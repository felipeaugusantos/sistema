unit untFarbenAutomotivaDinamica;

interface

uses
  Classes, Forms, Uni, untFuncoesSimples, SysUtils, DB, untFuncEspecificas,
  Math, Controls, strUtils, untTMatrizSaldosColorantes,
  untPnlBotoesAcoesNovaConsulta,
  UniClientDataSet;

Type
  TConsultaFarben = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TFormulaFarbenAutomotivaDinamica = class(TFormulaAutomotiva)
  private
    FblnNovaFormula: Boolean;
    fltPerAcr: Double;
    fltAcrMob: Double;
    procedure SetblnNovaFormula(const Value: Boolean);
  protected
  public
    procedure pCarregarColorantes; Override;
    procedure pCarregaPrecosBases; override;
    procedure pCalcularPrecos; Override;
    function fArredondaValor(fltValor: Double; intCasas: Integer): Double;
    function fTruncaValor(fltValor: Double; intCasas: Integer): Double;
    procedure pCalcularPesoGramas(strTipPrg: String);
    property blnNovaFormula: Boolean read FblnNovaFormula write SetblnNovaFormula;
    function fRetMatrizSaldosColorantes(): TClassMatrizSaldosColorantes; override;
    Constructor Create(strTabPre: String); override;

    function fRetornaFatorDensidade(strTipPrg: String; fltQtdCon, fltPesEsp: Double): Double;
    function fRetornaTotalDensidade(strTipPrg: String; fltPorcen, fltDensid: Double): Double;
    function fCasasDecimaisQtd(strTipPrg: String): Integer;

    function fCasasDecimaisFormulacao: Integer; override;
  end;

  function fConsultaFarbenAutomotivaDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaFarbenDinamicaVenda(Sender: TForm; qryTinta: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaFarbenInterna(Sender: TForm; qryTinta: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String;

  function fRetornaDescricaoFarbenAutomotivaDinamica(strDesCor: String): String;
  function fRetornaPrecoFarbenAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery;
    dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  function fDigDadosTintometricos(qryCadFar: TUniClientDataSet; stlDesEmb: TStringList; stlProEmbLt: TStringList;
            stlProEmbGl: TStringList; var strIteEmb: String; var strTipEmb: String; var strTipPre: String; var intQtdEmb: Integer;
            var fltPreEmb: Double; var fltEmbala: Double; var fltPreCus: Double; var fltPreVen: Double;
            var fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario; strProEmbCo: String; strProEmbSp: String; strProEmbTb: String; strProEmbSy: String): Boolean;
  function fRetornaUniTraProFarbenAutomotivaDinamica(fltPrcTin, fltPrvTin: Double):Double;
  function fGTinForFarbenAutomotivaDinamica(strIteTin, strTipPre: String; var arrFormul: TForMulTinDetArray;
            var arrBaixaPigmentos: TBaixaPigmentosArray; stlItensTraML: TStringList; fltVolPro: Double): Boolean;
  procedure pRetornaDadosFarbenAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
  function fRetornaUniTraEmbFarbenAutomotivaDinamica(strTipEmb: String): Double;
  procedure pRetornaTabelaPrecoFarbenAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);

implementation

uses
  untDigTintaAutomotivaFarben, untFuncoes,untIConsultaTinta,untClientDataSetFactory,untMultiSelectLocalizadorFactory,
  untTintaMaquina,untIConfTinta,untICalculadorFatVendas,untFarbenAutomotivaConsulta,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untTintaDeMaquinaComponenteComparerBaseAutomotiva;

{ FarbenAutomotivaDinamica }

function fConsultaFarbenAutomotivaDinamicaGeral(Sender: TForm): String;
var
  qryGen : TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaFarbenInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, Nil, Nil);
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

function fConsultaFarbenDinamicaVenda(Sender: TForm; qryTinta: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String;
begin
  Result := fConsultaFarbenInterna(Sender, qryTinta, tpcVenda, strTabPre, blnFaturamento, dicRetorno, sltItems);
end;

function fRetornaDescricaoFarbenAutomotivaDinamica(strDesCor: String): String;
begin
  Result := strDesCor;
end;

function fRetornaPrecoFarbenAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery;
  dicRetorno: TDicionario; blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = '';
  sltItems: TStringList = Nil): Boolean;
var
  strCodEmp: String;
  strOpcDoc: String;
  strTipPre: String;
  strTipEmb: String;
  intQtdEmb: Integer;
  blnUsaPreCus: Boolean;
  strMontad: String;
  strA_n_o_: String;

  strIteTin: String;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltUnitar: Double;
//  fltPrcTin: Double;
  fltPrvTin: Double;

  strIteEmb: String;

  fltVolPro: Double;

  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;

  strTabPre: String;

  strProEmbCo   : String;
  strProEmbSp   : String;
  strProEmbTb   : String;
  strProEmbSy   : String;

  strAuto: String;
  tinta : IConsultaTinta;
  strDesCor : String;
  conf: IConfTinta;
  cdsTinta: TUniClientDataSet;
