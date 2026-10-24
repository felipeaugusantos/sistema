{*********************************************************************************************}
{* Classe abstrata que representa a tinta Imobiliária ao todo, contendo todos os metodos que *}
{* serão acessados pelos outros modulos (Autcom/Auttin)                                      *}
{******************************************************************************************PH*}
unit untAbstractLibTintaImobiliaria;

interface

uses
  untAbstractLibTinta, untTipoTinta, untILibTinta, untIDataSet, SysUtils, untIDicionario,
  untAbstractFormulaImobiliaria, untITintadeMaquinaWrapper, untICalculadorPrecoTinta,
  untDigDadosTintometricosImobiliaria, untGTinForTipos, Classes, StrUtils,
  untIDigDadosTintometricos, untISaldosColorantes, untICalculadorFatVendasLibTintas;

type
  TAbstractLibTintaImobiliaria = class abstract (TAbstractLibTinta, ILibTinta)
  private
    strTabPreVen: String;
  protected
    function GetWhereRetComponente(const strCodEmp: String): String; override;
    procedure SetaParametrosRetComponentes(const dataSet: IDataSet; const strCodComp: String); override;
    function GetCampoComponenteCodIte(): String; override;
    function GetCampoComponenteCodComp(): String; override;
    function GetCampoComponenteDesComp(): String; override;
    function GetFormulaImobiliaria(const strTabPre: String): TAbstractFormulaImobiliaria; overload; virtual; abstract;
    function GetFormulaImobiliaria(): TAbstractFormulaImobiliaria; overload;
    function GetFatorEstoque(): Double; override;
    function GetSQLColorantesGTinFor(const strColorantes: string): string; virtual; abstract;
    function GetSQLBaseCataliGTinFor(const strColorantes: string; strCatalisador: String): String; virtual;
    function GetNomeCampoColoranteCodIte(): String; virtual;
    function GetNomeCampoColoranteCodCol(): string; virtual;
    function GetNomeCampoColoranteColDescri(): string; virtual;
    function fRetornaQuantidadeBaixaPigmentos(fltQtdBai: Double; const dataSet: IDataSet): Double; virtual;
    function fRetornaFormulacaoParaTabelaPreco(const dicRetorno: IDicionario; out qryGen: IDataSet): Boolean; virtual;

  public
    function fTipoTinta: TTipoTinta; override;
    function fTintaBaixaProduto(): Boolean; override;
    function fTintaBaixaEmbalagem(const strTipEmb: String; Var strCodIte: String): Boolean; override;
    function fUsaChapinhaTinta(strIdePro, strIteTin: String): Boolean; Override;
    function fRetornaCodigoChapinha(strIdePro: String): String; Override;
    function fTravaQuantidadeTinta(const strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean; override;
    function fFormulacaoAcumulada(): Boolean; override;
    procedure pTintaRetornaTabelaPreco(dicRetorno: IDicionario; fltFatorAcerto: Double); override;
    procedure pTintaRetornaTabPrecoImobiliaria(dicRetorno: IDicionario; fltFatorAcerto: Double); Virtual;
    function GetIdePro: String; override;
    function fRetornaTabelaColoranteTinta(): String; override;
    destructor Destroy; override;
    function RetornaPreco(const Sender: TObject; const dtsTinta: IDataSet; const dicRetorno: IDicionario;
      var saldos: ISaldosColorantes; blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil;
      strMD5Key: String = ''; blnSemTela: Boolean = False; strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean; override;
    function fGTinForGeral(var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray; const dicDados: IDicionario): Boolean; override;
    function fGTinForGer(var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray; const dicDados: IDicionario): Boolean; Virtual;
    function GetDigDadosTintometricos(strTabPre: string): IDigDadosTintometricos; override;
    function GetPrefixoTabela(): String; Virtual;
  end;

implementation

uses
  untColorante, untStrUtils, untVariantUtils, untFloatUtils, untAutcomTintaFactory, untAbstractCalculadorPrecoTinta,
  untMultiSelectLocalizadorFactory;

{ TAbstractLibTintaImobiliaria }

destructor TAbstractLibTintaImobiliaria.Destroy;
begin
  inherited Destroy;
end;

function TAbstractLibTintaImobiliaria.fFormulacaoAcumulada: Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaImobiliaria.fGTinForGer(
  var arrFormul: TForMulTinDetArray;
  var arrBaixaPigmentos: TBaixaPigmentosArray;
  const dicDados: IDicionario): Boolean;
var
  qryConsulta: IDataSet;
  intCont: Integer;
  formula: TAbstractFormulaImobiliaria;
  dicColorantes: IDicionario;
  strColorantes: string;
  qryColorantes: IDataSet;
  intPos: Integer;
  stlItensTraMl: TStringList;
begin
  Result := False;
  stlItensTraMl := nil;

  Try
    Try
      TMultiSelectLocalizadorFactory.GetLocalizador(dicDados['idepro']).Localizar(qryConsulta, ['ITETIN'], [TVariantUtils.IfNull(dicDados['itetin'], '')]);

      Result := Not qryConsulta.IsEmpty;

      If Not Result Then
        Exit;

      Formula := GetFormulaImobiliaria();
      dicColorantes := TAutcomTintaFactory.Get.GetDicionario;

      For intCont := 1 To formula.GetQuantidadeFormulacao Do
      Begin

        arrFormul[intCont].strFormul := qryConsulta.FieldByName(formula.GetPrefixoFormulacao + TStrUtils.fStrZero(intCont, 2)).AsString;
        arrFormul[intCont].fltQtdbas := formula.GetQuantidadeDadosTintometricos(qryConsulta, formula.GetPrefixoQuantidade(''), TStrUtils.fStrZero(intCont, 2)) * GetFatorEstoque;

        dicColorantes[arrFormul[intCont].strFormul] := arrFormul[intCont].fltQtdbas;

        strColorantes := strColorantes + QuotedStr(arrFormul[intCont].strFormul);
        If (Not TStrUtils.fEmptyStr(arrFormul[intCont].strFormul)) Then
        Begin
          strColorantes := strColorantes + ', ';
        End;
      End;

      strColorantes := Trim(strColorantes);
      If (RightStr(strColorantes, 1) = ',') Then
        strColorantes := Copy(strColorantes, 1, Length(strColorantes)-1);

      qryColorantes := TAutcomTintaFactory.Get.fGetDataSet;
      qryColorantes.Close;
      qryColorantes.SQL := GetSQLColorantesGTinFor(strColorantes);
      qryColorantes.Open;

      intPos := 0;
      stlItensTraMl := TStringList.Create;
      qryColorantes.First;
      SetLength(arrBaixaPigmentos, qryColorantes.RecordCount);

      While Not qryColorantes.Eof Do
      begin

        stlItensTraMl.Add(qryColorantes.FieldByName(GetNomeCampoColoranteCodIte).AsString);
        arrBaixaPigmentos[intPos].strCodIte   := qryColorantes.FieldByName(GetNomeCampoColoranteCodIte).AsString;
        arrBaixaPigmentos[intPos].fltQtdBaixa := fRetornaQuantidadeBaixaPigmentos(dicColorantes[qryColorantes.FieldByName(GetNomeCampoColoranteCodCol).AsString], qryColorantes);

        Inc(intPos);
        qryColorantes.Next;
      end;

      dicDados['stlItensTraMl'] := stlItensTraMl.Text;
      Result := True;
    Except
      on E: Exception do
      begin
       {$IFDEF LINUX}TAutcomTintaFactory.Get().WriteError(E.Message);{$ELSE}raise;{$ENDIF}
      end;
    End;
  Finally
    if Assigned(stlItensTraMl) then FreeAndNil(stlItensTraMl);
  End;
end;

function TAbstractLibTintaImobiliaria.fGTinForGeral(var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray;
  const dicDados: IDicionario): Boolean;
begin
  Result := fGTinForGer(arrFormul, arrBaixaPigmentos, dicDados);
end;

function TAbstractLibTintaImobiliaria.fRetornaCodigoChapinha(
  strIdePro: String): String;
begin
  Result := '';
end;

function TAbstractLibTintaImobiliaria.fRetornaFormulacaoParaTabelaPreco(
  const dicRetorno: IDicionario; out qryGen: IDataSet): Boolean;
begin
  Result := TMultiSelectLocalizadorFactory.GetLocalizador(dicRetorno['idepro']).
    Localizar(qryGen, ['ITETIN'], [TVariantUtils.IfNull(dicRetorno['itetin'], '')])
end;

function TAbstractLibTintaImobiliaria.fRetornaQuantidadeBaixaPigmentos(
  fltQtdBai: Double; const dataSet: IDataSet): Double;
begin
  Result := fltQtdBai;
end;


function TAbstractLibTintaImobiliaria.fRetornaTabelaColoranteTinta: String;
begin
  Result := GetFormulaImobiliaria.fRetornaTabelaColoranteTinta;
end;

function TAbstractLibTintaImobiliaria.fTintaBaixaEmbalagem(const strTipEmb: String; var strCodIte: String): Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaImobiliaria.fTintaBaixaProduto: Boolean;
begin
  Result := True;
end;

function TAbstractLibTintaImobiliaria.fTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TAbstractLibTintaImobiliaria.fTravaQuantidadeTinta(const strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaImobiliaria.fUsaChapinhaTinta(strIdePro,
  strIteTin: String): Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaImobiliaria.GetCampoComponenteCodComp: String;
begin
  Result := 'COL_CODCOL';
end;

function TAbstractLibTintaImobiliaria.GetCampoComponenteCodIte: String;
begin
  Result := 'COL_CODITE';
end;

function TAbstractLibTintaImobiliaria.GetCampoComponenteDesComp: String;
begin
  Result := '""';
end;

function TAbstractLibTintaImobiliaria.GetDigDadosTintometricos(strTabPre: string): IDigDadosTintometricos;
begin
  if TStrUtils.fEmptyStr(strTabPre) then
  begin
    strTabPre := TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString);
    if TStrUtils.fEmptyStr(strTabPre) then
    begin
      strTabPre := '1';
    end;
  end;

  Result := TDigDadosTintometricosImobiliaria.Create(GetFormulaImobiliaria(strTabPre));
end;

function TAbstractLibTintaImobiliaria.GetFatorEstoque: Double;
begin
  Result := GetFormulaImobiliaria.GetFatorEstoque;
end;

function TAbstractLibTintaImobiliaria.GetFormulaImobiliaria: TAbstractFormulaImobiliaria;
begin
//  Result := GetFormulaImobiliaria(TVariantUtils.IfNull(TAutcomTintaFactory.Get.fCfgSis('TABPAD'), '1'));
  Result := GetFormulaImobiliaria(TVariantUtils.IfNull(strTabPreVen,'1'));
end;

function TAbstractLibTintaImobiliaria.GetIdePro: String;
var
  formula: TAbstractFormulaImobiliaria;
begin
  formula := nil;
  Try
    Try
      formula := GetFormulaImobiliaria;
      Result := formula.GetIdePro;
    Except
      on E: Exception do
      begin
       {$IFDEF LINUX}TAutcomTintaFactory.Get().WriteError(E.Message);{$ELSE}raise;{$ENDIF}
      end;
    End;
  Finally
    if Assigned(formula) then FreeAndNil(formula);
  End;
end;

function TAbstractLibTintaImobiliaria.GetNomeCampoColoranteCodCol: string;
begin
  Result := 'COL_CODCOL';
end;

function TAbstractLibTintaImobiliaria.GetNomeCampoColoranteCodIte: String;
begin
  Result := 'COL_CODITE';
end;


function TAbstractLibTintaImobiliaria.GetNomeCampoColoranteColDescri: string;
begin
  Result := '""';
end;

function TAbstractLibTintaImobiliaria.GetPrefixoTabela: String;
begin
  Result := '';
end;

function TAbstractLibTintaImobiliaria.GetSQLBaseCataliGTinFor(
  const strColorantes: string; strCatalisador: String): String;
begin
  Result := '""';
end;

function TAbstractLibTintaImobiliaria.GetWhereRetComponente(const strCodEmp: String): String;
begin
  Result := Format('%s = :%0:s', [GetCampoComponenteCodComp]);
end;

procedure TAbstractLibTintaImobiliaria.pTintaRetornaTabelaPreco(dicRetorno: IDicionario; fltFatorAcerto: Double);
begin
  pTintaRetornaTabPrecoImobiliaria(dicRetorno, fltFatorAcerto);
end;

procedure TAbstractLibTintaImobiliaria.pTintaRetornaTabPrecoImobiliaria(
  dicRetorno: IDicionario; fltFatorAcerto: Double);
var
  formula: TAbstractFormulaImobiliaria;
  intCols: Integer;
  colorante: TColorante;
  calculadorFatVendas: ICalculadorFatVendasLibTintas;
  qryTintas: IDataSet;
  strCodEmp: String;
begin
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendasLibTintas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      formula := GetFormulaImobiliaria(TVariantUtils.IfNull(dicRetorno['tabpre'], '1'));
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
      strCodEmp := TAutcomTintaFactory.Get.GetCodEmp;
      TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(Formula.fVerificaEmpresaSetada);
      formula.ItemBaseOriginal := formula.GetItemBaseOriginal(dicRetorno['itetin']);

      If Not TStrUtils.fEmptyStr(GetPrefixoTabela) Then
      Begin
        If fRetornaFormulacaoParaTabelaPreco(dicRetorno, qryTintas) Then
        Begin
          If Assigned(qryTintas.FindField(GetPrefixoTabela + '_ACRMOB')) Then
            Formula.AcrMob := qryTintas.FieldByName(GetPrefixoTabela + '_ACRMOB').AsFloat
          Else
            Formula.AcrMob := 0;
        End;
      End
      Else
        Formula.AcrMob := 0;

      For intCols := 1 To formula.GetQuantidadeFormulacao Do
      begin
        If (TStrUtils.fEmptyStr(TVariantUtils.IfNull(dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)], ''))) Then
          Break;

        colorante := TColorante(formula.Add);
        colorante.CodigoColorante := dicRetorno['base' + TStrUtils.fStrZero(intCols, 2)];
        colorante.Quantidade := TFloatUtils.fFormataFloat(dicRetorno['qtdb' + TStrUtils.fStrZero(intCols, 2)] / formula.FatorEstoque, 3);
        colorante.Tipo := tciColorante;
      end;


      formula.ItemBase := TVariantUtils.IfNull(dicRetorno['itebas'], '');
      dicRetorno['desopetinta'] := TAutcomTintaFactory.Get.fGetConfTinta(dicRetorno['idepro']).fGetDouble('DESOPE');
      formula.RecalcularTabelas(dicRetorno);

      If (formula.PromocaoPrecoFixoSobreValorFinal = 'S') Then
      Begin
        formula.CalcularPrecos;
        formula.PrecoTotalColorantes := formula.GetCalculador.PrecoVenda;
        formula.CalculouColorante := 'S';
        formula.ItemBase := TVariantUtils.IfNull(dicRetorno['itebas'], '');
        dicRetorno['desopetinta'] := TAutcomTintaFactory.Get.fGetConfTinta(dicRetorno['idepro']).fGetDouble('DESOPE');
        formula.RecalcularTabelas(dicRetorno);
      End;

      dicRetorno['precus'] := formula.PrecoCusto + formula.BasePrecoCusto;
      dicRetorno['precu2'] := formula.PrecoCustoReal + formula.BasePrecoCustoReal;
      dicRetorno['premed'] := formula.PrecoMedio + formula.BasePrecoMedio;
      dicRetorno['preult'] := formula.UltimoPrecoCompra + formula.BasePrecoUltimaCompra;
      dicRetorno['impult'] := formula.UltimoPrecoCompraImpostos + formula.BasePrecoUltimaCompraImpostos;
      dicRetorno['prctin'] := formula.PrecoCompraLiquido + formula.BasePrecoCompraLiquido;
      dicRetorno['somcol'] := formula.PrecoTotalColorantes;

      dicRetorno.AdicionarObjeto('tintaDeMaquina', formula.tintaDeMaquina);
    Except
      on E: Exception do
      begin
       {$IFDEF LINUX}TAutcomTintaFactory.Get().WriteError(E.Message);{$ELSE}raise;{$ENDIF}
      end;
    End;
  Finally
    TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(strCodEmp);
  End;
