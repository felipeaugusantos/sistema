unit untFormulaIndustrial;

interface

uses
  Classes, Uni, SysUtils, untFuncoesSimples, UniClientDataSet,
  untTMatrizSaldosColorantes, Variants, untGenericTintaDeMaquina,
  untCadPro;

type
  TComponenteIndustrial = class;
  TTipoComponenteIndustrial = (tciBase, tciCatalisador, tciColorante);

  TFormulaIndustrial = class abstract(TCollection)
  protected
    strCodigoItemBase: string;
    strCodigoItemBaseOriginal: string;
    strTabPre: string;
    strCodigoBase: string;
    strEmbalagemBase: string;
    strCodigoEmbalagemBase: string;
    strUnidade: string;

    fltVolumeBaseOriginal: Double;
    fltVolumeColorantesOriginal: Double;
    fltVolumeOriginal: Double;

    fltVolumeBase: Double;
    fltVolumeColorantes: Double;
    fltVolume: Double;

    cdsTinta: TUniClientDataSet;
    qryBases: TUniQuery;
    qryEmbalagem: TUniQuery;
    qryComponentes: TUniQuery;

    fltPrecoCustoComponentes: Double;
    fltPrecoCustoRealComponentes: Double;
    fltPrecoVendaComponentes: Double;
    fltOutrosValoresComponentes: Double;
    fltIcmSaidaComponentes: Double;
    fltImpostosFederaisComponentes: Double;
    fltDespesasOperacionaisComponentes: Double;

    fltPrecoMedioComponentes: Double;
    fltPrecoUltimaCompraComponentes: Double;
    fltImpostosUltimaCompraComponentes: Double;
    fltPrecoCompraLiqComponentes: Double;

    fltPrecoCustoBase: Double;
    fltPrecoCustoRealBase: Double;
    fltPrecoVendaBase: Double;
    fltOutrosValoresBase: Double;
    fltIcmSaidaBase: Double;
    fltImpostosFederaisBase: Double;
    fltDespesasOperacionaisBase: Double;
    fltPesoEspecificoBase: Double;

    fltPrecoMedioBase: Double;
    fltPrecoUltimaCompraBase: Double;
    fltImpostosUltimaCompraBase: Double;
    fltPrecoCompraLiqBase: Double;

    fltPrecoCustoEmbalagem: Double;
    fltPrecoCustoRealEmbalagem: Double;
    fltPrecoVendaEmbalagem: Double;
    fltOutrosValoresEmbalagem: Double;
    fltIcmSaidaEmbalagem: Double;
    fltImpostosFederaisEmbalagem: Double;
    fltDespesasOperacionaisEmbalagem: Double;

    fltPrecoMedioEmbalagem: Double;
    fltPrecoUltimaCompraEmbalagem: Double;
    fltImpostosUltimaCompraEmbalagem: Double;
    fltPrecoCompraLiqEmbalagem: Double;

    blnUsaCatalisador: Boolean;
    blnPersonalizada: Boolean;

    FtintaDeMaquina: TGenericTintaDeMaquina;

    FPromoc: String;

    FBlnCalculaUnitario: Boolean;

    FCodCli: String;
    FCodCnd: String;
    FPrzMed: Integer;
  private
    function GetDespesasOperacionais: Double;
    function GetIcmSaida: Double;
    function GetImpostosFederais: Double;
    function GetOutrosValores: Double;
    function GetPrecoCusto: Double;
    function GetPrecoCustoReal: Double;
    function GetPrecoVenda: Double;

    function GetPrecoMedio: Double;
    function GetPrecoUltimaCompra: Double;
    function GetImpostosUltimaCompra: Double;
    function GetPrecoCompraLiq: Double;

  protected
    function GetVolumeColorante(): Double;
    function GetVolumeBase(): Double;
    function GetVolumeFinal(): Double;
    procedure SetVolumeFinal(const value: Double);
    function GetTextoCalculo(): string; virtual; abstract;
    function GetDescricao(): String; virtual; abstract;
    procedure CarregarBases; virtual; abstract;
    procedure CarregarEmbalagem; virtual;
    procedure CarregarComponentes; virtual; abstract;
    procedure SetUsaCatalisador(const Value: Boolean);
    function GetTemCatalisador(): Boolean;
    function GetCodigoProdutoEmbalagem(): string; virtual; abstract;
    procedure SetCodigoEmbalagemBase(const Value: string);
    function fTabPreco: String;
    function fCalculaPrecoCusto2(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe: Double): Double;
  public
    constructor Create(const strTabPre: string; const cdsTinta: TUniClientDataSet); reintroduce; virtual;
    destructor Destroy; override;
    procedure CarregarPrecos; virtual; abstract;
    procedure CarregarPrecosBases; overload; virtual; abstract;
    procedure CarregarPrecosBasesEmbalagem(const strCodigoEmbalagemBase: string);  virtual; abstract;
    procedure CarregarPrecosEmbalagem; virtual;

    procedure CalcularPrecos; virtual; abstract;
    procedure ZerarPrecos;
    procedure pRecalculaTabelas(dicRetorno: TDicionario); virtual;
    procedure pRetornaTabelaPreco(dicRetorno: TDicionario); virtual;
    function GetItemBase(): string;
    procedure SetItemBase(const Value: string); virtual;
    function GetMatrizSaldosColorantes(): TClassMatrizSaldosColorantes;
    procedure GetEmbalagensDisponivels(const dicEmbalagens: TDicionario;
      const dicCodigosEmbalagens: TDicionario; const dicProdutosBase: TDicionario); virtual; abstract;
    function GetCodigoProdutoVendaEmbalagem(): string; virtual; abstract;
  published
  public

    property tintaDeMaquina: TGenericTintaDeMaquina read FtintaDeMaquina;

    property VolumeBase: Double read GetVolumeBase;
    property VolumeColorantes: Double read GetVolumeColorante;
    property VolumeFinal: Double read GetVolumeFinal write SetVolumeFinal;
    property VolumeOriginal: Double read fltVolumeOriginal;

    property ItemBase: string read GetItemBase write SetItemBase;

    property Base: string read strCodigoBase write strCodigoBase;
    property EmbalagemBase: string read strEmbalagemBase write strEmbalagemBase;
    property CodigoEmbalagemBase: string read strCodigoEmbalagemBase write strCodigoEmbalagemBase;
    property Unidade : string read strUnidade write strUnidade;
    property TextoCalculo: string read GetTextoCalculo;
    property Descricao: string read GetDescricao;
    property UsaCatalisador: Boolean read blnUsaCatalisador write SetUsaCatalisador;

    property PrecoCustoComponentes: Double read fltPrecoCustoComponentes;
    property PrecoCustoRealComponentes: Double read fltPrecoCustoRealComponentes;
    property PrecoVendaComponentes: Double read fltPrecoVendaComponentes;
    property OutrosValoresComponentes: Double read fltOutrosValoresComponentes;
    property IcmSaidaComponentes: Double read fltIcmSaidaComponentes;
    property ImpostosFederaisComponentes: Double read fltImpostosFederaisComponentes;
    property DespesasOperacionaisComponentes: Double read fltDespesasOperacionaisComponentes;

    property PrecoMedioComponentes: Double read fltPrecoMedioComponentes;
    property PrecoUltimaCampraComponentes: Double read fltPrecoUltimaCompraComponentes;
    property ImpostosUltimaCompraComponentes: Double read fltImpostosUltimaCompraComponentes;
    property PrecoCompraLiqComponentes: Double read fltPrecoCompraLiqComponentes;

    property PrecoCustoBase: Double read fltPrecoCustoBase;
    property PrecoCustoRealBase: Double read fltPrecoCustoRealBase;
    property PrecoVendaBase: Double read fltPrecoVendaBase;
    property OutrosValoresBase: Double read fltOutrosValoresBase;
    property IcmSaidaBase: Double read fltIcmSaidaBase;
    property ImpostosFederaisBase: Double read fltImpostosFederaisBase;
    property DespesasOperacionaisBase: Double read fltDespesasOperacionaisBase;
    property PesoEspecificoBase: Double read fltPesoEspecificoBase;

    property PrecoMedioBase: Double read fltPrecoMedioBase;
    property PrecoUltimaCompraBase: Double read fltPrecoUltimaCompraBase;
    property ImpostosUltimaCompraBase: Double read fltImpostosUltimaCompraBase;
    property PrecoCompraLiqBase: Double read fltPrecoCompraLiqBase;

    property PrecoCustoEmbalagem: Double read fltPrecoCustoEmbalagem;
    property PrecoCustoRealEmbalagem: Double read fltPrecoCustoRealEmbalagem;
    property PrecoVendaEmbalagem: Double read fltPrecoVendaEmbalagem;
    property OutrosValoresEmbalagem: Double read fltOutrosValoresEmbalagem;
    property IcmSaidaEmbalagem: Double read fltIcmSaidaEmbalagem;
    property ImpostosFederaisEmbalagem: Double read fltImpostosFederaisEmbalagem;
    property DespesasOperacionaisEmbalagem: Double read fltDespesasOperacionaisEmbalagem;

    property PrecoMedioEmbalagem: Double read fltPrecoMedioEmbalagem;
    property PrecoUltimaCompraEmbalagem: Double read fltPrecoUltimaCompraEmbalagem;
    property ImpostosUltimaCompraEmbalagem: Double read fltImpostosUltimaCompraEmbalagem;
    property PrecoCompraLiqEmbalagem: Double read fltPrecoCompraLiqEmbalagem;

    property PrecoCusto: Double read GetPrecoCusto;
    property PrecoCustoReal: Double read GetPrecoCustoReal;
    property PrecoVenda: Double read GetPrecoVenda;
    property OutrosValores: Double read GetOutrosValores;
    property IcmSaida: Double read GetIcmSaida;
    property ImpostosFederais: Double read GetImpostosFederais;
    property DespesasOperacionais: Double read GetDespesasOperacionais;

    property PrecoMedio: Double           read GetPrecoMedio;
    property PrecoUltimaCompra: Double    read GetPrecoUltimaCompra;
    property ImpostosUltimaCompra: Double read GetImpostosUltimaCompra;
    property PrecoCompraLiq: Double       read GetPrecoCompraLiq;

    property TemCatalisador: Boolean read GetTemCatalisador;
    property Personalizada: Boolean read blnPersonalizada write blnPersonalizada;

    property StrPromoc: String read FPromoc;
    property blnCalculaUnitario: Boolean read FBlnCalculaUnitario write FBlnCalculaUnitario;

    property strCodCli: String  Read FCodCli Write FCodCli;
    property strCodCnd: String  Read FCodCnd Write FCodCnd;
    property intPrzMed: Integer Read FPrzMed Write FPrzMed;
  end;

  TComponenteIndustrial = class(TCollectionItem)
  private
    strCodigoComponente: string;
    fltQuantidade: Double;
    fltQuantidadeOriginal: Double;
    fltPrecoCusto: Double;
    fltPrecoVenda: Double;
    fltOutrosValores: Double;
    fltIcmSaida: Double;
    fltImpostosFederais: Double;
    fltDespesasOperacionais: Double;
    fltPesoEspecifico: Double;
    fltEmbalagem: Double;
    tciTipo: TTipoComponenteIndustrial;

    fltPrecoMedio: Double;
    fltUltimaCompra: Double;
    fltImpostosUltimaCompra: Double;
    fltCompraLiquido: Double;
    FPromoc: String;

    procedure SetQuantidade(const value: Double);
    function GetPrecoCustoReal(): Double;
    function fCalculaPrecoCusto2(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe: Double): Double;
  public
    procedure AplicarFator(const fltFator: Double);
    property CodigoComponente: string read strCodigoComponente write strCodigoComponente;
    property Quantidade: Double read fltQuantidade write SetQuantidade;

    property PrecoCusto: Double read fltPrecoCusto write fltPrecoCusto;
    property PrecoCustoReal: Double Read GetPrecoCustoReal;
    property PrecoVenda: Double Read fltPrecoVenda Write fltPrecoVenda;

    property OutrosValores: Double Read fltOutrosValores Write fltOutrosValores;
    property IcmSaida: Double Read fltIcmSaida Write fltIcmSaida;
    property ImpostosFederais: Double Read fltImpostosFederais Write fltImpostosFederais;
    property DespesasOperacionais: Double Read fltDespesasOperacionais Write fltDespesasOperacionais;
    property PesoEspecifico: Double Read fltPesoEspecifico write fltPesoEspecifico;

    property PrecoMedio: Double Read  fltPrecoMedio write fltPrecoMedio;
    property UltimaCompra: Double Read fltUltimaCompra write fltUltimaCompra;
    property ImpostosUltimaCompra: Double Read fltImpostosUltimaCompra write fltImpostosUltimaCompra;
    property CompraLiquido: Double Read fltCompraLiquido write fltCompraLiquido;

    property Embalagem: Double read fltEmbalagem write fltEmbalagem;
    property Tipo: TTipoComponenteIndustrial read tciTipo write tciTipo;
    property StrPromoc: String read FPromoc write FPromoc;
  end;

  function fCarregaPromocao(strCodIte, strTabPre, strCodCli, strCodCnd: String;
    intPrzMed: Integer; var fltPreCus, fltPreVen: Double): Boolean;

  function fTabPreco(strTabPre: String; blnCalculaUnitario: Boolean): String;

  procedure AcertaImpostos(const fltPreCus, fltPreCu2, fltOutVal, fltIcmSai, fltImpFed, fltDesOpe: Extended; dicRetorno: TDicionario);

