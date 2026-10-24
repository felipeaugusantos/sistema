{*********************************************************************************************}
{* Classe abstrata que representa a tinta Automotiva ao todo, contendo todos os metodos que  *}
{* serão acessados pelos outros modulos (Autcom/Auttin)                                      *}
{******************************************************************************************AC*}
unit untAbstractLibTintaAutomotiva;

interface

uses
  untAbstractLibTinta, untTipoTinta, untILibTinta, untIDataSet, SysUtils, untIDicionario,
  untAbstractFormulaAutomotiva, untITintadeMaquinaWrapper, untICalculadorPrecoTinta,
  untDigDadosTintometricosAutomotiva, untGTinForTipos, Classes, StrUtils,
  untIDigDadosTintometricos, untISaldosColorantes, untModoVenda, untFloatUtils,
  untBaseAutomotiva, untICalculadorFatVendasLibTintas;

type
  TAbstractLibTintaAutomotiva = class abstract (TAbstractLibTinta, ILibTinta)
  private
    strTabPreVen: String;
  protected
    function GetWhereRetComponente(const strCodEmp: String): String; override;
    procedure SetaParametrosRetComponentes(const dataSet: IDataSet; const strCodComp: String); override;
    function GetCampoComponenteCodIte(): String; override;
    function GetCampoComponenteCodComp(): String; override;
    function fGetCountPigmentos(dicBases: IDicionario; qryBases: IDataSet): Integer; virtual;

    function GetVolumeOriginal(const dicRetorno: IDicionario): Double; virtual; abstract;
    function GetVolumeConcentrado: Double; virtual; abstract;
    function GetVolumeDiluido: Double; virtual; abstract;
    function GetVolumePro(const dicRetorno: IDicionario): Double; virtual; abstract;
    procedure pProcessaFormulacaoTabelaPreco(Formula: TAbstractFormulaAutomotiva;
                                          const dicRetorno: IDicionario; const qryConsulta: IDataSet); virtual; abstract;
    function GetCodFormul(const dicRetorno: IDicionario): string; virtual; abstract;
    procedure pProcessaFormulacaoGTinFor(Var arrFormul: TForMulTinDetArray; Const qryConsulta: IDataSet; dicBases: IDicionario;
                                 Const Formula: TAbstractFormulaAutomotiva; Const dicDados: IDicionario;
                                 Var strBases: String); virtual; abstract;

    function GetFormulaAutomotiva(const strTabPre: String): TAbstractFormulaAutomotiva; overload; virtual; abstract;
    //É utilizada somente para as tintas onde a quantidade mostrada é diferente da quantidade da formulacao
    function GetFormulaAutomotivaQtdEsp(const strTabPre: String): TAbstractFormulaAutomotiva; overload; virtual;
    function GetFormulaAutomotiva(): TAbstractFormulaAutomotiva; overload;
