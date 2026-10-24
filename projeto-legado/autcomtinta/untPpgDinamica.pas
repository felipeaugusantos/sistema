unit untPpgDinamica;

interface

uses
  untFuncEspecificas, Forms, Classes, Uni, untFuncoesSimples, strUtils, SysUtils, Controls,
  Math, Dialogs, untFormulacaoAutomotiva, untPnlBotoesAcoesNovaConsulta,
  Variants, UniClientDataSet, ActiveX,  StdCtrls;

Type
  TfrmConsultaCompPpg = class(TfrmPnlBotoesAcoesNovaConsulta)
  public
    procedure pTarefaFormulacao(Sender: TObject); override;
    procedure pTarefaPrecos(Sender: TObject); override;
    procedure pTarefaVenda(Sender: TObject); override;
  End;

Type
  TfrmFormulacaoAutomotivaPpg = class(TfrmFormulacaoAutomotiva)
  public
    strSistema: String;
    procedure pRecalculaFormula(blnPadrao: Boolean); override;
  End;

Type
  TFormulaPpgDinamica  = class(TFormulaAutomotiva)
  private
    FstlListaAdicional4: TStringList;
    FstlListaAdicional3: TStringList;
    FstlListaAdicional2: TStringList;
    FstrCaptionAdicional3: String;
    FstrCaptionAdicional4: String;
    FstrCaptionAdicional2: String;
    fltPerAcr: Double;
    fltAcrMob: Double;
    strSistema: String;
    procedure SetstlListaAdicional2(const Value: TStringList);
    procedure SetstlListaAdicional3(const Value: TStringList);
    procedure SetstlListaAdicional4(const Value: TStringList);
    procedure SetstrCaptionAdicional2(const Value: String);
    procedure SetstrCaptionAdicional3(const Value: String);
    procedure SetstrCaptionAdicional4(const Value: String);
    procedure pCarregaBasesPorEmpresas;
    procedure pSubstituiBasesEmpresas(var cdsCadBas: TUniClientDataSet);
  protected
    stlBasesErros: TStringList;
    function fCalculaQuantidadeParaBaixaEstoque(objBase: TBaseAutomotiva): Double; override;
  public

    procedure pCarregarColorantes; Override;
    constructor Create(strTabPrePar: String); override;
    procedure pCarregaPrecosBases; override;
    procedure pCalcularPrecos; Override;
    procedure pReformula(strTipCor, strTextBase, strCatalisador, strDiluente: String; intModDil: Integer);
    procedure pReformulaNovo(const strTipo, strCodDil, strSistema: string; const fltPorDil: Double);

    property strCaptionAdicional2: String read FstrCaptionAdicional2 write SetstrCaptionAdicional2;
    property stlListaAdicional2: TStringList read FstlListaAdicional2 write SetstlListaAdicional2;
    property strCaptionAdicional3: String read FstrCaptionAdicional3 write SetstrCaptionAdicional3;
    property stlListaAdicional3: TStringList read FstlListaAdicional3 write SetstlListaAdicional3;
    property strCaptionAdicional4: String read FstrCaptionAdicional4 write SetstrCaptionAdicional4;
    property stlListaAdicional4: TStringList read FstlListaAdicional4 write SetstlListaAdicional4;

  End;

  function fRetornaPrecoPpgAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery; var dicRetorno: TDicionario;
    blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  function fConsultaPpgAutomotivaDinamica(Sender: TForm): String; stdcall;
  function fConsultaPpgAutomotivaDinamicaGeral(Sender: TForm): String; stdcall;
  function fConsultaPpgAutomotivaDinamicaVenda(Sender: TForm; qryTinta: TUniQuery;
    strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
  function fConsultaPpgAutomotivaDinamicaInterna(Sender: TForm; qryTinta: TUniQuery;
    tipoConsulta: TTipoConsulta; strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String;

  function fGTinForPpgAutomotivaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
    fltVolPro: Double; strCatalisador, strDiluente: String; strTipCor: String; strTextBase: String;
    intModDil: Integer; strTipPre: String; const fltPorDil: Double): Boolean;

  function fDigDadosTintometricos(qryTinta: TUniQuery; stlDesEmb: TStringList; stlProEmbLt, stlProEmbGl,
    stlProEmbBd, stlProEmbTb: TStringList;
    Var strIteEmb, strTipEmb: String; strTabPre: String; Var strTipPre: String; Var intQtdEmb: Integer;
    Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double;
    Var dicRetorno: TDicionario; strDesCor: String): Boolean;

  function fRetornaUniTraProPpgAutomotivaDinamica(strTipPre: String; fltPrcTin, fltPrvTin: Double): Double;
  procedure pRetornaTabelaPrecoPpgAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);
  procedure pRetornaDadosPpgAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
  function fRetornaDescricaoPpgAutomotivaDinamica(qryTinta: TUniQuery; strDesCor: String): String;
  function fRetNomMontadora(strcodMon: String): String;
  function fRetCodMontadora(strNomMon: String): String;

  function fRetTipoCor(qrytinta: TUniQuery): String;
  function fRetVolume(strCodBas: String; fltGramas: Double): Double;
  function fRetPeso(strCodBas: String; fltVolume: Double): Double;
  function fRetEmbalagemLT(strTipCor: String): String;
  function fRetEmbalagemGL(strTipCor: String): String;
  function fRetEmbalagemBD(strTipCor: String): String;
  function fRetEmbalagemTB(strTipCor: String): String;
  function fRetOpcoesDiluicao(strTipCor: String): TStringList;
  function fRetDiluentes(strTipCor: String; intModDil: Integer; strCatalisador: String): TStringList;
  function fGetDiluentes(const strLinha, strSistema: string): TStringList;
  function fRetCatalisadores(strTipCor: String; intModDil: Integer): TStringList;
  function fRetTexturBaseMat(strTipCor: String; intModDil: Integer): TStringList;
  function fRetStrTexturBaseMat(strTipCor: String; intModDil: Integer): String;
  function fRetQtdDiluente(strTipCor: String; fltVolPro: Double; intModDil: Integer; strTexBas: String; strCatalisador: String): Double;
  function fTemDiluente(strTipCor: String): Boolean;
  function fRetQtdCatalisador(strTipCor: String; strTextBase: String; fltVolPro: Double; intModDil: Integer; strCatalisador: String): Double;
  function fArredondaPPG(fltValor: Double): Double;
  procedure pBasesPorEmpresas(var cdsCadBas: TUniClientDataSet; qryGen: TUniQuery);
  function fSelectBasesSemAmarracao: String;
  function fRetornaAcrescimoMaoObra(strIteTin: String): Double;

implementation

uses DB, untDigTintaAutomotiva, untFuncoes,
  untTintaMaquina, untICalculadorFatVendas, untDigTintaAutomotivaPpgNova,
  untIConfTinta, untIConsultaTinta, untIConfEmb, untPpgConsulta, untPpgConsultaEscolha,
  untClientDataSetFactory, untGenericTintaDeMaquinaComponente, untTintaDeMaquinaComponenteTipo,
  untITintaDeMaquinaComponente, untTintaDeMaquinaComponenteComparerBaseAutomotiva;

{ TFormulaPpgDinamica }

constructor TFormulaPpgDinamica.Create(strTabPrePar: String);
  Var
    conf: IConfTinta;
begin
  inherited Create(strTabPrePar);
  stlBasesErros := TStringList.Create;
  conf := fGetConfTinta('PPG');
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;
  fltAcrMob := 0;
  strSistema := '';
end;

function TFormulaPpgDinamica.fCalculaQuantidadeParaBaixaEstoque(
  objBase: TBaseAutomotiva): Double;
begin
  If (Pos('PERSONALIZ', Self.strSistema) <= 0) Then
    Result := fArredondaPPG(IfThen(mveModoVenda = mvConcentrado, objBase.fltQtdCon, objBase.fltQtdDil) *
                (Self.fltVolumePro / Self.fltVolumeOri))
  Else
    Result := IfThen(mveModoVenda = mvConcentrado, objBase.fltQtdCon, objBase.fltQtdDil) *
                (Self.fltVolumePro / Self.fltVolumeOri);
end;

procedure TFormulaPpgDinamica.pCalcularPrecos;
var
  intIndex: Integer;
  intCIndex: Integer;
  objBase: TBaseAutomotiva;

  fltPreCusBas: Double;
  fltPreCu2Bas: Double;
  fltPreVenBas: Double;
  fltEmbala: Double;
  fltCusBasCon: Double;
  fltCu2BasCon: Double;
  fltVenBasCon: Double;
  fltCusBasDil: Double;
  fltCu2BasDil: Double;
  fltVenBasDil: Double;

  strCodIte: String;
  cdsCadBas: TUniClientDataSet;
  fltPreCusPro,
  fltPreVenPro : Double;

  componente: array[TModoVenda] of ITintaDeMaquinaComponente;

  procedure pZerarPrecos;
  Begin
    FPrecoCusCon := 0;
    fltCusBasCon := 0;
    FPrecoCu2Con := 0;
    fltCu2BasCon := 0;
    FPrecoVenCon := 0;
    fltVenBasCon := 0;
    FPrecoCusDil := 0;
    fltCusBasDil := 0;
    FPrecoCu2Dil := 0;
    fltCu2BasDil := 0;
    FPrecoVenDil := 0;
    fltVenBasDil := 0;

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
  pZerarPrecos;

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  //Se existir bases cadastradas por empresas entao substitui as caracteristicas do produto;
  If Not qryBasEmp.IsEmpty Then
    pSubstituiBasesEmpresas(cdsCadBas);

  FVolumeOri := 1.0;

  For intIndex := 0 To Count -1 Do
  Begin

    objBase := TBaseAutomotiva(Items[intIndex]);

    If (Self.FModoVenda = mvConcentrado) And (objBase.strTipBas = 'D') Then
    Begin
      Continue;
    End;

    If (Not cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []) and (Not stlBasesErros.Find(objBase.strCodBas, intCIndex))) Then
    Begin
      pZerarPrecos;
      stlBasesErros.Add(objBase.strCodBas);
      pMensagemOk('Base ' + objBase.strCodBas + ' não cadastrada. Favor verificar.');
      Break;
    End;

    strCodIte := cdsCadBas.FieldByName('BAS_CODITE').AsString;

    If (fEmptyStr(strCodIte) and (Not stlBasesErros.Find(objBase.strCodBas, intCIndex))) Then
    Begin
      pZerarPrecos;
      stlBasesErros.Add(objBase.strCodBas);
      pMensagemOk('A base ' + objBase.strCodBas + ' não está com o produto para venda associado.' + #13#10 +
                             'Favor verificar.');
      Break;
    End;

    If (cdsCadBas.FieldByName('ITE_CNV_ML').AsFloat <= 0) and (Not stlBasesErros.Find(objBase.strCodBas, intCIndex)) Then
    Begin
      pZerarPrecos;
      stlBasesErros.Add(objBase.strCodBas);
      pMensagemOk('O produto ' + cdsCadBas.FieldByName('BAS_CODITE').AsString + ' não está com o fator tintométrico ' + #13#10 +
                             'preenchido corretamente. Favor verificar.');
      Break;
    End;

    If (cdsCadBas.FieldByName('BAS_PESESP').AsFloat <= 0) and (Not stlBasesErros.Find(objBase.strCodBas, intCIndex)) Then
    Begin
      pZerarPrecos;
      stlBasesErros.Add(objBase.strCodBas);
      pMensagemOk('A base ' + objBase.strCodBas + ' está com o peso específico zerado.' + #13#10 +
                             'Favor verificar.');
    End;

    if (not IsItemAtivo(cdsCadBas.FieldByName('BAS_CODITE').AsString)) And (Not fEmptyStr(cdsCadBas.FieldByName('BAS_CODITE').AsString)) then
    begin
      pZerarPrecos;
      raise Exception.CreateFmt('O produto %s não está ativo, Favor verificar!', [cdsCadBas.FieldByName('BAS_CODITE').AsString]);
    end;

    If stlBasesErros.Find(objBase.strCodBas, intCIndex) Then
    Begin