implementation

uses
  untParCalculaPrecoCusto, untTConfiguracao,  untClientDataSetFactory,
  untFuncoes;

{ TFormulaIndustrial }

procedure TFormulaIndustrial.CarregarEmbalagem;
begin

  qryEmbalagem.Close;
  qryEmbalagem.SQL.Clear;
  qryEmbalagem.SQL.Add(
    ' SELECT         ' +
    '   ITE_CODITE   ' +
    '   , ITE_OUTVAL ' +
    '   , ITE_ICMSAI ' +
    '   , ITE_IMPFED ' +
    '   , ITE_DESOPE ');

  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') And blnCalculaUnitario Then
  begin
    qryEmbalagem.SQL.Add(
      '   , ITE_PRECUS ' +
      '   , ITE_PREVE' + fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ');
  end
  else
  begin
    qryEmbalagem.SQL.Add(
      '   , ITE_PRECUS ' +
      '   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ');
  end;

  qryEmbalagem.SQL.Add(
    ' FROM                       ' +
    '   ITEGER                   ' +
    ' WHERE ITE_CODITE = :CODITE ' +
    '   AND ITE_CODEMP = :CODEMP ');

  qryEmbalagem.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryEmbalagem.ParamByName('CODITE').AsString := GetCodigoProdutoEmbalagem;
end;

procedure TFormulaIndustrial.CarregarPrecosEmbalagem;
var
  cdsGen: TUniClientDataSet;
begin
  Try
    Try
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryEmbalagem);

      Self.fltPrecoCustoEmbalagem := cdsGen.FieldByName('ITE_PRECUS').AsFloat;
      Self.fltPrecoVendaEmbalagem := cdsGen.FieldByName('ITE_PREVEN').AsFloat;

      Self.fltPrecoCustoRealEmbalagem := cdsGen.FieldByName('ITE_PREVEN').AsFloat;
      Self.fltOutrosValoresEmbalagem := cdsGen.FieldByName('ITE_OUTVAL').AsFloat;
      Self.fltIcmSaidaEmbalagem := cdsGen.FieldByName('ITE_ICMSAI').AsFloat;
      Self.fltImpostosFederaisEmbalagem := cdsGen.FieldByName('ITE_IMPFED').AsFloat;
      Self.fltDespesasOperacionaisEmbalagem := cdsGen.FieldByName('ITE_DESOPE').AsFloat;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