end;

function TAbstractLibTintaImobiliaria.RetornaPreco(const Sender: TObject; const dtsTinta: IDataSet; const dicRetorno: IDicionario;
      var saldos: ISaldosColorantes; blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = ''; sltItems: TStringList = Nil;
      strMD5Key: String = ''; blnSemTela: Boolean = False; strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;
Var
  strTabPre: String;
  tintadeMaquinaWrapper: ITintadeMaquinaWrapper;
  calculador: ICalculadorPrecoTinta;
  digDados: IDigDadosTintometricos;
begin
  Result := False;
  saldos := nil;
  Try
    Try
      tintadeMaquinaWrapper := Self.GetITintadeMaquina;

      strTabPre    := TVariantUtils.IfNull(dicRetorno['tabpre'], '');
      if TStrUtils.fEmptyStr(strTabPre) then
      begin
        strTabPre := TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString);
        if TStrUtils.fEmptyStr(strTabPre) then
        begin
          strTabPre := '1';
        end;
      end;

      digDados := GetDigDadosTintometricos(strTabPre);
      calculador := TAbstractCalculadorPrecoTinta.Create(digDados);

      strTabPreVen := strTabPre;

      if not calculador.fRetornaPreco(Sender, dicRetorno, dtsTinta, blnFaturamento, blnPermiteTab, strTab, strAutoTab, sltItems, strMD5Key, blnSemTela) then
        Exit;

      saldos := digDados.GetSaldos;
      Result := True;

    Except
      on E: Exception do
      begin
       {$IFDEF LINUX}TAutcomTintaFactory.Get().WriteError(E.Message);{$ELSE}raise;{$ENDIF}
      end;
    End;
  Finally
  End;
end;

procedure TAbstractLibTintaImobiliaria.SetaParametrosRetComponentes(const dataSet: IDataSet; const strCodComp: String);
begin
  dataSet.ParamByName(GetCampoComponenteCodComp).AsString := strCodComp;
end;

end.
