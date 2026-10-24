unit untQckEspelhoNota;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, untFuncoesSimples, Uni,
  frxDMPExport, UniClientDataSet, Variants, DB, StrUtils, untEntFreConLista,
  Controls, untFuncoesGenerica, untEntVendor, untEntOutrasDespesas,
  untEspelhoNota, Datasnap.DBClient, untTipoFreteAtc,Forms;

type
  TfrmQckEspelhoNota = class(TForm)
    frxRelEspelhoNotaM: TfrxReport;
    frxRelEspelhoNotaJ: TfrxReport;
    frxGen: TfrxUserDataSet;
    frxRelatorio: TfrxDBDataset;
    frxMatricial: TfrxDotMatrixExport;
    cdsGNRE: TUniClientDataSet;
    cdsGNREGNR_CODFOR: TStringField;
    cdsGNREGNR_NUMGNR: TStringField;
    cdsGNREGNR_VALGNR: TFloatField;
    frxGNRE: TfrxDBDataset;
    frxRelEspelhoComPrecosJ: TfrxReport;
    frxRelEspelhoComPrecosM: TfrxReport;
    frxDBConFre: TfrxDBDataset;
    cdsGNREGNR_DTAVEN: TDateField;
    procedure DataModuleCreate(Sender: TObject);
    function frxRelEspelhoNotaMUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
    procedure DataModuleDestroy(Sender: TObject);
  private
    qryCadPag: TUniQuery;

    FPais: TPais;

    fltTotVarD,
    fltTotVarF,
    fltTotVarG: Double;

    strDocAnt,
    strForAnt: String;

    Function fVariacaoD: Double;
    Function fVariacaoG: Double;
    Function fVariacaoF: Double;
    Function fVariacao: Double;
    
    function fPercFrete(fltTotIte, fltTotFre, fltTotCon, fltTotAnt: Double): Double;
    function fRetVendorNota(strNotTip: String): String;
    function fRetIcmsAntecipado: String;
    Function fRetSomaConhecimento(fltValCon: Double): Double;

    function fRetOutrasDespesas: String;
    
    function fCalculaValPercentual( curPrecom, curDesF01, curDesF02,
    curDesF03, curDesF04, curDesF05, curDesF06, curAcrFin, curUnitar, curUniPed : Double ) : String;
    function fVisualizaParcela( strEspDoc, strNumDoc, strSerie, strCodFor : String) : String;
    function fRetCentroCustoDoc: String;
    function fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal: Double): String;
    function fMontaGNRE: Boolean;
    function fCondPagtoConhecimentoFrete(strNumDoc, strSerie, strCodFor, strCodEmp: String; dtaDtaDoc: TDate): String;

    function fTemConhecimentoFrete(strAutGer, strEspDoc: String): Boolean;
    function fRetModalidadeFrete(intModalidade: Integer): string;

    function fDuplicatasConhecimentoFrete(strNumDoc, strEspDoc, strSerie, strCodFor: String): String;
    function fCalculaMargem(fltPreCus, fltPreVen: Double): Double;

    Procedure pCarregaDuplicatasConhecFrete(strNumDoc, strSerie, strCodFor, strCodEmp: String);

    function fFormataConPag: String;

    { Private declarations }
  public
    intOpcVariacao: Integer;
    intOpc     : Integer;

    stlConPag  : TStringList;

    strCodEmp  : String;
    strTipCalc : String;
    strTipImp  : String;
    intOpcSelec: Integer;
    arrParcelas: TParcelasArray;
    strFrase: String;
    objLisFre: TFreConLista;
    objVendor: TEntVendor;
    objEspNot: TEspNota;
    objOutDes: TEntOutrasDespesas;
    { Public declarations }

    function fRetVendor: String;
  end;


implementation

uses Math, untConstantes, untEntFreCon, untPcmGer, untTypesSistema;

{$R *.dfm}

