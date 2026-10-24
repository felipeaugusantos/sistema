{************************************************************************}
{* Classe responsável pelas rotidas especificas de uma formula Salcomix *}
{*********************************************************************AC*}
unit untFormulaAutomotivaSalcomix;

interface

uses
  untAbstractFormulaAutomotiva, untICalculadorFormulaAutomotiva, untIDataSet, untBaseAutomotiva,
  SysUtils, untStrUtils, Controls, Classes, untIConfTinta, untFloatUtils, untModoVenda,
  untIDicionario, ComCtrls, System.StrUtils, Variants, untAbstractTintaSQLServer, untSalcomixFormulacaoSQLServer;


type
  TFormulaAutomotivaSalcomix = class(TAbstractFormulaAutomotiva)
  protected
    function GetCalculadorInterno(): ICalculadorFormulaAutomotiva; override;
    function GetTextoInformativoCalculo(): String; override;
    procedure CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva); override;
    function GetNomeCampoCustoBase: String; override;
    function GetNomeCampoVendaBase: String; override;
    function GetNomeTabelaBases: String; override;
    function GetNomeCampoBaseCodIte: String; override;
    function GetSelectBases: String; override;
  public
    function GetPrefixoQuantidade(const strModo: String): String; override;
    function GetPrefixoLitragem(const strModo: String): String; override;
    function GetQuantidadeFormulacao(): Integer; override;
    function GetCodNovaFormula(): String; override;
    function GetPrefixoFormulacao(): String; override;
    function GetDescricao(const dtsCadTin: IDataSet): String; override;
    function GetIdePro: String; override;
    function GetChaveIteTin(const dtsCadTin: IDataSet): string; override;
    procedure PreencheVolumeVenda(const dtsCadTin: IDataSet); override;
    procedure PreencheAcrescimoMaoObra(const dtsCadTin: IDataSet); override;
    function GetCodFormul(const dtsCadTin: IDataSet): string; override;
    function GetIndEmb(const dtsCadTin: IDataSet): integer; override;
    procedure PreencheQuantidadeFormulacaoVenda(const dtsCadTin: IDataSet); override;
    procedure pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet); override;
    function GetVolumePermitido(const dtsCadTin: IDataSet; strTipoPre: String):Double; override;
    function GetVolumePadraSpray: Double; override;
    function GetVolumePadraTambor(dtsCadTin: IDataSet): Double; override;
    function GetVolumePadraCopo : Double; override;

    function fValidaVolumeFormulucao(strTipoPre: String; const dtsCadTin: IDataSet): Boolean; override;

    function GetCalcOutrosValores(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoMedio(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcIcmsSaida(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcImpostosFederais(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcDespesasOperacionais(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoCusto(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoCustoReal(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcPrecoVenda(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;
    function GetCalcQuantidade(const base: TBaseAutomotiva; const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double; override;

    function GetProdutoVendaTinta(const dtsCadTin: IDataSet): string; override;
    function GetMontadora(const dtsCadTin: IDataSet): string; override;
    function GetAno(const dtsCadTin: IDataSet): string; override;
    function GetAcrescimoDespesaOperacionalTinta: Double; override;
    function GetDescricaoBase(strCodBas: String): String; override;
    function GetFatorEstoque: Double; override;
    procedure pDefineVolumeOriginal; override;
    function fMostrarComCatalisador: Boolean; override;

    procedure pPreencherPesCorFor(const dtsCadTin: IDataSet); override;

    function GetUniversal(const dtsCadTin: IDataSet): string; override;

    function GetChaForEspecifico(const dicRetorno: IDicionario;
      const dtsCadTin: IDataSet): String; override;

    procedure pRecalculaFormulaMostrarPadrao(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      blnConsLinhaDesBas: Boolean; strTipBas: String); override;

    procedure pRecalculaFormulaMostrarDigitado(var lsvFormulacao: TListView;
      Base: TBaseAutomotiva; intDecimaisPrecoVenda, intDecimaisPesoEspecifico: Integer;
      fltFator: Double; blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
      strTipBas: String); override;

    procedure CarregaPrecosBases; override;
    function fModoIntegracaoSistema(): Boolean; override;
    function fPossuiConexaoSQLServer(): Boolean; override;
    function NomeTinta():String; override;
    procedure GetLinhaFormula(); override;
    function fDefinirPadraoDiluido(): Boolean; override;
    procedure pCarregarBasesSQLServer; override;
    function GetLinhaFormulacao(const dtsCadTin: IDataSet): String; Override;
    function GetTintaSQLServer(strIdCor:String; strLInha:String): TAbstractTintaSQLServer; override;

    function GetVolumeMaximoLitro(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoBalde(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoCopo(dtsCadTin: IDataSet): Double; Override;
    function GetVolumeMaximoSpray(dtsCadTin: IDataSet): Double; Override;

    function fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer; dtsCadTin: IDataSet): Double; Override;
    function GetVolumePadraGalao(dtsCadTin: IDataSet): Double; Override;
    function GetVolumePadraoBalde(dtsCadTin: IDataSet): Double; Override;



  end;

implementation

uses
  untAbstractCalculadorFormulaAutomotiva, untAutcomTintaFactory;

{ TFormulaAutomotivaSalcomix }

procedure TFormulaAutomotivaSalcomix.CarregaPrecosBases;
Var
  intContador: Integer;
  Base: TBaseAutomotiva;
  fltPreCus: Double;
  fltPreVen: Double;
  fltDesOpeTinta: Double;
begin
  fltDesOpeTinta := TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGetDouble('DESOPE');

  Self.pPreencheListaAdicionalBases;

  For intContador := 0 To Self.Count - 1 Do
  Begin
    Base := TBaseAutomotiva(Self.Items[intContador]);
    If GetDataSetBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([Base.CodigoBase, Base.LinhaBase]), []) Then
    Begin
      Base.OutrosValores := GetDataSetBases.FieldByName('ITE_OUTVAL').AsFloat;
      Base.CodIte        := GetDataSetBases.FieldByName('BAS_CODITE').AsString;
      Base.ImpDir        := GetDataSetBases.FieldByName('ITE_IMPDIR').AsString;

      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And Assigned(calculadorFatVendas) Then
        Base.IcmsSaida   := calculadorFatVendas.fCalculaAliquota(Base.CodIte, Base.ImpDir)
      Else
        Base.IcmsSaida   := GetDataSetBases.FieldByName('ITE_ICMSAI').AsFloat;

      Base.ImpostosFederais               := GetDataSetBases.FieldByName('ITE_IMPFED').AsFloat;
      Base.DespesasOperacionais           := GetDataSetBases.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
      Base.PrecoMedio                     := GetDataSetBases.FieldByName('ITE_PREMED').AsFloat;
      Base.UltimoPrecoCompra              := GetDataSetBases.FieldByName('ITE_PREULT').AsFloat;
      Base.UltimoPrecoCompraImpostos      := GetDataSetBases.FieldByName('ITE_IMPULT').AsFloat;
      Base.PrecoCompraLiquido             := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
                                              GetDataSetBases.Fieldbyname('ITE_PRECOM').AsFloat, GetDataSetBases.Fieldbyname('ITE_DESF01').AsFloat,
                                              GetDataSetBases.Fieldbyname('ITE_DESF02').AsFloat, GetDataSetBases.Fieldbyname('ITE_DESF03').AsFloat,
                                              GetDataSetBases.Fieldbyname('ITE_DESF04').AsFloat, GetDataSetBases.Fieldbyname('ITE_DESF05').AsFloat,
                                              GetDataSetBases.Fieldbyname('ITE_DESF06').AsFloat), TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));
      Base.Embalagem                      := GetDataSetBases.FieldByName('BAS_EMBALA').AsFloat;
      Base.PesoEspecifico                 := GetDataSetBases.FieldByName('BAS_PESBAS').AsFloat;
      Base.PesGra                         := GetBasPesGra(GetDataSetBases);

      If TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetBases.FieldByName('BAS_CODITE').AsString,
        strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed, fltPreCus, fltPreVen) And (Not Self.blnProPre) Then
      Begin
        Base.PrecoCusto := fltPreCus;
        Base.PrecoVenda := fltPreVen;

        If strTabPre = strTabPreTin Then
            Self.Promoc := 'S';

        If Base.PrecoCusto = 0 Then
          Base.PrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        Base.PrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
        Base.PrecoVenda := GetDataSetBases.FieldByName('ITE_PREVEN').AsFloat;
      End;
      CarregaPrecosColorantesAdicional(GetDataSetBases, Base);
    End;
  End;

  RecBases := True;
  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;

end;

procedure TFormulaAutomotivaSalcomix.CarregaPrecosColorantesAdicional(const dataSetBases: IDataSet; const Base: TBaseAutomotiva);
Var
  dicDados: IDicionario;
begin
  Base.Cnv_Ml := dataSetBases.FieldByName('BAS_EMBALA').AsFloat;

  dicDados := TAutcomTintaFactory.Get.GetDicionario;
  dicDados['preven'] := Base.PrecoVenda;
  dicDados['precus'] := Base.PrecoCusto;
  dicDados['outval'] := Base.OutrosValores;
  dicDados['icmsai'] := Base.IcmsSaida;
  dicDados['impfed'] := Base.ImpostosFederais;
  dicDados['desope'] := Base.DespesasOperacionais;

  Base.PrecoCustoReal := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);

end;

function TFormulaAutomotivaSalcomix.fDefinirPadraoDiluido: Boolean;
begin
  Result := False;
    If Self.LinhaDil = 'S850' Then
      Result := True;
end;

function TFormulaAutomotivaSalcomix.fModoIntegracaoSistema: Boolean;
Var
  Conf: IConfTinta;
begin
  Conf := TAutcomTintaFactory.Get.fGetConfTinta('SAL');
  Result := Conf.fGet('CALFOR') = '1';
end;

function TFormulaAutomotivaSalcomix.fMostrarComCatalisador: Boolean;
begin
  Result := False;
end;

function TFormulaAutomotivaSalcomix.fPossuiConexaoSQLServer: Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaSalcomix.fValidaVolumeFormulucao(strTipoPre: String;
  const dtsCadTin: IDataSet): Boolean;
begin
  Result := True;
end;

function TFormulaAutomotivaSalcomix.fVolumePadraoLitro(fltVolumePadraoLitro: Double; intModoVenda: Integer;
  dtsCadTin: IDataSet): Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('VOLIEM'), 3);
end;

function TFormulaAutomotivaSalcomix.GetAcrescimoDespesaOperacionalTinta: Double;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('DESOPE');
end;

function TFormulaAutomotivaSalcomix.GetAno(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('SAL_ANOCOR').AsString;
end;

function TFormulaAutomotivaSalcomix.GetCalcDespesasOperacionais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltPreVenBas: Double;
  fltDesOpe: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltPreVenBas := Base.PrecoVenda / (Base.Embalagem * Base.PesoEspecifico) * fltQtdFor;
  fltDesOpe := fltPreVenBas * Base.DespesasOperacionais / 100;

  If (formula.fModoIntegracaoSistema) And (Pos('ESP', formula.Descricao) <= 0) Then
    Result := fltDesOpe
  Else
    Result := fltDesOpe * formula.VolumePro;
end;

function TFormulaAutomotivaSalcomix.GetCalcIcmsSaida(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltPreVenBas: Double;
  fltIcmSai:Double;
begin

  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltPreVenBas := Base.PrecoVenda / (Base.Embalagem * Base.PesoEspecifico) * fltQtdFor;
  fltIcmSai := fltPreVenBas * Base.IcmsSaida / 100;

  If (formula.fModoIntegracaoSistema) And (Pos('ESP', formula.Descricao) <= 0) Then
    Result := fltIcmSai
  Else
    Result := fltIcmSai * formula.VolumePro;
end;

function TFormulaAutomotivaSalcomix.GetCalcImpostosFederais(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltPreVenBas: Double;
  fltImpFederais: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltPreVenBas := Base.PrecoVenda / (Base.Embalagem * Base.PesoEspecifico) * fltQtdFor;
  fltImpFederais := fltPreVenBas * Base.ImpostosFederais / 100;

  If (formula.fModoIntegracaoSistema) And (Pos('ESP', formula.Descricao) <= 0) Then
    Result := fltImpFederais
  Else
    Result := fltImpFederais * formula.VolumePro;

end;

function TFormulaAutomotivaSalcomix.GetCalcOutrosValores(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltOutVal: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltOutVal := Base.OutrosValores / (Base.Embalagem * Base.PesoEspecifico) * fltQtdFor;

  If (formula.fModoIntegracaoSistema) And (Pos('ESP', formula.Descricao) <= 0) Then
    Result := fltOutVal
  Else
    Result := fltOutVal * formula.VolumePro;
end;

function TFormulaAutomotivaSalcomix.GetCalcPrecoCompraLiquido(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltComLiq: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltComLiq := Base.PrecoCompraLiquido / (Base.Embalagem * base.PesoEspecifico) * fltQtdFor;
  Result := fltComLiq;
end;

function TFormulaAutomotivaSalcomix.GetCalcPrecoCusto(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltPreCus: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltPreCus := base.PrecoCusto / (Base.Embalagem * Base.PesoEspecifico) * fltQtdFor;

  If (formula.fModoIntegracaoSistema) And (Pos('ESP', formula.Descricao) <= 0) Then
    Result := fltPreCus
  Else
    Result := fltPreCus * formula.VolumePro;
end;

function TFormulaAutomotivaSalcomix.GetCalcPrecoCustoReal(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltPreCusReal:Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltPreCusReal := Base.PrecoCustoReal / (Base.Embalagem * Base.PesoEspecifico) * fltQtdFor;

  If (formula.fModoIntegracaoSistema) And (Pos('ESP', formula.Descricao) <= 0) Then
    Result := fltPreCusReal
  Else
    Result := fltPreCusReal * formula.VolumePro;
end;

function TFormulaAutomotivaSalcomix.GetCalcPrecoMedio(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  Result    := Base.PrecoMedio / (Base.Embalagem * Base.PesoEspecifico) * fltQtdFor;
end;

function TFormulaAutomotivaSalcomix.GetCalcPrecoVenda(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
  fltPreVenBas: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
  fltPreVenBas := Base.PrecoVenda / (Base.Embalagem * Base.PesoEspecifico) * fltQtdFor;
  If (formula.fModoIntegracaoSistema) And (Pos('ESP', formula.Descricao) <= 0) Then
    Result := fltPreVenBas
  Else
    Result := fltPreVenBas * formula.VolumePro;
end;

function TFormulaAutomotivaSalcomix.GetCalcQuantidade(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
begin
  Result := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);
end;

function TFormulaAutomotivaSalcomix.GetCalculadorInterno: ICalculadorFormulaAutomotiva;
begin
  Result := TAbstractCalculadorFormulaAutomotiva.Create(Self);
end;

function TFormulaAutomotivaSalcomix.GetCalcUltimoPrecoCompra(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  Result := Base.UltimoPrecoCompra / (Base.Embalagem * Base.PesoEspecifico) * fltQtdFor;
end;

function TFormulaAutomotivaSalcomix.GetCalcUltimoPrecoCompraImpostos(const base: TBaseAutomotiva;
  const formula: TAbstractFormulaAutomotiva; const strTipo: String): Double;
var
  fltQtdFor: Double;
begin
  fltQtdFor := TAutcomTintaFactory.Get.IIF(strTipo = 'C', base.QuantidadeConcentrado, base.QuantidadeDiluido);

  Result := Base.UltimoPrecoCompraImpostos / (Base.Embalagem * Base.PesoEspecifico) * fltQtdFor;
end;

function TFormulaAutomotivaSalcomix.GetChaForEspecifico(
  const dicRetorno: IDicionario; const dtsCadTin: IDataSet): String;
begin
  Result := '';
end;


function TFormulaAutomotivaSalcomix.GetChaveIteTin(const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('SAL_MD5KEY').AsString;
end;

function TFormulaAutomotivaSalcomix.GetCodFormul(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaSalcomix.GetCodNovaFormula: String;
begin
  Result := 'SAL_CODPRO';
end;

function TFormulaAutomotivaSalcomix.GetDescricao(const dtsCadTin: IDataSet): String;
begin
  Result := dtsCadTin.FieldByName('SAL_DESCRI').AsString + ' - ' + dtsCadTin.FieldByName('SAL_CODPRO').AsString;
end;

function TFormulaAutomotivaSalcomix.GetDescricaoBase(strCodBas: String): String;
var
  qryGen: IDataSet;
begin
  qryGen := nil;
  Result := '';
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'SELECT BAS_DESBAS '+
                    '  FROM SAL_CADBAS '+
                    ' WHERE BAS_CODBAS = :CODBAS';
      qryGen.ParamByName('CODBAS').AsString := strCodBas;
      qryGen.Open;

      Result := qryGen.FieldByName('BAS_DESBAS').AsString;

      If Not TStrUtils.fEmptyStr(Result) Then
        Result := ' - ' + Result;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

function TFormulaAutomotivaSalcomix.GetFatorEstoque: Double;
begin
  Result := 1;
end;

function TFormulaAutomotivaSalcomix.GetIdePro: String;
begin
  Result := 'SAL';
end;

function TFormulaAutomotivaSalcomix.GetIndEmb(
  const dtsCadTin: IDataSet): integer;
begin
  Result := -1;
end;


procedure TFormulaAutomotivaSalcomix.GetLinhaFormula;
begin
  Self.LinhaDil := 'S850';
  Self.LinhaRes := 'S326';
end;

function TFormulaAutomotivaSalcomix.GetLinhaFormulacao(
  const dtsCadTin: IDataSet): String;
begin
  Result := LeftStr(dtsCadTin.FieldByName('SAL_LINHA_').AsString, 8);
end;

function TFormulaAutomotivaSalcomix.GetMontadora(
  const dtsCadTin: IDataSet): string;
begin
  Result := dtsCadTin.FieldByName('SAL_MONTAD').AsString;
end;

function TFormulaAutomotivaSalcomix.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TFormulaAutomotivaSalcomix.GetNomeCampoCustoBase: String;
begin
  Result := 'BAS_PRECUS';
end;

function TFormulaAutomotivaSalcomix.GetNomeCampoVendaBase: String;
begin
  Result := 'BAS_PREVEN';
end;

function TFormulaAutomotivaSalcomix.GetNomeTabelaBases: String;
begin
  Result := 'SAL_CADBAS';
end;

function TFormulaAutomotivaSalcomix.NomeTinta: String;
begin
  Result := 'Salcomix';
end;

function TFormulaAutomotivaSalcomix.GetPrefixoFormulacao: String;
begin
  Result := 'SAL_CODB';
end;

function TFormulaAutomotivaSalcomix.GetPrefixoLitragem(
  const strModo: String): String;
begin
    Result := '';
end;

function TFormulaAutomotivaSalcomix.GetPrefixoQuantidade(const strModo: String): String;
begin
  If strModo = 'C' Then
    Result := 'SAL_QTDB'
  Else
    Result := 'SAL_QTDD';
end;

function TFormulaAutomotivaSalcomix.GetProdutoVendaTinta(const dtsCadTin: IDataSet): string;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGet('SALPRO');
end;

function TFormulaAutomotivaSalcomix.GetQuantidadeFormulacao: Integer;
begin
  Result := 20;
end;

function TFormulaAutomotivaSalcomix.GetSelectBases: String;
begin
  Result := ' SELECT         ' +
            '     BAS_CODBAS ' +
            '   , BAS_CODITE ' +
            '   , BAS_EMBALA ' +
            '   , BAS_DESBAS ' +
            '   , BAS_PESBAS ' +
            '   , BAS_LINHA_ ' +
            '   , IFNULL(ITE_ITEATI, "N") ITE_ITEATI ' +
            '   , ITE_CNV_ML ' +
            '   , ITE_OUTVAL ' +
            '   , ITE_ICMSAI ' +
            '   , ITE_IMPFED ' +
            '   , ITE_DESOPE ' +
            '   , ITE_PREMED ' +
            '   , ITE_IMPULT ' +
            '   , ITE_PREULT ' +
            '   , ITE_PRECOM ' +
            '   , ITE_DESF01 ' +
            '   , ITE_DESF02 ' +
            '   , ITE_DESF03 ' +
            '   , ITE_DESF04 ' +
            '   , ITE_DESF05 ' +
            '   , ITE_DESF06 ';

  If TAutcomTintaFactory.Get.fCfgSis('IMPDIG') = '1' Then
    Result := Result  + '   , I.ITE_IMPDIR  '
  else
    Result := Result  + '   , G.ITE_IMPDIR  ';

end;

function TFormulaAutomotivaSalcomix.GetTextoInformativoCalculo: String;
begin
  Result :=
    'VolumeFormula  = ' + FloatToStrF(VolumeOri, ffFixed, 12, 4) + sLineBreak +
    'Valor da Base  = Preço(Embalagem * Peso Específico) * Qtde. Concentrado ' + sLineBreak +
    'Preço da Tinta = Soma(Valores de Base) * Volume Produzido * 1000 / VolumeFormula';
end;

function TFormulaAutomotivaSalcomix.GetTintaSQLServer(strIdCor,
  strLInha: String): TAbstractTintaSQLServer;
begin
  Result := TSalcomixFormulacaoSQLServer.Create(strIdCor, strLinha);
end;

function TFormulaAutomotivaSalcomix.GetUniversal(
  const dtsCadTin: IDataSet): string;
begin
  Result := '';
end;

function TFormulaAutomotivaSalcomix.GetVolumeMaximoBalde(
  dtsCadTin: IDataSet): Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('VOLIBA'), 3);
end;

function TFormulaAutomotivaSalcomix.GetVolumeMaximoCopo(
  dtsCadTin: IDataSet): Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('VOLICO'), 3)
end;

function TFormulaAutomotivaSalcomix.GetVolumeMaximoGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('VOLIGL'), 3);
end;

function TFormulaAutomotivaSalcomix.GetVolumeMaximoLitro(
  dtsCadTin: IDataSet): Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('VOLIEM'), 3);
end;

function TFormulaAutomotivaSalcomix.GetVolumeMaximoSpray(
  dtsCadTin: IDataSet): Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('VOLISP'), 3);
end;

function TFormulaAutomotivaSalcomix.GetVolumePadraCopo: Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('VOLICO'), 3);
end;

function TFormulaAutomotivaSalcomix.GetVolumePadraGalao(
  dtsCadTin: IDataSet): Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('VOLIGL'), 3);
end;

function TFormulaAutomotivaSalcomix.GetVolumePadraoBalde(
  dtsCadTin: IDataSet): Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('VOLIBA'), 3);
end;

function TFormulaAutomotivaSalcomix.GetVolumePadraSpray: Double;
begin
  Result := TAutcomTintaFactory.Get.fFormataFloat(TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetDouble('VOLISP'), 3);
end;

function TFormulaAutomotivaSalcomix.GetVolumePadraTambor(dtsCadTin: IDataSet): Double;
begin
  Result := 0;
end;

function TFormulaAutomotivaSalcomix.GetVolumePermitido(
  const dtsCadTin: IDataSet; strTipoPre: String): Double;
begin
  Result := 0;
end;


procedure TFormulaAutomotivaSalcomix.pCarregarBasesSQLServer;
Var
  tpsTipoPreparo: TTipoPreparoTinta;
  objFormula: TFormulaTintasSQLServer;
  objFormulaPadrao: TFormulaTintasSQLServer;
  intContador: Integer;
  Base: TBaseAutomotiva;
  Conf: IConfTinta;
  fltDesOpeTinta: Double;
  fltPreVen,
  fltPreCus: Double;
begin
  If Assigned(tintaSQLServer) Then
  Begin
    Conf := TAutcomTintaFactory.Get.fGetConfTinta('SAL');
    fltDesOpeTinta := Conf.fGetDouble('DESOPE');

    Self.VolumeOri := 1;

    If Resina325 Then
      tpsTipoPreparo := tpsResina325
    Else If Self.mveModoVenda = mvDiluido Then
      tpsTipoPreparo := tpsDiluido
    Else
      tpsTipoPreparo := tpsConcentrado;

    If Not blnErroIntegracao Then
      objFormula := tintaSQLServer.fCalculaFormulacao(TAutcomTintaFactory.Get.IIF(Self.VolumePro = 0, 0.9, Self.VolumePro), tpsTipoPreparo);

    If Not Assigned(objFormula) Then
    Begin
      blnErroIntegracao := True;
      Exit;
    End;

    objFormulaPadrao := tintaSQLServer.fCalculaFormulacao(Self.VolumeOri, tpsTipoPreparo);

    Clear;
    For intContador := 0 To objFormula.Count -1 Do
    Begin

      If Not GetDataSetBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([objFormula.Base[intContador].CodigoBase, objFormula.Base[intContador].LinhaBase]), []) Then
      Begin
        Raise Exception.Create('Base/Linha ' + objFormula.Base[intContador].CodigoBase + '/' + objFormula.Base[intContador].LinhaBase + ' não cadastrada. Favor verificar!');
      End;

      Base := TBaseAutomotiva(Self.Add);
      Base.CodigoBase := objFormula.Base[intContador].CodigoBase;
      Base.LinhaBase  := objFormula.Base[intContador].LinhaBase;
      Base.QuantidadeDiluido := objFormula.Base[intContador].QuantidadeDiluido;
      Base.QuantidadeConcentrado := objFormula.Base[intContador].QuantidadeConcentrado;

      Base.QuantidadePadraoCon := objFormulaPadrao.Base[intContador].QuantidadeConcentrado;
      Base.QuantidadePadraoDil := objFormulaPadrao.Base[intContador].QuantidadeDiluido;

      Base.Embalagem := GetDataSetBases.FieldByName('BAS_EMBALA').AsFloat;
      Base.PesoEspecifico := GetDataSetBases.FieldByName('BAS_PESBAS').AsFloat;

      If TAutcomTintaFactory.Get.fCarregaPromocao(GetDataSetBases.FieldByName('BAS_CODITE').AsString,
        strTabPre, Self.strCodCli, Self.strCodCnd, Self.intPrzMed, fltPreCus , fltPreVen) Then
      Begin
        Base.PrecoCusto := fltPreCus;
        Base.PrecoVenda := fltPreVen;
      End
      Else
      Begin
        Base.PrecoCusto := GetDataSetBases.FieldByName('ITE_PRECUS').AsFloat;
        Base.PrecoVenda := GetDataSetBases.FieldByName('ITE_PREVEN').AsFloat;
      End;

      Base.TipoBase := 'B';
      Base.ImpDir := GetDataSetBases.FieldByName('ITE_IMPDIR').AsString;
      Base.CodIte := GetDataSetBases.FieldByName('BAS_CODITE').AsString;
      Base.PrecoMedio := GetDataSetBases.FieldByName('ITE_PREMED').AsFloat;
      Base.OutrosValores := GetDataSetBases.FieldByName('ITE_OUTVAL').AsFloat;

      If TAutcomTintaFactory.Get.fCfgSis('IMPCF4', varBoolean) And Assigned(calculadorFatVendas) Then
        Base.IcmsSaida := calculadorFatVendas.fCalculaAliquota(Base.CodIte, Base.ImpDir)
      Else
        Base.IcmsSaida := GetDataSetBases.FieldByName('ITE_ICMSAI').AsFloat;

      Base.ImpostosFederais := GetDataSetBases.FieldByName('ITE_IMPFED').AsFloat;
      Base.DespesasOperacionais := GetDataSetBases.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTinta;
      Base.UltimoPrecoCompra := GetDataSetBases.FieldByName('ITE_PREULT').AsFloat;
      Base.UltimoPrecoCompraImpostos := GetDataSetBases.FieldByName('ITE_IMPULT').AsFloat;

      Base.PrecoCompraLiquido := TFloatUtils.fFormataFloat(TAutcomTintaFactory.Get.fCalculaPrecoCompraLiq(
        GetDataSetBases.FieldByName('ITE_PRECOM').AsFloat, GetDataSetBases.FieldByName('ITE_DESF01').AsFloat,
        GetDataSetBases.FieldByName('ITE_DESF02').AsFloat, GetDataSetBases.FieldByName('ITE_DESF03').AsFloat,
        GetDataSetBases.FieldByName('ITE_DESF04').AsFloat, GetDataSetBases.FieldByName('ITE_DESF05').AsFloat,
        GetDataSetBases.FieldByName('ITE_DESF06').AsFloat), TAutcomTintaFactory.Get.fCfgSis('DECUNI', VarInteger));
    End;

    FreeAndNil(objFormula);
    FreeAndNil(objFormulaPadrao);
  End;



end;

procedure TFormulaAutomotivaSalcomix.pDefineVolumeOriginal;
begin
  If Self.mveModoVenda = mvConcentrado then
    Self.VolumeOri := Self.VolumeConcentrado
  Else
    Self.VolumeOri := Self.VolumeDiluido;
end;

procedure TFormulaAutomotivaSalcomix.pPreencheProdutoEmbagemVenda(const dtsCadTin: IDataSet);
var
  conf: IConfTinta;
begin
  conf := TAutcomTintaFactory.Get.fGetConfTinta('SAL');

  stlDesEmb.Clear;
  DesEmb.Add('NORMAL');
  ProEmbLt.Add(Conf.fGet('SALIEM'));
  ProEmbGl.Add(Conf.fGet('SALIGL'));

  strProEmbCo := Conf.fGet('SALICO');
  strProEmbSp := Conf.fGet('SALISP');
  strProEmbBa := Conf.fGet('SALIBA');

end;

procedure TFormulaAutomotivaSalcomix.pPreencherPesCorFor(const dtsCadTin: IDataSet);
begin
  self.PesoCor := 0;
  self.PesoFor := 0;
end;

procedure TFormulaAutomotivaSalcomix.pRecalculaFormulaMostrarDigitado(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; fltFator: Double;
  blnConsLinhaDesBas: Boolean; intCont: Integer; strLinha: String;
  strTipBas: String);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    If (Base.QuantidadePadraoCon > 0) Or (Base.QuantidadePadraoDil > 0) Then
    Begin
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeConcentrado, 3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido, 3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido2, 3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End
    Else
    Begin
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeConcentrado * fltFator, 3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido * fltFator,3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido2,3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End;
  End;
end;

procedure TFormulaAutomotivaSalcomix.pRecalculaFormulaMostrarPadrao(
  var lsvFormulacao: TListView; Base: TBaseAutomotiva; intDecimaisPrecoVenda,
  intDecimaisPesoEspecifico: Integer; blnConsLinhaDesBas: Boolean;
  strTipBas: String);
begin
  With lsvFormulacao.Items.Add Do
  Begin
    Caption := Base.CodigoBase + Self.GetDescricaoBase(Base.CodigoBase);
    SubItems.Add(strTipBas);

    If (Base.QuantidadePadraoCon > 0) Or (Base.QuantidadePadraoDil > 0) Then
    Begin
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadePadraoCon, 3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadePadraoDil, 3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido2, 3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico))
    End
    Else
    Begin
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeConcentrado,3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido,3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(TFloatUtils.fFormataFloat(Base.QuantidadeDiluido2,3), ffFixed, 12, 3));
      SubItems.Add(FloatToStrF(Base.PrecoVenda, ffFixed, 12, intDecimaisPrecoVenda));
      SubItems.Add(FloatToStrF(Base.Embalagem, ffFixed, 12, 4));
      SubItems.Add(FloatToStrF(Base.PesoEspecifico, ffFixed, 12, intDecimaisPesoEspecifico));
    End;
  End;
end;


procedure TFormulaAutomotivaSalcomix.PreencheAcrescimoMaoObra(
  const dtsCadTin: IDataSet);
begin
  Self.AcrMob := dtsCadTin.FieldByName('SAL_ACRMOB').AsFloat;
end;

procedure TFormulaAutomotivaSalcomix.PreencheQuantidadeFormulacaoVenda(
  const dtsCadTin: IDataSet);
var
  intContador        : Integer;
  Base               : TBaseAutomotiva;
begin
  For intContador := 1 To Self.GetQuantidadeFormulacao Do
  Begin


    If TStrUtils.fEmptyStr(dtsCadTin.FieldByName('SAL_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
      Break;



    Base := TBaseAutomotiva(self.Add);
    Base.CodigoBase := dtsCadTin.FieldByName('SAL_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
    Base.LinhaBase  := LeftStr(dtsCadTin.FieldByName('SAL_LINHA_').AsString, 8);

    If Pos('ESP', dtsCadTin.FieldByName('SAL_CODPRO').AsString) > 0 Then
    Begin
      Base.QuantidadeDiluido := dtsCadTin.FieldByName('SAL_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      Base.QuantidadeConcentrado := dtsCadTin.FieldByName('SAL_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    End
    Else
    Begin
      If RightStr(dtsCadTin.FieldByName('SAL_LINHA_').AsString, 1) = 'D' Then
        Base.QuantidadeDiluido := dtsCadTin.FieldByName('SAL_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat
      Else
        Base.QuantidadeConcentrado := dtsCadTin.FieldByName('SAL_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
    End;

    Base.TipoBase := 'B';

  End;

end;

procedure TFormulaAutomotivaSalcomix.PreencheVolumeVenda(const dtsCadTin: IDataSet);
begin
  Self.VolumeOri         := 1000;
  Self.VolumePro         := 1;
  Self.VolumeConcentrado := 1000;
  Self.VolumeDiluido     := 1000;
end;

end.