//      Continue;
      pZerarPrecos;
      Break;
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

    If fltEmbala = 0 Then
      Exit;

    fltCusBasCon := (objBase.fltQtdCon * fltPreCusBas * FVolumePro) / (fltEmbala);
    fltCu2BasCon := (objBase.fltQtdCon * fltPreCu2Bas * FVolumePro) / (fltEmbala);
    fltVenBasCon := (objBase.fltQtdCon * fltPreVenBas * FVolumePro) / (fltEmbala);

    fltCusBasDil := (objBase.fltQtdDil * fltPreCusBas * FVolumePro) / (fltEmbala);
    fltCu2BasDil := (objBase.fltQtdDil * fltPreCu2Bas * FVolumePro) / (fltEmbala);
    fltVenBasDil := (objBase.fltQtdDil * fltPreVenBas * FVolumePro) / (fltEmbala);


    componente[mvConcentrado].Quantidade                := (objBase.fltQtdCon * FVolumePro) / (fltEmbala);
    componente[mvDiluido].Quantidade                    := (objBase.fltQtdDil * FVolumePro) / (fltEmbala);

    componente[mvConcentrado].OutrosValores             := (objBase.fltQtdCon * objBase.fltOutVal * FVolumePro) / (fltEmbala);
    componente[mvConcentrado].PrecoMedio                := (objBase.fltQtdCon * objBase.fltPreMed * FVolumePro) / (fltEmbala);
    componente[mvConcentrado].UltimoPrecoCompra         := (objBase.fltQtdCon * objBase.fltPreUlt * FVolumePro) / (fltEmbala);
    componente[mvConcentrado].UltimoPrecoCompraImpostos := (objBase.fltQtdCon * objBase.fltImpUlt * FVolumePro) / (fltEmbala);
    componente[mvConcentrado].PrecoCompraLiquido        := (objBase.fltQtdCon * objBase.fltComLiq * FVolumePro) / (fltEmbala);
    componente[mvConcentrado].IcmsSaida                 := fltVenBasCon * objBase.fltIcmSai / 100;
    componente[mvConcentrado].ImpostosFederais          := fltVenBasCon * objBase.fltImpFed / 100;
    componente[mvConcentrado].DespesasOperacionais      := fltVenBasCon * objBase.fltDesOpe / 100;
    componente[mvConcentrado].PrecoCusto                := fltCusBasCon;
    componente[mvConcentrado].PrecoCustoReal            := fltCu2BasCon;
    componente[mvConcentrado].PrecoVenda                := fltVenBasCon;

    componente[mvDiluido].OutrosValores                 := (objBase.fltQtdDil * objBase.fltOutVal * FVolumePro) / (fltEmbala);
    componente[mvDiluido].PrecoMedio                    := (objBase.fltQtdDil * objBase.fltPreMed * FVolumePro) / (fltEmbala);
    componente[mvDiluido].UltimoPrecoCompra             := (objBase.fltQtdDil * objBase.fltPreUlt * FVolumePro) / (fltEmbala);
    componente[mvDiluido].UltimoPrecoCompraImpostos     := (objBase.fltQtdDil * objBase.fltImpUlt * FVolumePro) / (fltEmbala);
    componente[mvDiluido].PrecoCompraLiquido            := (objBase.fltQtdDil * objBase.fltComLiq * FVolumePro) / (fltEmbala);
    componente[mvDiluido].IcmsSaida                     := fltVenBasDil * objBase.fltIcmSai / 100;
    componente[mvDiluido].ImpostosFederais              := fltVenBasDil * objBase.fltImpFed / 100;
    componente[mvDiluido].DespesasOperacionais          := fltVenBasDil * objBase.fltDesOpe / 100;
    componente[mvDiluido].PrecoCusto                    := fltCusBasDil;
    componente[mvDiluido].PrecoCustoReal                := fltCu2BasDil;
    componente[mvDiluido].PrecoVenda                    := fltVenBasDil;

{
    fltEmbala    := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat * objBase.fltPesEsp;

    If fltEmbala = 0 Then
      Exit;

    fltCusBasCon := (objBase.fltQtdCon * fltPreCusBas * FVolumePro) / (fltEmbala);
    fltCu2BasCon := (objBase.fltQtdCon * fltPreCu2Bas * FVolumePro) / (fltEmbala);
    fltVenBasCon := (objBase.fltQtdCon * fltPreVenBas * FVolumePro) / (fltEmbala);

    FOutValCon := FOutValCon + (objBase.fltQtdCon * objBase.fltOutVal * FVolumePro) / (fltEmbala);
    FIcmsaiCon := FIcmsaiCon + fltVenBasCon * objBase.fltIcmSai / 100;
    FImpFedCon := FImpFedCon + fltVenBasCon * objBase.fltImpFed / 100;
    FDesOpeCon := FDesOpeCon + fltVenBasCon * objBase.fltDesOpe / 100;
    FPreMedCon := FPreMedCon + (objBase.fltQtdCon * objBase.fltPreMed * FVolumePro) / (fltEmbala);

    FPrecoCusCon := FPrecoCusCon + fltCusBasCon;
    FPrecoCu2Con := FPrecoCu2Con + fltCu2BasCon;
    FPrecoVenCon := FPrecoVenCon + fltVenBasCon;

    fltCusBasDil := (objBase.fltQtdDil * fltPreCusBas * FVolumePro) / (fltEmbala);
    fltCu2BasDil := (objBase.fltQtdDil * fltPreCu2Bas * FVolumePro) / (fltEmbala);
    fltVenBasDil := (objBase.fltQtdDil * fltPreVenBas * FVolumePro) / (fltEmbala);

    FOutValDil := FOutValDil + (objBase.fltQtdDil * objBase.fltOutVal * FVolumePro) / (fltEmbala);
    FPreMedDil := FPreMedDil + (objBase.fltQtdDil * objBase.fltPreMed * FVolumePro) / (fltEmbala);

    FPreUltCon := FPreUltCon + (objBase.fltQtdCon * objBase.fltPreUlt * FVolumePro) / (fltEmbala);
    FPreUltDil := FPreUltDil + (objBase.fltQtdDil * objBase.fltPreUlt * FVolumePro) / (fltEmbala);
    FImpUltCon := FImpUltCon + (objBase.fltQtdCon * objBase.fltImpUlt * FVolumePro) / (fltEmbala);
    FImpUltDil := FImpUltDil + (objBase.fltQtdDil * objBase.fltImpUlt * FVolumePro) / (fltEmbala);

    FComLiqCon := FComLiqCon + (objBase.fltQtdCon * objBase.fltComLiq * FVolumePro) / (fltEmbala);
    FComLiqDil := FComLiqDil + (objBase.fltQtdDil * objBase.fltComLiq * FVolumePro) / (fltEmbala);

    FIcmsaiDil := FIcmsaiDil + fltVenBasDil * objBase.fltIcmSai / 100;
    FImpFedDil := FImpFedDil + fltVenBasDil * objBase.fltImpFed / 100;
    FDesOpeDil := FDesOpeDil + fltVenBasDil * objBase.fltDesOpe / 100;

    FPrecoCusDil := FPrecoCusDil + fltCusBasDil;
    FPrecoCu2Dil := FPrecoCu2Dil + fltCu2BasDil;
    FPrecoVenDil := FPrecoVenDil + fltVenBasDil;
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

procedure TFormulaPpgDinamica.pCarregaBasesPorEmpresas;
begin
  //Bases por empresas
  qryBasEmp.SQL.Clear;
  qryBasEmp.SQL.Add(' SELECT                               ');
  qryBasEmp.SQL.Add('   BAS_CODBAS                         ');
  qryBasEmp.SQL.Add('   , BAS_CODITE                       ');
//  qryBasEmp.SQL.Add('   , BAS_EMBALA                       ');
//  qryBasEmp.SQL.Add('   , BAS_PESESP                       ');
//  qryBasEmp.SQL.Add('   , BAS_BASEPO                       ');
  qryBasEmp.SQL.Add('   , ITE_CNV_ML                       ');

  qryBasEmp.SQL.Add('   , ITE_PREULT                       ');
  qryBasEmp.SQL.Add('   , ITE_IMPULT                       ');

  qryBasEmp.SQL.Add('   , ITE_PRECOM                       ');
  qryBasEmp.SQL.Add('   , ITE_DESF01                       ');
  qryBasEmp.SQL.Add('   , ITE_DESF02                       ');
  qryBasEmp.SQL.Add('   , ITE_DESF03                       ');
  qryBasEmp.SQL.Add('   , ITE_DESF04                       ');
  qryBasEmp.SQL.Add('   , ITE_DESF05                       ');
  qryBasEmp.SQL.Add('   , ITE_DESF06                       ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') <>  '0') Then
  begin
    qryBasEmp.SQL.Add('   , ITE_ICMSAI                       ');
    qryBasEmp.SQL.Add('   , ITE_IMPFED                       ');
    qryBasEmp.SQL.Add('   , ITE_DESOPE                       ');
    qryBasEmp.SQL.Add('   , ITE_OUTVAL                       ');
    qryBasEmp.SQL.Add('   , ITE_PREMED                       ');
  end
  else
  begin
    qryBasEmp.SQL.Add('   , 0 AS ITE_ICMSAI                  ');
    qryBasEmp.SQL.Add('   , 0 AS ITE_IMPFED                  ');
    qryBasEmp.SQL.Add('   , 0 AS ITE_DESOPE                  ');
    qryBasEmp.SQL.Add('   , 0 AS ITE_OUTVAL                  ');
    qryBasEmp.SQL.Add('   , 0 AS ITE_PREMED                  ');
  end;

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    qryBasEmp.SQL.Add('   , BAS_PRECUS AS ITE_PRECUS         ');
    qryBasEmp.SQL.Add('   , BAS_PREVEN AS ITE_PREVEN         ');
  end
  else if (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') then
  begin
    qryBasEmp.SQL.Add('   , G.ITE_PRECUS                     ');
    qryBasEmp.SQL.Add('   , G.ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN       ');
  end
  else
  begin
    qryBasEmp.SQL.Add('   , G.ITE_PRECUS                     ');
    qryBasEmp.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN       ');
  end;

  If fCfgSis('IMPDIG') = '1' Then
    qryBasEmp.SQL.Add('   , I.ITE_IMPDIR                     ')
  else
    qryBasEmp.SQL.Add('   , G.ITE_IMPDIR                     ');

  qryBasEmp.SQL.Add(' FROM                                 ');
  qryBasEmp.SQL.Add('   PPG_BASEMP                         ');
  qryBasEmp.SQL.Add('   INNER JOIN ITEGER G                ');
  qryBasEmp.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryBasEmp.SQL.Add('   INNER JOIN CADITE I                ');
  qryBasEmp.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryBasEmp.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');
  qryBasEmp.SQL.Add('   AND BAS_CODEMP = :BASEMP           ');

  qryBasEmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryBasEmp.ParamByName('BASEMP').AsString := VS_strCodEmp;
  qryBasEmp.Open;
end;

procedure TFormulaPpgDinamica.pCarregaPrecosBases;
  Var
    intContador: Integer;
    objBase: TBaseAutomotiva;
    fltConc : Double;
    fltDil  : Double;
    cdsCadBas: TUniClientDataSet;
    conf: IConfTinta;
    fltDesOpeTinta: Double;
    fltPreCusPro,
    fltPreVenPro,
    fltPreVenItem : Double;
begin
  fltConc := 0;
  fltDil := 0;

  conf := fGetConfTinta('PPG');
  fltDesOpeTinta := conf.fGetDouble('DESOPE');

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  //Se existir bases cadastradas por empresas entao substitui as caracteristicas do produto;
  If Not qryBasEmp.IsEmpty Then
    pSubstituiBasesEmpresas(cdsCadBas);

  For intContador := 0 To Self.Count-1 Do
  Begin
    objBase := TBaseAutomotiva(Self.Items[intContador]);
    cdsCadBas.Locate('BAS_CODBAS', objBase.strCodBas, []);

    objBase.fltEmbala := cdsCadBas.FieldByName('BAS_EMBALA').AsFloat;

    objBase.fltPesEsp := cdsCadBas.FieldByName('BAS_PESESP').AsFloat;
    If (cdsCadBas.FieldByName('BAS_BASEPO').AsString = 'S') Then
      objBase.fltPesEsp := 1;

    If fCarregaPromocao(cdsCadBas.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
      fltPreCusPro, fltPreVenPro) Then
    Begin
      fltPreVenItem := fltPreVenPro;
    End
    Else
    Begin
      fltPreVenItem := cdsCadBas.FieldByName('ITE_PREVEN').AsFloat;
    End;

    objBase.fltPreVen := fltPreVenItem;

    objBase.strImpDir := cdsCadBas.FieldByName('ITE_IMPDIR').AsString;
    objBase.strCodIte := cdsCadBas.FieldByName('BAS_CODITE').AsString;

    If Pos('PERSONALIZ', Self.strSistema) <= 0 Then
      objBase.fltQtdCon := fFormataFloat(objBase.fltQtdCon, 1);

    objBase.fltOutVal := cdsCadBas.FieldByName('ITE_OUTVAL').AsFloat;

    if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
      objBase.fltIcmSai := calculadorFatVendas.fCalculaAliquota(objBase.strCodIte, objBase.strImpDir)
    else
      objBase.fltIcmSai := cdsCadBas.FieldByName('ITE_ICMSAI').AsFloat;
      
    objBase.fltImpFed := cdsCadBas.FieldByName('ITE_IMPFED').AsFloat;
    objBase.fltDesOpe := cdsCadBas.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
    objBase.fltPreMed := cdsCadBas.FieldByName('ITE_PREMED').AsFloat;
    objBase.fltPreUlt := cdsCadBas.FieldByName('ITE_PREULT').AsFloat;
    objBase.fltImpUlt := cdsCadBas.FieldByName('ITE_IMPULT').AsFloat;

    objBase.fltComLiq := fCalculaPrecoCompraLiq(cdsCadBas.Fieldbyname('ITE_PRECOM').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF01').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF02').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF03').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF04').AsFloat, cdsCadBas.Fieldbyname('ITE_DESF05').AsFloat,
                                                cdsCadBas.Fieldbyname('ITE_DESF06').AsFloat);

    fltConc := fltConc + objBase.fltQtdCon;
    fltDil := fltDil + objBase.fltQtdDil;
  End;

  FCalculo.Clear;
  FCalculo.Add('Valor da Base = (Quantidade * Preço) / (1000 * Peso Específico)');
  FCalculo.Add('Preço da Tinta = Soma(Valores de Base) * Volume Produzido');
