unit untFatEstruturaVidro;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  UniClientDataSet,
{$ENDIF}
  Uni, SysUtils, Variants, Classes, TypInfo,
  Rest.Json, Data.DB, System.Generics.Collections, System.UITypes;

Type
  TFuncCalcAlqIcms = function(strCodIte, strEmpIte, strImpDir: String; strEntFut: String; blnEhCalcDifal: Boolean = False): Double of Object;

Type
  TComplementoVidro = Record
    strCodigo: String;
    strDescricao: String;
    fltFatorCusto: Double;
    fltFatorVenda: Double;
    procedure pCarregarComplemento(strCodCom: String);
  end;

Type
  TSubItemVidroTotais = record
    fltPrecoCustoTotal: Double;
    fltPrecoCustoRealTotal: Double;
    fltOutrosValoresTotal: Double;
    fltIcmsSaidaTotal: Double;
    fltImpostosFederaisTotal: Double;
    fltDespesasOperacionaisTotal: Double;
    fltPrecoUltimaCompraTotal: Double;
    fltPrecoUltimaComImpostosTotal: Double;
    fltPrecoCompraLiquidoTotal: Double;
    fltPrecoMedioTotal: Double;
    fltPrecoTabelaTotal: Double;
    fltPrecoVendaTotal: Double;
    fltPrecoVenda1Total: Double;
    fltPrecoVenda2Total: Double;
    fltPrecoVenda3Total: Double;
    fltPrecoVenda4Total: Double;
    fltPrecoVenda5Total: Double;
    fltPrecoVenda6Total: Double;
    fltPrecoVenda7Total: Double;
  end;

type
  TSubItemVidro = record
    strCodigo: String;
    strDescricao: String;
    strReferencia: String;
    strUnidade: String;
    strSiglaUnidade: String;
    strUsaMetragem: String;
    strImportacaoDireta: String;
    strItemFracionario: String;
    strTabelaPreco: String;
    strEntregaFutura: String;
    strAtivo: String;
    dtaDataBalanco: TDateTime;

    fltQuantidade: Double;
    fltLargura: Double;
    fltAltura: Double;
    fltAreaM2: Double;
    fltQuantidadeVenda: Double;

    fltPrecoDigitado: Double;
    fltPrecoVenda: Double;
    fltPrecoCusto: Double;
    fltPrecoCustoReal: Double;

    fltPrecoVenda1: Double;
    fltPrecoVenda2: Double;
    fltPrecoVenda3: Double;
    fltPrecoVenda4: Double;
    fltPrecoVenda5: Double;
    fltPrecoVenda6: Double;
    fltPrecoVenda7: Double;

    fltOutrosValores: Double;
    fltIcmsSaida: Double;
    fltImpostosFederais: Double;
    fltDespesasOperacionais: Double;
    fltPrecoUltimaCompra: Double;
    fltPrecoUltimaComImpostos: Double;
    fltPrecoCompraLiquido: Double;
    fltPrecoMedio: Double;

    blnManterPrecoVenda: Boolean;

    ComplementoVidro: TComplementoVidro;

    ValoresTotais: TSubItemVidroTotais;

    function fGetPrecoTabela: Double;
    function fGetDescricaoCompleta: String;

    procedure pCarregarProduto(strCodIte: String);
    procedure pCalcularValores;
  end;

type
  TSubItensVidro = class(TInterfacedObject, IInterface)
  private type
    TSubItensArray = Array Of TSubItemVidro;
  public
    FItems: TSubItensArray;
  public
    property Items: TSubItensArray read FItems write FItems;
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSubItensVidro;
  end;

type
  TSubItensVidroManager = class
    public
      class function fExportToClientDataSet(const subItens: TSubItensVidro): TUniClientDataSet;
      class function fLoadFromClientDataSet(const cdsItens: TUniClientDataSet): TSubItensVidro;
      class procedure pAddSubItemClientDataSet(const subItem: TSubItemVidro; var cdsItens: TUniClientDataSet; blnAlter: Boolean = False);
      class procedure pClonarSubItens(const subItensOri: TSubItensVidro; var subItensDes: TSubItensVidro);
      class procedure pRecalcularPrecos(var subItens: TSubItensVidro; const strTabPre, strEntFut, strEmpIte: String; fCalcAlqIcms: TFuncCalcAlqIcms = nil);
      class procedure pAcertarPrecos(var subItens: TSubItensVidro; const fltTotalEstrutura: Double);
      class function  fCalcularTotais(const subItens: TSubItensVidro): TSubItemVidroTotais;
      class procedure pGravarSubItensPedOrc(const subItens: TSubItensVidro; strAutIncFatDor: String);
      class procedure pCarregarSubItensPedOrc(var subItens: TSubItensVidro; strAutIncFatDor: String);
  end;

type
  TFatDigitacaoEstruturaVidro = class
    private
      FEmpresaItem          : String;
      FTabelaPreco          : String;
      FEntregaFutura        : String;
      FEstruturaDigitandoID : Integer;
      FEstruturaDigitando   : TSubItensVidro;
      FEstruturasSalvas     : TDictionary<Integer, TSubItensVidro>;
      function GetTemSubItens: Boolean;
    public
      constructor Create;
      destructor Destroy; override;
      procedure pCarregarEstrutura(ID: Integer);
      procedure pCancelarDigitacao;
      procedure pRecalcularPrecos(fCalcAlqIcms: TFuncCalcAlqIcms = nil);
    {$IFNDEF LINUX}
      function fDigitarEstrutura: Boolean;
    {$ENDIF}
      procedure pSalvarEstrutura; overload;
      procedure pSalvarEstrutura(ID: Integer); overload;
      procedure pExcluirEstrutura(ID: Integer);
      procedure pGravarEstruturaPedOrc(strAutIncFatDor: String);
      procedure pCarregarEstruturaPedOrc(strAutIncFatDor: String);
      property strTabelaPreco: String Read FTabelaPreco Write FTabelaPreco;
      property strEmpresaItem: String Read FEmpresaItem Write FEmpresaItem;
      property strEntregaFutura: String Read FEntregaFutura Write FEntregaFutura;
      property subItensEstrutura: TSubItensVidro Read FEstruturaDigitando Write FEstruturaDigitando;
      property dicEstruturasSalvas: TDictionary<Integer, TSubItensVidro> Read FEstruturasSalvas;
      property blnTemSubItensDigitados: Boolean Read GetTemSubItens;
  end;

