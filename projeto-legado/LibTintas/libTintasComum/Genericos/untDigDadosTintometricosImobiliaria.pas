{*********************************************************************************************}
{* Classes responsável pela interação entre a tela onde o usuario faz as modificações de uma *}
{* tinta (troca de base / acrescentar descrição) e o recalculo de preço da tinta             *}
{******************************************************************************************PH*}
unit untDigDadosTintometricosImobiliaria;

interface

uses
{$IFDEF LINUX}

{$ELSE}
  Controls,
{$ENDIF}
  untIDataSet, untColorante, untIDicionario,
  untAbstractFormulaImobiliaria, untAbstractDigDadosTintometricos,
  untVariantUtils, untStrUtils, SysUtils, untISaldosColorantes,
  untICalculadorFatVendasLibTintas, System.StrUtils;

type
  TDigDadosTintometricosImobiliaria = class(TAbstractDigDadosTintometricos)
  protected
    formula: TAbstractFormulaImobiliaria;
  public
    function fDigDadosTintometricos(const dtsCadTin: IDataSet; dicRetorno: IDicionario; blnSemTela: Boolean = False;
      strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean; override;
  public
    constructor Create(const formula: TAbstractFormulaImobiliaria);
    function GetSaldos: ISaldosColorantes; override;
    function GetChaForEspecifico(const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String; override;

  end;

implementation

uses
  untAbstractDigTintaImobiliaria, untAbstractDigTintaIndustrial,
  untAutcomTintaFactory, untLibTintaFactory;

{ TDigDadosTintometricosImobiliaria }

constructor TDigDadosTintometricosImobiliaria.Create(const formula: TAbstractFormulaImobiliaria);
begin
  inherited Create();
  self.formula := formula;
end;

function TDigDadosTintometricosImobiliaria.fDigDadosTintometricos(const dtsCadTin: IDataSet; dicRetorno: IDicionario; blnSemTela: Boolean = False;
      strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;
var
  colorante: TColorante;
  intCont: Integer;
  calculadorFatVendas: ICalculadorFatVendasLibTintas;
  ControllerImobiliaria: TAbstractDigTintaImobiliariaController;
  ControllerIndustrial: TAbstractDigTintaIndustrialController;
  qryGen : IDataSet;
begin
 {$IFDEF LINUX}
  ControllerImobiliaria := nil;
  ControllerIndustrial := nil;
 {$ELSE}
  frmAbstractDigTintaImobiliaria := Nil;
  frmAbstractDigTintaIndustrial := Nil;
 {$ENDIF}
  Try
    if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendasLibTintas, calculadorFatVendas) then
      calculadorFatVendas := nil;

    formula.calculadorFatVendas := calculadorFatVendas;

    formula.OpcDoc := TVariantUtils.IfNull(dicRetorno['opcdoc'], '');
    formula.CodCli := TVariantUtils.IfNull(dicRetorno['codcli'], '');
    formula.PrzMed := TVariantUtils.IfNull(dicRetorno['przmed'], '0');
    formula.CodCnd := TVariantUtils.IfNull(dicRetorno['codcnd'], '');
    formula.ProPre := TVariantUtils.IfNull(dicRetorno['propre'], False);
    formula.EmpPrd := TVariantUtils.IfNull(dicRetorno['empprd'], '');
    formula.OprFlj := TVariantUtils.IfNull(dicRetorno['oprflj'], '');
    Formula.EmpCd_ := TVariantUtils.IfNull(dicRetorno['emp_cd'], '');
    Formula.Cd_S_N := TVariantUtils.IfNull(dicRetorno['Cd_S_N'], '');
    Formula.EmpFat := TVariantUtils.IfNull(dicRetorno['empfat'], '');
    Formula.FatS_N := TVariantUtils.IfNull(dicRetorno['FatS_N'], '');

    formula.ItemBaseOriginal := formula.GetProdutoBaseFormula(dtsCadTin);
    formula.ItemBase := formula.ItemBaseOriginal;
    formula.Unidade := formula.GetUnidade(dtsCadTin);
    formula.Descricao := formula.GetDescricao(dtsCadTin);
    formula.fltVolumeBaseOriginal := formula.GetVolumeBaseOriginal(dtsCadTin);
    formula.fltVolumeOriginal := formula.GetVolumeOriginal(dtsCadTin);
    formula.fltVolumeColorantesOriginal := formula.GetVolumeColoranteOriginal(dtsCadTin);
    formula.UsaCatalisador := formula.GetUsaCatalisador(dtsCadTin);
    Formula.PreencheAcrescimoMaoObra(dtsCadTin);

    formula.Clear;
    For intCont := 1 To formula.GetQuantidadeFormulacao Do
    Begin
      if not Assigned(dtsCadTin.FindField(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2))) then
        Break;

      if TStrUtils.fEmptyStr(dtsCadTin.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString) then
        Break;

      colorante := TColorante(formula.Add);
      colorante.CodigoColorante := dtsCadTin.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;
      colorante.Quantidade      := formula.GetQuantidadeDadosTintometricos(dtsCadTin, formula.GetPrefixoQuantidade(''), TStrUtils.fStrZero(intCont, 2));
      colorante.Tipo := tciColorante;

      If Not TStrUtils.fEmptyStr(formula.GetPrefixoPercentual) Then
        Colorante.Percentual := dtsCadTin.FieldByName(formula.GetPrefixoPercentual + TStrUtils.fStrZero(intCont, 2)).AsFloat;
    End;

    If formula.fUtilizaQuantidadeBase Then
    Begin
      Colorante := TColorante(formula.Add);
      Colorante.CodigoColorante := dtsCadTin.FieldByName(formula.GetPrefixoFormulacaoBase).AsString;
      Colorante.Quantidade := dtsCadTin.FieldByName(formula.GetPrefixoQuantidadeBase).AsFloat;
      Colorante.Tipo := tciBase;
      Colorante.Percentual := dtsCadTin.FieldByName(formula.GetPrefixoPercentualBase).AsFloat;
    End;

    If formula.UsaCatalisador Then
    Begin
      If Not TStrUtils.fEmptyStr(formula.GetPrefixoFormulacaoCatalisador) Then
      Begin
        If Not TStrUtils.fEmptyStr(dtsCadTin.FieldByName(formula.GetPrefixoFormulacaoCatalisador).AsString) Then
        Begin
          colorante := TColorante(formula.Add);
          colorante.CodigoColorante := dtsCadTin.FieldByName(formula.GetPrefixoFormulacaoCatalisador).AsString;
          colorante.Quantidade := dtsCadTin.FieldByName(formula.GetPrefixoQuantidadeCatalisador).AsFloat;
          colorante.Tipo := tciCatalisador;
        End;
      End;
    End;

    If formula.GetIdePro = 'ADT' Then
      formula.dtsCadTin := dtsCadTin;

    formula.CarregarColorantes;
    formula.CarregarBases;
    formula.CarregaPrecosColorantes;

    If (formula.PromocaoPrecoFixoSobreValorFinal = 'S') Then
    Begin
      formula.CalcularPrecos;
      formula.PrecoTotalColorantes := formula.GetCalculador.PrecoVenda;
      formula.CalculouColorante := 'S';
      formula.ItemBase := formula.ItemBaseOriginal;
      formula.CarregarColorantes;
      formula.CarregarBases;
      formula.CarregaPrecosColorantes;
    End;

    qryGen := formula.GetDataSetMensAlerta(dtsCadTin);

    If Assigned(qryGen) Then
    Begin
      qryGen.First;
      While not (qryGen.Eof) Do
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', qryGen.FieldByName('MSG_MENSAG').AsString , ['&Ok']);
        qryGen.Next;
      End
    End;

    If Formula.fUsaMensAlertaNovo(dtsCadTin) Then
      Formula.GetDataSetMensAlertaNovo(dtsCadTin);

    If formula.fMostrarFormulacaoIndustrial Then
    Begin
      ControllerIndustrial := TAbstractDigTintaIndustrialController.Create;
      ControllerIndustrial.formula := formula;
    End
    Else
    Begin
      ControllerImobiliaria := TAbstractDigTintaImobiliariaController.Create;
      ControllerImobiliaria.formula := formula;
    End;

    If formula.fMostrarFormulacaoIndustrial Then
    Begin
    {$IFDEF LINUX}
      ControllerIndustrial.pOnShow(nil);
      ControllerIndustrial.formula.ItemBase := ControllerIndustrial.edtNovBas.Text;
      ControllerIndustrial.pCalculaTotais;
      ControllerIndustrial.pSelecionarEmbalagem;
      Result := ControllerIndustrial.fConfirmar;
    {$ELSE}
      frmAbstractDigTintaIndustrial := TfrmAbstractDigTintaIndustrial.Create(Nil);
      Try
        frmAbstractDigTintaIndustrial.Caption := frmAbstractDigTintaIndustrial.Caption + TLibTintaFactory.GetLibTinta.GetNomeTinta;
        frmAbstractDigTintaIndustrial.SetController(ControllerIndustrial);
        If blnSemTela Then
        Begin
          ControllerIndustrial.pOnShow(frmAbstractDigTintaIndustrial);
          frmAbstractDigTintaIndustrial.btnConfirma.Click;
          Result := (frmAbstractDigTintaIndustrial.ModalResult = mrOk);
        End
        Else
          Result := (frmAbstractDigTintaIndustrial.ShowModal = mrOk);
      Finally
        FreeAndNil(frmAbstractDigTintaIndustrial);
      End;
    {$ENDIF}
    End
    Else
    Begin
    {$IFDEF LINUX}
      ControllerImobiliaria.pOnShow(nil);
      ControllerImobiliaria.formula.ItemBase := ControllerImobiliaria.edtNovBas.Text;
      ControllerImobiliaria.pCalculaTotais;
      Result := ControllerImobiliaria.fConfirmar;
    {$ELSE}
      frmAbstractDigTintaImobiliaria := TfrmAbstractDigTintaImobiliaria.Create(nil);
      Try
        frmAbstractDigTintaImobiliaria.Caption := frmAbstractDigTintaImobiliaria.Caption + TLibTintaFactory.GetLibTinta.GetNomeTinta; // + ' - ' + formula.Descricao;
        frmAbstractDigTintaImobiliaria.SetController(ControllerImobiliaria);
        If blnSemTela Then
        Begin
          ControllerImobiliaria.pOnShow(frmAbstractDigTintaImobiliaria);
          frmAbstractDigTintaImobiliaria.btnConfirma.Click;
          Result := (frmAbstractDigTintaImobiliaria.ModalResult = mrOk);
        End
        Else
          Result := (frmAbstractDigTintaImobiliaria.ShowModal = mrOk);
      Finally
        FreeAndNil(frmAbstractDigTintaImobiliaria);
      End;
    {$ENDIF}
    End;

    formula.ProPre := False;
    If formula.fMostrarFormulacaoIndustrial Then
    Begin
      If Result Then
      Begin
         strChaveIteTin := formula.GetChaveIteTin(dtsCadTin);
         strCodigoItem := ControllerIndustrial.strNovBas;
         strDescricaoCor := ControllerIndustrial.strDesCor;
         fltPrecoCustoTinta := formula.PrecoCustoIndustrial;

         If TAutcomTintaFactory.Get.fGetConfTinta(formula.GetIdePro).fGet('ACRMOB') = '1' Then
           fltPrecoVendaTinta := formula.PrecoVendaIndustrial * (1 + Formula.AcrMob / 100)
         Else
           fltPrecoVendaTinta := formula.PrecoVendaIndustrial + Formula.AcrMob;

         strUnidade := ControllerIndustrial.strUniBas;

         dicRetorno['codite'] := strCodigoItem;
         dicRetorno['tipcor'] := formula.CodigoEmbalagemBase;
         dicRetorno['catali'] := TAutcomTintaFactory.Get.IIF(ControllerIndustrial.blnUsaCatalisador, 'S', 'N');
         fltVolumeProduto := 0;

         If formula.Personalizada Then
         Begin
           fltVolumeProduto := formula.VolumeFinal;
           dicRetorno['iteemb'] := TAutcomTintaFactory.Get.fGetConfTinta('ADT').fGet('EMBGRA');
           dicRetorno['codite'] := TAutcomTintaFactory.Get.fGetConfTinta('ADT').fGet('PROGRA');
         End;

         dicRetorno['precu2'] := Formula.PrecoCustoRealIndustrial;
         dicRetorno['premed'] := Formula.PrecoMedioIndustrial;
         dicRetorno['preult'] := Formula.UltimoPrecoCompraIndustrial;
         dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosIndustrial;
         dicRetorno['prctin'] := Formula.PrecoCompraLiquidoIndustrial;
         dicRetorno['promoc'] := Formula.Promoc;

         dicRetorno['outval'] := Formula.OutrosValoresIndustrial;
         dicRetorno['icmsai'] := Formula.IcmsSaidaIndustrial;
         dicRetorno['impfed'] := Formula.ImpostosFederaisIndustrial;
         dicRetorno['desope'] := Formula.DespesasOperacionaisIndustrial;

         strCatalisador := TAutcomTintaFactory.Get.IIF(ControllerIndustrial.blnUsaCatalisador, 'S', 'N');

         strNovaEmbalagem := ControllerIndustrial.strNovaEmbalagem;

         dicRetorno['formul'] := Formula.GetSaldos;
         dicRetorno.AdicionarObjeto('tintaDeMaquina', formula.tintaDeMaquina);

         Formula.RecalcularTabelas(dicRetorno);
      End;
    End
    Else
    Begin
      if Result then
      begin
        strChaveIteTin := formula.GetChaveIteTin(dtsCadTin);
        strCodigoItem := ControllerImobiliaria.strNovBas;
        strDescricaoCor := ControllerImobiliaria.strDesCor;
        fltPrecoCustoTinta := ControllerImobiliaria.fltPreCus;

        If TAutcomTintaFactory.Get.fGetConfTinta(formula.GetIdePro).fGet('ACRMOB') = '1' Then
          fltPrecoVendaTinta := ControllerImobiliaria.fltPreVen * (1 + Formula.AcrMob / 100)
        Else
          fltPrecoVendaTinta := ControllerImobiliaria.fltPreVen + Formula.AcrMob;

        strUnidade := ControllerImobiliaria.strUniBas;

        dicRetorno['precu2'] := formula.PrecoCustoReal + formula.BasePrecoCustoReal;
        dicRetorno['premed'] := formula.PrecoMedio + formula.BasePrecoMedio;
        dicRetorno['preult'] := formula.UltimoPrecoCompra + formula.BasePrecoUltimaCompra;
        dicRetorno['impult'] := formula.UltimoPrecoCompraImpostos + formula.BasePrecoUltimaCompraImpostos;
        dicRetorno['prctin'] := formula.PrecoCompraLiquido + formula.BasePrecoCompraLiquido;

        dicRetorno['promoc'] := formula.Promoc;

        dicRetorno['outval'] := formula.OutrosValores + formula.BaseOutrosValores;
        dicRetorno['icmsai'] := formula.IcmsSaida + formula.BaseIcmsSaida;
        dicRetorno['impfed'] := formula.ImpostosFederais + formula.BaseImpostosFederais;
        dicRetorno['desope'] := formula.DespesasOperacionais + formula.BaseDespesasOperacionais;
        dicRetorno['somcol'] := formula.PrecoTotalColorantes;

        dicRetorno.AdicionarObjeto('tintaDeMaquina', formula.tintaDeMaquina);

        formula.RecalcularTabelas(dicRetorno);
      end;
    End;
  Finally
    if Assigned(ControllerImobiliaria) Then FreeAndNil(ControllerImobiliaria);
    if Assigned(ControllerIndustrial) Then FreeAndNil(ControllerIndustrial);
  End;
end;

function TDigDadosTintometricosImobiliaria.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := formula.GetChaForEspecifico(dicRetorno, dtsCadTin);
end;

function TDigDadosTintometricosImobiliaria.GetSaldos: ISaldosColorantes;
begin
  Result := formula.GetSaldos;
end;

end.