constructor TFormulaIndustrial.Create(const strTabPre: string; const cdsTinta: TUniClientDataSet);
begin
  inherited Create(TComponenteIndustrial);
  Self.strTabPre := strTabPre;

  If fEmptyStr(Self.strTabPre) Then
    Self.strTabPre := '1';

  Self.cdsTinta := cdsTinta;
  qryBases := fCriaQuery();
  qryEmbalagem := fCriaQuery();
  qryComponentes := fCriaQuery();

  FtintaDeMaquina := TGenericTintaDeMaquina.Create();

  FPromoc := 'N';
  FBlnCalculaUnitario := True;

  CarregarBases;
  CarregarComponentes;
  CarregarEmbalagem;


  CarregarPrecosBases;
  CarregarPrecosEmbalagem;
  Self.blnPersonalizada := False;
end;

function TFormulaIndustrial.GetMatrizSaldosColorantes(): TClassMatrizSaldosColorantes;
var
  intCont: Integer;
  componente: TComponenteIndustrial;
  fltQtdFormul: Double;
  cdsCadCol: TUniClientDataSet;
  cdsCadBas: TUniClientDataSet;
begin

  Result := TClassMatrizSaldosColorantes.Create;
  cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryComponentes);

  cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryBases);

  For intCont := 0 To Self.Count - 1 Do
  Begin
    componente := TComponenteIndustrial(Self.Items[intCont]);
    if cdsCadCol.Locate('COL_CODCOL', componente.CodigoComponente, []) then
    begin
      fltQtdFormul := componente.Quantidade * cdsCadCol.FieldByName('COL_PESESP').AsFloat;

      If fltQtdFormul > 0 Then
      Begin
        Result.fAdicionar(1, Self.Descricao,
          cdsCadCol.FieldByName('COL_CODITE').AsString,
          fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', cdsCadCol.FieldByName('COL_CODITE').AsString),
          componente.CodigoComponente, fltQtdFormul, COLORANTE,
          'N',  //Peso em gramas base
          0.0); //Embalagem da base
      End;
    end
    else If (componente.Tipo = tciCatalisador) and (Self.TemCatalisador And Self.UsaCatalisador) Then
    Begin
      if cdsCadBas.Locate('BAS_CODBAS;BAS_CODEMB', VarArrayOf([componente.CodigoComponente, strCodigoEmbalagemBase]), []) then
      begin
        fltQtdFormul := componente.Quantidade * cdsCadBas.FieldByName('BAS_PESESP').AsFloat;

        If fltQtdFormul > 0 Then
        Begin
          Result.fAdicionar(1, Self.Descricao,
            cdsCadBas.FieldByName('BAS_CODITE').AsString,
            fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', cdsCadBas.FieldByName('BAS_CODITE').AsString),
            componente.CodigoComponente, fltQtdFormul, CATALISADOR,
            'N',  //Peso em gramas base
            0.0); //Embalagem da base
        End;
      end;
    End;
  End;

  if strCodigoItemBase <> strCodigoItemBaseOriginal then
    Result.fAdicionar(1, Self.Descricao, strCodigoItemBase,
                    fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', strCodigoItemBase),
                    strCodigoItemBase, 1, BASE_IMOBILIARIA,
                    'N',  //Peso em grama base
                    0.0)  //Embalagem da base
  else
    Result.fAdicionar(1, Self.Descricao, strCodigoItemBaseOriginal,
                    fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', strCodigoItemBaseOriginal),
                    strCodigoItemBaseOriginal, 1, BASE_IMOBILIARIA,
                    'N',  //Peso em gramas base
                    0.0); //Embalagem da base
