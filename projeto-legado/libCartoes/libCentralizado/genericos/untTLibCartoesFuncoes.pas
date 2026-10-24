{***************===========ATEN«√O===========***************}
{* N√O ALTERE NENHUMA FUN«√O J¡ EXISTENTE NESSA CLASSE.    *}
{* PRINCIPALMENTE SE FOR COISA ESPEFÕFICA APENAS           *}
{* PARA UMA CONCILIA«√O.                                   *}
{* QUALQUER ALTERA«√O PARA APENAS UMA CONCILIA«√O          *}
{* VOC  DEVE ALTERAR A QUE EST¡ EM SEU PROJETO.            *}
{* POR EXEMPLO: O DA REDECARD, VOC  DEVE ALTERAR           *}
{* A UNTTREDECARDFUNCOES.                                  *}
{*                                                         *}
{* REFOR«ANDO: N√O ALTERE NADA DESSA UNIT.                 *}
{* OBS: SE FOR REALMENTE NECESS¡RIO, FALAR COM             *}
{*      A EQUIPE DO FINANCEIRO, QUEM ENTENDE DESSA         *}
{*      ROTINA.                                            *}
{********************************************************AJ*}

unit untTLibCartoesFuncoes;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, System.Math,
     Vcl.Forms, System.DateUtils, Vcl.StdCtrls, System.Variants,
     Vcl.Controls, Winapi.Windows, Winapi.Messages, Data.DB, System.RTTI,
     TypInfo, Vcl.Dialogs, System.UITypes, Vcl.Graphics,
     System.NetEncoding, Vcl.Themes, Vcl.Styles, Vcl.SysStyles, Winapi.Psapi,
     System.Json, System.Generics.Collections,

     Uni, UniClientDataset, cxProgressBar, EditFocus, maskEditFocus,
     IdHashMessageDigest, frxClass, BitBtnLockedIncrem,

     untILibCartoesFactory, untILibCartoesWrapper, untLibCartoesInterfacesTipos,
     untLibCartoesConstantes, Faturamento.Classes.CNPJ;

Type
  TLibCartoesFuncoes = class
    class var FLastProcessMessages: TDateTime;
    class var FExisteCampoLiberacaoTransferencia: Boolean;
    class var FCampoMER_NUMNSUExiste: String;
    class var FDadosImportacaoConfirmacao: TDadosImportacaoConfirmacao;

    class var FIconeAplicacao: TIcon;

    class var FNomeFornecedor: TDictionary<String, String>;
    class var FNomePortador: TDictionary<String, String>;
    class var FNomeCentroDeCustos: TDictionary<String, String>;
    class var FNomeEmpresa: TDictionary<String, String>;
    class var FNomeOperador: TDictionary<String, String>;

    class function fEmptyStr(strString: String): Boolean;
    class function fStrToFloat(strValorUnico: String): Double;
    class function IIF(ACondicao: Boolean;
                       AValorVerdadeiro,
                       AValorFalso: Variant): Variant;
    class function fStrZero(Zeros:string;Quant:integer):String;
    class function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    class function fRetStrToSQLIn(strValores: String; strDelimitador: String = '_'): String;
    class function fRetStrToSQLArr(strValores: String; strDelimitador: String = '_'): TArray<Variant>;
    class function fRetArrToSQLIn(arrValores: TConsultasArray; strCodigo: String): String;
    class function fRetSomenteNumeros(strTexto: String): String;
    class function fGetLetraAlfa(intCol: Integer): String;
    class function fGetPosLetraAlfa(strLetra: String): Integer;
    class function fFloatToInt(fltNumero: Double): Integer;
    class function fNow: TDateTime;
    class function fTime(const AForceTime: Boolean = False; ADataset: TUniQuery = Nil): TDateTime;
    class Procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
    class Procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
    class procedure pStepStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String=''; blnStep: Boolean = True);
    class function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    class function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    class function fRetEmpresaFisica: String;
    class function fFormataAutInc(intAutInc: Int64; strCodEmp: String; strProEmp: String = ''): String;
    class procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
    class function fValidaPeriodo(strDtaIni, strDtaFin: String): Boolean;
    class function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;
    class function fTiraCaracEspeciais(strTexto      : String;
                                       blnUsaLista   : Boolean = True;
                                       blnTiraEspacos: Boolean = False;
                                       blnTiraPontos : Boolean = False;
                                       blnTiraDoisPts: Boolean = False;
                                       blnTiraTab    : Boolean = False;
                                       blnTiraVirgula: Boolean = True;
                                       blnTiraAbreviacaoNumero: Boolean = False): String;
    class Function fValidaCnpjCpf(strCPFCNPJ: String; blnMostraMSG: Boolean=False):Boolean;
    class function fDatasetDistinctField(objDataSet: TDataSet; strFieldName: String): TStringList;
    class function fCriaDataSource(DataSet: TDataSet): TDataSource;
    class function fCriarQuery(strSQL: String; AManterAberta: Boolean = False; AOwner: TComponent = nil): TUniQuery;
    class procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
    class Procedure pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False);
    class function fRetornaValorConfiguracao(ACodigoConfiguracao: String;
                                             ACodigoEmpresa: String = ''): String;
    class function GetMD5(const strTexto: string): string;

    class function fEhAdministrador(strCodOpe: String): Boolean; inline;

    class function RetornaDataHoraServidor: TDateTime;
    class function RetornaHoraServidor: TTime;

    class function ConverterArrayConsultaParaStringList(const AArray: TConsultasArray): TStringList;

    class function RetornaNomeEmpresa(ACodEmp: String): String;
    class function RetornaNomePortador(ACodigoPortador: String): String;
    class function RetornaNomeCentroDeCustos(ACodigoEvento: String): String;
    class function RetornaNomeFornecedor(ACodigoFornecedor: String): String;
    class function RetornaNomeOperador(ACodigoOperador: String): String;
    class function RetornaNomeBandeira(ANumeroCartao: String;
                                       ATipoCartao: String = ''): String;
    class function RetiraZerosEsquerda(AString: String): String;

    class function CriarClientDataSet(ADataSet: TDataSet;
                                      blnVazio: Boolean = False;
                                      AOwner: TComponent = Nil;
                                      blnRegistroAtual: Boolean = False;
                                      arrAddFields: TArray<TField> = Nil;
                                      arrSizeFields: TArray<TRecSizeField> = Nil): TUniClientDataSet;

    class function fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double;
    class function fDataAggregate(cdsClient: TUniClientDataSet; strNomCam: String): TDateTime;
    class function fIntAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Integer;

    class function ExecutaSQL(AScriptExec: String): Boolean;
    class function fTabelaExiste(strNomTab: String): Boolean;

    class function fCfgSisEmp(strCodCfg, strValCfg: String; ALocateValor: Boolean = False): String;

    class function fEmpresasTemAcessoPortador(strCodPor: String;
                                              strCodEmps: TStringList;
                                              out strEmpSemAcesso: String): Boolean;
    class function fVerificaAcessoCartao(strCodCar: String): Boolean;

    class function fGetPlanoDeContas(strCodRes: String = '') : String;
    class function fPortadorPermiteBaixa(strCodPor: String): Boolean;
    class function fEmpresaTemAcessoPortador(strCodPor: String; strCodEmp: String = ''): Boolean;

    class function fValidaLinhaGrupoCadCta(strLinGru: String): Boolean;
    class function PlanoDeContasAtivo(ACodCta : String; AMsgAlerta: Boolean = True): Boolean;
    class function CentroDeCustosAtivo(ACodEve : String; AMsgAlerta: Boolean = True): Boolean;

    class procedure CarregaParametroDataset(Var ADataset: TUniQuery;
                                            ANomeParametro: String;
                                            AValorparametro: Variant;
                                            ATipoParametro: TFieldType = ftUnknown);

    class procedure SetaValorCampoDataset(var ADataset: TUniQuery;
                                          const ANomeCampo: String;
                                          AValorCampo: Variant;
                                          ASempredaVariavel: Boolean = False;
                                          AValorCampoNulo: String = '');

    class procedure pDesmarcaLista(edtCodigo: TCustomEdit; Var arrLinha: TConsultasArray; strTempTable: String = ''; intTamCamp: Integer = 0);
    class procedure pEdtCodSelectExit(edtCodigo       : TCustomEdit;
                                      edtDescri       : TEditFocus;
                                  Var arrLinha        : TConsultasArray;
                                      fncRetNome      : TfncRetNome;
                                      fncRetNomeConst : TfncRetNomeConst;
                                      strMsgErr       : String;
                                      intTamCamp      : integer = 0;
                                      blnNegar        : Boolean = False;
                                      strCodigo       : String = 'CÛdigo';
                                      blnFeminino     : Boolean = False;
                                      blnSuprimirMensagem : Boolean = False;
                                      fncRetNomeParam : tfncRetNomeParam = nil;
                                      arrAux          : TConsultasArray = nil;
                                      strCodAux       : String = '';
                                      strAutIncrem    : String = '');

    class function ffrmData(Var dtaData: TDateTime; strCaption, strCaptionLabel: String): Boolean;

    class function GravaTabelaDelecao(AFormulario,
                                      ATabela: String;
                                      ARegistroDeletado: TDataSet;
                                      AGravarTodoDataset: Boolean = False): Boolean;

    class function fFindCfg(var ADataset: TUniClientDataset;
                            ACodCfg: string;
                            AAdicionarConfigDuranteValidacao: Boolean;
                            AFiltroEmpresa: Boolean = True): Boolean;

    class function ExisteValorMultiplosEstabelecimentos(ACodigoValidar,
                                                        AValorConfiguracao: String;
                                                        ASeparador: String;
                                                        AIgnoraZerosAEsquerda: Boolean = True): Boolean;

    class function MetodoExiste(AInstancia: IInterface;
                                ANomeMetodo: string): Boolean;
    class function CampoExiste(ANomeTabela,
                               ANomeCampo: String): Boolean;
    class function RetornaValorCfg(ACodigoCfg: String;
                                   ACodigoEmpresa: String = '';
                                   AValorDefault: String = ''): String;

    class function AguardeExecutarModalA(const AGenericProcedure: TGenericProcedure;
                                         const ADescricaoTela,
                                         AChaveTela: string): Boolean;

    class function ExecutaAguarde(AFuncaoGravando: TFunctionFormGravando;
                                  AMensagem: String): Boolean;

    class procedure Inc64(var AValor: Int64; AIntervalo: Int64 = 1);

    class Function fMensagem(strTitulo: String;
                             strTexto: String;
                             arrOpcoes: Array Of String;
                             intFocoBotao: Integer = 1;
                             blnSaiComEsc: Boolean = False;
                             intEstFon: Integer = 1;
                             intWidBut: Integer = 0;
                             blnAutosize: Boolean = False;
                             intSomarTop: Integer=0;
                             blnObrigaEsc: Boolean = False;
                             blnOcultPainelBtn: Boolean = False;
                             blnBtnSemImg : Boolean = False;
                             intHeightOpc: Integer = 0;
                             intFormWidth : Integer = 0;
                             intQtdLinha: Integer = -1): Integer;

    class function RetornaTamandoDeCampoString(ANomeTabela,
                                               ANomeCampo: String;
                                               ATamanhoDefault: Integer = 0): Integer;

    class function fRemoveAcento(Str:String): String;

    class function IfNull(varValor, varDefault: Variant): Variant;

    class function RetornaChaveBasic(AClientID,
                                     AClientSecret: String): String;

    class procedure CarregaEstiloNovoCfgs;

    class procedure pSetaClient(cdsClient: TDataSet);

    class procedure CarregaCorZebra;

    class procedure FreeAndNilDatasets<T: TDataset>(var ADataset: T);

    class procedure FreeAndNilStringLists(var AStringList: TStringList);

    class function TryDirectoryExists(APath: string; ATimeoutSecs: Integer = 10): Boolean;

    class procedure FreeAndNilObjeto(var AObjeto);

    class function ClonarObjeto<T: Class>(ASource: T; AIgnorarFields: String = '|'): T;

    class procedure DestroiDicionariosCache;

    class procedure pProcessMessages(ANow: Boolean = False);

    class function EstaEmTransacao: Boolean;

    class function CampoMER_NUMNSUExiste: Boolean;

    class function RetornaTimeStampEmMilisegundos: Int64;

    {$IFNDEF LINUX}
    class function PegaTimeZone: Integer;
    {$ENDIF}
  private
    class function fArredondaABNT_NBR5891_77(fltValor: Double;
                                             intDecimais: TRoundToRange;
                                             const Delta: Double  = 0.00001 ): Double;

    class function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;

    class function fSimpleRoundToEX(const AValue: Extended; const ADigit: TRoundToRange = -2): Extended;

    class function fValidaCnpjCpfDigIgual(strOpcao, strValor: String; blnMostraMSG: Boolean=True): Boolean;
    class function fValidaCPF(sCPF: string):Boolean;
    class function fTestaCgc(xCGC: String):Boolean;

    class procedure pCloneData(const objDestino, objOrigem: TUniClientDataSet);

    class procedure GeraListaDeCamposTabelaDelecao(Var ACamposTabelaDelecao,
                                                   AParametrosTabelaDelecao: String;
                                                   ATabela: String);

    class function fExisteConfiguracao(ACodigoCfg, ACodigoEmpresa: String): Boolean;

    class procedure pAddConfigDataSet(Var ADataset: TUniClientDataset;
                                      ACodigoCfg,
                                      ACodigoEmpresa: string);
  End;

  Var
    VS_FuncoesExternas: ILibCartoes;

    VS_CFG_USASAT,
    VS_CFG_RAABNT: String;