implementation

uses
{$IFDEF LINUX}
  untFuncoesGenerica,
{$ELSE}
  untfuncoesSimples, untConsultas, untFuncoes,
  untPai, untFatDigEstruturaVidro,
{$ENDIF}
  untTypesSistema, untParCalculaPrecoCusto, untIConfiguracao,
  untTConfiguracao;

{ TFatDigitacaoEstruturaVidro }

constructor TFatDigitacaoEstruturaVidro.Create;
begin
  FEstruturasSalvas := TDictionary<Integer,TSubItensVidro>.Create;
  FEstruturaDigitando := TSubItensVidro.Create;
  SetLength(FEstruturaDigitando.FItems, 0);
  FEstruturaDigitandoID := -1;
end;

destructor TFatDigitacaoEstruturaVidro.Destroy;
begin
  If Assigned(FEstruturasSalvas) Then
  Begin
    FreeAndNil(FEstruturasSalvas);
  End;

  SetLength(FEstruturaDigitando.FItems, 0);

  inherited Destroy;
end;

{$IFNDEF LINUX}
function TFatDigitacaoEstruturaVidro.fDigitarEstrutura: Boolean;
begin
  Try
    pCriarFormularios(TfrmFatDigEstruturaVidro, frmFatDigEstruturaVidro);

    TSubItensVidroManager.pClonarSubItens(FEstruturaDigitando, frmFatDigEstruturaVidro.subItens);
    frmFatDigEstruturaVidro.strTabPre := FTabelaPreco;
    frmFatDigEstruturaVidro.strEntFut := FEntregaFutura;
    frmFatDigEstruturaVidro.ShowModal;

    Result := frmFatDigEstruturaVidro.blnConfirma;

    If Result  Then
      TSubItensVidroManager.pClonarSubItens(frmFatDigEstruturaVidro.subItens, FEstruturaDigitando);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmFatDigEstruturaVidro);
end;
{$ENDIF}

function TFatDigitacaoEstruturaVidro.GetTemSubItens: Boolean;
begin
  Result := Length(FEstruturaDigitando.Items) > 0;
end;

procedure TFatDigitacaoEstruturaVidro.pCancelarDigitacao;
begin
  SetLength(FEstruturaDigitando.FItems, 0);
  FEstruturaDigitandoID := -1;
end;

procedure TFatDigitacaoEstruturaVidro.pCarregarEstrutura(ID: Integer);
begin
  If (Length(FEstruturaDigitando.Items) = 0) Or (ID <> FEstruturaDigitandoID) Then
  Begin
    FEstruturaDigitandoID := ID;
    If FEstruturasSalvas.ContainsKey(ID) Then
      TSubItensVidroManager.pClonarSubItens(FEstruturasSalvas[ID], FEstruturaDigitando);
  End;
end;

procedure TFatDigitacaoEstruturaVidro.pCarregarEstruturaPedOrc(
  strAutIncFatDor: String);
begin
  pCancelarDigitacao;
  TSubItensVidroManager.pCarregarSubItensPedOrc(FEstruturaDigitando, strAutIncFatDor);
end;

procedure TFatDigitacaoEstruturaVidro.pExcluirEstrutura(ID: Integer);
begin
  If FEstruturasSalvas.ContainsKey(ID) Then
    FEstruturasSalvas.Remove(ID);
end;

procedure TFatDigitacaoEstruturaVidro.pGravarEstruturaPedOrc(
  strAutIncFatDor: String);
begin
  TSubItensVidroManager.pGravarSubItensPedOrc(FEstruturaDigitando, strAutIncFatDor);
end;

procedure TFatDigitacaoEstruturaVidro.pRecalcularPrecos(
  fCalcAlqIcms: TFuncCalcAlqIcms);
begin
  TSubItensVidroManager.pRecalcularPrecos(FEstruturaDigitando, strTabelaPreco, strEntregaFutura, strEmpresaItem, fCalcAlqIcms);
end;

procedure TFatDigitacaoEstruturaVidro.pSalvarEstrutura;
begin
  pSalvarEstrutura(FEstruturaDigitandoID);
end;

procedure TFatDigitacaoEstruturaVidro.pSalvarEstrutura(ID: Integer);
Var
  subItens: TSubItensVidro;
begin
  TSubItensVidroManager.pClonarSubItens(FEstruturaDigitando, subItens);
  FEstruturasSalvas.AddOrSetValue(ID, subItens);
end;

{ TSubItensVidroManager }

class function TSubItensVidroManager.fExportToClientDataSet(
  const subItens: TSubItensVidro): TUniClientDataSet;
  Var
    subItem: TSubItemVidro;
