unit untBrasimixAutomotivaDinamica;

interface

uses SysUtils, Forms, Uni, Classes, untFuncoesSimples,
  StrUtils, untFuncEspecificas, Controls,
  untPnlBotoesAcoesNovaConsulta,
  untITintaDeMaquinaComponente, UniClientDataSet;

Type

  TfrmConsultaCompTintaBrasimix = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

  TformulaBrasimixAutomotivaDinamica  = class(TFormulaAutomotiva)
    Private
      fltPerAcr: Double;
      fltAcrMob: Double;
    protected
    public
      procedure pCarregaPrecosBases; override;
      procedure pCalcularPrecos; Override;
      procedure pCarregarColorantes; Override;
      Constructor Create(strTabPre: String); override;
  End;

  function fConsultaBrasimixAutomotivaDinamica(Sender: TForm): String; stdcall;
  function fConsultaBrasimixAutomotivaGeralDinamica(Sender: TForm): String; stdcall;
  function fConsultaBrasimixAutomotivaVendaDinamica(Sender: TForm; Var qryCadBza: TUniQuery; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fConsultaBrasimixAutomotivaDinamicaInterna(Sender: TForm;
    Var qryCadBza: TUniQuery; tipoConsulta: TTipoConsulta; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;

  function fGTinForBrasimixAutomotivaDinamica(strIteTin: String; strTipPre: String;
            Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
            Var stlItensTraMl: TStringList; fltVolPro: Double): Boolean; stdcall;

  function fDigDadosTintometricos(qryCadBza: TUniClientDataSet; stlDesEmb, stlProEmbLt,
    stlProEmbGl: TStringList; strProEmbCo,
    strProEmbSp: String; Var strIteEmb,
    strTipEmb, strTipPre: String; Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala,
    fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String; dicRetorno: TDicionario): Boolean;

  function fRetornaPrecoBrasimixAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery; Var dicRetorno: TDicionario;
    blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  function fRetornaDescricaoBrasimixAutomotivaDinamica(strDesCor: String): String;

  procedure pRetornaDadosBrasimixAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
  function fRetornaUniTraProBrasimixAutomotivaDinamica(strTipPre : String; fltPrcTin, fltPrvTin: Double): Double;

  procedure pRetornaTabelaPrecoBrasimixAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);

  function fGetSiglaTipo(strTipo: String): String;

implementation

uses DB, untDigTintaAutomotiva, Math, untIConfTinta,untICalculadorFatVendas, untIConsultaTinta,untTintaMaquina,
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo, untBrasimixAutomotivaConsulta,
  untFuncoes,
  untTintaDeMaquinaComponenteComparerBaseAutomotiva, untClientDataSetFactory, untMultiSelectLocalizadorFactory;

function fConsultaBrasimixAutomotivaDinamica(Sender: TForm): String; stdcall;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaBrasimixAutomotivaDinamicaInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, Nil, Nil);
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

function fConsultaBrasimixAutomotivaGeralDinamica(Sender: TForm): String; stdcall;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Sender);
      Result := fConsultaBrasimixAutomotivaDinamicaInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, Nil, Nil);
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

