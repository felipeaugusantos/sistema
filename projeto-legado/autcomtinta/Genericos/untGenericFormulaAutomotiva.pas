unit untGenericFormulaAutomotiva;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untFuncEspecificas, SysUtils, untIFormulaAutomotiva, System.Classes,
  untIConfTinta, untTintaMaquina;

type
  TGenericFormulaAutomotiva = class(TFormulaAutomotiva)
  private
    fltPerAcr: Double;
    fltDesOpeTinta: Double;
  protected
    formulaAutomotiva: IFormulaAutomotiva;
    blnRecalcularTabelas: Boolean;
    strIdePro: String;
  public
    procedure pCarregarColorantes; override;
    procedure pCarregaPrecosBases; override;
    procedure pCalcularPrecos; override;
    constructor Create(const strTabPrePar: String; const formulaAutomotiva: IFormulaAutomotiva; strIdePro: String; const blnRecalcularTabelas: Boolean); reintroduce;
    procedure pRecalculaTabelas(strTipoPreco: String; dicRetorno: TDicionario); override;
  end;

implementation

Uses
  untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untTintaDeMaquinaComponenteComparerBaseAutomotiva;

{ TGenericFormulaAutomotiva }

constructor TGenericFormulaAutomotiva.Create(const strTabPrePar: String; const formulaAutomotiva: IFormulaAutomotiva; strIdePro: String; const blnRecalcularTabelas: Boolean);
  Var
    conf: IConfTinta;
begin
  conf := fGetConfTinta(strIdePro);

  Self.formulaAutomotiva := formulaAutomotiva;
  Self.strIdePro      := strIdePro;
  Self.fltDesOpeTinta := conf.fGetDouble('DESOPE');
  Self.fltPerAcr      := conf.fGetDouble('APREVE') / 100.0;
  Self.blnRecalcularTabelas := blnRecalcularTabelas;

  inherited Create(strTabPrePar);
end;


procedure TGenericFormulaAutomotiva.pCalcularPrecos;
Var
  intIndex: Integer;
  objBase: TBaseAutomotiva;
  componente: array[TModoVenda] of ITintaDeMaquinaComponente;

  procedure pZerarPrecos;
  begin
    FPrecoCu2Con := 0.0;
    FPrecoCu2Dil := 0.0;
    FPrecoCusCon := 0.0;
    FPrecoCusDil := 0.0;
    FPrecoVenCon := 0.0;
    FPrecoVenDil := 0.0;
    FPreMedDil := 0;

    FOutValCon := 0;
    FOutValDil := 0;
    FImpFedCon := 0;
    FImpFedDil := 0;
    FDesOpeCon := 0;
    FDesOpeDil := 0;
    FIcmsaiCon := 0;
    FIcmsaiDil := 0;
    FPreMedCon := 0;

    FOutValCon := 0;
    FPreMedCon := 0;
    FComLiqCon := 0;
    FPreUltCon := 0;
    FImpUltCon := 0;

    FOutValDil := 0;
    FPreMedDil := 0;
    FComLiqDil := 0;
    FPreUltDil := 0;
    FImpUltDil := 0;
  End;
