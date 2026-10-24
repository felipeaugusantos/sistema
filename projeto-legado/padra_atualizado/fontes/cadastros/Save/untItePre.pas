unit untItePre;

interface

Uses
  DB,
  Uni,
  cxDBVGrid,
  untZClient,
  untFatorPreco,
  untFuncoesSimples,
  untParCalculaPrecoCusto;

Type
  TRecDadosExternos = Record
    qryTabela: TUniQuery;

    strCodGrp,
    strCodAbr,
    strCodFor: String;

    blnPreMat,
    blnPreDol,
    blnPreDolAnterior: Boolean;

    fltPreCom,
    fltDesF01,
    fltDesF02,
    fltDesF03,
    fltDesF04,
    fltDesF05,
    fltDesF06: Double;
  End;

  TItePre = Class
  Private

    intInfFed,
    intInfOpe,
    intInfSai,
    intVenMar,
    intDecUni: Integer;

    fltDolar: Double;

    strMarMkp: String;

    blnInfMat,
    blnFatPre: Boolean;

    objFatPre: TFatorPreco;

    recDados: TRecDadosExternos;

    strEstEmp: String;

    cpcParams: TParCalculaPrecoCusto;

    cdsPreAnt: TZClient;

    Procedure pSetPreCom(fltInfo: Double);
    Procedure pSetDesF01(fltInfo: Double);
    Procedure pSetDesF02(fltInfo: Double);
    Procedure pSetDesF03(fltInfo: Double);
    Procedure pSetDesF04(fltInfo: Double);
    Procedure pSetDesF05(fltInfo: Double);
    Procedure pSetDesF06(fltInfo: Double);
    Procedure pSetCodFor(strInfo: String);
    Procedure pSetCodAbr(strInfo: String);

    Function fSQLPrecos: String;

    function fCalcPrecoVenda(intOpcao: Integer;
                             cdsPrecos: TDataSet;
                             strCodAbr: String;
                             fltPreCom,
                             fltDesF01,
                             fltDesF02,
                             fltDesF03,
                             fltDesF04,
                             fltDesF05,
                             fltDesF06: Double;
                             blnPreDol: Boolean): Double;

    Procedure pCalculaDadosDisplay;
    Procedure pRecalculaPrecosFator(cdsPrecos: TZClient);
    procedure pRecalculaPreco(intPreMar: Integer; cdsPrecos: TZClient);
    Procedure pCriaCdsPreAnt;

    Procedure pAfterScrollPreco(dataSet: TDataSet);

    function fRetPrecoCusto(fltPreCom,
                            fltDesF01,
                            fltDesF02,
                            fltDesF03,
                            fltDesF04,
                            fltDesF05,
                            fltDesF06: Double;
                            cdsPrecos: TDataSet;
                            objConvMoeda: IConversorMoedaCusto): Double;

    function  fCalculaPrecoCompraLiq: Double;

    Function fFiltroTabAtivas: String;

    Procedure pBeforePostPreco(dataSet: TDataSet);
    Procedure pAfterPostPreco(dataSet: TDataSet);
    Procedure pBeforeEditPreco(dataSet: TDataSet);

    function fGetIcmsSTParteVenda(var blnST: Boolean; strCodAbf: String; fltPreComLiq, fltIpiEnt, fltImcSai: Double): Double;

    Procedure pRecalculaPrecoTabelaCorrente(intVenMar: Integer; blnSoDisplay, blnEditar: Boolean);

    Procedure pRecalculaPrecos(intVenMar: Integer; blnSoDisplay: Boolean = False);

    Procedure pRecalculaPrecoIdealCorrente(blnEditar: Boolean = True);
    Procedure pRecalculaMargemIdealCorrente(blnEditar: Boolean = True);

    Procedure pInciaTabelaPrecos;

    Function fGeraItePreEmpresas: Boolean;
    Function fAtualizaItePreEmpresas: Boolean;
    Function fAtualizaItePre(blnResFor: Boolean): Boolean;

    procedure pAtualizaUtilizaPredolEmpNaoUtilizaPrecoMatriz(strCodIte: String);

    procedure pRecalculaPrecoGeral(intPreMar: Integer; cdsPrecos: TDataSet;
                                   strCodAbr: String;
                                   fltPreCom,
                                   fltDesF01,
                                   fltDesF02,
                                   fltDesF03,
                                   fltDesF04,
                                   fltDesF05,
                                   fltDesF06: Double;
                                   blnPreDol: Boolean);

  Public

    cdsPrecos: TZClient;

    cxdPrecos: TcxDBVerticalGrid;

    constructor Create;

    Destructor Destroy; override;

    Function fCarregaPrecos(strCodIte, strCodEmp: String): Boolean;

    Procedure pSetaValoresExternos(APreCom,
                                   ADesF01,
                                   ADesF02,
                                   ADesF03,
                                   ADesF04,
                                   ADesF05,
                                   ADesF06: Double;
                                   ATabela: TUniQuery;
                                   ACodAbr,
                                   ACodFor: String;
                                   APreMat,
                                   APreDol: Boolean);

    Procedure pAplicaValorPrecos(arrCampos: Array Of String; arrValues: Array Of Double);

    Function fGravaTabelaPrecos(strCodIte, strCodEmp: String; blnIncluao: Boolean): Boolean;

    function fValidaMargem(fltMargem, fltComissao, fltIcmSai, fltImpFed, fltDesOpe: Double): Boolean;

    Class Function fAtualizaItensGrupoPrecos(strCodIte, strNomFrm: String): Boolean;

    property fltPreCom: Double Read recDados.fltPrecom Write pSetPrecom;
    property fltDesF01: Double Read recDados.fltPrecom Write pSetDesF01;
    property fltDesF02: Double Read recDados.fltPrecom Write pSetDesF02;
    property fltDesF03: Double Read recDados.fltPrecom Write pSetDesF03;
    property fltDesF04: Double Read recDados.fltPrecom Write pSetDesF04;
    property fltDesF05: Double Read recDados.fltPrecom Write pSetDesF05;
    property fltDesF06: Double Read recDados.fltPrecom Write pSetDesF06;

    property strCodAbr: String Read recDados.strCodAbr Write pSetCodAbr;
    property strCodFor: String Read recDados.strCodFor Write pSetCodFor;

    property blnPreDol: Boolean Read recDados.blnPreDol Write recDados.blnPreDol;
  End;

implementation

Uses
  Math,
  SysUtils,
  StrUtils,
  Classes,
  untTConfiguracao,
  untIcmsSTParteVenda;

Const
   MAX_TABELA_PRECO = 7;

