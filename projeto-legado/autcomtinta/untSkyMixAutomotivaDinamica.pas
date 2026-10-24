unit untSkyMixAutomotivaDinamica;

interface

uses SysUtils, Forms, Uni, Classes, untFuncoesSimples,  DB,
  StrUtils, untFuncEspecificas, Controls, Dialogs,
  untIConsulta, untPnlBotoesAcoesNovaConsulta,
 UniClientDataSet;

Type
  TfrmConsultaCompSkyMix = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;

    constructor Create(AOwner: TComponent; tipoConsulta: TTipoConsulta; strTabPre: String;
                tinta: IConsulta); reintroduce;
  End;

Type
  TFormulaSkyMixAutomotivaDinamica  = class(TFormulaAutomotiva)
    private
      fltPerAcr: Double;
      fltAcrMob: Double;
    protected
      stlBassesErros: TStringList;
    public
      procedure pCarregarColorantes; Override;
      procedure pCarregaPrecosBases; override;
      procedure pCalcularPrecos; Override;
      constructor Create(strTabPrePar: String); Override;
      destructor Destroy; override;
  End;

  function fConsultaSkyMixAutomotivaDinamica(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaSkyMixAutomotivaGeralDinamica(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaSkyMixAutomotivaVendaDinamica(Sender: TForm; strCodEmp: String; var qryCadSky: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultasSkyMixAutomotivaDinamicaInterna(Sender: TForm; qryCadSky: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;

  function fGTinForSkyMixAutomotivaDinamica(strIteTin: String; strTipPre: String;
            Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
            Var stlItensTraMl: TStringList; fltVolPro: Double): Boolean; stdcall;

  function fDigDadosTintometricos(qryCadSky: TUniClientDataSet; stlDesEmb, stlProEmbLt,
    stlGruEmbLt, stlProEmbGl, stlGruEmbGl: TStringList; strProEmbCo, strGruEmbCo,
    strProEmbSp, strGruEmbSp: String; Var strIteEmb,
    strGruEmb, strTipEmb, strTipPre: String; Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala,
    fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;

  function fRetornaPrecoSkyMixAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery; Var dicRetorno: TDicionario;
    blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  function fRetornaUniTraEmbSkymixAutomotiva(strTipEmb: String): Double;

  procedure pRetornaDadosSkyMixAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
  function fRetornaUniTraProSkyMixAutomotivaDinamica(strTipPre : String; fltPrcTin, fltPrvTin: Double): Double;

  procedure pRetornaTabelaPrecoSkyMixAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);

  function fRetornaMontadora(strCodMon: String): String;
  function GetLinha(const strCodGru: string): string;

implementation

uses untDigTintaAutomotiva, Math,
   untSkyMixAutomotivaConsulta,
  untIConsultaTinta, untDigTintaAutomotivaSkyMix, untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untTintaDeMaquinaComponenteComparerBaseAutomotiva,untFuncoes,
untIConfTinta,
untICalculadorFatVendas,
untITintaDeMaquinaComponente,
untTintaMaquina,
untClientDataSetFactory,
untMultiSelectLocalizadorFactory;

function fConsultaSkyMixAutomotivaDinamica(Sender: TForm; strCodEmp: String): String; stdcall;
var
  qryCadSky: TUniQuery;
begin
  qryCadSky := nil;
  Try
    Try
      qryCadSky := fCriaQuery(Sender);
      Result := fConsultasSkyMixAutomotivaDinamicaInterna(Sender, qryCadSky, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, Nil, Nil);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadSky) then FreeAndNil(qryCadSky);
  End;
end;

function fConsultaSkyMixAutomotivaGeralDinamica(Sender: TForm; strCodEmp: String): String; stdcall;
begin
  Result := fConsultaSkyMixAutomotivaDinamica(Sender, strCodEmp);
end;

function fConsultaSkyMixAutomotivaVendaDinamica(Sender: TForm; strCodEmp: String; Var qryCadSky: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultasSkyMixAutomotivaDinamicaInterna(Sender, qryCadSky, tpcVenda, strTabPre, blnFaturamento, dicRetorno, sltItems);
end;

function fGTinForSkyMixAutomotivaDinamica(strIteTin: String; strTipPre: String; 
  Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
  Var stlItensTraMl: TStringList; fltVolPro: Double): Boolean; stdcall;
var
  strSQL      : String;
  qryConsulta : TUniQuery;
  intCont     : Integer;
  strCamFor   : String;
  strCamQtd   : String;
  dicBases    : TDicionario;
  strBases    : String;
  cdsConsulta: TUniClientDataSet;
begin
  Result := False;
  qryConsulta := nil;
  dicBases := nil;
  Try
    Try
      Result := TMultiSelectLocalizadorFactory.GetLocalizador('SKY').Localizar(cdsConsulta, ['ITETIN'], [strIteTin]);
      if not Result then
        Exit;

      dicBases := TDicionario.Create;

      For intCont := 1 To 20 Do
      Begin
        strCamFor := 'SKY_FORM' + fStrZero(intCont, 2);

        If strTipPre = 'D' Then
          strCamQtd := 'SKY_QTDB' + fStrZero(intCont, 2)
        Else
          strCamQtd := 'SKY_QTDC' + fStrZero(intCont, 2);

        If fEmptyStr(cdsConsulta.FieldByName(strCamFor).AsString) Then
          Break;

        If (strTipPre = 'C') And (cdsConsulta.FieldByName('SKY_QTDC' + fStrZero(intCont, 2)).AsFloat = 0) Then
          Break;

        arrFormul[intCont].strFormul := cdsConsulta.FieldByName(strCamFor).AsString;
        arrFormul[intCont].fltQtdbas := cdsConsulta.FieldByName(strCamQtd).AsFloat / 0.9 * fltVolPro;
        dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

        {***************************************************************}
        {* ARMAZENA AS BASES EM UMA STRING PARA FAZER A BUSCA NAS BASES*}
        {************************************************************PH*}
        strBases := strBases + QuotedStr(arrFormul[intCont].strFormul) + ', ';
      End;

      strBases := Trim(strBases);
      strBases := Copy(strBases, 1, Length(strBases) - 1);

      {****************************************}
      {* SELECIONA SOMENTE AS BAES DA FORMULA *}
      {*************************************PH*}
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + ' 	BAS_CODBAS, ';
      strSQL := strSQL + ' 	BAS_CODITE ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + ' 	SKY_CADBAS  ';
      strSQL := strSQL + ' WHERE ' + GetInToOr('BAS_CODBAS', strBases);

      qryConsulta := fCriaQuery();
      qryConsulta.SQL.Text := strSQL;
      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      {********************************************************************}
      {* FIXA O TAMANHO DO ARRAY DE BAIXA PARA O TANTO DE BASES DA FORMULA*}
      {*****************************************************************PH*}
      SetLength(arrBaixaPigmentos, cdsConsulta.RecordCount);

      {**************************************************}
      {* CARREGA OS ITENS PARA FAZER A BAIXA DE ESTOQUE *}
      {***********************************************PH*}
      While (Not cdsConsulta.Eof) Do
      Begin
        stlItensTraMl.Add(cdsConsulta.FieldByName('BAS_CODITE').AsString);
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].strCodIte := cdsConsulta.FieldByName('BAS_CODITE').AsString;
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].fltQtdBaixa := dicBases[cdsConsulta.FieldByName('BAS_CODBAS').AsString];
        cdsConsulta.Next;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryConsulta) then FreeAndNil(qryConsulta);
    if Assigned(dicBases) then FreeAndNil(dicBases);
  End;
end;

procedure pRetornaDadosSkyMixAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
var
  cdsCadSky : TUniClientDataSet;
begin
  if TMultiSelectLocalizadorFactory.GetLocalizador('SKY').Localizar(cdsCadSky, ['ITETIN'], [strIteTin]) then
  begin
    dicRetorno['codtin'] := cdsCadSky.FieldByName('SKY_CODPRO').AsString +
        cdsCadSky.FieldByName('SKY_DESCRI').AsString +
        cdsCadSky.FieldByName('SKY_ANOFAB').AsString +
        cdsCadSky.FieldByName('SKY_ANUANC').AsString +
        cdsCadSky.FieldByName('SKY_CORPAI').AsString +
        cdsCadSky.FieldByName('SKY_NACIMP').AsString +
        cdsCadSky.FieldByName('SKY_CODMON').AsString +
        cdsCadSky.FieldByName('SKY_CODGRU').AsString +
        cdsCadSky.FieldByName('SKY_CODSGR').AsString +
        cdsCadSky.FieldByName('SKY_CODSGR').AsString;

    dicRetorno['montad'] := fRetornaMontadora(cdsCadSky.FieldByName('SKY_CODMON').AsString);
  end;

end;

function fDigDadosTintometricos(qryCadSky: TUniClientDataSet; stlDesEmb, stlProEmbLt, stlGruEmbLt, stlProEmbGl,
  stlGruEmbGl: TStringList; strProEmbCo, strGruEmbCo, strProEmbSp, strGruEmbSp: String;
  Var strIteEmb, strGruEmb, strTipEmb, strTipPre: String; Var intQtdEmb: Integer;
  Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String;
  dicRetorno: TDicionario): Boolean;
var
  objBase     : TBaseAutomotiva;
  objFormula  : TFormulaSkyMixAutomotivaDinamica;
  intCont     : Integer;
  fltPreCu2: Double;
  fltOutVal: Double;
  fltIcmSai: Double;
  fltImpFed: Double;
  fltDesOpe: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  cdsCadBas: TUniClientDataSet;
  intIndEmb: Integer;
  conf: IConfTinta;
begin
  Result := False;
  frmDigTintaAutomotivaSkyMix := nil;
  objFormula := nil;
  conf := fGetConfTinta('SKY');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;
            
      objFormula := TformulaSkyMixAutomotivaDinamica.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strDescri := qryCadSky.FieldbyName('SKY_DESCRI').AsString;
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.fltAcrMob := qryCadSky.FieldByName('SKY_ACRMOB').AsFloat;

      cdsCadBas := TClientDataSetFactory.GetClientDataSet(objFormula.qryCadBas);

      intIndEmb := -1;
      if qryCadSky.FieldByName('SKY_CODGRU').AsString = '5' then //laca
        intIndEmb := 0
      else if ((qryCadSky.FieldByName('SKY_CODGRU').AsString = '2') OR (qryCadSky.FieldByName('SKY_CODGRU').AsString = '3')) then //poliester
        intIndEmb := 1
      else if qryCadSky.FieldByName('SKY_CODGRU').AsString = '6' then //pu
        intIndEmb := 2
      else if qryCadSky.FieldByName('SKY_CODGRU').AsString = '4' then  //sintetico
        intIndEmb := 3
      else if qryCadSky.FieldByName('SKY_CODGRU').AsString = 'L' then  //Frota(SFL)
        intIndEmb := 4
      else if qryCadSky.FieldByName('SKY_CODGRU').AsString = 'S' then  //Frota(SFS)
        intIndEmb := 5
      else if qryCadSky.FieldByName('SKY_CODGRU').AsString = 'P' then  //Frota(SFP)
        intIndEmb := 6;

      For intCont := 1 To 20 Do
      Begin
        If fEmptyStr(qryCadSky.FieldbyName('SKY_FORM' + fStrZero(intCont, 2)).AsString) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryCadSky.FieldByName('SKY_FORM' + fStrZero(intCont, 2)).AsString;
        objBase.fltQtddIL := qryCadSky.FieldByName('SKY_QTDB' + fStrZero(intCont, 2)).AsFloat;
        objBase.fltQtdCon := qryCadSky.FieldByName('SKY_QTDC' + fStrZero(intCont, 2)).AsFloat;

        cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);
        objBase.fltEmbala := cdsCadBas.FieldbyName('BAS_EMBALA').AsFloat;
        objBase.fltPesEsp := cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

        If (objFormula.blnTemConcentrado) And (objBase.fltQtdCon = 0) Then
          objBase.strTipBas := 'D'
        Else
          objBase.strTipBas := 'B';
      End;

      objFormula.pCarregaPrecosBases;


      pCriarFormularios(TfrmDigTintaAutomotivaSkyMix, frmDigTintaAutomotivaSkyMix);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      objFormula.fltVolumeOri := 0.9;
      frmDigTintaAutomotivaSkyMix.objFormula := objFormula;
      frmDigTintaAutomotivaSkyMix.stlDesEmb := stlDesEmb;
      frmDigTintaAutomotivaSkyMix.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotivaSkyMix.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotivaSkyMix.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotivaSkyMix.fltVolumePadraoCopo := 0.450;
      frmDigTintaAutomotivaSkyMix.fltVolumeMaximoCopo := 0.450;
      frmDigTintaAutomotivaSkyMix.Caption := frmDigTintaAutomotivaSkyMix.Caption + 'SkyMix Automotiva';
      frmDigTintaAutomotivaSkyMix.edtQtdEmb.Text := '1';
      frmDigTintaAutomotivaSkyMix.Linha := GetLinha(qryCadSky.FieldbyName('SKY_CODGRU').AsString);

      frmDigTintaAutomotivaSkyMix.chkComCat.Visible := False;
      frmDigTintaAutomotivaSkyMix.intIndEmb   := intIndEmb;
      frmDigTintaAutomotivaSkyMix.strIdePro   := 'SKY';

      Result := (frmDigTintaAutomotivaSkyMix.ShowModal = mrOk);

      If Result Then
      Begin
        strIteEmb := frmDigTintaAutomotivaSkyMix.objFormula.strCodEmb;

        Case frmDigTintaAutomotivaSkyMix.objFormula.tpeTipEmb of

          teLitro  : begin
                       strTipEmb := 'LT';
                       fltEmbala := 0.900;
                     end;

          teGalao  : begin
                       strTipEmb := 'GL';
                       fltEmbala := 3.600;
                     end;

          teCopo   : begin
                       strTipEmb := 'CP';
                       fltEmbala := 3.600;
                     end;
        end;


        strTipPre := IIF(frmDigTintaAutomotivaSkyMix.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotivaSkyMix.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoEmbalagem;
        fltVolPro := frmDigTintaAutomotivaSkyMix.objFormula.fltVolumePro;

        If (frmDigTintaAutomotivaSkyMix.rdgModoVenda.ItemIndex = 0) Then
        Begin
          fltPreCus := frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoCusCon + frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoCu2Con + frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoVenCon + frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoEmbalagem;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoCusDil + frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoCu2Dil + frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoVenDil + frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoEmbalagem;
        End;

        dicRetorno['premed'] := IfThen(frmDigTintaAutomotivaSkyMix.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaSkyMix.objFormula.fltPreMedCon,
          frmDigTintaAutomotivaSkyMix.objFormula.fltPreMedDil) +
          frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotivaSkyMix.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaSkyMix.objFormula.fltImpUltCon,
          frmDigTintaAutomotivaSkyMix.objFormula.fltImpUltDil) +
          frmDigTintaAutomotivaSkyMix.objFormula.fltUltimoImpostoEmbalagem;

        dicRetorno['preult'] := IfThen(frmDigTintaAutomotivaSkyMix.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaSkyMix.objFormula.fltPreUltCon,
          frmDigTintaAutomotivaSkyMix.objFormula.fltPreUltDil) +
          frmDigTintaAutomotivaSkyMix.objFormula.fltPreUltEmbalagem;

        dicRetorno['prctin'] := IfThen(frmDigTintaAutomotivaSkyMix.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaSkyMix.objFormula.fltComLiqCon,
          frmDigTintaAutomotivaSkyMix.objFormula.fltComLiqDil) +
          frmDigTintaAutomotivaSkyMix.objFormula.fltPrecoCompraLiquidoEmbalagem;

        dicRetorno['promoc'] := frmDigTintaAutomotivaSkyMix.objFormula.StrPromoc;

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['qtdemb'] := objFormula.intQtdEmb;

        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        dicRetorno['promoc']      := objFormula.StrPromoc;
        objFormula.pCalculaImpostosSaida(dicRetorno);

        dicRetorno['obscolorista']   := frmDigTintaAutomotivaSkyMix.edtDescricaoColorista.Text;
        dicRetorno['tipoformulacao'] := frmDigTintaAutomotivaSkyMix.rdgTipoFormula.ItemIndex;

        dicRetorno['saldocols'] := frmDigTintaAutomotivaSkyMix.blnSaldoSuficiente;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotivaSkyMix.matrizSaldosColorantes);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
      End;

      If (Result) And (Assigned(dicRetorno)) Then
      Begin
        objFormula.pRecalculaTabelas(strTipPre, dicRetorno);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmDigTintaAutomotivaSkyMix) then FreeAndNil(frmDigTintaAutomotivaSkyMix);
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
end;