end;

procedure TFormulaPpgDinamica.pCarregarColorantes;
begin
  inherited;
  qryCadBas.SQL.Clear;
  qryCadBas.SQL.Add(' SELECT                               ');
  qryCadBas.SQL.Add('   BAS_CODBAS                         ');
  qryCadBas.SQL.Add('   , BAS_CODITE                       ');
  qryCadBas.SQL.Add('   , BAS_EMBALA                       ');
  qryCadBas.SQL.Add('   , BAS_PESESP                       ');
  qryCadBas.SQL.Add('   , BAS_BASEPO                       ');  
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
  qryCadBas.SQL.Add('   PPG_CADBAS                         ');
  qryCadBas.SQL.Add('   INNER JOIN ITEGER G                ');
  qryCadBas.SQL.Add('     ON BAS_CODITE = G.ITE_CODITE     ');
  qryCadBas.SQL.Add('   INNER JOIN CADITE I                ');
  qryCadBas.SQL.Add('     ON G.ITE_CODITE = I.ITE_CODITE   ');
  qryCadBas.SQL.Add(' WHERE G.ITE_CODEMP = :CODEMP         ');

  //Necessario por causa da nova tabela de bases por empresas
  qryCadBas.SQL.Add('         UNION ALL                    ');

  qryCadBas.SQL.Add( fSelectBasesSemAmarracao );

  qryCadBas.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCadBas.Open;

  pCarregaBasesPorEmpresas;
end;

function fConsultaPpgAutomotivaDinamica(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaPpgAutomotivaDinamicaInterna(Sender, qryGen, tpcGeral, IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), False, Nil, Nil);
  FreeAndNil(qryGen);
End;

function fConsultaPpgAutomotivaDinamicaGeral(Sender: TForm): String; stdcall;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery(Sender);
  Result := fConsultaPpgAutomotivaDinamicaInterna(Sender, qryGen, tpcGeral, '1', False, Nil, Nil);
  FreeAndNil(qryGen);
End;

function fConsultaPpgAutomotivaDinamicaVenda(Sender: TForm; qryTinta: TUniQuery;
  strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario; sltItems: TStringList): String; stdcall;
Begin
  Result := fConsultaPpgAutomotivaDinamicaInterna(Sender, qryTinta, tpcVenda, strTabPre, blnFaturamento, dicRetorno, sltItems);
End;

function fConsultaPpgAutomotivaDinamicaInterna(Sender: TForm; qryTinta: TUniQuery;
  tipoConsulta: TTipoConsulta; strTabPre: String; blnFaturamento: Boolean; dicRetorno: TDicionario;
    sltItems: TStringList): String;
Begin
  Result := (TPpgConsultaEscolha.Create).fExecutarConsulta(Sender,
    qryTinta, tipoConsulta, strTabPre, TfrmConsultaCompPpg, '', blnFaturamento, dicRetorno, sltItems);
End;


procedure TFormulaPpgDinamica.pReformula(strTipCor, strTextBase, strCatalisador,
  strDiluente: String; intModDil: Integer);
  Var
    intCont: Integer;
    objBase: TBaseAutomotiva;
    fltVolume: Double;
begin
  fltVolume := fltVolumePro * 1000;
  //RESTAURA A FORMULACAO COM SOMENTE O CONCENTRADO
  For intCont := Self.Count - 1 DownTo 0 do
  Begin
    If TBaseAutomotiva(Self.Items[intCont]).strTipBas <> 'B' Then
    Begin
      Self.Delete(intCont);
    End
    Else
    Begin
      TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := 0;
    End;
  End;

  If strTipCor = 'DELTRON DG' Then
  Begin
    If intModDil = 0 Then
    Begin
      If Not fEmptyStr(strTextBase) Then
      Begin
        If strTextBase = 'D843' Then
        Begin
          objBase := TBaseAutomotiva(Self.Add);
          objBase.strCodBas := strTextBase;
          objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 8 / 30);
          objBase.strTipBas := 'T';

          If Not fEmptyStr(strDiluente) Then
          Begin
            objBase := TBaseAutomotiva(Self.Add);
            objBase.strCodBas := strDiluente;
            objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 3 / 30);
            objBase.strTipBas := 'D';
          End;

          objBase := TBaseAutomotiva(Self.Add);
          objBase.strCodBas := 'D819';
          objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 4 / 30);
          objBase.strTipBas := 'F';

          If Not fEmptyStr(strCatalisador) Then
          Begin
            objBase := TBaseAutomotiva(Self.Add);
            objBase.strCodBas := strCatalisador;
            objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 7 / 30);
            objBase.strTipBas := 'C';
          End;
        End

        Else If strTextBase = 'D844' Then
        Begin
          objBase := TBaseAutomotiva(Self.Add);
          objBase.strCodBas := strTextBase;
          objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 0.8 * 4 / 24);
          objBase.strTipBas := 'T';

          If Not fEmptyStr(strDiluente) Then
          Begin
            objBase := TBaseAutomotiva(Self.Add);
            objBase.strCodBas := strDiluente;
            objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 0.8 * 1 / 24);
            objBase.strTipBas := 'D'
          End;

          objBase := TBaseAutomotiva(Self.Add);
          objBase.strCodBas := 'D819';
          objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 0.8 * 4 / 24);
          objBase.strTipBas := 'F';

          If Not fEmptyStr(strCatalisador) Then
          Begin
            objBase := TBaseAutomotiva(Self.Add);
            objBase.strCodBas := strCatalisador;
            objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 0.8 * 7 / 24);
            objBase.strTipBas := 'C';
          End;
        End;
      End;
    End

    Else If intModDil = 1 Then
    Begin
      If Not fEmptyStr(strTextBase) Then
      Begin
        If strTextBase = 'D843' Then
        Begin
          objBase := TBaseAutomotiva(Self.Add);
          objBase.strCodBas := strCatalisador;
          objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 3 / 9);
          objBase.strTipBas := 'T';

          If Not fEmptyStr(strDiluente) Then
          Begin
            objBase := TBaseAutomotiva(Self.Add);
            objBase.strCodBas := strDiluente;
            objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 2 / 9);
            objBase.strTipBas := 'D';
          End;
        End
        Else If strTextBase = 'D844' Then
        Begin
          objBase := TBaseAutomotiva(Self.Add);
          objBase.strCodBas := strCatalisador;
          objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 3 / 18);
          objBase.strTipBas := 'T';

          If Not fEmptyStr(strDiluente) Then
          Begin
            objBase := TBaseAutomotiva(Self.Add);
            objBase.strCodBas := strDiluente;
            objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 2 / 18);
            objBase.strTipBas := 'D';
          End;
        End;

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strCatalisador;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 3 / 9);
        objBase.strTipBas := 'C';

      End;
    End

    Else If intModDil = 2 Then
    Begin
      If Not fEmptyStr(strCatalisador) Then
      Begin
        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strCatalisador;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 2 / 6);
        objBase.strTipBas := 'C';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strCatalisador;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 1 / 6);
        objBase.strTipBas := 'F';
      End;
    End

    Else If intModDil = 3 Then
    Begin
      If Not fEmptyStr(strTextBase) Then
      Begin
        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strTextBase;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 3 / 9);
        objBase.strTipBas := 'TB';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strCatalisador;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 1 / 9);
        objBase.strTipBas := 'C';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strDiluente;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 2 / 9);
        objBase.strTipBas := 'D';
      End;
    End

    Else If intModDil = 4 Then
    Begin
      If Not fEmptyStr(strTextBase) Then
      Begin
        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strTextBase;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 8 / 30);
        objBase.strTipBas := 'TB';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := 'D819';
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 4 / 30);
        objBase.strTipBas := 'F';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strCatalisador;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 4 / 30);
        objBase.strTipBas := 'C';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strDiluente;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 3 / 30);
        objBase.strTipBas := 'D';
      End;
    End

    Else If intModDil = 5 Then
    Begin
      If Not fEmptyStr(strCatalisador) Then
      Begin
        If Pos(strCatalisador, '_D803_D841_') > 0 Then
        Begin
          objBase := TBaseAutomotiva(Self.Add);
          objBase.strCodBas := strCatalisador;
          objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 1 / 6);
          objBase.strTipBas := 'C';

          objBase := TBaseAutomotiva(Self.Add);
          objBase.strCodBas := strDiluente;
          objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 1 / 6);
          objBase.strTipBas := 'D';
        End
        Else If Pos(strCatalisador, '_D861_D802_D863_') > 0 Then
        Begin
          objBase := TBaseAutomotiva(Self.Add);
          objBase.strCodBas := strCatalisador;
          objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 1 / 4);
          objBase.strTipBas := 'C';

          objBase := TBaseAutomotiva(Self.Add);
          objBase.strCodBas := strDiluente;
          objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 1 / 4);
          objBase.strTipBas := 'D';
        End;

      End;
    End

    Else If intModDil = 6 Then
    Begin
      If Not fEmptyStr(strTextBase) Then
      Begin
        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strTextBase;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 4 / 24);
        objBase.strTipBas := 'TB';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := 'D819';
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 4 / 24);
        objBase.strTipBas := 'F';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strCatalisador;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 7 / 24);
        objBase.strTipBas := 'C';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strDiluente;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 1 / 24);
        objBase.strTipBas := 'D';
      End;
    End

    Else If intModDil = 7 Then
    Begin
      If Not fEmptyStr(strTextBase) Then
      Begin
        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strTextBase;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 0.230840);
        objBase.strTipBas := 'TB';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strCatalisador;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 0.153893);
        objBase.strTipBas := 'C';

        objBase := TBaseAutomotiva(Self.Add);
        objBase.strCodBas := strDiluente;
        objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 0.153893);
        objBase.strTipBas := 'D';
      End;
    End;

  End
  Else If strTipCor = 'DELTRON BC' Then
  Begin
    objBase := TBaseAutomotiva(Self.Add);
    objBase.strCodBas := strDiluente;
    objBase.fltQtdDil := fRetPeso(objBase.strCodBas, fltVolume * 1 / 2);
    objBase.strTipBas := 'D';
  End;


  //MONTA A FORMULACAO DE ACORDO COM OS COLORANTES
  For intCont := 0 To Self.Count - 1 Do
  Begin
    If TBaseAutomotiva(Self.Items[intCont]).strTipBas = 'B' Then
    Begin
      If strTipCor = 'DELTRON DG' Then
      Begin
        If intModDil = 0 Then
        Begin
          If strTextBase = 'D843' Then
          Begin
            TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 8 / 30;
          End
          Else If strTextBase = 'D844' Then
          Begin
            TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 8 / 30;
          End;
        End

        Else If intModDil = 1 Then
        Begin
          If strTextBase = 'D843' Then
          Begin
            TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 3 / 9;
          End
          Else If strTextBase = 'D844' Then
          Begin
            TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 11 / 18;
          End;
        End

        Else If intModDil = 2 Then
        Begin
          TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 3 / 6;
        End

        Else If intModDil = 3 Then
        Begin
          TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 4 / 15;
        End

        Else If intModDil = 4 Then
        Begin
          TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 22 / 30;
        End

        Else If intModDil = 5 Then
        Begin
          If Pos(strCatalisador, '_D803_D841_') > 0 Then
          Begin
            TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 4 / 6;
          End
          Else
          Begin
            TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 1 / 2;
          End;

        End

        Else If intModDil = 6 Then
        Begin
          TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 1 / 3;
        End

        Else If intModDil = 7 Then
        Begin
          TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 0.461373;
        End;

      End
      Else If strTipCor = 'DELTRON BC' Then
      Begin
        TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdCon * 1 / 2;
      End;
      //TBaseAutomotiva(Self.Items[intCont]).fltQtdDil := TBaseAutomotiva(Self.Items[intCont]).fltQtdDil * fltVolumePro;
    End;
  End;

  Try
    pCarregaPrecosBases;
    pCalcularPrecos;
  Except
    On E: Exception Do
    Begin
      fMensagem('ATENÇÃO', e.Message, ['OK']);  
    End;
  End;