begin
  Result := TUniClientDataSet.Create(nil);

  Result.FieldDefs.Add('autoincrem',             ftAutoInc);
  Result.FieldDefs.Add('codigo',                 ftString, fTamCodIte);
  Result.FieldDefs.Add('descricao',              ftString, 100);
  Result.FieldDefs.Add('descricaocompleta',      ftString, 255);
  Result.FieldDefs.Add('referencia',             ftString, 050);
  Result.FieldDefs.Add('unidade',                ftString, 005);
  Result.FieldDefs.Add('siglaunidade',           ftString, 005);
  Result.FieldDefs.Add('usametragem',            ftString, 001);
  Result.FieldDefs.Add('importacaodireta',       ftString, 001);
  Result.FieldDefs.Add('tabelapreco',            ftString, 001);
  Result.FieldDefs.Add('entregafutura',          ftString, 001);
  Result.FieldDefs.Add('ativo',                  ftString, 001);
  Result.FieldDefs.Add('itemfracionario',        ftString, 001);
  Result.FieldDefs.Add('databalanco',            ftDate);
  Result.FieldDefs.Add('quantidade',             ftFloat);
  Result.FieldDefs.Add('largura',                ftFloat);
  Result.FieldDefs.Add('altura',                 ftFloat);
  Result.FieldDefs.Add('aream2',                 ftFloat);
  Result.FieldDefs.Add('quantidadevenda',        ftFloat);
  Result.FieldDefs.Add('precodigitado',          ftFloat);
  Result.FieldDefs.Add('precovenda',             ftFloat);
  Result.FieldDefs.Add('precocusto',             ftFloat);
  Result.FieldDefs.Add('precocustoreal',         ftFloat);
  Result.FieldDefs.Add('precovenda1',            ftFloat);
  Result.FieldDefs.Add('precovenda2',            ftFloat);
  Result.FieldDefs.Add('precovenda3',            ftFloat);
  Result.FieldDefs.Add('precovenda4',            ftFloat);
  Result.FieldDefs.Add('precovenda5',            ftFloat);
  Result.FieldDefs.Add('precovenda6',            ftFloat);
  Result.FieldDefs.Add('precovenda7',            ftFloat);
  Result.FieldDefs.Add('outrosvalores',          ftFloat);
  Result.FieldDefs.Add('icmssaida',              ftFloat);
  Result.FieldDefs.Add('impostosfederais',       ftFloat);
  Result.FieldDefs.Add('despesasoperacionais',   ftFloat);
  Result.FieldDefs.Add('precoultimacompra',      ftFloat);
  Result.FieldDefs.Add('precoultimacomimpostos', ftFloat);
  Result.FieldDefs.Add('precocompraliquido',     ftFloat);
  Result.FieldDefs.Add('precomedio',             ftFloat);
  Result.FieldDefs.Add('complemento',            ftString, 005);

  //Totalizadores
  Result.FieldDefs.Add('precocustototal',             ftFloat);
  Result.FieldDefs.Add('precocustorealtotal',         ftFloat);
  Result.FieldDefs.Add('outrosvalorestotal',          ftFloat);
  Result.FieldDefs.Add('icmssaidatotal',              ftFloat);
  Result.FieldDefs.Add('impostosfederaistotal',       ftFloat);
  Result.FieldDefs.Add('despesasoperacionaistotal',   ftFloat);
  Result.FieldDefs.Add('precoultimacompratotal',      ftFloat);
  Result.FieldDefs.Add('precoultimacomimpostostotal', ftFloat);
  Result.FieldDefs.Add('precocompraliquidototal',     ftFloat);
  Result.FieldDefs.Add('precomediototal',             ftFloat);
  Result.FieldDefs.Add('precotabelatotal',            ftFloat);
  Result.FieldDefs.Add('precovendatotal',             ftFloat);
  Result.FieldDefs.Add('precovenda1total',            ftFloat);
  Result.FieldDefs.Add('precovenda2total',            ftFloat);
  Result.FieldDefs.Add('precovenda3total',            ftFloat);
  Result.FieldDefs.Add('precovenda4total',            ftFloat);
  Result.FieldDefs.Add('precovenda5total',            ftFloat);
  Result.FieldDefs.Add('precovenda6total',            ftFloat);
  Result.FieldDefs.Add('precovenda7total',            ftFloat);

  Result.CreateDataSet;
  Result.Open;

  For subItem In subItens.Items Do
  Begin
    pAddSubItemClientDataSet(subItem, Result);
  End;

end;

class function TSubItensVidroManager.fLoadFromClientDataSet(
  const cdsItens: TUniClientDataSet): TSubItensVidro;
  Var
    subItem: TSubItemVidro;
    intRecNo: Integer;
    prcScroll: TprcScroll;
