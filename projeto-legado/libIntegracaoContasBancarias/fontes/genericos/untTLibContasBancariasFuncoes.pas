unit untTLibContasBancariasFuncoes;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, System.Math,
     Vcl.Forms, System.DateUtils, Vcl.StdCtrls, System.Variants,
     Vcl.Controls, Winapi.Windows, Winapi.Messages, Data.DB,
     Vcl.Themes, Vcl.Styles, Vcl.SysStyles,Graphics,Vcl.Dialogs,
     Vcl.Buttons,BitBtnLockedIncrem,System.UITypes,

     Uni, UniClientDataset, cxProgressBar, EditFocus, maskEditFocus,
     IdHashMessageDigest, frxClass,

     untILibContaBancariaFactory, untILibContaBancariaWrapper, untLibContaBancariaInterfacesTipos,
     untLibContaBancariaHorarioSistema,untLibContaBancariaConstantes,untMensagem,
     Faturamento.Classes.CNPJ;

Type
  TLibContaBancariaFuncoes = class
    class var FLastProcessMessages: TDateTime;
    class var FExisteCampoLiberacaoTransferencia: Boolean;

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
    class function fGetConnectionID: String;
    class function fRetSomenteNumeros(strTexto: String): String;
    class function fGetLetraAlfa(intCol: Integer): String;
    class function fGetPosLetraAlfa(strLetra: String): Integer;
    class procedure Aguarde(msecs: Integer);
    class procedure AguardeCincoSegundos;
    class procedure AguardeTresSegundos;
    class function fFloatToInt(fltNumero: Double): Integer;
    class procedure CarregaEstiloAutcom;
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
    class function fMensagem(strTitulo: String;
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
                       intQtdLinha: Integer = -1;
                       pProcedureAjuda: TProcedureAjuda = nil): Integer; overload; //deprecated;
    class function fMensagemEx(strTitulo: String;
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
                                            AValorparametro: Variant);

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
                                      strCodigo       : String = 'Código';
                                      blnFeminino     : Boolean = False;
                                      blnSuprimirMensagem : Boolean = False;
                                      fncRetNomeParam : tfncRetNomeParam = nil;
                                      arrAux          : TConsultasArray = nil;
                                      strCodAux       : String = '';
                                      strAutIncrem    : String = '');

    class function GravaTabelaDelecao(AFormulario,
                                      ATabela: String;
                                      ARegistroDeletado: TDataSet;
                                      AGravarTodoDataset: Boolean = False): Boolean;

    class function fFindCfg(var ADataset: TUniClientDataset;
                            ACodCfg: string;
                            AAdicionarConfigDuranteValidacao: Boolean;
                            AFiltroEmpresa: Boolean = True): Boolean;

    class function MetodoExiste(AInstancia: IInterface;
                                ANomeMetodo: string): Boolean;
    class function CampoExiste(ANomeTabela,
                               ANomeCampo: String): Boolean;
    class function RetornaValorCfg(ACodigoCfg: String;
                                   ACodigoEmpresa: String = ''): String;

    class function AguardeExecutarModalA(const AGenericProcedure: TGenericProcedure;
                                         const ADescricaoTela,
                                         AChaveTela: string): Boolean;

    class function ExecutaAguarde(AFuncaoGravando: TFunctionFormGravando;
                                  AMensagem: String): Boolean;

    class function CriarFormGravando: TForm;
    class procedure AlterarMensagemFormGravando(AFormgravando: TForm; AMensagem: String);
    class procedure AtualizarStatusProgressaFormGravando(AFormgravando: TForm);
    class procedure IniciarProgressoFormGravando(AFormgravando: TForm;
                                                 intProgresso: Integer;
                                                 intMaximo: Integer);
    class procedure AdicionarFuncaoAcaoFormGravando(AFormgravando: TForm; AFunctionFormGravando: TFunctionFormGravando);
  private
    class function fArredondaABNT_NBR5891_77(fltValor: Double;
                                             intDecimais: TRoundToRange;
                                             const Delta: Double  = 0.00001 ): Double;

    class function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;

    class function fSimpleRoundToEX(const AValue: Extended; const ADigit: TRoundToRange = -2): Extended;

    class procedure pProcessMessages(ANow: Boolean = False);

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
    VS_FuncoesExternas: ILibContaBancaria;

implementation
Uses untLibContaBancariaGravando,
     untLibContaBancariaGravandoOld;
{ TLibContaBancariaFuncoes }