procedure TfrmQckEspelhoNota.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  stlConPag := TStringList.Create;

  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  fltTotVarD := 0;
  fltTotVarF := 0;
  fltTotVarG := 0;

  strDocAnt := '';
  strForAnt := '';

  FPais := fSetaPais;
  qryCadPag := fCriaQuery(Self);

  objLisFre    := Nil;

  frxRelEspelhoNotaM.AddFunction('function fPercFrete(fltTotIte, fltTotFre, fltTotCon, fltTotAnt: Double): Double;');
  frxRelEspelhoNotaM.AddFunction('function fFormataCondPag(strCond: String): String;');
  frxRelEspelhoNotaM.AddFunction('function fRetVendor: String;');
  frxRelEspelhoNotaM.AddFunction('function fRetIcmsAntecipado: String;');
  frxRelEspelhoNotaM.AddFunction('function fRetOutrasDespesas: String;');
  frxRelEspelhoNotaM.AddFunction('function fCalculaValorCompra(curPreCom, curDesF01, curDesF02, curDesF03,curDesF04, curDesF05, curDesF06, curAcrFin : Double ): Double;');
  frxRelEspelhoNotaM.AddFunction('function fCalculaValPercentual(curPrecom, curDesF01, curDesF02, curDesF03, curDesF04, curDesF05, curDesF06, curAcrFin, curUnitar, curUniPed : Double) : String;');
  frxRelEspelhoNotaM.AddFunction('function fVisualizaParcela( strEspDoc, strNumDoc, strSerie, strCodFor : String) : String');
  frxRelEspelhoNotaM.AddFunction('function fRetCentroCustoDoc: String;');
  frxRelEspelhoNotaM.AddFunction('function fFormataCpfCgc(strCGCCPF: String; intTipo: Integer): String;');
  frxRelEspelhoNotaM.AddFunction('function fMontaGNRE: Boolean;');
  frxRelEspelhoNotaM.AddFunction('function fOpcRel: integer;');
  frxRelEspelhoNotaM.AddFunction('function fCondPagtoConhecimentoFrete(strNumDoc, strSerie, strCodFor, strCodEmp: String; dtaDtaDoc: TDate): String;');
  frxRelEspelhoNotaM.AddFunction('function fTemConhecimentoFrete(strAutGer, strEspDoc: String): Boolean;');
  frxRelEspelhoNotaM.AddFunction('function fRetModalidadeFrete(intModalidade: Integer): String;');


  frxRelEspelhoNotaM.AddFunction('function fDuplicatasConhecimentoFrete(strNumDoc, strEspDoc, strSerie, strCodFor: String): String;');
  frxRelEspelhoNotaM.AddFunction('function fStrToFloat(strValor: String): Double;');
  frxRelEspelhoNotaM.AddFunction('function fCalculaMargem(fltPreCus, fltPreVen: Double): Double;');
  frxRelEspelhoNotaM.AddFunction('Function fVariacao: Double;');
  frxRelEspelhoNotaM.AddFunction('Function fVariacaoD: Double;');
  frxRelEspelhoNotaM.AddFunction('Function fVariacaoG: Double;');
  frxRelEspelhoNotaM.AddFunction('Function fVariacaoF: Double;');
  frxRelEspelhoNotaM.AddFunction('Function fRetSomaConhecimento(fltValCon: Double): Double;');
  frxRelEspelhoNotaM.AddFunction('function fFormataConPag: String;');

  frxRelEspelhoNotaj.AddFunction('function fPercFrete(fltTotIte, fltTotFre, fltTotCon, fltTotAnt: Double): Double;');
  frxRelEspelhoNotaJ.AddFunction('function fFormataCondPag(strCond: String): String;');
  frxRelEspelhoNotaJ.AddFunction('function fRetVendor: String;');
  frxRelEspelhoNotaJ.AddFunction('function fRetIcmsAntecipado: String;');
  frxRelEspelhoNotaJ.AddFunction('function fRetOutrasDespesas: String;');
  frxRelEspelhoNotaJ.AddFunction('function fCalculaValorCompra( curPreCom, curDesF01, curDesF02, curDesF03,curDesF04, curDesF05, curDesF06, curAcrFin: Double ): Double;');
  frxRelEspelhoNotaJ.AddFunction('function fCalculaValPercentual(curPrecom, curDesF01, curDesF02, curDesF03, curDesF04, curDesF05, curDesF06, curAcrFin, curUnitar, curUniPed : Double) : String;');
  frxRelEspelhoNotaJ.AddFunction('function fVisualizaParcela( strEspDoc, strNumDoc, strSerie, strCodFor : String) : String');
  frxRelEspelhoNotaJ.AddFunction('function fRetCentroCustoDoc: String;');
  frxRelEspelhoNotaJ.AddFunction('function fFormataCpfCgc(strCGCCPF: String; intTipo: Integer): String;');
  frxRelEspelhoNotaJ.AddFunction('function fMontaGNRE: Boolean');
  frxRelEspelhoNotaJ.AddFunction('function fOpcRel: integer;');
  frxRelEspelhoNotaJ.AddFunction('function fCondPagtoConhecimentoFrete(strNumDoc, strSerie, strCodFor, strCodEmp: String; dtaDtaDoc: TDate): String;');
  frxRelEspelhoNotaJ.AddFunction('function fTemConhecimentoFrete(strAutGer, strEspDoc: String): Boolean;');
  frxRelEspelhoNotaJ.AddFunction('function fRetModalidadeFrete(intModalidade: Integer): string;');

  frxRelEspelhoNotaJ.AddFunction('function fDuplicatasConhecimentoFrete(strNumDoc, strEspDoc, strSerie, strCodFor: String): String;');
  frxRelEspelhoNotaJ.AddFunction('function fStrToFloat(strValor: String): Double;');
  frxRelEspelhoNotaJ.AddFunction('function fCalculaMargem(fltPreCus, fltPreVen: Double): Double;');
  frxRelEspelhoNotaJ.AddFunction('Function fVariacao: Double;');
  frxRelEspelhoNotaJ.AddFunction('Function fVariacaoD: Double;');
  frxRelEspelhoNotaJ.AddFunction('Function fVariacaoG: Double;');
  frxRelEspelhoNotaJ.AddFunction('Function fVariacaoF: Double;');
  frxRelEspelhoNotaJ.AddFunction('Function fRetSomaConhecimento(fltValCon: Double): Double;');
  frxRelEspelhoNotaJ.AddFunction('function fFormataConPag: String;');

  frxRelEspelhoComPrecosJ.AddFunction('function fPercFrete(fltTotIte, fltTotFre, fltTotCon, fltTotAnt: Double): Double;');
  frxRelEspelhoComPrecosJ.AddFunction('function fFormataCondPag(strCond: String): String;');
  frxRelEspelhoComPrecosJ.AddFunction('function fRetVendor: String;');
  frxRelEspelhoComPrecosJ.AddFunction('function fRetIcmsAntecipado: String;');
  frxRelEspelhoComPrecosJ.AddFunction('function fRetOutrasDespesas: String;');
  frxRelEspelhoComPrecosJ.AddFunction('function fCalculaValorCompra( curPreCom, curDesF01, curDesF02, curDesF03,curDesF04, curDesF05, curDesF06, curAcrFin: Double ): Double;');
  frxRelEspelhoComPrecosJ.AddFunction('function fCalculaValPercentual(curPrecom, curDesF01, curDesF02, curDesF03, curDesF04, curDesF05, curDesF06, curAcrFin, curUnitar, curUniPed : Double) : String;');
  frxRelEspelhoComPrecosJ.AddFunction('function fVisualizaParcela( strEspDoc, strNumDoc, strSerie, strCodFor : String) : String');
  frxRelEspelhoComPrecosJ.AddFunction('function fRetCentroCustoDoc: String;');
  frxRelEspelhoComPrecosJ.AddFunction('function fFormataCpfCgc(strCGCCPF: String; intTipo: Integer): String;');
  frxRelEspelhoComPrecosJ.AddFunction('function fMontaGNRE: Boolean');
  frxRelEspelhoComPrecosJ.AddFunction('function fOpcRel: integer;');
  frxRelEspelhoComPrecosJ.AddFunction('function fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal: Double): String;');
  frxRelEspelhoComPrecosJ.AddFunction('function fCondPagtoConhecimentoFrete(strNumDoc, strSerie, strCodFor, strCodEmp: String; dtaDtaDoc: TDate): String;');
  frxRelEspelhoComPrecosJ.AddFunction('function fTemConhecimentoFrete(strAutGer, strEspDoc: String): Boolean;');
  frxRelEspelhoComPrecosJ.AddFunction('function fRetModalidadeFrete(intModalidade: Integer): string;');
  frxRelEspelhoComPrecosJ.AddFunction('function fDuplicatasConhecimentoFrete(strNumDoc, strEspDoc, strSerie, strCodFor: String): String;');
  frxRelEspelhoComPrecosJ.AddFunction('function fStrToFloat(strValor: String): Double;');
  frxRelEspelhoComPrecosJ.AddFunction('function fCalculaMargem(fltPreCus, fltPreVen: Double): Double;');
  frxRelEspelhoComPrecosM.AddFunction('Function fVariacao: Double;');
  frxRelEspelhoComPrecosM.AddFunction('Function fVariacaoD: Double;');
  frxRelEspelhoComPrecosM.AddFunction('Function fVariacaoG: Double;');
  frxRelEspelhoComPrecosM.AddFunction('Function fVariacaoF: Double;');
  frxRelEspelhoComPrecosM.AddFunction('Function fRetSomaConhecimento(fltValCon: Double): Double;');
  frxRelEspelhoComPrecosM.AddFunction('function fFormataConPag: String;');

  frxRelEspelhoComPrecosM.AddFunction('function fPercFrete(fltTotIte, fltTotFre, fltTotCon, fltTotAnt: Double): Double;');
  frxRelEspelhoComPrecosM.AddFunction('function fFormataCondPag(strCond: String): String;');
  frxRelEspelhoComPrecosM.AddFunction('function fRetVendor: String;');
  frxRelEspelhoComPrecosM.AddFunction('function fRetIcmsAntecipado: String;');
  frxRelEspelhoComPrecosM.AddFunction('function fRetOutrasDespesas: String;');
  frxRelEspelhoComPrecosM.AddFunction('function fCalculaValorCompra( curPreCom, curDesF01, curDesF02, curDesF03,curDesF04, curDesF05, curDesF06, curAcrFin: Double ): Double;');
  frxRelEspelhoComPrecosM.AddFunction('function fCalculaValPercentual(curPrecom, curDesF01, curDesF02, curDesF03, curDesF04, curDesF05, curDesF06, curAcrFin, curUnitar, curUniPed : Double) : String;');
  frxRelEspelhoComPrecosM.AddFunction('function fVisualizaParcela( strEspDoc, strNumDoc, strSerie, strCodFor : String) : String');
  frxRelEspelhoComPrecosM.AddFunction('function fRetCentroCustoDoc: String;');
  frxRelEspelhoComPrecosM.AddFunction('function fFormataCpfCgc(strCGCCPF: String; intTipo: Integer): String;');
  frxRelEspelhoComPrecosM.AddFunction('function fMontaGNRE: Boolean');
  frxRelEspelhoComPrecosM.AddFunction('function fOpcRel: integer;');
  frxRelEspelhoComPrecosM.AddFunction('function fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal: Double): String;');
  frxRelEspelhoComPrecosM.AddFunction('function fCondPagtoConhecimentoFrete(strNumDoc, strSerie, strCodFor, strCodEmp: String; dtaDtaDoc: TDate): String;');
  frxRelEspelhoComPrecosM.AddFunction('function fTemConhecimentoFrete(strAutGer, strEspDoc: String): Boolean;');
  frxRelEspelhoComPrecosM.AddFunction('function fRetModalidadeFrete(intModalidade: Integer): string;');

  frxRelEspelhoComPrecosM.AddFunction('function fDuplicatasConhecimentoFrete(strNumDoc, strEspDoc, strSerie, strCodFor: String): String;');
  frxRelEspelhoComPrecosM.AddFunction('function fStrToFloat(strValor: String): Double;');
  frxRelEspelhoComPrecosM.AddFunction('function fCalculaMargem(fltPreCus, fltPreVen: Double): Double;');
  frxRelEspelhoComPrecosJ.AddFunction('Function fVariacao: Double;');
  frxRelEspelhoComPrecosJ.AddFunction('Function fVariacaoD: Double;');
  frxRelEspelhoComPrecosJ.AddFunction('Function fVariacaoG: Double;');
  frxRelEspelhoComPrecosJ.AddFunction('Function fVariacaoF: Double;');
  frxRelEspelhoComPrecosJ.AddFunction('Function fRetSomaConhecimento(fltValCon: Double): Double;');
  frxRelEspelhoComPrecosJ.AddFunction('function fFormataConPag: String;');

  TfrxMemoView(frxRelEspelhoNotaJ.FindObject('rllZebra')).Highlight.Color          := fCfgSis('CORZEB');
  TfrxMemoView(frxRelEspelhoNotaJ.FindObject('rdbQtdIte')).DisplayFormat.FormatStr := fMskDigitos(fCfgSis('DEQTEM', varInteger));
  TfrxMemoView(frxRelEspelhoNotaM.FindObject('rdbQtdIte')).DisplayFormat.FormatStr := fMskDigitos(fCfgSis('DEQTEM', varInteger));

  TfrxMemoView(frxRelEspelhoComPrecosJ.FindObject('rllZebra')).Highlight.Color          := fCfgSis('CORZEB');
  TfrxMemoView(frxRelEspelhoComPrecosJ.FindObject('rdbQtdIte')).DisplayFormat.FormatStr := fMskDigitos(fCfgSis('DEQTEM', varInteger));

  cdsGNRE.CreateDataSet;
  cdsGNRE.Open;