function fConsultaBrasimixAutomotivaVendaDinamica(Sender: TForm; Var qryCadBza: TUniQuery; strTabPre: String;
  blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := fConsultaBrasimixAutomotivaDinamicaInterna(Sender, qryCadBza, tpcVenda, strTabPre, blnFaturamento, dicRetorno, sltItems);
end;

function fGTinForBrasimixAutomotivaDinamica(strIteTin: String; strTipPre: String;
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
      if not TMultiSelectLocalizadorFactory.GetLocalizador('BZA').Localizar(cdsConsulta, ['ITETIN'], [strIteTin]) then
        Exit;
      
      qryConsulta := fCriaQuery;
      dicBases := TDicionario.Create;

      For intCont := 1 To 15 Do
      Begin
        strCamFor := 'BZA_CODB' + fStrZero(intCont, 2);
        strCamQtd := 'BZA_QTDB' + fStrZero(intCont, 2);

        If fEmptyStr(cdsConsulta.FieldByName(strCamFor).AsString) Then
          Break;

        arrFormul[intCont].strFormul := cdsConsulta.FieldByName(strCamFor).AsString;
        arrFormul[intCont].fltQtdbas := cdsConsulta.FieldByName(strCamQtd).AsFloat * fltVolPro / 0.900;
        dicBases[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;
        strBases := strBases + QuotedStr(arrFormul[intCont].strFormul) + ', ';
      End;

      strBases := Trim(strBases);
      strBases := Copy(strBases, 1, Length(strBases) - 1);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  BAS_CODBAS, ';
      strSQL := strSQL + '  BAS_CODITE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  BZA_CADBAS ';
      strSQL := strSQL + 'WHERE ' + GetInToOr('BAS_CODBAS', strBases);

      qryConsulta.Close;
      qryConsulta.SQL.Text := strSQL;
      cdsConsulta := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      SetLength(arrBaixaPigmentos, cdsConsulta.RecordCount);

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

procedure pRetornaDadosBrasimixAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
var
  cdsGen: TUniClientDataSet;
begin
  if TMultiSelectLocalizadorFactory.GetLocalizador('BZA').Localizar(cdsGen, ['ITETIN'], [strIteTin]) then
  begin
    dicRetorno['codtin'] := cdsGen.FieldByName('BZA_CODSEQ').AsString;
    dicRetorno['montad'] := cdsGen.FieldByName('BZA_MONTAD').AsString;
    dicRetorno['martin'] := cdsGen.FieldByName('BZA_ARQTXT').AsString;
  end;
end;

function fDigDadosTintometricos(qryCadBza: TUniClientDataSet; stlDesEmb, stlProEmbLt,
  stlProEmbGl: TStringList; strProEmbCo, strProEmbSp: String;
  Var strIteEmb, strTipEmb, strTipPre: String; Var intQtdEmb: Integer;
  Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double; strTabPre: String;
  dicRetorno: TDicionario): Boolean;
var
  objBase     : TBaseAutomotiva;
  objFormula  : TformulaBrasimixAutomotivaDinamica;
  intCont     : Integer;
  fltPreCu2: Double;
  calculadorFatVendas: ICalculadorFatVendas;
  cdsCadBas: TUniClientDataSet;
  conf: IConfTinta;
begin
  Result := False;
  objFormula := nil;
  frmDigTintaAutomotiva := nil;
  conf := fGetConfTinta('BZA');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TformulaBrasimixAutomotivaDinamica.Create(strTabPre);
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.strDescri := qryCadBza.FieldbyName('BZA_DESCRI').AsString;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      objFormula.fltAcrMob := qryCadBza.FieldByName('BZA_ACRMOB').AsFloat;

      cdsCadBas := TClientDataSetFactory.GetClientDataSet(objFormula.qrycadBas);

      For intCont := 1 To 15 Do
      Begin
        If fEmptyStr(qryCadBza.FieldbyName('BZA_CODB' + fStrZero(intCont, 2)).AsString) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryCadBza.FieldByName('BZA_CODB' + fStrZero(intCont, 2)).AsString;

        If ((qryCadBza.FieldByName('BZA_ARQTXT').AsString = 'POLIESTER') Or
            (qryCadBza.FieldByName('BZA_ARQTXT').AsString = 'POLIESTER PREMIUM')) Then
          objBase.fltQtdDil := qryCadBza.FieldByName('BZA_QTDB' + fStrZero(intCont, 2)).AsFloat
        Else
          objBase.fltQtdCon := qryCadBza.FieldByName('BZA_QTDB' + fStrZero(intCont, 2)).AsFloat;

        cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);
        objBase.fltEmbala := cdsCadBas.FieldbyName('BAS_EMBALA').AsFloat;
        objBase.fltPesEsp := cdsCadBas.FieldByName('BAS_PESPEC').AsFloat;

        If ((objBase.strCodBas = 'DILUEN') Or (objBase.strCodBas = 'TD00050')) Then
          objBase.strTipBas := 'D'
        Else
          objBase.strTipBas := 'B';
      End;

      objFormula.pCarregaPrecosBases;

      pCriarFormularios(TfrmDigTintaAutomotiva, frmDigTintaAutomotiva);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotiva.objFormula := objFormula;
      frmDigTintaAutomotiva.stlDesEmb := stlDesEmb;
      frmDigTintaAutomotiva.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotiva.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotiva.strProEmbCo := strProEmbCo;
      frmDigTintaAutomotiva.strProEmbSp := strProEmbSp;

      If fEmptyStr(strProEmbCo) Then
        frmDigTintaAutomotiva.rdbCopo.Visible := False;

      If fEmptyStr(strProEmbSp) Then
        frmDigTintaAutomotiva.rdbSpray.Visible := False;
      frmDigTintaAutomotiva.Caption := frmDigTintaAutomotiva.Caption + 'Brasimix Automotiva';
      {*************************************}
      {* NAO POSSUI CATALISADOR ESSA TINTA *}
      {**********************************PH*}
      frmDigTintaAutomotiva.chkComCat.Visible := False;
      frmDigTintaAutomotiva.strIdePro   := dicRetorno['idepro'];
      Result := (frmDigTintaAutomotiva.ShowModal = mrOk);

      If Result Then
      Begin
        strIteEmb := frmDigTintaAutomotiva.objFormula.strCodEmb;

        Case frmDigTintaAutomotiva.objFormula.tpeTipEmb of
          teLitro  : begin
                       strTipEmb := 'LT';
                       fltEmbala := 0.900;
                     end;
          teCopo   : begin
                       strTipEmb := 'CP';
                       fltEmbala := 0.500;
                     end;
          teGalao  : begin
                       strTipEmb := 'GL';
                       fltEmbala := 3.600;
                     end;
          teSpray  : begin
                       strTipEmb := 'SP';
                       fltEmbala := 0.400;
                     end;
        end;

        strTipPre := IIF(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotiva.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotiva.objFormula.fltPrecoEmbalagem;
        fltVolPro := frmDigTintaAutomotiva.objFormula.fltVolumePro;

        If frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0 Then
        Begin
          fltPreCus := frmDigTintaAutomotiva.objFormula.fltPrecoCusCon + frmDigTintaAutomotiva.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTintaAutomotiva.objFormula.fltPrecoCu2Con + frmDigTintaAutomotiva.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTintaAutomotiva.objFormula.fltPrecoVenCon + frmDigTintaAutomotiva.objFormula.fltPrecoEmbalagem;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotiva.objFormula.fltPrecoCusDil + frmDigTintaAutomotiva.objFormula.fltPrecoCustoEmbalagem;
          fltPreCu2 := frmDigTintaAutomotiva.objFormula.fltPrecoCu2Dil + frmDigTintaAutomotiva.objFormula.fltPrecoCusto2Embalagem;
          fltPreVen := frmDigTintaAutomotiva.objFormula.fltPrecoVenDil + frmDigTintaAutomotiva.objFormula.fltPrecoEmbalagem;
        End;


        dicRetorno['premed'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltPreMedCon,
          frmDigTintaAutomotiva.objFormula.fltPreMedDil) +
          frmDigTintaAutomotiva.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltImpUltCon,
          frmDigTintaAutomotiva.objFormula.fltImpUltDil) +
          frmDigTintaAutomotiva.objFormula.fltUltimoImpostoEmbalagem;

        dicRetorno['preult'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltPreUltCon,
          frmDigTintaAutomotiva.objFormula.fltPreUltDil) +
          frmDigTintaAutomotiva.objFormula.fltPreUltEmbalagem;

        dicRetorno['prctin'] := IfThen(frmDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotiva.objFormula.fltComLiqCon,
          frmDigTintaAutomotiva.objFormula.fltComLiqDil) +
          frmDigTintaAutomotiva.objFormula.fltPrecoCompraLiquidoEmbalagem;

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['qtdemb'] := objFormula.intQtdEmb;
        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        dicRetorno['promoc']      := frmDigTintaAutomotiva.objFormula.StrPromoc;

        dicRetorno['obscolorista']   := frmDigTintaAutomotiva.edtDescricaoColorista.Text;
        dicRetorno['tipoformulacao'] := frmDigTintaAutomotiva.rdgTipoFormula.ItemIndex;

        objFormula.pCalculaImpostosSaida(dicRetorno);

        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotiva.matrizSaldosColorantes);
        dicRetorno['saldocols'] := frmDigTintaAutomotiva.blnSaldoSuficiente;
        dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);

        If (Result) And (Assigned(dicRetorno)) Then
        Begin
          objFormula.pRecalculaTabelas(strTipPre, dicRetorno);
        End;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmDigTintaAutomotiva) then FreeAndNil(frmDigTintaAutomotiva);
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
end;