end;

destructor TFormulaIndustrial.Destroy;
begin
  if Assigned(qryBases) then FreeAndNil(qryBases);
  if Assigned(qryEmbalagem) then FreeAndNil(qryEmbalagem);
  if Assigned(qryComponentes) then FreeAndNil(qryComponentes);
  inherited;
end;

function TFormulaIndustrial.fCalculaPrecoCusto2(fltPreVen, fltPreCus, fltOutVal,
  fltICMSai, fltImpFed, fltDesOpe: Double): Double;
var
  parcus: TParCalculaPrecoCusto;
begin
  parcus := nil;
  Result := 0;
  Try
    Try
      parcus := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);
      If fltIcmSai < 0 Then
        Result := fltPreCus
      Else
        Result := parcus.fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe, 0, 0);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(parcus) then FreeAndNil(parcus);
  End;
end;

function TFormulaIndustrial.fTabPreco: String;
begin
  Result := untFormulaIndustrial.fTabPreco(Self.strTabPre, FBlnCalculaUnitario);
end;

function TFormulaIndustrial.GetDespesasOperacionais: Double;
begin
  if blnPersonalizada then
    Result := DespesasOperacionaisComponentes + DespesasOperacionaisEmbalagem
  else
    Result := DespesasOperacionaisComponentes + DespesasOperacionaisBase;