end;

function TfrmQckEspelhoNota.frxRelEspelhoNotaMUserFunction(
  const MethodName: String; var Params: Variant): Variant;
   Var
     strValor: String;
begin

  If SameText(MethodName, 'FSTRTOFLOAT') Then
  Begin
    strValor := Trim(Params[0]);
    Delete(strValor, Length(strValor), 1);
    Result := fStrToFloat(strValor);
  End;

  If MethodName = 'FFORMATACONDPAG' Then
    Result := fFormataCondPag(Params[0]);

  If SameText(MethodName, 'fRetVendor') Then
    Result := fRetVendor;

  If SameText(MethodName, 'fRetIcmsAntecipado') Then
    Result := fRetIcmsAntecipado;

  If SameText(MethodName, 'fRetOutrasDespesas') Then
    Result := fRetOutrasDespesas;

  If MethodName = 'FCALCULAVALORCOMPRA' Then
    Result := fCalculaValorCompra(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5],Params[6],Params[7]);

  if MethodName = 'FCALCULAVALPERCENTUAL' Then
    Result := fCalculaValPercentual(Params[0],Params[1],Params[2],Params[3],Params[4],Params[5],Params[6],Params[7],Params[8],Params[9]);

  If MethodName = 'FCALCULACUSTOREAL' Then
    Result := fCalculaCustoReal(Params[0],Params[1],Params[2],Params[3],Params[4]);

  if MethodName = 'FVISUALIZAPARCELA' Then
    Result := fVisualizaParcela(Params[0],Params[1],Params[2],Params[3]);

  if SameText(MethodName, 'fRetCentroCustoDoc') Then
    Result := fRetCentroCustoDoc;

  if MethodName = 'FFORMATACPFCGC' Then
  Begin
    If Params[1] = 1 Then
      Result := 'CNPJ: ' + fFormataCpfCgc(Params[0], FPais)
    Else
      Result := 'C.P.F: ' + fFormataCpfCgc(Params[0], FPais);
  End;

  if SameText(MethodName,'fMontaGNRE') Then
    Result := fMontaGNRE;

  if SameText(MethodName,'fOpcRel') Then
    Result := intOpcSelec;

  If SameText(MethodName,'fCondPagtoConhecimentoFrete') Then
    Result := fCondPagtoConhecimentoFrete(Params[0], Params[1], Params[2], Params[3], Params[4]);

  If SameText(MethodName, 'fTemConhecimentoFrete') Then
    Result := fTemConhecimentoFrete(Params[0], Params[1]);

  If SameText(MethodName, 'fRetModalidadeFrete') Then
    Result := fRetModalidadeFrete(Params[0]);

  if SameText(MethodName,'fDuplicatasConhecimentoFrete') Then
    Result := fDuplicatasConhecimentoFrete(Params[0], Params[1],Params[2], Params[3]);

  If SameText(MethodName,'fCalculaMargem') Then
    Result := fCalculaMargem(Params[0], Params[1]);

  If SameText(MethodName,'fFormataConPag') Then
    Result := fFormataConPag;

  If SameText(MethodName,'fVariacao') Then
    Result := fVariacao;

  If SameText(MethodName,'fVariacaoD') Then
    Result := fVariacaoD;

  If SameText(MethodName,'fVariacaoG') Then
    Result := fVariacaoG;

  If SameText(MethodName,'fVariacaoF') Then
    Result := fVariacaoF;

  If SameText(MethodName,'fRetSomaConhecimento') Then
    Result := fretSomaConhecimento(Params[0]);

  If SameText(MethodName, 'fPercFrete') Then
    Result := fPercFrete(Params[0], Params[1], Params[2], Params[3]);