//    function GetFatorEstoque(): Double; override;
    function GetSQLBasesGTinFor(const strBases: string; Const dicDados: IDicionario): string; virtual; abstract;
    function GetSQLBasesEmpGTinFor(const strBases: String; Const dicDados: IDicionario): String; Virtual;
    procedure GetSQLBasesGTinForParametros(qryBases: IDataSet); virtual;
    function GetNomeCampoBaseCodIte(): String; virtual;
    function GetNomeCampoBaseCodBas(): string; virtual;
    function GetPrefixoTabela: String; virtual; abstract;

    function GetFormulArrBaixaPigmentos(dtsBases: IDataSet): String; virtual;
    function GetPesGraArrBaixaPigmentos(dtsBases: IDataSet): String; virtual;
    function GetEmbalaArrBaixaPigmentos(dtsBases: IDataSet): Double; virtual;
    function GetComponentePorEmpresas(const strCodEmp: String): String; virtual;

    procedure pProcessaBaixaPigmentosGTinFor(qryBases: IDataSet; intPos: Integer; Var List: TStringList;
      arrBaixaPigmentos: TBaixaPigmentosArray; dicBases: IDicionario; Const dicDados: IDicionario; strBases: String); Virtual;

    procedure PreencherPesCorFor(Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet); virtual;
    procedure pLocalizaFormulacaoGTinFor(const dicDados: IDicionario; out qryGen: IDataSet); virtual;
    function fRetornaQuantidadeBaixaGTinFor(dicBases: IDicionario; qryBases: IDataSet): Double; virtual;
    function fRetornaFormulacaoParaTabelaPreco(const dicRetorno: IDicionario; out qryGen: IDataSet): Boolean; virtual;

  public
    function fTintaTipo: TTipoTinta; Virtual;
    function fTipoTinta: TTipoTinta; override;
    function fTintaBaixaProduto(): Boolean; override;
    function fTintaBaixaEmbalagem(const strTipEmb: String; Var strCodIte: String): Boolean; override;
    function fUsaChapinhaTinta(strIdePro, strIteTin: String): Boolean; Override;
    function fUsaChapinhaTintaGeneric(strIdePro, strIteTin: String): Boolean; Virtual;
    function fRetornaCodigoChapinha(strIdePro: String): String; Override;
    function fRetornaCodigoChapinhaGeneric(strIdePro: String): String; Virtual;
    function fTravaQuantidadeTinta(const strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean; override;
    function fFormulacaoAcumulada(): Boolean; override;
    procedure pTintaRetornaTabelaPreco(dicRetorno: IDicionario; fltFatorAcerto: Double); override;
    procedure pTintaRetornaTabelaPrecoGeneric(dicRetorno: IDicionario; fltFatorAcerto: Double); Virtual;
    function GetIdePro: String; override;
    function fRetornaTabelaColoranteTinta(): String; override;
    destructor Destroy; override;
    function RetornaPreco(const Sender: TObject; const dtsTinta: IDataSet; const dicRetorno: IDicionario;
      var saldos: ISaldosColorantes; blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = '';
      sltItems: TStringList = Nil; strMD5Key: String = ''; blnSemTela: Boolean = False;
         strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean; override;
    function fGTinForGeral(var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray;
      const dicDados: IDicionario): Boolean; override;
    function GetDigDadosTintometricos(strTabPre: string): IDigDadosTintometricos; override;
     function GetQuantidadeGramaMl(const fltValor: Double; const Fator: Double; strFormula: String): Double; override;
  end;

implementation

uses
  untStrUtils, untVariantUtils, untAutcomTintaFactory, untAbstractCalculadorPrecoTinta,
  untMultiSelectLocalizadorFactory;

{ TAbstractLibTintaAutomotiva }

destructor TAbstractLibTintaAutomotiva.Destroy;
begin
  inherited Destroy;
end;

function TAbstractLibTintaAutomotiva.fFormulacaoAcumulada: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGetInteger('ACUABS') = 1;
end;

function TAbstractLibTintaAutomotiva.fGetCountPigmentos(dicBases: IDicionario;
  qryBases: IDataSet): Integer;
begin
  Result := 0;

  While Not qryBases.Eof Do
  Begin

    If fRetornaQuantidadeBaixaGTinFor(dicBases, qryBases) > 0 Then
      Result := Result + 1;

    qryBases.Next;
  End;
end;

function TAbstractLibTintaAutomotiva.fGTinForGeral(var arrFormul: TForMulTinDetArray; var arrBaixaPigmentos: TBaixaPigmentosArray;
  const dicDados: IDicionario): Boolean;
var
  qryConsulta: IDataSet;
  formula: TAbstractFormulaAutomotiva;
  dicBases: IDicionario;
  strBases: string;
  qryBases: IDataSet;
  intPos: Integer;
  stlItensTraMl: TStringList;
begin
  Result := False;
  stlItensTraMl := nil;
  Try
    Try
      pLocalizaFormulacaoGTinFor(dicDados, qryConsulta);

      Result := not qryConsulta.IsEmpty;
      if not Result then
        Exit;

      formula := GetFormulaAutomotiva();
      dicBases := TAutcomTintaFactory.Get.GetDicionario;

      pProcessaFormulacaoGTinFor(arrFormul, qryConsulta, dicBases, formula, dicDados, strBases);

      strBases := Trim(strBases);
      If (RightStr(strBases, 1) = ',') Then
        strBases := Copy(strBases, 1, Length(strBases)-1);

      qryBases := TAutcomTintaFactory.Get.fGetDataSet;
      qryBases.Close;
      qryBases.SQL := GetSQLBasesGTinFor(strBases, dicDados);
      GetSQLBasesGTinForParametros(qryBases);
      qryBases.Open;

      intPos := 0;
      stlItensTraMl := TStringList.Create;
      SetLength(arrBaixaPigmentos, fGetCountPigmentos(dicBases, qryBases));
      qryBases.First;

      pProcessaBaixaPigmentosGTinFor(qryBases, intPos, stlItensTraMl, arrBaixaPigmentos, dicBases, dicDados, strBases);

      dicDados['stlItensTraMl'] := stlItensTraMl.Text;
      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlItensTraMl) then FreeAndNil(stlItensTraMl);
  End;
end;

function TAbstractLibTintaAutomotiva.fRetornaCodigoChapinha(
  strIdePro: String): String;
begin
  Result := fRetornaCodigoChapinhaGeneric(strIdePro);
end;

function TAbstractLibTintaAutomotiva.fRetornaCodigoChapinhaGeneric(
  strIdePro: String): String;
begin
  Result := '';
end;

function TAbstractLibTintaAutomotiva.fRetornaFormulacaoParaTabelaPreco(
  const dicRetorno: IDicionario; out qryGen: IDataSet): Boolean;
begin
  Result := TMultiSelectLocalizadorFactory.GetLocalizador(dicRetorno['idepro']).
    Localizar(qryGen, ['ITETIN'], [TVariantUtils.IfNull(dicRetorno['itetin'], '')])

end;

function TAbstractLibTintaAutomotiva.fRetornaQuantidadeBaixaGTinFor(
  dicBases: IDicionario; qryBases: IDataSet): Double;
begin
  Result := dicBases[qryBases.FieldByName(GetNomeCampoBaseCodBas).AsString];
end;

function TAbstractLibTintaAutomotiva.fRetornaTabelaColoranteTinta: String;
begin
  Result := GetFormulaAutomotiva.fRetornaTabelaBaseTinta;
end;

function TAbstractLibTintaAutomotiva.fTintaBaixaEmbalagem(const strTipEmb: String; var strCodIte: String): Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaAutomotiva.fTintaBaixaProduto: Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaAutomotiva.fTintaTipo: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TAbstractLibTintaAutomotiva.fTipoTinta: TTipoTinta;
begin
  Result := fTintaTipo;
end;

function TAbstractLibTintaAutomotiva.fTravaQuantidadeTinta(const strTipEmb: String; fltQtdEmb, fltQtdDig: Double): Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaAutomotiva.fUsaChapinhaTinta(strIdePro,
  strIteTin: String): Boolean;
begin
  Result := fUsaChapinhaTintaGeneric(strIdePro, strIteTin);
end;

function TAbstractLibTintaAutomotiva.fUsaChapinhaTintaGeneric(strIdePro,
  strIteTin: String): Boolean;
begin
  Result := False;
end;

function TAbstractLibTintaAutomotiva.GetCampoComponenteCodComp: String;
begin
  Result := 'BAS_CODBAS';
end;

function TAbstractLibTintaAutomotiva.GetCampoComponenteCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TAbstractLibTintaAutomotiva.GetComponentePorEmpresas(const strCodEmp: String): String;
begin
  Result := '';
end;

function TAbstractLibTintaAutomotiva.GetDigDadosTintometricos(strTabPre: string): IDigDadosTintometricos;
begin
  if TStrUtils.fEmptyStr(strTabPre) then
  begin
    strTabPre := TAutcomTintaFactory.Get.fCfgSis('TABPAD', varString);
    if TStrUtils.fEmptyStr(strTabPre) then
    begin
      strTabPre := '1';
    end;
  end;

  Result := TDigDadosTintometricosAutomotiva.Create(
    GetFormulaAutomotiva(strTabPre), GetFormulaAutomotivaQtdEsp(strTabPre));
end;

function TAbstractLibTintaAutomotiva.GetEmbalaArrBaixaPigmentos(
  dtsBases: IDataSet): Double;
begin
  Result := 0;
end;

{function TAbstractLibTintaAutomotiva.GetFatorEstoque: Double;
begin
  Result := GetFormulaAutomotiva.GetFatorEstoque;
end;}

function TAbstractLibTintaAutomotiva.GetFormulaAutomotiva: TAbstractFormulaAutomotiva;
begin
//  Result := GetFormulaAutomotiva(TVariantUtils.IfNull(TAutcomTintaFactory.Get.fCfgSis('TABPAD'), '1'));
  Result := GetFormulaAutomotiva(TVariantUtils.IfNull(strTabPreVen,'1'));
end;

function TAbstractLibTintaAutomotiva.GetFormulaAutomotivaQtdEsp(
  const strTabPre: String): TAbstractFormulaAutomotiva;
begin
  Result := Nil;
end;

function TAbstractLibTintaAutomotiva.GetFormulArrBaixaPigmentos(dtsBases: IDataSet): String;
begin
  Result := '';
end;

function TAbstractLibTintaAutomotiva.GetIdePro: String;
var
  formula: TAbstractFormulaAutomotiva;
begin
  formula := nil;
  Try
    Try
      formula := GetFormulaAutomotiva;
      Result := formula.GetIdePro;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(formula) then FreeAndNil(formula);
  End;
end;

function TAbstractLibTintaAutomotiva.GetNomeCampoBaseCodBas: string;
begin
  Result := 'BAS_CODBAS';
end;

function TAbstractLibTintaAutomotiva.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TAbstractLibTintaAutomotiva.GetPesGraArrBaixaPigmentos(
  dtsBases: IDataSet): String;
begin
  Result := 'N';
end;

function TAbstractLibTintaAutomotiva.GetQuantidadeGramaMl(const fltValor,
  Fator: Double; strFormula: String): Double;
begin
  Result := 1;
end;

function TAbstractLibTintaAutomotiva.GetSQLBasesEmpGTinFor(
  const strBases: String; const dicDados: IDicionario): String;
begin
  //
end;

procedure TAbstractLibTintaAutomotiva.GetSQLBasesGTinForParametros(
  qryBases: IDataSet);
begin
  //
end;

function TAbstractLibTintaAutomotiva.GetWhereRetComponente(const strCodEmp: String): String;
begin
  Result := Format('%s = :%0:s', [GetCampoComponenteCodComp]) + GetComponentePorEmpresas(strCodEmp);
end;

procedure TAbstractLibTintaAutomotiva.pLocalizaFormulacaoGTinFor(
  const dicDados: IDicionario; out qryGen: IDataSet);
begin
  TMultiSelectLocalizadorFactory.GetLocalizador(dicDados['idepro']).
    Localizar(qryGen, ['ITETIN'], [TVariantUtils.IfNull(dicDados['itetin'], '')]);

end;

procedure TAbstractLibTintaAutomotiva.pProcessaBaixaPigmentosGTinFor(qryBases: IDataSet; intPos: Integer; Var List: TStringList;
  arrBaixaPigmentos: TBaixaPigmentosArray; dicBases: IDicionario; Const dicDados: IDicionario; strBases: String);
begin
  while not qryBases.Eof do
  begin

    If fRetornaQuantidadeBaixaGTinFor(dicBases, qryBases) <= 0 Then
    Begin
      qryBases.Next;
      Continue;
    End;

    List.Add(qryBases.FieldByName(GetNomeCampoBaseCodIte).AsString);
    arrBaixaPigmentos[intPos].strCodIte   := qryBases.FieldByName(GetNomeCampoBaseCodIte).AsString;
//  arrBaixaPigmentos[intPos].fltQtdBaixa := dicBases[qryBases.FieldByName(GetNomeCampoBaseCodBas).AsString];
    arrBaixaPigmentos[intPos].fltQtdBaixa := fRetornaQuantidadeBaixaGTinFor(dicBases, qryBases);
    arrBaixaPigmentos[intPos].strFormul   := GetFormulArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].strPesGra   := GetPesGraArrBaixaPigmentos(qryBases);
    arrBaixaPigmentos[intPos].fltEmbBas   := GetEmbalaArrBaixaPigmentos(qryBases);

    Inc(intPos);
    qryBases.Next;
  end;