//DELTRON BC
//DELTRON DG
//DELFLEET
//DULON
//OMNI
//DELTRON UHS
//ENVIROBASE
//EMBALAGEM

end;

procedure TFormulaPpgDinamica.pReformulaNovo(const strTipo, strCodDil, strSistema: string; const fltPorDil: Double);
var
  intCont: Integer;
  diluente: TBaseAutomotiva;
  qryGen: TUniQuery;
  fltTotalVolumeAtual: Double;
  base: TBaseAutomotiva;
  fltTotalVolumeDiluido: Double;
  fltTaxa: Double;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT                                    ' +
        '   *                                                ' +
        ' FROM                                               ' +
        '   PPG_CADBAS B                                     ' +
        '   INNER JOIN PPG_CADDIL D                          ' +
        '     ON B.BAS_CODBAS = D.DIL_CODDIL                 ' +
        ' WHERE BAS_TIPO__ = :TIPO                           ' +
        '   AND DIL_SISTEM = :SISTEM                         ';

      qryGen.ParamByName('TIPO').AsString := strTipo;
      qryGen.ParamByName('SISTEM').AsString := strSistema;
      qryGen.Open;

      if qryGen.IsEmpty then
        Exit;

      fltTotalVolumeAtual := 0;

      for intCont := Self.Count - 1 downto 0 do
      begin
        base := (Self.Items[intCont] as TBaseAutomotiva);
        if base.strTipBas <> 'B' then
          Self.Delete(intCont)
        else
          fltTotalVolumeAtual := fltTotalVolumeAtual + (base.fltQtdCon / base.fltPesEsp);
      end;

      fltTotalVolumeDiluido := fltTotalVolumeAtual + (fltPorDil * fltTotalVolumeAtual / 100);
      fltTaxa := fltTotalVolumeAtual / fltTotalVolumeDiluido;

      diluente := (Self.Add as TBaseAutomotiva);
      diluente.strCodBas := strCodDil;
      diluente.strTipBas := 'D';
      diluente.fltPesEsp := qryGen.FieldByName('BAS_PESESP').AsFloat;
      diluente.fltQtdDil := (fltPorDil * fltTotalVolumeAtual / 100) * diluente.fltPesEsp;

      for intCont := Self.Count - 1 downto 0 do
      begin
        base := (Self.Items[intCont] as TBaseAutomotiva);

        if base.strTipBas <> 'D' then
        begin
          base.fltQtdDil := base.fltQtdCon  * fltTaxa;
        end
        else
        begin
          base.fltQtdDil := base.fltQtdDil * fltTaxa;
        end;  
      end;

//      pCarregaPrecosBases;
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

procedure TFormulaPpgDinamica.pSubstituiBasesEmpresas(var cdsCadBas: TUniClientDataSet);
  var fltPreCusPro,
      fltPreVenPro :Double;
begin
  qryBasEmp.First;
  While Not qryBasEmp.Eof Do
  Begin
    If cdsCadBas.Locate('BAS_CODBAS', qryBasEmp.FieldByName('BAS_CODBAS').AsString, []) Then
    Begin
      cdsCadBas.Edit;
      cdsCadBas.FieldByName('BAS_CODITE').AsString := qryBasEmp.FieldByName('BAS_CODITE').AsString;
      cdsCadBas.FieldByName('ITE_CNV_ML').AsFloat  := qryBasEmp.FieldByName('ITE_CNV_ML').AsFloat;

      cdsCadBas.FieldByName('ITE_PREULT').AsFloat  := qryBasEmp.FieldByName('ITE_PREULT').AsFloat;
      cdsCadBas.FieldByName('ITE_IMPULT').AsFloat  := qryBasEmp.FieldByName('ITE_IMPULT').AsFloat;

      cdsCadBas.FieldByName('ITE_PRECOM').AsFloat  := qryBasEmp.FieldByName('ITE_PRECOM').AsFloat;
      cdsCadBas.FieldByName('ITE_DESF01').AsFloat  := qryBasEmp.FieldByName('ITE_DESF01').AsFloat;
      cdsCadBas.FieldByName('ITE_DESF02').AsFloat  := qryBasEmp.FieldByName('ITE_DESF02').AsFloat;
      cdsCadBas.FieldByName('ITE_DESF03').AsFloat  := qryBasEmp.FieldByName('ITE_DESF03').AsFloat;
      cdsCadBas.FieldByName('ITE_DESF04').AsFloat  := qryBasEmp.FieldByName('ITE_DESF04').AsFloat;
      cdsCadBas.FieldByName('ITE_DESF05').AsFloat  := qryBasEmp.FieldByName('ITE_DESF05').AsFloat;
      cdsCadBas.FieldByName('ITE_DESF06').AsFloat  := qryBasEmp.FieldByName('ITE_DESF06').AsFloat;

      cdsCadBas.FieldByName('ITE_ICMSAI').AsFloat  := qryBasEmp.FieldByName('ITE_ICMSAI').AsFloat;
      cdsCadBas.FieldByName('ITE_IMPFED').AsFloat  := qryBasEmp.FieldByName('ITE_IMPFED').AsFloat;
      cdsCadBas.FieldByName('ITE_DESOPE').AsFloat  := qryBasEmp.FieldByName('ITE_DESOPE').AsFloat;
      cdsCadBas.FieldByName('ITE_OUTVAL').AsFloat  := qryBasEmp.FieldByName('ITE_OUTVAL').AsFloat;
      cdsCadBas.FieldByName('ITE_PREMED').AsFloat  := qryBasEmp.FieldByName('ITE_PREMED').AsFloat;


      If fCarregaPromocao(qryBasEmp.FieldByName('BAS_CODITE').AsString, fTabPreco, strCodCli, strCodCnd, intPrzMed,
        fltPreCusPro, fltPreVenPro) Then
      Begin
        cdsCadBas.FieldByName('ITE_PRECUS').AsFloat  := fltPreCusPro;
        cdsCadBas.FieldByName('ITE_PREVEN').AsFloat  := fltPreVenPro;
        FPromoc := 'S';

        If fltPreCusPro = 0 Then
          cdsCadBas.FieldByName('ITE_PRECUS').AsFloat  := qryBasEmp.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        cdsCadBas.FieldByName('ITE_PRECUS').AsFloat  := qryBasEmp.FieldByName('ITE_PRECUS').AsFloat;
        cdsCadBas.FieldByName('ITE_PREVEN').AsFloat  := qryBasEmp.FieldByName('ITE_PREVEN').AsFloat;
      End;

      cdsCadBas.FieldByName('ITE_IMPDIR').AsString := qryBasEmp.FieldByName('ITE_IMPDIR').AsString;
      cdsCadBas.Post;
    End;

    qryBasEmp.Next;
  End;

  cdsCadBas.First;
end;

procedure TFormulaPpgDinamica.SetstlListaAdicional2(
  const Value: TStringList);
begin
  FstlListaAdicional2 := Value;
end;

procedure TFormulaPpgDinamica.SetstlListaAdicional3(
  const Value: TStringList);
begin
  FstlListaAdicional3 := Value;
end;

procedure TFormulaPpgDinamica.SetstlListaAdicional4(
  const Value: TStringList);
begin
  FstlListaAdicional4 := Value;
end;

procedure TFormulaPpgDinamica.SetstrCaptionAdicional2(const Value: String);
begin
  FstrCaptionAdicional2 := Value;
end;

procedure TFormulaPpgDinamica.SetstrCaptionAdicional3(const Value: String);
begin
  FstrCaptionAdicional3 := Value;
end;

procedure TFormulaPpgDinamica.SetstrCaptionAdicional4(const Value: String);
begin
  FstrCaptionAdicional4 := Value;
end;

{ TfrmConsultaCompPpg }

function fGTinForPpgAutomotivaDinamica(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList;
  fltVolPro: Double; strCatalisador, strDiluente: String; strTipCor: String; strTextBase: String;
  intModDil: Integer; strTipPre: String; const fltPorDil: Double): Boolean;
var
  qryGen : TUniQuery;
  strBases: String;
  dicBases: TDicionario;
  strSql: String;

  intCont: Integer;
  strCampFor: String;
  strCampBas: String;

  objFormula: TFormulaPpgDinamica;
  objBase: TBaseAutomotiva;
  qryBases: TUniQuery;
  fltQuantidade: Double;
  cdsCadBas: TUniClientDataSet;
Begin
  Result := False;

  qryGen := nil;
  dicBases := nil;
  objFormula := nil;
  qryBases := nil;

  Try
    Try
      qryGen := fCriaQuery(nil);
      dicBases := TDicionario.Create;
      strBases := '';

      strSql := '';
      strSQL := strSQL + ' SELECT *  ';
      strSQL := strSQL + '   FROM PPG_CADPPG  ';
      strSQL := strSQL + '  WHERE PPG_MD5KEY = :ITETIN ';

      qryGen.Close;
      qryGen.SQL.Text := strSql;
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      If qryGen.IsEmpty Then
      begin
        strSql := '';
        strSQL := strSQL + ' SELECT *  ';
        strSQL := strSQL + ' FROM PPG_CADPPG  ';
        strSQL := strSQL + ' WHERE CONCAT( ';
        strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB10, "")) = :ITETIN;  ';

        qryGen.Close;
        qryGen.SQL.Text := strSql;
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;

        If qryGen.IsEmpty Then
        begin
          strSql := '';
          strSQL := strSQL + ' SELECT *  ';
          strSQL := strSQL + ' FROM PPG_CADPPG  ';
          strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
          strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB10, ""))) AS CHAR) = :ITETIN;  ';

          qryGen.Close;
          qryGen.SQL.Text := strSql;
          qryGen.ParamByName('ITETIN').AsString := strIteTin;
          qryGen.Open;


          if (qryGen.IsEmpty) then
          begin

            strSql := '';
            strSQL := strSQL + ' SELECT *  ';
            strSQL := strSQL + ' FROM PPG_CADPPG  ';
            strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
            strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB10, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB11, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB11, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB12, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB12, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB13, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB13, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB14, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB14, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB15, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB15, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB16, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB16, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB17, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB17, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB18, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB18, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB19, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB19, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_CODB20, ""),   ';
            strSQL := strSQL + '    IFNULL(PPG_QTDB20, ""))) AS CHAR) = :ITETIN; ';

            qryGen.Close;
            qryGen.SQL.Text := strSql;
            qryGen.ParamByName('ITETIN').AsString := strIteTin;
            qryGen.Open;

          end;
        end;
      end;

      If qryGen.IsEmpty Then
      Begin
        qryGen.Close;
        Result := False;
        Exit;
      End;

      If qryGen.IsEmpty Then
      Begin
        qryGen.Close;
        Result := False;
        Exit;
      End;

      objFormula := TFormulaPpgDinamica.Create('1');
      objFormula.fltVolumePro := fltVolPro;

      qryBases := fCriaQuery();
      qryBases.SQL.Text := 'SELECT * FROM PPG_CADBAS';
      qryBases.Open;

      For intCont := 1 To 20 Do
      Begin
        strCampFor := 'PPG_CODB' + fStrZero(intCont, 2);
        strCampBas := 'PPG_QTDB' + fStrZero(intCont, 2);

        If fEmptyStr(qryGen.FieldByName(strCampFor).AsString) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryGen.FieldByName(strCampFor).AsString;
        objBase.fltQtdCon := qryGen.FieldByName(strCampBas).AsFloat;
        objBase.strTipBas := 'B';

        if qryBases.Locate('BAS_CODBAS', objBase.strCodBas, []) then
        begin
          objBase.fltPesEsp := qryBases.FieldByName('BAS_PESESP').AsFloat;
          objBase.fltEmbala := qryBases.FieldByName('BAS_EMBALA').AsFloat;
        end;
      End;

      objFormula.pReformulaNovo(strTipCor, strDiluente, qryGen.FieldByName('PPG_SISTEM').AsString, fltPorDil);

      For intCont := 0 To objFormula.Count - 1 Do
      Begin
        If Pos('PERSONALIZ', qryGen.FieldByName('PPG_SISTEM').AsString) <= 0 Then
        Begin
          If strTipPre = 'C' Then
            fltQuantidade := fArredondaPPG(fFormataFloat(TBaseAutomotiva(objFormula.Items[intCont]).fltQtdCon, 1) * fltVolPro)
          Else
            fltQuantidade := fArredondaPPG(fFormataFloat(TBaseAutomotiva(objFormula.Items[intCont]).fltQtdDil, 1) * fltVolPro);
        End
        Else
        Begin
          If strTipPre = 'C' Then
            fltQuantidade := TBaseAutomotiva(objFormula.Items[intCont]).fltQtdCon * fltVolPro
          Else
            fltQuantidade := TBaseAutomotiva(objFormula.Items[intCont]).fltQtdDil * fltVolPro;
        End;

        if fltQuantidade <= 0 then
          Continue;

        arrFormul[intCont + 1].strFormul := TBaseAutomotiva(objFormula.Items[intCont]).strCodBas;
        arrFormul[intCont + 1].fltQtdbas := fltQuantidade;

        dicBases[arrFormul[intCont + 1].strFormul] := arrFormul[intCont + 1].fltQtdbas;
        strBases := strBases + QuotedStr(arrFormul[intCont + 1].strFormul) + ', ';
      End;

      strBases := Trim(strBases);
      If RightStr(strBases, 1) = ',' Then
        strBases := Copy(strBases, 1, Length(strBases) - 1);

      // Bases gerais
      strSql := '';
      strSql := strSql + ' SELECT ';
      strSql := strSql + '   BAS_CODBAS, ';
      strSql := strSql + '   BAS_CODITE ';
      strSql := strSql + ' FROM PPG_CADBAS ';
      strSql := strSql + ' WHERE BAS_CODBAS IN(' + strBases + '); ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Text := strSql;
      qryGen.Open;

      cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryGen);

      //Substitui se houver bases por empresas
      strSql := '';
      strSql := strSql + ' SELECT ';
      strSql := strSql + '   BAS_CODBAS, ';
      strSql := strSql + '   BAS_CODITE ';
      strSql := strSql + ' FROM PPG_BASEMP ';
      strSql := strSql + ' WHERE BAS_CODBAS IN(' + strBases + ') ';
      strSql := strSql + '   AND BAS_CODEMP = ' + QuotedStr(VS_strCodEmp);
      strSql := strSql + '   AND BAS_CODITE IS NOT NULL ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Text := strSql;
      qryGen.Open;

      If Not qryGen.IsEmpty Then
        pBasesPorEmpresas(cdsCadBas, qryGen);

      SetLength(arrBaixaPigmentos, cdsCadBas.RecordCount);

      While Not cdsCadBas.Eof Do
      Begin
        stlItensTraMl.Add(cdsCadBas.FieldByName('BAS_CODITE').AsString);
        arrBaixaPigmentos[cdsCadBas.RecNo - 1].strCodIte := cdsCadBas.FieldByName('BAS_CODITE').AsString;
        arrbaixaPigmentos[cdsCadBas.RecNo - 1].fltQtdBaixa := dicBases[cdsCadBas.FieldByName('BAS_CODBAS').AsString];
        cdsCadBas.Next;
      End;

      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicBases) then FreeAndNil(dicBases);
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(objFormula) then FreeAndNil(objFormula);
    if Assigned(qryBases) then FreeAndNil(qryBases);
  End;

