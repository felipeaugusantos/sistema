{*********************************************************************************************}
{* Classes responsável pela interação entre a tela onde o usuario faz as modificações de uma *}
{* tinta (escolhe a quantidade e o tipo de embalagem) e o recalculo de preço da tinta        *}
{******************************************************************************************AC*}
unit untDigDadosTintometricosAutomotiva;

interface

uses
{$IFNDEF LINUX}
  Controls,
{$ENDIF}
  untIDataSet, untBaseAutomotiva, untIDicionario,System.Classes, untModoVenda,
  untAbstractFormulaAutomotiva, untAbstractDigDadosTintometricos,
  untVariantUtils, untStrUtils, SysUtils, untISaldosColorantes,
  untAbstractDigTintaAutomotiva, untTipoEmbalagem, untICalculadorFatVendasLibTintas, untAbstractTintaSQLServer, StrUtils;

type
  TDigDadosTintometricosAutomotiva = class(TAbstractDigDadosTintometricos)
  private
    function GetUnidadeItemEmbalagem(const strIteEmb: String): string;
    procedure pPreparaFormulacaoQuantidadeEspecifica(const dtsCadTin: IDataSet;
      dicRetorno: IDicionario);

  protected
    formula: TAbstractFormulaAutomotiva;
    formulaQtdEsp: TAbstractFormulaAutomotiva;
  public
    function fDigDadosTintometricos(const dtsCadTin: IDataSet; dicRetorno: IDicionario; blnSemTela: Boolean = False;
      strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean; override;
  public
    constructor Create(const formula, formulaQtdEsp: TAbstractFormulaAutomotiva);
    function GetSaldos: ISaldosColorantes; override;
    function GetChaForEspecifico(const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String; override;
  end;

implementation

uses
  untAutcomTintaFactory, untLibTintaFactory;

{ TDigDadosTintometricosAutomotiva }

constructor TDigDadosTintometricosAutomotiva.Create(const formula, formulaQtdEsp: TAbstractFormulaAutomotiva);
begin
  inherited Create();
  self.formula := formula;
  self.formulaQtdEsp := formulaQtdEsp;
end;

function TDigDadosTintometricosAutomotiva.fDigDadosTintometricos(const dtsCadTin: IDataSet; dicRetorno: IDicionario; blnSemTela: Boolean = False;
      strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;
Var
  intIndEmb            : Integer;
  intForm              : Integer;
  intCont              : Integer;
  calculadorFatVendas  : ICalculadorFatVendasLibTintas;
  stlBaseDilue         : TStringList;
  stlDiluentes         : TStringList;
  stlCatalizador       : TStringList;
  ControllerAutomotiva : TAbstractDigTintaAutomotivaController;
  dtsTinTmp            : IDataSet;

  function fEhBaseDiluente(Base: TBaseAutomotiva): Boolean;
  begin
    Result := ((Base.TipoBase = 'B') Or (Base.TipoBase = 'D')) And ((Base.QuantidadeConcentrado <= 0)  And (Base.QuantidadeDiluido > 0));
  end;

begin
  Result := False;
  {$IFDEF LINUX}
  ControllerAutomotiva := Nil;
  {$ELSE}
  frmAbstractDigTintaAutomotiva := nil;
  {$ENDIF}

  stlBaseDilue := TStringList.Create;
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendasLibTintas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      formula.calculadorFatVendas := calculadorFatVendas;


      dtsTinTmp := dtsCadTin;
      formula.Descricao := formula.GetDescricao(dtsCadTin);
      formula.CodFormul := formula.GetCodFormul(dtsCadTin);
      formula.OpcDoc    := TVariantUtils.IfNull(dicRetorno['opcdoc'], '');
      formula.CodCli    := TVariantUtils.IfNull(dicRetorno['codcli'], '');
      formula.PrzMed    := TVariantUtils.IfNull(dicRetorno['przmed'], '0');
      formula.CodCnd    := TVariantUtils.IfNull(dicRetorno['codcnd'], '');
      formula.ProPre    := TVariantUtils.IfNull(dicRetorno['propre'], False);
      formula.PreencheVolumeVenda(dtsCadTin);
      formula.pPreencherPesCorFor(dtsCadTin);
      formula.pPreencherBaixaQtdDig(dtsCadTin);
      formula.PreencheAcrescimoMaoObra(dtsCadTin);
      intIndEmb := formula.GetIndEmb(dtsCadTin);

      {$IFDEF LINUX}
        Formula.DilLinux := strCodDil;
      {$ENDIF}

      If formula.fPossuiConexaoSQLServer Then
      Begin
        If formula.fModoIntegracaoSistema And
          (Pos('ESP', dtsCadTin.FieldByName(formula.GetIdePro + '_CODPRO').AsString) <= 0) Then
        Begin
          Formula.pConectarSQLServer(dtsCadTin.FieldByName(formula.GetIdePro + '_CODSEQ').AsString,
            formula.GetLinhaFormulacao(dtsCadTin));
        End;
      End;

      formula.Clear;
      Formula.PreencheQuantidadeFormulacaoVenda(dtsCadTin);
      formula.OprFlj := TVariantUtils.IfNull(dicRetorno['oprflj'], '');
      formula.EmpresaProducao := TVariantUtils.IfNull(dicRetorno['empprd'], '');
      Formula.EmpCd_ := TVariantUtils.IfNull(dicRetorno['emp_cd'], '');
      Formula.CD_S_N := TVariantUtils.IfNull(dicRetorno['Cd_S_N'], '');
      Formula.EmpFat := TVariantUtils.IfNull(dicRetorno['empfat'], '');
      Formula.FatS_N := TVariantUtils.IfNull(dicRetorno['FatS_N'], '');
      Formula.EmpEst := TVariantUtils.IfNull(dicRetorno['codemp'], TAutcomTintaFactory.Get.GetCodEmp);
      Formula.PerfomanceAgent := False;
      Formula.PorPer := 0;
      Formula.UsaChapinha := Formula.GetUsaChapinha(dtsCadTin);
      Formula.ProCha := Formula.GetProdutoChapinha;
      formula.CarregarBases(dicRetorno);
      formula.CarregarBasesPorEmpresa(dicRetorno);

      If Not formula.AcertoValor Then
        Formula.FatorAcerto := 1.0
      Else
        Formula.FatorAcerto := 0.0;

      formula.CarregaPrecosBases;
      formula.CarregaPrecosBasesPorEmpresa;


      //É utilizada somente para as tintas onde a quantidade mostrada é diferente da quantidade da formulacao
      pPreparaFormulacaoQuantidadeEspecifica(dtsCadTin, dicRetorno);

      stlDiluentes := formula.fGetDiluentes(dtsCadTin);
      stlCatalizador := Formula.fGetCatalizador(dtsCadTin);


      ControllerAutomotiva := TAbstractDigTintaAutomotivaController.Create(Formula);
      ControllerAutomotiva.Formula := Formula;
      ControllerAutomotiva.FormulaQtdEsp := FormulaQtdEsp;
      ControllerAutomotiva.dtsCadTin := dtsTinTmp;


      If Assigned(stlDiluentes) Then
        ControllerAutomotiva.Formula.ListaAdicional.Assign(stlDiluentes);

      If Assigned(stlCatalizador) Then
        ControllerAutomotiva.formula.ListaCatalizador.Assign(stlCatalizador);


      Formula.pPreencheProdutoEmbagemVenda(dtsCadTin);

      ControllerAutomotiva.EmbPro := strEmbPro;
      ControllerAutomotiva.ModVen := strModoVenda;
    {$IFDEF LINUX}
      ControllerAutomotiva.Formula.ModVen := strModoVenda;
    {$ENDIF}
      ControllerAutomotiva.stlDesEmb   := Formula.DesEmb;
      ControllerAutomotiva.stlProEmbLt := Formula.ProEmbLt;
      ControllerAutomotiva.stlProEmbGl := Formula.ProEmbGl;
      ControllerAutomotiva.stlProEmbLa := Formula.ProEmbLa;
      ControllerAutomotiva.strProEmbCo := Formula.sProEmbCo;
      ControllerAutomotiva.strProEmbSp := Formula.sProEmbSp;
      ControllerAutomotiva.strProEmbSs := Formula.sProEmbSs;
      ControllerAutomotiva.strProEmbPo := Formula.sProEmbPo;
      ControllerAutomotiva.strProEmbSd := Formula.sProEmbSd;
      ControllerAutomotiva.strProEmbBa := Formula.sProEmbBa;
      ControllerAutomotiva.strProEmbTb := Formula.sProEmbTb;
      ControllerAutomotiva.blnMosDil2         := Formula.fMostrarDil2;
      ControllerAutomotiva.blnConsLinhaDesBas := Formula.fConsiderarLinhaDesBas;
      ControllerAutomotiva.fltMixVolMiC := formula.GetVolumePermitido(dtsCadTin, 'C');
      ControllerAutomotiva.fltMixVolMiD := formula.GetVolumePermitido(dtsCadTin, 'D');
      ControllerAutomotiva.fltVolumePadraoSpray  := TAutcomTintaFactory.Get.IIF(formula.GetVolumePadraSpray  > 0, formula.GetVolumePadraSpray , ControllerAutomotiva.fltVolumePadraoSpray);
      ControllerAutomotiva.fltVolumePadraoTambor := TAutcomTintaFactory.Get.IIF(formula.GetVolumePadraTambor(dtsCadTin) > 0, formula.GetVolumePadraTambor(dtsCadTin), ControllerAutomotiva.fltVolumePadraoTambor);
      ControllerAutomotiva.fltVolumePadraoCopo   := TAutcomTintaFactory.Get.IIF(formula.GetVolumePadraCopo   > 0, formula.GetVolumePadraCopo  , ControllerAutomotiva.fltVolumePadraoCopo);
      ControllerAutomotiva.fltVolumePadraoSpraySint := TAutcomTintaFactory.Get.IIF(formula.GetVolumePadraoSpraySint  > 0, formula.GetVolumePadraoSpraySint, ControllerAutomotiva.fltVolumePadraoSpraySint);
      ControllerAutomotiva.fltVolumePadraoSprayDuco := TAutcomTintaFactory.Get.IIF(formula.GetVolumePadraoSprayDuco  > 0, formula.GetVolumePadraoSprayDuco, ControllerAutomotiva.fltVolumePadraoSprayDuco);
      ControllerAutomotiva.fltVolumePadraoSprayPoli := TAutcomTintaFactory.Get.IIF(formula.GetVolumePadraoSprayPoli  > 0, formula.GetVolumePadraoSprayPoli, ControllerAutomotiva.fltVolumePadraoSprayPoli);
      ControllerAutomotiva.fltVolumeMaximoLitro := formula.GetVolumeMaximoLitro(dtsCadTin);
      ControllerAutomotiva.fltVolumeMaximoGalao := formula.GetVolumeMaximoGalao(dtsCadTin);
      ControllerAutomotiva.fltVolumeMaximoLata  := formula.GetVolumeMaximoLata(dtsCadTin);
      ControllerAutomotiva.fltVolumeMaximoBalde := formula.GetVolumeMaximoBalde(dtsCadTin);
      ControllerAutomotiva.fltVolumeMaximoTambor := formula.GetVolumeMaximoTambor(dtsCadTin);
      ControllerAutomotiva.fltVolumeMaximoCopo  := formula.GetVolumeMaximoCopo(dtsCadTin);
      ControllerAutomotiva.fltVolumeMaximoSpray := formula.GetVolumeMaximoSpray(dtsCadTin);
      ControllerAutomotiva.fltVolumeMaximoSpraySint := formula.GetVolumeMaximoSpraySint(dtsCadTin);
      ControllerAutomotiva.fltVolumeMaximoSprayPoli := formula.GetVolumeMaximoSprayPoli(dtsCadTin);
      ControllerAutomotiva.fltVolumeMaximoSprayDuco := formula.GetVolumeMaximoSprayDuco(dtsCadTin);
      ControllerAutomotiva.intIndEmb := intIndEmb;
      ControllerAutomotiva.strQualid := formula.GetQualidade(dtsCadTin);


      If formula.fPossuiConexaoSQLServer Then
      Begin
        If formula.fModoIntegracaoSistema Then
        Begin
          ControllerAutomotiva.strLinha := formula.GetLinhaFormulacao(dtsCadTin);
          formula.GetLinhaFormula;

          If Pos('ESP', dtsCadTin.FieldByName(Formula.GetIdePro + '_CODPRO').AsString) > 0 Then
            ControllerAutomotiva.chkResina325.Visible := False;
        End;
      End;

      {$IFDEF LINUX}
        ControllerAutomotiva.pOnShow(nil);
        ControllerAutomotiva.pCalculaPrecos();
        Result := ControllerAutomotiva.fConfirmar();
      {$ELSE}
        frmAbstractDigTintaAutomotiva := TfrmAbstractDigTintaAutomotiva.Create(nil);
        Try
          frmAbstractDigTintaAutomotiva.Caption := frmAbstractDigTintaAutomotiva.Caption + TLibTintaFactory.GetLibTinta.GetNomeTinta;
          frmAbstractDigTintaAutomotiva.SetController(ControllerAutomotiva);
          If blnSemTela Then
          Begin
            ControllerAutomotiva.pOnShow(frmAbstractDigTintaAutomotiva);
            frmAbstractDigTintaAutomotiva.btnConfirma.Click;
            Result := (frmAbstractDigTintaAutomotiva.ShowModal = mrOk)
               And Formula.fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmAbstractDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0, 'C', 'D'), dtsCadTin);
          End
          Else
            Result := (frmAbstractDigTintaAutomotiva.ShowModal = mrOk)
              And Formula.fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmAbstractDigTintaAutomotiva.rdgModoVenda.ItemIndex = 0, 'C', 'D'), dtsCadTin);

        Except
          On E: Exception Do
            Raise;
        End;
      {$ENDIF}

      formula.ProPre := False;

      If Result Then
      begin
        If (Formula.blnTemDiluido And Formula.blnTemConcentrado) And (Assigned(dicRetorno)) Then
        Begin
          If (Formula.mveModoVenda = mvConcentrado) Then
          Begin
            //SE ESCOLHEU CONCENTRADO ENTÃO REMOVE BASES DILUENTES
            For intForm := 0 To Formula.Count-1 Do
              If (fEhBaseDiluente(TBaseAutomotiva(Formula.Items[intForm]))) Then
                stlBaseDilue.Add(TBaseAutomotiva(Formula.Items[intForm]).CodigoBase);

            If (stlBaseDilue.Count > 0) Then
            Begin
              For intCont := 0 To stlBaseDilue.Count-1 Do
              Begin
                For intForm := 0 To Formula.Count-1 Do
                Begin
                  If (TBaseAutomotiva(Formula.Items[intForm]).CodigoBase = stlBaseDilue[intCont]) Then
                  Begin
                    Formula.Items[intForm].Destroy;
                    Break;
                  End;
                End
              End;
              Formula.Promoc := 'N';
            End;
          End;
        End;

        strDescricaoCor        := ControllerAutomotiva.strDesCor;
        strItemEmbalagem       := ControllerAutomotiva.formula.CodEmb;
      {$IFNDEF LINUX}
        strTipoPreco           := TAutcomTintaFactory.Get.IIF(ControllerAutomotiva.rdgModoVenda.ItemIndex = 0, 'C', 'D');
      {$ELSE}
        strTipoPreco           := TAutcomTintaFactory.Get.IIF(ControllerAutomotiva.ModVen = 'C', 'C', 'D');
      {$ENDIF}
        intQuantidadeEmbalagem := StrToIntDef(ControllerAutomotiva.edtQtdEmb.Text, 0);
        intTipoFormulacao      := ControllerAutomotiva.rdgTipoFormula.ItemIndex;
        fltPrecoEmbalagem      := ControllerAutomotiva.Formula.EmbPrecoVenda;
        strItemChapinha        := ControllerAutomotiva.Formula.ProCha;
        strUsaChapinha         := TAutcomTintaFactory.Get.IIF(ControllerAutomotiva.Formula.UsaChapinha, 'S', 'N');

        //Base com a quantidade zerada liberada por senha (a principio para Axalta)
        strBaseQtdZerada       := ControllerAutomotiva.Formula.BaseQtdZerada;

        if (ControllerAutomotiva.Formula.tpeTipEmb in [teLitro]) then
        begin
          strTipoEmbalagem       := 'LT';
          fltEmbalagem           := 0.900;
        end

        else
        if (ControllerAutomotiva.Formula.tpeTipEmb in [teBalde]) then
        begin
          strTipoEmbalagem       := 'BD';
          fltEmbalagem           := formula.GetVolumePadraoBalde(dtsCadTin);
        end

        else
        if (ControllerAutomotiva.Formula.tpeTipEmb in [teTambor]) then
        begin
          strTipoEmbalagem       := 'TB';
          fltEmbalagem           := 200.000;
        end

        else
        if (ControllerAutomotiva.Formula.tpeTipEmb in [teLata]) then
        begin
          strTipoEmbalagem       := 'LA';
          fltEmbalagem           := formula.GetVolumePadraoLata(dtsCadTin);
        end
        else
        if (ControllerAutomotiva.Formula.tpeTipEmb in [teCopo]) then
        begin
          strTipoEmbalagem       := 'CP';
          fltEmbalagem           := 0.500;
        end
        else
        if (ControllerAutomotiva.Formula.tpeTipEmb in [teSpray]) then
        begin
          strTipoEmbalagem       := 'SP';
          fltEmbalagem           := 0.400;
        end
        else
        begin
          strTipoEmbalagem       := 'GL';
          fltEmbalagem           := formula.GetVolumePadraGalao(dtsCadTin);
        end;


        strChaveIteTin     := formula.GetChaveIteTin(dtsCadTin);
        strCodigoItem      := formula.GetProdutoVendaTinta(dtsCadTin);
        strUnidade         := GetUnidadeItemEmbalagem(strItemEmbalagem);
        strMontadora       := formula.GetMontadora(dtsCadTin);
        strA_n_o_          := formula.GetAno(dtsCadTin);
        strChaFor          := formula.GetChaFor(dtsCadTin);
        strTipoTinta       := 'A';
        strUniversal       := formula.GetUniversal(dtsCadTin);
        strLinha           := formula.GetLinha(dtsCadTin);

        If Formula.UsaChapinha Then
        Begin
          dicRetorno['custin'] :=  ControllerAutomotiva.Formula.ChaPrecoCusto;
          dicRetorno['curtin'] :=  ControllerAutomotiva.Formula.ChaPrecoCustoReal;
          dicRetorno['premed'] :=  ControllerAutomotiva.Formula.ChaPrecoMedio;
          dicRetorno['impult'] :=  ControllerAutomotiva.Formula.ChaPrecoUltimaCompraImpostos;
          dicRetorno['preult'] :=  ControllerAutomotiva.Formula.ChaPrecoUltimaCompra;
          dicRetorno['prctin'] :=  ControllerAutomotiva.Formula.ChaPrecoCompraLiquido;
        End
        Else
        Begin
          dicRetorno['custin'] := 0;
          dicRetorno['curtin'] := 0;
          dicRetorno['premed'] := 0;
          dicRetorno['impult'] := 0;
          dicRetorno['preult'] := 0;
          dicRetorno['prctin'] := 0;
        End;

      {$IFDEF LINUX}
        If (ControllerAutomotiva.ModVen = 'D') Then
        Begin
          fltPrecoCustoTinta     := TVariantUtils.IfNull(dicRetorno['custin'], 0) + ControllerAutomotiva.Formula.PrecoCustoDil + ControllerAutomotiva.Formula.EmbPrecoCusto;
          fltPrecoCustoRealTinta := TVariantUtils.IfNull(dicRetorno['curtin'], 0) + ControllerAutomotiva.Formula.PrecoCustoRealDil + ControllerAutomotiva.Formula.EmbPrecoCustoReal;
          fltPrecoVendaTinta     := ControllerAutomotiva.Formula.PrecoVendaDil;
          dicRetorno['premed']   := TVariantUtils.IfNull(dicRetorno['premed'], 0) + ControllerAutomotiva.Formula.PrecoMedioDil + ControllerAutomotiva.Formula.EmbPrecoMedio;
          dicRetorno['impult']   := TVariantUtils.IfNull(dicRetorno['impult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraImpostosDil + ControllerAutomotiva.Formula.EmbPrecoUltimaCompraImpostos;
          dicRetorno['preult']   := TVariantUtils.IfNull(dicRetorno['preult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraDil + ControllerAutomotiva.Formula.EmbPrecoUltimaCompra;
          dicRetorno['prctin']   := TVariantUtils.IfNull(dicRetorno['prctin'], 0) + ControllerAutomotiva.Formula.PrecoCompraLiquidoDil + ControllerAutomotiva.Formula.EmbPrecoCompraLiquido;
        End 
        Else If (ControllerAutomotiva.ModVen = 'C') Then
        Begin
          fltPrecoCustoTinta     := TVariantUtils.IfNull(dicRetorno['custin'], 0) + ControllerAutomotiva.Formula.PrecoCustoCon + ControllerAutomotiva.Formula.EmbPrecoCusto;
          fltPrecoCustoRealTinta := TVariantUtils.IfNull(dicRetorno['curtin'], 0) + ControllerAutomotiva.Formula.PrecoCustoRealCon + ControllerAutomotiva.Formula.EmbPrecoCustoReal;
          fltPrecoVendaTinta     := ControllerAutomotiva.Formula.PrecoVendaCon;
          dicRetorno['premed']   := TVariantUtils.IfNull(dicRetorno['premed'], 0) + ControllerAutomotiva.Formula.PrecoMedioCon + ControllerAutomotiva.Formula.EmbPrecoMedio;
          dicRetorno['impult']   := TVariantUtils.IfNull(dicRetorno['impult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraImpostosCon + ControllerAutomotiva.Formula.EmbPrecoUltimaCompraImpostos;
          dicRetorno['preult']   := TVariantUtils.IfNull(dicRetorno['preult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraCon + ControllerAutomotiva.Formula.EmbPrecoUltimaCompra;
          dicRetorno['prctin']   := TVariantUtils.IfNull(dicRetorno['prctin'], 0) + ControllerAutomotiva.Formula.PrecoCompraLiquidoCon + ControllerAutomotiva.Formula.EmbPrecoCompraLiquido;
        End;
      {$ELSE}
        If (ControllerAutomotiva.rdgModoVenda.ItemIndex = 0) Then
        Begin
          If ControllerAutomotiva.Formula.AcertoValor Then
          Begin
            fltPrecoCustoTinta     := TVariantUtils.IfNull(dicRetorno['custin'], 0) + ControllerAutomotiva.Formula.PrecoCustoCon + ControllerAutomotiva.Formula.EmbPrecoCusto + ControllerAutomotiva.Formula.FatorAcerto;
            fltPrecoCustoRealTinta := TVariantUtils.IfNull(dicRetorno['curtin'], 0) + ControllerAutomotiva.Formula.PrecoCustoRealCon + ControllerAutomotiva.Formula.EmbPrecoCustoReal + ControllerAutomotiva.Formula.FatorAcerto;
            fltPrecoVendaTinta     := ControllerAutomotiva.Formula.PrecoVendaCon;
            dicRetorno['premed']   := TVariantUtils.IfNull(dicRetorno['premed'], 0) + ControllerAutomotiva.Formula.PrecoMedioCon + ControllerAutomotiva.Formula.EmbPrecoMedio + ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['impult']   := TVariantUtils.IfNull(dicRetorno['impult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraImpostosCon + ControllerAutomotiva.Formula.EmbPrecoUltimaCompraImpostos + ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['preult']   := TVariantUtils.IfNull(dicRetorno['preult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraCon + ControllerAutomotiva.Formula.EmbPrecoUltimaCompra + ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['prctin']   := TVariantUtils.IfNull(dicRetorno['prctin'], 0) + ControllerAutomotiva.Formula.PrecoCompraLiquidoCon + ControllerAutomotiva.Formula.EmbPrecoCompraLiquido + ControllerAutomotiva.Formula.FatorAcerto;
          End
          Else
          Begin
            fltPrecoCustoTinta     := (TVariantUtils.IfNull(dicRetorno['custin'], 0) + ControllerAutomotiva.Formula.PrecoCustoCon + ControllerAutomotiva.Formula.EmbPrecoCusto) * ControllerAutomotiva.Formula.FatorAcerto;
            fltPrecoCustoRealTinta := (TVariantUtils.IfNull(dicRetorno['curtin'], 0) + ControllerAutomotiva.Formula.PrecoCustoRealCon  + ControllerAutomotiva.Formula.EmbPrecoCustoReal) * ControllerAutomotiva.Formula.FatorAcerto;
            fltPrecoVendaTinta     := ControllerAutomotiva.Formula.PrecoVendaCon;
            dicRetorno['premed']   := (TVariantUtils.IfNull(dicRetorno['premed'], 0) + ControllerAutomotiva.Formula.PrecoMedioCon + ControllerAutomotiva.Formula.EmbPrecoMedio) * ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['impult']   := (TVariantUtils.IfNull(dicRetorno['impult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraImpostosCon + ControllerAutomotiva.Formula.EmbPrecoUltimaCompraImpostos) * ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['preult']   := (TVariantUtils.IfNull(dicRetorno['preult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraCon + ControllerAutomotiva.Formula.EmbPrecoUltimaCompra) * ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['prctin']   := (TVariantUtils.IfNull(dicRetorno['prctin'], 0) + ControllerAutomotiva.Formula.PrecoCompraLiquidoCon + ControllerAutomotiva.Formula.EmbPrecoCompraLiquido) * ControllerAutomotiva.Formula.FatorAcerto;
          End;
        End
        Else
        Begin
          If ControllerAutomotiva.Formula.AcertoValor Then
          Begin
            fltPrecoCustoTinta     := TVariantUtils.IfNull(dicRetorno['custin'], 0) + ControllerAutomotiva.Formula.PrecoCustoDil + ControllerAutomotiva.Formula.EmbPrecoCusto + ControllerAutomotiva.Formula.FatorAcerto;
            fltPrecoCustoRealTinta := TVariantUtils.IfNull(dicRetorno['curtin'], 0) + ControllerAutomotiva.Formula.PrecoCustoRealDil + ControllerAutomotiva.Formula.EmbPrecoCustoReal + ControllerAutomotiva.Formula.FatorAcerto;
            fltPrecoVendaTinta     := ControllerAutomotiva.Formula.PrecoVendaDil;
            dicRetorno['premed']   := TVariantUtils.IfNull(dicRetorno['premed'], 0) + ControllerAutomotiva.Formula.PrecoMedioDil + ControllerAutomotiva.Formula.EmbPrecoMedio + ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['impult']   := TVariantUtils.IfNull(dicRetorno['impult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraImpostosDil + ControllerAutomotiva.Formula.EmbPrecoUltimaCompraImpostos + ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['preult']   := TVariantUtils.IfNull(dicRetorno['preult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraDil + ControllerAutomotiva.Formula.EmbPrecoUltimaCompra + ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['prctin']   := TVariantUtils.IfNull(dicRetorno['prctin'], 0) + ControllerAutomotiva.Formula.PrecoCompraLiquidoDil + ControllerAutomotiva.Formula.EmbPrecoCompraLiquido + ControllerAutomotiva.Formula.FatorAcerto;
          End
          Else
          Begin
            fltPrecoCustoTinta     := (TVariantUtils.IfNull(dicRetorno['custin'], 0) + ControllerAutomotiva.Formula.PrecoCustoDil + ControllerAutomotiva.Formula.EmbPrecoCusto) * ControllerAutomotiva.Formula.FatorAcerto;
            fltPrecoCustoRealTinta := (TVariantUtils.IfNull(dicRetorno['curtin'], 0) + ControllerAutomotiva.Formula.PrecoCustoRealDil + ControllerAutomotiva.Formula.EmbPrecoCustoReal) * ControllerAutomotiva.Formula.FatorAcerto;
            fltPrecoVendaTinta     := ControllerAutomotiva.Formula.PrecoVendaDil;
            dicRetorno['premed']   := (TVariantUtils.IfNull(dicRetorno['premed'], 0) + ControllerAutomotiva.Formula.PrecoMedioDil + ControllerAutomotiva.Formula.EmbPrecoMedio) * ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['impult']   := (TVariantUtils.IfNull(dicRetorno['impult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraImpostosDil + ControllerAutomotiva.Formula.EmbPrecoUltimaCompraImpostos) * ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['preult']   := (TVariantUtils.IfNull(dicRetorno['preult'], 0) + ControllerAutomotiva.Formula.UltimoPrecoCompraDil + ControllerAutomotiva.Formula.EmbPrecoUltimaCompra) * ControllerAutomotiva.Formula.FatorAcerto;
            dicRetorno['prctin']   := (TVariantUtils.IfNull(dicRetorno['prctin'], 0) + ControllerAutomotiva.Formula.PrecoCompraLiquidoDil + ControllerAutomotiva.Formula.EmbPrecoCompraLiquido) * ControllerAutomotiva.Formula.FatorAcerto;
          End;
        End;
      {$ENDIF}

        If fltPrecoVendaTinta > 0 Then
        Begin
          If TAutcomTintaFactory.Get.fGetConfTinta(Formula.GetIdePro).fGet('ACRMOB') = '1' Then
            fltPrecoVendaTinta := (fltPrecoVendaTinta + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
          Else
            fltPrecoVendaTinta     := fltPrecoVendaTinta + Formula.EmbPrecoVenda + Formula.AcrMob;

          If Formula.UsaChapinha Then
            fltPrecoVendaTinta := fltPrecoVendaTinta + Formula.ChaPrecoVenda;

          dicRetorno['preco_venda_original'] := fltPrecoVendaTinta;

          If ControllerAutomotiva.Formula.AcertoValor Then
            fltPrecoVendaTinta := fltPrecoVendaTinta + ControllerAutomotiva.Formula.FatorAcerto
          Else
            fltPrecoVendaTinta := fltPrecoVendaTinta * ControllerAutomotiva.Formula.FatorAcerto;
        End;
        

        fltVolumeProduto := ControllerAutomotiva.Formula.VolumePro;

        If Not Formula.fPreencheCatalisadorNovo Then
        {$IFNDEF LINUX}
          strCatalisador := formula.fRetornaCatalisadorVenda(ControllerAutomotiva.chkComCat.Checked, strTipoPreco,
            TAutcomTintaFactory.Get.IIF(Pos(Formula.GetIdePro, 'DU2_ROB_PFA_ALA_') > 0, ControllerAutomotiva.cmbListaCatalizador.Text,
              ControllerAutomotiva.cmbListaAdicional.Text))
        {$ELSE}
          strCatalisador := ''
        {$ENDIF}
        Else
          strCatalisador := Formula.fRetornaCatalisadorNovo(dtsCadTin);

        dicRetorno['precus']      := fltPrecoCustoTinta;
        dicRetorno['precu2']      := fltPrecoCustoRealTinta;
        dicRetorno['tippre']      := strTipoPreco;
        dicRetorno['desopetinta'] := formula.GetAcrescimoDespesaOperacionalTinta;
        dicRetorno['promoc']      := ControllerAutomotiva.formula.Promoc;
        dicRetorno['qtdemb']      := intQuantidadeEmbalagem;
        dicRetorno['camada']      := TVariantUtils.IfNull(Formula.fGetCamada(dtsCadTin), '');

        If Formula.fPossuiConexaoSQLServer Then
        Begin
          If formula.fModoIntegracaoSistema Then
          Begin
            If (ControllerAutomotiva.chkResina325.Checked) Or (ControllerAutomotiva.ModVen = 'R') Then
              dicRetorno['coddil'] := 'R'
            Else If (ControllerAutomotiva.rdgModoVenda.ItemIndex = 1) Or (ControllerAutomotiva.ModVen = 'D') Then
              dicRetorno['coddil'] := 'D'
            Else
              dicRetorno['coddil'] := 'C';
          End;
        End
        Else
        Begin
          If strTipoPreco = 'C' Then
          Begin
            dicRetorno['coddil'] := '';
            dicRetorno['catali'] := '';
          End
          Else
          Begin
          {$IFNDEF LINUX}
            dicRetorno['coddil'] := Formula.fRetornaDiluente(ControllerAutomotiva.cmbListaAdicional.Text);
          {$ELSE}
            If stlDiluentes <> Nil Then
              dicRetorno['coddil'] := Formula.fRetornaDiluente(TAutcomTintaFactory.Get.IIF(Assigned(stlDiluentes),
                                                                 ControllerAutomotiva.cmbListaAdicional[formula.SetItemIndexLinuxDiluente(dtsCadTin, ControllerAutomotiva.cmbListaAdicional)],
                                                                 ControllerAutomotiva.cmbListaAdicional.Text))
            Else
              dicRetorno['coddil'] := '';
          {$ENDIF}
            dicRetorno['catali'] := ControllerAutomotiva.cmbListaCatalizador.Text;
          End;
        End;

        dicRetorno['pordil']      := Formula.PorDil;
        dicRetorno['porper']      := Formula.PorPer;
        dicRetorno['obscolorista']   := ControllerAutomotiva.edtDescricaoColorista.Text;
        dicRetorno['tipoformulacao'] := intTipoFormulacao;
      {$IFNDEF LINUX}
        dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(ControllerAutomotiva.rdgAcerto.ItemIndex = 0, 'N', 'S');
      {$ENDIF}
        formula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', Formula.tintaDeMaquina[Formula.mveModoVenda]);

        If (Result) And (Assigned(dicRetorno)) Then
        Begin
          formula.RecalcularTabelas(dicRetorno);
          If (stlBaseDilue.Count > 0) Then
            dicRetorno['promoc'] := Formula.Promoc;
        End;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  { TODO -oRG : Verificar IDataSet destruindo ao dar FreeAndNil no Controller em  Linux }
  {$IFNDEF LINUX}
    If Assigned(ControllerAutomotiva) Then
      FreeAndNil(ControllerAutomotiva);
  {$ENDIF}
  {$IFNDEF LINUX}
    If Assigned(frmAbstractDigTintaAutomotiva) Then
      FreeAndNil(frmAbstractDigTintaAutomotiva);
  {$ENDIF}
    If Assigned(stlBaseDilue) Then
      FreeAndNil(stlBaseDilue);

    If Assigned(stlDiluentes) Then
      FreeAndNil(stlDiluentes);

    if Assigned(stlCatalizador) Then
      FreeAndNil(stlCatalizador);
  End;
end;

function TDigDadosTintometricosAutomotiva.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := formula.GetChaForEspecifico(dicRetorno, dtsCadTin);
end;

function TDigDadosTintometricosAutomotiva.GetSaldos: ISaldosColorantes;
begin
  Result := formula.GetSaldos;
end;

function TDigDadosTintometricosAutomotiva.GetUnidadeItemEmbalagem(
  const strIteEmb: String): string;
 var
   qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT ITE_CODUNI ' +
                '  FROM CADITE     ' +
                ' WHERE ITE_CODITE = :CODITE ';
  qryGen.ParamByName('CODITE').AsString := strIteEmb;
  qryGen.Open;

  Result := qryGen.FieldByName('ITE_CODUNI').AsString;
end;

procedure TDigDadosTintometricosAutomotiva.pPreparaFormulacaoQuantidadeEspecifica(
  const dtsCadTin: IDataSet; dicRetorno: IDicionario);
begin
  If Assigned(formulaQtdEsp) Then
  Begin
    formulaQtdEsp.PreencheVolumeVenda(dtsCadTin);

    formulaQtdEsp.GetDescricao(dtsCadTin);

    formulaQtdEsp.pPreencherPesCorFor(dtsCadTin);
    formulaQtdEsp.pPreencherBaixaQtdDig(dtsCadTin);

    formulaQtdEsp.OpcDoc := TVariantUtils.IfNull(dicRetorno['opcdoc'], '');

    formulaQtdEsp.Clear;
    formulaQtdEsp.PreencheQuantidadeFormulacaoVendaEsp(dtsCadTin);

    formulaQtdEsp.CarregarBases(dicRetorno);
    formulaQtdEsp.CarregarBasesPorEmpresa(dicRetorno);
    formulaQtdEsp.pCarregarBasesSQLServerCasoNecessario;


    formulaQtdEsp.CarregaPrecosBases;
    formulaQtdEsp.CarregaPrecosBasesPorEmpresa;
  End;
end;

end.