end;

function TfrmQckEspelhoNota.fPercFrete(fltTotIte, fltTotFre, fltTotCon, fltTotAnt: Double): Double;
Begin
  If fltTotIte <> 0 Then
    Result := ((fltTotFre +
                fltTotCon +
                fltTotAnt) /  fltTotIte) * 100
  Else
    Result := 0;
End;

function TfrmQckEspelhoNota.fCalculaMargem(fltPreCus, fltPreVen: Double): Double;
Begin
  Result := fCalculaPrecoVenda(2, fltPreCus, fltPreVen, 0, 0, 0, 0, 0);
End;

function TfrmQckEspelhoNota.fCalculaCustoReal(fltPreCus,
                                              fltIcmSai,
                                              fltImpFed,
                                              fltDesOpe,
                                              fltOutVal: Double): String;
  Var
    fltPreTmp: Double;
    fltCalTmp: Double;
Begin
  fltCalTmp := (1 - ((fltIcmSai+ fltImpFed + fltDesOpe)) / 100);
  fltPreTmp := fltPreCus + fltOutVal;
  Result    := FloatToStrF(fltPreTmp / fltCalTmp, ffFixed, 4, 3);
end;

function TfrmQckEspelhoNota.fCalculaValPercentual( curPrecom, curDesF01, curDesF02, curDesF03,
         curDesF04, curDesF05, curDesF06, curAcrFin, curUnitar,curUniPed : Double) : String;