{ TformulaSkyMixAutomotivaDinamica }

constructor TFormulaSkyMixAutomotivaDinamica.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited Create(strTabPrePar);
  stlBassesErros := TStringList.Create;
  stlBassesErros.Clear;
  stlBassesErros.Sorted := True;
  stlBassesErros.Duplicates := dupIgnore;
  conf := fGetConfTinta('SKY');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

  fltAcrMob := 0;
end;

destructor TFormulaSkyMixAutomotivaDinamica.Destroy;
begin
  FreeAndNil(stlBassesErros);
  inherited;
end;

procedure TFormulaSkyMixAutomotivaDinamica.pCalcularPrecos;
var
  intIndex: Integer;
  intCIndex: Integer;
  objBase: TBaseAutomotiva;
  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltEmbala   : Double;

  fltCusBasDil: Double;
  fltCusBasCon: Double;

  fltCu2BasDil: Double;
  fltCu2BasCon: Double;

  fltVenBasDil: Double;
  fltVenBasCon: Double;

  fltPorMVA: Double;
  fltPorIPI: Double;
  fltPorICMS: Double;

  fltFatMl: Double;
  fltFatMlCon: Double;

  fltFator: Double;
  fltFatorCon: Double;

  fltVIcmsVen: Double;
  fltVIcmsCus: Double;
  fltVIcmsCu2: Double;

  fltVIPICus: Double;
  fltVIPICu2: Double;
  fltVIPIVen: Double;

  fltVMVACus: Double;
  fltVMVACu2: Double;
  fltVMVAVen: Double;

  fltVMVAIcmsCus: Double;
  fltVMVAIcmsCu2: Double;
  fltVMVAIcmsVen: Double;

  fltDifIcmsCus: Double;
  fltDifIcmsCu2: Double;
  fltDifIcmsVen: Double;

  fltValorTintaCus: Double;
  fltValorTintaCu2: Double;
  fltValorTintaVen: Double;
  conf: IConfTinta;

  fltQtdMlCon: Double;
  fltQtdMlDil: Double;

  componente: array[TModoVenda] of ITintaDeMaquinaComponente;
  cdsCadBas: TUniClientDataSet;

  fltPreCusItem: Double;
  fltPreVenItem: Double;
  fltPreCusPro: Double;
  fltPreVenPro: Double;

  procedure pZerarPrecos;
  begin
    FPrecoCusDil := 0.0;
    FPrecoVenDil := 0.0;
    FPrecoCu2Con := 0.0;
    FPrecoCu2Dil := 0.0;
    FPrecoCusCon := 0.0;
    FPrecoVenCon := 0.0;

    FOutValCon := 0;
    FIcmsaiCon := 0;
    FImpFedCon := 0;
    FDesOpeCon := 0;
    FPreMedCon := 0;
    FComLiqCon := 0;
    FPreUltCon := 0;
    FImpUltCon := 0;

    FOutValDil := 0;
    FIcmsaiDil := 0;
    FImpFedDil := 0;
    FDesOpeDil := 0;
    FPreMedDil := 0;
    FComLiqDil := 0;
    FPreUltDil := 0;
    FImpUltDil := 0;

    FPromoc := 'N';
  End;