End;

function fDigDadosTintometricos(qryTinta: TUniQuery; stlDesEmb: TStringList; stlProEmbLt, stlProEmbGl,
    stlProEmbBd, stlProEmbTb: TStringList;
    Var strIteEmb, strTipEmb: String; strTabPre: String; Var strTipPre: String; Var intQtdEmb: Integer;
    Var fltPreEmb, fltEmbala, fltPreCus, fltPreVen, fltVolPro: Double;
    Var dicRetorno: TDicionario; strDesCor: String): Boolean;
var
  objBase: TBaseAutomotiva;
  objFormula: TFormulaPpgDinamica;
  intContador: Integer;
  strTipCor: String;
  fltPreCu2: Double;

  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
Begin
  Result := False;
  objFormula := nil;
  frmDigTintaAutomotivaPpgNova := nil;
  conf := fGetConfTinta('PPG');
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaPpgDinamica.Create(strTabPre);;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 1000;
      objFormula.fltVolumePro := dicRetorno['volpro'];
      objFormula.strDescri := fRetornaDescricaoPpgAutomotivaDinamica(qryTinta, strDesCor);

      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      // strTipCor := fRetTipoCor(qryTinta);
      strTipCor := qryTinta.FieldByName('PPG_TIPO__').AsString;

      objFormula.strSistema := qryTinta.FieldByName('PPG_SISTEM').AsString;

      objFormula.fltAcrMob := qryTinta.FieldByName('PPG_ACRMOB').AsFloat;

      objFormula.FDadosAdicionais := True;
      objFormula.FCaptionAdicional := 'Diluentes';
      objFormula.FListaAdicional := fGetDiluentes(strTipCor, qryTinta.FieldByName('PPG_SISTEM').AsString);
      objFormula.FAdicionalConcentrado := True;
      objFormula.FIndiceAdicional := 0;

      For intContador := 1 To 20 Do
      Begin
        If fEmptyStr(qryTinta.FieldByName('PPG_CODB' + fStrZero(intContador, 2)).AsString) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := qryTinta.FieldByName('PPG_CODB' + fStrZero(intContador, 2)).AsString;
        objBase.fltQtdCon := qryTinta.FieldByName('PPG_QTDB' + fStrZero(intContador, 2)).AsFloat;
        objBase.strTipBas := 'B';
      End;

      objFormula.pCarregaPrecosBases;

      if objFormula.FListaAdicional.Count > 0 then
        objFormula.pReformulaNovo(qryTinta.FieldByName('PPG_TIPO__').AsString,
          objFormula.FListaAdicional[0],
          qryTinta.FieldByName('PPG_SISTEM').AsString,
          0)
      else
        objFormula.pReformulaNovo(qryTinta.FieldByName('PPG_TIPO__').AsString,
          '',
          qryTinta.FieldByName('PPG_SISTEM').AsString,
          0);

      objFormula.pCarregaPrecosBases;

      pCriarFormularios(TfrmDigTintaAutomotivaPpgNova, frmDigTintaAutomotivaPpgNova);
      objFormula.strCodEmpEst := IfNull(dicRetorno['codemp'], VS_strCodEmp);
      frmDigTintaAutomotivaPpgNova.objFormula := objFormula;
      frmDigTintaAutomotivaPpgNova.stlDesEmb := stlDesEmb;
      frmDigTintaAutomotivaPpgNova.stlProEmbLt := stlProEmbLt;
      frmDigTintaAutomotivaPpgNova.stlProEmbGl := stlProEmbGl;
      frmDigTintaAutomotivaPpgNova.stlProEmbBd := stlProEmbBd;
      frmDigTintaAutomotivaPpgNova.stlProEmbTb := stlProEmbTb;

      frmDigTintaAutomotivaPpgNova.strProEmbCo := 'XXXXX';
      frmDigTintaAutomotivaPpgNova.strProEmbSp := 'XXXXX';
      frmDigTintaAutomotivaPpgNova.Caption := frmDigTintaAutomotivaPpgNova.Caption + 'PPG';
//      frmDigTintaAutomotivaPpgNova.edtVolume.Text := '1';
      frmDigTintaAutomotivaPpgNova.strIdePro      := dicRetorno['idepro'];
      frmDigTintaAutomotivaPpgNova.Sistema := qryTinta.FieldByName('PPG_SISTEM').AsString;
      Result := (frmDigTintaAutomotivaPpgNova.ShowModal = mrOk);

      If (Result) Then
      Begin
        Case frmDigTintaAutomotivaPpgNova.objFormula.tpeTipEmb of
          teLitro  : begin
                       strTipEmb := 'LT';
                       fltEmbala := 1.000;
                     end;
          teBalde  : begin
                       strTipEmb := 'BD';
                       fltEmbala := 18.000;
                     end;
          teGalao  : begin
                       strTipEmb := 'GL';
                       fltEmbala := 3.600;
                     end;
          teTambor : begin
                       strTipEmb := 'TB';
                       fltEmbala := 200.000;
                     end;
        end;

        frmDigTintaAutomotivaPpgNova.edtVolume.Text := FloatToStr(fltEmbala);

        strIteEmb := frmDigTintaAutomotivaPpgNova.objFormula.strCodEmb;
        strTipPre := IIF(frmDigTintaAutomotivaPpgNova.rdgModoVenda.ItemIndex = 0, 'C', 'D');
        intQtdEmb := StrToIntDef(frmDigTintaAutomotivaPpgNova.edtQtdEmb.Text, 0);
        fltPreEmb := frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoEmbalagem;

        If strTipPre = 'C' Then
        Begin
          fltPreCus := frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoCusCon;
          fltPreCu2 := frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoCu2Con;
          fltPreVen := frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoVenCon;
        End
        Else
        Begin
          fltPreCus := frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoCusDil;
          fltPreCu2 := frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoCu2Dil;
          fltPreVen := frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoVenDil;
        End;

        dicRetorno['premed'] := IfThen(frmDigTintaAutomotivaPpgNova.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaPpgNova.objFormula.fltPreMedCon,
          frmDigTintaAutomotivaPpgNova.objFormula.fltPreMedDil) +
          frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoMedioEmbalagem;

        dicRetorno['impult'] := IfThen(frmDigTintaAutomotivaPpgNova.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaPpgNova.objFormula.fltImpUltCon,
          frmDigTintaAutomotivaPpgNova.objFormula.fltImpUltDil) +
          frmDigTintaAutomotivaPpgNova.objFormula.fltUltimoImpostoEmbalagem;

        dicRetorno['preult'] := IfThen(frmDigTintaAutomotivaPpgNova.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaPpgNova.objFormula.fltPreUltCon,
          frmDigTintaAutomotivaPpgNova.objFormula.fltPreUltDil) +
          frmDigTintaAutomotivaPpgNova.objFormula.fltPreUltEmbalagem;

        dicRetorno['prctin'] := IfThen(frmDigTintaAutomotivaPpgNova.rdgModoVenda.ItemIndex = 0,
          frmDigTintaAutomotivaPpgNova.objFormula.fltComLiqCon,
          frmDigTintaAutomotivaPpgNova.objFormula.fltComLiqDil) +
          frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoCompraLiquidoEmbalagem;

        fltPreCus := fltPreCus + frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoCustoEmbalagem;
        fltPreCu2 := fltPreCu2 + frmDigTintaAutomotivaPpgNova.objFormula.fltPrecoCusto2Embalagem;

//        fltVolPro := fltEmbala;
        fltVolPro := frmDigTintaAutomotivaPpgNova.objFormula.fltVolumePro;

        dicRetorno['obscolorista']   := frmDigTintaAutomotivaPpgNova.edtDescricaoColorista.Text;
        dicRetorno['tipoformulacao'] := frmDigTintaAutomotivaPpgNova.rdgTipoFormula.ItemIndex;

        dicRetorno['volpro'] := fltVolPro;
        dicRetorno['moddil'] := frmDigTintaAutomotivaPpgNova.cmbListaAdicional.ItemIndex;
        dicRetorno['tipcor'] := frmDigTintaAutomotivaPpgNova.cmbTipoEmbalagem.Text;
        dicRetorno['coddil'] := frmDigTintaAutomotivaPpgNova.cmbListaAdicional.Text;
        dicRetorno['pordil'] := frmDigTintaAutomotivaPpgNova.PorDil;
        dicRetorno['linha_'] := frmDigTintaAutomotivaPpgNova.Sistema;

        dicRetorno['precus'] := fltPreCus;
        dicRetorno['precu2'] := fltPreCu2;
        dicRetorno['tippre'] := strTipPre;
        dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
        objFormula.pCalculaImpostosSaida(dicRetorno);

        dicRetorno['promoc'] := frmDigTintaAutomotivaPpgNova.objFormula.StrPromoc;

        dicRetorno['saldocols'] := frmDigTintaAutomotivaPpgNova.blnSaldoSuficiente;
        dicRetorno.AdicionarObjeto('formul', frmDigTintaAutomotivaPpgNova.matrizSaldosColorantes);
      End;

      If (Result) And (Assigned(dicretorno)) Then
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
    if Assigned(frmDigTintaAutomotivaPpgNova) then FreeAndNil(frmDigTintaAutomotivaPpgNova);
  End;
End;

function fRetornaUniTraProPpgAutomotivaDinamica(strTipPre: String; fltPrcTin, fltPrvTin: Double): Double;
Var
  conf: IConfTinta;
Begin
  conf := fGetConfTinta('PPG');