Begin
  Result := '';
  If intOpcVariacao In [1, 2, 3] Then
  Begin

    If curUniPed <> 0 Then
      Result := FloatToStrF((curUnitar / curUniPed - 1) * 100 , ffFixed,6,2) + '%'
    Else
      Result := '0,00%';

  End
  Else
  If strTipCalc = 'C' Then
  Begin
    If fCalculaValorCompra(curPrecom,
                           curDesF01,
                           curDesF02,
                           curDesF03,
                           curDesF04,
                           curDesF05,
                           curDesF06,
                           curAcrFin) <> 0 Then
    Begin

        Result := FloatToStrF(fFormataFloat((curUnitar /
                            fCalculaValorCompra(curPrecom,
                                                curDesF01,
                                                curDesF02,
                                                curDesF03,
                                                curDesF04,
                                                curDesF05,
                                                curDesF06,
                                                curAcrFin) - 1) * 100, 2) , ffFixed,6,2) + '%';
    End;
  End
  Else
  Begin
    If curUniPed <> 0 Then
      Result := FloatToStrF(fFormataFloat((curUnitar / curUniPed - 1) * 100, 2) , ffFixed,6,2) + '%'
    Else
      Result := '0,00%';

  End ;


End;


procedure TfrmQckEspelhoNota.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  If VarName = 'EMP_NOMEMP' Then
    Value := fRetNomeEmpresa(VS_strCodEmp)

  Else If VarName = 'REL_NOMREL' Then
  Begin
    Value := Self.Name;

    If Not fEmptyStr(strFrase) Then
      Value := Value + ' ' + strFrase;
  End;
end;

function TfrmQckEspelhoNota.fVisualizaParcela( strEspDoc, strNumDoc, strSerie, strCodFor : String) : String;
  Var
    intContador  : Integer;
    strParcelas  : String;
    strAgrupamento: String;
    stlAgrupamentos: TStringList;
    intAgrup: Integer;
Begin
  stlAgrupamentos := TStringList.Create;
  stlAgrupamentos.Sorted     := True;
  stlAgrupamentos.Duplicates := dupIgnore;  // serão ignorados

  Try
    Try
      {********************************}
      {* PEGA OS VALORES DAS PARCELAS *}
      {*****************************AF*}
      if intOpcSelec = 1 Then
        arrParcelas := fRetParcelas(strNumDoc,
                                    strSerie,
                                    strCodFor,
                                    strCodEmp,
                                    True );

      strAgrupamento := '';
      strParcelas := '';
      For intContador := 0 To Length(arrParcelas) -1 Do
      Begin
        If Not fEmptyStr(arrParcelas[intContador].strNumAgp) Then
          stlAgrupamentos.Add(String(arrParcelas[intContador].strNumAgp));

        strParcelas := strParcelas + String(arrLetras[intContador]) + ')' + arrParcelas[intContador].strData + ' ' + arrParcelas[intContador].strValor +  ' Boleto:'+ arrParcelas[intContador].strVeioBo +'   ';
        If (arrLetras[intContador] = 'F')And(strTipImp = 'M') Then
          strParcelas := strParcelas + #13#10;
      End;

      If stlAgrupamentos.Count > 0 Then
      Begin
        For intAgrup := 0 To stlAgrupamentos.Count - 1 Do
          strAgrupamento := strAgrupamento + String(arrParcelas[intAgrup].strNumAgp) + ' ';
      End;

      Result := strParcelas;

      If Not fEmptyStr(strAgrupamento) Then
        Result := 'Agrupamento : ' + strAgrupamento + #13#10 + Result;

    Except
      Result := '';
    End;
  Finally
    stlAgrupamentos.Free;
  End;
End;

function TfrmQckEspelhoNota.fRetCentroCustoDoc: String;
Begin
  If Length(arrParcelas) > 0 Then
    Result := 'Plano de Contas: ' + fFormataCCusto(arrParcelas[0].strCodCta) + '-' + fRetDescCentroCusto(arrParcelas[0].strCodCta)
  Else
    Result := '';
End;

procedure TfrmQckEspelhoNota.DataModuleDestroy(Sender: TObject);
begin

  stlConPag.Clear;
  FreeAndNil(stlConPag);

  If cdsGNRE.Active Then
  Begin
    cdsGNRE.EmptyDataSet;
    cdsGNRE.Close;
  End;
end;

function TfrmQckEspelhoNota.fFormataConPag: String;
  Var
    intContador: Integer;
begin
  Result := frxRelatorio.DataSet.FieldByName('CONPAG2').AsString;

  If intOpcSelec = 1 Then
  Begin
    Result := '';

    stlConPag.CommaText := frxRelatorio.DataSet.FieldByName('PEDCOMDOC').AsString;

    For intContador := 0 To stlConPag.Count - 1 Do
    Begin
      Result := Result + fFormataCondPag(fCampoTabela('PCG_CONPAG', 'PCMGER', ['PCG_NUMPED', 'PCG_CODEMP'], [LeftStr(stlConPag[intContador], Length(stlConPag[intContador]) - 4),
                                                                                                             RightStr(stlConPag[intContador], 3)]));

      If intContador < stlConPag.Count - 1 Then
        Result := Result + ', ';
    End;

  End;
End;

function TfrmQckEspelhoNota.fMontaGNRE: Boolean;
  Var
    qryGen: TUniQuery;