begin
  inherited;
  conf  := fGetConfTinta('SKY');
  pZerarPrecos;

  fltPorMVA := conf.fGetDouble('SKYMVA') / 100;

  If fltVolumePro <= 0.0 Then
    fltVolumePro := 1;

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotiva(Items[intIndex]);

    If (Self.FModoVenda = mvConcentrado) And (objBase.strTipBas = 'D') Then
    Begin
      Continue;
    End;    

    If ((Not cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, [])) and (Not stlBassesErros.Find(objBase.strCodBas, intCIndex))) Then
    Begin
      pZerarPrecos;
      stlBassesErros.Add(objBase.strCodBas);
      Raise Exception.Create('Base ' + objBase.strCodBas + ' não cadastrada. Favor verificar.');
      Continue;
    End;

    If ((fEmptyStr(cdsCadBas.FieldByName('BAS_CODITE').AsString)) and (Not stlBassesErros.Find(objBase.strCodBas, intCIndex))) Then
    Begin
      pZerarPrecos;
      stlBassesErros.Add(objBase.strCodBas);
      Raise Exception.Create('A base ' + objBase.strCodBas + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Continue;
    End;

    If ((cdsCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0) and (Not stlBassesErros.Find(objBase.strCodBas, intCIndex))) Then
    Begin
      pZerarPrecos;
      stlBassesErros.Add(objBase.strCodBas);
      Raise Exception.Create('O produto ' + cdsCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Continue;
    End;

    If ((cdsCadBas.FieldByName('BAS_PESESP').AsFloat <= 0) and (Not stlBassesErros.Find(objBase.strCodBas, intCIndex))) Then
    Begin
      pZerarPrecos;
      stlBassesErros.Add(objBase.strCodBas);
      Raise Exception.Create('A base ' + objBase.strCodBas + ' está com o peso específico zerado.' + #13#10 +
                             'Favor verificar.');
      Continue;
    End;

    If Not IsItemAtivo(cdsCadBas.FieldByName('BAS_CODITE').AsString) Then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [cdsCadBas.FieldByName('BAS_CODITE').AsString]);
    end;

    If objBase.fltPesEsp = 0.0 Then
      Exit;

    if stlBassesErros.Count > 0 then
    Begin
      pZerarPrecos;
      Exit;
    End;

    componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
    if not Assigned(componente[mvConcentrado]) then
    begin
      componente[mvConcentrado] := tintaDeMaquina[mvConcentrado].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objBase.strCodIte, objBase.strCodBas, tmctBaseAutomotiva
      ));
    end;

    componente[mvDiluido] := tintaDeMaquina[mvDiluido].Localizar(TTintaDeMaquinaComponenteComparerBaseAutomotiva.Create(objBase.strCodBas));
    if not Assigned(componente[mvDiluido]) then
    begin
      componente[mvDiluido] := tintaDeMaquina[mvDiluido].Adicionar(TGenericTintaDeMaquinaComponente.Create(
        objBase.strCodIte, objBase.strCodBas, tmctBaseAutomotiva
      ));
    end;

    componente[mvConcentrado].Quantidade := objBase.fltQtdCon * FVolumePro / FVolumeOri;
    componente[mvDiluido].Quantidade := objBase.fltQtdDil * FVolumePro / FVolumeOri;

    If fCarregaPromocao(cdsCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreCusItem := fltPreCusPro;
      fltPreVenItem := fltPreVenPro;
      FPromoc := 'S';

      If fltPreCusItem = 0 Then
        fltPreCusItem := cdsCadBas.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPreCusItem := cdsCadBas.FieldByName('ITE_PRECUS').AsFloat;
      fltPreVenItem := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    fltPreCu2Bas := fCalculaPrecoCusto2(fltPreVenItem,
                                        fltPreCusItem,
                                        objBase.fltOutVal,
                                        objBase.fltIcmSai,
                                        objBase.fltImpFed,
                                        objBase.fltDesOpe);

    fltPreCusBas := fltPreCusItem;
    fltPreVenBas := fltPreVenItem;
    fltEmbala    := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

    fltPorICMS := cdsCadBas.FieldByName('ITE_ICMSAI').AsFloat / 100;
    fltPorIPI := cdsCadBas.FieldByName('ITE_IPISAI').AsFloat / 100;

    fltFatMl := objBase.fltQtdDil / objBase.fltPesEsp;
    fltFatMlCon := objBase.fltQtdCon / objBase.fltPesEsp;

    fltFator := fltFatMl / fltEmbala;
    fltFatorCon := fltFatMlCon / fltEmbala;

    fltVIcmsCus := fltPreCusBas * fltPorICMS;
    fltVIcmsCu2 := fltPreCu2Bas * fltPorICMS;
    fltVIcmsVen := fFormataFloat(fltPreVenBas, 4) * fFormataFloat(fltPorICMS, 4);

    fltVIPICus := fltPreCusBas * fltPorIPI;
    fltVIPICus := fltVIPICus + fltPreCusBas;
    fltVIPICu2 := fltPreCu2Bas * fltPorIPI;
    fltVIPICu2 := fltVIPICu2 + fltPreCu2Bas;
    fltVIPIVen := fltPreVenBas * fltPorIPI;
    fltVIPIVen := fltVIPIVen + fltPreVenBas;

    fltVMVACus := fltVIPICus * fltPorMVA;
    fltVMVACus := fltVMVACus + fltVIPICus;
    fltVMVACu2 := fltVIPICu2 * fltPorMVA;
    fltVMVACu2 := fltVMVACu2 + fltVIPICu2;
    fltVMVAVen := fltVIPIVen * fltPorMVA;
    fltVMVAVen := fltVMVAVen + fltVIPIVen;

    fltVMVAIcmsCus := fltVMVACus * fltPorICMS;
    fltVMVAIcmsCu2 := fltVMVACu2 * fltPorICMS;
    fltVMVAIcmsVen := fltVMVAVen * fltPorICMS;

    fltDifIcmsCus := fltVMVAIcmsCus - fltVIcmsCus;
    fltDifIcmsCu2 := fltVMVAIcmsCu2 - fltVIcmsCu2;
    fltDifIcmsVen := fltVMVAIcmsVen - fltVIcmsVen;

    fltValorTintaCus := fltVIPICus + fltDifIcmsCus;
    fltValorTintaCu2 := fltVIPICu2 + fltDifIcmsCu2;
    fltValorTintaven := fltVIPIVen + fltDifIcmsVen;

    fltCusBasDil := fltValorTintaCus * fltFator * fltVolumePro / 0.9;
    fltCu2BasDil := fltValorTintaCu2 * fltFator * fltVolumePro / 0.9;

    fltCusBasCon := fltValorTintaCus * fltFatorCon * fltVolumePro / 0.9;
    fltCu2BasCon := fltValorTintaCu2 * fltFatorCon * fltVolumePro / 0.9;

    fltVenBasDil := fltValorTintaVen * fltFator * fltVolumePro / 0.9;
    fltVenBasCon := fltValorTintaVen * fltFatorCon * fltVolumePro / 0.9;

    componente[mvConcentrado].OutrosValores := (objBase.fltOutVal * fltFatorCon * fltVolumePro / 0.9);
    componente[mvDiluido].OutrosValores := (objBase.fltOutVal * fltFator * fltVolumePro / 0.9);

    componente[mvConcentrado].IcmsSaida := fltVenBasCon * objBase.fltIcmSai / 100;
    componente[mvDiluido].IcmsSaida := fltVenBasDil * objBase.fltIcmSai / 100;

    componente[mvConcentrado].ImpostosFederais := fltVenBasCon * objBase.fltImpFed / 100;
    componente[mvDiluido].ImpostosFederais := fltVenBasDil * objBase.fltImpFed / 100;

    componente[mvConcentrado].DespesasOperacionais := fltVenBasCon * objBase.fltDesOpe / 100;
    componente[mvDiluido].DespesasOperacionais := fltVenBasDil * objBase.fltDesOpe / 100;

    componente[mvConcentrado].PrecoMedio := (objBase.fltPreMed * fltFatorCon * fltVolumePro / 0.9);
    componente[mvDiluido].PrecoMedio := (objBase.fltPreMed * fltFator * fltVolumePro / 0.9);

    componente[mvConcentrado].UltimoPrecoCompra := (objBase.fltPreUlt * fltFatorCon * fltVolumePro / 0.9);
    componente[mvDiluido].UltimoPrecoCompra := (objBase.fltPreUlt * fltFator * fltVolumePro / 0.9);

    componente[mvConcentrado].UltimoPrecoCompraImpostos := (objBase.fltImpUlt * fltFatorCon * fltVolumePro / 0.9);
    componente[mvDiluido].UltimoPrecoCompraImpostos := (objBase.fltImpUlt * fltFator * fltVolumePro / 0.9);

    componente[mvConcentrado].PrecoCompraLiquido := (objBase.fltComLiq * fltFatorCon * fltVolumePro / 0.9);
    componente[mvDiluido].PrecoCompraLiquido := (objBase.fltComLiq * fltFator * fltVolumePro / 0.9);

    componente[mvConcentrado].PrecoCusto := fltCusBasCon;
    componente[mvDiluido].PrecoCusto := fltCusBasDil;

    componente[mvConcentrado].PrecoCustoReal := fltCu2BasCon;
    componente[mvDiluido].PrecoCustoReal := fltCu2BasDil;

    componente[mvConcentrado].PrecoVenda := fltVenBasCon;
    componente[mvDiluido].PrecoVenda := fltVenBasDil;
  End;

  FOutValCon := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes;
  FOutValDil := tintaDeMaquina[mvDiluido].GetOutrosValoresComponentes;

  FIcmsaiCon := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes;
  FIcmsaiDil := tintaDeMaquina[mvDiluido].GetIcmsSaidaComponentes;

  FImpFedCon := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes;
  FImpFedDil := tintaDeMaquina[mvDiluido].GetImpostosFederaisComponentes;

  FDesOpeCon := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes;
  FDesOpeDil := tintaDeMaquina[mvDiluido].GetDespesasOperacionaisComponentes;

  FPreMedCon := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes;
  FPreMedDil := tintaDeMaquina[mvDiluido].GetPrecoMedioComponentes;

  FPrecoCusCon := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes;
  FPrecoCusDil := tintaDeMaquina[mvDiluido].GetPrecoCustoComponentes;

  FPrecoCu2Con := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes;
  FPrecoCu2Dil := tintaDeMaquina[mvDiluido].GetPrecoCustoRealComponentes;

  FPrecoVenCon := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes;
  FPrecoVenDil := tintaDeMaquina[mvDiluido].GetPrecoVendaComponentes;

  FPrecoVenCon := FPrecoVenCon + (fltPerAcr * FPrecoVenCon);
  FPrecoVenDil := FPrecoVenDil + (fltPerAcr * FPrecoVenDil);

  FPreUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraComponentes;
  FPreUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraComponentes;
  FImpUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraImpostosComponentes;
  FImpUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraImpostosComponentes;

  FComLiqCon := tintaDeMaquina[mvConcentrado].GetPrecoCompraLiquidoComponentes;
  FComLiqDil := tintaDeMaquina[mvDiluido].GetPrecoCompraLiquidoComponentes;

  If FPrecoVenCon > 0 Then
    FPrecoVenCon := FPrecoVenCon + fltAcrMob;

  If FPrecoVenDil > 0 Then
    FPrecoVenDil := FPrecoVenDil + fltAcrMob;
  
  pCarregaPrecosBases;
end;

procedure TFormulaSkyMixAutomotivaDinamica.pCarregaPrecosBases;
var
  intContador: Integer;
  objBase: TBaseAutomotiva;
  cdsCadBas: TUniClientDataSet;
  fltPreCusPro: Double;
  fltPreVenPro: Double;
  fltPreVenItem: Double;

  conf: IConfTinta;
  fltDesOpeTinta: Double;
begin
  conf := fGetConfTinta('SKY');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);
  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);

    If fCarregaPromocao(cdsCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreVenItem := fltPreVenPro;
      FPromoc := 'S';
    End
    Else
    Begin
      fltPreVenItem := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objBase.fltEmbala := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := cdsCadBas.FieldByName('BAS_PESESP').AsFloat;
    objBase.fltPreVen := fltPreVenItem;
    objBase.strImpDir := cdsCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := cdsCadBas.FieldByName('BAS_CODITE').AsString;

    objBase.fltOutVal := cdsCadBas.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := cdsCadBas.FieldByName('ITE_ICMSAI').AsFloat;
      
    objBase.fltImpFed := cdsCadBas.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := cdsCadBas.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objBase.fltPreMed := cdsCadBas.FieldByName('ITE_PREMED').AsFloat;
    objBase.fltImpUlt := cdsCadBas.FieldByName('ITE_IMPULT').AsFloat;
    objBase.fltPreUlt := cdsCadBas.FieldByName('ITE_PREULT').AsFloat;

    objBase.fltComLiq := fFormataFloat(fCalculaPrecoCompraLiq(cdsCadBas.Fieldbyname('ITE_PRECOM').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                              cdsCadBas.Fieldbyname('ITE_DESF02').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                              cdsCadBas.Fieldbyname('ITE_DESF04').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                              cdsCadBas.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
  End;

  FCalculo.Clear;
  FCalculo.Add('VolumeFormula  = ' + FloatToStrF(FVolumePro, ffFixed, 12, 4));
  FCalculo.Add('Fator = (Quantidade / Peso Específico / Emabalagem)');
  FCalculo.Add('Valor da Base = (Preço * Fator  *  Valor Produzido / 0.9)');
  FCalculo.Add('Preço da Tinta = (Soma do Valor da Base de todas as bases)');
end;

procedure TFormulaSkyMixAutomotivaDinamica.pCarregarColorantes;
begin
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_PESESP                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');
  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');
  qryCadBas.SQL.Add('   , ITE_PREMED                       ');

  qryCadBas.SQL.Add('   , ITE_PRECOM                       ');
  qryCadBas.SQL.Add('   , ITE_DESF01                       ');
  qryCadBas.SQL.Add('   , ITE_DESF02                       ');
  qryCadBas.SQL.Add('   , ITE_DESF03                       ');
  qryCadBas.SQL.Add('   , ITE_DESF04                       ');
  qryCadBas.SQL.Add('   , ITE_DESF05                       ');
  qryCadBas.SQL.Add('   , ITE_DESF06                       ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
  begin
    qryCadBas.SQL.Add('   , ITE_IMPFED                       ');
    qryCadBas.SQL.Add('   , ITE_DESOPE                       ');
    qryCadBas.SQL.Add('   , ITE_OUTVAL                       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , 0 AS ITE_IMPFED                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_DESOPE                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
  end;

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    qryCadBas.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
    qryCadBas.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
    qryCadBas.SQL.Add('   , BAS_ICMS__ AS ITE_ICMSAI         ');
    qryCadBas.SQL.Add('   , BAS_IPI___ AS ITE_IPISAI         ');
  end
  else if (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario then
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
    qryCadBas.SQL.Add('   , G.ITE_ICMSAI                     ');
    qryCadBas.SQL.Add('   , G.ITE_IPISAI                     ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
    qryCadBas.SQL.Add('   , G.ITE_ICMSAI                     ');
    qryCadBas.SQL.Add('   , G.ITE_IPISAI                     ');
  end;

  If fCfgSis('IMPDIG') = '1' Then
    qryCadBas.SQL.Add('   , I.ITE_IMPDIR                     ')
  else
    qryCadBas.SQL.Add('   , G.ITE_IMPDIR                     ');

  qryCadBas.SQL.Add(' FROM                                 ');
  qryCadBas.SQL.Add('   SKY_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  TClientDataSetFactory.GetClientDataSet(qryCadBas);
end;

function fRetornaPrecoSkyMixAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery; Var dicRetorno: TDicionario;
  blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
var
  strCodEmp     : String;
  strOpcDoc     : String;
  blnUsaPreCus  : Boolean;
  strTipEmb     : String;
  intQtdEmb     : Integer;
  strIteEmb     : String;
  strGruEmb     : String;
  strTipPre     : String;
  fltPreEmb     : Double;
  fltEmbala     : Double;
  fltPreCus     : Double;
  fltPreVen     : Double;
  strIteTin     : String;
  strMontad     : String;
  strA_n_o_     : String;
//  fltPrcTin     : Double;
  fltPrvTin     : Double;

  stlDesEmb     : TStringList;
  stlProEmbLt   : TStringList;
  stlGruEmbLt   : TStringList;
  stlProEmbGl   : TStringList;
  stlGruEmbGl   : TStringList;
  strProEmbCo   : String;
  strGruEbmCo   : String;
  strProEmbSp   : String;
  strGruEmbSp   : String;

  fltVolPro     : Double;
  strTabPre     : String;

  strSkyPqu: String;
  strSkyPga: String;

  strDesCor: String;
  strAuto: String;
  tinta: IConsultaTinta;
  conf: IConfTinta;
  cdsTinta: TUniClientDataSet;
begin
  Result := False;
  stlDesEmb := nil;
  stlProEmbGl := nil;
  stlGruEmbGl := nil;
  stlProEmbLt := nil;
  stlGruEmbLt := nil;
  Try
    Try
      strCodEmp    := dicRetorno['codemp'];
      strOpcDoc    := dicRetorno['opcdoc'];
      blnUsaPreCus := dicRetorno['usaprecus'];
      strTipEmb    := dicRetorno['tipemb'];
      intQtdEmb    := dicRetorno['qtdemb'];
      strTabPre    := dicRetorno['tabpre'];

      stlDesEmb := TStringList.Create;
      stlDesEmb.Add('LACA');
      stlDesEmb.Add('POLIESTER');
      stlDesEmb.Add('PU');
      stlDesEmb.Add('SINTÉTICO');
      stlDesEmb.Add('SKYFROTA(SFL)');
      stlDesEmb.Add('SKYFROTA(SFS)');
      stlDesEmb.Add('SKYFROTA(SFP)');

      If strTab = 'N' Then
      Begin
        strAuto := fConsultaSkyMixAutomotivaVendaDinamica(Sender, strCodEmp, qryTinta, strTabPre, blnFaturamento, dicRetorno, sltItems);

        If strAuto = '-1' Then
          Exit;
      End
      Else
        strAuto := strAutoTab;

      conf  := fGetConfTinta('SKY');
      tinta := TSkyMixConsulta.Create;

      qryTinta.Close;
      qryTinta.SQL.Text := TSkyMixConsulta.Create.fGetSelectAutoIncrem(strAuto);
      cdsTinta := TClientDataSetFactory.GetClientDataSet(qryTinta);

      strIteTin := cdsTinta.FieldByName('SKY_MD5KEY').AsString;

      strMontad := fRetornaMontadora(cdsTinta.FieldByName('SKY_CODMON').AsString);
      strA_n_o_ := cdsTinta.FieldByName('SKY_ANOFAB').AsString;

      stlProEmbGl :=  TStringList.Create;
      stlGruEmbGl :=  TStringList.Create;
      stlProEmbLt :=  TStringList.Create;
      stlGruEmbLt :=  TStringList.Create;

      strSkyPga := conf.fGet('SKYPGA'); //fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA', '');
      strSkyPqu := conf.fGet('SKYPQU'); //fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU', '');

      stlProEmbGl.Add(strSkyPga);
      stlProEmbGl.Add(conf.fGet('SKYPGA_POLIESTER')); //stlProEmbGl.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_POLIESTER', strSkyPga));
      stlProEmbGl.Add(conf.fGet('SKYPGA_PU'));        //stlProEmbGl.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_PU', strSkyPga));
      stlProEmbGl.Add(conf.fGet('SKYPGA_SINTETICO')); //stlProEmbGl.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_SINTETICO', strSkyPga));
      stlProEmbGl.Add(conf.fGet('SKYPGA_FROSFL'));
      stlProEmbGl.Add(conf.fGet('SKYPGA_FROSFS'));
      stlProEmbGl.Add(conf.fGet('SKYPGA_FROSFP'));

      stlGruEmbGl.Add(fRetGrupoItem(strSkyPga));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_POLIESTER'))); //stlGruEmbGl.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_POLIESTER', strSkyPga)));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_PU')));        //stlGruEmbGl.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_PU', strSkyPga)));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_SINTETICO'))); //stlGruEmbGl.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_SINTETICO', strSkyPga)));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_FROSFL')));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_FROSFS')));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_FROSFP')));

      stlProEmbLt.Add(strSkyPqu);
      stlProEmbLt.Add(conf.fGet('SKYPQU_POLIESTER')); //stlProEmbLt.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_POLIESTER', strSkyPqu));
      stlProEmbLt.Add(conf.fGet('SKYPQU_PU'));        //stlProEmbLt.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_PU', strSkyPqu));
      stlProEmbLt.Add(conf.fGet('SKYPQU_SINTETICO')); //stlProEmbLt.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_SINTETICO', strSkyPqu));
      stlProEmbLt.Add(conf.fGet('SKYPQU_FROSFL'));
      stlProEmbLt.Add(conf.fGet('SKYPQU_FROSFS'));
      stlProEmbLt.Add(conf.fGet('SKYPQU_FROSFP'));

      stlGruEmbLt.Add(fRetGrupoItem(strSkyPqu));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_POLIESTER'))); //stlGruEmbLt.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_POLIESTER', strSkyPqu)));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_PU')));        //stlGruEmbLt.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_PU', strSkyPqu)));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_SINTETICO'))); //stlGruEmbLt.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_SINTETICO', strSkyPqu)));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_FROSFL')));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_FROSFS')));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_FROSFP')));

      strProEmbCo := conf.fGet('SKYPCP'); //fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPCP', '');
      strGruEbmCo := fRetGrupoItem(strProEmbCo);

      strGruEmb := strGruEmb;
      If Not fDigDadosTintometricos(cdsTinta, stlDesEmb, stlProEmbLt, stlGruEmbLt, stlProEmbGl, stlGruEmbGl,
                                    strProEmbCo, strGruEbmCo, strProEmbSp, strGruEmbSp,
                                    strIteEmb, strGruEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                                    fltPreCus, fltPreVen, fltVolPro, strTabPre, dicRetorno) Then
        Exit;

      strDesCor := Trim(tinta.fGetDescricao(cdsTinta.FieldbyName('AUTOINCREM').AsString));
      dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