implementation
Uses untLibCartoesHorarioSistema, untLibCartoesDigData, untLibCartoesGravando,
     untLibCartoesGravandoOld, untLibCartoesMensagem;
{ TLibCartoesFuncoes }

class function TLibCartoesFuncoes.AguardeExecutarModalA(
  const AGenericProcedure: TGenericProcedure; const ADescricaoTela,
  AChaveTela: string): Boolean;
begin
  If VS_FuncoesExternas.fITelaGravandoAntiga Then
    Result := TfrmGravandoOld.fExecutarModalA(AGenericProcedure, ADescricaoTela, AChaveTela)
  Else
    Result := TfrmGravando.fExecutarModalA(AGenericProcedure, ADescricaoTela, AChaveTela);
end;

class function TLibCartoesFuncoes.CampoExiste(ANomeTabela,
  ANomeCampo: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT * FROM ' + ANomeTabela + ' WHERE FALSE';
    LConsulta.Open;

    Result := LConsulta.FindField(ANomeCampo) <> Nil;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

class function TLibCartoesFuncoes.CampoMER_NUMNSUExiste: Boolean;
begin
  If FCampoMER_NUMNSUExiste.IsEmpty Then
    FCampoMER_NUMNSUExiste := IIF(CampoExiste('MER_MLPGTO', 'MER_NUMNSU'), 'S', 'N');

  If FCampoMER_NUMNSUExiste.Equals('N') Then
    Exit(False);

  Result := True;
end;

class procedure TLibCartoesFuncoes.CarregaCorZebra;
begin
  Try
    untLibCartoesConstantes.COR_ZEBRA := StrToInt(fRetornaValorConfiguracao('CFG_CORZEB', VS_FuncoesExternas.fIRetEmpresaLogada));
  Except
    untLibCartoesConstantes.COR_ZEBRA := clWhite;
  End;
end;

class procedure TLibCartoesFuncoes.CarregaEstiloNovoCfgs;
begin
  Try
    TStyleManager.TrySetStyle(AUTCOM_STYLE_NAME);
    TStyleManager.SystemHooks  := TStyleManager.SystemHooks - [shDialogs];

    TCustomStyleEngine.UnRegisterSysStyleHook('#32768', TSysPopupStyleHook);

    TCustomStyleEngine.UnRegisterSysStyleHook('#32770', TSysDialogStyleHook);

    TCustomStyleEngine.UnRegisterSysStyleHook('ScrollBar', TSysScrollBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Button', TSysButtonStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Edit', TSysEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('ComboBox', TSysComboBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Label', TSysComboBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('ListBox', TSysListBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('ComboLBox', TSysListBoxStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Static', TSysStaticStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('Shape', TSysStaticStyleHook);

    TCustomStyleEngine.UnRegisterSysStyleHook('ToolbarWindow32', TSysToolbarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('SysListView32', TSysListViewStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('SysTabControl32', TSysTabControlStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('SysTreeView32', TSysTreeViewStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_progress32', TSysProgressBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50A', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50W', TSysRichEditStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('RebarWindow32', TSysReBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_statusbar32', TSysStatusBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_trackbar32', TSysTrackBarStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('msctls_updown32', TSysUpDownStyleHook);
    TCustomStyleEngine.UnRegisterSysStyleHook('tooltips_class32', TSysTooltipsStyleHook);
  Except
  End;
end;

class procedure TLibCartoesFuncoes.CarregaParametroDataset(
  var ADataset: TUniQuery;
  ANomeParametro: String;
  AValorParametro: Variant;
  ATipoParametro: TFieldType = ftUnknown);
begin
  If Not Assigned(ADataset) Then
    Exit;

  If ADataset.Params.FindParam(ANomeParametro) = Nil Then
    Exit;

  Try

    Case ATipoParametro Of
      ftDate:
        ADataset.ParamByName(ANomeParametro).AsDate :=
          VarToDateTime(AValorParametro);
    Else
      ADataset.ParamByName(ANomeParametro).Value := AValorParametro;
    End;

  Except
    On E: Exception Do
      Raise E;
  End;
end;

class function TLibCartoesFuncoes.CentroDeCustosAtivo(ACodEve: String;
  AMsgAlerta: Boolean): Boolean;
  Var
    LQryAux : TUniQuery;
    LSQL    : String;
begin
  If fEmptyStr(ACodEve) Then
    Exit(True);

  LQryAux := Nil;
  Try
    LQryAux := VS_FuncoesExternas.fICriaQuery;

    Result := False;

    LSQL := '';
    LSQL := LSQL + 'SELECT EVE_SITUAC            ';
    LSQL := LSQL + 'FROM CADEVE                  ';
    LSQL := LSQL + 'WHERE EVE_CODEVE = :CODEVE   ';

    Try
      LQryAux.Close;
      LQryAux.SQL.Clear;
      LQryAux.SQL.Add(LSQL);
      LQryAux.ParamByName('CODEVE').AsString := ACodEve;
      LQryAux.Open;
      Result := LQryAux.FieldByName('EVE_SITUAC').AsString <> 'I';

      If Not Result And AMsgAlerta Then
      Begin
        fMensagem('ATEN«√O!', 'O Centro de Custos est· Inativo!', ['&Ok']);
      End

    Except
      On E : Exception Do
      Begin
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[untFuncoesSimples.CentroDeCustosAtivo]');
      End;
    End;
  Finally
    FreeAndNilDatasets(LQryAux);
  End;
end;

class function TLibCartoesFuncoes.ClonarObjeto<T>(ASource: T; AIgnorarFields: String = '|'): T;
  Var
    LContext: TRttiContext;

    LRttiType: TRttiInstanceType;

    LField: TRttiField;

    LMethod: TRttiMethod;

    LConstructor: TRttiMethod;
begin
  If Not Assigned(ASource) then
    Exit(Nil);

  LContext := TRttiContext.Create;
  LRttiType := LContext.GetType(ASource.ClassType) As TRttiInstanceType;

  LConstructor := Nil;
  For LMethod In LRttiType.GetMethods do
  Begin
    If LMethod.IsConstructor And (Length(LMethod.GetParameters) = 0) Then
    Begin
      LConstructor := LMethod;
      Break;
    End;
  End;

  If Assigned(LConstructor) Then
    Result := LConstructor.Invoke(LRttiType.MetaclassType, []).AsType<T>
  Else
    Result := T(LRttiType.MetaclassType.Create);

  Try
    For LField In LRttiType.GetFields Do
    Begin
      If AIgnorarFields.Contains(LField.Name + '|') Then
        Continue;

      LField.SetValue(Pointer(Result), LField.GetValue(Pointer(ASource)));
    End;
  Except
    FreeAndNil(Result);

    Raise;
  End;
end;

class function TLibCartoesFuncoes.ConverterArrayConsultaParaStringList(
  const AArray: TConsultasArray): TStringList;
    Var
      LItem: TConsultas;
begin
  Result := TStringList.Create;

  If Length(AArray) = 0 Then
    Exit;

  For LItem In AArray Do
    Result.Add(LItem.strCodigo);
end;

class function TLibCartoesFuncoes.CriarClientDataSet(ADataSet: TDataSet; blnVazio: Boolean = False;
  AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False;
  arrAddFields: TArray<TField> = Nil; arrSizeFields: TArray<TRecSizeField> = Nil): TUniClientDataSet;
  Var
    intCont  : Integer;
    intIdx_  : Integer;
    intSize  : Integer;
    intRecno : Integer;
begin
  Result := TUniClientDataSet.Create(AOwner);

  For intCont := 0 To ADataSet.Fields.Count -1 Do
  Begin
    intSize := ADataSet.Fields[intCont].Size;

    If Assigned(arrSizeFields) Then
    Begin
      For intIdx_ := 0 To Length(arrSizeFields) -1 Do
      Begin
        If (ADataSet.Fields[intCont].FieldName = arrSizeFields[intIdx_].Name) Then
          intSize := arrSizeFields[intIdx_].Size
      End;
    End;

    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := ADataSet.Fields[intCont].FieldName;
      DataType := ADataSet.Fields[intCont].DataType;
      Size     := intSize;
      Required := False;
    End;
  End;

  For intCont := 0 To Length(arrAddFields) -1 Do
    Result.FieldDefs.Add(arrAddFields[intCont].FieldName,
                         arrAddFields[intCont].DataType,
                         arrAddFields[intCont].Size,
                         False);

  Result.CreateDataSet;
  Result.Open;

  Result.LogChanges := False;

  If blnVazio Then
    Exit;

  intRecno := ADataSet.RecNo;
  ADataSet.DisableControls;

  Try
    If Not blnRegistroAtual Then
      ADataSet.First;

    While (Not ADataSet.Eof) Or blnRegistroAtual Do
    Begin
      Result.Append;

      For intCont := 0 To ADataSet.Fields.Count -1 Do
        Result.Fields[intCont].Value := ADataSet.Fields[intCont].Value;

      Result.Post;

      If blnRegistroAtual Then
        Break;

      ADataSet.Next;
    End;
  Finally
    ADataSet.RecNo := intRecno;
    ADataSet.EnableControls;
  End;
end;

class procedure TLibCartoesFuncoes.DestroiDicionariosCache;
begin
  If Assigned(FNomeFornecedor) Then
    FreeAndNil(FNomeFornecedor);

  If Assigned(FNomePortador) Then
    FreeAndNil(FNomePortador);

  If Assigned(FNomeCentroDeCustos) Then
    FreeAndNil(FNomeCentroDeCustos);

  If Assigned(FNomeEmpresa) Then
    FreeAndNil(FNomeEmpresa);

  If Assigned(FNomeOperador) Then
    FreeAndNil(FNomeOperador);
end;

class function TLibCartoesFuncoes.EstaEmTransacao: Boolean;
  Var
    LDataset: TUniQuery;
begin
  LDataset := Nil;
  Try
    LDataset := VS_FuncoesExternas.fICriaQuery;
    Result := LDataset.Connection.InTransaction;
  Finally
    FreeAndNilDatasets(LDataset);
  End;
end;

class function TLibCartoesFuncoes.ExecutaAguarde(
  AFuncaoGravando: TFunctionFormGravando; AMensagem: String): Boolean;
  Var
    LFormGravandoOld: TfrmGravandoOld;

    LFormGravando: TfrmGravando;
Begin
  If VS_FuncoesExternas.fITelaGravandoAntiga Then
  Begin
    Try
      pCriarFormularios(TfrmGravandoOld, LFormGravandoOld);
      LFormGravandoOld.fExecutarAcao := AFuncaoGravando;
      LFormGravandoOld.lblGravando.Caption := AMensagem;
      LFormGravandoOld.pgbStatus.Visible := True;
      LFormGravandoOld.ShowModal;

      Exit(LFormGravandoOld.blnConfirma);
    Finally
      FreeAndNil(LFormGravandoOld);
      VS_FuncoesExternas.pITrimAppMemorySize;
    End;
  End;

  Try
    pCriarFormularios(TfrmGravando, LFormGravando);
    LFormGravando.fExecutarAcao := AFuncaoGravando;
    LFormGravando.lblGravando.Caption := AMensagem;
    LFormGravando.pgbStatus.Visible := True;
    LFormGravando.ShowModal;

    Result := LFormGravando.blnConfirma;
  Finally
    FreeAndNil(LFormGravando);
    VS_FuncoesExternas.pITrimAppMemorySize;
  End;
end;

class function TLibCartoesFuncoes.ExecutaSQL(AScriptExec: String): Boolean;
  Var
    LExecutar: TUniQuery;
Begin
  LExecutar := Nil;
  Try
    LExecutar := VS_FuncoesExternas.fICriaQuery;
    LExecutar.SQL.Text := AScriptExec;
    LExecutar.ExecSQL;

    Result := LExecutar.RowsAffected > 0;
  Finally
    FreeAndNilDatasets(LExecutar);
  End;
End;

class function TLibCartoesFuncoes.ExisteValorMultiplosEstabelecimentos(
  ACodigoValidar, AValorConfiguracao, ASeparador: String;
  AIgnoraZerosAEsquerda: Boolean = True): Boolean;
  Var
    LValor: String;
begin
  Result := False;

  If fEmptyStr(AValorConfiguracao) Then
    Exit;

  If fEmptyStr(ACodigoValidar) Then
    Exit;

  If ASeparador.Trim.IsEmpty Then
    Exit;

  For LValor In AValorConfiguracao.Split([ASeparador]) Do
  Begin
    If AIgnoraZerosAEsquerda Then
    Begin
      If fEmptyStr(RetiraZerosEsquerda(LValor)) Then
        Continue;

      If RetiraZerosEsquerda(LValor).Equals(RetiraZerosEsquerda(ACodigoValidar)) Then
        Exit(True);
    End
    Else
    Begin
      If fEmptyStr(LValor) Then
        Continue;

      If LValor.Equals(ACodigoValidar) Then
        Exit(True);
    End;
  End;
end;

class function TLibCartoesFuncoes.fArredondaABNT_NBR5891_77(fltValor: Double;
  intDecimais: TRoundToRange; const Delta: Double): Double;
  var
     extPow, extUltimosNumeros, extValorPow : Extended;
     fltParteRestante: Double;
     intCalc, intFracCalc, intUltimoNumero, intValor : Int64;
     blnNegativo: Boolean;
Begin
   blnNegativo  := (fltValor < 0);

   extPow       := intpower(10, abs(intDecimais) );
   extValorPow  := abs(fltValor) / 10 ;
   intValor  := trunc(extValorPow);
   extUltimosNumeros := frac(extValorPow);

   extValorPow := fSimpleRoundToEX( extUltimosNumeros * 10 * extPow, -9) ; // SimpleRoundTo elimina dizimas ;
   IntCalc  := trunc( extValorPow );
   intFracCalc := trunc( frac( extValorPow ) * 100 );

   if (intFracCalc > 50) then
     Inc( IntCalc )

   else if (intFracCalc = 50) then
   begin
     intUltimoNumero := round( frac( IntCalc / 10) * 10);

     if odd(intUltimoNumero) then
       Inc( IntCalc )
     else
     begin
       fltParteRestante := frac( extValorPow * 10 ) ;

       if fltParteRestante > Delta then
         Inc( IntCalc );
     end ;
   end ;

   Result := ((intValor*10) + (IntCalc / extPow));

   if blnNegativo then
     Result := -Result;
end;

class function TLibCartoesFuncoes.fBetween(fltValor, fltMinimo,
  fltMaximo: Double): Boolean;
begin
  Result := (fltValor >= fltMinimo) And
            (fltValor <= fltMaximo);
end;

class function TLibCartoesFuncoes.fCfgSisEmp(strCodCfg, strValCfg: String;
  ALocateValor: Boolean): String;
  Var
    strSQL   : String;
    qryGenCfg: TUniQuery;
Begin
  Result := EmptyStr;

  qryGenCfg := Nil;
  Try
    qryGenCfg := VS_FuncoesExternas.fICriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT  SQL_NO_CACHE       ';
    strSQL := strSQL + '   SIS_CODEMP               ';
    strSQL := strSQL + ' FROM                       ';
    strSQL := strSQL + '   CFGSIS                   ';
    strSQL := strSQL + ' WHERE                      ';
    strSQL := strSQL + '   SIS_CODCFG = :CODCFG AND ';

    If Not ALocateValor Then
      strSQL := strSQL + '   SIS_VALCFG = :VALCFG   '
    Else
      strSQL := strSQL + '   LOCATE(:VALCFG, SIS_VALCFG) > 0 ';

    qryGenCfg.SQL.Text := strSQL;

    qryGenCfg.ParamByName('VALCFG').Value := strValCfg;
    qryGenCfg.ParamByName('CODCFG').Value := 'CFG_' + strCodCfg;
    qryGenCfg.Open;

    If Not qryGenCfg.IsEmpty Then
    Begin
      While Not qryGenCfg.Eof Do
      Begin
        Result := Result + qryGenCfg.FieldByName('SIS_CODEMP').AsString + '_';

        qryGenCfg.Next;
      End;
    End;
  Finally
    FreeAndNilDatasets(qryGenCfg);
  End;
end;

class function TLibCartoesFuncoes.fCriaDataSource(
  DataSet: TDataSet): TDataSource;
begin
  Result := TDataSource.Create(DataSEt);
  Result.DataSet := DataSet;
end;

class function TLibCartoesFuncoes.fCriarQuery(strSQL: String;
  AManterAberta: Boolean; AOwner: TComponent): TUniQuery;
  //Var
  //  intCont: Integer;
begin
  Result := VS_FuncoesExternas.fICriaQuery;
  Result.SQL.Text := strSQL;
  Result.Open;

  If AManterAberta Then
    Exit;

  Result.Close;

  //For intCont := 0 To Result.FieldDefs.Count - 1 Do
  //Begin
  //  Result.FieldDefs[intCont].CreateField(Result);
  //End;
end;

class function TLibCartoesFuncoes.fDataAggregate(cdsClient: TUniClientDataSet;
  strNomCam: String): TDateTime;
begin
  If TAggregateField(cdsClient.FieldByName(strNomCam)).Value = Null Then
    Exit(0);

  Result := TAggregateField(cdsClient.FieldByName(strNomCam)).Value;
end;

class function TLibCartoesFuncoes.fDatasetDistinctField(objDataSet: TDataSet;
  strFieldName: String): TStringList;
  Var
    intPosicao: Integer;
    tmpAfterScroll: TDataSetNotifyEvent;
begin
  Result := TStringList.Create;
  Result.Sorted := True; //melhora o desempenho no IndexOf

  intPosicao     := objDataSet.RecNo;
  tmpAfterScroll := objDataSet.AfterScroll;
  objDataSet.AfterScroll    := Nil;
  objDataSet.DisableControls;
  Try
    objDataSet.First;
    While Not objDataSet.Eof Do
    Begin
      If Result.IndexOf(objDataSet.FieldByName(strFieldName).AsString) = -1 Then
        Result.Add(objDataSet.FieldByName(strFieldName).AsString);
      objDataSet.Next;
    End;
  Finally
    objDataSet.RecNo       := intPosicao;
    objDataSet.AfterScroll := tmpAfterScroll;
    objDataSet.EnableControls;
  End;
end;

class function TLibCartoesFuncoes.fDoubleAggregate(cdsClient: TUniClientDataSet;
  strNomCam: String): Double;
begin
  If TAggregateField(cdsClient.FieldByName(strNomCam)).Value = Null Then
    Exit(0);

  Result := TAggregateField(cdsClient.FieldByName(strNomCam)).Value;
end;

class function TLibCartoesFuncoes.fEhAdministrador(strCodOpe: String): Boolean;
begin
  Result := MatchStr(strCodOpe, ['997', '998', '999']);
end;

class function TLibCartoesFuncoes.fEmpresasTemAcessoPortador(strCodPor: String;
  strCodEmps: TStringList; out strEmpSemAcesso: String): Boolean;
  Var
    strSql, strCodEmp: String;
    qryTmp: TUniQuery;
begin
  strEmpSemAcesso := '';

  If strCodPor.IsEmpty Then
    Exit(fEmptyStr(strEmpSemAcesso));

  qryTmp := Nil;
  Try
    qryTmp := VS_FuncoesExternas.fICriaQuery;
    strSql := '';
    strSql := strSql + ' SELECT POR_EMPACE ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   CADPOR ';
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   POR_CODPOR = :CODIGO ';

    With qryTmp Do
    Begin
      SQL.Add(strSql);
      ParamByName('CODIGO').AsString := strCodPor;
      Open;

      If Not fEmptyStr(FieldByName('POR_EMPACE').AsString) Then
      Begin
        For strCodEmp In strCodEmps Do
        Begin
          If Pos(strCodEmp, FieldByName('POR_EMPACE').AsString) = 0 Then
            strEmpSemAcesso := strEmpSemAcesso + strCodEmp + ',';
        End;
      End;

      Result := fEmptyStr(strEmpSemAcesso);

      If Not Result Then
        strEmpSemAcesso := LeftStr(strEmpSemAcesso, Length(strEmpSemAcesso) -1);

      Close;
    End;
  Finally
    FreeAndNilDatasets(qryTmp);
  End;
end;

class function TLibCartoesFuncoes.fEmpresaTemAcessoPortador(strCodPor,
  strCodEmp: String): Boolean;
   Var
    strSql: String;
    qryTmp: TUniQuery;
begin
  Result := True;

  If strCodPor.IsEmpty Then
    Exit;

  qryTmp := Nil;
  Try
    qryTmp := VS_FuncoesExternas.fICriaQuery;
    strSql := '';
    strSql := strSql + ' SELECT POR_EMPACE ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   CADPOR ';
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   POR_CODPOR = :CODIGO ';

    qryTmp.SQL.Add(strSql);
    qryTmp.ParamByName('CODIGO').AsString := strCodPor;
    qryTmp.Open;

    If Not fEmptyStr(qryTmp.FieldByName('POR_EMPACE').AsString) Then
    Begin
      If fEmptyStr(strCodEmp) Then
        strCodEmp := VS_FuncoesExternas.fIRetEmpresaLogada;

      Result := Pos(strCodEmp, qryTmp.FieldByName('POR_EMPACE').AsString) > 0;
    End;

    qryTmp.Close;
  Finally
    FreeAndNilDatasets(qryTmp);
  End;
end;

class function TLibCartoesFuncoes.fEmptyStr(strString: String): Boolean;
begin
  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');

  Result := AnsiReplaceText(strString, ' ', '') = '';
end;

class function TLibCartoesFuncoes.fExisteConfiguracao(ACodigoCfg,
  ACodigoEmpresa: String): Boolean;
  Var
    strSQL: String;
    qryCfg: TUniQuery;
begin
  qryCfg := Nil;
  Try
    qryCfg := VS_FuncoesExternas.fICriaQuery;
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SIS_CODCFG        ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  CFGSIS  ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  SIS_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  SIS_CODEMP = :CODEMP     ';

    qryCfg.SQL.Text := strSQL;
    qryCfg.ParamByName('CODCFG').AsString := IIF(ACodigoCfg.StartsWith('CFG_'), ACodigoCfg, 'CFG_' + ACodigoCfg);
    qryCfg.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryCfg.Open;
    Result := Not qryCfg.IsEmpty;
  Finally
    FreeAndNilDatasets(qryCfg);
  End;
end;

class function TLibCartoesFuncoes.fFormataAutInc(intAutInc: Int64; strCodEmp,
  strProEmp: String): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + fPadL(IntToStr(intAutInc) + strCodEmp, 17, '0');
end;

class function TLibCartoesFuncoes.fFormataFloat(fltNumero: Double;
  intDecimais: Integer): Double;
begin
  If VS_CFG_USASAT.IsEmpty Then
  Begin
    VS_CFG_USASAT := RetornaValorCfg('CFG_USASAT', EmptyStr, 'N');
    VS_CFG_RAABNT := RetornaValorCfg('CFG_RAABNT', EmptyStr, 'N');
  End;
  //Se usa SAT entao sempre usa regras de arredondamento ABNT NBR 5891/77
  If Concat(VS_CFG_USASAT, VS_CFG_RAABNT).Contains('S') Then
    Exit(fArredondaABNT_NBR5891_77(fltNumero, intDecimais));

  Result := fFormataFloatInterna(fltNumero, intDecimais);
end;

class function TLibCartoesFuncoes.fFormataFloatInterna(fltNumero: Double;
  intDecimais: Integer): Double;
  Var
    intDig: Integer;
    strVal: String;
begin
  strVal := FloatToStr(fltNumero);

  {*******************************}
  {* SE O VALOR POSSUIR DECIMAIS *}
  {****************************JC*}
  If Pos(FormatSettings.DecimalSeparator, strVal) > 0 Then
  Begin
    intDig := Length(strVal) - Pos(FormatSettings.DecimalSeparator, strVal);

    {*********************************************************************************}
    {* SUBSTITUI O ULTIMO DIGITO DE "5" PARA "6" FORCANDO O ARREDONDAMENTO PARA CIMA *}
    {******************************************************************************JC*}
    If (intDig > 0) And (intDig > intDecimais) And (strVal[Length(strVal)] = '5') Then
    Begin
      strVal[Length(strVal)] := '6';
    End;
  End;

  {************************************************************}
  {* CONTINUA FORMATANDO IGUAL ERA COM A FUNCAO fFormataFloat *}
  {*********************************************************JC*}
  Result := fStrToFloat(FloatToStrF(fStrToFloat(strVal), ffFixed, 12, intDecimais));
end;

class function TLibCartoesFuncoes.ffrmData(var dtaData: TDateTime; strCaption,
  strCaptionLabel: String): Boolean;
  Var
    frmLibCartoesDigData : TfrmLibCartoesDigData;
begin

  If dtaData = 0 Then
    dtaData := VS_FuncoesExternas.fIGetVS_Date;

  Try
    Try
      pCriarFormularios(TfrmLibCartoesDigData, frmLibCartoesDigData);
      frmLibCartoesDigData.Caption         := strCaption;
      frmLibCartoesDigData.lblData.Caption := strCaptionLabel;

      Try
        frmLibCartoesDigData.dtmData.Date    := dtaData;
      Except
        frmLibCartoesDigData.dtmData.Date    := VS_FuncoesExternas.fIGetVS_Date;
      End;

      Result := (frmLibCartoesDigData.ShowModal = mrOk);

      If Result Then
        dtaData := frmLibCartoesDigData.dtmData.Date;

    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[ffrmData]');
      End;
    End;
  Finally
    FreeAndNil(frmLibCartoesDigData);
    VS_FuncoesExternas.pITrimAppMemorySize;
  End;
end;

class function TLibCartoesFuncoes.fGetLetraAlfa(intCol: Integer): String;
  Var
    strLetra : String;
    intLetra1: Integer;
    intLetra2: Integer;
    fltValor : Double;
begin
  strLetra := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  If intCol > 26 Then
  Begin
    fltValor  := (intCol / 26);
    intLetra1 := fFloatToInt(fltValor - Frac(fltValor));
    intLetra2 := fFloatToInt(intcol Mod 26);

    If intLetra2 = 0 Then
    Begin
      Dec(intLetra1);
      intLetra2 := 26;
    End;

    Result    := strLetra[intLetra1] + strLetra[intLetra2];
  End
  Else
    Result   := strLetra[intCol];
end;

class function TLibCartoesFuncoes.fGetPlanoDeContas(strCodRes: String): String;
begin
  If (Length(Trim(strCodRes)) < 7) Then
  begin
    strCodRes := fStrZero(Trim(strCodRes),5);
    Result := VS_FuncoesExternas.fICampoTabela('CTA_CODCTA', 'CADCTA', ['CTA_CODRES'], [strCodRes], False);
  End;
  Result := IIF(fEmptyStr(Result),strCodRes,Result);
end;

class function TLibCartoesFuncoes.fGetPosLetraAlfa(strLetra: String): Integer;
  Const
    ALFA: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
begin
  Result := Pos(strLetra, ALFA);
end;

class function TLibCartoesFuncoes.fIntAggregate(cdsClient: TUniClientDataSet;
  strNomCam: String): Integer;
begin
  If TAggregateField(cdsClient.FieldByName(strNomCam)).Value = Null Then
    Exit(0);

  Result := TAggregateField(cdsClient.FieldByName(strNomCam)).Value;
end;

class function TLibCartoesFuncoes.fMensagem(strTitulo, strTexto: String;
  arrOpcoes: array of String; intFocoBotao: Integer; blnSaiComEsc: Boolean;
  intEstFon, intWidBut: Integer; blnAutosize: Boolean; intSomarTop: Integer;
  blnObrigaEsc, blnOcultPainelBtn, blnBtnSemImg: Boolean; intHeightOpc,
  intFormWidth, intQtdLinha: Integer): Integer;
  Var
    intQtdOpcoes : Integer;
    intPosicao   : Integer;
    fntFonte     : TFont;
    frmMsg       : TfrmMensagem;
    aHandle      : THandle;
    wrdTexto     : Word;
    BtnHeight    : Integer;
begin
  BtnHeight      := 28;
  intQtdOpcoes   := 0;

  fntFonte       := TFont.Create;
  fntFonte.Name  := 'charter';
  fntFonte.Size  := 13;

  For intPosicao := 0 To Length( arrOpcoes )-1 Do
  Begin
    If arrOpcoes[intPosicao] <> '' Then
      Inc(intQtdOpcoes)
    Else
      Break;
  End;

  If (Length(arrOpcoes) = 2)   And
     (Trim(arrOpcoes[0]) = '') And
     (Trim(arrOpcoes[1]) = '') Then
  Begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&N„o';
    intQtdOpcoes := 2;
  End;

  If Trim(arrOpcoes[0]) = '' Then
  Begin
    MessageDlg('… obrigatÛrio a passagem dos parametros em ordem!', mtInformation, [mbOK], 0);
    Result := 0;
    Exit;
  End;

  {********************************}
  {* -> Define Foco para Botao    *}
  {*****************************WI*}
  If ( intFocoBotao <= 0 )           Or
     ( intFocoBotao > intQtdOpcoes ) Then
    intFocoBotao := 1;

  If Not VS_ExibirMensagemAoUsuario Then
  Begin
    If Assigned(VS_OnMensagemAoUsuario) Then
      VS_OnMensagemAoUsuario(strTexto + ' [ ' + arrOpcoes[intFocoBotao-1].Replace('&','') + ' ] ');

    aHandle := FindWindow('TfrmAutcomSvc', Nil);
    If aHandle > 0 Then
    Begin
      wrdTexto := GlobalAddAtom(Pchar(strTexto));
      SendMessage(aHandle,CM_AVISOS,0,wrdTexto);
      GlobalDeleteAtom(wrdTexto);
    End;

    Result := intFocoBotao;
    Exit;
  End;

  Try
    Try
      pCriarFormularios(TfrmMensagem, frmMsg);

      If VS_ExibirMensagemStayOnTop Then
        frmMsg.FormStyle := fsStayOnTop;

      frmMsg.intSomaTop := intSomarTop;
      If (blnAutosize) Then
        frmMsg.WindowState := wsMaximized;

      If intHeightOpc <> 0 Then
        frmMsg.Height := intHeightOpc;

      If strTitulo = '' Then
        strTitulo := 'AVISO';

      If intEstFon = 2 Then
        frmMsg.lblMensagem.Font.Name := 'Courier New';

      frmMsg.lblTitulo.Caption   := strTitulo;
      frmMsg.lblMensagem.Caption := strTexto;

      If intQtdLinha > 0 Then
        frmMsg.Height := frmMsg.Height + (frmMsg.lblMensagem.Canvas.TextHeight('X') * intQtdLinha);

      if intFormWidth > 0 Then
        frmMsg.Width := intFormWidth;

      If intQtdOpcoes = 1 Then
      Begin
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := frmMsg.pnlBotoes;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 126
          Else
            Width      := intWidBut;

          If blnAutosize Then
          Begin
            Left  := (Screen.Width - 126) Div 2
          End Else
          Begin
            If intWidBut <> 0 Then
              Left       := 156 - ((intWidBut - 156) Div 2)
            Else
              If Length(arrOpcoes) = 1 Then
                Left       := (frmMsg.Width - Width) Div 2
              Else
                Left       := 156;
          End;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := frmMsg.imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 2 Then
      Begin
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := frmMsg.pnlBotoes;

          If blnAutosize Then
          Begin
            Left  := ((Screen.Width - 2*130) Div 2);
          End Else
          Begin
            If intWidBut <> 0 Then
              Left       := ((frmMsg.Width - (intWidBut*2)) Div 2)
            Else
              Left       := 90;
          End;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := frmMsg.imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := frmMsg.pnlBotoes;

          If blnAutosize Then
          Begin

            Left  := ((Screen.Width - 2*126) Div 2) + 126 + 7;

          End Else
          Begin

            If intWidBut <> 0 Then
              Left := ((frmMsg.Width - (intWidBut*2) ) Div 2) + intWidBut + 1
            Else
            Left       := 222;
          End;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := frmMsg.imgbotao2.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 3 Then
      Begin

        if intFormWidth = 0 Then
        frmMsg.Width := 494;

        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := frmMsg.pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*3) ) Div 3)
          Else
          Left       := 18;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 146
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := frmMsg.imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := frmMsg.pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*3) ) Div 3) + intWidBut + 1
          Else
          Left       := 166;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 146
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := frmMsg.imgbotao2.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := frmMsg.pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*3) ) Div 3) + (intWidBut * 2) + 1
          Else
          Left       := 314;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 146
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[2];
          Tag        := 3;
          If not blnBtnSemImg Then
            Glyph      := frmMsg.imgbotao3.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 4 Then
      Begin
        if intFormWidth = 0 Then
          frmMsg.Width := 494;

        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := frmMsg.pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*4) ) Div 4)
          Else
          Left       := 10;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 110
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := frmMsg.imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := frmMsg.pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*4) ) Div 4) + intWidBut + 1
          Else
          Left       := 125;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 110
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := frmMsg.imgbotao2.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := frmMsg.pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*4) ) Div 4) + (intWidBut * 2) + 1
          Else
          Left       := 240;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 110
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[2];
          Tag        := 3;
          If not blnBtnSemImg Then
            Glyph      := frmMsg.imgbotao3.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := frmMsg.pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*4) ) Div 4) + (intWidBut * 3) + 1
          Else
          Left       := 355;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 110
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[3];
          Tag        := 4;
          If not blnBtnSemImg Then
            Glyph      := frmMsg.imgbotao4.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End;

      frmMsg.intFocus     := intFocoBotao;
      frmMsg.blnSaiComEsc := blnSaiComEsc;
      frmMsg.blnObrigaEsc := blnObrigaEsc;
      frmMsg.blnOcultPainelBtn := blnOcultPainelBtn;

      Try
        {$IFDEF TESTABILIDADE_AUTCOM}
        TTestabilidade.fGetTestabilidade.SetConteudoMensagem(strTexto);
        {$ENDIF}
      Except
        //
      End;

      frmMsg.ShowModal;
      Result := frmMsg.intRetorno;

      Try
       {$IFDEF TESTABILIDADE_AUTCOM}
        TTestabilidade.fGetTestabilidade.SetConteudoMensagem('');
        {$ENDIF}
      Except
        //
      End;

    Except
      On E: Exception Do
      Begin
        Result := 0;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[fMensagem]');
      End;
    End;
  Finally
    FreeAndNil(frmMsg);
    FreeAndNil(fntFonte);
    VS_FuncoesExternas.pITrimAppMemorySize;
  End;