begin
  Result := False;

  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  Try
    Try
      stlDesEmb   := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;

      strIteTin := '';
      strTipEmb := '';
      intQtdEmb := 0;
      fltPreEmb := 0.0;
      fltEmbala := 0.0;

      strCodEmp    := dicRetorno['codemp'];
      strOpcDoc    := dicRetorno['opcdoc'];
      strTipEmb    := dicRetorno['tipemb'];
      intQtdEmb    := dicRetorno['qtdemb'];
      blnUsaPreCus := dicRetorno['usaprecus'];
      strTabPre    := dicRetorno['tabpre'];

      If strTab = 'N' Then
      Begin
        strAuto := fConsultaFarbenDinamicaVenda(Sender, qryTinta, strTabPre, blnFaturamento, dicRetorno, sltItems);

        If (strAuto = '-1') Then
        Begin
          Exit;
        End;
      End
      Else
        strAuto := strAutoTab;

      conf  := fGetConfTinta('FAR');
      tinta := TFarbenAutomotivaConsulta.Create;

      qryTinta.Close;
      qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
      cdsTinta := TClientDataSetFactory.GetClientDataSet(qryTinta);

      strMontad := cdsTinta.FieldByName('FAR_MONTAD').AsString;
      strA_n_o_ := cdsTinta.FieldByName('FAR_A_N_O_').AsString;

      stlDesEmb.Add('NORMAL');
      stlProEmbLt.Add(conf.fGet('FARPLT'));
      stlProEmbGl.Add(conf.fGet('FARPGL'));

      strProEmbCo := conf.fGet('FARPCP');
      strProEmbSp := conf.fGet('FARPSP');
      strProEmbTb := conf.fGet('FARPTB');
      strProEmbSy := conf.fGet('FARPSY');

      strIteTin := cdsTinta.FieldByName('FAR_MD5KEY').AsString;
      dicRetorno['chafor'] := fRetornaDescricaoFarbenAutomotivaDinamica(strDesCor);

      fltPreCus := 0;
      fltUnitar := 0;

      If Not fDigDadosTintometricos(cdsTinta, stlDesEmb, stlProEmbLt, stlProEmbGl,
                                    strIteEmb, strTipEmb, strTipPre,
                                    intQtdEmb, fltPreEmb, fltEmbala, fltPreCus, fltUnitar, fltVolPro,
                                    strTabPre, dicRetorno, strProEmbCo, strProEmbSp, strProEmbTb, strProEmbSy) Then
        Exit;

      strDesCor := Trim(tinta.fGetDescricao(cdsTinta.FieldByName('AUTOINCREM').AsString));
      dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);
//      fltPrcTin := fltPreCus;

      If blnUsaPreCus Then
        fltUnitar := fltPreCus;

      fltPrvTin := fltUnitar;

      dicRetorno['precus'] := fltPreCus;
      dicRetorno['unitar'] := fltUnitar;
//      dicRetorno['prctin'] := fltPrcTin;
      dicRetorno['prvtin'] := fltPrvTin;
      dicRetorno['codite'] := conf.fGet('FARPRO');
      dicRetorno['itetin'] := strIteTin;

      dicRetorno['iteemb'] := strIteEmb;
      dicRetorno['tipemb'] := strTipEmb;
      dicRetorno['qtdemb'] := intQtdEmb;
      dicRetorno['preemb'] := fltPreEmb;
      dicRetorno['embala'] := fltEmbala;
      dicRetorno['volpro'] := fltVolPro;

      dicRetorno['montad'] := strMontad;
      dicRetorno['a_n_o_'] := strA_n_o_;
      dicRetorno['chafor'] := fRetornaDescricaoFarbenAutomotivaDinamica(strDesCor) + strTipEmb;
      dicRetorno['tippre'] := strTipPre;
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
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
  End;

end;


{ TFormulaFarbenAutomotivaDinamica }