end;

function TFormulaIndustrial.GetIcmSaida: Double;
begin
  if blnPersonalizada then
    Result := IcmSaidaComponentes + IcmSaidaEmbalagem
  else
    Result := IcmSaidaComponentes + IcmSaidaBase
end;

function TFormulaIndustrial.GetImpostosFederais: Double;
begin
  if blnPersonalizada then
    Result := ImpostosFederaisComponentes + ImpostosFederaisEmbalagem
  else
    Result := ImpostosFederaisComponentes + ImpostosFederaisBase;
end;

function TFormulaIndustrial.GetImpostosUltimaCompra: Double;
begin
  if blnPersonalizada then
    Result := ImpostosUltimaCompraComponentes + ImpostosUltimaCompraEmbalagem
  else
    Result := ImpostosUltimaCompraComponentes + ImpostosUltimaCompraBase;
end;

function TFormulaIndustrial.GetItemBase: string;
begin
  Result := strCodigoItemBaseOriginal;
  if (strCodigoItemBase <> strCodigoItemBaseOriginal) then
    Result := strCodigoItemBase;
end;

function TFormulaIndustrial.GetOutrosValores: Double;
begin
  if blnPersonalizada then
    Result := OutrosValoresComponentes + OutrosValoresEmbalagem
  else
    Result := OutrosValoresComponentes + OutrosValoresBase;