//  If fArqIniTinta(0, 'PPG', 'TRAPPG', '0') = 'VEN' Then
  If conf.fGet('TRAPPG') = 'VEN' Then
    Result := fltPrvTin * conf.fGetDouble('FATPPG') //fStrTofloat(fArqIniTinta(0, 'PPG', 'FATPPG', '1'))
  Else
    Result := fltPrcTin * conf.fGetDouble('FATPPG'); //fStrToFloat(fArqIniTinta(0, 'PPG', 'FATPPG', '1'));

  Result := fFormataFloat(Result, 2);
End;

procedure pRetornaTabelaPrecoPpgAutomotiva(dicRetorno: TDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  objFormula: TFormulaPpgDinamica;
  objBase: TBaseAutomotiva;
  intContador: Integer;
  calculadorFatVendas: ICalculadorFatVendas;
  conf: IConfTinta;
  strTabelaUnica: String;
begin
  conf := fGetConfTinta('PPG');
  objFormula := nil;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      objFormula := TFormulaPpgDinamica.Create('1');
      objFormula.blnCalculaUnitario := False;
      objFormula.calculadorFatVendas := calculadorFatVendas;
      objFormula.fltVolumeOri := 1000;
      objFormula.strOpcDoc := IfNull(dicRetorno['opcdoc'], '');
      objFormula.strCodCli := IfNull(dicRetorno['codcli'], '');
      objFormula.strCodCnd := IfNull(dicRetorno['codcnd'], '');
      objFormula.intPrzMed := IfNull(dicRetorno['przmed'], 0);

      objFormula.fltAcrMob := fRetornaAcrescimoMaoObra(dicRetorno['itetin']);

      objFormula.fltVolumePro := dicRetorno['volpro'];

      If dicRetorno['tippre'] = 'C' Then
        objFormula.mveModoVenda := mvConcentrado
      Else
        objFormula.mveModoVenda := mvDiluido;

      objFormula.fltFatorAcerto := fltFatorAcerto;

      objFormula.strSistema := IfNull(dicRetorno['linha_'], '');

      objFormula.strCodEmb := dicRetorno['iteemb'];
      objFormula.strIdePro := IfNull(dicRetorno['idepro'], '');

      For intContador := 1 To 20 Do
      Begin

        If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
          Break;

        objBase := TBaseAutomotiva(objFormula.Add);
        objBase.strCodBas := dicRetorno['base' + fStrZero(intContador, 2)];
        If dicRetorno['tippre'] = 'C' Then
          objBase.fltQtdCon := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * (objFormula.fltVolumeOri / 1000) / objFormula.fltVolumePro
        Else
          objBase.fltQtdDil := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)], 3) * (objFormula.fltVolumeOri / 1000) / objFormula.fltVolumePro;
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
            Begin
              objFormula.pCalculaImpostosSaida(dicRetorno);
              dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina[objFormula.mveModoVenda]);
              dicRetorno['promoc'] := objFormula.StrPromoc;
            End;

            If dicRetorno['tippre'] = 'C' Then
            Begin
              dicRetorno['impult'] := objFormula.fltImpUltCon + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltCon + objFormula.fltPreUltEmbalagem;
              dicRetorno['premed'] := objFormula.fltPreMedCon + objFormula.fltPrecoMedioEmbalagem;
              dicRetorno['prctin'] := objFormula.fltComLiqCon + objFormula.fltPrecoCompraLiquidoEmbalagem;
            End
            Else
            Begin
              dicRetorno['impult'] := objFormula.fltImpUltDil + objFormula.fltUltimoImpostoEmbalagem;
              dicRetorno['preult'] := objFormula.fltPreUltDil + objFormula.fltPreUltEmbalagem;
              dicRetorno['premed'] := objFormula.fltPreMedDil + objFormula.fltPrecoMedioEmbalagem;
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
    if Assigned(objFormula) then FreeAndNil(objFormula);
  End;
End;


procedure pRetornaDadosPpgAutomotivaDinamica(strIteTin: String; dicRetorno: TDicionario);
var
  qryCadGen: TUniQuery;
  strSQL: String;
begin
  qryCadGen := nil;
  Try
    Try
      qryCadGen := fCriaQuery(Nil);

      strSQL := '';
      strSQL := strSQL + ' SELECT *  ';
      strSQL := strSQL + ' FROM PPG_CADPPG  ';
      strSQL := strSQL + ' WHERE CONCAT( ';
      strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB10, "")) = :ITETIN;  ';

      qryCadGen.Close;
      qryCadGen.SQL.Clear;
      qryCadGen.SQL.Add(strSQL);
      qryCadGen.ParamByName('ITETIN').AsString := strIteTin;
      qryCadGen.Open;

      if qryCadGen.IsEmpty then
      begin
        strSQL := '';
        strSQL := strSQL + ' SELECT *  ';
        strSQL := strSQL + ' FROM PPG_CADPPG  ';
        strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
        strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB10, ""))) AS CHAR) = :ITETIN;  ';

        qryCadGen.Close;
        qryCadGen.SQL.Clear;
        qryCadGen.SQL.Add(strSQL);
        qryCadGen.ParamByName('ITETIN').AsString := strIteTin;
        qryCadGen.Open;

        if (qryCadGen.IsEmpty) then
        begin
          strSQL := '';
          strSQL := strSQL + ' SELECT *  ';
          strSQL := strSQL + ' FROM PPG_CADPPG  ';
          strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
          strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB10, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB11, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB11, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB12, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB12, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB13, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB13, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB14, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB14, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB15, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB15, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB16, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB16, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB17, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB17, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB18, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB18, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB19, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB19, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_CODB20, ""),   ';
          strSQL := strSQL + '    IFNULL(PPG_QTDB20, ""))) AS CHAR) = :ITETIN;  ';

          qryCadGen.Close;
          qryCadGen.SQL.Clear;
          qryCadGen.SQL.Add(strSQL);
          qryCadGen.ParamByName('ITETIN').AsString := strIteTin;
          qryCadGen.Open;

        end;

      end;

      if qryCadGen.IsEmpty then
        Exit;

      dicRetorno['codtin'] := qryCadGen.FieldByName('PPG_CODCOR').AsString;
      dicRetorno['montad'] := qryCadGen.FieldByName('PPG_MONTAD').AsString;
      dicRetorno['martin'] := qryCadGen.FieldByName('PPG_TIPO__').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCadGen) then FreeAndNil(qryCadGen);
  End;
end;


function fRetornaDescricaoPpgAutomotivaDinamica(qryTinta: TUniQuery; strDesCor: String): String;
begin
  Result := strDesCor;
end;

function fRetNomMontadora(strcodMon: String): String;
  Var
    qrygen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Text := 'SELECT MON_DESCRI FROM PPG_CADMON WHERE MON_CODMON = :CODMON';
  qryGen.ParamByName('CODMON').AsString := strcodMon;
  qryGen.Open;

  Result := qryGen.FieldByName('MON_DESCRI').AsString;
  FreeAndNil(qrygen);
end;

function fRetCodMontadora(strNomMon: String): String;
  Var
    qrygen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);
  qryGen.SQL.Text := 'SELECT MON_CODMON FROM PPG_CADMON WHERE MON_DESCRI = :NOMMON';
  qryGen.ParamByName('NOMMON').AsString := strNomMon;
  qryGen.Open;

  Result := qryGen.FieldByName('MON_CODMON').AsString;
  FreeAndNil(qrygen);
end;

function fRetornaPrecoPpgAutomotivaDinamica(Sender: TForm; qryTinta: TUniQuery; var dicRetorno: TDicionario;
  blnFaturamento: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil): Boolean;
  Var
    strTipEmb: String;
    strIteTin: String;
    strMontadora: String;
    strAno: String;
    strIteEmb: String;
    strTabPre: String;
    strTipPre: String;
    intQtdEmb: Integer;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltPreVen: Double;
    fltVolPro: Double;

//    fltPrcTin: Double;
    fltPrvTin: Double;
    fltUniTar: Double;

    stlDesEmb: TStringList;
    stlProEmbLt: TStringList;
    stlProEmbGl: TStringList;
    stlProEmbBd: TStringList;
    stlProEmbTb: TStringList;

    strTipCor: String;
    conf: IConfTinta;
    strAuto: String;
    tinta : IConsultaTinta;
    strDesCor: String;
    blnUsaPreCus: Boolean;
begin
  Result := False;
  conf := fGetConfTinta('PPG');
  strTipEmb := '';
  strTabPre := '';
  fltPreEmb := 0;
  fltEmbala := 0;
  fltPreCus := 0;
  fltPreVen := 0;
  fltVolPro := 1;

  strTipEmb := dicRetorno['tipemb'];
  strTabPre := dicRetorno['tabpre'];
  intQtdEmb := dicRetorno['qtdemb'];
  blnUsaPreCus := dicRetorno['usaprecus'];

{
  If (fConsultaPpgAutomotivaDinamicaVenda(Sender, qryTinta, strTabPre) = '-1') Then
  Begin
    Exit;
  End;
}

  If strTab = 'N' Then
  Begin
    strAuto := fConsultaPpgAutomotivaDinamicaVenda(Sender, qryTinta, strTabPre, blnFaturamento, dicRetorno, sltItems);

    If (strAuto = '-1') Then
    Begin
      Exit;
    End;
  End
  Else
    strAuto := strAutoTab;

  tinta := TPpgConsulta.Create;

  qryTinta.Close;
  qryTinta.SQL.Text := tinta.fGetSelectAutoIncrem(strAuto);
  qryTinta.Open;

  strIteTin := qryTinta.FieldByName('PPG_MD5KEY').AsString;

  strMontadora := fRetNomMontadora(qryTinta.FieldByName('PPG_MONTAD').AsString);
  strAno := RightStr(Trim(qryTinta.FieldByName('PPG_A_N_O_').AsString), 2);

  stlDesEmb := TStringList.Create;
  stlProEmbLt := TStringList.Create;
  stlProEmbGl := TStringList.Create;
  stlProEmbBd := TStringList.Create;
  stlProEmbTb := TStringList.Create;

  // strTipCor := fRetTipoCor(qryTinta);
  strTipCor := qryTinta.FieldByName('PPG_TIPO__').AsString;
  stlDesEmb.Text := strTipCor;
  stlProEmbLt.Text := fRetEmbalagemLT(strTipCor);
  stlProEmbGl.Text := fRetEmbalagemGL(strTipCor);
  stlProEmbBd.Text := fRetEmbalagemBD(strTipCor);
  stlProEmbTb.Text := fRetEmbalagemTB(strTipCor);

  If Not fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmbLt, stlProEmbGl, stlProEmbBd, stlProEmbTb,
    strIteEmb, strTipEmb, strTabPre, strTipPre, intQtdEmb, fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
    fltVolPro, dicRetorno, strDesCor) Then
  Begin
    Exit;
  End;

  strDesCor := Trim(tinta.fGetDescricao(qryTinta.FieldbyName('AUTOINCREM').AsString));

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltPreVen + fltPreEmb;

//  fltPrcTin := fltPreCus;
  fltPrvTin := fltUnitar;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
//  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROPPG'); //fArqIniTinta(0, 'PPG', 'PROPPG', '');
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['tippre'] := strTipPre;
  dicRetorno['embala'] := fltEmbala;
  dicRetorno['descor'] := '';
  dicRetorno['volpro'] := fltVolPro;
  dicRetorno['chafor'] := fRetornaDescricaoPpgAutomotivaDinamica(qryTinta, strDesCor) + strTipEmb;
  dicRetorno['descor'] := strDesCor;

  dicRetorno['montad'] := strMontadora;
  dicRetorno['a_n_o_'] := strAno;

  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');

  pFormataValores(dicRetorno, fCfgSis('DECUNI', varInteger));  

  Result := True;
end;

function fRetTipoCor(qrytinta: TUniQuery): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  qryGen.SQL.Text := 'SELECT BAS_TIPO__ FROM PPG_CADBAS WHERE BAS_CODBAS = :CODBAS;';
  {*******************************************}
  {* TODAS AS BASES SÃO DO MESMO TIPO        *}
  {****************************************PH*}
  qryGen.ParamByName('CODBAS').AsString := qryTinta.FieldByName('PPG_CODB01').AsString;
  qryGen.Open;
  Result := qryGen.FieldByName('BAS_TIPO__').AsString;
  FreeAndNil(qryGen);
end;

function fRetVolume(strCodBas: String; fltGramas: Double): Double;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  qryGen.SQL.Text := 'SELECT (:QTD / BAS_PESESP) ML FROM PPG_CADBAS WHERE BAS_CODBAS = :CODBAS;';
  qryGen.ParamByName('QTD').AsFloat := fltGramas;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;
  Result := qryGen.FieldByName('ML').AsFloat;
  FreeAndNil(qryGen);
end;