constructor TItePre.Create;
Begin
  cxdPrecos := Nil;

  FillChar(recDados, Sizeof(recDados), #0);

  strMarMkp := fCfgSis('MARMKP');
  intDecUni := fCfgSis('DECUNI', varInteger);
  intVenMar := fCfgSis('VENMAR', varInteger);

  blnInfMat := fCfgSis('INFMAT', varBoolean);

  intInfFed := fCfgSis('INFFED', varInteger);
  intInfOpe := fCfgSis('INFOPE', varInteger);
  intInfSai := fCfgSis('INFSAI', varInteger);

  strEstEmp := fCadEmp('ESTADO');

  cdsPrecos := TZClient.Create(Nil, fSQLPrecos);

  pCriaCdsPreAnt;

  objFatPre := Nil;
  blnFatPre := fCfgSis('FATPRE', varBoolean);

  If blnFatPre Then
  Begin
    objFatPre := TFatorPreco.Create;
    cdsPrecos.AfterScroll := pAfterScrollPreco;
  End;

  cpcParams := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao, True, True);

  fltDolar := fGetUltimaCotacaoDolarVenda;
End;

Destructor TItePre.Destroy;
Begin
  If Assigned(cdsPrecos) Then
    FreeAndNil(cdsPrecos);

  If Assigned(cdsPreAnt) Then
    FreeAndNil(cdsPreAnt);

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);
End;

Function TItePre.fFiltroTabAtivas: String;
  Var
    sltLista: TStringList;
    intContador: Integer;
Begin
  sltLista := TStringList.Create;

  For intContador := 1 To Length(VS_strTabPrc) Do
    If VS_strTabPrc[intContador] = 'S' Then
      sltLista.Add(IntToStr(intContador));

  Result := 'ITE_TABELA IN (' + fCommaText(sltLista) + ')';

  FreeAndNil(sltLista);
End;

Procedure TItePre.pCriaCdsPreAnt;
Begin
  cdsPreAnt := TZClient.Create(Nil, fSQLPrecos);
  cdsPreAnt.fLeDados('TItePre.pCriaCdsPreAnt');
End;

Function TItePre.fSQLPrecos: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT     ';
  strSQL := strSQL + '   I.*,     ';

  strSQL := strSQL + '   0.0000 AS MARMK3,  ';
  strSQL := strSQL + '   0.0000 AS CUSREA,  ';
  strSQL := strSQL + '   0.0000 AS LUCLIQ,  ';
  strSQL := strSQL + '   0.0000 AS PREIDE,  ';
  strSQL := strSQL + '   0.0000 AS PREDOL   ';

  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   ITEPRE I ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '       ITE_CODITE = :CODITE ';
  strSQL := strSQL + '   AND ITE_CODEMP = :CODEMP ';

  Result := strSQL;
End;

Procedure TItePre.pInciaTabelaPrecos;
  Var
    intTabelas,
    intCampos: Integer;
Begin
  For intTabelas := 1 To MAX_TABELA_PRECO Do
  Begin
    cdsPrecos.Insert;
    cdsPrecos.FieldByName('ITE_TABELA').AsInteger := intTabelas;

    For intCampos := 0 To cdsPrecos.FieldCount -1 Do
      If cdsPrecos.Fields[intCampos].DataType = ftFloat Then
        cdsPrecos.Fields[intCampos].AsFloat := 0;

    cdsPrecos.Post;
  End;
End;

Procedure TItePre.pSetaValoresExternos(APreCom,
                                       ADesF01,
                                       ADesF02,
                                       ADesF03,
                                       ADesF04,
                                       ADesF05,
                                       ADesF06: Double;
                                       ATabela: TUniQuery;
                                       ACodAbr,
                                       ACodFor: String;
                                       APreMat,
                                       APreDol: Boolean);

Begin
  recDados.fltPreCom := APreCom;
  recDados.fltDesF01 := ADesF01;
  recDados.fltDesF02 := ADesF02;
  recDados.fltDesF03 := ADesF03;
  recDados.fltDesF04 := ADesF04;
  recDados.fltDesF05 := ADesF05;
  recDados.fltDesF06 := ADesF06;

  recDados.qryTabela := ATabela;
  recDados.strCodAbr := ACodAbr;
  recDados.strCodFor := ACodFor;
  recDados.blnPreMat := APreMat;
  recDados.blnPreDol := APreDol;
  recDados.blnPreDolAnterior := APreDol;
End;

Function TItePre.fCarregaPrecos(strCodIte, strCodEmp: String): Boolean;
Begin
  With cdsPrecos Do
  Begin
    qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
    qryQuery.ParamByName('CODITE').AsString := strCodIte;

    Result := fLeDados('TItePre.fCarregaPrecos');

    If Result Then
    Begin
      cdsPrecos.Filter   := fFiltroTabAtivas;
      cdsPrecos.Filtered := True;

      IndexFieldNames := 'ITE_TABELA';
      pAlinhaCampoCentro('ITE_TABELA');

      pFormataDecimal('LUCLIQ', intDecUni);
      pFormataDecimal('PREDOL', intDecUni);
      pFormataDecimal('PREIDE', intDecUni);
      pFormataDecimal('CUSREA', intDecUni);

      BeforePost := Nil;
      AfterPost  := Nil;
      BeforeEdit := Nil;

      If IsEmpty Then
        pInciaTabelaPrecos;

      pRecalculaPrecos(intVenMar, False {True});
    End;

    BeforeEdit := pBeforeEditPreco;
    BeforePost := pBeforePostPreco;
    AfterPost  := pAfterPostPreco;
  End;
End;

procedure TItePre.pSetPreCom(fltInfo: Double);
Begin
  If fltInfo <> recDados.fltPreCom Then
  Begin
    recDados.fltPreCom := fltInfo;

    pRecalculaPrecos(intVenMar);
  End;
End;

Procedure TItePre.pSetDesF01(fltInfo: Double);
Begin
  If fltInfo <> recDados.fltDesF01 Then
  Begin
    recDados.fltDesF01 := fltInfo;

    pRecalculaPrecos(intVenMar);
  End;
End;

Procedure TItePre.pSetDesF02(fltInfo: Double);
Begin
  If fltInfo <> recDados.fltDesF02 Then
  Begin
    recDados.fltDesF02 := fltInfo;

    pRecalculaPrecos(intVenMar);
  End;
End;

Procedure TItePre.pSetDesF03(fltInfo: Double);
Begin
  If fltInfo <> recDados.fltDesF03 Then
  Begin
    recDados.fltDesF03 := fltInfo;

    pRecalculaPrecos(intVenMar);
  End;
End;

Procedure TItePre.pSetDesF04(fltInfo: Double);
Begin
  If fltInfo <> recDados.fltDesF04 Then
  Begin
    recDados.fltDesF04 := fltInfo;

    pRecalculaPrecos(intVenMar);
  End;
End;

Procedure TItePre.pSetDesF05(fltInfo: Double);
Begin
  If fltInfo <> recDados.fltDesF05 Then
  Begin
    recDados.fltDesF05 := fltInfo;

    pRecalculaPrecos(intVenMar);
  End;
End;

Procedure TItePre.pSetDesF06(fltInfo: Double);
Begin
  If fltInfo <> recDados.fltDesF06 Then
  Begin
    recDados.fltDesF06 := fltInfo;

    pRecalculaPrecos(intVenMar);
  End;
End;

Procedure TItePre.pSetCodFor(strInfo: String);
Begin
  If strInfo <> recDados.strCodFor Then
  Begin
    recDados.strCodFor := strInfo;

    pRecalculaPrecos(intVenMar);
  End;
