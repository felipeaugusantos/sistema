{*********************************************************************************************}
{* Classes responsável pela interação entre a tela onde o usuario faz as modificações de uma *}
{* tinta (troca de base / acrescentar descrição) e o recalculo de preço da tinta             *}
{******************************************************************************************PH*}
unit untDigDadosTintometricosImobiliaria;

interface

uses
  untIDataSet, untColorante, untIDicionario,
  untAbstractFormulaImobiliaria, untAbstractDigDadosTintometricos,
  untVariantUtils, untStrUtils, SysUtils, Controls, untISaldosColorantes;
                 
type
  TDigDadosTintometricosImobiliaria = class(TAbstractDigDadosTintometricos)
  protected
    formula: TAbstractFormulaImobiliaria;
  public
    function fDigDadosTintometricos(const dtsCadTin: IDataSet; const dicRetorno: IDicionario): Boolean; override;
  public
    constructor Create(const formula: TAbstractFormulaImobiliaria);
    function GetSaldos: ISaldosColorantes; override;
  end;

implementation

uses
  untAbstractDigTintaImobiliaria, untAutcomTintaFactory, untLibTintaFactory;

{ TDigDadosTintometricosImobiliaria }

constructor TDigDadosTintometricosImobiliaria.Create(const formula: TAbstractFormulaImobiliaria);
begin
  inherited Create();
  self.formula := formula;
end;

function TDigDadosTintometricosImobiliaria.fDigDadosTintometricos(const dtsCadTin: IDataSet; const dicRetorno: IDicionario): Boolean;
var
  colorante: TColorante;
  intCont: Integer;
begin
  Result := False;
  frmAbstractDigTintaImobiliaria := nil;
  Try
    Try
      formula.ItemBaseOriginal := formula.GetProdutoBaseFormula(dtsCadTin);
      formula.ItemBase := formula.ItemBaseOriginal;
      formula.Unidade := formula.GetUnidade(dtsCadTin);
      formula.Descricao := formula.GetDescricao(dtsCadTin);
      formula.OpcDoc := TVariantUtils.IfNull(dicRetorno['opcdoc'], '');

      formula.Clear;
      For intCont := 1 To formula.GetQuantidadeFormulacao Do
      Begin
        if not Assigned(dtsCadTin.FindField(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2))) then
          Break;

        if TStrUtils.fEmptyStr(dtsCadTin.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString) then
          Break;

        colorante := TColorante(formula.Add);
        colorante.CodigoColorante := dtsCadTin.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;
        colorante.Quantidade := dtsCadTin.FieldByName(formula.GetPrefixoQuantidade('') + TStrUtils.fStrZero(intCont, 2)).AsFloat;
      End;

      formula.CarregarColorantes;
      formula.CarregaPrecosColorantes;
      frmAbstractDigTintaImobiliaria := TfrmAbstractDigTintaImobiliaria.Create(nil);
      frmAbstractDigTintaImobiliaria.Caption := frmAbstractDigTintaImobiliaria.Caption + TLibTintaFactory.GetLibTinta.GetNomeTinta + ' - ' + formula.Descricao;
      frmAbstractDigTintaImobiliaria.formula := formula;
      Result := (frmAbstractDigTintaImobiliaria.ShowModal = mrOk);
      if Result then
      begin
        strChaveIteTin := formula.GetChaveIteTin(dtsCadTin);
        strCodigoItem := frmAbstractDigTintaImobiliaria.strNovBas;;
        strDescricaoCor := frmAbstractDigTintaImobiliaria.strDesCor;
        fltPrecoCustoTinta := frmAbstractDigTintaImobiliaria.fltPreCus;
        fltPrecoVendaTinta := frmAbstractDigTintaImobiliaria.fltPreVen;
        strUnidade := frmAbstractDigTintaImobiliaria.strUniBas;
        dicRetorno['precu2'] := formula.PrecoCustoReal;
        formula.RecalcularTabelas(dicRetorno);
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmAbstractDigTintaImobiliaria) then FreeAndNil(frmAbstractDigTintaImobiliaria);
  End;
end;


function TDigDadosTintometricosImobiliaria.GetSaldos: ISaldosColorantes;
begin
  Result := formula.GetSaldos;  
end;

end.