end;

function TFormulaIndustrial.GetPrecoCompraLiq: Double;
begin
  if blnPersonalizada then
    Result := PrecoCompraLiqComponentes + PrecoCompraLiqEmbalagem
  else
    Result := PrecoCompraLiqComponentes + PrecoCompraLiqBase;
end;

function TFormulaIndustrial.GetPrecoCusto: Double;
begin
  if blnPersonalizada then
    Result := PrecoCustoComponentes + PrecoCustoEmbalagem
  else
    Result := PrecoCustoComponentes + PrecoCustoBase
end;

function TFormulaIndustrial.GetPrecoCustoReal: Double;
begin
  if blnPersonalizada then
    Result := PrecoCustoRealComponentes + PrecoCustoRealEmbalagem
  else
    Result := PrecoCustoRealComponentes + PrecoCustoRealBase
end;

function TFormulaIndustrial.GetPrecoMedio: Double;
begin
  if blnPersonalizada then
    Result := PrecoMedioComponentes + PrecoMedioEmbalagem
  else
    Result := PrecoMedioComponentes + PrecoMedioBase;
end;

function TFormulaIndustrial.GetPrecoUltimaCompra: Double;
begin
  if blnPersonalizada then
    Result := PrecoUltimaCampraComponentes + PrecoUltimaCompraEmbalagem
  else
    Result := PrecoUltimaCampraComponentes + PrecoUltimaCompraBase;
end;

function TFormulaIndustrial.GetPrecoVenda: Double;
begin
  if blnPersonalizada then
    Result := PrecoVendaComponentes + PrecoVendaEmbalagem
  else
    Result := PrecoVendaComponentes + PrecoVendaBase;
end;

function TFormulaIndustrial.GetTemCatalisador: Boolean;
var
  intCont: Integer;
begin
  Result := False;
  for intCont := 0 to Self.Count - 1 do
  begin
    if TComponenteIndustrial(Self.Items[intCont]).Tipo = tciCatalisador then
    begin
      Result := True;
      Exit;
    end;  
    
  end;  
    
end;

function TFormulaIndustrial.GetVolumeBase: Double;
begin
  Result := fltVolumeBase;
end;

function TFormulaIndustrial.GetVolumeColorante: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to Self.Count - 1 do
  begin
    Result := Result + TComponenteIndustrial(Self.Items[intCont]).Quantidade;
  end; 
    
end;

function TFormulaIndustrial.GetVolumeFinal: Double;
begin
  if fltVolume = 0 then
    SetVolumeFinal(fltVolumeOriginal);

  Result := fltVolumeBase + fltVolumeColorantes;
end;

procedure TFormulaIndustrial.pRecalculaTabelas(dicRetorno: TDicionario);
var
  strTabelas: String;
  intContador: Integer;
  strTabelaUnica: String;