end;

class function TLibCartoesFuncoes.fNow: TDateTime;
begin
  Result := IfThen(Trunc(VS_FuncoesExternas.fIGetVS_Date) = 0, nOw(), VS_FuncoesExternas.fIGetVS_Date + fTime());
end;

class function TLibCartoesFuncoes.fPadL(strTexto: String; intTamanho: Integer;
  strCaracter: String): String;
  Var
    intContador: Integer;
begin
  Result := strTexto;

  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto, (Length(strTexto) + 1) - intTamanho, intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;
end;

class function TLibCartoesFuncoes.fPadR(strTexto: String; intTamanho: Integer;
  strCaracter: String): String;
  Var
    intContador: Integer;
begin
  Result := strTexto;

  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;
end;

class function TLibCartoesFuncoes.fPortadorPermiteBaixa(
  strCodPor: String): Boolean;
begin
  Result := False;

  If fEmptyStr(strCodPor) Then
    Exit;

  Result := VS_FuncoesExternas.fICampoTabela('POR_PERBAI', 'CADPOR', ['POR_CODPOR'], [strCodPor], False) = 'S';
end;

class procedure TLibCartoesFuncoes.FreeAndNilDatasets<T>(var ADataset: T);
begin
  If Not Assigned(ADataset) Then
    Exit;

  Try
    TDataset(ADataset).Close;
  Finally
    FreeAndNil(ADataset);
  End;