//      fltPrcTin := fltPreCus;
      If blnUsaPreCus Then
        fltPreVen := fltPreCus;

      fltPrvTin := fltPreVen;

      dicRetorno['precus'] := fltPreCus;
      dicRetorno['unitar'] := fltPreVen;
//      dicRetorno['prctin'] := fltPrcTin;
      dicRetorno['prvtin'] := fltPrvTin;
      dicRetorno['codite'] := conf.fGet('SKYPRO'); //fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPRO', '');
      dicRetorno['itetin'] := strIteTin;
      dicRetorno['tippre'] := strTipPre;

      dicRetorno['iteemb'] := strIteEmb;
      dicRetorno['gruemb'] := fRetGrupoItem(strIteEmb); //strGruEmb;
      dicRetorno['tipemb'] := strTipEmb;
      dicRetorno['qtdemb'] := intQtdEmb;
      dicRetorno['preemb'] := fltPreEmb;
      dicRetorno['embala'] := fltEmbala;
      dicRetorno['volpro'] := fltVolPro;

      dicRetorno['montad'] := strMontad;
      dicRetorno['a_n_o_'] := strA_n_o_;
      dicRetorno['chafor'] := strDesCor + strTipEmb;
      dicRetorno['descor'] := strDesCor;
      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlGruEmbGl) then FreeAndNil(stlGruEmbGl);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlGruEmbLt) then FreeAndNil(stlGruEmbLt);
  End;