{ TformulaBrasimixAutomotivaDinamica }

constructor TformulaBrasimixAutomotivaDinamica.Create(strTabPre: String);
  Var
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('BZA');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

  fltAcrMob := 0;
end;


procedure TformulaBrasimixAutomotivaDinamica.pCalcularPrecos;
var
  intIndex: Integer;
  objBase: TBaseAutomotiva;
  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltEmbala   : Double;

  fltDesBasCon: Double;
  fltDesCamCon: Double;

  fltDesBasDil: Double;
  fltDesCamDil: Double;

  fltCusBasCon: Double;
  fltCu2BasCon: Double;
  fltVenBasCon: Double;

  fltCusBasDil: Double;
  fltCu2BasDil: Double;
  fltVenBasDil: Double;
  fltPreCusPro: Double;
  fltPreVenPro: Double;

  rmRoundMode: TFPURoundingMode;
  componente: array[TModoVenda] of ITintaDeMaquinaComponente;
  cdsCadBas: TUniClientDataSet;

  procedure pZerarPrecos;
  begin
    fltDesBasCon := 0.0;
    fltDesCamCon := 0.0;
    fltDesBasDil := 0.0;
    fltDesCamDil := 0.0;
    FPrecoCu2Con := 0.0;
    FPrecoCu2Dil := 0.0;
    FPrecoCusCon := 0.0;
    FPrecoCusDil := 0.0;
    FPrecoVenCon := 0.0;
    FPrecoVenDil := 0.0;

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

    FPreUltCon := 0;
    FPreUltDil := 0;
    FImpUltCon := 0;
    FImpUltDil := 0;

    FComLiqCon := 0;
    FComLiqDil := 0;
  End;