begin
  Result := False;
  If intOpcSelec = 1 Then
  Begin
    cdsGNRE.EmptyDataSet;

    qryGen := fCriaQuery;
    With qryGen, SQL Do
    Begin
      Clear;
      Add('SELECT ');
      Add('  GNR_NUMGNR,');
      Add('  GNR_VALGNR,');
      Add('  CONCAT(GNR_CODFOR," - ", FOR_NOMFOR) AS GNR_CODFOR,');
      Add('  GNR_DTAVEN ');
      Add('FROM CADGNR');
      Add('INNER JOIN CADFOR ON FOR_CODFOR = GNR_CODFOR');
      Add('WHERE');

      If fEmptyStr(frxRelatorio.DataSet.FieldByName('SERIE_').AsString) Then
        Add('  ((GNR_SERIE_ IS NULL) OR (GNR_SERIE_ = "")) AND')
      Else
        Add('  GNR_SERIE_ = :SERIE_ AND');

      Add('  GNR_FORDOC = :FORDOC AND');
      Add('  GNR_ESPDOC = :ESPDOC AND');
      Add('  GNR_CODEMP = :CODEMP AND');
      Add('  GNR_NUMDOC = :NUMDOC    ');

      ParamByName('FORDOC').AsString := frxRelatorio.DataSet.FieldByName('CODFOR').AsString;
      ParamByName('ESPDOC').AsString := frxRelatorio.DataSet.FieldByName('ESPDOC').AsString;
      ParamByName('CODEMP').AsString := frxRelatorio.DataSet.FieldByName('CODEMP').AsString;
      ParamByName('NUMDOC').AsString := frxRelatorio.DataSet.FieldByName('NUMDOC').AsString;

      If Not fEmptyStr(frxRelatorio.DataSet.FieldByName('SERIE_').AsString) Then
        ParamByName('SERIE_').AsString := frxRelatorio.DataSet.FieldByName('SERIE_').AsString;

      Open;

      While Not Eof do
      Begin
        cdsGNRE.Insert;
        cdsGNRE.FieldByName('GNR_NUMGNR').AsString := FieldByName('GNR_NUMGNR').AsString;
        cdsGNRE.FieldByName('GNR_VALGNR').AsFloat  := FieldByName('GNR_VALGNR').AsFloat;
        cdsGNRE.FieldByName('GNR_CODFOR').AsString := FieldByName('GNR_CODFOR').AsString;
        cdsGNRE.FieldByName('GNR_DTAVEN').AsString := FieldByName('GNR_DTAVEN').AsString;

        cdsGNRE.Post;
        Result := True;
        Next;
      End;

      Close;

    End;
    FreeAndNil(qryGen);
  End Else
  Begin
    Result := Not cdsGNRE.IsEmpty;
  End;
end;

function TfrmQckEspelhoNota.fCondPagtoConhecimentoFrete(strNumDoc, strSerie, strCodFor, strCodEmp: String; dtaDtaDoc: TDate): String;
  Var
    arrDatas: TDateArray;
    intContador: Integer;
    dtaDtaBas: TDateTime;
Begin
  Result := '';

  If Assigned(objLisFre) And objLisFre.blnEntMer Then
  Begin
    Result := objEspNot.fCondPagtoConhecimentoFrete;
  End Else
  Begin

    pCarregaDuplicatasConhecFrete(strNumDoc, strSerie, strCodFor, strCodEmp);

    If qryCadPag.IsEmpty Then
      Exit;

    SetLength(arrDatas, qryCadPag.RecordCount);
    With qryCadPag Do
    Begin
      If IsEmpty Then
        Exit;
      intContador := 0;
      First;
      dtaDtaBas := dtaDtaDoc;
      While Not Eof Do
      Begin
        arrDatas[intContador] := FieldByName('DTAVEN').AsDateTime;
        Inc(intContador);
        Next;
      End;
    End;

    If qryCadPag.RecordCount > 0 Then
    Begin
      Result := fFormataCondPag(fRetornaCndPag(arrDatas, dtaDtaBas));
    End;
  End;
End;

function TfrmQckEspelhoNota.fDuplicatasConhecimentoFrete(strNumDoc, strEspDoc, strSerie, strCodFor: String): String;
Begin
  Result := '';

  If fEmptyStr(strNumDoc) Then
    Exit;

  If Assigned(objLisFre) And (objLisFre.blnEntMer) Then
  Begin
    Result := objEspNot.fDuplicatasConhecimentoFrete(strNumDoc, strEspDoc, strSerie, strCodFor);

  End Else
  Begin

    pCarregaDuplicatasConhecFrete(strNumDoc, strSerie, strCodFor, VS_strCodEmp);

    With qryCadPag Do
    Begin
      If IsEmpty Then
        Exit;
      First;
      While Not Eof Do
      Begin
        Result := Result + FieldByName('NUMDUP').AsString + '   ' +
           FormatDateTime('DD/MM/YYYY', FieldByName('DTAVEN').AsDateTime) + '   ' +
           FormatFloat('#0.00', FieldByName('VALDUP').AsFloat);

        Next;

        If Not Eof Then
          Result := Result + '  --  ';
      End;

      If RecordCount > 0 Then
      Begin
        Result := 'Plano de Contas : ' + fFormataCCusto(FieldByName('CODCTA').AsString) + '-' + fRetDescCentroCusto(FieldByName('CODCTA').AsString) +
                  #13#10 + 'Duplicatas: ' + Result;
      End;
    End;

  End;

  Result := Trim(Result);
End;

Procedure TfrmQckEspelhoNota.pCarregaDuplicatasConhecFrete(strNumDoc, strSerie, strCodFor, strCodEmp: String);
  Var
    strSQL: String;