begin
  intRecNo := cdsItens.RecNo;

  Try
    pDisableControls(cdsItens, prcScroll);

    Result := TSubItensVidro.Create;
    SetLength(Result.FItems, 0);
    cdsItens.First;

    While Not cdsItens.Eof Do
    Begin
      subItem.strCodigo                 := cdsItens.FieldByName('codigo').AsString;
      subItem.strDescricao              := cdsItens.FieldByName('descricao').AsString;
      subItem.strReferencia             := cdsItens.FieldByName('referencia').AsString;
      subItem.strUnidade                := cdsItens.FieldByName('unidade').AsString;
      subItem.strSiglaUnidade           := cdsItens.FieldByName('siglaunidade').AsString;
      subItem.strUsaMetragem            := cdsItens.FieldByName('usametragem').AsString;
      subItem.strItemFracionario        := cdsItens.FieldByName('itemfracionario').AsString;
      subItem.strImportacaoDireta       := cdsItens.FieldByName('importacaodireta').AsString;
      subItem.strAtivo                  := cdsItens.FieldByName('ativo').AsString;
      subItem.dtaDataBalanco            := cdsItens.FieldByName('databalanco').AsDateTime;
      subItem.strTabelaPreco            := cdsItens.FieldByName('tabelapreco').AsString;
      subItem.strEntregaFutura          := cdsItens.FieldByName('entregafutura').AsString;

      subItem.fltPrecoCusto             := cdsItens.FieldByName('precocusto').AsFloat;
      subItem.fltPrecoCustoReal         := cdsItens.FieldByName('precocustoreal').AsFloat;

      subItem.fltQuantidade             := cdsItens.FieldByName('quantidade').AsFloat;
      subItem.fltLargura                := cdsItens.FieldByName('largura').AsFloat;
      subItem.fltAltura                 := cdsItens.FieldByName('altura').AsFloat;
      subItem.fltAreaM2                 := cdsItens.FieldByName('aream2').AsFloat;
      subItem.fltQuantidadeVenda        := cdsItens.FieldByName('quantidadevenda').AsFloat;

      subItem.fltPrecoDigitado          := cdsItens.FieldByName('precodigitado').AsFloat;
      subItem.fltPrecoVenda             := cdsItens.FieldByName('precovenda').AsFloat;
      subItem.fltPrecoVenda1            := cdsItens.FieldByName('precovenda1').AsFloat;
      subItem.fltPrecoVenda2            := cdsItens.FieldByName('precovenda2').AsFloat;
      subItem.fltPrecoVenda3            := cdsItens.FieldByName('precovenda3').AsFloat;
      subItem.fltPrecoVenda4            := cdsItens.FieldByName('precovenda4').AsFloat;
      subItem.fltPrecoVenda5            := cdsItens.FieldByName('precovenda5').AsFloat;
      subItem.fltPrecoVenda6            := cdsItens.FieldByName('precovenda6').AsFloat;
      subItem.fltPrecoVenda7            := cdsItens.FieldByName('precovenda7').AsFloat;

      subItem.fltOutrosValores          := cdsItens.FieldByName('outrosvalores').AsFloat;
      subItem.fltIcmsSaida              := cdsItens.FieldByName('icmssaida').AsFloat;
      subItem.fltImpostosFederais       := cdsItens.FieldByName('impostosfederais').AsFloat;
      subItem.fltDespesasOperacionais   := cdsItens.FieldByName('despesasoperacionais').AsFloat;
      subItem.fltPrecoUltimaCompra      := cdsItens.FieldByName('precoultimacompra').AsFloat;
      subItem.fltPrecoUltimaComImpostos := cdsItens.FieldByName('precoultimacomimpostos').AsFloat;
      subItem.fltPrecoCompraLiquido     := cdsItens.FieldByName('precocompraliquido').AsFloat;
      subItem.fltPrecoMedio             := cdsItens.FieldByName('precomedio').AsFloat;

      subItem.ComplementoVidro.pCarregarComplemento(cdsItens.FieldByName('complemento').AsString);

      //Totalizadores
      With subItem.ValoresTotais Do
      Begin
        fltPrecoCustoTotal              := cdsItens.FieldByName('precocustototal').AsFloat;
        fltPrecoCustoRealTotal          := cdsItens.FieldByName('precocustorealtotal').AsFloat;
        fltOutrosValoresTotal           := cdsItens.FieldByName('outrosvalorestotal').AsFloat;
        fltIcmsSaidaTotal               := cdsItens.FieldByName('icmssaidatotal').AsFloat;
        fltImpostosFederaisTotal        := cdsItens.FieldByName('impostosfederaistotal').AsFloat;
        fltDespesasOperacionaisTotal    := cdsItens.FieldByName('despesasoperacionaistotal').AsFloat;
        fltPrecoUltimaCompraTotal       := cdsItens.FieldByName('precoultimacompratotal').AsFloat;
        fltPrecoUltimaComImpostosTotal  := cdsItens.FieldByName('precoultimacomimpostostotal').AsFloat;
        fltPrecoCompraLiquidoTotal      := cdsItens.FieldByName('precocompraliquidototal').AsFloat;
        fltPrecoMedioTotal              := cdsItens.FieldByName('precomediototal').AsFloat;
        fltPrecoTabelaTotal             := cdsItens.FieldByName('precotabelatotal').AsFloat;
        fltPrecoVendaTotal              := cdsItens.FieldByName('precovendatotal').AsFloat;
        fltPrecoVenda1Total             := cdsItens.FieldByName('precovenda1total').AsFloat;
        fltPrecoVenda2Total             := cdsItens.FieldByName('precovenda2total').AsFloat;
        fltPrecoVenda3Total             := cdsItens.FieldByName('precovenda3total').AsFloat;
        fltPrecoVenda4Total             := cdsItens.FieldByName('precovenda4total').AsFloat;
        fltPrecoVenda5Total             := cdsItens.FieldByName('precovenda5total').AsFloat;
        fltPrecoVenda6Total             := cdsItens.FieldByName('precovenda6total').AsFloat;
        fltPrecoVenda7Total             := cdsItens.FieldByName('precovenda7total').AsFloat;
      End;

      SetLength(Result.FItems, Length(Result.Items) + 1);
      Result.Items[Length(Result.Items) - 1] := subItem;

      cdsItens.Next;
    End;

    cdsItens.First;
  Finally
    cdsItens.RecNo := intRecNo;
    pEnableControls(cdsItens, prcScroll);
  End;

end;

class procedure TSubItensVidroManager.pAcertarPrecos(
  var subItens: TSubItensVidro; const fltTotalEstrutura: Double);
  Var
    intItem: Integer;
    fltTotalEstruturaAtual: Double;
    fltFatorPreco: Double;
begin
  fltTotalEstruturaAtual := fCalcularTotais(subItens).fltPrecoVendaTotal;

  For intItem := Low(subItens.Items) To High(subItens.Items) Do
  Begin
    With subItens.Items[intItem], ValoresTotais Do
    Begin
      pCalcularValores;

      fltFatorPreco      := fltPrecoVendaTotal / fltTotalEstruturaAtual;
      fltPrecoVendaTotal := fltTotalEstrutura * fltFatorPreco;
      fltPrecoVenda      := fltPrecoVendaTotal / fltQuantidadeVenda;

      blnManterPrecoVenda := True;
      pCalcularValores;
    End;
  End;

end;

class procedure TSubItensVidroManager.pAddSubItemClientDataSet(
  const subItem: TSubItemVidro; var cdsItens: TUniClientDataSet;
  blnAlter: Boolean = False);