end;

function fRetornaUniTraProSkyMixAutomotivaDinamica(strTipPre : String; fltPrcTin, fltPrvTin: Double): Double;
Var
  conf: IConfTinta;
begin
  conf := fGetConfTinta('SKY');
//  If fArqIniTinta(0, 'SkyMix Automotiva', 'SKYTRA', '0') = 'VEN' Then
  if conf.fGet('SKYTRA') = 'VEN' then
    Result :=  fltPrvTin * conf.fGetDouble('SKYFAT') //fStrToFloat(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYFAT', ''))
  Else
    Result :=  fltPrcTin * conf.fGetDouble('SKYFAT'); //fStrToFloat(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYFAT', ''));

  Result := fFormataFloat(Result, 2);
end;

procedure pRetornaTabelaPrecoSkyMixAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  objFormula: TFormulaSkyMixAutomotivaDinamica;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  strTabelas: string;
  calculadorFatVendas: ICalculadorFatVendas;
  strTabelaUnica: string;
  conf: IConfTinta;
  cdsConsulta: TUniClientDataSet;
begin
  conf := fGetConfTinta('SKY');
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaSkyMixAutomotivaDinamica.Create('1');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 0.9;
      objFormula.fltVolumePro := dicRetorno['volpro'];

      If TMultiSelectLocalizadorFactory.GetLocalizador('SKY').Localizar(cdsConsulta, ['ITETIN'], [dicRetorno['itetin']]) Then
        objFormula.fltAcrMob := cdsConsulta.FieldByName('SKY_ACRMOB').AsFloat;

      If dicRetorno['tippre'] = 'C' Then
        objFormula.mveModoVenda := mvConcentrado
      Else
        objFormula.mveModoVenda := mvDiluido;

      objFormula.fltFatorAcerto := fltFatorAcerto;

      objFormula.strCodEmb := dicRetorno['iteemb'];
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      
      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := dicRetorno['base' + fStrZero(intContador, 2)];
        If dicRetorno['tippre'] = 'C' Then
          objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro
        Else
          objBase.fltQtdDil := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * objFormula.fltVolumeOri / objFormula.fltVolumePro;
        objBase.strTipBas := 'B';
      End;

      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      strTabelaUnica := IfNull(dicRetorno['tabelaunica'], '');
      if not fEmptyStr(strTabelaUnica) then
      begin
        objFormula.strTabPre := strTabelaUnica;
        objFormula.pCarregarColorantes;
        objFormula.pCarregaPrecosBases;
        objFormula.pCalcularPrecos;

        If IfNull(dicRetorno['precus'], 0) <= 0 Then
        Begin
          If dicRetorno['tippre'] = 'C' Then
            dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
          Else
            dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
        End;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + strTabelaUnica] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
        End
        Else
        Begin
          dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
          dicRetorno['preve' + strTabelaUnica] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
        End;

        objFormula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
        dicRetorno['promoc'] := objFormula.StrPromoc;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
        End
        Else
        Begin
          dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
          dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
          dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
          dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;
        End;
      end
      else
      begin
        strTabelas := fCfgSis('TABPRC');
        If Length(strTabelas) < 7 Then
          strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

        For intContador := 1 To Length(strTabelas) Do
        Begin
          if strTabelas[intContador] = 'S' then
          begin
            objFormula.strTabPre := IntToStr(intContador);
            objFormula.pCarregarColorantes;
            objFormula.pCarregaPrecosBases;
            objFormula.pCalcularPrecos;

            If IfNull(dicRetorno['precus'], 0) <= 0 Then
            Begin
              If dicRetorno['tippre'] = 'C' Then
                dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem
              Else
                dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem;
            End;

            If dicRetorno['tippre'] = 'C' Then
            Begin
              dicRetorno['precu2'] := objFormula.fltPrecoCu2Con + objFormula.fltPrecoCusto2Embalagem;
              dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenCon + objFormula.fltPrecoEmbalagem;
            End
            Else
            Begin
              dicRetorno['precu2'] := objFormula.fltPrecoCu2Dil + objFormula.fltPrecoCusto2Embalagem;
              dicRetorno['preve' + IntToStr(intContador)] := objFormula.fltPrecoVenDil + objFormula.fltPrecoEmbalagem;
            End;

            if intContador = IfNull(dicRetorno['tabpre'], 0) then
            begin
              objFormula.pCalculaImpostosSaida(dicRetorno);
              dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
              dicRetorno['promoc'] := objFormula.StrPromoc;

              If dicRetorno['tippre'] = 'C' Then
              Begin
                dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
                dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
                dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
              End
              Else
              Begin
                dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
                dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
                dicRetorno['prctin'] := objFormula.fltComLiqDil + objFormula.fltPrecoCompraLiquidoEmbalagem;                
              End;
            end;

            If dicRetorno['tippre'] = 'C' Then
              dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem
            Else
              dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
          end;
        End;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(cdsConsulta) then FreeAndNil(cdsConsulta);
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
end;