Constructor TFormulaFarbenAutomotivaDinamica.Create(strTabPre: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('FAR');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

  fltAcrMob := 0;
end;


procedure TFormulaFarbenAutomotivaDinamica.pCalcularPrecos;
var
  intIndex: Integer;
  objBase: TBaseAutomotiva;

  fltPreCu2: Double;

  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;

  fltPreCusDil: Double;
  fltPreCu2Dil: Double;
  fltPreVenDil: Double;

  fltDesBasCon: Double;
  fltDesCamCon: Double;
  fltPreCusPro,
  fltPreVenPro : Double;
  cdsCadBas: TUniClientDataSet;

  componente: array[TModoVenda] of ITintaDeMaquinaComponente;

  procedure pZerarPrecos;
  begin
    fltDesBasCon := 0.0;
    fltDesCamCon := 0.0;
    FPrecoCusCon := 0.0;
    FPrecoVenCon := 0.0;
    FPrecoCusDil := 0;
    FPrecoVenDil := 0;

    FPrecoCu2Con := 0.0;
    FPrecoCu2Dil := 0.0;

    FOutValCon := 0;
    FIcmsaiCon := 0;
    FImpFedCon := 0;
    FDesOpeCon := 0;
    FPreMedCon := 0;

    FOutValDil := 0;
    FIcmsaiDil := 0;
    FImpFedDil := 0;
    FDesOpeDil := 0;
    FPreMedDil := 0;

    FComLiqCon := 0;
    FPreUltCon := 0;
    FImpUltCon := 0;

    FComLiqDil := 0;
    FPreUltDil := 0;
    FImpUltDil := 0;
  End;
begin
  inherited;

  pZerarPrecos;

  If fltVolumePro <= 0.0 Then
    fltVolumePro := 1;

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotiva(Items[intIndex]);

    If (Not blnComCatalisador) And (objBase.strTipBas = 'C') Then
    Begin
      Continue;
    End;

    If (objBase.strTipBas = 'D') And (Self.FModoVenda = mvConcentrado) Then
    Begin
      Continue;
    End;

    If (Not cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, [])) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('Base ' + objBase.strCodBas + ' não cadastrada. Favor verificar.');
    End;

    If (fEmptyStr(cdsCadBas.FieldByName('BAS_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
    End;

    If (cdsCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + cdsCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
    End;

    If (cdsCadBas.FieldByName('BAS_DENSID').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' está com o peso específico zerado.' + #13#10 +
                             'Favor verificar.');
    End;

    If (cdsCadBas.FieldByName('BAS_EMBALA').IsNull) Or (cdsCadBas.FieldByName('BAS_EMBALA').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' não está com a embalagem configurada' + #13#10 +
                             'Favor verificar.');
    End;

    if not IsItemAtivo(cdsCadBas.FieldByName('BAS_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [cdsCadBas.FieldByName('BAS_CODITE').AsString]);
    end;

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

    If fCarregaPromocao(cdsCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreCusBas := fltPreCusPro;
      fltPreVenBas := fltPreVenPro;
      FPromoc := 'S';

      If fltPreCusBas = 0 Then
        fltPreCusBas := cdsCadBas.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPreCusBas := cdsCadBas.FieldByName('ITE_PRECUS').AsFloat;
      fltPreVenBas := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    fltPreCu2 := fCalculaPrecoCusto2(fltPreVenBas,
                                     fltPreCusBas,
                                     objBase.fltOutVal,
                                     objBase.fltIcmSai,
                                     objBase.fltImpFed,
                                     objBase.fltDesOpe);

    fltPreCusDil := (fltVolumePro / 0.9) * fltPreCusBas * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    fltPreCu2Dil := (fltVolumePro / 0.9) * fltPreCu2    * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    fltPreVenDil := (fltVolumePro / 0.9) * fltPreVenBas * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

    fltPreCusBas := (fltVolumePro / 0.9) * fltPreCusBas * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    fltPreCu2Bas := (fltVolumePro / 0.9) * fltPreCu2    * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    fltPreVenBas := (fltVolumePro / 0.9) * fltPreVenBas * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

    componente[mvConcentrado].Quantidade                := (fltVolumePro / 0.9) * objBase.fltQtdCon;
    componente[mvDiluido].Quantidade                    := (fltVolumePro / 0.9) * objBase.fltQtdDil;

    componente[mvConcentrado].OutrosValores             := (fltVolumePro / 0.9) * objBase.fltOutVal * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    componente[mvConcentrado].PrecoMedio                := (fltVolumePro / 0.9) * objBase.fltPreMed * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    componente[mvConcentrado].UltimoPrecoCompra         := (fltVolumePro / 0.9) * objBase.fltPreUlt * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    componente[mvConcentrado].UltimoPrecoCompraImpostos := (fltVolumePro / 0.9) * objBase.fltImpUlt * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    componente[mvConcentrado].PrecoCompraLiquido        := (fltVolumePro / 0.9) * objBase.fltComLiq * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    componente[mvConcentrado].IcmsSaida                 := objBase.fltIcmSai * fltPreVenBas / 100;
    componente[mvConcentrado].ImpostosFederais          := objBase.fltImpFed * fltPreVenBas / 100;
    componente[mvConcentrado].DespesasOperacionais      := objBase.fltDesOpe * fltPreVenBas / 100;
    componente[mvConcentrado].PrecoCusto                := fltPreCusBas;
    componente[mvConcentrado].PrecoCustoReal            := fltPreCu2Bas;
    componente[mvConcentrado].PrecoVenda                := fltPreVenBas;

    componente[mvDiluido].OutrosValores                 := (fltVolumePro / 0.9) * objBase.fltOutVal * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    componente[mvDiluido].PrecoMedio                    := (fltVolumePro / 0.9) * objBase.fltPreMed * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    componente[mvDiluido].UltimoPrecoCompra             := (fltVolumePro / 0.9) * objBase.fltPreUlt * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    componente[mvDiluido].UltimoPrecoCompraImpostos     := (fltVolumePro / 0.9) * objBase.fltImpUlt * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    componente[mvDiluido].PrecoCompraLiquido            := (fltVolumePro / 0.9) * objBase.fltComLiq * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    componente[mvDiluido].IcmsSaida                     := objBase.fltIcmSai * fltPreVenDil / 100;
    componente[mvDiluido].ImpostosFederais              := objBase.fltImpFed * fltPreVenDil / 100;
    componente[mvDiluido].DespesasOperacionais          := objBase.fltDesOpe * fltPreVenDil / 100;
    componente[mvDiluido].PrecoCusto                    := fltPreCusDil;
    componente[mvDiluido].PrecoCustoReal                := fltPreCu2Dil;
    componente[mvDiluido].PrecoVenda                    := fltPreVenDil;

{
    fltPreCusDil := (fltVolumePro / 0.9) * fltPreCusBas * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    fltPreCu2Dil := (fltVolumePro / 0.9) * fltPreCu2    * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    fltPreVenDil := (fltVolumePro / 0.9) * fltPreVenBas * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

    fltPreCusBas := (fltVolumePro / 0.9) * fltPreCusBas * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    fltPreCu2Bas := (fltVolumePro / 0.9) * fltPreCu2    * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    fltPreVenBas := (fltVolumePro / 0.9) * fltPreVenBas * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

    FOutValCon := FOutValCon + (fltVolumePro / 0.9) * objBase.fltOutVal * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    FOutValDil := FOutValDil + (fltVolumePro / 0.9) * objBase.fltOutVal * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

    FIcmsaiCon := FIcmsaiCon + objBase.fltIcmSai * fltPreVenBas / 100;
    FIcmsaiDil := FIcmsaiDil + objBase.fltIcmSai * fltPreVenDil / 100;

    FImpFedCon := FImpFedCon + objBase.fltImpFed * fltPreVenBas / 100;
    FImpFedDil := FImpFedDil + objBase.fltImpFed * fltPreVenDil / 100;

    FDesOpeCon := FDesOpeCon + objBase.fltDesOpe * fltPreVenBas / 100;
    FDesOpeDil := FDesOpeDil + objBase.fltDesOpe * fltPreVenDil / 100;

    FPreMedCon := FPreMedCon + (fltVolumePro / 0.9) * objBase.fltPreMed * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    FPreMedDil := FPreMedDil + (fltVolumePro / 0.9) * objBase.fltPreMed * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

    FComLiqCon := FComLiqCon + (fltVolumePro / 0.9) * objBase.fltComLiq * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    FComLiqDil := FComLiqDil + (fltVolumePro / 0.9) * objBase.fltComLiq * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

    FPreUltCon := FPreUltCon + (fltVolumePro / 0.9) * objBase.fltPreUlt * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    FPreUltDil := FPreUltDil + (fltVolumePro / 0.9) * objBase.fltPreUlt * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

    FImpUltCon := FImpUltCon + (fltVolumePro / 0.9) * objBase.fltImpUlt * (objBase.fltQtdCon / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);
    FImpUltDil := FImpUltDil + (fltVolumePro / 0.9) * objBase.fltImpUlt * (objBase.fltQtdDil / objBase.fltPesEsp / cdsCadBas.FieldByName('BAS_EMBALA').AsFloat);

    FPrecoCusCon := FPrecoCusCon + fltPreCusBas;
    FPrecoCu2Con := FPrecoCu2Con + fltPreCu2Bas;
    FPrecoVenCon := FPrecoVenCon + fltPreVenBas;

    FPrecoCusDil := FPrecoCusDil + fltPreCusDil;
    FPrecoCu2Dil := FPrecoCu2Dil + fltPreCu2Dil;
    FPrecoVenDil := FPrecoVenDil + fltPreVenDil;
}
  End;

  FOutValCon := tintaDeMaquina[mvConcentrado].GetOutrosValoresComponentes;
  FOutValDil := tintaDeMaquina[mvDiluido].GetOutrosValoresComponentes;

  FPreMedCon := tintaDeMaquina[mvConcentrado].GetPrecoMedioComponentes;
  FPreMedDil := tintaDeMaquina[mvDiluido].GetPrecoMedioComponentes;

  FPreUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraComponentes;
  FPreUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraComponentes;

  FImpUltCon := tintaDeMaquina[mvConcentrado].GetUltimoPrecoCompraImpostosComponentes;
  FImpUltDil := tintaDeMaquina[mvDiluido].GetUltimoPrecoCompraImpostosComponentes;

  FComLiqCon := tintaDeMaquina[mvConcentrado].GetPrecoCompraLiquidoComponentes;
  FComLiqDil := tintaDeMaquina[mvDiluido].GetPrecoCompraLiquidoComponentes;

  FIcmsaiCon := tintaDeMaquina[mvConcentrado].GetIcmsSaidaComponentes;
  FIcmsaiDil := tintaDeMaquina[mvDiluido].GetIcmsSaidaComponentes;

  FImpFedCon := tintaDeMaquina[mvConcentrado].GetImpostosFederaisComponentes;
  FImpFedDil := tintaDeMaquina[mvDiluido].GetImpostosFederaisComponentes;

  FDesOpeCon := tintaDeMaquina[mvConcentrado].GetDespesasOperacionaisComponentes;
  FDesOpeDil := tintaDeMaquina[mvDiluido].GetDespesasOperacionaisComponentes;

  FPrecoCusCon := tintaDeMaquina[mvConcentrado].GetPrecoCustoComponentes;
  FPrecoCusDil := tintaDeMaquina[mvDiluido].GetPrecoCustoComponentes;

  FPrecoCu2Con := tintaDeMaquina[mvConcentrado].GetPrecoCustoRealComponentes;
  FPrecoCu2Dil := tintaDeMaquina[mvDiluido].GetPrecoCustoRealComponentes;

  FPrecoVenCon := tintaDeMaquina[mvConcentrado].GetPrecoVendaComponentes;
  FPrecoVenDil := tintaDeMaquina[mvDiluido].GetPrecoVendaComponentes;

  FPrecoVenCon := FPrecoVenCon + (fltPerAcr * FPrecoVenCon);
  FPrecoVenDil := FPrecoVenDil + (fltPerAcr * FPrecoVenDil);

{
  FPrecoVenCon := FPrecoVenCon + (fltPerAcr * FPrecoVenCon);
  FPrecoVenDil := FPrecoVenDil + (fltPerAcr * FPrecoVenDil);
}

  If FPrecoVenCon > 0 Then
    FPrecoVenCon := FPrecoVenCon + fltAcrMob;

  If FPrecoVenDil > 0 Then
    FPrecoVenDil := FPrecoVenDil + fltAcrMob;

  pCarregaPrecosBases;
end;

procedure TFormulaFarbenAutomotivaDinamica.pCarregaPrecosBases;
var
  intContador: Integer;
  objBase: TBaseAutomotiva;
  cdsCadBas: TUniClientDataSet;
  conf: IConfTinta;
  fltDesOpeTinta: Double;
  fltPreCusPro,
  fltPreVenPro,
  fltPreVenItem: Double;
begin
  conf := fGetConfTinta('FAR');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);
  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);

    objBase.fltEmbala := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := cdsCadBas.FieldByName('BAS_DENSID').AsFloat;

    If fCarregaPromocao(cdsCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreVenItem := fltPreVenPro;
    End
    Else
    Begin
      fltPreVenItem := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objBase.strImpDir := cdsCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := cdsCadBas.FieldByName('BAS_CODITE').AsString;
    objBase.fltPreVen := fltPreVenItem;

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
    objBase.fltComLiq := fCalculaPrecoCompraLiq(cdsCadBas.Fieldbyname('ITE_PRECOM').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF02').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF04').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF06').AsFloat);
  End;

  FCalculo.Clear;
  FCalculo.Add('VolumeFormula  = ' + FloatToStrF(FVolumePro, ffFixed, 12, 4));
  FCalculo.Add('Valor da Base  = (Qtde. Concentrado * Preço) / (Embalagem * Peso Específico)');
  FCalculo.Add('Preço da Tinta = Soma(Valores de Base) * Volume Produzido / VolumeFormula');

end;

procedure TFormulaFarbenAutomotivaDinamica.pCarregarColorantes;
begin
  inherited;
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_DENSID                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');

  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');

  qryCadBas.SQL.Add('   , ITE_PRECOM                       ');
  qryCadBas.SQL.Add('   , ITE_DESF01                       ');
  qryCadBas.SQL.Add('   , ITE_DESF02                       ');
  qryCadBas.SQL.Add('   , ITE_DESF03                       ');
  qryCadBas.SQL.Add('   , ITE_DESF04                       ');
  qryCadBas.SQL.Add('   , ITE_DESF05                       ');
  qryCadBas.SQL.Add('   , ITE_DESF06                       ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
  begin
    qryCadBas.SQL.Add('   , ITE_ICMSAI                       ');
    qryCadBas.SQL.Add('   , ITE_IMPFED                       ');
    qryCadBas.SQL.Add('   , ITE_DESOPE                       ');
    qryCadBas.SQL.Add('   , ITE_OUTVAL                       ');
    qryCadBas.SQL.Add('   , ITE_PREMED                       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_IMPFED                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_DESOPE                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
    qryCadBas.SQL.Add('   , 0 AS ITE_PREMED                  ');
  end;

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    qryCadBas.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
    qryCadBas.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
  end
  else if (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and FBlnCalculaUnitario then
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                     ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
  end;

  If fCfgSis('IMPDIG') = '1' Then
    qryCadBas.SQL.Add('   , I.ITE_IMPDIR                     ')
  else
    qryCadBas.SQL.Add('   , G.ITE_IMPDIR                     ');

  qryCadBas.SQL.Add(' FROM                                 ');
  qryCadBas.SQL.Add('   FAR_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
end;

function fDigDadosTintometricos(qryCadFar: TUniClientDataSet; stlDesEmb: TStringList; stlProEmbLt: TStringList;
  stlProEmbGl: TStringList; var strIteEmb: String;
  var strTipEmb: String; var strTipPre: String; var intQtdEmb: Integer;
  var fltPreEmb: Double; var fltEmbala: Double; var fltPreCus: Double; var fltPreVen: Double;
  var fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario; strProEmbCo: String; strProEmbSp: String; strProEmbTb: String; strProEmbSy: String): Boolean;
var
  objBase: TBaseAutomotiva;
  objFormula: TFormulaFarbenAutomotivaDinamica;
  intContador: Integer;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
Begin
  Result := False;
  objFormula := nil;
  frmDigTintaAutomotivaFarben := nil;
  conf := fGetConfTinta('FAR');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaFarbenAutomotivaDinamica.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');
      objFormula.blnNovaFormula := LeftStr(qryCadFar.FieldByName('FAR_CODNFM').AsString, 3) = 'ESP';
      objFormula.strDescri    := qryCadFar.FieldByName('FAR_DESCRI').AsString;

      objFormula.fltAcrMob := qryCadFar.FieldByName('FAR_ACRMOB').AsFloat;

      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(qryCadFar.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString)) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryCadFar.FieldByName('FAR_CODB' + fStrZero(intContador, 2)).AsString;
        objBase.fltQtdCon := qryCadFar.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat;
        objBase.fltQtdDil := qryCadFar.FieldByName('FAR_QTDD' + fStrZero(intContador, 2)).AsFloat;
        If qryCadFar.FieldByName('FAR_QTDC' + fStrZero(intContador, 2)).AsFloat = 0 Then
          objBase.strTipBas := 'D'
        Else
          objBase.strTipBas := 'B'

      End;

      objFormula.pCarregaPrecosBases;
      objFormula.pCalcularPesoGramas(qryCadFar.FieldByName('FAR_TIPPRG').AsString);

      pCriarFormularios(TfrmDigTintaAutomotivaFarben, frmDigTintaAutomotivaFarben);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      objFormula.fltVolumeOri := 0.9;
      objFormula.FVolumePro := 0.9;
      frmDigTintaAutomotivaFarben.objFormula  := objFormula;
      frmDigTintaAutomotivaFarben.stlDesEmb   := stlDesEmb;
      frmDigTintaAutomotivaFarben.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotivaFarben.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotivaFarben.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotivaFarben.strProEmbSp := strProEmbSp;
      frmDigTintaAutomotivaFarben.strProEmbTb := strProEmbTb;
      frmDigTintaAutomotivaFarben.strProEmbSy := strProEmbSy;
      frmDigTintaAutomotivaFarben.Caption     := frmDigTintaAutomotivaFarben.Caption + 'Farben Automotiva';

      frmDigTintaAutomotivaFarben.strIdePro   := dicRetorno['idepro'];

      Result := (frmDigTintaAutomotivaFarben.ShowModal = mrOk);

      If (Result) Then
      Begin
        strIteEmb := frmDigTintaAutomotivaFarben.objFormula.strCodEmb;

        Case frmDigTintaAutomotivaFarben.objFormula.tpeTipEmb of
          teLitro  : begin
                       strTipEmb := 'LT';
                       fltEmbala := 0.900;
                     end;
          teLata   : begin
                       strTipEmb := 'LA';
                       fltEmbala := 18.000;
                     end;
          teGalao  : begin
                       strTipEmb := 'GL';
                       fltEmbala := 3.600;
                     end;
          teCopo   : begin
                       strTipEmb := 'CP';
                       fltEmbala := 0.450;
                     end;
          teSpray  : begin
                       strTipEmb := 'SP';
                       fltEmbala := 0.400;
                     end;
          teTambor : begin
                       strTipEmb := 'TB';
                       fltEmbala := 200.000;
                     end;
        end;


        strTipPre := IIF(frmDigTintaAutomotivaFarben.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotivaFarben.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotivaFarben.objFormula.fltPrecoEmbalagem;

        If (frmDigTintaAutomotivaFarben.rdgModoVenda.ItemIndex = 0) Then
        Begin
          fltPreCus := frmDigTintaAutomotivaFarben.objFormula.fltPrecoCusCon;
          fltPreCu2 := frmDigTintaAutomotivaFarben.objFormula.fltPrecoCu2Con;
          fltPreVen := frmDigTintaAutomotivaFarben.objFormula.fltPrecoVenCon;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotivaFarben.objFormula.fltPrecoCusDil;
          fltPreCu2 := frmDigTintaAutomotivaFarben.objFormula.fltPrecoCu2Dil;
          fltPreVen := frmDigTintaAutomotivaFarben.objFormula.fltPrecoVenDil;
        End;

        dicRetorno['premed'] := IfThen(frmDigTintaAutomotivaFarben.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaFarben.objFormula.fltPreMedCon,
          frmDigTintaAutomotivaFarben.objFormula.fltPreMedDil) +
          frmDigTintaAutomotivaFarben.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotivaFarben.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaFarben.objFormula.fltImpUltCon,
          frmDigTintaAutomotivaFarben.objFormula.fltImpUltDil) +
          frmDigTintaAutomotivaFarben.objFormula.fltUltimoImpostoEmbalagem;

        dicRetorno['preult'] := IfThen(frmDigTintaAutomotivaFarben.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaFarben.objFormula.fltPreUltCon,
          frmDigTintaAutomotivaFarben.objFormula.fltPreUltDil) +
          frmDigTintaAutomotivaFarben.objFormula.fltPreUltEmbalagem;

        dicRetorno['prctin'] := IfThen(frmDigTintaAutomotivaFarben.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaFarben.objFormula.fltComLiqCon,
          frmDigTintaAutomotivaFarben.objFormula.fltComLiqDil) +
          frmDigTintaAutomotivaFarben.objFormula.fltPrecoCompraLiquidoEmbalagem;

        fltPreCus := fltPreCus + frmDigTintaAutomotivaFarben.objFormula.fltPrecoCustoEmbalagem;
        fltPreCu2 := fltPreCu2 + frmDigTintaAutomotivaFarben.objFormula.fltPrecoCusto2Embalagem;
        fltPreVen := fltPreVen + fltPreEmb;

        fltVolPro := frmDigTintaAutomotivaFarben.objFormula.fltVolumePro;

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;

        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        dicRetorno['promoc']      := objFormula.StrPromoc;
        objFormula.pCalculaImpostosSaida(dicRetorno);

        dicRetorno['obscolorista']   := frmDigTintaAutomotivaFarben.edtDescricaoColorista.Text;
        dicRetorno['tipoformulacao'] := frmDigTintaAutomotivaFarben.rdgTipoFormula.ItemIndex;

        dicRetorno['saldocols'] := frmDigTintaAutomotivaFarben.blnSaldoSuficiente;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotivaFarben.matrizSaldosColorantes);
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
    if Assigned(objFormula) then FreeAndNil(objFormula);
    if Assigned(frmDigTintaAutomotivaFarben) then FreeAndNil(frmDigTintaAutomotivaFarben);
  End;
end;

function fRetornaUniTraProFarbenAutomotivaDinamica(fltPrcTin, fltPrvTin: Double):Double;
Var
  conf: IConfTinta;
begin
  conf  := fGetConfTinta('FAR');

  If conf.fGet('FARPRE') = 'VEN' Then
    Result :=  fltPrvTin * conf.fGetDouble('FARFAT')
  Else
    Result :=  fltPrcTin * conf.fGetDouble('FARFAT');

  Result := fFormataFloat(Result, 2);
end;

function fGTinForFarbenAutomotivaDinamica(strIteTin, strTipPre: String; var arrFormul: TForMulTinDetArray;
            var arrBaixaPigmentos: TBaixaPigmentosArray; stlItensTraML: TStringList; fltVolPro: Double): Boolean;
var
  strSQL      : String;
  qryConsulta : TUniQuery;
  intCont     : Integer;
  strCamFor   : String;
  strCamQtd   : String;
  dicBases    : TDicionario;
  strBases    : String;
  blnNovaFormula: Boolean;
  cdsConsulta: TUniClientDataSet;

  fltTotalPorcentagem: Double;
  fltTotalDensidade: Double;
  fltFatorDensidade: Double;
  intForm: Integer;  

  function fTruncaValor(fltValor: Double; intCasas: Integer): Double;
  begin
    Result := fStrToFloat ( ( FloatToStr(Int(fltValor)) ) + Copy(FloatToStr(Frac(fltValor)), 2, (intCasas + 1) ) );
  end;

  function fArredondaValor(fltValor: Double; intCasas: Integer): Double;
  begin
    Result := fStrToFloat(FormatFloat('0.' + fStrZero(0, intCasas), fltValor));
  end;
begin
  Result := False;
  qryConsulta := nil;
  dicBases := nil;
  Try
    Try
      if not TMultiSelectLocalizadorFactory.GetLocalizador('FAR').Localizar(cdsConsulta, ['ITETIN'], [strIteTin]) then
        Exit;

      blnNovaFormula := LeftStr(cdsConsulta.FieldByName('FAR_CODNFM').AsString, 3) = 'ESP';

      fltTotalPorcentagem := 0;
      fltTotalDensidade := 0;
      intForm := 1;      

      For intCont := 1 To 20 Do
      Begin
        strCamFor := 'FAR_CODB' + fStrZero(intCont, 2);
        If strTipPre  = 'C' Then
          strCamQtd := 'FAR_QTDC' + fStrZero(intCont, 2)
        Else
          strCamQtd := 'FAR_QTDD' + fStrZero(intCont, 2);

        If fEmptyStr(cdsConsulta.FieldByName(strCamFor).AsString) Then
          Continue;

        if cdsConsulta.FieldByName(strCamQtd).AsFloat <= 0 then
          Continue;

        arrFormul[intForm].strFormul := cdsConsulta.FieldByName(strCamFor).AsString;
        arrFormul[intForm].fltQtdbas := cdsConsulta.FieldByName(strCamQtd).AsFloat;
        fltTotalPorcentagem := fltTotalPorcentagem + arrFormul[intForm].fltQtdbas;
        strBases := strBases + QuotedStr(arrFormul[intForm].strFormul) + ', ';
        Inc(intForm);
      End;

      strBases := Trim(strBases);
      strBases := Copy(strBases, 1, Length(strBases) - 1);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  BAS_CODBAS, ';
      strSQL := strSQL + '  BAS_CODITE, ';
      strSQL := strSQL + '  BAS_DENSID  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  FAR_CADBAS ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  BAS_CODBAS IN (' + strBases + ') ';

      qryConsulta := fCriaQuery;
      qryConsulta.Close;
      qryConsulta.SQL.Text := strSQL;
      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      dicBases := TDicionario.Create;

      For intCont := 1 To 20 Do
      Begin
        If fEmptyStr(arrFormul[intCont].strFormul) Then
          Continue;

        cdsConsulta.Locate('BAS_CODBAS', arrFormul[intCont].strFormul, []);

        Try
          fltFatorDensidade :=  fTruncaValor(arrFormul[intCont].fltQtdbas / cdsConsulta.FieldByName('BAS_DENSID').AsFloat, 2);
        Except
          fltFatorDensidade :=  1;
        End;

        fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
      End;

      Try
        fltTotalDensidade := fTruncaValor(fltTotalPorcentagem / fltTotalDensidade, 2);
      Except
        fltTotalDensidade := 1;
      End;


      For intCont := 1 To 20 Do
      Begin
       If fEmptyStr(arrFormul[intCont].strFormul) Then
          Continue;

        If blnNovaFormula Then
        Begin
          arrFormul[intCont].fltQtdbas := arrFormul[intCont].fltQtdbas * fltVolPro / 0.9;
          dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
        End
        Else
        Begin
          arrFormul[intCont].fltQtdbas := fArredondaValor(fltVolPro * fltTotalDensidade * (arrFormul[intCont].fltQtdbas / 100) * 1000, 5);
          dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
        End;
      End;

      SetLength(arrBaixaPigmentos, cdsConsulta.RecordCount);
      cdsConsulta.First;

      While (Not cdsConsulta.Eof) Do
      Begin
        stlItensTraMl.Add(cdsConsulta.FieldByName('BAS_CODITE').AsString);
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].strCodIte := cdsConsulta.FieldByName('BAS_CODITE').AsString;
        arrBaixaPigmentos[cdsConsulta.RecNo - 1].fltQtdBaixa := dicBases[cdsConsulta.FieldByName('BAS_CODBAS').AsString];
        cdsConsulta.Next;
      End;

      Result := True;
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

procedure pRetornaDadosFarbenAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
var
  cdsCadFar: TUniClientDataSet;
begin
  if TMultiSelectLocalizadorFactory.GetLocalizador('FAR').Localizar(cdsCadFar, ['ITETIN'], [strIteTin]) then
  begin
    dicRetorno['codtin'] := cdsCadFar.FieldByName('FAR_CODSEQ').AsString;
    dicRetorno['montad'] := cdsCadFar.FieldByName('FAR_MONTAD').AsString;
    dicRetorno['martin'] := cdsCadFar.FieldByName('FAR_LINHA_').AsString;
  end;
end;

procedure pRetornaTabelaPrecoFarbenAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  objFormula: TFormulaFarbenAutomotivaDinamica;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  strCodBas: String;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
  strTabelaUnica: String;
  cdsConsulta: TUniClientDataSet;
begin
  conf := fGetConfTinta('FAR');
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaFarbenAutomotivaDinamica.Create('1');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 0.9;
      objFormula.fltVolumePro := 0.9; //dicRetorno['volpro'];

      if TMultiSelectLocalizadorFactory.GetLocalizador('FAR').Localizar(cdsConsulta, ['ITETIN'], [dicRetorno['itetin']]) then
        objFormula.fltAcrMob := cdsConsulta.FieldByName('FAR_ACRMOB').AsFloat;

      If dicRetorno['tippre'] = 'C' Then
        objFormula.mveModoVenda := mvConcentrado
      Else
        objFormula.mveModoVenda := mvDiluido;

      objFormula.fltFatorAcerto := fltFatorAcerto;

      objFormula.strCodEmb := dicRetorno['iteemb'];

      For intContador := 1 To 15 Do
      Begin

        strCodBas := IfNull(dicRetorno['base' + fStrZero(intContador, 2)], '');

        If (fEmptyStr(strCodBas)) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := strCodBas;
        If dicRetorno['tippre'] = 'C' Then
          objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3)
        Else
          objBase.fltQtdDil := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3);
        objBase.strTipBas := 'B';
      End;

      dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

      strTabelaUnica := IfNull(dicRetorno['tabelaunica'], '');
      If Not fEmptyStr(strTabelaUnica) Then
      Begin
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
      End
      Else
      Begin
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
                dicRetorno['precus'] := objFormula.fltPrecoCusCon + objFormula.fltPrecoCustoEmbalagem * objFormula.fltVolumeOri / objFormula.fltVolumePro
              Else
                dicRetorno['precus'] := objFormula.fltPrecoCusDil + objFormula.fltPrecoCustoEmbalagem * objFormula.fltVolumeOri / objFormula.fltVolumePro;
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
            Begin
              objFormula.pCalculaImpostosSaida(dicRetorno);
              dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
              dicRetorno['promoc'] := objFormula.StrPromoc;
            End;

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
          end;
        End;
      End;
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

function fRetornaUniTraEmbFarbenAutomotivaDinamica(strTipEmb: String): Double;
var
  fltPreEmb: Double;
  conf: IConfTinta;
begin
  conf := fGetConfTinta('FAR');

  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('FARPLT')
  Else
    fltPreEmb := conf.fGetDouble('FARPGL');

  Result := fltPreEmb * conf.fGetDouble('FARFAT'); 
end;

function TFormulaFarbenAutomotivaDinamica.fArredondaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := fStrToFloat(FormatFloat('0.' + fStrZero(0, intCasas), fltValor));
end;

function TFormulaFarbenAutomotivaDinamica.fCasasDecimaisFormulacao: Integer;
begin
  Result := 4;
end;

function TFormulaFarbenAutomotivaDinamica.fCasasDecimaisQtd(
  strTipPrg: String): Integer;
begin
  Result := 4;

  If MatchStr(strTipPrg, ['1', '2']) Then
    Result := 5;
end;

function TFormulaFarbenAutomotivaDinamica.fTruncaValor(fltValor: Double;
  intCasas: Integer): Double;
begin
  Result := fStrToFloat ( ( FloatToStr(Int(fltValor)) ) + Copy(FloatToStr(Frac(fltValor)), 2, (intCasas + 1) ) );
end;

procedure TFormulaFarbenAutomotivaDinamica.pCalcularPesoGramas(strTipPrg: String);
var
  objBase: TBaseAutomotiva;
  intIndex: Integer;

  fltFatorDensidade: Double;
  fltTotalDensidade: Double;
  fltTotalPorcentagem: Double;
begin

  fltTotalPorcentagem := 0;
  fltTotalDensidade := 0;
  objBase := Nil;

  If Not blnNovaFormula Then
  Begin
    Try
      For intIndex := 0 To Count - 1 Do
      Begin
        objBase := TBaseAutomotiva(Items[intIndex]);

        {FATOR DA DENSIDADE}
        Try
          fltFatorDensidade :=  fRetornaFatorDensidade(strTipPrg, objBase.fltQtdCon, objBase.fltPesEsp); //objBase.fltQtdCon / objBase.fltPesEsp;//fTruncaValor(objBase.fltQtdCon / objBase.fltPesEsp, 2);
        Except
          fltFatorDensidade :=  1;
        End;

        {SOMATORIO DA PORCENTAGEM}
        fltTotalPorcentagem := fltTotalPorcentagem + objBase.fltQtdCon;

        {SOMATORIO DA DENSIDADE}
        fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
      End;
    Except
      On E: EDivByZero Do
      Begin
        Raise EDivByZero.Create(Format('O peso especifico da base %s não está configurado', [objBase.strCodBas]));
      End;

      On E: Exception Do
      Begin
        Raise Exception.Create('Não foi possivel obter os dados da formula');
      End;
    End;

    { DENSIDADE TOTAL }
    Try
      fltTotalDensidade := fRetornaTotalDensidade(strTipPrg, fltTotalPorcentagem, fltTotalDensidade); //fltTotalPorcentagem / fltTotalDensidade;//fTruncaValor(fltTotalPorcentagem / fltTotalDensidade, 2);
    Except
      fltTotalDensidade := 1;
    End;


    For intIndex := 0 To Count - 1 Do
    Begin
      objBase := TBaseAutomotiva(Items[intIndex]);
      objBase.fltQtdCon := fArredondaValor(0.900 * fltTotalDensidade * (objBase.fltQtdCon / 100) * 1000, fCasasDecimaisQtd(strTipPrg)); //4
    End;

    fltTotalPorcentagem := 0;
    fltTotalDensidade := 0;

    Try
      For intIndex := 0 To Count - 1 Do
      Begin
        objBase := TBaseAutomotiva(Items[intIndex]);

        {FATOR DA DENSIDADE}
        fltFatorDensidade :=  fTruncaValor(objBase.fltQtdDil / objBase.fltPesEsp, 2);
        {SOMATORIO DA PORCENTAGEM}
        fltTotalPorcentagem := fltTotalPorcentagem + objBase.fltQtdDil;

        {SOMATORIO DA DENSIDADE}
        fltTotalDensidade := fltTotalDensidade + fltFatorDensidade;
      End;
    Except
      On E: EDivByZero Do
      Begin
        Raise EDivByZero.Create(Format('O peso especifico da base %s não está configurado', [objBase.strCodBas]));
      End;

      On E: Exception Do
      Begin
        Raise Exception.Create('Não foi possivel obter os dados da formula');
      End;
    End;

    { DENSIDADE TOTAL }
    Try
      fltTotalDensidade := fTruncaValor(fltTotalPorcentagem / fltTotalDensidade, 2);
    Except
      fltTotalDensidade := 1;
    End;


    For intIndex := 0 To Count - 1 Do
    Begin
      objBase := TBaseAutomotiva(Items[intIndex]);
      objBase.fltQtdDil := fArredondaValor(0.900 * fltTotalDensidade * (objBase.fltQtdDil / 100) * 1000, 5);
    End;
  End;
end;

procedure TFormulaFarbenAutomotivaDinamica.SetblnNovaFormula(
  const Value: Boolean);
begin
  FblnNovaFormula := Value;
end;

function TFormulaFarbenAutomotivaDinamica.fRetMatrizSaldosColorantes: TClassMatrizSaldosColorantes;
var
  intCont: Integer;
  objBase: TBaseAutomotiva;
  fltQtdFormul: Double;
  cdsCadBas: TUniClientDataSet;
begin
  Result := nil;
  Try
    Try
      Result := TClassMatrizSaldosColorantes.Create;
      cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

      For intCont := 0 To Self.Count - 1 Do
      Begin
        objBase := TBaseAutomotiva(Items[intCont]);
        cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);

        fltQtdFormul := IfThen(mveModoVenda = mvConcentrado, objBase.fltQtdCon, objBase.fltQtdDil) * (Self.fltVolumePro / Self.fltVolumeOri);

        If fltQtdFormul > 0 Then
        Begin

          Result.fAdicionar(1, Self.strDescri,
            cdsCadBas.FieldByName('BAS_CODITE').AsString,
            fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', cdsCadBas.FieldByName('BAS_CODITE').AsString),
            objBase.strCodBas,
            fltQtdFormul,
            BASE_AUTOMOTIVA,
            'N',  //Peso em gramas base
            0.0); //Embalagem da base
        End;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaFarbenAutomotivaDinamica.fRetornaFatorDensidade(
  strTipPrg: String; fltQtdCon, fltPesEsp: Double): Double;
begin
  Result := fltQtdCon / fltPesEsp;

  If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltQtdCon / fltPesEsp, 2);
end;

function TFormulaFarbenAutomotivaDinamica.fRetornaTotalDensidade(
  strTipPrg: String; fltPorcen, fltDensid: Double): Double;
begin
  Result := fltPorcen / fltDensid;

  If MatchStr(strTipPrg, ['1', '2']) Then
    Result := fTruncaValor(fltPorcen / fltDensid, 2);
end;

{ TConsultaFarben }

procedure TConsultaFarben.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  strIteEmb: String;
  strTipEmb: String;
  strTipPre: String;
  intQtdEmb: Integer;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltUnitar: Double;
  fltVolPro: Double;
  strProEmbCo   : String;
  strProEmbSp   : String;
  strProEmbTb   : String;
  strProEmbSy   : String;

  dicParams: TDicionario;
  conf: IConfTinta;
  cdsGen: TUniClientDataSet;
begin
  inherited;
  qryGen := nil;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  dicParams := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf := fGetConfTinta('FAR');

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM FAR_CADFAR WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      stlDesEmb   := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;

      stlDesEmb.Add('NORMAL');

      stlProEmbLt.Add(conf.fGet('FARPLT'));
      stlProEmbGl.Add(conf.fGet('FARPGL'));

      strProEmbCo := conf.fGet('FARPCP');
      strProEmbSp := conf.fGet('FARPSP');

      strProEmbTb := conf.fGet('FARPTB');
      strProEmbSY := conf.fGet('FARPSY');

      dicParams := TDicionario.Create;
      dicParams['idepro'] := 'FAR';

      fDigDadosTintometricos(cdsGen, stlDesEmb, stlProEmbLt, stlProEmbGl,
        strIteEmb, strTipEmb, strTipPre,
        intQtdEmb, fltPreEmb, fltEmbala, fltPreCus, fltUnitar, fltVolPro, strTabPre, dicParams,
        strProEmbCo, strProEmbSp, strProEmbTb, strProEmbSy);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(dicParams) then FreeAndNil(dicParams);
  End;
end;

procedure TConsultaFarben.pTarefaPrecos(Sender: TObject);
begin
  inherited;
  pTarefaFormulacao(Sender);
end;

procedure TConsultaFarben.pTarefaVenda(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadFarNfm', False);
end;

function fConsultaFarbenInterna(Sender: TForm; qryTinta: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String; blnFaturamento: Boolean;
    dicRetorno: TDicionario; sltItems: TStringList): String;
begin
  Result := (TFarbenAutomotivaConsulta.Create).fExecutarConsulta(Sender,
    qryTinta, tipoConsulta, strTabPre, TConsultaFarben, '', blnFaturamento, dicRetorno, sltItems);
end;

end.