begin
  If blnAlter Then cdsItens.Edit Else cdsItens.Append;

  cdsItens.FieldByName('codigo').AsString                := subItem.strCodigo;
  cdsItens.FieldByName('descricao').AsString             := subItem.strDescricao;
  cdsItens.FieldByName('descricaocompleta').AsString     := subItem.fGetDescricaoCompleta;
  cdsItens.FieldByName('referencia').AsString            := subItem.strReferencia;
  cdsItens.FieldByName('unidade').AsString               := subItem.strUnidade;
  cdsItens.FieldByName('siglaunidade').AsString          := subItem.strSiglaUnidade;
  cdsItens.FieldByName('usametragem').AsString           := subItem.strUsaMetragem;
  cdsItens.FieldByName('itemfracionario').AsString       := subItem.strItemFracionario;
  cdsItens.FieldByName('importacaodireta').AsString      := subItem.strImportacaoDireta;
  cdsItens.FieldByName('ativo').AsString                 := subItem.strAtivo;
  cdsItens.FieldByName('databalanco').AsDateTime         := subItem.dtaDataBalanco;
  cdsItens.FieldByName('tabelapreco').AsString           := subItem.strTabelaPreco;
  cdsItens.FieldByName('entregafutura').AsString         := subItem.strEntregaFutura;

  cdsItens.FieldByName('precocusto').AsFloat             := subItem.fltPrecoCusto;
  cdsItens.FieldByName('precocustoreal').AsFloat         := subItem.fltPrecoCustoReal;

  cdsItens.FieldByName('quantidade').AsFloat             := subItem.fltQuantidade;
  cdsItens.FieldByName('largura').AsFloat                := subItem.fltLargura;
  cdsItens.FieldByName('altura').AsFloat                 := subItem.fltAltura;
  cdsItens.FieldByName('aream2').AsFloat                 := subItem.fltAreaM2;
  cdsItens.FieldByName('quantidadevenda').AsFloat        := subItem.fltQuantidadeVenda;

  cdsItens.FieldByName('precodigitado').Value            := IIF(subItem.fltPrecoDigitado = 0, Null, subItem.fltPrecoDigitado);
  cdsItens.FieldByName('precovenda').AsFloat             := subItem.fltPrecoVenda;
  cdsItens.FieldByName('precovenda1').AsFloat            := subItem.fltPrecoVenda1;
  cdsItens.FieldByName('precovenda2').AsFloat            := subItem.fltPrecoVenda2;
  cdsItens.FieldByName('precovenda3').AsFloat            := subItem.fltPrecoVenda3;
  cdsItens.FieldByName('precovenda4').AsFloat            := subItem.fltPrecoVenda4;
  cdsItens.FieldByName('precovenda5').AsFloat            := subItem.fltPrecoVenda5;
  cdsItens.FieldByName('precovenda6').AsFloat            := subItem.fltPrecoVenda6;
  cdsItens.FieldByName('precovenda7').AsFloat            := subItem.fltPrecoVenda7;

  cdsItens.FieldByName('outrosvalores').AsFloat          := subItem.fltOutrosValores;
  cdsItens.FieldByName('icmssaida').AsFloat              := subItem.fltIcmsSaida;
  cdsItens.FieldByName('impostosfederais').AsFloat       := subItem.fltImpostosFederais;
  cdsItens.FieldByName('despesasoperacionais').AsFloat   := subItem.fltDespesasOperacionais;
  cdsItens.FieldByName('precoultimacompra').AsFloat      := subItem.fltPrecoUltimaCompra;
  cdsItens.FieldByName('precoultimacomimpostos').AsFloat := subItem.fltPrecoUltimaComImpostos;
  cdsItens.FieldByName('precocompraliquido').AsFloat     := subItem.fltPrecoCompraLiquido;
  cdsItens.FieldByName('precomedio').AsFloat             := subItem.fltPrecoMedio;

  cdsItens.FieldByName('complemento').AsString           := subItem.ComplementoVidro.strCodigo;

  //Totalizadores
  With subItem.ValoresTotais Do
  Begin
    cdsItens.FieldByName('precocustototal').AsFloat             := fltPrecoCustoTotal;
    cdsItens.FieldByName('precocustorealtotal').AsFloat         := fltPrecoCustoRealTotal;
    cdsItens.FieldByName('outrosvalorestotal').AsFloat          := fltOutrosValoresTotal;
    cdsItens.FieldByName('icmssaidatotal').AsFloat              := fltIcmsSaidaTotal;
    cdsItens.FieldByName('impostosfederaistotal').AsFloat       := fltImpostosFederaisTotal;
    cdsItens.FieldByName('despesasoperacionaistotal').AsFloat   := fltDespesasOperacionaisTotal;
    cdsItens.FieldByName('precoultimacompratotal').AsFloat      := fltPrecoUltimaCompraTotal;
    cdsItens.FieldByName('precoultimacomimpostostotal').AsFloat := fltPrecoUltimaComImpostosTotal;
    cdsItens.FieldByName('precocompraliquidototal').AsFloat     := fltPrecoCompraLiquidoTotal;
    cdsItens.FieldByName('precomediototal').AsFloat             := fltPrecoMedioTotal;
    cdsItens.FieldByName('precotabelatotal').AsFloat            := fltPrecoTabelaTotal;
    cdsItens.FieldByName('precovendatotal').AsFloat             := fltPrecoVendaTotal;
    cdsItens.FieldByName('precovenda1total').AsFloat            := fltPrecoVenda1Total;
    cdsItens.FieldByName('precovenda2total').AsFloat            := fltPrecoVenda2Total;
    cdsItens.FieldByName('precovenda3total').AsFloat            := fltPrecoVenda3Total;
    cdsItens.FieldByName('precovenda4total').AsFloat            := fltPrecoVenda4Total;
    cdsItens.FieldByName('precovenda5total').AsFloat            := fltPrecoVenda5Total;
    cdsItens.FieldByName('precovenda6total').AsFloat            := fltPrecoVenda6Total;
    cdsItens.FieldByName('precovenda7total').AsFloat            := fltPrecoVenda7Total;
  End;

  cdsItens.Post;
end;

class function TSubItensVidroManager.fCalcularTotais(const subItens: TSubItensVidro): TSubItemVidroTotais;
  Var
    subItem: TSubItemVidro;