end;

procedure TAbstractLibTintaAutomotiva.PreencherPesCorFor(
  Formula: TAbstractFormulaAutomotiva; qryConsulta: IDataSet);
begin
  //
end;

procedure TAbstractLibTintaAutomotiva.pTintaRetornaTabelaPreco(dicRetorno: IDicionario; fltFatorAcerto: Double);
begin
  pTintaRetornaTabelaPrecoGeneric(dicRetorno, fltFatorAcerto);
end;

procedure TAbstractLibTintaAutomotiva.pTintaRetornaTabelaPrecoGeneric(
  dicRetorno: IDicionario; fltFatorAcerto: Double);
var
  strTabelas: String;
  Formula: TAbstractFormulaAutomotiva;
  intContador: Integer;
  strTabelaUnica: String;
  strTabelaAtual: String;
  calculadorFatVendas: ICalculadorFatVendasLibTintas;
  qryConsulta: IDataSet;
  strCodEmp: String;
begin
  Try
    Try
      if not Supports(dicRetorno.RetornaObjeto('calculadorFatVendas'), ICalculadorFatVendasLibTintas, calculadorFatVendas) then
        calculadorFatVendas := nil;

      Formula := GetFormulaAutomotiva(TVariantUtils.IfNull(dicRetorno['tabpre'], '1'));
      formula.calculadorFatVendas := calculadorFatVendas;
      Formula.BlnCalculaUnitario := False;
      Formula.VolumeOri          := GetVolumeOriginal(dicRetorno);
      Formula.VolumeConcentrado  := GetVolumeConcentrado;
      Formula.VolumeDiluido      := GetVolumeDiluido;
      Formula.VolumePro          := GetVolumePro(dicRetorno);

      If dicRetorno['tippre'] = 'C' Then
        Formula.mveModoVenda     := mvConcentrado
      Else
        Formula.mveModoVenda     := mvDiluido;

      If (Not Formula.AcertoValor) And (fltFatorAcerto = 0) Then
        Formula.FatorAcerto        := 1
      Else
        Formula.FatorAcerto        := fltFatorAcerto;

      Formula.OpcDoc := TVariantUtils.IfNull(dicRetorno['opcdoc'], '');
      Formula.CodCli := TVariantUtils.IfNull(dicRetorno['codcli'], '');
      Formula.CodCnd := TVariantUtils.IfNull(dicRetorno['codcnd'], '');
      Formula.PrzMed := TVariantUtils.IfNull(dicRetorno['przmed'], 0);
      formula.OprFlj := TVariantUtils.IfNull(dicRetorno['oprflj'], '');
      formula.EmpresaProducao := TVariantUtils.IfNull(dicRetorno['empprd'], '');
      Formula.EmpCd_ := TVariantUtils.IfNull(dicRetorno['emp_cd'], '');
      Formula.CD_S_N := TVariantUtils.IfNull(dicRetorno['Cd_S_N'], '');
      Formula.EmpFat := TVariantUtils.IfNull(dicRetorno['empfat'], '');
      Formula.FatS_N := TVariantUtils.IfNull(dicRetorno['FatS_N'], '');

      strCodEmp := TAutcomTintaFactory.Get.GetCodEmp;
      TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(Formula.fVerificaEmpresaSetada);

      If Formula.AcertoValor Then
        dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(Formula.FatorAcerto > 0, 'S', 'N')
      Else
        dicRetorno['acerto'] := TAutcomTintaFactory.Get.IIF(Formula.FatorAcerto > 1, 'S', 'N');

      If fRetornaFormulacaoParaTabelaPreco(dicRetorno, qryConsulta) Then
        Formula.AcrMob := qryConsulta.FieldByName(GetPrefixoTabela + '_ACRMOB').AsFloat
      Else
        dicRetorno['formula_nao_encontrada'] := 'S';

      Formula.CodEmb := dicRetorno['iteemb'];
      Formula.UsaChapinha := Formula.GetUsaChapinha(qryConsulta);
      Formula.ProCha := TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGet('PROCHA');

      PreencherPesCorFor(Formula, qryConsulta);

      pProcessaFormulacaoTabelaPreco(Formula, dicRetorno, qryConsulta);

      Formula.CodFormul := GetCodFormul(dicRetorno);


      dicRetorno['desopetinta'] := TAutcomTintaFactory.Get.fGetConfTinta(GetIdePro).fGetDouble('DESOPE');

      strTabelaUnica := TVariantUtils.IfNull(dicRetorno['tabelaunica'], '');

      If (not TStrUtils.fEmptyStr(strTabelaUnica)) Then
      Begin
        Formula.TabPre := strTabelaUnica;

        Formula.CarregarBases(dicRetorno);
        Formula.CarregarBasesPorEmpresa(dicRetorno);

        Formula.CarregaPrecosBases;
        Formula.CarregaPrecosBasesPorEmpresa;

        Formula.CalcularPrecos;

        {Carrega preço da embalagem conforme tabela de preço!}
        Formula.pCarregaPrecoPromocaoEmbalagem(strTabelaUnica, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));
        Formula.pCarregaPrecoChapinha(strTabelaUnica, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));

        If TVariantUtils.IfNull(dicRetorno['precus'], 0) <= 0 Then
        Begin
          If dicRetorno['tippre'] = 'C' Then
            dicRetorno['precus'] := Formula.PrecoCustoCon + Formula.EmbPrecoCusto
          Else
            dicRetorno['precus'] := Formula.PrecoCustoDil + Formula.EmbPrecoCusto;

          If Formula.UsaChapinha Then
            dicRetorno['precus'] := dicRetorno['precus'] + Formula.ChaPrecoCusto;
        End;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['precu2'] := Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal;

          If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaCon + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
          Else
            dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaCon + Formula.EmbPrecoVenda) + Formula.AcrMob;

          If Formula.UsaChapinha Then
          Begin
            dicRetorno['precu2'] := dicRetorno['precu2'] + Formula.ChaPrecoCustoReal;
            dicRetorno['preve' + strTabelaUnica] := dicRetorno['preve' + strTabelaUnica] + Formula.ChaPrecoVenda;
          End;

          dicRetorno['preve' + strTabelaUnica + '_original'] := dicRetorno['preve' + strTabelaUnica];
        End
        Else
        Begin
          dicRetorno['precu2'] := Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal;

          If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
            dicRetorno['preve' + strTabelaUnica] := (Formula.PrecoVendaDil + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
          Else
            dicRetorno['preve' + strTabelaUnica] := Formula.PrecoVendaDil + Formula.EmbPrecoVenda + Formula.AcrMob;

          If Formula.UsaChapinha Then
          Begin
            dicRetorno['precu2'] := dicRetorno['precu2'] + Formula.ChaPrecoCustoReal;
            dicRetorno['preve' + strTabelaUnica] := dicRetorno['preve' + strTabelaUnica] + Formula.ChaPrecoVenda;
          End;

          dicRetorno['preve' + strTabelaUnica + '_original'] := dicRetorno['preve' + strTabelaUnica];
        End;

        Formula.pCalculaImpostosSaida(dicRetorno);
        dicRetorno.AdicionarObjeto('tintaDeMaquina', Formula.tintaDeMaquina[Formula.mveModoVenda]);
        dicRetorno['promoc'] := Formula.Promoc;

        If dicRetorno['tippre'] = 'C' Then
        Begin
          dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos;
          dicRetorno['preult'] := Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra;
          dicRetorno['premed'] := Formula.PrecoMedioCon + Formula.EmbPrecoMedio;
          dicRetorno['prctin'] := Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido;

          If Formula.UsaChapinha Then
          Begin
            dicRetorno['impult'] := dicRetorno['impult'] + Formula.ChaPrecoUltimaCompraImpostos;
            dicRetorno['preult'] := dicRetorno['preult'] + Formula.ChaPrecoUltimaCompra;
            dicRetorno['premed'] := dicRetorno['premed'] + Formula.ChaPrecoMedio;
            dicRetorno['prctin'] := dicRetorno['prctin'] + Formula.ChaPrecoCompraLiquido;
          End;
        End
        Else
        Begin
          dicRetorno['impult'] := Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos;
          dicRetorno['preult'] := Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra;
          dicRetorno['premed'] := Formula.PrecoMedioDil + Formula.EmbPrecoMedio;
          dicRetorno['prctin'] := Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido;

          If Formula.UsaChapinha Then
          Begin
            dicRetorno['impult'] := dicRetorno['impult'] + Formula.ChaPrecoUltimaCompraImpostos;
            dicRetorno['preult'] := dicRetorno['preult'] + Formula.ChaPrecoUltimaCompra;
            dicRetorno['premed'] := dicRetorno['premed'] + Formula.ChaPrecoMedio;
            dicRetorno['prctin'] := dicRetorno['prctin'] + Formula.ChaPrecoCompraLiquido;
          End;
        end;

        If Formula.AcertoValor Then
        Begin
          dicRetorno['precus'] := dicRetorno['precus'] + Formula.FatorAcerto;
          dicRetorno['preve' + strTabelaUnica] := dicRetorno['preve' + strTabelaUnica] + Formula.FatorAcerto;
          dicRetorno['precu2'] := dicRetorno['precu2'] + Formula.FatorAcerto;
          dicRetorno['impult'] := dicRetorno['impult'] + Formula.FatorAcerto;
          dicRetorno['preult'] := dicRetorno['preult'] + Formula.FatorAcerto;
          dicRetorno['premed'] := dicRetorno['premed'] + Formula.FatorAcerto;
          dicRetorno['prctin'] := dicRetorno['prctin'] + Formula.FatorAcerto;
        End
        Else
        Begin
          dicRetorno['precus'] := dicRetorno['precus'] * Formula.FatorAcerto;
          dicRetorno['preve' + strTabelaUnica] := dicRetorno['preve' + strTabelaUnica] * Formula.FatorAcerto;
          dicRetorno['precu2'] := dicRetorno['precu2'] * Formula.FatorAcerto;
          dicRetorno['impult'] := dicRetorno['impult'] * Formula.FatorAcerto;
          dicRetorno['preult'] := dicRetorno['preult'] * Formula.FatorAcerto;
          dicRetorno['premed'] := dicRetorno['premed'] * Formula.FatorAcerto;
          dicRetorno['prctin'] := dicRetorno['prctin'] * Formula.FatorAcerto;
        End;
      End
      Else
      Begin
        strTabelas := TAutcomTintaFactory.Get.fCfgSis('TABPRC');
        If Length(strTabelas) < 7 Then
          strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

        strTabelaAtual := Formula.TabPre;
        For intContador := 1 To Length(strTabelas) Do
        Begin
          If strTabelas[intContador] = 'S' Then
          Begin
            Formula.TabPre := IntToStr(intContador);

            Formula.CarregarBases(dicRetorno);
            Formula.CarregarBasesPorEmpresa(dicRetorno);

            Formula.CarregaPrecosBases;
            Formula.CarregaPrecosBasesPorEmpresa;

            Formula.CalcularPrecos;

            {Carrega preço da embalagem conforme tabela de preço!}
            Formula.pCarregaPrecoPromocaoEmbalagem(Formula.TabPre, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));
            Formula.pCarregaPrecoChapinha(Formula.TabPre, TVariantUtils.IfNull(dicRetorno['opcdoc'], ''));

            If TVariantUtils.IfNull(dicRetorno['precus'], 0) <= 0 Then
            Begin
              If dicRetorno['tippre'] = 'C' Then
              Begin
                If Formula.UsaChapinha Then
                  dicRetorno['precus'] := Formula.ChaPrecoCusto;

                If Formula.AcertoValor Then
                  dicRetorno['precus'] := TVariantUtils.IfNull(dicRetorno['precus'], 0) + (Formula.PrecoCustoCon + Formula.EmbPrecoCusto + Formula.FatorAcerto)
                Else
                  dicRetorno['precus'] := (TVariantUtils.IfNull(dicRetorno['precus'], 0) + Formula.PrecoCustoCon + Formula.EmbPrecoCusto) * Formula.FatorAcerto;
              End
              Else
              Begin
                If Formula.UsaChapinha Then
                  dicRetorno['precus'] := Formula.ChaPrecoCusto;

                If Formula.AcertoValor Then
                  dicRetorno['precus'] := TVariantUtils.IfNull(dicRetorno['precus'], 0) + (Formula.PrecoCustoDil + Formula.EmbPrecoCusto + Formula.FatorAcerto)
                Else
                  dicRetorno['precus'] := (TVariantUtils.IfNull(dicRetorno['precus'], 0) + Formula.PrecoCustoDil + Formula.EmbPrecoCusto) * Formula.FatorAcerto;
              End;
            End;

            If dicRetorno['tippre'] = 'C' Then
            Begin
              If Formula.UsaChapinha Then
              Begin
                dicRetorno['precu2'] := Formula.ChaPrecoCustoReal;
                dicRetorno['preve' + IntToStr(intContador)] := Formula.ChaPrecoVenda;
              End;

              If Formula.AcertoValor Then
                dicRetorno['precu2'] := TVariantUtils.IfNull(dicRetorno['precu2'], 0) + (Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal + Formula.FatorAcerto)
              Else
                dicRetorno['precu2'] := (TVariantUtils.IfNull(dicRetorno['precu2'], 0) + Formula.PrecoCustoRealCon + Formula.EmbPrecoCustoReal) * Formula.FatorAcerto;

              If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
                dicRetorno['preve' + IntToStr(intContador)] := (TVariantUtils.IfNull(dicRetorno['preve' + IntToStr(intContador)], 0) + Formula.PrecoVendaCon + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
              Else
                dicRetorno['preve' + IntToStr(intContador)] := TVariantUtils.IfNull(dicRetorno['preve' + IntToStr(intContador)], 0) + (Formula.PrecoVendaCon + Formula.EmbPrecoVenda + Formula.AcrMob);

              dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];
            End
            Else
            Begin
              If Formula.UsaChapinha Then
              Begin
                dicRetorno['precu2'] := Formula.ChaPrecoCustoReal;
                dicRetorno['preve' + IntToStr(intContador)] := Formula.ChaPrecoVenda;
              End;

              If Formula.AcertoValor Then
                dicRetorno['precu2'] := TVariantUtils.IfNull(dicRetorno['precu2'], 0) + (Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal + Formula.FatorAcerto)
              Else
                dicRetorno['precu2'] := (TVariantUtils.IfNull(dicRetorno['precu2'], 0) + Formula.PrecoCustoRealDil + Formula.EmbPrecoCustoReal) * Formula.FatorAcerto;

              If TAutcomTintaFactory.Get.fGetConfTinta(Self.GetIdePro).fGet('ACRMOB') = '1' Then
                dicRetorno['preve' + IntToStr(intContador)] := (TVariantUtils.IfNull(dicRetorno['preve' + IntToStr(intContador)], 0) + Formula.PrecoVendaDil + Formula.EmbPrecoVenda) * (1 + Formula.AcrMob / 100)
              Else
                dicRetorno['preve' + IntToStr(intContador)] := TVariantUtils.IfNull(dicRetorno['preve' + IntToStr(intContador)], 0) + (Formula.PrecoVendaDil + Formula.EmbPrecoVenda + Formula.AcrMob);

              dicRetorno['preve' + IntToStr(intContador) + '_original'] := dicRetorno['preve' + IntToStr(intContador)];
            End;

            If intContador = TVariantUtils.IfNull(dicRetorno['tabpre'], 0) Then
            Begin
              Formula.pCalculaImpostosSaida(dicRetorno);
              dicRetorno.AdicionarObjeto('tintaDeMaquina', Formula.tintaDeMaquina[Formula.mveModoVenda]);
              dicRetorno['promoc'] := Formula.Promoc;

              If dicRetorno['tippre'] = 'C' Then
              Begin
                If Formula.UsaChapinha Then
                Begin
                  dicRetorno['impult'] := Formula.ChaPrecoUltimaCompraImpostos;
                  dicRetorno['preult'] := Formula.ChaPrecoUltimaCompra;
                  dicRetorno['premed'] := Formula.ChaPrecoMedio;
                  dicRetorno['prctin'] := Formula.ChaPrecoCompraLiquido;
                End;

                If Formula.AcertoValor Then
                Begin
                  dicRetorno['impult'] := TVariantUtils.IfNull(dicRetorno['impult'], 0) + (Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos + Formula.FatorAcerto);
                  dicRetorno['preult'] := TVariantUtils.IfNull(dicRetorno['preult'], 0) + (Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra + Formula.FatorAcerto);
                  dicRetorno['premed'] := TVariantUtils.IfNull(dicRetorno['premed'], 0) + (Formula.PrecoMedioCon + Formula.EmbPrecoMedio + Formula.FatorAcerto);
                  dicRetorno['prctin'] := TVariantUtils.IfNull(dicRetorno['prctin'], 0) + (Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido + Formula.FatorAcerto);
                End
                Else
                Begin
                  dicRetorno['impult'] := (TVariantUtils.IfNull(dicRetorno['impult'], 0) + Formula.UltimoPrecoCompraImpostosCon + Formula.EmbPrecoUltimaCompraImpostos) * Formula.FatorAcerto;
                  dicRetorno['preult'] := (TVariantUtils.IfNull(dicRetorno['preult'], 0) + Formula.UltimoPrecoCompraCon + Formula.EmbPrecoUltimaCompra) * Formula.FatorAcerto;
                  dicRetorno['premed'] := (TVariantUtils.IfNull(dicRetorno['premed'], 0) + Formula.PrecoMedioCon + Formula.EmbPrecoMedio) * Formula.FatorAcerto;
                  dicRetorno['prctin'] := (TVariantUtils.IfNull(dicRetorno['prctin'], 0) + Formula.PrecoCompraLiquidoCon + Formula.EmbPrecoCompraLiquido) * Formula.FatorAcerto;
                End;
              End
              Else
              Begin
                If Formula.UsaChapinha Then
                Begin
                  dicRetorno['impult'] := Formula.ChaPrecoUltimaCompraImpostos;
                  dicRetorno['preult'] := Formula.ChaPrecoUltimaCompra;
                  dicRetorno['premed'] := Formula.ChaPrecoMedio;
                  dicRetorno['prctin'] := Formula.ChaPrecoCompraLiquido;
                End;

                If Formula.AcertoValor Then
                Begin
                  dicRetorno['impult'] := TVariantUtils.IfNull(dicRetorno['impult'], 0) + (Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos + Formula.FatorAcerto);
                  dicRetorno['preult'] := TVariantUtils.IfNull(dicRetorno['preult'], 0) + (Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra + Formula.FatorAcerto);
                  dicRetorno['premed'] := TVariantUtils.IfNull(dicRetorno['premed'], 0) + (Formula.PrecoMedioDil + Formula.EmbPrecoMedio + Formula.FatorAcerto);
                  dicRetorno['prctin'] := TVariantUtils.IfNull(dicRetorno['prctin'], 0) + (Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido + Formula.FatorAcerto);
                End
                Else
                Begin
                  dicRetorno['impult'] := (TVariantUtils.IfNull(dicRetorno['impult'], 0) + Formula.UltimoPrecoCompraImpostosDil + Formula.EmbPrecoUltimaCompraImpostos) * Formula.FatorAcerto;
                  dicRetorno['preult'] := (TVariantUtils.IfNull(dicRetorno['preult'], 0) + Formula.UltimoPrecoCompraDil + Formula.EmbPrecoUltimaCompra) * Formula.FatorAcerto;
                  dicRetorno['premed'] := (TVariantUtils.IfNull(dicRetorno['premed'], 0) + Formula.PrecoMedioDil + Formula.EmbPrecoMedio) * Formula.FatorAcerto;
                  dicRetorno['prctin'] := (TVariantUtils.IfNull(dicRetorno['prctin'], 0) + Formula.PrecoCompraLiquidoDil + Formula.EmbPrecoCompraLiquido) * Formula.FatorAcerto;
                End;
              End;
            End;

            If Formula.AcertoValor Then
              dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] + Formula.FatorAcerto
            Else
              dicRetorno['preve' + IntToStr(intContador)] := dicRetorno['preve' + IntToStr(intContador)] * Formula.FatorAcerto;
          End;
        End;
        Formula.TabPre := strTabelaAtual;
      End;
    Except
      on E: Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    End;
  Finally
    TAutcomTintaFactory.Get.pSetaEmpresaLogadaTinta(strCodEmp);
  End;
end;

function TAbstractLibTintaAutomotiva.RetornaPreco(const Sender: TObject; const dtsTinta: IDataSet; const dicRetorno: IDicionario;
      var saldos: ISaldosColorantes; blnFaturamento, blnPermiteTab: Boolean; strTab: String = 'N'; strAutoTab: String = '';
      sltItems: TStringList = Nil; strMD5Key: String = ''; blnSemTela: Boolean = False;
         strEmbPro: String = ''; strModoVenda: String = ''; strCodDil: String = ''): Boolean;
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

      if not calculador.fRetornaPreco(Sender, dicRetorno, dtsTinta, blnFaturamento, blnPermiteTab, strTab, strAutoTab, sltItems, strMD5Key, blnSemTela, strEmbPro, strModoVenda, strCodDil) then
        Exit;

      saldos := digDados.GetSaldos;
      Result := True;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TAbstractLibTintaAutomotiva.SetaParametrosRetComponentes(const dataSet: IDataSet; const strCodComp: String);
begin
  dataSet.ParamByName(GetCampoComponenteCodComp).AsString := strCodComp;
end;

end.