function fRetPeso(strCodBas: String; fltVolume: Double): Double;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  qryGen.SQL.Text := 'SELECT (:QTD * BAS_PESESP) ML FROM PPG_CADBAS WHERE BAS_CODBAS = :CODBAS;';
  qryGen.ParamByName('QTD').AsFloat := fltVolume;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;
  Result := qryGen.FieldByName('ML').AsFloat;
  FreeAndNil(qryGen);
end;

function fRetEmbalagemLT(strTipCor: String): String;
Var
  conf: IConfTinta;
  confEmb: IConfEmb;
begin
  conf := fGetConfTinta('PPG');
  confEmb := fGetConfEmb('PPG');

  if Pos('DELTRON', strTipCor) > 0 then
    Result := conf.fGet('PPGLDT')
  else if Pos('DELFLEET', strTipCor) > 0 then
    Result := conf.fGet('PPGLDF')
  else if Pos('DULON', strTipCor) > 0 then
    Result := conf.fGet('PPGLDU')
  else if Pos('OMNI', strTipCor) > 0 then
    Result := conf.fGet('PPGLOM')
  else if Pos('ENVIROBASE', strTipCor) > 0 then
    Result := conf.fGet('PPGLDT');

//AQUI CONFIGURACOES (PM)
  If (conf.fGet('NOVFOR') = 'S') Then
  Begin
    Result := '';
  //forma nova com troca de embalagem
    if Pos('2K', strTipCor) > 0 then
      Result := confEmb.fGet('PPGPML2K')
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLAC')
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLDF')
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLDT')
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLDU')
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLEB')
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLIN')
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLSG')
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLZY');
  End;

end;

function fRetEmbalagemGL(strTipCor: String): String;
Var
  conf: IConfTinta;
  confEmb: IConfEmb;
begin
  conf := fGetConfTinta('PPG');
  confEmb := fGetConfEmb('PPG');

  if Pos('DELTRON', strTipCor) > 0 then
    Result := conf.fGet('PPGGDT')
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := conf.fGet('PPGGDF')
  Else If Pos('DULON', strTipCor) > 0 Then
    Result := conf.fGet('PPGGDU')
  Else If Pos('OMNI', strTipCor) > 0 Then
    Result := conf.fGet('PPGGOM')
  Else If Pos('ENVIROBASE', strTipCor) > 0 Then
    Result := conf.fGet('PPGGDT');