class procedure TLibContaBancariaFuncoes.Aguarde(msecs: Integer);
  var
    FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;

class procedure TLibContaBancariaFuncoes.AguardeCincoSegundos;
begin
  Aguarde(5000);
end;

class procedure TLibContaBancariaFuncoes.AguardeTresSegundos;
begin
  Aguarde(1500);
end;

class function TLibContaBancariaFuncoes.AguardeExecutarModalA(
  const AGenericProcedure: TGenericProcedure; const ADescricaoTela,
  AChaveTela: string): Boolean;
begin
  If VS_FuncoesExternas.fITelaGravandoAntiga Then
    Result := TfrmGravandoOld.fExecutarModalA(AGenericProcedure, ADescricaoTela, AChaveTela)
  Else
    Result := TfrmGravando.fExecutarModalA(AGenericProcedure, ADescricaoTela, AChaveTela);
end;

class procedure TLibContaBancariaFuncoes.AlterarMensagemFormGravando(
  AFormgravando: TForm; AMensagem: String);
begin
  If VS_FuncoesExternas.fITelaGravandoAntiga Then
    TfrmGravandoOld(AFormgravando).lblGravando.Caption := AMensagem
  Else
    TfrmGravando(AFormgravando).lblGravando.Caption := AMensagem;
end;

class procedure TLibContaBancariaFuncoes.AtualizarStatusProgressaFormGravando(
  AFormGravando: TForm);
begin
  If VS_FuncoesExternas.fITelaGravandoAntiga Then
  Begin
    If Assigned(TfrmGravandoOld(AFormgravando).pgbStatus) Then
      pStepStatusGravacao(TfrmGravandoOld(AFormGravando).pgbStatus);
  End
  Else
  Begin
    If Assigned(TfrmGravando(AFormGravando).pgbStatus) Then
      pStepStatusGravacao(TfrmGravando(AFormGravando).pgbStatus);
  End;
end;

class procedure TLibContaBancariaFuncoes.AdicionarFuncaoAcaoFormGravando(
  AFormgravando: TForm; AFunctionFormGravando: TFunctionFormGravando);
begin
  If VS_FuncoesExternas.fITelaGravandoAntiga Then
    TfrmGravandoOld(AFormgravando).fExecutarAcao := AFunctionFormGravando
  Else
    TfrmGravando(AFormgravando).fExecutarAcao := AFunctionFormGravando;
end;

class function TLibContaBancariaFuncoes.CampoExiste(ANomeTabela,
  ANomeCampo: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT * FROM ' + ANomeTabela + ' WHERE FALSE';
    LConsulta.Open;

    Result := LConsulta.FindField(ANomeCampo) <> Nil;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class procedure TLibContaBancariaFuncoes.CarregaEstiloAutcom;
begin
  If VS_AutcomModoClassico Then
    Exit;

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
    VS_AutcomModoClassico := True;
  End;
end;

class procedure TLibContaBancariaFuncoes.CarregaParametroDataset(
  var ADataset: TUniQuery; ANomeParametro: String; AValorparametro: Variant);
begin
  If Not Assigned(ADataset) Then
    Exit;

  If ADataset.Params.FindParam(ANomeParametro) = Nil Then
    Exit;

  Try
    ADataset.ParamByName(ANomeParametro).Value := AValorParametro;
  Except
    On E: Exception Do
      Raise E;
  End;
end;

class function TLibContaBancariaFuncoes.CentroDeCustosAtivo(ACodEve: String;
  AMsgAlerta: Boolean): Boolean;
  Var
    LQryAux : TUniQuery;
    LSQL    : String;
begin
  If fEmptyStr(ACodEve) Then
    Exit(True);

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
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'O Centro de Custos está Inativo!', ['&Ok']);
      End

    Except
      On E : Exception Do
      Begin
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[untFuncoesSimples.CentroDeCustosAtivo]');
      End;
    End;
  Finally
    FreeAndNil(LQryAux);
  End;
end;