begin
  strTabelaUnica := IfNull(dicRetorno['tabelaunica'], '');

  Self.FBlnCalculaUnitario := False;

  If not fEmptyStr(strTabelaUnica) Then
  Begin
    Self.strTabPre := strTabelaUnica;
    Self.CarregarBases;
    Self.CarregarComponentes;
    Self.CalcularPrecos;

    dicRetorno['preve' + strTabelaUnica] := Self.PrecoVenda;

    dicRetorno['promoc'] := Self.StrPromoc;

    AcertaImpostos(Self.PrecoCustoReal, Self.PrecoCustoReal,
            Self.OutrosValores,
            Self.IcmSaida,
            Self.ImpostosFederais,
            Self.DespesasOperacionais,
            dicRetorno);
  End
  Else
  Begin
    strTabelas := fCfgSis('TABPRC');
    If Length(strTabelas) < 7 Then
      strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

    For intContador := 1 To Length(strTabelas) Do
    Begin
      if strTabelas[intContador] = 'S' then
      begin
        Self.strTabPre := IntToStr(intContador);
        Self.CarregarBases;
        Self.CarregarComponentes;
        Self.CalcularPrecos;

        dicRetorno['preve' + IntToStr(intContador)] := Self.PrecoVenda;

        If intContador = IfNull(dicRetorno['tabpre'], 0) Then
        Begin
          dicRetorno['promoc'] := Self.StrPromoc;

          AcertaImpostos(Self.PrecoCustoReal, Self.PrecoCustoReal,
                  Self.OutrosValores,
                  Self.IcmSaida,
                  Self.ImpostosFederais,
                  Self.DespesasOperacionais,
                  dicRetorno);
        End;
      end;
    End;
  End;
end;

procedure TFormulaIndustrial.pRetornaTabelaPreco(dicRetorno: TDicionario);
var
  intContador: Integer;
  copmponente: TComponenteIndustrial;
begin
  For intContador := 1 To 20 Do
  Begin
    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
      Continue;

    copmponente := TComponenteIndustrial(Self.Add);
    copmponente.CodigoComponente := dicRetorno['base' + fStrZero(intContador, 2)];
    copmponente.Quantidade := dicRetorno['qtdb' + fStrZero(intContador, 2)];
    copmponente.Tipo := tciColorante;
  End;

  pRecalculaTabelas(dicRetorno);

  dicRetorno['precus'] := Self.PrecoCusto;
  dicRetorno['precu2'] := Self.PrecoCustoReal;
end;

procedure TFormulaIndustrial.SetCodigoEmbalagemBase(const Value: string);
begin
  if Value <> strCodigoEmbalagemBase then
    CarregarPrecosBasesEmbalagem(Value);

  strCodigoEmbalagemBase := Value;  
end;

procedure TFormulaIndustrial.SetItemBase(const Value: string);
var
  blnCarrega: Boolean;
begin
  if fEmptyStr(strCodigoItemBaseOriginal) then
    strCodigoItemBaseOriginal := Value;

  blnCarrega := strCodigoItemBase <> Value;
  strCodigoItemBase := Value;
  if blnCarrega then
  begin    
    CarregarPrecosBases;
  end;

end;

procedure TFormulaIndustrial.SetUsaCatalisador(const Value: Boolean);
begin
  blnUsaCatalisador := Value;
end;

procedure TFormulaIndustrial.SetVolumeFinal(const value: Double);
var
  fltFator: Double;
  intCont: Integer;
begin
  fltFator := value / (fltVolumeBaseOriginal + fltVolumeColorantesOriginal);
  fltVolume := fltVolumeOriginal * fltFator;
  fltVolumeBase := fltVolumeBaseOriginal * fltFator;
  fltVolumeColorantes := fltVolumeColorantesOriginal * fltFator;

  for intCont := 0 to Self.Count - 1 do
  begin
    TComponenteIndustrial(Self.Items[intCont]).AplicarFator(fltFator);
  end;

end;