End;

Procedure TItePre.pSetCodAbr(strInfo: String);
Begin
  If strInfo <> recDados.strCodAbr Then
  Begin
    recDados.strCodAbr := strInfo;

    pRecalculaPrecos(intVenMar);
  End;
End;

function TItePre.fRetPrecoCusto(fltPreCom,
                                fltDesF01,
                                fltDesF02,
                                fltDesF03,
                                fltDesF04,
                                fltDesF05,
                                fltDesF06: Double;
                                cdsPrecos: TDataSet;
                                objConvMoeda: IConversorMoedaCusto): Double;
begin
  Try
    {**********************************}
    {* CALCULA PREÇOS DE CUSTO        *}
    {*******************************JB*}
    With cpcParams  Do
    Begin
      curPreCom := fltPreCom;
      curDesF01 := fltDesF01;
      curDesF02 := fltDesF02;
      curDesF03 := fltDesF03;
      curDesF04 := fltDesF04;
      curDesF05 := fltDesF05;
      curDesF06 := fltDesF06;

      curICMSEnt:= cdsPrecos.FieldByName('ITE_ICMENT').AsFloat;
      curIPIEnt := cdsPrecos.FieldByName('ITE_IPIENT').AsFloat;
      curFrete  := cdsPrecos.FieldByName('ITE_FREENT').AsFloat;
      curAcrFin := cdsPrecos.FieldByName('ITE_ACRFIN').AsFloat;
      curSubsti := cdsPrecos.FieldByName('ITE_SUBSTI').AsFloat;
      curValFre := cdsPrecos.FieldByName('ITE_VALFRE').AsFloat;
      curDesAdb := cdsPrecos.FieldByName('ITE_DESADB').AsFloat;
      curSubFed := cdsPrecos.FieldByName('ITE_SUBFED').AsFloat;
    End;

    Result := cpcParams.fCalculaPrecoCusto(objConvMoeda);

  Finally

  End;

end;

function TItePre.fCalculaPrecoCompraLiq: Double;
Begin
  With recDados Do
  Result := untfuncoesSimples.fCalculaPrecoCompraLiq(fltPreCom,
                                                     fltDesF01,
                                                     fltDesF02,
                                                     fltDesF03,
                                                     fltDesF04,
                                                     fltDesF05,
                                                     fltDesF06,
                                                     blnPreDol);
End;

function TItePre.fGetIcmsSTParteVenda(var blnST: Boolean; strCodAbf: String; fltPreComLiq, fltIpiEnt, fltImcSai: Double): Double;
  Var
    strCodSit : String;
begin
  Result := 0.00;
  blnST := False;

  If (strMarMkp = '4') And (Not fEmptyStr(strCodAbf)) Then
  Begin
    strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [strCodAbf, strEstEmp]);
    Result := untIcmsSTParteVenda.fGetIcmsSTParteVenda(strCodAbf, '_SAI_CCO', strCodSit, strEstEmp, fltPreComLiq, fltIpiEnt, fltImcSai, strEstEmp, blnST, strMarMkp);
  End;
end;

function TItePre.fCalcPrecoVenda(intOpcao: Integer; cdsPrecos: TDataSet; strCodAbr: String;
                                 fltPreCom,
                                 fltDesF01,
                                 fltDesF02,
                                 fltDesF03,
                                 fltDesF04,
                                 fltDesF05,
                                 fltDesF06: Double;
                                 blnPreDol: Boolean): Double;
  Var
    blnST: Boolean;
    fltIcmsSTParteVenda : Double;
Begin
  If (intOpcao = 2 {Margem}) Or (Not blnFatPre) Or (cdsPrecos.FieldByName('ITE_TABELA').AsInteger = 1) Then
  Begin
    fltIcmsSTParteVenda := fGetIcmsSTParteVenda(blnST,
                                                strCodAbr,
                                                untfuncoesSimples.fCalculaPrecoCompraLiq(fltPreCom,
                                                     fltDesF01,
                                                     fltDesF02,
                                                     fltDesF03,
                                                     fltDesF04,
                                                     fltDesF05,
                                                     fltDesF06,
                                                     blnPreDol),
                                                cdsPrecos.FieldByName('ITE_IPIENT').AsFloat,
                                                cdsPrecos.FieldByName('ITE_ICMSAI').AsFloat);

    Result := fCalculaPrecoVenda(intOpcao,
                                 cdsPrecos.FieldByName('ITE_PRECUS').AsFloat + cdsPrecos.FieldByName('ITE_OUTVAL').AsFloat,
                                 cdsPrecos.FieldByName('ITE_PREVEN').AsFloat,
                                 cdsPrecos.FieldByName('ITE_MARBRU').AsFloat,
                                 cdsPrecos.FieldByName('ITE_ICMSAI').AsFloat,
                                 cdsPrecos.FieldByName('ITE_IMPFED').AsFloat,
                                 cdsPrecos.FieldByName('ITE_DESOPE').AsFloat,
                                 cdsPrecos.FieldByName('ITE_COMISS').AsFloat,
                                 '',
                                 '',
                                 -1,
                                 fltIcmsSTParteVenda,
                                 blnST);
  End

  Else If intOpcao = 1 Then
    Result := cdsPrecos.FieldByName('ITE_PREVEN').AsFloat

  Else Result := cdsPrecos.FieldByName('ITE_MARBRU').AsFloat;
End;

procedure TItePre.pRecalculaPreco(intPreMar: Integer; cdsPrecos: TZClient);
begin
  If recDados.blnPreMat Then
    Exit;

  With recDados Do
  pRecalculaPrecoGeral(intPreMar,
                       cdsPrecos,
                       strCodAbr,
                       fltPreCom,
                       fltDesF01,
                       fltDesF02,
                       fltDesF03,
                       fltDesF04,
                       fltDesF05,
                       fltDesF06,
                       blnPreDol);

  pCalculaDadosDisplay;
End;

procedure TItePre.pRecalculaPrecoGeral(intPreMar: Integer; cdsPrecos: TDataSet;
                                         strCodAbr: String;
                                         fltPreCom,
                                         fltDesF01,
                                         fltDesF02,
                                         fltDesF03,
                                         fltDesF04,
                                         fltDesF05,
                                         fltDesF06: Double;
                                         blnPreDol: Boolean);
  Var
    objConvMoeda: TConversorMoedaCusto;