begin
  inherited;

  pZerarPrecos;
  FVolumeOri := formulaAutomotiva.GetVolumeOri;

  If fltVolumePro <= 0.0 Then
    fltVolumePro := 1;

  For intIndex := 0 To Count -1 Do
  Begin
    objBase := TBaseAutomotiva(Items[intIndex]);

    If (Not qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, [])) Then
    Begin
      pZerarPrecos;
      raise Exception.Create('Base ' + objBase.strCodBas + ' não cadastrada. Favor verificar.');
    End;

    If (fEmptyStr(qryCadBas.FieldByName('BAS_CODITE').AsString)) Then
    Begin
      pZerarPrecos;
      raise Exception.Create( 'A base ' + objBase.strCodBas + ' não está com o produto para venda associado.' + #13#10 +
        'Favor verificar.');
    End;

    If (qryCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      raise Exception.Create('O produto ' + qryCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
        'preenchido corretamente. Favor verificar.');
    End;

    If (qryCadBas.FieldByName('BAS_PESESP').AsFloat <= 0) Then
    Begin
      pZerarPrecos;
      raise Exception.Create('A base ' + objBase.strCodBas + ' está com o peso específico zerado.' + #13#10 +
        'Favor verificar.');
    End;

    If (objBase.fltPreVen <= 0) Then
    Begin
      pZerarPrecos;
      Raise Exception.Create('O produto ' + qryCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o preço de venda ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Exit;
    End;

    if not IsItemAtivo(qryCadBas.FieldByName('BAS_CODITE').AsString) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [qryCadBas.FieldByName('BAS_CODITE').AsString]);
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

    componente[mvConcentrado].Quantidade                := (fltVolumePro / fltVolumeOri) * objBase.fltQtdCon;
    componente[mvDiluido].Quantidade                    := (fltVolumePro / fltVolumeOri) * objBase.fltQtdDil;

    componente[mvConcentrado].OutrosValores             := (formulaAutomotiva.GetCalculoBaseOutValCon(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvConcentrado].PrecoMedio                := (formulaAutomotiva.GetCalculoBasePreMedCon(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvConcentrado].UltimoPrecoCompra         := (formulaAutomotiva.GetCalculoBasePreUltCon(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvConcentrado].UltimoPrecoCompraImpostos := (formulaAutomotiva.GetCalculoBaseImpUltCon(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvConcentrado].PrecoCompraLiquido        := (formulaAutomotiva.GetCalculoBaseComLiqCon(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvConcentrado].IcmsSaida                 := (formulaAutomotiva.GetCalculoBaseIcmSaiCon(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvConcentrado].ImpostosFederais          := (formulaAutomotiva.GetCalculoBaseImpFedCon(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvConcentrado].DespesasOperacionais      := (formulaAutomotiva.GetCalculoBaseDesOpeCon(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvConcentrado].PrecoCusto                := (formulaAutomotiva.GetCalculoBasePreCusCon(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvConcentrado].PrecoCustoReal            := (formulaAutomotiva.GetCalculoBasePreCu2Con(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvConcentrado].PrecoVenda                := (formulaAutomotiva.GetCalculoBasePreVenCon(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;

    componente[mvDiluido].OutrosValores                 := (formulaAutomotiva.GetCalculoBaseOutValDil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvDiluido].PrecoMedio                    := (formulaAutomotiva.GetCalculoBasePreMedDil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvDiluido].UltimoPrecoCompra             := (formulaAutomotiva.GetCalculoBasePreUltDil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvDiluido].UltimoPrecoCompraImpostos     := (formulaAutomotiva.GetCalculoBaseImpUltDil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvDiluido].PrecoCompraLiquido            := (formulaAutomotiva.GetCalculoBaseComLiqDil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvDiluido].IcmsSaida                     := (formulaAutomotiva.GetCalculoBaseIcmSaiDil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvDiluido].ImpostosFederais              := (formulaAutomotiva.GetCalculoBaseImpFedDil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvDiluido].DespesasOperacionais          := (formulaAutomotiva.GetCalculoBaseDesOpeDil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvDiluido].PrecoCusto                    := (formulaAutomotiva.GetCalculoBasePreCusDil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvDiluido].PrecoCustoReal                := (formulaAutomotiva.GetCalculoBasePreCu2Dil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;
    componente[mvDiluido].PrecoVenda                    := (formulaAutomotiva.GetCalculoBasePreVenDil(objBase) * fltVolumePro / fltVolumeOri) * FFatorAcerto;

{
    FPrecoCusCon := FPrecoCusCon + formulaAutomotiva.GetCalculoBasePreCusCon(objBase) * fltVolumePro / fltVolumeOri;
    FPrecoCu2Con := FPrecoCu2Con + formulaAutomotiva.GetCalculoBasePreCu2Con(objBase) * fltVolumePro / fltVolumeOri;
    FPrecoVenCon := FPrecoVenCon + formulaAutomotiva.GetCalculoBasePreVenCon(objBase) * fltVolumePro / fltVolumeOri;

    FPrecoCusDil := FPrecoCusDil + formulaAutomotiva.GetCalculoBasePreCusDil(objBase) * fltVolumePro / fltVolumeOri;
    FPrecoCu2Dil := FPrecoCu2Dil + formulaAutomotiva.GetCalculoBasePreCu2Dil(objBase) * fltVolumePro / fltVolumeOri;
    FPrecoVenDil := FPrecoVenDil + formulaAutomotiva.GetCalculoBasePreVenDil(objBase) * fltVolumePro / fltVolumeOri;

    FOutValCon := FOutValCon + formulaAutomotiva.GetCalculoBaseOutValCon(objBase) * fltVolumePro / fltVolumeOri;
    FOutValDil := FOutValDil + formulaAutomotiva.GetCalculoBaseOutValDil(objBase) * fltVolumePro / fltVolumeOri;
    FImpFedCon := FImpFedCon + formulaAutomotiva.GetCalculoBaseImpFedCon(objBase) * fltVolumePro / fltVolumeOri;
    FImpFedDil := FImpFedDil + formulaAutomotiva.GetCalculoBaseImpFedDil(objBase) * fltVolumePro / fltVolumeOri;
    FDesOpeCon := FDesOpeCon + formulaAutomotiva.GetCalculoBaseDesOpeCon(objBase) * fltVolumePro / fltVolumeOri;
    FDesOpeDil := FDesOpeDil + formulaAutomotiva.GetCalculoBaseDesOpeDil(objBase) * fltVolumePro / fltVolumeOri;
    FIcmsaiCon := FIcmsaiCon + formulaAutomotiva.GetCalculoBaseIcmSaiCon(objBase) * fltVolumePro / fltVolumeOri;
    FIcmsaiDil := FIcmsaiDil + formulaAutomotiva.GetCalculoBaseIcmSaiDil(objBase) * fltVolumePro / fltVolumeOri;
    FPreMedCon := FPreMedCon + formulaAutomotiva.GetCalculoBasePreMedCon(objBase) * fltVolumePro / fltVolumeOri;
    FPreMedDil := FPreMedDil + formulaAutomotiva.GetCalculoBasePreMedDil(objBase) * fltVolumePro / fltVolumeOri;

    FComLiqCon := FComLiqCon + formulaAutomotiva.GetCalculoBaseComLiqCon(objBase) * fltVolumePro / fltVolumeOri;
    FComLiqDil := FComLiqDil + formulaAutomotiva.GetCalculoBaseComLiqDil(objBase) * fltVolumePro / fltVolumeOri;
    FPreUltCon := FPreUltCon + formulaAutomotiva.GetCalculoBasePreUltCon(objBase) * fltVolumePro / fltVolumeOri;
    FPreUltDil := FPreUltDil + formulaAutomotiva.GetCalculoBasePreUltDil(objBase) * fltVolumePro / fltVolumeOri;
    FImpUltCon := FImpUltCon + formulaAutomotiva.GetCalculoBaseImpUltCon(objBase) * fltVolumePro / fltVolumeOri;
    FImpUltDil := FImpUltDil + formulaAutomotiva.GetCalculoBaseImpUltDil(objBase) * fltVolumePro / fltVolumeOri;
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

  pAplicarAcrescimoPrecoVenda(fltPerAcr);

  If FPrecoVenCon > 0 Then
    FPrecoVenCon := FPrecoVenCon + fltAcrMaoObr;

  If FPrecoVenDil > 0 Then
    FPrecoVenDil := FPrecoVenDil + fltAcrMaoObr;

  pCarregaPrecosBases;
end;

procedure TGenericFormulaAutomotiva.pCarregaPrecosBases;
var
  intContador: Integer;
  objBase: TBaseAutomotiva;
  fltPreCusPro,
  fltPreVenPro : Double;
  strCodEmpresa: String;
  blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  strCodEmpresa := fVerificaEmpresaSetada();


  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    qryCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);

    objBase.fltEmbala := qryCadBas.FieldByName('BAS_EMBALA').AsFloat;
    objBase.fltPesEsp := qryCadBas.FieldByName('BAS_PESESP').AsFloat;

    If fCarregaPromocao(qryCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa) Then
    Begin
      objBase.fltPreVen := fltPreVenPro;
      objBase.fltPreCus := fltPreCusPro;
      FPromoc := 'S';

      If fltPreCusPro = 0 Then
        objBase.fltPreCus := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
    End
    Else
    Begin
      objBase.fltPreVen := qryCadBas.FieldByName('ITE_PREVEN').AsFloat;
      objBase.fltPreCus := qryCadBas.FieldByName('ITE_PRECUS').AsFloat;
    End;

//    objBase.fltIcmSai := qryCadBas.FieldByName('ITE_ICMSAI').AsFloat;

    objBase.strCodIte := qryCadBas.FieldByName('BAS_CODITE').AsString;
    objBase.strImpDir := qryCadBas.FieldByName('ITE_IMPDIR').AsString;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := qryCadBas.FieldByName('ITE_ICMSAI').AsFloat;

    objBase.fltImpFed := qryCadBas.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := qryCadBas.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objBase.fltOutVal := qryCadBas.FieldByName('ITE_OUTVAL').AsFloat;
    objBase.strTipBas := formulaAutomotiva.GetTipBas(objBase.strCodBas);
    objBase.fltPreMed := qryCadBas.FieldByName('ITE_PREMED').AsFloat;

    objBase.fltPreUlt := qryCadBas.FieldByName('ITE_PREULT').AsFloat;
    objBase.fltImpUlt := qryCadBas.FieldByName('ITE_IMPULT').AsFloat;
    objBase.fltComLiq := fCalculaPrecoCompraLiquido(qryCadBas.Fieldbyname('ITE_PRECOM').AsFloat, qryCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                    qryCadBas.Fieldbyname('ITE_DESF02').AsFloat, qryCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                    qryCadBas.Fieldbyname('ITE_DESF04').AsFloat, qryCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                    qryCadBas.Fieldbyname('ITE_DESF06').AsFloat);
  End;

  FCalculo.Clear;
  FCalculo.Add('VolumeFormula  = ' + FloatToStrF(FVolumePro, ffFixed, 12, 4));
  FCalculo.Add(formulaAutomotiva.GetTextoCalculoValor);
end;

procedure TGenericFormulaAutomotiva.pCarregarColorantes;
begin
  qryCadBas.SQL.Clear;

  qryCadBas.SQL.Add(' SELECT                              ');
  qryCadBas.SQL.Add('   BAS_CODBAS                        ');
  qryCadBas.SQL.Add('   , BAS_CODITE                      ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                      ');
  qryCadBas.SQL.Add('   , BAS_PESESP                      ');
  qryCadBas.SQL.Add('   , ITE_CNV_ML                      ');

  qryCadBas.SQL.Add('   , ITE_PREULT                       ');
  qryCadBas.SQL.Add('   , ITE_IMPULT                       ');

  qryCadBas.SQL.Add('   , ITE_PRECOM                       ');
  qryCadBas.SQL.Add('   , ITE_DESF01                       ');
  qryCadBas.SQL.Add('   , ITE_DESF02                       ');
  qryCadBas.SQL.Add('   , ITE_DESF03                       ');
  qryCadBas.SQL.Add('   , ITE_DESF04                       ');
  qryCadBas.SQL.Add('   , ITE_DESF05                       ');
  qryCadBas.SQL.Add('   , ITE_DESF06                       ');  

  If (fCfgSis('PREGER') <>  '0') Then
  begin
    qryCadBas.SQL.Add('   , ITE_ICMSAI                      ');
    qryCadBas.SQL.Add('   , ITE_IMPFED                      ');
    qryCadBas.SQL.Add('   , ITE_DESOPE                      ');
    qryCadBas.SQL.Add('   , ITE_OUTVAL                      ');
    qryCadBas.SQL.Add('   , ITE_PREMED                      ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , 0 AS ITE_ICMSAI                 ');
    qryCadBas.SQL.Add('   , 0 AS ITE_IMPFED                 ');
    qryCadBas.SQL.Add('   , 0 AS ITE_DESOPE                 ');
    qryCadBas.SQL.Add('   , 0 AS ITE_OUTVAL                 ');
    qryCadBas.SQL.Add('   , 0 AS ITE_PREMED                 ');
  end;

  If (fCfgSis('PREGER') = '0') Then
  begin
    qryCadBas.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS        ');
    qryCadBas.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN        ');
  end
  Else If (fCfgSis('PREGER') = '1') and FBlnCalculaUnitario Then
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                    ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + fCfgSis('TABPRE') + ' AS ITE_PREVEN      ');
  end
  else
  begin
    qryCadBas.SQL.Add('   , G.ITE_PRECUS                    ');
    qryCadBas.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN      ');
  end;

  If fCfgSis('IMPDIG') = '1' Then
    qryCadBas.SQL.Add('   , I.ITE_IMPDIR                     ')
  else
    qryCadBas.SQL.Add('   , G.ITE_IMPDIR                     ');

  qryCadBas.SQL.Add(' FROM                                ');
  qryCadBas.SQL.Add('   ' + formulaAutomotiva.GetNomeTabelaBase + '                        ');
  qryCadBas.SQL.Add('   LEFT JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = BAS_CODITE    ');
  qryCadBas.SQL.Add('     AND G.ITE_CODEMP = :CODEMP      ');
  qryCadBas.SQL.Add('   LEFT JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON I.ITE_CODITE = BAS_CODITE    ');

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadBas.Open;
end;

procedure TGenericFormulaAutomotiva.pRecalculaTabelas(strTipoPreco: String; dicRetorno: TDicionario);
var
  strTabelas: String;
  intContador: Integer;
  strTabelaUnica: string;
begin
  If blnRecalcularTabelas Then
  Begin
    strTabelaUnica := IfNull(dicRetorno['tabelaunica'], '');

    If Not fEmptyStr(strTabelaUnica) Then
    Begin
      Self.strTabPre := strTabelaUnica;
      Self.pCarregarColorantes;
      Self.pCarregaPrecosBases;
      Self.pCalcularPrecos;

      If IfNull(dicRetorno['precus'], 0) <= 0 Then
      Begin
        If strTipoPreco = 'C' Then
          dicRetorno['precus'] := Self.fltPrecoCusCon + Self.fltPrecoCustoEmbalagem
        Else
          dicRetorno['precus'] := Self.fltPrecoCusDil + Self.fltPrecoCustoEmbalagem;
      End;

      If strTipoPreco = 'C' Then
      Begin
        dicRetorno['precu2'] := Self.fltPrecoCu2Con + Self.fltPrecoCusto2Embalagem;
        dicRetorno['preve' + strTabelaUnica] := Self.fltPrecoVenCon + Self.fltPrecoEmbalagem;
      End
      Else
      Begin
        dicRetorno['precu2'] := Self.fltPrecoCu2Dil + Self.fltPrecoCusto2Embalagem;
        dicRetorno['preve' + strTabelaUnica] := Self.fltPrecoVenDil + Self.fltPrecoEmbalagem;
      End;

      Self.pCalculaImpostosSaida(dicRetorno);
      dicRetorno.AdicionarObjeto('tintaDeMaquina', Self.tintaDeMaquina[Self.mveModoVenda]);
      dicRetorno['promoc'] := Self.StrPromoc;
    End
    Else
    Begin
      strTabelas := fCfgSis('TABPRC');
      If Length(strTabelas) < 7 Then
        strTabelas := strTabelas + StringOfChar('N',7-Length(strTabelas));

      For intContador := 1 To Length(strTabelas) Do
      Begin
        if strTabelas[intContador] = 'S' then
        begin
          Self.strTabPre := IntToStr(intContador);
          Self.pCarregarColorantes;
          Self.pCarregaPrecosBases;
          Self.pCalcularPrecos;

          If IfNull(dicRetorno['precus'], 0) <= 0 Then
          Begin
            If strTipoPreco = 'C' Then
              dicRetorno['precus'] := Self.fltPrecoCusCon + Self.fltPrecoCustoEmbalagem
            Else
              dicRetorno['precus'] := Self.fltPrecoCusDil + Self.fltPrecoCustoEmbalagem;
          End;

          If strTipoPreco = 'C' Then
          Begin
            dicRetorno['precu2'] := Self.fltPrecoCu2Con + Self.fltPrecoCusto2Embalagem;
            dicRetorno['preve' + IntToStr(intContador)] := Self.fltPrecoVenCon + Self.fltPrecoEmbalagem;
          End
          Else
          Begin
            dicRetorno['precu2'] := Self.fltPrecoCu2Dil + Self.fltPrecoCusto2Embalagem;
            dicRetorno['preve' + IntToStr(intContador)] := Self.fltPrecoVenDil + Self.fltPrecoEmbalagem;
          End;

          if intContador = IfNull(dicRetorno['tabpre'], 0) then
          Begin
            Self.pCalculaImpostosSaida(dicRetorno);
            dicRetorno.AdicionarObjeto('tintaDeMaquina', Self.tintaDeMaquina[Self.mveModoVenda]);
            dicRetorno['promoc'] := Self.StrPromoc;
          End;
        end;
      End;
    End;
  End
  Else
  Begin
    dicRetorno.AdicionarObjeto('tintaDeMaquina', Self.tintaDeMaquina[Self.mveModoVenda]);
  End;

  dicRetorno['fatace'] := fltFatorAcerto;
end;

end.