end;

class procedure TLibCartoesFuncoes.FreeAndNilStringLists(
  var AStringList: TStringList);
begin
  If Not Assigned(AStringList) Then
    Exit;

  AStringList.Clear;
  FreeAndNil(AStringList);
end;

class procedure TLibCartoesFuncoes.FreeAndNilObjeto(var AObjeto);
begin
  If Not Assigned(TObject(AObjeto)) Then
    Exit;

  FreeAndNil(AObjeto);
end;

class function TLibCartoesFuncoes.fFindCfg(var ADataset: TUniClientDataset;
  ACodCfg: string; AAdicionarConfigDuranteValidacao: Boolean; AFiltroEmpresa: Boolean = True): Boolean;
begin
  If AFiltroEmpresa Then
  Begin
    If ADataset.FindKey([ACodCfg, VS_FuncoesExternas.fIRetEmpresaLogada]) Then
      Exit(True);
  End
  Else
  Begin
    If ADataset.FindKey([ACodCfg]) Then
      Exit(True);
  End;

  If AAdicionarConfigDuranteValidacao Then
  Begin
    Try
      VS_FuncoesExternas.fICfgSis(ACodCfg.Replace('CFG_', ''), VarString, VS_FuncoesExternas.fIRetEmpresaLogada);
    Except
      //Tenta criar a configuracao caso nao exista na empresa
    End;

    If fExisteConfiguracao(ACodCfg, VS_FuncoesExternas.fIRetEmpresaLogada) Then
    Begin
      pAddConfigDataSet(ADataset, ACodCfg, VS_FuncoesExternas.fIRetEmpresaLogada);
      Result := True;
      Exit;
    End;
  End;

  Result := False;