begin
  FillChar(Result, SizeOf(Result), #0);

  For subItem In subItens.Items Do
    With subItem.ValoresTotais Do
    Begin
      subItem.pCalcularValores;
      Result.fltPrecoCustoTotal              := Result.fltPrecoCustoTotal             + fltPrecoCustoTotal;
      Result.fltPrecoCustoRealTotal          := Result.fltPrecoCustoRealTotal         + fltPrecoCustoRealTotal;
      Result.fltOutrosValoresTotal           := Result.fltOutrosValoresTotal          + fltOutrosValoresTotal;
      Result.fltIcmsSaidaTotal               := Result.fltIcmsSaidaTotal              + fltIcmsSaidaTotal;
      Result.fltImpostosFederaisTotal        := Result.fltImpostosFederaisTotal       + fltImpostosFederaisTotal;
      Result.fltDespesasOperacionaisTotal    := Result.fltDespesasOperacionaisTotal   + fltDespesasOperacionaisTotal;
      Result.fltPrecoUltimaCompraTotal       := Result.fltPrecoUltimaCompraTotal      + fltPrecoUltimaCompraTotal;
      Result.fltPrecoUltimaComImpostosTotal  := Result.fltPrecoUltimaComImpostosTotal + fltPrecoUltimaComImpostosTotal;
      Result.fltPrecoCompraLiquidoTotal      := Result.fltPrecoCompraLiquidoTotal     + fltPrecoCompraLiquidoTotal;
      Result.fltPrecoMedioTotal              := Result.fltPrecoMedioTotal             + fltPrecoMedioTotal;
      Result.fltPrecoTabelaTotal             := Result.fltPrecoTabelaTotal            + fltPrecoTabelaTotal;
      Result.fltPrecoVendaTotal              := Result.fltPrecoVendaTotal             + fltPrecoVendaTotal;
      Result.fltPrecoVenda1Total             := Result.fltPrecoVenda1Total            + fltPrecoVenda1Total;
      Result.fltPrecoVenda2Total             := Result.fltPrecoVenda2Total            + fltPrecoVenda2Total;
      Result.fltPrecoVenda3Total             := Result.fltPrecoVenda3Total            + fltPrecoVenda3Total;
      Result.fltPrecoVenda4Total             := Result.fltPrecoVenda4Total            + fltPrecoVenda4Total;
      Result.fltPrecoVenda5Total             := Result.fltPrecoVenda5Total            + fltPrecoVenda5Total;
      Result.fltPrecoVenda6Total             := Result.fltPrecoVenda6Total            + fltPrecoVenda6Total;
      Result.fltPrecoVenda7Total             := Result.fltPrecoVenda7Total            + fltPrecoVenda7Total;
    End;

end;

class procedure TSubItensVidroManager.pClonarSubItens(
  const subItensOri: TSubItensVidro; var subItensDes: TSubItensVidro);
  Var
    intIndex: Integer;
begin
  subItensDes := TSubItensVidro.Create;
  SetLength(subItensDes.FItems, Length(subItensOri.Items));
  For intIndex := Low(subItensOri.Items) to High(subItensOri.Items) do
    subItensDes.Items[intIndex] := subItensOri.Items[intIndex];
end;

class procedure TSubItensVidroManager.pRecalcularPrecos(
  var subItens: TSubItensVidro; const strTabPre, strEntFut,
  strEmpIte: String; fCalcAlqIcms: TFuncCalcAlqIcms);
  Var
    intItem: Integer;
begin
  For intItem := Low(subItens.Items) To High(subItens.Items) Do
  Begin
    subItens.Items[intItem].strTabelaPreco   := strTabPre;
    subItens.Items[intItem].strEntregaFutura := strEntFut;

    If Assigned(fCalcAlqIcms) And fCfgSis('IMPCF4', VarBoolean) Then
      subItens.Items[intItem].fltIcmsSaida :=
        fCalcAlqIcms(subItens.Items[intItem].strCodigo, strEmpIte,
                     subItens.Items[intItem].strImportacaoDireta,
                     subItens.Items[intItem].strEntregaFutura);

    subItens.Items[intItem].pCalcularValores;
  End;
end;

class procedure TSubItensVidroManager.pGravarSubItensPedOrc(
  const subItens: TSubItensVidro; strAutIncFatDor: String);
  Var
    subItem: TSubItemVidro;
    qryOrcVid: TUniQuery;
begin
  qryOrcVid := fCriaQuery();

  qryOrcVid.Close;
  qryOrcVid.SQL.Add('SELECT * FROM ORCVID WHERE FALSE');
  qryOrcVid.Open;

  For subItem In subItens.Items Do
  Begin
    qryOrcVid.Append;

    qryOrcVid.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ORCVID', VS_strCodEmp);
    qryOrcVid.FieldByName('VID_SEQGER').AsString := strAutIncFatDor;
    qryOrcVid.FieldByName('VID_CODITE').AsString := subItem.strCodigo;
    qryOrcVid.FieldByName('VID_QTDITE').AsFloat  := subItem.fltQuantidade;
    qryOrcVid.FieldByName('VID_LARGUR').AsFloat  := subItem.fltLargura;
    qryOrcVid.FieldByName('VID_ALTURA').AsFloat  := subItem.fltAltura;
    qryOrcVid.FieldByName('VID_AREAM2').AsFloat  := subItem.fltAreaM2;
    qryOrcVid.FieldByName('VID_PREDIG').Value    := IIF(subItem.fltPrecoDigitado = 0, Null, subItem.fltPrecoDigitado);

    If Not fEmptyStr(subItem.ComplementoVidro.strCodigo) Then
      qryOrcVid.FieldByName('VID_CODCPL').AsString := subItem.ComplementoVidro.strCodigo;

    qryOrcVid.Post;
  End;

  qryOrcVid.Close;
  FreeAndNil(qryOrcVid);
end;

class procedure TSubItensVidroManager.pCarregarSubItensPedOrc(
  var subItens: TSubItensVidro; strAutIncFatDor: String);
  Var
    subItem: TSubItemVidro;
    qryOrcVid: TUniQuery;
begin
  subItens := TSubItensVidro.Create;
  SetLength(subItens.FItems, 0);

  qryOrcVid := fCriaQuery();

  qryOrcVid.Close;

  qryOrcVid.SQL.Add('SELECT ORCVID.*, FDO_TABPRE, FDO_ENTFUT FROM FATDOR ' +
                    'INNER JOIN ORCVID ON FATDOR.AUTOINCREM = VID_SEQGER ' +
                    'WHERE FATDOR.AUTOINCREM = :AUTINC');

  qryOrcVid.ParamByName('AUTINC').AsString := strAutIncFatDor;
  qryOrcVid.Open;

  qryOrcVid.First;

  While Not qryOrcVid.Eof Do
  Begin
    subItem.pCarregarProduto(qryOrcVid.FieldByName('VID_CODITE').AsString);

    subItem.strTabelaPreco   := qryOrcVid.FieldByName('FDO_TABPRE').AsString;
    subItem.strEntregaFutura := qryOrcVid.FieldByName('FDO_ENTFUT').AsString;
    subItem.fltQuantidade    := qryOrcVid.FieldByName('VID_QTDITE').AsFloat;
    subItem.fltLargura       := qryOrcVid.FieldByName('VID_LARGUR').AsFloat;
    subItem.fltAltura        := qryOrcVid.FieldByName('VID_ALTURA').AsFloat;
    subItem.fltPrecoDigitado := qryOrcVid.FieldByName('VID_PREDIG').AsFloat;

    subItem.ComplementoVidro.pCarregarComplemento(qryOrcVid.FieldByName('VID_CODCPL').AsString);

    subItem.pCalcularValores;

    SetLength(subItens.FItems, Length(subItens.Items) + 1);
    subItens.Items[Length(subItens.Items) -1] := subItem;

    qryOrcVid.Next;
  End;

  qryOrcVid.Close;
  FreeAndNil(qryOrcVid);
end;

{ TSubItemVidro }

function TSubItemVidro.fGetDescricaoCompleta: String;
begin
  Result := strDescricao + ' ' +
    ComplementoVidro.strCodigo + ' ' + ComplementoVidro.strDescricao;
end;

function TSubItemVidro.fGetPrecoTabela: Double;
begin
  If fEmptyStr(strTabelaPreco) Then
    strTabelaPreco := '1';

  Case strTabelaPreco[1] Of
    '1' : Result := fltPrecoVenda1;
    '2' : Result := fltPrecoVenda2;
    '3' : Result := fltPrecoVenda3;
    '4' : Result := fltPrecoVenda4;
    '5' : Result := fltPrecoVenda5;
    '6' : Result := fltPrecoVenda6;
    '7' : Result := fltPrecoVenda7;
    Else  Result := fltPrecoVenda1;
  end;

  Result := Result * ComplementoVidro.fltFatorVenda;
end;

procedure TSubItemVidro.pCalcularValores;
  Var
    parPreCus: TParCalculaPrecoCusto;
begin
  fltAreaM2 := 0.0;

  If strUsaMetragem = 'S' Then
    fltAreaM2 := fFormataFloat(fCalculaQuantidadeMetrosCubicos(fltQuantidade,
      fltAltura, fltLargura, 1.0, strSiglaUnidade), fCfgSis('DECQTD', varInteger));

  If fEmptyStr(strTabelaPreco) Then
    strTabelaPreco := '1';

  If fEmptyStr(strEntregaFutura) Then
    strEntregaFutura := 'N';

  If fEmptyStr(ComplementoVidro.strCodigo) Then
  Begin
    ComplementoVidro.fltFatorCusto := 1;
    ComplementoVidro.fltFatorVenda := 1;
  End;

  If Not blnManterPrecoVenda Then
  Begin
    fltPrecoVenda := fGetPrecoTabela;

    If fltPrecoDigitado <> 0 Then
      fltPrecoVenda := fltPrecoDigitado;
  End;

  If strUsaMetragem = 'S' Then
    fltQuantidadeVenda :=  fltAreaM2
  Else
    fltQuantidadeVenda :=  fltQuantidade;

  parPreCus := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao);

  fltPrecoCustoReal := parPreCus.fCalculaPrecoCustoRealVenda(fltPrecoVenda,
    (fltPrecoCusto * ComplementoVidro.fltFatorCusto), fltOutrosValores, fltIcmsSaida,
    fltImpostosFederais, fltDespesasOperacionais, 0, 0);

  FreeAndNil(parPreCus);

  //Totalizadores
  With ValoresTotais, ComplementoVidro Do
  Begin
    fltPrecoVendaTotal             := fltQuantidadeVenda * fltPrecoVenda;
    fltPrecoTabelaTotal            := fltQuantidadeVenda * fGetPrecoTabela;

    fltPrecoVenda1Total            := fltQuantidadeVenda * fltPrecoVenda1  * fltFatorVenda;
    fltPrecoVenda2Total            := fltQuantidadeVenda * fltPrecoVenda2  * fltFatorVenda;
    fltPrecoVenda3Total            := fltQuantidadeVenda * fltPrecoVenda3  * fltFatorVenda;
    fltPrecoVenda4Total            := fltQuantidadeVenda * fltPrecoVenda4  * fltFatorVenda;
    fltPrecoVenda5Total            := fltQuantidadeVenda * fltPrecoVenda5  * fltFatorVenda;
    fltPrecoVenda6Total            := fltQuantidadeVenda * fltPrecoVenda6  * fltFatorVenda;
    fltPrecoVenda7Total            := fltQuantidadeVenda * fltPrecoVenda7  * fltFatorVenda;
    fltPrecoCustoTotal             := fltQuantidadeVenda * fltPrecoCusto   * fltFatorCusto;

    fltPrecoCustoRealTotal         := fltQuantidadeVenda * fltPrecoCustoReal;
    fltOutrosValoresTotal          := fltQuantidadeVenda * fltOutrosValores;
    fltIcmsSaidaTotal              := fltPrecoVendaTotal * fltIcmsSaida / 100;
    fltImpostosFederaisTotal       := fltPrecoVendaTotal * fltImpostosFederais / 100;
    fltDespesasOperacionaisTotal   := fltPrecoVendaTotal * fltDespesasOperacionais / 100;
    fltPrecoUltimaCompraTotal      := fltQuantidadeVenda * fltPrecoUltimaCompra;
    fltPrecoUltimaComImpostosTotal := fltQuantidadeVenda * fltPrecoUltimaComImpostos;
    fltPrecoCompraLiquidoTotal     := fltQuantidadeVenda * fltPrecoCompraLiquido;
    fltPrecoMedioTotal             := fltQuantidadeVenda * fltPrecoMedio;
  End;