procedure TFormulaIndustrial.ZerarPrecos;
begin
  fltPrecoCustoComponentes := 0;
  fltPrecoCustoRealComponentes := 0;
  fltPrecoVendaComponentes := 0;
  fltOutrosValoresComponentes := 0;
  fltIcmSaidaComponentes := 0;
  fltImpostosFederaisComponentes := 0;
  fltDespesasOperacionaisComponentes := 0;

  fltPrecoMedioComponentes := 0;
  fltPrecoUltimaCompraComponentes := 0;
  fltImpostosUltimaCompraComponentes := 0;
  fltPrecoCompraLiqComponentes := 0;

  fltPrecoCustoBase := 0;
  fltPrecoCustoRealBase := 0;
  fltPrecoVendaBase := 0;
  fltOutrosValoresBase := 0;
  fltIcmSaidaBase := 0;
  fltImpostosFederaisBase := 0;
  fltDespesasOperacionaisBase := 0;
  fltPesoEspecificoBase := 0;

  fltPrecoMedioBase := 0;
  fltPrecoUltimaCompraBase := 0;
  fltImpostosUltimaCompraBase := 0;
  fltPrecoCompraLiqBase := 0;

  fltPrecoCustoEmbalagem := 0;
  fltPrecoCustoRealEmbalagem := 0;
  fltPrecoVendaEmbalagem := 0;
  fltOutrosValoresEmbalagem := 0;
  fltIcmSaidaEmbalagem := 0;
  fltImpostosFederaisEmbalagem := 0;
  fltDespesasOperacionaisEmbalagem := 0;

  fltPrecoMedioEmbalagem := 0;
  fltPrecoUltimaCompraEmbalagem := 0;
  fltImpostosUltimaCompraEmbalagem := 0;
  fltPrecoCompraLiqEmbalagem := 0;
end;

{ TComponenteIndustrial }

procedure TComponenteIndustrial.AplicarFator(const fltFator: Double);
begin
  fltQuantidade := fltFator * fltQuantidadeOriginal;
end;

function TComponenteIndustrial.fCalculaPrecoCusto2(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe: Double): Double;
var
  parcus: TParCalculaPrecoCusto;
begin
  Result := 0.0;
  parcus := nil;
  Try
    Try
      parcus := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);

      If fltIcmSai < 0 Then
        Result := fltPreCus
      Else
        Result := parcus.fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe, 0, 0);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(parcus) then
      FreeAndNil(parcus);
  End;
end;

function TComponenteIndustrial.GetPrecoCustoReal: Double;
begin
  Result := fCalculaPrecoCusto2(fltPrecoVenda, fltPrecoCusto, fltOutrosValores, fltIcmSaida, fltImpostosFederais, fltDespesasOperacionais);
end;

procedure TComponenteIndustrial.SetQuantidade(const value: Double);
begin
  if fltQuantidadeOriginal = 0 then
    fltQuantidadeOriginal := value;

  fltQuantidade := value;
end;

function fCarregaPromocao(strCodIte, strTabPre, strCodCli, strCodCnd: String;
    intPrzMed: Integer; var fltPreCus, fltPreVen: Double): Boolean;
Var
  fltComVar,
  fltComAta,
  fltComDis,
  fltQtdDis,
  fltDesF07: Double;
  blnParticiona,
  blnPromo: Boolean;
  strComPro: String;
begin
  Result := Not fClienteFilial(strCodCli) And
                fRetornaPrecosPromocao(strCodIte, strCodCli, VS_Date, 0, 0, 0, intPrzMed,
                                       fltPreCus, fltPreVen, fltComVar, fltComAta,
                                       fltComDis, fltQtdDis, fltDesF07, strComPro, blnParticiona,
                                       blnPromo, strTabPre, strCodCnd, '', '', False);
end;

function fTabPreco(strTabPre: String; blnCalculaUnitario: Boolean): String;
begin
  If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    Result := '1';
  end
  Else If (fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') and blnCalculaUnitario Then
  begin
    Result := fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1');
  end
  else
  begin
    Result := strTabPre;
  end;
end;

procedure AcertaImpostos(const fltPreCus, fltPreCu2, fltOutVal, fltIcmSai, fltImpFed, fltDesOpe: Extended; dicRetorno: TDicionario);
begin
  dicRetorno['outval'] := fltOutVal;
  dicRetorno['icmsai'] := fltIcmSai;
  dicRetorno['impfed'] := fltImpFed;
  dicRetorno['desope'] := fltDesOpe;
end;

end.