end;

class function TLibCartoesFuncoes.fFloatToInt(fltNumero: Double): Integer;
begin
  Result := StrToIntDef(FloatToStrF(fltNumero, ffFixed, 12, 0), 0);
end;

class function TLibCartoesFuncoes.fRemoveAcento(Str: String): String;
  Const
		ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(Str) do
		If Pos(Str[x],ComAcento)<>0 Then
			Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

class function TLibCartoesFuncoes.fRetArrToSQLIn(arrValores: TConsultasArray;
  strCodigo: String): String;
  Var
    strForAux: TConsultas;
Begin
  Result := '';
  If Length(arrValores) > 0 Then
  Begin
    For strForAux In arrValores Do
      Result := Result + '"' + strForAux.strCodigo + '",';
    Result := LeftStr(Result, Length(Result) - 1);
  End
  Else
    Result := '"' + strCodigo + '"';
end;

class function TLibCartoesFuncoes.fRetEmpresaFisica: String;
begin
  Result := VS_FuncoesExternas.fICampoTabela('PRO_CODEMP', 'PROCOD', ['PRO_NOMARQ'], ['MOVGER'], False);
end;

class function TLibCartoesFuncoes.fRetornaValorConfiguracao(ACodigoConfiguracao,
  ACodigoEmpresa: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  If ACodigoEmpresa.IsEmpty Then
    ACodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.Close;
    LConsulta.SQL.Text := 'SELECT SIS_VALCFG ' +
                          'FROM CFGSIS ' +
                          'WHERE SIS_CODCFG=:CODCFG ' +
                          '  AND SIS_CODEMP=:CODEMP';

    LConsulta.ParamByName('CODCFG').AsString := ACodigoConfiguracao;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit(EmptyStr);

    Result := LConsulta.FieldByName('SIS_VALCFG').AsString;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

class function TLibCartoesFuncoes.fRetSomenteNumeros(strTexto: String): String;
  Var
    strTmp: String;
    intIndice: Integer;
begin
  strTmp := '';

  If Not fEmptyStr(strTexto) Then
  Begin
    For intIndice := 1 To Length(strTexto) Do
      If CharInSet(strTexto[intIndice], ['0'..'9']) Then
        strTmp := strTmp + strTexto[intIndice];
  End;

  Result := strTmp;
end;

class function TLibCartoesFuncoes.fRetStrToSQLArr(strValores,
  strDelimitador: String): TArray<Variant>;
  Var
    stlListEmp: TStringList;
    intCont_: Integer;
Begin
  stlListEmp := TStringList.Create;

  Try
    stlListEmp.Delimiter := '_';
    stlListEmp.DelimitedText := strValores;
    SetLength(Result, stlListEmp.Count);

    For intCont_ := 0 To stlListEmp.Count -1 Do
    Begin
      If  stlListEmp.Strings[intCont_] <> '' Then
        Result[intCont_] := stlListEmp.Strings[intCont_];
    End;
  Finally
    FreeAndNil(stlListEmp);
  End;
end;

class function TLibCartoesFuncoes.fRetStrToSQLIn(strValores,
  strDelimitador: String): String;
  var
    arrValores : TArray<String>;
    intContador: Integer;
    strResultado: String;
Begin
  arrValores := strValores.Split(strDelimitador);

  For intContador := 0 To Length(arrValores)-1 Do
  Begin
    if strResultado = '""' then
      strResultado := '';

    if not fEmptyStr(strResultado) then
      strResultado := strResultado + ', "' + arrValores[intContador] + '"'
    else
      strResultado := '"' + arrValores[intContador] + '"';
  end;

  Result := strResultado;
end;

class function TLibCartoesFuncoes.fSimpleRoundToEX(const AValue: Extended;
  const ADigit: TRoundToRange): Extended;
  var
    LFactor: Extended;
begin
  LFactor := IntPower(10.0, ADigit);
  if AValue < 0 then
    Result := Int((AValue / LFactor) - 0.5) * LFactor
  else
    Result := Int((AValue / LFactor) + 0.5) * LFactor;
end;

class function TLibCartoesFuncoes.fStrToFloat(strValorUnico: String): Double;
begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',''),0);
end;

class function TLibCartoesFuncoes.fStrZero(Zeros: string;
  Quant: integer): String;
  Var
    I,Tamanho:integer;
    Aux: string;
begin
  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  For I := 1 To Tamanho Do
	  If Aux[i] <> ',' Then
	    Zeros := Zeros + Aux[i];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  for I:=1 to Quant-Tamanho do
    Zeros:=Zeros + '0';

  Aux := Zeros + Aux;
  fStrZero := Aux;
end;

class function TLibCartoesFuncoes.fTabelaExiste(strNomTab: String): Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SHOW TABLES LIKE ' + QuotedStr(strNomTab);
    LConsulta.Open;
    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

class function TLibCartoesFuncoes.fTestaCgc(xCGC: String): Boolean;
begin
  Result := TCNPJ.fTestaCNPJ(xCGC, fRetornaValorConfiguracao('CFG_NWCNPJ') = 'S');
end;

class function TLibCartoesFuncoes.fTime(const AForceTime: Boolean;
  ADataset: TUniQuery): TDateTime;
begin
  If (AForceTime) Or (Not Assigned(ADataset)) Then
    Result := untLibCartoesHorarioSistema.GetTime()
  Else
    Result := untLibCartoesHorarioSistema.GetTime(VS_FuncoesExternas.fIRetEmpresaLogada, ADataset.Connection);
end;

class function TLibCartoesFuncoes.fTiraCaracEspeciais(strTexto: String;
  blnUsaLista, blnTiraEspacos, blnTiraPontos, blnTiraDoisPts, blnTiraTab,
  blnTiraVirgula, blnTiraAbreviacaoNumero: Boolean): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  If blnUsaLista Then
    strLista := '/\-_+#,;<>|*™∫∞&"''()%$®@!?ß={}[]¥`^~π≤≥£¢ÿ'
  Else
    strLista := EmptyStr;

  If (blnTiraEspacos) Then
    strLista := strLista + ' ';

  If (blnTiraPontos) Then
    strLista := strLista + '.';

  If (blnTiraDoisPts) Then
    strLista := strLista + ':';

  If (blnTiraTab) Then
    strLista := strLista + #9;

  If (blnTiraAbreviacaoNumero) Then
    strLista := strLista + '∫';

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := '‡ËÏÚ˘·ÈÌÛ˙‚ÍÓÙ˚„ı‰ÎÔˆ¸Á¿»Ã“Ÿ¡…Õ”⁄¬ Œ‘€√’ƒÀœ÷‹«';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;
end;

class function TLibCartoesFuncoes.fValidaCnpjCpf(strCPFCNPJ: String;
  blnMostraMSG: Boolean): Boolean;
  Var
    strOpcao : String;
begin
  Result := False;

  If Not fEmptyStr(strCPFCNPJ) Then
  Begin
    strOpcao := IfThen(Length(strCPFCNPJ) > 11, '1','2');

    Result := fValidaCnpjCpfDigIgual(strOpcao, strCPFCNPJ, False);

    If Result Then
    Begin
      If strOpcao = '1' Then
        Result := fTestaCgc(strCPFCNPJ)
      Else If strOpcao = '2' Then
        Result := fValidaCPF(strCPFCNPJ);
    End;

    If (blnMostraMSG) And (Not Result) Then
     fMensagem('ATEN«√O', strCPFCNPJ + ' n„o È um n˙mero de '+IfThen(strOpcao='1','CNPJ','CPF')+' v·lido!', ['&Ok']);
  End
  Else
  Begin
    If (blnMostraMSG) Then
      fMensagem('ATEN«√O', 'CPF/CNPJ n„o informado!', ['&Ok']);
  End;
End;

class function TLibCartoesFuncoes.fValidaCnpjCpfDigIgual(strOpcao,
  strValor: String; blnMostraMSG: Boolean): Boolean;
Var
    blnRepetido: Boolean;
    strDado    : String;
    chrLetra   : Char;
    intContador: Integer;
begin
  Result := True;

  If fEmptyStr(strValor) Then
  Begin
    Exit(False);
  End;

  blnRepetido := True;
  strDado     := fTiraCaracEspeciais(strValor);
  chrLetra    := strDado[1];

  For intContador := 2 To Length(strDado) Do
  Begin
    If chrLetra <> strDado[intContador] Then
    Begin
      blnRepetido := False;
      Break;
    End;
  End;

  If blnRepetido Then
  Begin
    Result := False;
    If blnMostraMSG Then
      fMensagem('ATEN«√O', strValor + ' n„o È um N˙mero de CPF/CNPJ v·lido!', ['&Ok']);
  End;
end;

class function TLibCartoesFuncoes.fValidaCPF(sCPF: string): Boolean;
  var
   sDigs, sVal  : string;
   iSTot, iSTot2: integer;
   i: integer;
begin
  Result := False;
  sCPF   := Trim(AnsiReplaceText(sCPF, '.', ''));
  sCPF   := Trim(AnsiReplaceText(sCPF, '-', ''));
  iSTot  := 0;
  iSTot2 := 0;
  If Length(sCPF) = 11 Then
  begin
    For i := 9 Downto 1 Do
    Begin
      iSTot  := iSTot  + StrToIntDef(Copy(sCPF,i,1),0) * (11-i);
      iSTot2 := iSTot2 + StrToIntDef(Copy(sCPF,i,1),0) * (12-i);
    End;
    iSTot  := iSTot Mod 11;
    sDigs  := sDigs + IntToStr(iif(iSTot < 2, 0, 11-iSTot));

    iSTot2 := iSTot2 + 2*StrToIntDef(sDigs,0);
    isTot2 := iSTot2 Mod 11;
    sDigs  := sDigs + IntToStr(iif(iSTot2 < 2, 0, 11-iSTot2));

    sVal   := Copy(sCPF,10,2);
    Result := sDigs = sVal;
  End;
end;

class function TLibCartoesFuncoes.fValidaLinhaGrupoCadCta(
  strLinGru: String): Boolean;
begin
  Result := True;

  If RightStr(strLinGru, 3) = '000' Then
    Result := False;
end;

class function TLibCartoesFuncoes.fValidaPeriodo(strDtaIni,
  strDtaFin: String): Boolean;
begin

  Result := True;
  {*****************************************}
  {* CASO A DATA INICIAL SEJA VAZIA, OK    *}
  {**************************************MV*}
  If Not fEmptyStr(fTiraCaracEspeciais(strDtaIni)) Then
  Begin
    Try
      If StrToDate(strDtaFin) < StrToDate(strDtaIni) Then
      Begin
        Result := False;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;
  End;

end;

class function TLibCartoesFuncoes.fVerificaAcessoCartao(
  strCodCar: String): Boolean;
  Var
    strCodEmp: String;
begin
  strCodEmp := VS_FuncoesExternas.fICampoTabela('CAR_CODEMP', 'CADCAR', ['CAR_CODCAR'], [strCodCar]);
  Result    := (fEmptyStr(strCodEmp)) Or (Pos(strCodEmp, VS_FuncoesExternas.fIRetEmpAcessoOperador) > 0);
end;

class procedure TLibCartoesFuncoes.GeraListaDeCamposTabelaDelecao(
var ACamposTabelaDelecao, AParametrosTabelaDelecao: String; ATabela: String);
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT * FROM DEL_' + ATabela + ' WHERE FALSE';
    LConsulta.Open;

    ACamposTabelaDelecao := '';
    AParametrosTabelaDelecao := '';

    For LCampo In LConsulta.Fields Do
    Begin
      ACamposTabelaDelecao := ACamposTabelaDelecao + LCampo.FieldName + ',';
      AParametrosTabelaDelecao := AParametrosTabelaDelecao + ':' + LCampo.FieldName + ',';
    End;

    ACamposTabelaDelecao := LeftStr(ACamposTabelaDelecao, ACamposTabelaDelecao.Length - 1);
    AParametrosTabelaDelecao := LeftStr(AParametrosTabelaDelecao, AParametrosTabelaDelecao.Length - 1);

  Finally
    FreeAndNilDatasets(LConsulta);
  End;
End;

class function TLibCartoesFuncoes.GetMD5(const strTexto: string): string;
  Var
    idHash128: TIdHashMessageDigest5;
begin
  idHash128 := Nil;
  Try
    idHash128 := TIdHashMessageDigest5.Create;

    Result := idHash128.HashStringAsHex(strTexto);
  Finally
    If Assigned(idHash128) Then
      FreeAndNil(idHash128);
  End;
end;

class function TLibCartoesFuncoes.GravaTabelaDelecao(AFormulario,
  ATabela: String; ARegistroDeletado: TDataSet; AGravarTodoDataset: Boolean = False): Boolean;
Const
  LArrayCamposIgnorados: Array of String = ['OPEDEL', 'DTADEL', 'HORDEL', 'MOTDEL'];

  Var
    LCamposTabelaDelecao: String;
    LParametrosTabelaDelecao: String;
    LGravarTabelaDelecao: TUniQuery;
    LCampo: TField;
Begin
  Result := False;
  LGravarTabelaDelecao := Nil;
  Try
    GeraListaDeCamposTabelaDelecao(LCamposTabelaDelecao, LParametrosTabelaDelecao, ATabela);
    LGravarTabelaDelecao := VS_FuncoesExternas.fICriaQuery;

    Try

      If ARegistroDeletado.IsEmpty Then
        Exit;

      If AGravarTodoDataset Then
        ARegistroDeletado.First;

      While Not ARegistroDeletado.Eof Do
      Begin
        LGravarTabelaDelecao.SQL.Text := 'REPLACE INTO DEL_' + ATabela + ' (' + LCamposTabelaDelecao + ') ' +
                                         ' VALUES (' + LParametrosTabelaDelecao + ') ';

        For LCampo In ARegistroDeletado.Fields Do
        Begin
          If MatchStr(LCampo.FieldName, LArrayCamposIgnorados) Then
            Continue;

          If Not LGravarTabelaDelecao.SQL.Text.Contains(LCampo.FieldName) Then
            Continue;

          LGravarTabelaDelecao.ParamByName(LCampo.FieldName).Value := LCampo.Value;
        End;

        LGravarTabelaDelecao.ParamByName('OPEDEL').AsString     := VS_FuncoesExternas.fIRetOperadorLogado;
        LGravarTabelaDelecao.ParamByName('DTADEL').AsDateTime   := VS_FuncoesExternas.fIGetVS_Date;
        LGravarTabelaDelecao.ParamByName('HORDEL').AsString     := FormatDateTime('hh:mm:ss', fTime());

        If LGravarTabelaDelecao.SQL.Text.Contains('MOTDEL') Then
          LGravarTabelaDelecao.ParamByName('MOTDEL').AsString     := '';

        LGravarTabelaDelecao.ExecSQL;
        LGravarTabelaDelecao.Close;

        If Not AGravarTodoDataset Then
          Break;

        ARegistroDeletado.Next;
      End;

      Result:= True;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNilDatasets(LGravarTabelaDelecao);
  End;

End;

class function TLibCartoesFuncoes.IfNull(varValor,
  varDefault: Variant): Variant;
begin
  Result := varValor;
	If (Result = Null) Then
		Result := varDefault;
end;

class function TLibCartoesFuncoes.IIF(ACondicao: Boolean; AValorVerdadeiro,
  AValorFalso: Variant): Variant;
begin
  If ACondicao Then
    Exit(AValorVerdadeiro);

  Result := AValorFalso;
end;

class function TLibCartoesFuncoes.MetodoExiste(AInstancia: IInterface;
  ANomeMetodo: string): Boolean;
  var
    LContext: TRttiContext;

    LRttiType: TRttiType;

    LMethod: TRttiMethod;
begin
  Result := False;

  LRttiType := LContext.GetType(TypeInfo(ILibCartoes));
  for LMethod in LRttiType.GetMethods do
  begin
    if LMethod.Name.Equals(ANomeMetodo) then
      Exit(True);
  end;
end;

class procedure TLibCartoesFuncoes.pAddConfigDataSet(
  var ADataset: TUniClientDataset; ACodigoCfg, ACodigoEmpresa: string);
  Var
    LQuery: TUniQuery;
    LIndex: Integer;
begin
  LQuery := Nil;
  try
    LQuery := VS_FuncoesExternas.fICriaQuery;
    LQuery.SQL.Add('SELECT * FROM CFGSIS WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP');
    LQuery.ParamByName('CODCFG').AsString := ACodigoCfg;
    LQuery.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LQuery.Open;
    ADataset.Append;
    for LIndex := 0 To LQuery.Fields.Count-1 do
    Begin
      if ADataset.FindField(LQuery.Fields[LIndex].FieldName) <> nil then
        ADataset.FindField(LQuery.Fields[LIndex].FieldName).Value :=
          LQuery.Fields[LIndex].Value;
    End;
    ADataset.Post;
  finally
    FreeAndNilDatasets(LQuery);
  end;
end;

class procedure TLibCartoesFuncoes.pCloneData(const objDestino,
  objOrigem: TUniClientDataSet);
begin
  objDestino.Data := objOrigem.Data;
end;

class procedure TLibCartoesFuncoes.pCloneDataSet(dtsDestino,
  dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean);
  Var
    intContador: Integer;
    prcScroll: TprcScroll;
Begin

  Try
    pDisableControls(dtsOrigem, prcScroll);

    pCloneData(dtsDestino, dtsOrigem);

    If Not dtsDestino.IsEmpty Then
      dtsDestino.LogChanges := False;

    If blnComFomatacao Then
    Begin
      For intContador := 0 To dtsOrigem.FieldCount -1 Do
      Begin
        dtsDestino.Fields[intContador].DisplayLabel := dtsOrigem.Fields[intContador].DisplayLabel;

        If dtsDestino.Fields[intContador].DataType = ftFloat Then
          TFloatField(dtsDestino.Fields[intContador]).DisplayFormat := TFloatField(dtsOrigem.Fields[intContador]).DisplayFormat;

      End;
    End;

  Finally
    pEnableControls(dtsOrigem, prcScroll);
  End;

end;

class procedure TLibCartoesFuncoes.pCriarFormularios(Classe: TComponentClass;
  var frmForm);
  Var
    intCont: Integer;
    strMsg: String;
Begin

  strMsg := '';

  For intCont := 0 To 4 Do
  Begin

    Try
      Application.CreateForm(Classe, frmForm);
      strMsg := '';
    Except
      On E: EAccessViolation Do
        Raise;

      On E: Exception Do
        strMsg := E.Message + ' ' + E.ClassName;
    End;

    If fEmptyStr(strMsg) Then
      Break;

    Application.ProcessMessages;
    Sleep(1500);

  End;

  If Not fEmptyStr(strMsg) Then
    Raise Exception.Create('Erro ao criar o formul·rio.' + #13 + strMsg);

end;

class procedure TLibCartoesFuncoes.pDesmarcaLista(edtCodigo: TCustomEdit;
  var arrLinha: TConsultasArray; strTempTable: String; intTamCamp: Integer);
  Var
    intTamanho: integer;
    strText   : string;
Begin
  If edtCodigo.ClassNameIs('TEditFocus') Then
  Begin
    strText := TEditFocus(edtCodigo).Text;
    intTamanho := TEditFocus(edtCodigo).TamCampo;
    if intTamCamp > 0 then
      intTamanho := intTamCamp;
  End Else
  Begin
    strText := TMaskEditFocus(edtCodigo).Text;
    intTamanho := IntTamCamp;
  End;

  If fEmptyStr(strText) Or
    ((strText <> fStrZero('0',intTamanho)) And (strText <> '+1')) Then
  Begin
    SetLength(arrLinha,0);
    If (Not fEmptyStr(strTempTable)) And fTabelaExiste(strTempTable) Then
      ExecutaSQL('UPDATE ' + strTempTable+ ' SET MARDES = "D"');
  End
end;

class procedure TLibCartoesFuncoes.pDisableControls(dtsDataSet: TDataSet;
  var prcScroll: TprcScroll);
begin
  prcScroll := dtsDataSet.AfterScroll;
  dtsDataSet.AfterScroll := Nil;
  dtsDataSet.DisableControls;
end;

class procedure TLibCartoesFuncoes.pEdtCodSelectExit(edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; var arrLinha: TConsultasArray; fncRetNome: TfncRetNome;
  fncRetNomeConst: TfncRetNomeConst; strMsgErr: String; intTamCamp: integer;
  blnNegar: Boolean; strCodigo: String; blnFeminino,
  blnSuprimirMensagem: Boolean; fncRetNomeParam: tfncRetNomeParam;
  arrAux: TConsultasArray; strCodAux, strAutIncrem: String);
  Var
    intTamanho: Integer;
    strText  : String;
Begin


  If Assigned(edtDescri) Then
  Begin

    If edtCodigo.ClassNameIs('TEditFocus') Then
    Begin
      intTamanho := TEditFocus(edtCodigo).TamCampo;
      if intTamCamp > 0 then
        intTamanho := intTamCamp;
      strText    := TEditFocus(edtCodigo).Text;
    End

    Else
    Begin
      intTamanho := intTamCamp;
      strText    := TMaskEditFocus(edtCodigo).Text;
    End;

    If strText <> fStrZero('0',intTamanho) Then
      SetLength(arrLinha,0);

    If fEmptyStr(strText) Then
    Begin
      If Assigned(edtDescri) Then
      Begin
        If blnNegar Then
          If blnFeminino Then
            edtDescri.Text := 'NENHUMA'
          Else
            edtDescri.Text := 'NENHUM'
        Else
          If blnFeminino Then
            edtDescri.Text := 'TODAS'
          Else
            edtDescri.Text := 'TODOS';
      End;
    End

    Else
    Begin

      If Length(arrLinha) = 0 Then
      Begin
        SetLength(arrLinha,1);
        arrLinha[0].strCodigo := strText;

        if assigned(fncRetNomeParam) then
        begin
          if assigned(arrAux) then
            arrlinha[0].strDescri := fncRetNomeParam(strText,arrAux)
          else
            arrlinha[0].strDescri := fncRetNomeParam(iif(strAutIncrem<>'',strAutIncrem,strText));
        end
        else
        If Assigned(fncRetNomeConst) Then
          arrLinha[0].strDescri := fncRetNomeConst(strText)

        Else If Assigned(fncRetNome) Then
          arrLinha[0].strDescri := fncRetNome(strText);

      End;

      If Length(arrLinha) = 1 Then
      Begin
        If Assigned(edtDescri) Then
        begin
          If Assigned(fncRetNomeParam) Then
          begin
            if assigned(arrAux) then
              edtDescri.Text := fncRetNomeParam(strText, arrAux)
            else
              edtDescri.Text := fncRetNomeParam(strText);
          end
          else
          If Assigned(fncRetNomeConst) Then
            edtDescri.Text := fncRetNomeConst(strText)
          Else If Assigned(fncRetNome) Then
            edtDescri.Text := fncRetNome(strText);
        end;
      End;
    End;

    If Assigned(edtDescri) Then
    Begin
      If fEmptyStr(edtDescri.Text) And (Not fEmptyStr(strText))  and Not(blnSuprimirMensagem)Then
      Begin
        fMensagem('', strCodigo + ' ' + strMsgErr + ' n„o encontrado.', ['&O K']);
        edtCodigo.Clear;
        pSetFocus(edtCodigo);
      End;
    End;
  End
  Else
  Begin
    If edtCodigo.Text <> '+1' Then
      SetLength(arrLinha,0);

    If (Length(arrLinha) = 0) And (Not fEmptyStr(edtCodigo.Text)) Then
    Begin
      SetLength(arrLinha,1);
      arrLinha[0].strCodigo := edtCodigo.Text;
    End;

    If  (Not(blnSuprimirMensagem)) And
        (Length(arrLinha) = 1) And
       ((Assigned(fncRetNomeConst) And fEmptyStr(fncRetNomeConst(edtCodigo.Text))) Or
         (Assigned(fncRetNome)     And fEmptyStr(fncRetNome(edtCodigo.Text)))    ) And
       (Not fEmptyStr(edtCodigo.Text))                                             Then
    Begin
      fMensagem('AVISO', strCodigo + ' '+ strMsgErr + ' n„o encontrado.', ['&O K']);
      edtCodigo.Clear;
      pSetFocus(edtCodigo);
    End;

  End;
End;

{$IFNDEF LINUX}
class function TLibCartoesFuncoes.PegaTimeZone: Integer;
  Var
    TimeZone: TTimeZoneInformation;

    LTimeZoneServer: TUniQuery;

    LValorMaquinaLocal: Integer;

    LPossuiTimeZoneAlterado: Boolean;
begin
  If VS_TimeZone <> 0 Then
    Exit(VS_TimeZone);

  Result := 3;

  LTimeZoneServer := Nil;
  Try
    LTimeZoneServer := VS_FuncoesExternas.fICriaQuery;
    Try
      GetTimeZoneInformation(TimeZone);

      LValorMaquinaLocal := TimeZone.Bias div 60;
    Except
      LValorMaquinaLocal := 3;
    End;

    Try
      LTimeZoneServer.SQL.Text := 'SHOW VARIABLES LIKE "%time_zone%"';
      LTimeZoneServer.Open;

      If Not LTimeZoneServer.IsEmpty Then
      Begin
        LPossuiTimeZoneAlterado := LTimeZoneServer.Locate('Variable_name', 'time_zone', []);
        If LPossuiTimeZoneAlterado Then
        Begin
          LPossuiTimeZoneAlterado := Not LTimeZoneServer.FieldByName('Value').AsString.ToUpperInvariant.Equals('SYSTEM');

          If LPossuiTimeZoneAlterado Then
          Begin
            If TryStrToInt(LeftStr(LTimeZoneServer.FieldByName('Value').AsString, 3).Replace(':', EmptyStr), Result) Then
            Begin
              Result := Result * -1;
              Exit;
            End;
          End;
        End;

        If LTimeZoneServer.Locate('Variable_name', 'system_time_zone', []) Then
        Begin
          Result := LTimeZoneServer.FieldByName('value').AsInteger * -1;
          Exit;
        End;
      End;

      Result := LValorMaquinaLocal;
    Except
      Result := LValorMaquinaLocal;
    End;
  Finally
    VS_TimeZone := Result;

    FreeAndNilDatasets(LTimeZoneServer);
  End;
end;
{$ENDIF}

class procedure TLibCartoesFuncoes.pEnableControls(dtsDataSet: TDataSet;
  var prcScroll: TprcScroll; blnRefresh: Boolean);
begin
  dtsDataSet.EnableControls;
  dtsDataSet.AfterScroll := prcScroll;
  If blnRefresh then
    dtsDataSet.AfterScroll(dtsDataSet)
end;

class function TLibCartoesFuncoes.PlanoDeContasAtivo(ACodCta: String;
  AMsgAlerta: Boolean): Boolean;
  Var
    LQryAux : TUniQuery;
    LSQL    : String;
begin
  If fEmptyStr(ACodCta) Then
    Exit(True);

  LQryAux := Nil;
  Try
    LQryAux := VS_FuncoesExternas.fICriaQuery;

    Result := False;

    LSQL := '';
    LSQL := LSQL + 'SELECT                       ';
    LSQL := LSQL + '  CTA_STATUS                 ';
    LSQL := LSQL + 'FROM                         ';
    LSQL := LSQL + '  CADCTA                     ';
    LSQL := LSQL + 'WHERE CTA_CODCTA = :CODCTA   ';

    Try
      LQryAux.Close;
      LQryAux.SQL.Clear;
      LQryAux.SQL.Add(LSQL);
      LQryAux.ParamByName('CODCTA').AsString := ACodCta;
      LQryAux.Open;
      Result := LQryAux.FieldByName('CTA_STATUS').AsString.Equals('A');

      If Not Result And AMsgAlerta Then
      Begin
        fMensagem('ATEN«√O!', 'O Plano de Contas est· Inativo!', ['&Ok']);
      End

    Except
      On E : Exception Do
      Begin
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[untFuncoesSimples.PlanoDeContasInativo]');
      End;
    End;
  Finally
    FreeAndNilDatasets(LQryAux);
  End;
end;

class procedure TLibCartoesFuncoes.pProcessMessages(ANow: Boolean);
begin
  If ((ANow) Or (MilliSecondsBetween(Now(), FLastProcessMessages) >= 700)) Then
  Begin
    Application.ProcessMessages;
    FLastProcessMessages := Now();
  End;
end;

class procedure TLibCartoesFuncoes.pSetaClient(cdsClient: TDataSet);
  Var
    intContador: Integer;
Begin
  For intContador := 0 To cdsClient.Fields.Count - 1 Do
  Begin
    If cdsClient.Fields[intContador].ReadOnly Then
      cdsClient.Fields[intContador].ProviderFlags := cdsClient.Fields[intContador].ProviderFlags - [pfInWhere, pfInUpdate];
    cdsClient.Fields[intContador].ReadOnly := False;
    cdsClient.Fields[intContador].Required := False;
  End;
end;

class procedure TLibCartoesFuncoes.pSetFocus(SenderUnico: TWinControl;
  Form: TCustomForm);
begin
  If Not Assigned(SenderUnico) Then
    Exit;

  If ((GetKeyState(VK_SHIFT) And 128) = 128) And
     ((GetKeyState(VK_TAB) And 128) = 128) Then
    Exit;

  Try
    if Form = Nil then
      Form := GetParentForm(SenderUnico);

    If (Form <> nil) And (Form.CanFocus) And SenderUnico.CanFocus Then
    Begin
      Try
        SenderUnico.SetFocus;

        if (SenderUnico is TCustomCheckBox) or (SenderUnico is TCustomCombo) then
          SenderUnico.Perform(WM_UPDATEUISTATE, MakeWParam(UIS_CLEAR, UISF_HIDEFOCUS), 0);

      Except

      End;
    End;
  Except

  End;
end;

class procedure TLibCartoesFuncoes.pStepStatusGravacao(
  pgbStatus: TcxProgressBar; strInformacao: String; blnStep: Boolean);
begin
  If Assigned(pgbStatus) Then
  Begin
    If blnStep Then
      pgbStatus.Position := pgbStatus.Position + 1;

    If (Not fEmptyStr(strInformacao)) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
      TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInformacao;

    pProcessMessages;
  End;

  If Not fEmptyStr(strInformacao) Then
    If Not VS_ExibirMensagemAoUsuario Then
      If Assigned(VS_OnMensagemAoUsuario) Then
        VS_OnMensagemAoUsuario(strInformacao);
end;

class function TLibCartoesFuncoes.RetiraZerosEsquerda(AString: String): String;
begin
  If AString.IsEmpty Then
    Exit('');

  While AString[1] = '0' do
  Begin
    Delete(AString,1,1);

    If AString.Length = 0 Then
      Break;
  End;

  Result := AString;
end;

class function TLibCartoesFuncoes.RetornaChaveBasic(AClientID,
  AClientSecret: String): String;
  Var
    LBase64: TBase64Encoding;
begin
  Result := '';

  If AClientID.IsEmpty Then
    Exit;

  If AClientSecret.IsEmpty Then
    Exit;

  LBase64 := Nil;
  Try
    LBase64 := TBase64Encoding.Create(0);

    Result := 'Basic ' + LBase64.Encode(AClientID + ':' + AClientSecret);
  Finally
    If Assigned(LBase64) Then
      FreeAndNil(LBase64);
  End;
end;

class function TLibCartoesFuncoes.RetornaDataHoraServidor: TDateTime;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT CURRENT_TIMESTAMP AS DATAHORA FROM DUAL';
    LConsulta.Open;

    Result := LConsulta.FieldByName('DATAHORA').AsDateTime;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

class function TLibCartoesFuncoes.RetornaHoraServidor: TTime;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT CURRENT_TIME AS HORA FROM DUAL';
    LConsulta.Open;

    Result := LConsulta.FieldByName('HORA').AsDateTime;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

class function TLibCartoesFuncoes.RetornaNomeBandeira(
  ANumeroCartao: String; ATipoCartao: String = ''): String;
Begin
  //Visa
  If (LeftStr(ANumeroCartao, 1) = '4') And
     (Length(ANumeroCartao) In [13, 16, 19]) Then
    Result := 'VISA'
  Else
  //Master
  If ((Pos(LeftStr(ANumeroCartao, 2), '51_52_53_54_55_') > 0) Or
      (Pos(LeftStr(ANumeroCartao, 4), '2221_2720_2307_') > 0) And
      (Length(ANumeroCartao) = 16)) Or
     (Pos(LeftStr(ANumeroCartao, 4), '6036_') > 0) Then
  Begin
    Result := 'MASTERCARD';

    If ATipoCartao = 'D…BITO' Then
      Result := 'MAESTRO';
  End
  Else
  //Banricompras
  If (LeftStr(ANumeroCartao, 6) = '639664') Then
    Result := 'BANRICOMPAS'
  Else
  //VerdeCard
  If (LeftStr(ANumeroCartao, 6) = '627894') Then
    Result := 'VERDECARD'
  Else
  //BanriCard
  If (LeftStr(ANumeroCartao, 6) = '608718') Then
    Result := 'BANRICARD'
  else
  //Maestro
  If ((Pos(LeftStr(ANumeroCartao, 2), '50_56_57_58_') > 0) Or (LeftStr(ANumeroCartao, 1) = '6')) And
     (Length(ANumeroCartao) = 16) Then
    Result := 'MAESTRO'
  Else
  //American Express
  If (Pos(LeftStr(ANumeroCartao, 2), '34_37_') > 0) Then
    Result := 'AMERICAN EXPRESS'
  Else
  //Diners
  If (Pos(LeftStr(ANumeroCartao, 3), '300_301_302_303_304_305_309_') > 0) Or
     (Pos(LeftStr(ANumeroCartao, 2), '36_38_39') > 0) And
     (Length(ANumeroCartao) In [14, 16, 17, 18, 19]) Then
    Result := 'DINERS'
  Else
  //Elo
  If (Pos(LeftStr(ANumeroCartao, 4), '4011_4576_5067_') > 0) Or
     (Pos(LeftStr(ANumeroCartao, 6), '636368_438935_504175_451416_636297_506699_') > 0) Then
    Result := 'ELO'
  Else
  //Hipercard
  If (Pos(LeftStr(ANumeroCartao, 4), '3841_6062_') > 0) Then
    Result := 'HIPERCARD'
  Else
  //Aura
  If (LeftStr(ANumeroCartao, 2) = '50') Then
    Result := 'AURA'
  Else
  //BANESCARD
  If (Pos('585988',ANumeroCartao) > 0) Then
    Result := 'BANESCARD'

  //N„o conhecido
  Else
  Begin
    Result := 'OUTROS';

    If Pos('PIX', ANumeroCartao) > 0 Then
      Result := 'PIX'
    Else If Pos('BOLETO', ANumeroCartao) > 0 Then
      Result := 'BOLETO';

  End;
end;

class function TLibCartoesFuncoes.RetornaNomeCentroDeCustos(
  ACodigoEvento: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  If ACodigoEvento.Trim.IsEmpty Then
    Exit(EmptyStr);

  If Not Assigned(FNomeCentroDeCustos) Then
  Begin
    LConsulta := Nil;
    FNomeCentroDeCustos := TDictionary<String, String>.Create;

    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SELECT EVE_CODEVE, ' +
                            '       EVE_CODCOM, ' +
                            '       EVE_DESEVE  ' +
                            'FROM CADEVE ' +
                            'ORDER BY EVE_CODEVE, EVE_CODCOM ';

      LConsulta.Open;

      If LConsulta.IsEmpty Then
        Exit(EmptyStr);

      While Not LConsulta.Eof Do
      Begin
        FNomeCentroDeCustos.AddOrSetValue(LConsulta.Fields[0].AsString, LConsulta.Fields[2].AsString);

        If Not LConsulta.Fields[1].AsString.IsEmpty Then
          FNomeCentroDeCustos.AddOrSetValue(LConsulta.Fields[1].AsString, LConsulta.Fields[2].AsString);

        LConsulta.Next;
      End;
    Finally
      FreeAndNilDatasets(LConsulta);
    End;
  End;

  If Not FNomeCentroDeCustos.TryGetValue(ACodigoEvento, Result) Then
    Result := EmptyStr;
end;

class function TLibCartoesFuncoes.RetornaNomeEmpresa(ACodEmp: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  If ACodEmp.Trim.IsEmpty Then
    Exit(EmptyStr);

  If Not Assigned(FNomeEmpresa) Then
  Begin
    LConsulta := Nil;
    FNomeEmpresa := TDictionary<String, String>.Create;

    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SELECT EMP_CODEMP, ' +
                            '       EMP_NOMEMP  ' +
                            'FROM CADEMP ' +
                            'ORDER BY EMP_CODEMP';
      LConsulta.Open;

      If LConsulta.IsEmpty Then
        Exit(EmptyStr);

      While Not LConsulta.Eof Do
      Begin
        FNomeEmpresa.AddOrSetValue(LConsulta.Fields[0].AsString, LConsulta.Fields[1].AsString);
        LConsulta.Next;
      End;
    Finally
      FreeAndNilDatasets(LConsulta);
    End;
  End;

  If Not FNomeEmpresa.TryGetValue(ACodEmp, Result) Then
    Result := EmptyStr;
end;

class function TLibCartoesFuncoes.RetornaNomeFornecedor(
  ACodigoFornecedor: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  If ACodigoFornecedor.Trim.IsEmpty Then
    Exit(EmptyStr);

  If Not Assigned(FNomeFornecedor) Then
  Begin
    LConsulta := Nil;
    FNomeFornecedor := TDictionary<String, String>.Create;

    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SELECT FOR_CODFOR, ' +
                            '       FOR_NOMFOR  ' +
                            'FROM CADFOR ' +
                            'ORDER BY FOR_CODFOR';
      LConsulta.Open;

      If LConsulta.IsEmpty Then
        Exit(EmptyStr);

      While Not LConsulta.Eof Do
      Begin
        FNomeFornecedor.AddOrSetValue(LConsulta.Fields[0].AsString, LConsulta.Fields[1].AsString);
        LConsulta.Next;
      End;
    Finally
      FreeAndNilDatasets(LConsulta);
    End;
  End;

  If Not FNomeFornecedor.TryGetValue(ACodigoFornecedor, Result) Then
    Result := EmptyStr;
end;

class function TLibCartoesFuncoes.RetornaNomeOperador(
  ACodigoOperador: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  If ACodigoOperador.Trim.IsEmpty Then
    Exit(EmptyStr);

  If Not Assigned(FNomeOperador) Then
  Begin
    LConsulta := Nil;
    FNomeOperador := TDictionary<String, String>.Create;

    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SELECT OPE_CODOPE, ' +
                            '       OPE_NOMOPE  ' +
                            'FROM CADOPE ' +
                            'ORDER BY OPE_CODOPE';
      LConsulta.Open;

      If LConsulta.IsEmpty Then
        Exit(EmptyStr);

      While Not LConsulta.Eof Do
      Begin
        FNomeOperador.AddOrSetValue(LConsulta.Fields[0].AsString, LConsulta.Fields[1].AsString);
        LConsulta.Next;
      End;
    Finally
      FreeAndNilDatasets(LConsulta);
    End;
  End;

  If Not FNomeOperador.TryGetValue(ACodigoOperador, Result) Then
    Result := EmptyStr;
end;

class function TLibCartoesFuncoes.RetornaNomePortador(
  ACodigoPortador: String): String;
  Var
    LConsulta: TUniQuery;
Begin
   If ACodigoPortador.Trim.IsEmpty Then
    Exit(EmptyStr);

  If Not Assigned(FNomePortador) Then
  Begin
    LConsulta := Nil;
    FNomePortador := TDictionary<String, String>.Create;

    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SELECT POR_CODPOR, ' +
                            '       POR_NOMPOR  ' +
                            'FROM CADPOR ' +
                            'ORDER BY POR_CODPOR';
      LConsulta.Open;

      If LConsulta.IsEmpty Then
        Exit(EmptyStr);

      While Not LConsulta.Eof Do
      Begin
        FNomePortador.AddOrSetValue(LConsulta.Fields[0].AsString, LConsulta.Fields[1].AsString);
        LConsulta.Next;
      End;
    Finally
      FreeAndNilDatasets(LConsulta);
    End;
  End;

  If Not FNomePortador.TryGetValue(ACodigoPortador, Result) Then
    Result := EmptyStr;
end;

class function TLibCartoesFuncoes.RetornaTamandoDeCampoString(ANomeTabela,
  ANomeCampo: String; ATamanhoDefault: Integer): Integer;
  Var
    LConsulta: TUniQuery;
begin
  Result := ATamanhoDefault;

  If ANomeCampo.IsEmpty Then
    Exit;

  If ANomeTabela.IsEmpty Then
    Exit;

  LConsulta := Nil;
  Try
    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SELECT COLUMN_NAME AS CAMPO, ' +
                            '       DATA_TYPE AS TIPO,  ' +
                            '       CHARACTER_MAXIMUM_LENGTH AS TAMANHO ' +
                            'FROM information_schema.COLUMNS ' +
                            'WHERE TABLE_SCHEMA = :BANCO ' +
                            '  AND TABLE_NAME = :TABELA ' +
                            '  AND COLUMN_NAME = :CAMPO ';

      LConsulta.ParamByName('BANCO').AsString := LConsulta.Connection.Database;
      LConsulta.ParamByName('TABELA').AsString := ANomeTabela;
      LConsulta.ParamByName('CAMPO').AsString := ANomeCampo;
      LConsulta.Open;

      If LConsulta.IsEmpty Then
        Exit;

      If Not MatchStr(LConsulta.FieldByName('TIPO').AsString, ['char', 'varchar', 'text']) Then
        Exit;

      Result := LConsulta.FieldByName('TAMANHO').AsInteger;
    Except
      { n„o pode parar a rotina }
    End;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

class function TLibCartoesFuncoes.RetornaTimeStampEmMilisegundos: Int64;
{$IFDEF LINUX}
begin
  Result := DateTimeToUnix(Now, False) * 1000 + MilliSecondOf(Now);
end;
{$ELSE}
  var
    LDateTime: TDateTime;

    LDataServidor,
    LHoraServidor: TDateTime;

    LConsulta: TUniQuery;

    SystemTime: TSystemTime;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    Try
      LConsulta.SQL.Text := 'SELECT CURRENT_DATE AS DATA, ' +
                            '       CURTIME(3) AS HORA ' +
                            'FROM DUAL';
      LConsulta.Open;

      LDataServidor := FloatToDateTime(LConsulta.FieldByName('DATA').AsFloat);
      LHoraServidor := IncHour(FloatToDateTime(LConsulta.FieldByName('HORA').AsFloat), PegaTimeZone);

      LDateTime := EncodeDate(YearOf(LDataServidor), MonthOf(LDataServidor), DayOf(LDataServidor)) +
                   EncodeTime(HourOf(LHoraServidor), MinuteOf(LHoraServidor), SecondOf(LHoraServidor), MilliSecondOf(LHoraServidor));

      Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
    Except
      GetSystemTime(SystemTime);
      LDateTime := EncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay) +
                   EncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
      Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
    End;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
End;
{$ENDIF}

class function TLibCartoesFuncoes.RetornaValorCfg(ACodigoCfg: String;
  ACodigoEmpresa: String = ''; AValorDefault: String = ''): String;
  Var
    LConsulta: TUniQuery;
begin
  If ACodigoEmpresa.IsEmpty Then
    ACodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT SIS_VALCFG ' +
                          'FROM CFGSIS ' +
                          'WHERE SIS_CODCFG=:CODCFG ' +
                          '  AND SIS_CODEMP=:CODEMP ';

    LConsulta.ParamByName('CODCFG').AsString := ACodigoCfg;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.Open;

    Result := LConsulta.FieldByName('SIS_VALCFG').AsString;
    If Result.IsEmpty Then
      Result := AValorDefault;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

class procedure TLibCartoesFuncoes.SetaValorCampoDataset(
  var ADataset: TUniQuery; const ANomeCampo: String; AValorCampo: Variant;
  ASempredaVariavel: Boolean; AValorCampoNulo: String);
begin
  If ANomeCampo.IsEmpty Then
    Exit;

  If Not Assigned(ADataset) Then
    Exit;

  If Not ADataset.Active Then
    Exit;

  If ADataset.FindField(ANomeCampo) = Nil Then
    Exit;

  If VarToStr(AValorCampo).Equals(AValorCampoNulo) Then
  Begin
    ADataset.FieldByName(ANomeCampo).Clear;
    Exit;
  End;

  ADataset.FieldByName(ANomeCampo).Value := AValorCampo;

  If ASempredaVariavel Then
    Exit;

  If VarToStr(AValorCampo).IsEmpty Then
    ADataset.FieldByName(ANomeCampo).Clear;
end;

class function TLibCartoesFuncoes.TryDirectoryExists(APath: string;
  ATimeoutSecs: Integer): Boolean;
  Var
    res: TThreadDirectoryExists.TTestResult;
    thread: TThreadDirectoryExists;
begin
  Result := False;
  if APath = '' then
    Exit;

  res := trNoDirectory;
  Assert(ATimeoutSecs > 0, 'TryDirectoryExists: timeout cannot be 0.');
  thread:= Nil;
  Try
    thread:= TThreadDirectoryExists.Create( true );
    res := thread.TestForDir(APath, ATimeoutSecs * 1000);
    Result := (res = trDirectoryExists);
  Finally
    if res = trTimeout then
      thread := Nil
    Else
      FreeAndNil(thread);
  End;
end;

class procedure TLibCartoesFuncoes.Inc64(var AValor: Int64; AIntervalo: Int64 = 1);
Begin
  AValor := AValor + AIntervalo;
End;

initialization
  VS_FuncoesExternas := TLibCartoesFactory.Get;
  TLibCartoesFuncoes.FDadosImportacaoConfirmacao := Nil;
  TLibCartoesFuncoes.FCampoMER_NUMNSUExiste := EmptyStr;

  TLibCartoesFuncoes.FNomeFornecedor := Nil;
  TLibCartoesFuncoes.FNomePortador := Nil;
  TLibCartoesFuncoes.FNomeCentroDeCustos := Nil;
  TLibCartoesFuncoes.FNomeEmpresa := Nil;
  TLibCartoesFuncoes.FNomeOperador := Nil;

finalization
  VS_FuncoesExternas := Nil;

  If Assigned(TLibCartoesFuncoes.FIconeAplicacao) Then
    FreeAndNil(TLibCartoesFuncoes.FIconeAplicacao);

  If Assigned(TLibCartoesFuncoes.FDadosImportacaoConfirmacao) Then
    TLibCartoesFuncoes.FDadosImportacaoConfirmacao := Nil;

  TLibCartoesFuncoes.DestroiDicionariosCache;
  
end.