function fRetornaMontadora(strCodMon: String): String;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(nil);
      qryGen.SQL.Text := 'SELECT MON_DESMON FROM SKY_CADMON WHERE MON_CODMON = :CODMON';
      qryGen.ParamByName('CODMON').AsString := strCodMon;
      Result := TClientDataSetFactory.GetClientDataSet(qryGen).FieldByName('MON_DESMON').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function fRetornaUniTraEmbSkymixAutomotiva(strTipEmb: String): Double;
  Var
    fltPreEmb: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('SKY');
  
  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('SKYPQU') //fStrToFloat(fArqIniTinta(0, 'Skymix Automotiva', 'SKYPQU', ''))
  Else
    fltPreEmb := conf.fGetDouble('SKYPGA'); //fStrToFloat(fArqIniTinta(0, 'Skymix Automotiva', 'SKYPGA', ''));

  conf := fGetConfTinta('BZA');

  Result := fltPreEmb * conf.fGetDouble('SKYFAT'); //fStrToFloat(fArqIniTinta(0, 'Brasimix Automotiva', 'SKYFAT', ''));
end;

function fConsultasSkyMixAutomotivaDinamicaInterna(Sender: TForm; qryCadSky: TUniQuery;
  tipoConsulta: TTipoConsulta; strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String; stdcall;
begin
  Result := (TSkyMixConsulta.Create).fExecutarConsulta(Sender,
    qryCadSky, tipoConsulta, strTabPre, TfrmConsultaCompSkyMix,
    '', blnFaturamento, dicRetorno, sltItems);
end;


{ TfrmConsultaCompSkyMix }

constructor TfrmConsultaCompSkyMix.Create(AOwner: TComponent;
  tipoConsulta: TTipoConsulta; strTabPre: String; tinta: IConsulta);
begin
  inherited Create(tipoConsulta, strTabPre, tinta);
  btnExecutaTarefa2.Visible := False;
  If (tipoConsulta <> tpcVenda) Then
  Begin
    btnExecutaTarefa.Visible  := True;
  End
  Else
    btnExecutaTarefa2.Visible  := True;
end;

procedure TfrmConsultaCompSkyMix.pTarefaFormulacao(Sender: TObject);
Var
  stlProEmbGl,
  stlGruEmbGl,
  stlProEmbLt,
  stlGruEmbLt,
  stlDesEmb: TStringList;
  strSkyPga: String;
  strSkyPqu: String;

  strProEmbCo,
  strGruEbmCo,
  strProEmbSp,
  strGruEmbSp,
  strIteEmb,
  strGruEmb,
  strTipEmb,
  strTipPre: String;
  intQtdEmb: Integer;
  fltPreEmb,
  fltEmbala,
  fltPreCus,
  fltPreVen,
  fltVolPro: Double;
  dicRetorno: TDicionario;

  qryGen: TUniQuery;
  conf: IConfTinta;
  cdsGen: TUniClientDataSet;
begin
  dicRetorno := nil;
  stlProEmbGl :=  nil;
  stlGruEmbGl :=  nil;
  stlProEmbLt :=  nil;
  stlGruEmbLt :=  nil;
  Try
    Try
      conf := fGetConfTinta('SKY');
      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM SKY_CADSKY WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      dicRetorno := TDicionario.Create;
      stlDesEmb := TStringList.Create;
      stlDesEmb.Add('LACA');
      stlDesEmb.Add('POLIESTER');
      stlDesEmb.Add('PU');
      stlDesEmb.Add('SINTÉTICO');
      stlDesEmb.Add('SKYFROTA(SFL)');
      stlDesEmb.Add('SKYFROTA(SFS)');
      stlDesEmb.Add('SKYFROTA(SFP)');

      stlProEmbGl :=  TStringList.Create;
      stlGruEmbGl :=  TStringList.Create;
      stlProEmbLt :=  TStringList.Create;
      stlGruEmbLt :=  TStringList.Create;

      strSkyPga := conf.fGet('SKYPGA'); //fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA', '');
      strSkyPqu := conf.fGet('SKYPQU'); //fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU', '');

      stlProEmbGl.Add(strSkyPga);
      stlProEmbGl.Add(conf.fGet('SKYPGA_POLIESTER')); //stlProEmbGl.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_POLIESTER', strSkyPga));
      stlProEmbGl.Add(conf.fGet('SKYPGA_PU'));        //stlProEmbGl.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_PU', strSkyPga));
      stlProEmbGl.Add(conf.fGet('SKYPGA_SINTETICO')); //stlProEmbGl.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_SINTETICO', strSkyPga));
      stlProEmbGl.Add(conf.fGet('SKYPGA_FROSFL'));
      stlProEmbGl.Add(conf.fGet('SKYPGA_FROSFS'));
      stlProEmbGl.Add(conf.fGet('SKYPGA_FROSFP'));

      stlGruEmbGl.Add(fRetGrupoItem(strSkyPga));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_POLIESTER'))); //stlGruEmbGl.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_POLIESTER', strSkyPga)));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_PU')));        //stlGruEmbGl.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_PU', strSkyPga)));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_SINTETICO'))); //stlGruEmbGl.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_SINTETICO', strSkyPga)));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_FROSFL')));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_FROSFS')));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_FROSFP')));

      stlProEmbLt.Add(strSkyPqu);
      stlProEmbLt.Add(conf.fGet('SKYPQU_POLIESTER')); //stlProEmbLt.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_POLIESTER', strSkyPqu));
      stlProEmbLt.Add(conf.fGet('SKYPQU_PU'));        //stlProEmbLt.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_PU', strSkyPqu));
      stlProEmbLt.Add(conf.fGet('SKYPQU_SINTETICO')); //stlProEmbLt.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_SINTETICO', strSkyPqu));
      stlProEmbLt.Add(conf.fGet('SKYPQU_FROSFL'));
      stlProEmbLt.Add(conf.fGet('SKYPQU_FROSFS'));
      stlProEmbLt.Add(conf.fGet('SKYPQU_FROSFP'));

      stlGruEmbLt.Add(fRetGrupoItem(strSkyPqu));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_POLIESTER'))); //stlGruEmbLt.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_POLIESTER', strSkyPqu)));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_PU')));        //stlGruEmbLt.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_PU', strSkyPqu)));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_SINTETICO'))); //stlGruEmbLt.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_SINTETICO', strSkyPqu)));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_FROSFL')));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_FROSFS')));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_FROSFP')));

      strProEmbCo := conf.fGet('SKYPCP');

      fDigDadosTintometricos(cdsGen, stlDesEmb, stlProEmbLt, stlGruEmbLt, stlProEmbGl, stlGruEmbGl,
                             strProEmbCo, strGruEbmCo, strProEmbSp, strGruEmbSp,
                             strIteEmb, strGruEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                             fltPreCus, fltPreVen, fltVolPro, strTabPre, dicRetorno);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicRetorno) then FreeAndNil(dicRetorno);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlGruEmbGl) then FreeAndNil(stlGruEmbGl);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlGruEmbLt) then FreeAndNil(stlGruEmbLt);
  End;
end;

procedure TfrmConsultaCompSkyMix.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompSkyMix.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadSkyNovasFormulas', False);
end;

function GetLinha(const strCodGru: string): string;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                      ' +
        '   GRU_LINHA_                ' +
        ' FROM                        ' +
        '   SKY_CADGRU                ' +
        ' WHERE GRU_CODGRU = :CODGRU  ';
      qryGen.ParamByName('CODGRU').AsString := strCodGru;
      Result := TClientDataSetFactory.GetClientDataSet(qryGen).FieldByName('GRU_LINHA_').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;  

end.