end;

procedure TSubItemVidro.pCarregarProduto(strCodIte: String);
  Var
    qryItem: TUniQuery;

  function fPrecoCompraLiquido: String;
  Begin
    Result := '';

    Result := Result + '  I.ITE_PRECOM * ';
    Result := Result + '            (1 - I.ITE_DESF01 / 100) * ';
    Result := Result + '            (1 - I.ITE_DESF02 / 100) * ';
    Result := Result + '            (1 - I.ITE_DESF03 / 100) * ';
    Result := Result + '            (1 - I.ITE_DESF04 / 100) * ';
    Result := Result + '            (1 - I.ITE_DESF05 / 100) * ';
    Result := Result + '            (1 - I.ITE_DESF06 / 100)   ';
  End;

begin
  If (strCodIte <> Self.strCodigo) Then
  Begin
    FillChar(Self, SizeOf(Self), #0);

    qryItem := fCriaQuery;

    With qryItem, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT ');
      Add('  C.ITE_CODITE AS "codigo", ');
      Add('  C.ITE_DESITE AS "descricao", ');
      Add('  C.ITE_REFERE AS "referencia", ');
      Add('  C.ITE_CODUNI AS "unidade", ');
      Add('  U.UNI_SIGUNI AS "siglaunidade", ');
      Add('  U.UNI_METFAT AS "usametragem", ');
      Add('  U.UNI_ITEFRA AS "itemfracionario", ');
      Add('  C.ITE_ITEATI AS "ativo", ');
      Add('  I.ITE_DTABAL AS "databalanco", ');
      Add('  I.ITE_PRECUS AS "precocusto", ');
      Add('  I.ITE_PREVE1 AS "precovenda1", ');
      Add('  I.ITE_PREVE2 AS "precovenda2", ');
      Add('  I.ITE_PREVE3 AS "precovenda3", ');
      Add('  I.ITE_PREVE4 AS "precovenda4", ');
      Add('  I.ITE_PREVE5 AS "precovenda5", ');
      Add('  I.ITE_PREVE6 AS "precovenda6", ');
      Add('  I.ITE_PREVE7 AS "precovenda7", ');

      If fCfgSis('IMPDIG') = '1' Then
        Add('  C.ITE_IMPDIR AS importacaodireta, ')
      Else
        Add('  I.ITE_IMPDIR AS importacaodireta, ');

      Add('  I.ITE_OUTVAL AS outrosvalores, ');
      Add('  I.ITE_ICMSAI AS icmssaida, ');
      Add('  I.ITE_IMPFED AS impostosfederais, ');
      Add('  I.ITE_DESOPE AS despesasoperacionais, ');

      Add('  I.ITE_PREULT AS precoultimacompra, ');
      Add('  I.ITE_IMPULT AS precoultimacomimpostos, ');
      Add('  I.ITE_PREMED AS precomedio, ');

      //Foi feito dessa forma por causa do arredondamento do MySQL (tem um bug)
      Add(fRoundSql(fPrecoCompraLiquido, fCfgSis('DECUNI')) + ' AS precocompraliquido ');

      Add('FROM ');
      Add('  CADITE C ');
      Add('  INNER JOIN ITEGER I ON C.ITE_CODITE = I.ITE_CODITE AND ');
      Add('                         I.ITE_CODEMP = :CODEMP ');
      Add('  INNER JOIN CADUNI U ON C.ITE_CODUNI = U.UNI_CODUNI ');
      Add('WHERE ');
      Add('  C.ITE_CODITE = :CODITE ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;

      Open;

      Self.strCodigo                 := FieldByName('codigo').AsString;
      Self.strDescricao              := FieldByName('descricao').AsString;
      Self.strReferencia             := FieldByName('referencia').AsString;
      Self.strUnidade                := FieldByName('unidade').AsString;
      Self.strSiglaUnidade           := FieldByName('siglaunidade').AsString;
      Self.strUsaMetragem            := FieldByName('usametragem').AsString;
      Self.strItemFracionario        := FieldByName('itemfracionario').AsString;
      Self.strAtivo                  := FieldByName('ativo').AsString;
      Self.dtaDataBalanco            := FieldByName('databalanco').AsDateTime;
      Self.fltPrecoCusto             := FieldByName('precocusto').AsFloat;
      Self.fltPrecoVenda1            := FieldByName('precovenda1').AsFloat;
      Self.fltPrecoVenda2            := FieldByName('precovenda2').AsFloat;
      Self.fltPrecoVenda3            := FieldByName('precovenda3').AsFloat;
      Self.fltPrecoVenda4            := FieldByName('precovenda4').AsFloat;
      Self.fltPrecoVenda5            := FieldByName('precovenda5').AsFloat;
      Self.fltPrecoVenda6            := FieldByName('precovenda6').AsFloat;
      Self.fltPrecoVenda7            := FieldByName('precovenda7').AsFloat;
      Self.strImportacaoDireta       := FieldByName('importacaodireta').AsString;
      Self.fltOutrosValores          := FieldByName('outrosvalores').AsFloat;
      Self.fltIcmsSaida              := FieldByName('icmssaida').AsFloat;
      Self.fltImpostosFederais       := FieldByName('impostosfederais').AsFloat;
      Self.fltDespesasOperacionais   := FieldByName('despesasoperacionais').AsFloat;
      Self.fltPrecoUltimaCompra      := FieldByName('precoultimacompra').AsFloat;
      Self.fltPrecoUltimaComImpostos := FieldByName('precoultimacomimpostos').AsFloat;
      Self.fltPrecoCompraLiquido     := FieldByName('precocompraliquido').AsFloat;
      Self.fltPrecoMedio             := FieldByName('precomedio').AsFloat;
      Self.blnManterPrecoVenda       := False;
      Self.fltPrecoDigitado          := 0;
      Self.ComplementoVidro.pCarregarComplemento('');
      Close;
    End;

    FreeAndNil(qryItem);
  End;

end;

{ TComplementoVidro }

procedure TComplementoVidro.pCarregarComplemento(strCodCom: String);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();

  With qryGen, SQL Do
  Begin
    Add('SELECT * FROM CADCPL WHERE CPL_CODIGO = :CODIGO');
    ParamByName('CODIGO').AsString := strCodCom;
    Open;

    strCodigo     := FieldByName('CPL_CODIGO').AsString;
    strDescricao  := FieldByName('CPL_DESCRI').AsString;
    fltFatorCusto := FieldByName('CPL_FATCUS').AsFloat;
    fltFatorVenda := FieldByName('CPL_FATVEN').AsFloat;

    If fEmptyStr(strCodigo) Then
    Begin
      fltFatorCusto := 1;
      fltFatorVenda := 1;
    End;

    Close;
  End;

  FreeAndNil(qryGen);
end;

{ TSubItensVidro }

class function TSubItensVidro.FromJsonString(AJsonString: string): TSubItensVidro;
begin
  Result := TJson.JsonToObject<TSubItensVidro>(AJsonString);
end;

function TSubItensVidro.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

end.