begin
  inherited;

  pZerarPrecos;
  FVolumeOri := 0.9;

  If fltVolumePro <= 0.0 Then
    fltVolumePro := 1;

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotiva(Items[intIndex]);

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

    If (cdsCadBas.FieldByName('BAS_PESPEC').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('A base ' + objBase.strCodBas + ' está com o peso específico zerado.' + #13#10 +
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

    componente[mvConcentrado].Quantidade := objBase.fltQtdCon * FVolumePro / 0.900;
    componente[mvDiluido].Quantidade := objBase.fltQtdDil * FVolumePro / 0.900;


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

    fltPreCu2Bas := fCalculaPrecoCusto2(fltPreVenBas,
                                        fltPreCusBas,
                                        objBase.fltOutVal,
                                        objBase.fltIcmSai,
                                        objBase.fltImpFed,
                                        objBase.fltDesOpe);

    fltEmbala    := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat * objBase.fltPesEsp;

    rmRoundMode := GetRoundMode;
    SetRoundMode(rmTruncate);
    fltCusBasCon := (((objBase.fltQtdCon * fltPreCusBas) / (fltEmbala)) * (FVolumePro)) / 0.900;
    fltCu2BasCon := (((objBase.fltQtdCon * fltPreCu2Bas) / (fltEmbala)) * (FVolumePro)) / 0.900;
    fltVenBasCon := (((objBase.fltQtdCon * fltPreVenBas) / (fltEmbala)) * (FVolumePro)) / 0.900;

    fltCusBasDil := (((objBase.fltQtdDil * fltPreCusBas) / (fltEmbala)) * (FVolumePro)) / 0.900;
    fltCu2BasDil := (((objBase.fltQtdDil * fltPreCu2Bas) / (fltEmbala)) * (FVolumePro)) / 0.900;
    fltVenBasDil := (((objBase.fltQtdDil * fltPreVenBas) / (fltEmbala)) * (FVolumePro)) / 0.900;
    SetRoundMode(rmRoundMode);

    FPrecoCusCon := FPrecoCusCon + fltCusBasCon;
    FPrecoCu2Con := FPrecoCu2Con + fltCu2BasCon;
    FPrecoVenCon := FPrecoVenCon + fltVenBasCon;

    FPrecoCusDil := FPrecoCusDil + fltCusBasDil;
    FPrecoCu2Dil := FPrecoCu2Dil + fltCu2BasDil;
    FPrecoVenDil := FPrecoVenDil + fltVenBasDil;

    componente[mvConcentrado].OutrosValores := (((objBase.fltQtdCon * objBase.fltOutVal) / (fltEmbala)) * (FVolumePro)) / 0.900;
    componente[mvDiluido].OutrosValores := (((objBase.fltQtdDil * objBase.fltOutVal) / (fltEmbala)) * (FVolumePro)) / 0.900;

    componente[mvConcentrado].IcmsSaida := objBase.fltIcmSai * fltVenBasCon / 100;
    componente[mvDiluido].IcmsSaida := objBase.fltIcmSai * fltVenBasDil / 100;

    componente[mvConcentrado].ImpostosFederais := objBase.fltImpFed * fltVenBasCon / 100;
    componente[mvDiluido].ImpostosFederais := objBase.fltImpFed * fltVenBasDil / 100;

    componente[mvConcentrado].DespesasOperacionais := objBase.fltDesOpe * fltVenBasCon / 100;
    componente[mvDiluido].DespesasOperacionais := objBase.fltDesOpe * fltVenBasDil / 100;

    componente[mvConcentrado].PrecoMedio := (((objBase.fltQtdCon * objBase.fltPreMed) / (fltEmbala)) * (FVolumePro)) / 0.900;
    componente[mvDiluido].PrecoMedio := (((objBase.fltQtdDil * objBase.fltPreMed) / (fltEmbala)) * (FVolumePro)) / 0.900;

    componente[mvConcentrado].UltimoPrecoCompra := (((objBase.fltQtdCon * objBase.fltPreUlt) / (fltEmbala)) * (FVolumePro)) / 0.900;
    componente[mvDiluido].UltimoPrecoCompra := (((objBase.fltQtdDil * objBase.fltPreUlt) / (fltEmbala)) * (FVolumePro)) / 0.900;

    componente[mvConcentrado].UltimoPrecoCompraImpostos := (((objBase.fltQtdCon * objBase.fltImpUlt) / (fltEmbala)) * (FVolumePro)) / 0.900;
    componente[mvDiluido].UltimoPrecoCompraImpostos := (((objBase.fltQtdDil * objBase.fltImpUlt) / (fltEmbala)) * (FVolumePro)) / 0.900;

    componente[mvConcentrado].PrecoCompraLiquido := (((objBase.fltQtdCon * objBase.fltComLiq) / (fltEmbala)) * (FVolumePro)) / 0.900;
    componente[mvDiluido].PrecoCompraLiquido := (((objBase.fltQtdDil * objBase.fltComLiq) / (fltEmbala)) * (FVolumePro)) / 0.900;

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

procedure TformulaBrasimixAutomotivaDinamica.pCarregaPrecosBases;
var
  intContador: Integer;
  objBase: TBaseAutomotiva;
  cdsCadBas: TUniClientDataSet;

  conf: IConfTinta;
  fltDesOpeTinta: Double;
  fltPreCusPro,
  fltPreVenPro: Double;
  fltPreVenItem: Double;

begin
  conf := fGetConfTinta('BZA');
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
    End
    Else
    Begin
      fltPreVenItem := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;


    objBase.fltEmbala := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := cdsCadBas.FieldByName('BAS_PESPEC').AsFloat;
    objBase.fltPreVen := fltPreVenItem;
    objBase.strImpDir := cdsCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := cdsCadBas.FieldByName('BAS_CODITE').AsString;
    objBase.fltImpUlt := cdsCadBas.FieldByName('ITE_IMPULT').AsFloat;
    objBase.fltPreUlt := cdsCadBas.FieldByName('ITE_PREULT').AsFloat;
    objBase.fltComLiq := fFormataFloat(fCalculaPrecoCompraLiq(cdsCadBas.Fieldbyname('ITE_PRECOM').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF02').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF04').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF06').AsFloat), fCfgSis('DECUNI', VarInteger));
    objBase.fltOutVal := cdsCadBas.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := cdsCadBas.FieldByName('ITE_ICMSAI').AsFloat;

    objBase.fltImpFed := cdsCadBas.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := cdsCadBas.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objBase.fltPreMed := cdsCadBas.FieldByName('ITE_PREMED').AsFloat;    
  End;

  FCalculo.Clear;
  FCalculo.Add('VolumeFormula  = ' + FloatToStrF(FVolumePro, ffFixed, 12, 4));
  FCalculo.Add('Valor da Base  = (Qtde. Concentrado * Preço) / (Embalagem * Volume Produzido) /0.900');
  FCalculo.Add('Preço da Tinta = (Soma do Valor da Base de todas as bases)');

end;

procedure TformulaBrasimixAutomotivaDinamica.pCarregarColorantes;
begin
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_PESPEC                       ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                       ');

  qryCadBas.SQL.Add('   , ITE_ICMSAI                       ');
  qryCadBas.SQL.Add('   , ITE_IMPFED                       ');
  qryCadBas.SQL.Add('   , ITE_DESOPE                       ');
  qryCadBas.SQL.Add('   , ITE_OUTVAL                       ');
  qryCadBas.SQL.Add('   , ITE_PREMED                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');

  qryCadBas.SQL.Add('   , ITE_PREULT                       ');

  qryCadBas.SQL.Add('   , ITE_PRECOM                       ');
  qryCadBas.SQL.Add('   , ITE_DESF01                       ');
  qryCadBas.SQL.Add('   , ITE_DESF02                       ');
  qryCadBas.SQL.Add('   , ITE_DESF03                       ');
  qryCadBas.SQL.Add('   , ITE_DESF04                       ');
  qryCadBas.SQL.Add('   , ITE_DESF05                       ');
  qryCadBas.SQL.Add('   , ITE_DESF06                       ');  

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
  qryCadBas.SQL.Add('   BZA_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  TClientDataSetFactory.GetClientDataSet(qryCadBas);
end;

function fRetornaPrecoBrasimixAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery; Var dicRetorno: TDicionario;
  blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
var
  strCodEmp     : String;
  strOpcDoc     : String;
  blnUsaPreCus  : Boolean;
  strTipEmb     : String;
  intQtdEmb     : Integer;
  strIteEmb     : String;
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
  stlProEmbGl   : TStringList;
  strProEmbCo   : String;
  strProEmbSp   : String;

  fltVolPro     : Double;
  strTabPre     : String;

  strAuto: String;
  tinta : IConsultaTinta;
  strDesCor : String;
  conf: IConfTinta;
  cdsTinta: TUniClientDataSet;
begin
  Result := False;
  stlDesEmb := nil;
  stlProEmbGl := nil;
  stlProEmbLt := nil;
  Try
    Try
      strCodEmp    := dicRetorno['codemp'];
      strOpcDoc    := dicRetorno['opcdoc'];
      blnUsaPreCus := dicRetorno['usaprecus'];
      strTipEmb    := dicRetorno['tipemb'];
      intQtdEmb    := dicRetorno['qtdemb'];
      strTabPre    := dicRetorno['tabpre'];

      stlDesEmb := TStringList.Create;
      stlDesEmb.Add('SINTETICO');
      stlDesEmb.Add('LACA');
      stlDesEmb.Add('POLIESTER');
      stlDesEmb.Add('P. U.');
      stlDesEmb.Add('EPOXI');

      If strTab = 'N' Then
      Begin
        strAuto := fConsultaBrasimixAutomotivaVendaDinamica(Sender, qryTinta, strTabPre, blnFaturamento, dicRetorno, sltItems);

        If (strAuto = '-1') Then
        Begin
          Exit;
        End;
      End
      Else
        strAuto := strAutoTab;

      conf  := fGetConfTinta('BZA');
      tinta := TBrasimixAutomotivaConsulta.Create;

      qryTinta.Close;
      qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
      cdsTinta := TClientDataSetFactory.GetClientDataSet(qryTinta);

      strIteTin := cdsTinta.FieldByName('BZA_MD5KEY').AsString;
      strMontad := cdsTinta.FieldByName('BZA_MONTAD').AsString;
      strA_n_o_ := cdsTinta.FieldByName('BZA_A_N_O_').AsString;

      stlProEmbGl :=  TStringList.Create;
      stlProEmbLt :=  TStringList.Create;

      stlProEmbGl.Add(conf.fGet('BZAIGL'));
      stlProEmbGl.Add(conf.fGet('BZAGLA'));
      stlProEmbGl.Add(conf.fGet('BZAGPO'));
      stlProEmbGl.Add(conf.fGet('BZAGPU'));
      stlProEmbGl.Add(conf.fGet('BZAGPE'));

      stlProEmbLt.Add(conf.fGet('BZAIEM'));
      stlProEmbLt.Add(conf.fGet('BZALLA'));
      stlProEmbLt.Add(conf.fGet('BZALPO'));
      stlProEmbLt.Add(conf.fGet('BZALPU'));
      stlProEmbLt.Add(conf.fGet('BZALPE'));

      strProEmbCo := conf.fGet('BZACOP');
      strProEmbSp := conf.fGet('BZASPR');

      If Not fDigDadosTintometricos(cdsTinta, stlDesEmb, stlProEmbLt, stlProEmbGl,
                                    strProEmbCo, strProEmbSp,
                                    strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                                    fltPreCus, fltPreVen, fltVolPro, strTabPre, dicRetorno) Then
        Exit;

      strDesCor := Trim(tinta.fGetDescricao(cdsTinta.FieldByName('AUTOINCREM').AsString));
      dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

//      fltPrcTin := fltPreCus;
      If blnUsaPreCus Then
        fltPreVen := fltPreCus;

      fltPrvTin := fltPreVen;

      dicRetorno['precus'] := fltPreCus;
      dicRetorno['unitar'] := fltPreVen;
//      dicRetorno['prctin'] := fltPrcTin;
      dicRetorno['prvtin'] := fltPrvTin;
      dicRetorno['codite'] := conf.fGet('PROBZA'); //fArqIniTinta(0, 'Brasimix Automotiva', 'PROBZA', '');
      dicRetorno['itetin'] := strIteTin;

      dicRetorno['iteemb'] := strIteEmb;
      dicRetorno['tipemb'] := strTipEmb;
      dicRetorno['qtdemb'] := intQtdEmb;
      dicRetorno['preemb'] := fltPreEmb;
      dicRetorno['embala'] := fltEmbala;
      dicRetorno['volpro'] := fltVolPro;

      dicRetorno['montad'] := strMontad;
      dicRetorno['a_n_o_'] := strA_n_o_;
      dicRetorno['chafor'] := fRetornaDescricaoBrasimixAutomotivaDinamica(strDesCor) + strTipEmb;
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
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
  End;
end;

function fRetornaDescricaoBrasimixAutomotivaDinamica(strDesCor: String): String;
begin
  Result := strDesCor;
end;

function fRetornaUniTraProBrasimixAutomotivaDinamica(strTipPre : String; fltPrcTin, fltPrvTin: Double): Double;
Var
  conf: IConfTinta;
begin
  conf := fGetConfTinta('BZA');

  If conf.fGet('TRABZA') = 'VEN' Then
    Result :=  fltPrvTin * conf.fGetDouble('FATBZA')
  Else
    Result :=  fltPrcTin * conf.fGetDouble('FATBZA'); 
    
  Result := fFormataFloat(Result, 2);
end;

procedure pRetornaTabelaPrecoBrasimixAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  objFormula: TformulaBrasimixAutomotivaDinamica;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
  strTabelaUnica: string;
  conf: IConfTinta;
  cdsConsulta: TUniClientDataSet;
begin
  conf := fGetConfTinta('BZA');
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TformulaBrasimixAutomotivaDinamica.Create('1');
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 0.9;
      objFormula.fltVolumePro := dicRetorno['volpro'];

      if TMultiSelectLocalizadorFactory.GetLocalizador('BZA').Localizar(cdsConsulta, ['ITETIN'], [dicRetorno['itetin']]) then
        objFormula.fltAcrMob := cdsConsulta.FieldByName('BZA_ACRMOB').AsFloat;

      If dicRetorno['tippre'] = 'C' Then
        objFormula.mveModoVenda := mvConcentrado
      Else
        objFormula.mveModoVenda := mvDiluido;

      objFormula.fltFatorAcerto := fltFatorAcerto;

      objFormula.strCodEmb := dicRetorno['iteemb'];


      For intContador := 1 To 15 Do
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

      strTabelas := fCfgSis('TABPRC');
      If Length(strTabelas) < 7 Then
        strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

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
            end;

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

function fConsultaBrasimixAutomotivaDinamicaInterna(Sender: TForm;
    Var qryCadBza: TUniQuery; tipoConsulta: TTipoConsulta; strTabPre: String;
    blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
begin
  Result := (TBrasimixAutomotivaConsulta.Create).fExecutarConsulta(Sender,
    qryCadBza, tipoConsulta, strTabPre, TfrmConsultaCompTintaBrasimix, '', blnFaturamento, dicRetorno, sltItems);
end;

{ TfrmConsultaCompTintaBrasimix }

procedure TfrmConsultaCompTintaBrasimix.pTarefaFormulacao(Sender: TObject);
var
  qryGen: TUniQuery;
  strTipEmb     : String;
  intQtdEmb     : Integer;
  strIteEmb     : String;
  strTipPre     : String;
  fltPreEmb     : Double;
  fltEmbala     : Double;
  fltPreCus     : Double;
  fltPreVen     : Double;
  strIteTin     : String;
  strMontad     : String;
  strA_n_o_     : String;

  stlDesEmb     : TStringList;
  stlProEmbLt   : TStringList;
  stlProEmbGl   : TStringList;

  strProEmbCo   : String;
  strProEmbSp   : String;

  fltVolPro     : Double;
  dicParams: TDicionario;
  conf: IConfTinta;
  cdsGen: TUniClientDataSet;
begin
  qryGen := nil;
  dicParams := nil;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      conf := fGetConfTinta('BZA');

      stlDesEmb := TStringList.Create;
      stlDesEmb.Add('SINTETICO');
      stlDesEmb.Add('LACA');
      stlDesEmb.Add('POLIESTER');
      stlDesEmb.Add('P. U.');
      stlDesEmb.Add('EPOXI');

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM BZA_CADBZA WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryGen);

      strIteTin := cdsGen.FieldByName('BZA_MD5KEY').AsString;
      strMontad := cdsGen.FieldByName('BZA_MONTAD').AsString;
      strA_n_o_ := cdsGen.FieldByName('BZA_A_N_O_').AsString;

      stlProEmbGl :=  TStringList.Create;
      stlProEmbLt :=  TStringList.Create;

      stlProEmbGl.Add(conf.fGet('BZAIGL'));
      stlProEmbGl.Add(conf.fGet('BZAGLA'));
      stlProEmbGl.Add(conf.fGet('BZAGPO'));
      stlProEmbGl.Add(conf.fGet('BZAGPU'));
      stlProEmbGl.Add(conf.fGet('BZAGPE'));

      stlProEmbLt.Add(conf.fGet('BZAIEM'));
      stlProEmbLt.Add(conf.fGet('BZALLA'));
      stlProEmbLt.Add(conf.fGet('BZALPO'));
      stlProEmbLt.Add(conf.fGet('BZALPU'));
      stlProEmbLt.Add(conf.fGet('BZALPE'));

      strProEmbCo := conf.fGet('BZACOP');
      strProEmbSp := conf.fGet('BZASPR');

      dicParams := TDicionario.Create;
      dicParams['idepro'] := 'BZA';

      fDigDadosTintometricos(cdsGen, stlDesEmb, stlProEmbLt, stlProEmbGl,
                                    strProEmbCo, strProEmbSp,
                                    strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                                    fltPreCus, fltPreVen, fltVolPro, strTabPre, dicParams);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(dicParams) then FreeAndNil(dicParams);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
  End;
end;

procedure TfrmConsultaCompTintaBrasimix.pTarefaPrecos(Sender: TObject);
begin
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompTintaBrasimix.pTarefaVenda(Sender: TObject);
begin
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadBzaNovasFormulas', False);
end;

function fGetSiglaTipo(strTipo: String): string;
Begin
  Result := '';
  If (strTipo = 'POLIESTER') Then
    Result := 'PE'
  Else If (strTipo = 'POLIURETANO FLEET 3X1') Then
    Result := 'PU'
  Else If (strTipo = 'POLIURETANO H.S. 2X1') Then
    Result := 'PH'
  Else If (strTipo = 'SINT. EXTRA-RAPIDO') Then
    Result := 'SR'
  Else If (strTipo = 'SINT. AUTOMOTIVO') Then
    Result := 'ST'
  Else If (strTipo = 'SINT. RAPIDO BRASILIAR') Then
    Result := 'SB'
  Else If (strTipo = 'SINT. RODOAGROINDUSTRIAL') Then
    Result := 'SI'
  Else If (strTipo = 'LACA NITRO-CELULOSE') Then
    Result := 'LC'
  Else If (strTipo = 'LACA NITRO AUTOMOTIVA') Then
    Result := 'LA'
  Else If (strTipo = 'EPOXI') Then
    Result := 'EP'
  Else If (strTipo = 'POLIURETANO PREMIUM 4X1') Then
    Result := 'PM'
  Else If (strTipo = 'POLIESTER PREMIUM') Then
    Result := 'PP'
  Else If (strTipo = 'EPOXI POLIAMINA') Then
    Result := 'EM'
  Else If (strTipo = 'POLIURETANO PREM. HS 4X1') Then
    Result := 'PR'
  Else If (strTipo = 'POLIURETANO PARA MADEIRA') Then
    Result := 'PD'
  Else If (strTipo = 'EPOX POLIAMIDA PLUS') Then
    Result := 'ED'
End;

end.