Begin
  With qryCadPag, SQL Do
  Begin
    Close;

    If fEmptyStr(strNumDoc) Then
      Exit;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CONCAT(CTP_NUMDUP, "-", CTP_PARCEL, IF(IFNULL(CTP_SERIE_, "") <> "", "-", ""), IFNULL(CTP_SERIE_, "")) AS NUMDUP, ';
    strSQL := strSQL + '   IF(CTP_DTAPAG IS NULL, CTP_VALDUP, CTP_VALORI) AS VALDUP, ';
    strSQL := strSQL + '   CTP_CODCTA AS CODCTA, ';
    strSQL := strSQL + '   CTP_DTAVEN AS DTAVEN, ';
    strSQL := strSQL + '   CTP_DTACAD AS DTACAD  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADPAG ';
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   IFNULL(CTP_SERIE_, "") = :SERIE_ AND ';
    strSQL := strSQL + '   CTP_CODFOR = :CODFOR ';
    Text   := strSQL + ' ORDER BY DTAVEN ';

    ParamByName('NUMDUP').AsString := fStrZero(strNumDoc, 12);
    ParamByName('SERIE_').AsString := Trim(strSerie);
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;


    Open;
  End;
End;

function TfrmQckEspelhoNota.fRetVendor: String;
Begin
  If intOpc = 1 Then
    Result := fRetVendorNota(CTP_VENDOR)
  Else
    Result := objEspNot.fRetVendorDigitacao;
End;

function TfrmQckEspelhoNota.fRetIcmsAntecipado: String;
Begin
  If intOpc = 1 Then
    Result := fRetVendorNota(CTP_ICMS_ANTECIPADO)
  Else
    Result := objEspNot.fRetICMAntDigitacao;
End;

function TfrmQckEspelhoNota.fRetModalidadeFrete(intModalidade: Integer): string;
begin
  Result := '';
  If intModalidade = 0 Then
    Exit;
  Result := fDescricaoFrete(IntToStr(intModalidade));
end;

function TfrmQckEspelhoNota.fRetOutrasDespesas: String;
Begin
  If intOpc = 1 Then
    Result := fRetVendorNota(CTP_OUTRAS_DESPESAS)
  Else
    Result := objEspNot.fRetOutrasDespesasDigitacao;
End;

function TfrmQckEspelhoNota.fRetVendorNota(strNotTip: String): String;
  Var
    qryVendor: TUniQuery;
    strSQL: String;
    fltTotal: Double;
    strCodFor,
    strResFre : String;
    strLinha  : String;