begin
  If recDados.blnPreDol Then
    objConvMoeda := TConversorMoedaCusto.Create
  Else
    objConvMoeda := Nil;

  With cdsPrecos Do
  Begin
    FieldByName('ITE_PRECUS').AsFloat := fRetPrecoCusto(fltPreCom,
                                                        fltDesF01,
                                                        fltDesF02,
                                                        fltDesF03,
                                                        fltDesF04,
                                                        fltDesF05,
                                                        fltDesF06,
                                                        cdsPrecos,
                                                        objConvMoeda);

    If (intPreMar = 1) Or
       ((recDados.qryTabela.State In [dsInsert]) And (FieldByName('ITE_PREVEN').AsFloat = 0)) Then
    Begin
      FieldByName('ITE_PREVEN').AsFloat := fCalCPrecoVenda(1,
                                                           cdsPrecos,
                                                           strCodAbr,
                                                           fltPreCom,
                                                           fltDesF01,
                                                           fltDesF02,
                                                           fltDesF03,
                                                           fltDesF04,
                                                           fltDesF05,
                                                           fltDesF06,
                                                           blnPreDol);
    End
    Else
    Begin
      FieldByName('ITE_MARBRU').AsFloat := fCalcPrecoVenda(2,
                                                           cdsPrecos,
                                                           strCodAbr,
                                                           fltPreCom,
                                                           fltDesF01,
                                                           fltDesF02,
                                                           fltDesF03,
                                                           fltDesF04,
                                                           fltDesF05,
                                                           fltDesF06,
                                                           blnPreDol);
    End;
  End;

end;

Procedure TItePre.pCalculaDadosDisplay;
Begin
  With cdsPrecos Do
  Begin
    If Not (State In dsEditModes) Then
      Exit;

    FieldByName('CUSREA').AsFloat := untfuncoesSimples.fCalculaCustoReal(
                                       FieldByName('ITE_PRECUS').AsFloat,
                                       FieldByName('ITE_ICMSAI').AsFloat,
                                       FieldByName('ITE_IMPFED').AsFloat,
                                       FieldByName('ITE_DESOPE').AsFloat,
                                       FieldByName('ITE_OUTVAL').AsFloat);

    FieldByName('LUCLIQ').AsFloat := FieldByName('ITE_PREVEN').AsFloat - FieldByName('CUSREA').AsFloat;

    pRecalculaPrecoIdealCorrente(False);

    If fltDolar > 0 Then
      FieldByName('PREDOL').AsFloat := FieldByName('ITE_PREVEN').AsFloat / fltDolar;

    If strMarMkp = '3' Then
      FieldByName('MARMK3').AsFloat := fMarkupToMargem(FieldByName('ITE_MARBRU').AsFloat);
  End;
End;