class function TLibContaBancariaFuncoes.ConverterArrayConsultaParaStringList(
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

class function TLibContaBancariaFuncoes.CriarClientDataSet(ADataSet: TDataSet; blnVazio: Boolean = False;
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

  With ADataSet Do
  Begin
    intRecno := RecNo;
    DisableControls;

    If Not blnRegistroAtual Then
      First;

    While (Not Eof) Or blnRegistroAtual Do
    Begin
      Result.Append;

      For intCont := 0 To Fields.Count -1 Do
        Result.Fields[intCont].Value := Fields[intCont].Value;

      Result.Post;

      If blnRegistroAtual Then
        Break;

      Next;
    End;
    RecNo := intRecno;
    EnableControls;
  End;
end;

class function TLibContaBancariaFuncoes.CriarFormGravando: TForm;
begin
  If VS_FuncoesExternas.fITelaGravandoAntiga Then
    pCriarFormularios(TfrmGravandoOld, Result)
  Else
    pCriarFormularios(TfrmGravando, Result)
end;

class function TLibContaBancariaFuncoes.ExecutaAguarde(
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
  End;
end;

class function TLibContaBancariaFuncoes.ExecutaSQL(AScriptExec: String): Boolean;
  Var
    LExecutar: TUniQuery;
Begin
  Try
    LExecutar := VS_FuncoesExternas.fICriaQuery;

    Try
      LExecutar.SQL.Text := AScriptExec;
      LExecutar.ExecSQL;

      Result := LExecutar.RowsAffected > 0;
    Finally
      LExecutar.Close;
      FreeAndNil(LExecutar);
    End;
  Except
    On E: Exception Do
      Raise E;
  End;
End;

class function TLibContaBancariaFuncoes.fArredondaABNT_NBR5891_77(fltValor: Double;
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

class function TLibContaBancariaFuncoes.fBetween(fltValor, fltMinimo,
  fltMaximo: Double): Boolean;
begin
  Result := (fltValor >= fltMinimo) And
            (fltValor <= fltMaximo);
end;

class function TLibContaBancariaFuncoes.fCfgSisEmp(strCodCfg, strValCfg: String;
  ALocateValor: Boolean): String;
  Var
    strSQL   : String;
    qryGenCfg: TUniQuery;
Begin
  Result := EmptyStr;
  qryGenCfg := VS_FuncoesExternas.fICriaQuery;

  Try
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
    qryGenCfg.Close;
    FreeAndNil(qryGenCfg);
  End;
end;

class function TLibContaBancariaFuncoes.fCriaDataSource(
  DataSet: TDataSet): TDataSource;
begin
  Result := TDataSource.Create(DataSEt);
  Result.DataSet := DataSet;
end;

class function TLibContaBancariaFuncoes.fCriarQuery(strSQL: String;
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

class function TLibContaBancariaFuncoes.fDataAggregate(cdsClient: TUniClientDataSet;
  strNomCam: String): TDateTime;
begin
  If TAggregateField(cdsClient.FieldByName(strNomCam)).Value = Null Then
    Exit(0);

  Result := TAggregateField(cdsClient.FieldByName(strNomCam)).Value;
end;

class function TLibContaBancariaFuncoes.fDatasetDistinctField(objDataSet: TDataSet;
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

class function TLibContaBancariaFuncoes.fDoubleAggregate(cdsClient: TUniClientDataSet;
  strNomCam: String): Double;
begin
  If TAggregateField(cdsClient.FieldByName(strNomCam)).Value = Null Then
    Exit(0);

  Result := TAggregateField(cdsClient.FieldByName(strNomCam)).Value;
end;

class function TLibContaBancariaFuncoes.fEhAdministrador(strCodOpe: String): Boolean;
begin
  Result := MatchStr(strCodOpe, ['997', '998', '999']);
end;

class function TLibContaBancariaFuncoes.fEmpresasTemAcessoPortador(strCodPor: String;
  strCodEmps: TStringList; out strEmpSemAcesso: String): Boolean;
  Var
    strSql, strCodEmp: String;
    qryTmp: TUniQuery;
begin
  strEmpSemAcesso := '';
  qryTmp := VS_FuncoesExternas.fICriaQuery;
  Try
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
    FreeAndNil(qryTmp);
  End;
end;

class function TLibContaBancariaFuncoes.fEmpresaTemAcessoPortador(strCodPor,
  strCodEmp: String): Boolean;
   Var
    strSql: String;
    qryTmp: TUniQuery;
begin
  Result := True;
  qryTmp := VS_FuncoesExternas.fICriaQuery;
  Try
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
    FreeAndNil(qryTmp);
  End;
end;

class function TLibContaBancariaFuncoes.fEmptyStr(strString: String): Boolean;
begin
  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');

  Result := AnsiReplaceText(strString, ' ', '') = '';
end;

class function TLibContaBancariaFuncoes.fExisteConfiguracao(ACodigoCfg,
  ACodigoEmpresa: String): Boolean;
  Var
    strSQL: String;
    qryCfg: TUniQuery;
begin
  qryCfg := VS_FuncoesExternas.fICriaQuery;

  Try
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
    qryCfg.Close;
    FreeAndNil(qryCfg);
  End;
end;

class function TLibContaBancariaFuncoes.fFormataAutInc(intAutInc: Int64; strCodEmp,
  strProEmp: String): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + fPadL(IntToStr(intAutInc) + strCodEmp, 17, '0');
end;

class function TLibContaBancariaFuncoes.fFormataFloat(fltNumero: Double;
  intDecimais: Integer): Double;
begin
  //Se usa SAT entao sempre usa regras de arredondamento ABNT NBR 5891/77
  If Concat(RetornaValorCfg('CFG_USASAT'), RetornaValorCfg('CFG_RAABNT')).Contains('S') Then
    Exit(fArredondaABNT_NBR5891_77(fltNumero, intDecimais));

  Result := fFormataFloatInterna(fltNumero, intDecimais);
end;

class function TLibContaBancariaFuncoes.fFormataFloatInterna(fltNumero: Double;
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

class function TLibContaBancariaFuncoes.fGetConnectionID: String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := VS_FuncoesExternas.fICriaQuery;

  Try

    qryAux.SQL.Add('SELECT CONNECTION_ID()');
    qryAux.Open;

    Result := qryAux.Fields[0].AsString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

class function TLibContaBancariaFuncoes.fGetLetraAlfa(intCol: Integer): String;
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

class function TLibContaBancariaFuncoes.fGetPlanoDeContas(strCodRes: String): String;
begin
  If (Length(Trim(strCodRes)) < 7) Then
  begin
    strCodRes := fStrZero(Trim(strCodRes),5);
    Result := VS_FuncoesExternas.fICampoTabela('CTA_CODCTA', 'CADCTA', ['CTA_CODRES'], [strCodRes], False);
  End;
  Result := IIF(fEmptyStr(Result),strCodRes,Result);
end;

class function TLibContaBancariaFuncoes.fGetPosLetraAlfa(strLetra: String): Integer;
  Const
    ALFA: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
begin
  Result := Pos(strLetra, ALFA);
end;

class function TLibContaBancariaFuncoes.fIntAggregate(cdsClient: TUniClientDataSet;
  strNomCam: String): Integer;
begin
  If TAggregateField(cdsClient.FieldByName(strNomCam)).Value = Null Then
    Exit(0);

  Result := TAggregateField(cdsClient.FieldByName(strNomCam)).Value;
end;

class function TLibContaBancariaFuncoes.fNow: TDateTime;
begin
  Result := IfThen(Trunc(VS_FuncoesExternas.fIGetVS_Date) = 0, nOw(), VS_FuncoesExternas.fIGetVS_Date + fTime());
end;

class function TLibContaBancariaFuncoes.fPadL(strTexto: String; intTamanho: Integer;
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

class function TLibContaBancariaFuncoes.fPadR(strTexto: String; intTamanho: Integer;
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

class function TLibContaBancariaFuncoes.fPortadorPermiteBaixa(
  strCodPor: String): Boolean;
begin
  Result := False;

  If fEmptyStr(strCodPor) Then
    Exit;

  Result := VS_FuncoesExternas.fICampoTabela('POR_PERBAI', 'CADPOR', ['POR_CODPOR'], [strCodPor], False) = 'S';
end;

class function TLibContaBancariaFuncoes.fFindCfg(var ADataset: TUniClientDataset;
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

class function TLibContaBancariaFuncoes.fFloatToInt(fltNumero: Double): Integer;
begin
  Result := StrToIntDef(FloatToStrF(fltNumero, ffFixed, 12, 0), 0);
end;

class function TLibContaBancariaFuncoes.fRetArrToSQLIn(arrValores: TConsultasArray;
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

class function TLibContaBancariaFuncoes.fRetEmpresaFisica: String;
begin
  Result := VS_FuncoesExternas.fICampoTabela('PRO_CODEMP', 'PROCOD', ['PRO_NOMARQ'], ['MOVGER'], False);
end;

class function TLibContaBancariaFuncoes.fRetornaValorConfiguracao(ACodigoConfiguracao,
  ACodigoEmpresa: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  If ACodigoEmpresa.IsEmpty Then
    ACodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

  LConsulta := VS_FuncoesExternas.fICriaQuery;
  Try
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
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class function TLibContaBancariaFuncoes.fRetSomenteNumeros(strTexto: String): String;
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

class function TLibContaBancariaFuncoes.fRetStrToSQLArr(strValores,
  strDelimitador: String): TArray<Variant>;
  Var
    stlListEmp: TStringList;
    intCont_: Integer;
Begin
  stlListEmp := TStringList.Create;

  stlListEmp.Delimiter := '_';
  stlListEmp.DelimitedText := strValores;
  SetLength(Result, stlListEmp.Count);

  For intCont_ := 0 To stlListEmp.Count -1 Do
  Begin
    If  stlListEmp.Strings[intCont_] <> '' Then
      Result[intCont_] := stlListEmp.Strings[intCont_];
  End;

  FreeAndNil(stlListEmp);
end;

class function TLibContaBancariaFuncoes.fRetStrToSQLIn(strValores,
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

class function TLibContaBancariaFuncoes.fSimpleRoundToEX(const AValue: Extended;
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

class function TLibContaBancariaFuncoes.fStrToFloat(strValorUnico: String): Double;
begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',''),0);
end;

class function TLibContaBancariaFuncoes.fStrZero(Zeros: string;
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

class function TLibContaBancariaFuncoes.fTabelaExiste(strNomTab: String): Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SHOW TABLES LIKE ' + QuotedStr(strNomTab);
    LConsulta.Open;
    Result := Not LConsulta.IsEmpty;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class function TLibContaBancariaFuncoes.fTestaCgc(xCGC: String): Boolean;
begin
  Result := TCNPJ.fTestaCNPJ(xCGC, fRetornaValorConfiguracao('CFG_NWCNPJ') = 'S');
end;

class function TLibContaBancariaFuncoes.fTime(const AForceTime: Boolean;
  ADataset: TUniQuery): TDateTime;
begin
  If (AForceTime) Or (Not Assigned(ADataset)) Then
    Result := untLibContaBancariaHorarioSistema.GetTime()
  Else
    Result := untLibContaBancariaHorarioSistema.GetTime(VS_FuncoesExternas.fIRetEmpresaLogada, ADataset.Connection);
end;

class function TLibContaBancariaFuncoes.fTiraCaracEspeciais(strTexto: String;
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
    strLista := '/\-_+#,;<>|*ªº°&"''()%$¨@!?§={}[]´`^~¹²³£¢Ø'
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
    strLista := strLista + 'º';

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüçÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ';

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

class function TLibContaBancariaFuncoes.fValidaCnpjCpf(strCPFCNPJ: String;
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
     VS_FuncoesExternas.fIMensagem('ATENÇÃO', strCPFCNPJ + ' não é um número de '+IfThen(strOpcao='1','CNPJ','CPF')+' válido!', ['&Ok']);
  End
  Else
  Begin
    If (blnMostraMSG) Then
      VS_FuncoesExternas.fIMensagem('ATENÇÃO', 'CPF/CNPJ não informado!', ['&Ok']);
  End;
End;

class function TLibContaBancariaFuncoes.fValidaCnpjCpfDigIgual(strOpcao,
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
      VS_FuncoesExternas.fIMensagem('ATENÇÃO', strValor + ' não é um Número de CPF/CNPJ válido!', ['&Ok']);
  End;
end;

class function TLibContaBancariaFuncoes.fValidaCPF(sCPF: string): Boolean;
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

class function TLibContaBancariaFuncoes.fValidaLinhaGrupoCadCta(
  strLinGru: String): Boolean;
begin
  Result := True;

  If RightStr(strLinGru, 3) = '000' Then
    Result := False;
end;

class function TLibContaBancariaFuncoes.fValidaPeriodo(strDtaIni,
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

class function TLibContaBancariaFuncoes.fVerificaAcessoCartao(
  strCodCar: String): Boolean;
  Var
    strCodEmp: String;
begin
  strCodEmp := VS_FuncoesExternas.fICampoTabela('CAR_CODEMP', 'CADCAR', ['CAR_CODCAR'], [strCodCar]);
  Result    := (fEmptyStr(strCodEmp)) Or (Pos(strCodEmp, VS_FuncoesExternas.fIRetEmpAcessoOperador) > 0);
end;

class procedure TLibContaBancariaFuncoes.GeraListaDeCamposTabelaDelecao(
  var ACamposTabelaDelecao, AParametrosTabelaDelecao: String; ATabela: String);
    Var
      LConsulta: TUniQuery;

      LCampo: TField;
  Begin
    Try
      LConsulta := fCriarQuery('SELECT * FROM DEL_' + ATabela + ' WHERE FALSE');
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
      FreeAndNil(LConsulta);
    End;
  End;

class function TLibContaBancariaFuncoes.GetMD5(const strTexto: string): string;
  Var
    idHash128: TIdHashMessageDigest5;
begin
  Try
    idHash128 := TIdHashMessageDigest5.Create;

    Result := idHash128.HashStringAsHex(strTexto);
  Finally
    FreeAndNil(idHash128);
  End;
end;

class function TLibContaBancariaFuncoes.GravaTabelaDelecao(AFormulario,
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
        LGravarTabelaDelecao.SQL.Text := 'INSERT INTO DEL_' + ATabela + ' (' + LCamposTabelaDelecao + ') ' +
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
    FreeAndNil(LGravarTabelaDelecao);
  End;

End;

class function TLibContaBancariaFuncoes.IIF(ACondicao: Boolean; AValorVerdadeiro,
  AValorFalso: Variant): Variant;
begin
  If ACondicao Then
    Exit(AValorVerdadeiro);

  Result := AValorFalso;
end;

class procedure TLibContaBancariaFuncoes.IniciarProgressoFormGravando(
  AFormgravando: TForm; intProgresso, intMaximo: Integer);
begin
  If VS_FuncoesExternas.fITelaGravandoAntiga Then
  Begin
    If Assigned(TfrmGravandoOld(AFormgravando).pgbStatus) Then
    Begin
      TfrmGravandoOld(AFormgravando).pgbStatus.Visible  := (intProgresso + intMaximo) > 0;
      TfrmGravandoOld(AFormgravando).pgbStatus.Position := intProgresso;
      TfrmGravandoOld(AFormgravando).pgbStatus.properties.Max := intMaximo;
      Application.ProcessMessages;
    End;

  End
  Else
  Begin
    If Assigned(TfrmGravando(AFormgravando).pgbStatus) Then
    Begin
      TfrmGravando(AFormgravando).pgbStatus.Visible  := (intProgresso + intMaximo) > 0;
      TfrmGravando(AFormgravando).pgbStatus.Position := intProgresso;
      TfrmGravando(AFormgravando).pgbStatus.properties.Max := intMaximo;
      Application.ProcessMessages;
    End;
  End;
end;

class function TLibContaBancariaFuncoes.MetodoExiste(AInstancia: IInterface;
  ANomeMetodo: string): Boolean;
  var
    LMetodo: TMethod;
begin
  Result := False;

  LMetodo.Code := nil;
  LMetodo.Data := nil;

  If AInstancia.QueryInterface(ILibContaBancaria, LMetodo.Data) = S_OK then
    Result := Assigned(LMetodo.Code);
end;

class procedure TLibContaBancariaFuncoes.pAddConfigDataSet(
  var ADataset: TUniClientDataset; ACodigoCfg, ACodigoEmpresa: string);
  Var
    LQuery: TUniQuery;
    LIndex: Integer;
begin
  LQuery := VS_FuncoesExternas.fICriaQuery;
  try
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
    LQuery.Close;
    FreeAndNil(LQuery);
  end;
end;

class procedure TLibContaBancariaFuncoes.pCloneData(const objDestino,
  objOrigem: TUniClientDataSet);
begin
  objDestino.Data := objOrigem.Data;
end;

class procedure TLibContaBancariaFuncoes.pCloneDataSet(dtsDestino,
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

class procedure TLibContaBancariaFuncoes.pCriarFormularios(Classe: TComponentClass;
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
    Raise Exception.Create('Erro ao criar o formulário.' + #13 + strMsg);

end;

class procedure TLibContaBancariaFuncoes.pDesmarcaLista(edtCodigo: TCustomEdit;
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

class procedure TLibContaBancariaFuncoes.pDisableControls(dtsDataSet: TDataSet;
  var prcScroll: TprcScroll);
begin
  prcScroll := dtsDataSet.AfterScroll;
  dtsDataSet.AfterScroll := Nil;
  dtsDataSet.DisableControls;
end;

class procedure TLibContaBancariaFuncoes.pEdtCodSelectExit(edtCodigo: TCustomEdit;
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
        VS_FuncoesExternas.fIMensagem('', strCodigo + ' ' + strMsgErr + ' não encontrado.', ['&O K']);
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
      VS_FuncoesExternas.fIMensagem('AVISO', strCodigo + ' '+ strMsgErr + ' não encontrado.', ['&O K']);
      edtCodigo.Clear;
      pSetFocus(edtCodigo);
    End;

  End;
End;

class procedure TLibContaBancariaFuncoes.pEnableControls(dtsDataSet: TDataSet;
  var prcScroll: TprcScroll; blnRefresh: Boolean);
begin
  dtsDataSet.EnableControls;
  dtsDataSet.AfterScroll := prcScroll;
  If blnRefresh then
    dtsDataSet.AfterScroll(dtsDataSet)
end;

class function TLibContaBancariaFuncoes.PlanoDeContasAtivo(ACodCta: String;
  AMsgAlerta: Boolean): Boolean;
  Var
    LQryAux : TUniQuery;
    LSQL    : String;
begin
  If fEmptyStr(ACodCta) Then
    Exit(True);

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
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'O Plano de Contas está Inativo!', ['&Ok']);
      End

    Except
      On E : Exception Do
      Begin
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[untFuncoesSimples.PlanoDeContasInativo]');
      End;
    End;
  Finally
      FreeAndNil(LQryAux);
  End;
end;

class procedure TLibContaBancariaFuncoes.pProcessMessages(ANow: Boolean);
begin
  If ((ANow) Or (MilliSecondsBetween(Now(), FLastProcessMessages) >= 500)) Then
  Begin
    Application.ProcessMessages;
    FLastProcessMessages := Now();
  End;
end;

class procedure TLibContaBancariaFuncoes.pSetFocus(SenderUnico: TWinControl;
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

class procedure TLibContaBancariaFuncoes.pStepStatusGravacao(
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

class function TLibContaBancariaFuncoes.RetiraZerosEsquerda(AString: String): String;
begin
  While AString[1] = '0' do
    Delete(AString,1,1);

  Result := AString;
end;

class function TLibContaBancariaFuncoes.RetornaDataHoraServidor: TDateTime;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT CURRENT_TIMESTAMP AS DATAHORA FROM DUAL';
    LConsulta.Open;

    Result := LConsulta.FieldByName('DATAHORA').AsDateTime;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class function TLibContaBancariaFuncoes.RetornaHoraServidor: TTime;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT CURRENT_TIME AS HORA FROM DUAL';
    LConsulta.Open;

    Result := LConsulta.FieldByName('HORA').AsDateTime;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class function TLibContaBancariaFuncoes.RetornaNomeCentroDeCustos(
  ACodigoEvento: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT EVE_DESEVE FROM CADEVE ';

    if ACodigoEvento.Length > 5 then
      LConsulta.SQL.Add('WHERE EVE_CODCOM = :CODEVE ')
    else
      LConsulta.SQL.Add('WHERE EVE_CODEVE = :CODEVE ');

    LConsulta.ParamByName('CODEVE').AsString := ACodigoEvento;

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit(EmptyStr);

    Result := LConsulta.FieldByName('EVE_DESEVE').AsString;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class function TLibContaBancariaFuncoes.RetornaNomeEmpresa(ACodEmp: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT EMP_NOMEMP FROM CADEMP ' +
                          ' WHERE EMP_CODEMP="' + ACodEmp + '"';
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit(EmptyStr);

    Result := LConsulta.FieldByName('EMP_NOMEMP').AsString;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class function TLibContaBancariaFuncoes.RetornaNomeFornecedor(
  ACodigoFornecedor: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT FOR_NOMFOR FROM CADFOR ' +
                          ' WHERE FOR_CODFOR="' + ACodigoFornecedor + '"';
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit(EmptyStr);

    Result := LConsulta.FieldByName('FOR_NOMFOR').AsString;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class function TLibContaBancariaFuncoes.RetornaNomeOperador(
  ACodigoOperador: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT OPE_NOMOPE FROM CADOPE ' +
                          ' WHERE OPE_CODOPE="' + ACodigoOperador + '"';
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit(EmptyStr);

    Result := LConsulta.FieldByName('OPE_NOMOPE').AsString;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class function TLibContaBancariaFuncoes.RetornaNomePortador(
  ACodigoPortador: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT POR_NOMPOR FROM CADPOR ' +
                          ' WHERE POR_CODPOR="' + ACodigoPortador + '"';
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit(EmptyStr);

    Result := LConsulta.FieldByName('POR_NOMPOR').AsString;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;


class function TLibContaBancariaFuncoes.fMensagem(strTitulo: String;
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
                                            intFormWidth: Integer = 0;
                                            intQtdLinha: Integer = -1;
                                            pProcedureAjuda: TProcedureAjuda = nil): Integer;
begin
  result := TLibContaBancariaFuncoes.fMensagemEx(strTitulo,
                                                 strTexto,
                                                 arrOpcoes,
                                                 intFocoBotao,
                                                 blnSaiComEsc,
                                                 intEstFon,
                                                 intWidBut,
                                                 blnAutosize,
                                                 intSomarTop,
                                                 blnObrigaEsc,
                                                 blnOcultPainelBtn,
                                                 blnBtnSemImg,
                                                 intHeightOpc,
                                                 intFormWidth,
                                                 intQtdLinha);
end;


class function TLibContaBancariaFuncoes.fMensagemEx(strTitulo: String;
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
                                              intFormWidth: Integer = 0;
                                              intQtdLinha: Integer = -1): Integer;
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
  //fntFonte.Style := [fsBold];

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
    arrOpcoes[1] := '&Não';
    intQtdOpcoes := 2;
  End;

  If Trim(arrOpcoes[0]) = '' Then
  Begin
    MessageDlg('É obrigatório a passagem dos parametros em ordem!', mtInformation, [mbOK], 0);
    Result := 0;
    Exit;
  End;

  {********************************}
  {* -> Define Foco para Botao    *}
  {*****************************WI*}
  If ( intFocoBotao <= 0 )           Or
     ( intFocoBotao > intQtdOpcoes ) Then
    intFocoBotao := 1;

  Try

    pCriarFormularios(TfrmMensagem, frmMsg);

    With frmMsg Do
    Begin
      intSomaTop := intSomarTop;
      If (blnAutosize) Then
        WindowState := wsMaximized;

      If intHeightOpc <> 0 Then
        frmMsg.Height := intHeightOpc;

      If ( (ParamCount = 1) And  SameText(ParamStr(1), 'EXPEDICAO_MOTOROLA') ) Then
        blnAutosize := True;
        //intWidBut := 90;

      If strTitulo = '' Then
        strTitulo := 'AVISO';

      If intEstFon = 2 Then
        lblMensagem.Font.Name := 'Courier New';

      If SameText(ParamStr(1), 'VENDA_ASSISTIDA') Then
      Begin
        Height := 300;
        lblMensagem.Font.Size := 20;
        fntFonte.Size  := 18;
        frmMsg.lblTitulo.Font.Size := 18;
        frmMsg.pnlBotoes.Height := 60;
        BtnHeight := 50;
      End;

      lblTitulo.Caption   := strTitulo;
      lblMensagem.Caption := strTexto;

      If intQtdLinha > 0 Then
        frmMsg.Height := frmMsg.Height + (lblMensagem.Canvas.TextHeight('X') * intQtdLinha);

      if intFormWidth > 0 Then
        Width := intFormWidth;

      If intQtdOpcoes = 1 Then
      Begin
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

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
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 2 Then
      Begin
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

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
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

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
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 3 Then
      Begin

        if intFormWidth = 0 Then
        frmMsg.Width := 494;

        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

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
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

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
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

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
            Glyph      := imgbotao3.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
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

  FreeAndNil(frmMsg);
  FreeAndNil(fntFonte);

end;

class function TLibContaBancariaFuncoes.RetornaValorCfg(ACodigoCfg,
  ACodigoEmpresa: String): String;
begin
  If ACodigoEmpresa.IsEmpty Then
    ACodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

  Result := VS_FuncoesExternas.fICampoTabela('SIS_VALCFG',
                                             'CFGSIS',
                                             ['SIS_CODCFG', 'SIS_CODEMP'],
                                             [ACodigoCfg, ACodigoEmpresa])
end;

class procedure TLibContaBancariaFuncoes.SetaValorCampoDataset(
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

initialization
  VS_FuncoesExternas := TLibContaBancariaFactory.Get;

finalization
  VS_FuncoesExternas := Nil;

end.