Begin
  Result   := '';
  strResFre:= '';
  fltTotal := 0;

  qryVendor := fCriaQuery(Self);

  With qryVendor, SQL Do
  Begin

    strSQL := ' /* untQckEspelhoNota.fRetVendor */ ';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CTP_CODFOR AS CODFOR,  ';
    strSQL := strSQL + '   CTP_PARCEL, ';
    strSQL := strSQL + '   CTP_CODCTA AS CODCTA, ';
    strSQL := strSQL + '   CONCAT(CTP_NUMDUP, "-", CTP_PARCEL, IF(IFNULL(CTP_SERIE_, "") <> "", "-", ""), IFNULL(CTP_SERIE_, "")) AS NUMDUP, ';
    strSQL := strSQL + '   IF(CTP_DTAPAG IS NULL, CTP_VALDUP, CTP_VALORI) AS VALDUP, ';
    strSQL := strSQL + '   CTP_DTAVEN AS DTAVEN, ';
    strSQL := strSQL + '   CTP_DTACAD AS DTACAD  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADPAG ';
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   CTP_NOTENT = :NOTENT AND ';
    strSQL := strSQL + '   CTP_NOTTIP = :NOTTIP     ';
    Text   := strSQL + ' ORDER BY CODFOR, NUMDUP, DTAVEN ';


    ParamByName('NOTTIP').AsString := strNotTip;

    ParamByName('NOTENT').AsString := frxRelatorio.DataSet.FieldByName('NUMDOC').AsString +
                                      frxRelatorio.DataSet.FieldByName('ESPDOC').AsString +
                                      frxRelatorio.DataSet.FieldByName('CODEMP').AsString +
                                      fstrEspaco(frxRelatorio.DataSet.FieldByName('SERIE_').AsString, 3) +
                                      frxRelatorio.DataSet.FieldByName('CODFOR').AsString;
    Open;

    strLinha  := '';

    If Not IsEmpty Then
      strLinha  := 'Plano de Contas: ' + fFormataCCusto(FieldByName('CODCTA').AsString) + '-' + fRetDescCentroCusto(FieldByName('CODCTA').AsString) + #13#10;

    While Not Eof Do
    Begin
      strCodFor := FieldByName('CODFOR').AsString;

      fltTotal := fltTotal + FieldByName('VALDUP').AsFloat;
      strLinha := strLinha  + FieldByName('NUMDUP').AsString + ' - ' +
                         DateToStr(FieldByName('DTAVEN').AsDateTime) +
                         '   ' +  FormatFloat('#0.00', FieldByName('VALDUP').AsFloat) + '  --  ';
      Next;

      If Eof Or (strCodFor <> FieldByName('CODFOR').AsString) Then
      Begin
        If fltTotal > 0 Then
          Result := Result + 'Fornecedor: ' + strCodFor + '-' + fRetNomFornecedor(strCodFor) +
                    '   Valor: ' + FormatFloat('#0.00', fltTotal) +  #13#10 + strLinha ;

        If Not Eof Then
          Result := Result + #13#10;

        fltTotal := 0.00;
        strLinha := '';
      End;

    End;

    { ************************** }
    { Exibe informações do Frete }
    { ***********************GB* }
    If (strNotTip = CTP_ICMS_ANTECIPADO) Then
    Begin
      Close;
      fltTotal := 0; 

      objLisFre.First;
      While Not objLisFre.Eof Do
      Begin

        ParamByName('NOTENT').AsString := objLisFre.FieldByName('NUMDOC').AsString +
                                          objLisFre.FieldByName('ESPDOC').AsString +
                                          objLisFre.FieldByName('CODEMP').AsString +
                                          fstrEspaco(objLisFre.FieldByName('SERIE_').AsString, 3) +
                                          objLisFre.FieldByName('CODTRA').AsString;
        Open;

        While Not Eof Do
        Begin
          fltTotal := fltTotal + FieldByName('VALDUP').AsFloat;
          strResFre := strResFre + FieldByName('NUMDUP').AsString + ' - ' +
                             DateToStr(FieldByName('DTAVEN').AsDateTime) +
                             '   ' +  FormatFloat('#0.00', FieldByName('VALDUP').AsFloat) + '  --  ';
          Next;
        End;

        objLisFre.Next;
      End;

      If fltTotal > 0 Then
        strResFre := 'Fornecedor: ' + FieldByName('CODFOR').AsString + '-' + fRetNomFornecedor(FieldByName('CODFOR').AsString) +
                  '   Valor: ' + FormatFloat('#0.00', fltTotal) +  #13#10 + strResFre;


    End;

    if Not fEmptyStr(strResFre) Then
      Result := Result + IIF( not fEmptyStr(Result), #13#10, '') + strResFre;

  End;

  FreeAndNil(qryVendor);
End;

function TfrmQckEspelhoNota.fTemConhecimentoFrete(strAutGer, strEspDoc: String): Boolean;
Begin

  If Assigned(objLisFre) Then
  Begin
     If Not objLisFre.blnEntMer Then
       objLisFre.fCarregaConhecimento(strAutGer, strEspDoc);

     Result := objLisFre.fltValCon > 0;

  End Else
  Begin

     Result := False;

  End;

End;

Function TfrmQckEspelhoNota.fVariacao: Double;
  Var
    fltVlrUni,
    fltVlrPed,
    fltQtdIte: Double;
Begin
  With frxRelatorio.DataSet Do
  Begin
    If strDocAnt <> FieldByName('NUMDOC').AsString Then
      fltTotVarD := 0;

    If strForAnt <> FieldByName('CODFOR').AsString Then
      fltTotVarF := 0;

    strDocAnt := FieldByName('NUMDOC').AsString;
    strForAnt := FieldByName('CODFOR').AsString;

    fltVlrUni := FieldByName('UNITAR').AsFloat;

    If intOpcVariacao = 2 Then
      fltVlrPed := FieldByName('UNITAR_IMP').AsFloat

    Else If (intOpcVariacao = 3) Or (intOpcVariacao = 1) Then
      fltVlrPed := FieldByName('PRECOM').AsFloat

    Else
      fltVlrPed := fCalculaValorCompra(FieldByName('PRECOM').AsFloat,
                                       FieldByName('DESF01').AsFloat,
                                       FieldByName('DESF02').AsFloat,
                                       FieldByName('DESF03').AsFloat,
                                       FieldByName('DESF04').AsFloat,
                                       FieldByName('DESF05').AsFloat,
                                       FieldByName('DESF06').AsFloat,
                                       FieldByName('ACRFIN').AsFloat);

    fltQtdIte := FieldByName('QTDITE').AsFloat;

    If fltVlrPed > 0 Then
    Begin
      If strTipCalc = 'C' Then
      Begin
        Result := (fltVlrUni - fltVlrPed) * fltQtdIte;

        fltTotVarD := fltTotVarD + ((fltVlrUni - fltVlrPed) * fltQtdIte);
        fltTotVarF := fltTotVarF + ((fltVlrUni - fltVlrPed) * fltQtdIte);
        fltTotVarG := fltTotVarG + ((fltVlrUni - fltVlrPed) * fltQtdIte);
      End
      Else
      Begin
        Result := (fltVlrUni - FieldByName('UNIPED').AsFloat) * fltQtdIte;

        fltTotVarD := fltTotVarD + (fltVlrUni - FieldByName('UNIPED').AsFloat) * fltQtdIte;
        fltTotVarF := fltTotVarF + (fltVlrUni - FieldByName('UNIPED').AsFloat) * fltQtdIte;
        fltTotVarG := fltTotVarG + (fltVlrUni - FieldByName('UNIPED').AsFloat) * fltQtdIte;
      End;  
    End
    Else
      Result := 0;
  End;
End;

Function TfrmQckEspelhoNota.fVariacaoD: Double;
Begin
  Result := fltTotVarD;
End;

Function TfrmQckEspelhoNota.fVariacaoF: Double;
Begin
  Result := fltTotVarF;
End;

Function TfrmQckEspelhoNota.fVariacaoG: Double;
Begin
  Result := fltTotVarG;
End;

Function TfrmQckEspelhoNota.fRetSomaConhecimento(fltValCon: Double): Double;
  Var
    qryConFre: TUniQuery;
Begin
  If Not Assigned(objLisFre) Then
  Begin
    Result := 0;
    Exit;
  End;
  
  If intOpc <> 1 Then
  Begin
    Result := objEspNot.fRetSomaConhecimento;
  End Else
  Begin
    qryConFre := fCriaQuery;
    With qryConFre, SQL Do
    Begin
      Clear;
      Add('SELECT ');
      Add('  SUM(IFNULL(T.DET_CONFRE, 0)) AS FREDOC ');
      Add('FROM MOVDET D');
      Add('INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM');
      Add('WHERE ');
      Add('  D.DET_SEQGER = :SEQGER');

      ParamByName('SEQGER').AsString := frxRelatorio.DataSet.FieldByName('AUTGER').AsString;

      Open;

      If objLisFre.fRetSoma('TOT_VALCON') > 0 Then
        Result := FieldByName('FREDOC').AsFloat * (objLisFre.FieldByName('VALCON').AsFloat / objLisFre.fRetSoma('TOT_VALCON'))
      Else
        Result := 0;

      Close;

    End;
    FreeAndNil(qryConFre);
  End;
End;

end.