Procedure TItePre.pRecalculaPrecoIdealCorrente(blnEditar: Boolean = True);
Begin
  With cdsPrecos Do
  Begin
    If blnEditar Then
      Edit;

    FieldByName('PREIDE').AsFloat := fCalculaPrecoVenda(1,
                                        FieldByName('ITE_PRECUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                        0,
                                        FieldByName('ITE_MARIDE').AsFloat,
                                        FieldByName('ITE_ICMSAI').AsFloat,
                                        FieldByName('ITE_IMPFED').AsFloat,
                                        FieldByName('ITE_DESOPE').AsFloat,
                                        FieldByName('ITE_COMISS').AsFloat);

    If blnEditar Then
      Post;
  End;
End;

Procedure TItePre.pRecalculaMargemIdealCorrente(blnEditar: Boolean = True);
Begin
  With cdsPrecos Do
  Begin
    If blnEditar Then
      Edit;

    FieldByName('ITE_MARIDE').AsFloat := fCalculaPrecoVenda(2,
                                            FieldByName('ITE_PRECUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                            FieldByName('PREIDE').AsFloat,
                                            0,
                                            FieldByName('ITE_ICMSAI').AsFloat,
                                            FieldByName('ITE_IMPFED').AsFloat,
                                            FieldByName('ITE_DESOPE').AsFloat,
                                            FieldByName('ITE_COMISS').AsFloat);

    If blnEditar Then
      Post;
  End;
End;

Procedure TItePre.pRecalculaPrecoTabelaCorrente(intVenMar: Integer; blnSoDisplay, blnEditar: Boolean);
Begin
  With cdsPrecos Do
  Begin
    If blnEditar Then
      Edit;

    If blnSoDisplay Then
      pCalculaDadosDisplay
    Else
      pRecalculaPreco(intVenMar, cdsPrecos);

    If blnEditar Then
      Post;

  End;
End;

Procedure TItePre.pRecalculaPrecos(intVenMar: Integer; blnSoDisplay: Boolean = False);
Begin
  With cdsPrecos Do
  Begin
    DisableControls;

    Filtered := False;

    First;

    While Not Eof Do
    Begin
      Edit;

      pRecalculaPrecoTabelaCorrente(intVenMar, blnSoDisplay, False);

      Post;

      If blnFatPre Then
        Break;

      Next;
    End;

    Filtered := True;

    First;

    EnableControls;
  End;

End;

Function TItePre.fGravaTabelaPrecos(strCodIte, strCodEmp: String; blnIncluao: Boolean): Boolean;
  Var
    strAutInc: String;
Begin
  Result := False;

  If (Not fEmptyStr(cdsPrecos.FieldByName('ITE_CODITE').AsString)) And
     (strCodIte <> cdsPrecos.FieldByName('ITE_CODITE').AsString) Then
  Begin
    pMensagemOk('Erro interno na gravação do produto!');
    Exit;
  End;

  strAutInc := fRetAutoIncrem('MOVDET', VS_strCodEmp, cdsPrecos.RecordCount);

  cdsPrecos.DisableControls;

  cdsPrecos.Filtered := False;

  cdsPrecos.First;
  While Not cdsPrecos.Eof do
  Begin
    cdsPrecos.Edit;

    cdsPrecos.FieldByName('AUTOINCREM').AsString := strAutInc;
    cdsPrecos.FieldByName('ITE_CODITE').AsString := strCodIte;
    cdsPrecos.FieldByName('ITE_CODEMP').AsString := strCodEmp;
    cdsPrecos.Post;

    cdsPrecos.Next;

    strAutInc := fNextAutoIncrem(strAutInc);
  End;

  Result := cdsPrecos.fSalva;

  If Result Then
  Begin
    If blnIncluao Then
      Result := fGeraItePreEmpresas
    Else
      Result := fAtualizaItePreEmpresas;
  End;

  cdsPrecos.Filtered := True;

  cdsPrecos.EnableControls;
End;

Procedure TItePre.pBeforeEditPreco(dataSet: TDataSet);
  Var
    intContador: Integer;
Begin
  If cdsPreAnt.IsEmpty Then
    cdsPreAnt.Insert
  Else
    cdsPreAnt.Edit;

  For intContador := 0 To cdsPreAnt.Fields.Count - 1 Do
    cdsPreAnt.Fields[intContador].Value := cdsPrecos.Fields[intContador].Value;

  cdsPreAnt.Post;
End;

Procedure TItePre.pAfterPostPreco(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    AfterPost := Nil;

    If blnFatPre And (FieldByName('ITE_TABELA').AsInteger = 1) Then
      pRecalculaPrecosFator(cdsPrecos);

    AfterPost := pAfterPostPreco;
  End;

End;

Procedure TItePre.pRecalculaPrecosFator(cdsPrecos: TZClient);
  Var
    fltIcmsSTParteVenda : Double;
    blnST : Boolean;
    fltPreVen: Double;
    blnDesabilita: Boolean;
Begin
  If Not blnFatPre Then
    Exit;

  blnDesabilita := Not cdsPrecos.ControlsDisabled;

  If blnDesabilita Then
    cdsPrecos.DisableControls;

  fltPreVen := cdsPrecos.FieldByName('ITE_PREVEN').AsFloat;

  cdsPrecos.Filter := 'ITE_TABELA <> 1';

  cdsPrecos.First;

  While Not cdsPrecos.Eof Do
  Begin
    cdsPrecos.Edit;

    cdsPrecos.FieldByName('ITE_PREVEN').AsFloat :=
      objFatPre.fCalculaPrecoVendaFator(fltPreVen, cdsPrecos.FieldByName('ITE_TABELA').AsInteger);

    fltIcmsSTParteVenda := fGetIcmsSTParteVenda(blnST,
                                                recDados.strCodAbr,
                                                fCalculaPrecoCompraLiq,
                                                cdsPrecos.FieldByName('ITE_IPIENT').AsFloat,
                                                cdsPrecos.FieldByName('ITE_ICMSAI').AsFloat);

    cdsPrecos.FieldByName('ITE_MARBRU').AsFloat :=
      fCalculaPrecoVenda(2,
                         cdsPrecos.FieldByName('ITE_PRECUS').AsFloat + cdsPrecos.FieldByName('ITE_OUTVAL').AsFloat,
                         cdsPrecos.FieldByName('ITE_PREVEN').AsFloat,
                         0,
                         cdsPrecos.FieldByName('ITE_ICMSAI').AsFloat,
                         cdsPrecos.FieldByName('ITE_IMPFED').AsFloat,
                         cdsPrecos.FieldByName('ITE_DESOPE').AsFloat,
                         cdsPrecos.FieldByName('ITE_COMISS').AsFloat,
                         '',
                         '',
                         -1,
                         fltIcmsSTParteVenda,
                         blnST);

    cdsPrecos.Post;

    cdsPrecos.Next;
  End;

  cdsPrecos.Filter   := fFiltroTabAtivas;
  cdsPrecos.Filtered := True;

  cdsPrecos.First;

  If blnDesabilita Then
    cdsPrecos.EnableControls;
End;

Procedure TItePre.pBeforePostPreco(dataSet: TDataSet);
Begin
  If cdsPreAnt.FieldByName('PREIDE').Value <> cdsPrecos.FieldByName('PREIDE').Value Then
    pRecalculaMargemIdealCorrente(False)

  Else If cdsPreAnt.FieldByName('ITE_MARIDE').Value <> cdsPrecos.FieldByName('ITE_MARIDE').Value Then
    pRecalculaPrecoIdealCorrente(False)

  Else If (cdsPreAnt.FieldByName('ITE_PREVEN').Value <> cdsPrecos.FieldByName('ITE_PREVEN').Value) Then
    pRecalculaPrecoTabelaCorrente(2, False, False)

  Else If (cdsPreAnt.FieldByName('ITE_MARBRU').Value <> cdsPrecos.FieldByName('ITE_MARBRU').Value) Then
    pRecalculaPrecoTabelaCorrente(1, False, False)

  Else If (cdsPreAnt.FieldByName('ITE_ICMENT').Value <> cdsPrecos.FieldByName('ITE_ICMENT').Value) Or
          (cdsPreAnt.FieldByName('ITE_SUBFED').Value <> cdsPrecos.FieldByName('ITE_SUBFED').Value) Or
          (cdsPreAnt.FieldByName('ITE_IPIENT').Value <> cdsPrecos.FieldByName('ITE_IPIENT').Value) Or
          (cdsPreAnt.FieldByName('ITE_FREENT').Value <> cdsPrecos.FieldByName('ITE_FREENT').Value) Or
          (cdsPreAnt.FieldByName('ITE_VALFRE').Value <> cdsPrecos.FieldByName('ITE_VALFRE').Value) Or
          (cdsPreAnt.FieldByName('ITE_ACRFIN').Value <> cdsPrecos.FieldByName('ITE_ACRFIN').Value) Or
          (cdsPreAnt.FieldByName('ITE_SUBSTI').Value <> cdsPrecos.FieldByName('ITE_SUBSTI').Value) Or
          (cdsPreAnt.FieldByName('ITE_DESADB').Value <> cdsPrecos.FieldByName('ITE_DESADB').Value) Or
          (cdsPreAnt.FieldByName('ITE_OUTVAL').Value <> cdsPrecos.FieldByName('ITE_OUTVAL').Value) Or
          (cdsPreAnt.FieldByName('ITE_ICMSAI').Value <> cdsPrecos.FieldByName('ITE_ICMSAI').Value) Or
          (cdsPreAnt.FieldByName('ITE_IMPFED').Value <> cdsPrecos.FieldByName('ITE_IMPFED').Value) Or
          (cdsPreAnt.FieldByName('ITE_DESOPE').Value <> cdsPrecos.FieldByName('ITE_DESOPE').Value) Or
          (cdsPreAnt.FieldByName('ITE_COMISS').Value <> cdsPrecos.FieldByName('ITE_COMISS').Value) Then
    pRecalculaPrecoTabelaCorrente(intVenMar, False, False);
End;

Function TItePre.fGeraItePreEmpresas: Boolean;
  Var
    intContador: Integer;

    strEmpresas,
    strAutInc  : String;

    qryCadEmp  : TUniQuery;
    cdsPreEmp  : TZClient;

    fltIcmsSTParteVenda : Double;
    blnST : Boolean;

  function fRetPrecoCustoInclusao: Double;
    Var
      objConversorMoeda: TConversorMoedaCusto;
  begin
    Try

      With cpcParams, cdsPreEmp Do
      Begin
        curPreCom := FieldByName('ITE_PRECOM').AsFloat;
        curDesF01 := FieldByName('ITE_DESF01').AsFloat;
        curDesF02 := FieldByName('ITE_DESF02').AsFloat;
        curDesF03 := FieldByName('ITE_DESF03').AsFloat;
        curDesF04 := FieldByName('ITE_DESF04').AsFloat;
        curDesF05 := FieldByName('ITE_DESF05').AsFloat;
        curDesF06 := FieldByName('ITE_DESF06').AsFloat;
        curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
        curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
        curFrete  := FieldByName('ITE_FREENT').AsFloat;
        curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
        curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
        curValFre := FieldByName('ITE_VALFRE').AsFloat;
        curDesAdb := FieldByName('ITE_DESADB').AsFloat;
        curSubFed := FieldByName('ITE_SUBFED').AsFloat;
      End;

      objConversorMoeda := Nil;
      If recDados.blnPreDol Then
      Begin
        objConversorMoeda := TConversorMoedaCusto.Create;
      End;

      Result := cpcParams.fCalculaPrecoCusto(objConversorMoeda);

      If Assigned(objConversorMoeda) Then
        FreeAndNil(objConversorMoeda);
    Finally

    End;
  End;

  Procedure pCarregaEmpresas;
    Var
      strSQL: String;
  Begin
    qryCadEmp := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP <> :CODEMP ';

    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;
  End;

begin
  Result := False;

  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  cdsPreEmp := TZClient.Create(Nil, fSQLPrecos);

  If Not cdsPreEmp.fLeDados('TItePre.fGeraItePreEmpresas') Then
    Exit;

  pCarregaEmpresas;

  strAutInc := fRetAutoIncrem('ITEGER', VS_strCodEmp, qryCadEmp.RecordCount * cdsPrecos.RecordCount);

  While Not qryCadEmp.Eof Do
  Begin
    cdsPreEmp.Insert;

    For intContador := 0 To cdsPrecos.FieldCount -1 Do
      cdsPreEmp.Fields[intContador].Value := cdsPrecos.Fields[intContador].Value;

    If Not fCfgSis('CONIPI', varBoolean, qryCadEmp.FieldByName('EMP_CODEMP').AsString) Then
    Begin
      cdsPreEmp.FieldByName('ITE_IPISAI').AsFloat := 0.0;
    End;

    cdsPreEmp.FieldByName('ITE_CODEMP').AsString  := qryCadEmp.FieldByName('EMP_CODEMP').AsString; // Código da Empresa...
    cdsPreEmp.FieldByName('AUTOINCREM').AsString  := strAutInc;

    If blnInfMat And fValidaEscala(qryCadEmp.FieldByName('EMP_TABPAD').AsString,  1 , Length(VS_strTabPrc)) Then
    Begin
      // É POR EMPRESA OU NÃO É DO GRUPO
      If (intInfSai = 1) Or (Pos(qryCadEmp.FieldByName('EMP_CODEMP').AsString, strEmpresas) = 0) Then // PEGA DA PROPRIA EMPRESA - CASO CONTRARIO JÁ FOI PREENCHIDO ACIMA
        cdsPreEmp.FieldByName('ITE_ICMSAI').AsFloat := qryCadEmp.FieldByName('EMP_ICMSAI').AsFloat;

      If (intInfFed = 1) Or (Pos(qryCadEmp.FieldByName('EMP_CODEMP').AsString, strEmpresas) = 0) Then // PEGA DA PROPRIA EMPRESA - CASO CONTRARIO JÁ FOI PREENCHIDO ACIMA
        cdsPreEmp.FieldByName('ITE_IMPFED').AsFloat := qryCadEmp.FieldByName('EMP_IMPFED').AsFloat;

      If (intInfOpe = 1) Or (Pos(qryCadEmp.FieldByName('EMP_CODEMP').AsString, strEmpresas) = 0) Then // PEGA DA PROPRIA EMPRESA - CASO CONTRARIO JÁ FOI PREENCHIDO ACIMA
        cdsPreEmp.FieldByName('ITE_DESOPE').AsFloat := qryCadEmp.FieldByName('EMP_DESOPE').AsFloat;

      If (Not fEhEmpresaResponsavelFornecedor(recDados.strCodFor)) And (Pos(qryCadEmp.FieldByName('EMP_CODEMP').AsString, strEmpresas) = 0) Then
      Begin
        cdsPreEmp.FieldByName('ITE_ICMENT').AsFloat := qryCadEmp.FieldByName('EMP_ICMENT').AsFloat;
        cdsPreEmp.FieldByName('ITE_SUBFED').AsFloat := qryCadEmp.FieldByName('EMP_SUBFED').AsFloat;
        cdsPreEmp.FieldByName('ITE_PRECUS').AsFloat := fRetPrecoCustoInclusao;
      End;

      fltIcmsSTParteVenda := fGetIcmsSTParteVenda(blnST,
                                                  recDados.strCodAbr,
                                                  untfuncoesSimples.fCalculaPrecoCompraLiq(
                                                     cdsPreEmp.FieldByName('ITE_PRECOM').AsFloat,
                                                     cdsPreEmp.FieldByName('ITE_DESF01').AsFloat,
                                                     cdsPreEmp.FieldByName('ITE_DESF02').AsFloat,
                                                     cdsPreEmp.FieldByName('ITE_DESF03').AsFloat,
                                                     cdsPreEmp.FieldByName('ITE_DESF04').AsFloat,
                                                     cdsPreEmp.FieldByName('ITE_DESF05').AsFloat,
                                                     cdsPreEmp.FieldByName('ITE_DESF06').AsFloat,
                                                     recDados.blnPreDol),
                                                  cdsPreEmp.FieldByName('ITE_IPIENT').AsFloat,
                                                  cdsPreEmp.FieldByName('ITE_ICMSAI').AsFloat);

      cdsPreEmp.FieldByName('ITE_MARBRU').AsFloat :=
              fCalculaPrecoVenda(2,
                                 cdsPreEmp.FieldByName('ITE_PRECUS').AsFloat + cdsPreEmp.FieldByName('ITE_OUTVAL').AsFloat,
                                 cdsPreEmp.FieldByName('ITE_PREVEN').AsFloat,
                                 cdsPreEmp.FieldByName('ITE_MARBRU').AsFloat,
                                 cdsPreEmp.FieldByName('ITE_ICMSAI').AsFloat,
                                 cdsPreEmp.FieldByName('ITE_IMPFED').AsFloat,
                                 cdsPreEmp.FieldByName('ITE_DESOPE').AsFloat,
                                 cdsPreEmp.FieldByName('ITE_COMISS').AsFloat,
                                 '',
                                 '',
                                 -1,
                                 fltIcmsSTParteVenda,
                                 blnST);
    End;

    cdsPreEmp.Post;

    qryCadEmp.Next;

    strAutInc := fNextAutoIncrem(strAutInc);
  End;

  Result := cdsPreEmp.fSalva;

  FreeAndNil(qryCadEmp);
  FreeAndNil(cdsPreEmp);
end;


Function TItePre.fAtualizaItePre(blnResFor: Boolean): Boolean;
  Var
    strEmpresas: String;
    stlEmpresas: TStringList;
    cdsItePre: TZClient;
    intIndex: Integer;
begin
  Result := True;

  If recDados.blnPreMat Then
    Exit;

  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  If strEmpresas = (VS_strCodEmp + '_') Then
    Exit;

  stlEmpresas := TStringList.Create;
  stlEmpresas.Text := AnsiReplaceStr(strEmpresas, '_', #13#10);
  stlEmpresas.Sorted := True;

  If stlEmpresas.Find(VS_strCodEmp, intIndex) Then
    stlEmpresas.Delete(intIndex);

  cdsItePre := TZClient.Create(Nil, 'SELECT * FROM ITEPRE WHERE ITE_CODITE = :CODITE AND ITE_CODEMP ' +
                                      IIF(blnResFor, ' NOT ', '') + 'IN (' +  fCommaText(stlEmpresas, True)  + ')');

  cdsItePre.qryQuery.ParamByName('CODITE').AsString := cdsPrecos.FieldByName('ITE_CODITE').AsString;

  If cdsItePre.fLeDados('TItePre.fAtualizaItePre') Then
  Begin
    Result := False;
    Exit;
  End;

  While Not cdsItePre.Eof Do
  Begin

    If cdsPrecos.FindKey([cdsItePre.FieldByName('ITE_TABELA').AsInteger]) Then
    Begin
      cdsItePre.Edit;

      cdsItePre.FieldByName('ITE_IPIENT').AsFloat := cdsPrecos.FieldByName('ITE_IPIENT').AsFloat;
      cdsItePre.FieldByName('ITE_FREENT').AsFloat := cdsPrecos.FieldByName('ITE_FREENT').AsFloat;
      cdsItePre.FieldByName('ITE_VALFRE').AsFloat := cdsPrecos.FieldByName('ITE_VALFRE').AsFloat;
      cdsItePre.FieldByName('ITE_PRECUS').AsFloat := cdsPrecos.FieldByName('ITE_PRECUS').AsFloat;
      cdsItePre.FieldByName('ITE_ACRFIN').AsFloat := cdsPrecos.FieldByName('ITE_ACRFIN').AsFloat;
      cdsItePre.FieldByName('ITE_ICMENT').AsFloat := cdsPrecos.FieldByName('ITE_ICMENT').AsFloat;
      cdsItePre.FieldByName('ITE_SUBFED').AsFloat := cdsPrecos.FieldByName('ITE_SUBFED').AsFloat;
      cdsItePre.FieldByName('ITE_DESADB').AsFloat := cdsPrecos.FieldByName('ITE_DESADB').AsFloat;

      If Not blnResFor Then
      Begin
        If (Not blnInfMat) Or (intInfFed = 2) Then
          cdsItePre.FieldByName('ITE_IMPFED').AsFloat := cdsPrecos.FieldByName('ITE_IMPFED').AsFloat;

        If (Not blnInfMat) Or (intInfOpe = 2) Then
          cdsItePre.FieldByName('ITE_DESOPE').AsFloat := cdsPrecos.FieldByName('ITE_DESOPE').AsFloat;

        If (Not blnInfMat) Or (intInfSai = 2) Then
          cdsItePre.FieldByName('ITE_ICMSAI').AsFloat := cdsPrecos.FieldByName('ITE_ICMSAI').AsFloat;

        cdsItePre.FieldByName('ITE_OUTVAL').AsFloat  := cdsPrecos.FieldByName('ITE_OUTVAL').AsFloat;

        If fCfgSis('IPI_IG') = '1' Then
          cdsItePre.FieldByName('ITE_IPISAI').AsFloat := cdsPrecos.FieldByName('ITE_IPISAI').AsFloat;

        cdsItePre.FieldByName('ITE_MARBRU').AsFloat := cdsPrecos.FieldByName('ITE_MARBRU').AsFloat;
        cdsItePre.FieldByName('ITE_COMISS').AsFloat := cdsPrecos.FieldByName('ITE_COMISS').AsFloat;
        cdsItePre.FieldByName('ITE_PREVEN').AsFloat := cdsPrecos.FieldByName('ITE_PREVEN').AsFloat;
      End;

      If blnInfMat Then
        cdsItePre.FieldByName('ITE_MARBRU').AsFloat :=
           fCalculaPrecoVenda(2,
                              cdsItePre.FieldByName('ITE_PRECUS').AsFloat + cdsItePre.FieldByName('ITE_OUTVAL').AsFloat,
                              cdsItePre.FieldByName('ITE_PREVEN').AsFloat,
                              cdsItePre.FieldByName('ITE_MARBRU').AsFloat,
                              cdsItePre.FieldByName('ITE_ICMSAI').AsFloat,
                              cdsItePre.FieldByName('ITE_IMPFED').AsFloat,
                              cdsItePre.FieldByName('ITE_DESOPE').AsFloat,
                              cdsItePre.FieldByName('ITE_COMISS').AsFloat);
      cdsItePre.Post;
    End;

    cdsItePre.Next;
  End;

  If recDados.blnPreDolAnterior <> recDados.blnPreDol Then
    pAtualizaUtilizaPredolEmpNaoUtilizaPrecoMatriz(cdsPrecos.FieldByName('ITE_CODITE').AsString);

  Result := cdsItePre.fSalva;

  FreeAndNil(cdsItePre);
End;

Function TItePre.fAtualizaItePreEmpresas: Boolean;
Begin
  Result := fAtualizaItePre(False);

  If Result And blnInfMat And fEhEmpresaResponsavelFornecedor(recDados.strCodFor) Then
    Result := fAtualizaItePre(True);
End;

procedure TItePre.pAtualizaUtilizaPredolEmpNaoUtilizaPrecoMatriz(strCodIte: String);
  var
    strEmpresas: string;
    intVenMarCfg: integer;
    qryIteger,
    qryItePre: TUniQuery;

    Function fSQLIteger: String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';

      If fCfgSis('TIPABF') = '2' Then
        strSQL := strSQL + '   G.ITE_CODABF, '
      Else
        strSQL := strSQL + '   C.ITE_CODABF, ';

      strSQL := strSQL + '   G.ITE_PREDOL, ';
      strSQL := strSQL + '   G.ITE_PRECOM, ';
      strSQL := strSQL + '   G.ITE_DESF01, ';
      strSQL := strSQL + '   G.ITE_DESF02, ';
      strSQL := strSQL + '   G.ITE_DESF03, ';
      strSQL := strSQL + '   G.ITE_DESF04, ';
      strSQL := strSQL + '   G.ITE_DESF05, ';
      strSQL := strSQL + '   G.ITE_DESF06  ';
      strSQL := strSQL + ' FROM           ';
      strSQL := strSQL + '   ITEGER G     ';

      strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE    ';

      strSQL := strSQL + ' WHERE          ';
      strSQL := strSQL + '   G.ITE_CODITE = :CODITE AND G.ITE_CODEMP = :COPDEMP  ';

      Result := strSQL;
    End;

begin
  strEmpresas := fStringSQLLocateToStringSQLIN(fRetEmpresasUsamPrecoMatriz);
  qryIteger := fCriaQuery;
  qryIteger.SQL.Text := fSQLIteger;

  qryItePre := fCriaQuery;

  Try
    qryItePre.SQL.Add('SELECT * FROM ITEPRE');
    qryItePre.SQL.Add(' WHERE ITE_CODITE  = ' + QuotedStr(strCodIte));
    qryIteger.SQL.Add('   AND ITE_CODEMP NOT IN (' + strEmpresas + ')');
    qryItePre.Open;

    While not qryItePre.Eof Do
    Begin

      qryIteger.Close;
      qryIteger.ParamByName('CODITE').AsString := strCodIte;
      qryIteger.ParamByName('CODEMP').AsString := qryItePre.FieldByName('ITE_CODEMP').AsString;
      qryIteger.Open;

      If (Not qryIteger.IsEmpty) And
         (qryIteger.FieldByName('ITE_PREDOL').AsString <> IIf(recDados.blnPreDol, 'S', 'N')) Then
      Begin

        intVenMarCfg := fCfgSis('VENMAR', varInteger, qryItePre.FieldByName('ITE_CODEMP').AsString);

        If fCfgSis('COTDOR', varBoolean, qryItePre.FieldByName('ITE_CODEMP').AsString) Then
        Begin
          qryItePre.Edit;

          pRecalculaPrecoGeral(intVenMarCfg,
                               qryItePre,
                               qryIteger.FieldByName('ITE_CODABF').AsString, // ??? DEVERIA SER DA EMPRESA CORRENTE?
                               qryIteger.FieldByName('ITE_PRECOM').AsFloat,
                               qryIteger.FieldByName('ITE_DESF01').AsFloat,
                               qryIteger.FieldByName('ITE_DESF02').AsFloat,
                               qryIteger.FieldByName('ITE_DESF03').AsFloat,
                               qryIteger.FieldByName('ITE_DESF04').AsFloat,
                               qryIteger.FieldByName('ITE_DESF05').AsFloat,
                               qryIteger.FieldByName('ITE_DESF06').AsFloat,
                               qryIteger.FieldByName('ITE_PREDOL').AsString = 'S');

          qryItePre.Post;
        End;

      End;

      qryItePre.Next;
    End;

  Finally
    FreeAndNil(qryItePre);
    FreeAndNil(qryIteger);
  End;

end;

Class Function TItePre.fAtualizaItensGrupoPrecos(strCodIte, strNomFrm: String): Boolean;
  Var
    qryIteGru,
    qryItens: TUniQuery;
    cdsUpdate: TZClient;
Begin
  Result   := True;

  qryItens := fCriaQuery;

  qryItens.SQL.Text := 'SELECT * FROM ITEPRE WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
  qryItens.ParamByName('CODITE').AsString := strCodIte;
  qryItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryItens.Open;
  qryItens.IndexFieldNames := 'ITE_TABELA';

  qryIteGru := fCriaQuery;
  qryIteGru.SQL.Text := 'SELECT ITE_CODITE FROM CADITE WHERE ITE_CODGPR  = (SELECT C.ITE_CODGPR FROM CADITE C ON C.ITE_CODITE = :CODITE) ';
  qryIteGru.ParamByName('CODITE').AsString := strCodIte;
  qryIteGru.Open;

  cdsUpdate := TZClient.Create(Nil, 'SELECT * FROM ITEPRE WHERE     ' +
                                    '                           ITE_CODEMP IN (' + fStringSQLLocateToStringSQLIN(fRetEmpresasUsamPrecoMatriz) + ') ' +
                                    '                       AND ITE_CODITE = :CODITE');

  While Not qryIteGru.Eof Do
  Begin

    cdsUpdate.ParamByName('CODITE').AsString :=  qryIteGru.FieldByName('ITE_CODITE').AsString;

    If cdsUpdate.fLeDados('TItePre.pAtualizaItensGrupoPrecos') Then
    Begin

      While Not cdsUpdate.Eof Do
      Begin

        If qryItens.FindKey([cdsUpdate.FieldByName('ITE_TABELA').AsString]) Then
        Begin
          cdsUpdate.Edit;

          cdsUpdate.FieldByName('ITE_ICMENT').Value := qryItens.FieldByName('ITE_ICMENT').Value;
          cdsUpdate.FieldByName('ITE_SUBFED').Value := qryItens.FieldByName('ITE_SUBFED').Value;
          cdsUpdate.FieldByName('ITE_IPIENT').Value := qryItens.FieldByName('ITE_IPIENT').Value;
          cdsUpdate.FieldByName('ITE_FREENT').Value := qryItens.FieldByName('ITE_FREENT').Value;
          cdsUpdate.FieldByName('ITE_VALFRE').Value := qryItens.FieldByName('ITE_VALFRE').Value;
          cdsUpdate.FieldByName('ITE_ACRFIN').Value := qryItens.FieldByName('ITE_ACRFIN').Value;
          cdsUpdate.FieldByName('ITE_SUBSTI').Value := qryItens.FieldByName('ITE_SUBSTI').Value;
          cdsUpdate.FieldByName('ITE_DESADB').Value := qryItens.FieldByName('ITE_DESADB').Value;
          cdsUpdate.FieldByName('ITE_PRECUS').Value := qryItens.FieldByName('ITE_PRECUS').Value;
          cdsUpdate.FieldByName('ITE_OUTVAL').Value := qryItens.FieldByName('ITE_OUTVAL').Value;
          cdsUpdate.FieldByName('ITE_ICMSAI').Value := qryItens.FieldByName('ITE_ICMSAI').Value;
          cdsUpdate.FieldByName('ITE_IMPFED').Value := qryItens.FieldByName('ITE_IMPFED').Value;
          cdsUpdate.FieldByName('ITE_DESOPE').Value := qryItens.FieldByName('ITE_DESOPE').Value;
          cdsUpdate.FieldByName('ITE_MARBRU').Value := qryItens.FieldByName('ITE_MARBRU').Value;
          cdsUpdate.FieldByName('ITE_MARIDE').Value := qryItens.FieldByName('ITE_MARIDE').Value;
          cdsUpdate.FieldByName('ITE_COMISS').Value := qryItens.FieldByName('ITE_COMISS').Value;
          cdsUpdate.FieldByName('ITE_PREVEN').Value := qryItens.FieldByName('ITE_PREVEN').Value;
        End;

        // GRAVAR PREALT

        cdsUpdate.Next;
      End; {While Not cdsUpdate.Eof Do}

      Result := cdsUpdate.fSalva;

    End;

    qryIteGru.Next;
  End; {While Not qryIteGru.Eof Do}

  FreeAndNil(qryItens);
  FreeAndNil(qryIteGru);
  FreeAndNil(cdsUpdate);
End;

Procedure TItePre.pAplicaValorPrecos(arrCampos: Array Of String; arrValues: Array Of Double);
  Var
    intContador: Integer;
Begin
  With cdsPrecos Do
  Begin
    DisableControls;

    Filtered := False;

    First;

    While Not Eof Do
    Begin
      Edit;

      For intContador := Low(arrCampos) To High(arrCampos) Do
        cdsPrecos.FieldByName(arrCampos[intContador]).Value := arrValues[intContador];

      pRecalculaPrecoTabelaCorrente(intVenMar, False, False);

      Post;

      If blnFatPre Then
        Break;

      Next;
    End;

    First;

    Filtered := True;

    EnableControls;
  End;

End;

function TItePre.fValidaMargem(fltMargem, fltComissao, fltIcmSai, fltImpFed, fltDesOpe: Double): Boolean;
begin
  Result := Not (fltMargem + fltComissao + fltIcmSai + fltImpFed + fltDesOpe > 100);
End;

Procedure TItePre.pAfterScrollPreco(dataSet: TDataSet);
Begin

  If blnFatPre And Assigned(cxdPrecos) Then
    cxdPrecos.OptionsData.Editing := dataSet.FieldByName('ITE_TABELA').AsInteger = 1;

End;

// DÚVIDAS
// - PREÇO IDEAL, MARGEM IDEAL, RECALCULO INFMAT NÃO ESTÃO CALCULANDO ICMS OPÇÃO MARMKP = 4 - MARKUP RITEC
// - strMarMkp - ATUALIZAÇÃO DO DOLAR ESTÁ PEGANDO DA EMPRESA LOGADA OPÇÃO MARMKP = 4 - MARKUP RITEC

end.