//AQUI CONFIGURACOES (PM)
  If (conf.fGet('NOVFOR') = 'S') Then
  Begin
    Result := '';
    //Forma nova com troca de embalagem
    If Pos('2K', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMG2K')
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMGAC')
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMGDF')
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMGDT')
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMGDU')
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMGEB')
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMGIN')
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMGSG')
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMGZY'); 
  End;
end;

function fRetOpcoesDiluicao(strTipCor: String): TStringList;
begin
  Result := TStringList.Create;
  Result.Clear;

  If strTipCor = 'DELTRON DG' Then
  Begin
    Result.Add('Texturar e Flexibilizar');
    Result.Add('Texturar');
    Result.Add('Flexibilizado Brilhante');
    Result.Add('Fosco');
    Result.Add('Flexibilizado e Fosco');
    Result.Add('Brilhante e Rígido');
    Result.Add('Flexibilizado e Acetinado');
    Result.Add('Acetinado');
  End
  Else If strTipCor = 'DELTRON BC' Then
  Begin
    Result.Add('Diluir');
  End
  Else
    Result.Add('Sem Ação')

end;

function fRetDiluentes(strTipCor: String; intModDil: Integer; strCatalisador: String): TStringList;
begin
  Result := TStringList.Create;
  Result.Clear;

  If (strTipCor = 'DELTRON DG') Or (strTipCor = 'DELTRON BC') Then
  Begin
    If intModDil <> 2 Then
    Begin
      Result.Add('D808');
      Result.Add('807');

      If strCatalisador <> 'D863' Then
        Result.Add('D812');
    End;
  End
  Else
    Result.Add('Sem Diluente');
end;

function fGetDiluentes(const strLinha, strSistema: string): TStringList;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT                                    ' +
        '   *                                                ' +
        ' FROM                                               ' +
        '   PPG_CADBAS B                                     ' +
        '   INNER JOIN PPG_CADDIL D                          ' +
        '     ON B.BAS_CODBAS = D.DIL_CODDIL                 ' +
        ' WHERE BAS_TIPO__ = :TIPO                           ' +
        '   AND DIL_SISTEM = :SISTEM                         ';


      qryGen.ParamByName('TIPO').AsString := strLinha;
      qryGen.ParamByName('SISTEM').AsString := strSistema;
      qryGen.Open;

      Result := TStringList.Create;

      while not qryGen.Eof do
      begin
        Result.Add(qryGen.FieldByName('BAS_CODBAS').AsString);
        qryGen.Next;
      end;

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


function fRetCatalisadores(strTipCor: String; intModDil: Integer): TStringList;
begin
  Result := TStringList.Create;
  Result.Clear;

//  Result.Add('Texturar e Flexibilizar');
//  Result.Add('Texturar');
//  Result.Add('Flexibilizado Brilhante');
//  Result.Add('Fosco');
//  Result.Add('Flexibilizado e Fosco');
//  Result.Add('Brilhante e Rígido');
//  Result.Add('Flexibilizado e Acetinado');
//  Result.Add('Acetinado');

  If strTipCor = 'DELTRON DG' Then
  Begin
    Result.Add('D803');
    Result.Add('D841');
    Result.Add('D861');

    If intModDil = 5  Then
    Begin
      Result.Add('D802');
      Result.Add('D863');
    End;

  End
  Else
    Result.Add('Sem Catalisador');
end;

function fRetTexturBaseMat(strTipCor: String; intModDil: Integer): TStringList;
begin
  Result := TStringList.Create;
  Result.Clear;

//  Result.Add('Texturar e Flexibilizar');
//  Result.Add('Texturar');
//  Result.Add('Flexibilizado Brilhante');
//  Result.Add('Fosco');
//  Result.Add('Flexibilizado e Fosco');
//  Result.Add('Brilhante e Rígido');
//  Result.Add('Flexibilizado e Acetinado');
//  Result.Add('Acetinado');

  If strTipCor = 'DELTRON DG' Then
  Begin
    If intModDil < 2 Then
    Begin
      Result.Add('D843');
      Result.Add('D844');
    End
    Else If ((intModDil > 2) And (intModDil < 5) Or (intModDil > 5)) Then
    Begin
      Result.Add('759');
    End;
  End
  Else
    Result.Add('Sem Texturizante');

end;

function fRetStrTexturBaseMat(strTipCor: String; intModDil: Integer): String;
begin
  Result := 'Texturizante';

  If strTipCor = 'DELTRON DG' Then
  Begin
    If ((intModDil > 2) And (intModDil < 5) Or (intModDil > 5)) Then
    Begin
      Result := 'Base';
    End;
  End;
end;

function fRetQtdDiluente(strTipCor: String; fltVolPro: Double; intModDil: Integer; strTexBas: String; strCatalisador: String): Double;
begin
//  Result.Add('Texturar e Flexibilizar');
//  Result.Add('Texturar');
//  Result.Add('Flexibilizado Brilhante');
//  Result.Add('Fosco');
//  Result.Add('Flexibilizado e Fosco');
//  Result.Add('Brilhante e Rígido');
//  Result.Add('Flexibilizado e Acetinado');
//  Result.Add('Acetinado');
  Result := 0;

  If strTipCor = 'DELTRON DG' Then
  Begin
    If intModDil = 0 Then
    Begin
      If strTexBas = 'D843' Then
        Result := fltVolPro * 3 / 30
      Else If strTexBas = 'D844' Then
        Result := fltVolPro * 1 / 30;
    End
    Else If intModDil = 1 Then
    Begin
      If strTexBas = 'D843' Then
        Result := fltVolPro * 2 / 9
      Else If strTexBas = 'D844' Then
        Result := fltVolPro * 2 / 18;
    End
    Else If intModDil = 3 Then
    Begin
      Result := fltVolPro * 2 / 9;
    End
    Else If intModDil = 4 Then
    Begin
      Result := fltVolPro * 3 / 30;
    End
    Else If intModDil = 5 Then
    Begin
      If Pos(strCatalisador, '_D803_D841_') > 0 Then
      Begin
        Result := fltVolPro * 1 / 6;
      End
      Else If Pos(strCatalisador, '_D861_D802_') > 0 Then
      Begin
        Result := fltVolPro * 1 / 4;
      End;
    End
    Else If intModDil = 6 Then
    Begin
      Result := fltVolPro * 1 / 24;
    End
    Else If intModDil = 7 Then
    Begin
      Result := fltVolPro * 0.153893
    End;

  End
  Else If strTipCor = 'DELTRON BC' Then
  Begin
    Result := fltVolPro * 1 / 2;
  End;
end;

function fTemDiluente(strTipCor: String): Boolean;
begin
  If (strTipCor = 'DELTRON DG') Or (strTipCor = 'DELTRON BC') Then
    Result := True
  Else
    Result := False;
end;

function fRetQtdCatalisador(strTipCor: String; strTextBase: String; fltVolPro: Double; intModDil: Integer; strCatalisador: String): Double;
begin
  Result := 0;
  If strTipCor = 'DELTRON DG' Then
  Begin
    If intModDil = 0 Then
    Begin
      Result := fltVolPro * 7 / 30;
    End

    Else If intModDil = 1 Then
    Begin
      Result := fltVolPro * 1 / 9;
    End

    Else If intModDil = 2 Then
    Begin
      Result := fltVolPro * 2 / 6;
    End

    Else If intModDil = 3 Then
    Begin
      Result := fltVolPro * 1 / 9;
    End

    Else If intModDil = 4 Then
    Begin
      Result := fltVolPro * 7 / 30;
    End

    Else If intModDil = 5 Then
    Begin
      If Pos(strCatalisador, '_D803_D841_') > 0 Then
      Begin
        Result := fltVolPro * 1 / 6;
      End
      Else If Pos(strCatalisador, '_D861_D802_D863_') > 0 Then
      Begin
        Result := fltVolPro * 1 / 4;
      End;
    End

    Else If intModDil = 6 Then
    Begin
      Result := fltVolPro * 7 / 24;
    End

    Else If intModDil = 7 Then
    Begin
      Result := fltVolPro * 0.153893;
    End;
  End;
end;


{ TfrmFormulacaoAutomotivaPpg }

procedure TfrmFormulacaoAutomotivaPpg.pRecalculaFormula(
  blnPadrao: Boolean);
  Var
    intCont : Integer;
    objBase: TBaseAutomotiva;
    strTipBas: String;
    fltFator: Double;

    strCodIte: String;
    strCodBasRet: String;
    strDesBas: String;

    function fDescricaoBase(strCodBas: String): String;
    begin
      Result := strCodBas;

      If (Not fEmptyStr(strIdePro)) Then
      Begin
        pRetItemEDescricaoColorante(strIdePro, strCodBas, strCodIte, strCodBasRet, strDesBas, VS_strCodEmp);

        If (Not fEmptyStr(strDesBas)) Then
        Begin
          Result := Result + '-' + strDesBas;
        End;
      End;
    end;
begin
  strIdePro := 'PPG';

  objFormula.fltVolumeOri := 1000;

  If objFormula.fltVolumeOri > 0 Then
    fltFator := objFormula.fltVolumePro / objFormula.fltVolumeOri
  Else
    fltFator := 1;

  If objFormula.fltVolumeOri > 1 Then
    fltFator := fltFator * 1000;

  lsvFormulacao.Clear;

  For intCont := 0 To objFormula.Count - 1 Do
  Begin
    objBase := TBaseAutomotiva(objFormula.Items[intCont]);

    If objBase.strTipBas = 'B' Then
      strTipBas := 'BASE'
    Else If objBase.strTipBas = 'C' Then
      strTipBas := 'CATALISADOR'
    Else If objBase.strTipBas = 'T' Then
      strTipBas := 'TEXTURIZANTE'
    Else If objBase.strTipBas = 'F' Then
      strTipBas := 'FLEXIBILIZADOR'
    Else If objBase.strTipBas = 'TB' Then
      strTipBas := 'BASE MATEANTE'
    Else
      strTipBas := 'DILUENTE';

    With lsvFormulacao.Items.Add Do
    Begin
      Caption := fDescricaoBase(objBase.strCodBas);
      SubItems.Add(strTipBas);

      If (blnPadrao) Then
      Begin
        If Pos('PERSONALIZ', strSistema) <= 0 Then
        Begin
          SubItems.Add(FloatToStrF(fArredondaPPG(objBase.fltQtdCon), ffFixed, 12, 2));
          SubItems.Add(FloatToStrF(fArredondaPPG(objBase.fltQtdDil), ffFixed, 12, 2));
          SubItems.Add(FloatToStrF(fArredondaPPG(objBase.fltQtdDi2), ffFixed, 12, 2));
        End
        Else
        Begin
          SubItems.Add(FloatToStrF(objBase.fltQtdCon, ffFixed, 12, 2));
          SubItems.Add(FloatToStrF(objBase.fltQtdDil, ffFixed, 12, 2));
          SubItems.Add(FloatToStrF(objBase.fltQtdDi2, ffFixed, 12, 2));
        End;
      End
      Else
      Begin
        If Pos('PERSONALIZ', strSistema) <= 0 Then
        Begin
          SubItems.Add(FloatToStrF(fArredondaPPG(objBase.fltQtdCon * fltFator), ffFixed, 12, 2));
          SubItems.Add(FloatToStrF(fArredondaPPG(objBase.fltQtdDil * fltFator), ffFixed, 12, 2));
          SubItems.Add(FloatToStrF(fArredondaPPG(objBase.fltQtdDi2 * fltFator), ffFixed, 12, 2));
        End
        Else
        Begin
          SubItems.Add(FloatToStrF(objBase.fltQtdCon * fltFator, ffFixed, 12, 2));
          SubItems.Add(FloatToStrF(objBase.fltQtdDil * fltFator, ffFixed, 12, 2));
          SubItems.Add(FloatToStrF(objBase.fltQtdDi2 * fltFator, ffFixed, 12, 2));
        End;
      End;

      SubItems.Add(FloatToStrF(objBase.fltPreVen, ffFixed, 12, 2));
      SubItems.Add(FloatToStrF(objBase.fltEmbala, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(objBase.fltPesEsp, ffFixed, 12, 3));
    End;
  End;

  memCalculo.Lines.Clear;
  memCalculo.Lines.Assign(objFormula.stlCalculo);

  objFormula.fltVolumeOri := 1;    
end;

function fArredondaPPG(fltValor: Double): Double;
  Var
    strAux: String;
begin
  strAux := Format('%.2f', [fltValor]);
  strAux := Copy(strAux, 1, Length(strAux) - 1);
  Result := fStrToFloat(strAux);
end;

function fRetEmbalagemBD(strTipCor: String): String;
Var
  conf: IConfTinta;
  confEmb: IConfEmb;
begin
  conf := fGetConfTinta('PPG');
  confEmb := fGetConfEmb('PPG');

  If Pos('DELTRON', strTipCor) > 0 Then
    Result := conf.fGet('PPGLADT') //fArqIniTinta(0, 'PPG', 'PPGLADT', '')
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := conf.fGet('PPGLADF') //fArqIniTinta(0, 'PPG', 'PPGLADF', '')
  Else If Pos('DULON', strTipCor) > 0 Then
    Result := conf.fGet('PPGLADU') //fArqIniTinta(0, 'PPG', 'PPGLADU', '')
  Else If Pos(strTipCor, 'OMNI') > 0 Then
    Result := conf.fGet('PPGLAOM'); //fArqIniTinta(0, 'PPG', 'PPGLADT', '')

//AQUI CONFIGURACOES (PM)
  If (conf.fGet('NOVFOR') = 'S') Then
  Begin
    Result := '';
    //Forma nova de carregar com troca de embalagem
    If Pos('2K', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLA2K')
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLAAC')
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLADF')
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLADT')
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLADU')
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLAEB')
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLAIN')
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLASG')
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMLAZY');
  End;
end;

function fRetEmbalagemTB(strTipCor: String): String;
Var
  conf: IConfTinta;
  confEmb: IConfEmb;
begin
  conf := fGetConfTinta('PPG');
  confEmb := fGetConfEmb('PPG');
  
  If Pos('DELTRON', strTipCor) > 0 Then
    Result := conf.fGet('PPGTDT')
  Else If Pos('DELFLEET', strTipCor) > 0 Then
    Result := conf.fGet('PPGTDF')
  Else If Pos('DULON', strTipCor) > 0 Then
    Result := conf.fGet('PPGTDU')
  Else If Pos('OMNI', strTipCor) > 0 Then
    Result := conf.fGet('PPGTOM');

//AQUI CONFIGURACOES (PM)
  If (conf.fGet('NOVFOR') = 'S') Then
  Begin
    Result := '';
    //Forma nova de carregar sem trocar embalagens
    If Pos('2K', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMT2K')
    Else If Pos('ACS', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMTAC')
    Else If Pos('DELFLEET', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMTDF')
    Else If Pos('DELTRON', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMTDT')
    Else If Pos('DULON', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMTDU')
    Else If Pos('ENVIROBASE', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMTEB')
    Else If Pos('INDUSTRAN', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMTIN')
    Else If Pos('SPECTRAL GREY', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMTSG')
    Else If Pos('ZYNAMIX', strTipCor) > 0 Then
      Result := confEmb.fGet('PPGPMTZY');
  End;
end;

procedure pBasesPorEmpresas(var cdsCadBas: TUniClientDataSet; qryGen: TUniQuery);
begin
  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If cdsCadBas.Locate('BAS_CODBAS', qryGen.FieldByName('BAS_CODBAS').AsString, []) Then
    Begin
      cdsCadBas.Edit;
      cdsCadBas.FieldByName('BAS_CODITE').AsString := qryGen.FieldByName('BAS_CODITE').AsString;
      cdsCadBas.Post;
    End;

    qryGen.Next;
  End;
  cdsCadBas.First;
end;

function fSelectBasesSemAmarracao: String;
begin
  Result := '';
  Result := Result + '    SELECT ';
  Result := Result + '        BAS_CODBAS ';
  Result := Result + '      , BAS_CODITE ';
  Result := Result + '      , BAS_EMBALA ';
  Result := Result + '      , BAS_PESESP ';
  Result := Result + '      , BAS_BASEPO ';

  Result := Result + '      , 0 AS ITE_CNV_ML  ';

  Result := Result + '      , 0 AS ITE_PREULT  ';
  Result := Result + '      , 0 AS ITE_IMPULT  ';

  Result := Result + '      , 0 AS ITE_PRECOM  ';
  Result := Result + '      , 0 AS ITE_DESF01  ';
  Result := Result + '      , 0 AS ITE_DESF02  ';
  Result := Result + '      , 0 AS ITE_DESF03  ';
  Result := Result + '      , 0 AS ITE_DESF04  ';
  Result := Result + '      , 0 AS ITE_DESF05  ';
  Result := Result + '      , 0 AS ITE_DESF06  ';

  Result := Result + '      , 0 AS ITE_ICMSAI  ';
  Result := Result + '      , 0 AS ITE_IMPFED  ';
  Result := Result + '      , 0 AS ITE_DESOPE  ';
  Result := Result + '      , 0 AS ITE_OUTVAL  ';
  Result := Result + '      , 0 AS ITE_PREMED  ';
  Result := Result + '      , 0 AS ITE_PRECUS  ';
  Result := Result + '      , 0 AS ITE_PREVEN  ';
  Result := Result + '      ,"N" AS ITE_IMPDIR ';

  Result := Result + '    FROM         ';
  Result := Result + '      PPG_CADBAS ';
  Result := Result + '    WHERE (BAS_CODITE IS NULL OR ';
  Result := Result + '           BAS_CODITE = "")      ';
end;

function fRetornaAcrescimoMaoObra(strIteTin: String): Double;
var
  strSQL: String;
  qryGen: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT PPG_ACRMOB  ';
  strSQL := strSQL + ' FROM PPG_CADPPG  ';
  strSQL := strSQL + ' WHERE CONCAT( ';
  strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),   ';
  strSQL := strSQL + '    IFNULL(PPG_QTDB10, "")) = :ITETIN;  ';

  Try
    qryGen := fCriaQuery;

    qryGen.Close;
    qryGen.SQL.Text := strSql;
    qryGen.ParamByName('ITETIN').AsString := strIteTin;
    qryGen.Open;

    If qryGen.IsEmpty Then
    begin
      strSql := '';
      strSQL := strSQL + ' SELECT PPG_ACRMOB  ';
      strSQL := strSQL + ' FROM PPG_CADPPG  ';
      strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
      strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),   ';
      strSQL := strSQL + '    IFNULL(PPG_QTDB10, ""))) AS CHAR) = :ITETIN;  ';

      qryGen.Close;
      qryGen.SQL.Text := strSql;
      qryGen.ParamByName('ITETIN').AsString := strIteTin;
      qryGen.Open;

      if (qryGen.IsEmpty) then
      begin
        strSql := '';
        strSQL := strSQL + ' SELECT PPG_ACRMOB  ';
        strSQL := strSQL + ' FROM PPG_CADPPG  ';
        strSQL := strSQL + ' WHERE CAST(MD5(CONCAT( ';
        strSQL := strSQL + '    IFNULL(PPG_DESCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_VEICUL, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_MONTAD, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_TIPO__, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_A_N_O_, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODCOR, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODATC, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB01, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB01, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB02, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB02, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB03, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB03, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB04, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB04, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB05, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB05, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB06, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB06, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB07, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB07, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB08, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB08, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB09, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB09, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB10, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB10, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB11, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB11, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB12, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB12, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB13, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB13, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB14, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB14, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB15, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB15, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB16, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB16, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB17, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB17, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB18, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB18, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB19, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB19, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_CODB20, ""),   ';
        strSQL := strSQL + '    IFNULL(PPG_QTDB20, ""))) AS CHAR) = :ITETIN; ';

        qryGen.Close;
        qryGen.SQL.Text := strSql;
        qryGen.ParamByName('ITETIN').AsString := strIteTin;
        qryGen.Open;

      end;
    end;

    Result := qryGen.FieldByName('PPG_ACRMOB').AsFloat;
  Finally
    FreeAndNil(qryGen);
  End;
end;

{ TfrmConsultaCompPpg }

procedure TfrmConsultaCompPpg.pTarefaFormulacao(Sender: TObject);
var
  qryTinta: TUniQuery;
  stlDesEmb: TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  stlProEmbBd: TStringList;
  stlProEmbTb: TStringList;
  strIteEmb: String;
  strTipEmb: String;
  strTipPre: String;
  intQtdEmb: Integer;
  fltPreEmb: Double;
  fltEmbala: Double;
  fltPreCus: Double;
  fltVolPro: Double;
  fltPreVen: Double;
  dicRetorno: TDicionario;
  strTipCor,
  strDesCor: String;
begin
  dicRetorno := nil;
  qryTinta := nil;
  stlDesEmb := nil;
  stlProEmbLt := nil;
  stlProEmbGl := nil;
  stlProEmbBd := nil;
  stlProEmbTb := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      dicRetorno := TDicionario.Create;

      qryTinta := fCriaQuery(Self);
      qryTinta.SQL.Add('SELECT * FROM PPG_CADPPG WHERE AUTOINCREM = :AUTINC');
      qryTinta.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      qryTinta.Open;

      stlDesEmb   := TStringList.Create;
      stlProEmbLt := TStringList.Create;
      stlProEmbGl := TStringList.Create;
      stlProEmbBd := TStringList.Create;
      stlProEmbTb := TStringList.Create;

      // strTipCor := fRetTipoCor(qryTinta);
      strTipCor        := qryTinta.FieldByName('PPG_TIPO__').AsString;
      stlDesEmb.Text   := strTipCor;
      stlProEmbLt.Text := fRetEmbalagemLT(strTipCor);
      stlProEmbGl.Text := fRetEmbalagemGL(strTipCor);
      stlProEmbBd.Text := fRetEmbalagemBD(strTipCor);
      stlProEmbTb.Text := fRetEmbalagemTB(strTipCor);

      dicRetorno['idepro'] := 'PPG';
      dicRetorno['volpro'] := 1;

      fDigDadosTintometricos(qryTinta, stlDesEmb, stlProEmbLt, stlProEmbGl, stlProEmbBd, stlProEmbTb,
        strIteEmb, strTipEmb, strTabPre, strTipPre, intQtdEmb, fltPreEmb, fltEmbala, fltPreCus, fltPreVen,
        fltVolPro, dicRetorno, strDesCor);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(dicRetorno) then FreeAndNil(dicRetorno);
    if Assigned(qryTinta) then FreeAndNil(qryTinta);
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbBd) then FreeAndNil(stlProEmbBd);
    if Assigned(stlProEmbTb) then FreeAndNil(stlProEmbTb);
  End;
end;

procedure TfrmConsultaCompPpg.pTarefaPrecos(Sender: TObject);
begin
  pTarefaFormulacao(Sender);
end;

procedure TfrmConsultaCompPpg.pTarefaVenda(Sender: TObject);
begin
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadPpgNovasFormulas', False);
end;

end.
