{******************************************************************************}
{* Classe abstrata que implementa o básico de todas as formulas imobiliárias. *}
{***************************************************************************PH*}
unit untAbstractFormulaImobiliaria;

interface

uses
  untAbstractFormula, untIDataSet, Classes, SysUtils, untICalculadorFormulaImobiliaria,
  untColorante, untIDicionario, Variants, untISaldosColorantes;

type
  TAbstractFormulaImobiliaria = class abstract (TAbstractFormula)
  private
    strItemBaseOriginal: String;
    strItemBase: String;
    fltBasePrecoCusto: Double;
    fltBasePrecoCustoReal: Double;
    fltBasePrecoVenda: Double;
    dataSetColorantes: IDataSet;
    strUnidade: String;
    strDescricao: String;
  private
    fltOutrosValores: Double;
    fltIcmsSaida: Double;
    fltImpostosFederais: Double;
    fltDespesasOperacionais: Double;
    fltPrecoCusto: Double;
    fltPrecoCustoReal: Double;
    fltPrecoVenda: Double;
  protected
    calculador: ICalculadorFormulaImobiliaria;
    function GetCalculadorInterno(): ICalculadorFormulaImobiliaria; virtual; abstract;
  protected
    function GetOutrosValores(): Double; override;
    function GetIcmsSaida(): Double; override;
    function GetImpostosFederais(): Double; override;
    function GetDespesasOperacionais(): Double; override;
    function GetPrecoCusto(): Double; override;
    function GetPrecoCustoReal(): Double; override;
    function GetPrecoVenda(): Double; override;
  protected
    procedure SetItemBase(const Value: String); virtual;
    procedure CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante); virtual;
    function GetDataSetColorantes(): IDataSet;
    function GetNomeTabelaColorantes(): String; virtual; abstract;
    function GetNomeCampoCustoBase: String; virtual; abstract;
    function GetNomeCampoVendaBase: String; virtual; abstract;
    function GetNomeTabelaBase: String; virtual; abstract;
    function GetNomeCampoBaseCodIte: String; virtual;
  public
    procedure CarregarColorantes; virtual;
    procedure RecalcularTabelas(const dicRetorno: IDicionario); override;
    function fRetornaTabelaColoranteTinta(): String; virtual;
    function GetItemBaseOriginal(const strIteTin: String): String; virtual; abstract;
    function GetProdutoBaseFormula(const dtsCadTin: IDataSet): String; virtual; abstract;
    procedure CarregaPrecosColorantes; virtual;
    procedure CalcularPrecos; override;
    function GetCalculador(): ICalculadorFormulaImobiliaria;
    function GetSaldos: ISaldosColorantes; override;
  public
    function GetUnidade(const dtsCadTin: IDataSet): String; virtual; abstract;
    function GetDescricao(const dtsCadTin: IDataSet): String; virtual; abstract;
  public
    constructor Create(const strTabPre: String);
    destructor Destroy; override;
  public
    property ItemBaseOriginal: String read strItemBaseOriginal write strItemBaseOriginal;
    property ItemBase: String read strItemBase write SetItemBase;
    property BasePrecoCusto: Double read fltBasePrecoCusto;
    property BasePrecoCustoReal: Double read fltBasePrecoCustoReal;
    property ColorantesDataSet: IDataSet read GetDataSetColorantes;
    property BasePrecoVenda: Double read fltBasePrecoVenda;
    property Unidade: String read strUnidade write strUnidade;
    property Descricao: String read strDescricao write strDescricao;
  end;

implementation

uses
  untAutcomTintaFactory, untGenericSaldosColorantes;

{ TAbstractFormulaImobiliaria }

procedure TAbstractFormulaImobiliaria.CalcularPrecos;
begin
  GetCalculador.Calcular;

  fltPrecoVenda := GetCalculador.PrecoVenda;
  fltPrecoCusto := GetCalculador.PrecoCusto;
  fltPrecoCustoReal := GetCalculador.PrecoCustoReal;
  fltOutrosValores := GetCalculador.OutrosValores;
  fltIcmsSaida := GetCalculador.IcmsSaida;
  fltImpostosFederais := GetCalculador.ImpostosFederais;
  fltDespesasOperacionais := GetCalculador.DespesasOperacionais;  
end;

function TAbstractFormulaImobiliaria.fRetornaTabelaColoranteTinta: String;
begin
  Result := GetNomeTabelaColorantes;
end;

function TAbstractFormulaImobiliaria.GetCalculador: ICalculadorFormulaImobiliaria;
begin
  if not Assigned(calculador) then
    calculador := GetCalculadorInterno;

  Result := calculador;
end;

function TAbstractFormulaImobiliaria.GetDataSetColorantes: IDataSet;
begin
  if not Assigned(dataSetColorantes) then
  begin
    dataSetColorantes := TAutcomTintaFactory.Get.fGetDataSet;
  end;

  Result := dataSetColorantes;  
end;

function TAbstractFormulaImobiliaria.GetDespesasOperacionais: Double;
begin
  Result := fltDespesasOperacionais;
end;

function TAbstractFormulaImobiliaria.GetIcmsSaida: Double;
begin
  Result := fltIcmsSaida;
end;

function TAbstractFormulaImobiliaria.GetImpostosFederais: Double;
begin
  Result := fltImpostosFederais;
end;

function TAbstractFormulaImobiliaria.GetNomeCampoBaseCodIte: String;
begin
  Result := 'BAS_CODITE';
end;

function TAbstractFormulaImobiliaria.GetOutrosValores: Double;
begin
  Result := fltOutrosValores;
end;

function TAbstractFormulaImobiliaria.GetPrecoCusto: Double;
begin
  Result := fltPrecoCusto;
end;

function TAbstractFormulaImobiliaria.GetPrecoCustoReal: Double;
begin
  Result := fltPrecoCustoReal;
end;

function TAbstractFormulaImobiliaria.GetPrecoVenda: Double;
begin
  Result := fltPrecoVenda;
end;

function TAbstractFormulaImobiliaria.GetSaldos: ISaldosColorantes;
var
  intCont: Integer;
  saldos: TGenericSaldosColorantes;
  colorante: TColorante;
begin
  saldos := TGenericSaldosColorantes.Create();

  for intCont := 0 to Self.Count - 1 do
  begin
    colorante := TColorante(Self.Items[intCont]);
    GetDataSetColorantes.Locate('COL_CODCOL', colorante.CodigoColorante, []);

    if colorante.Quantidade > 0 then
    begin
      saldos.Adicionar(TGenericSaldoColorante.Create(
        1,
        Descricao,
        GetDataSetColorantes.FieldByName('COL_CODITE').AsString,
        VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [
          GetDataSetColorantes.FieldByName('COL_CODITE').AsString]), ''),
        colorante.CodigoColorante,
        colorante.Quantidade * FatorEstoque,
        COLORANTE_IMOBILIARIO));
    end;
  end;

  saldos.Adicionar(TGenericSaldoColorante.Create(
    1,
    Descricao,
    ItemBase,
    VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE', 'ITE_DESITE', [ItemBase]), ''),
    ItemBase,
    1,
    BASE_IMOBILIARIA));

  Result := saldos;
end;

procedure TAbstractFormulaImobiliaria.CarregaPrecosColorantes;
var
  intContador: Integer;
  colorante: TColorante;
begin

  For intContador := 0 To Self.Count-1 Do
  Begin
    colorante := TColorante(Self.Items[intContador]);
    GetDataSetColorantes.Locate('COL_CODCOL', colorante.CodigoColorante, []);

    colorante.OutrosValores := GetDataSetColorantes.FieldByName('ITE_OUTVAL').AsFloat;
    colorante.IcmsSaida := GetDataSetColorantes.FieldByName('ITE_ICMSAI').AsFloat;
    colorante.ImpostosFederais := GetDataSetColorantes.FieldByName('ITE_IMPFED').AsFloat;
    colorante.DespesasOperacionais := GetDataSetColorantes.FieldByName('ITE_DESOPE').AsFloat;

    colorante.PrecoCusto := GetDataSetColorantes.FieldByName('ITE_PRECUS').AsFloat;
    colorante.PrecoVenda := GetDataSetColorantes.FieldByName('ITE_PREVEN').AsFloat;
    CarregaPrecosColorantesAdicional(GetDataSetColorantes, colorante);
  End;

  TextoInformativoCalculo.Text := GetTextoInformativoCalculo;
end;

procedure TAbstractFormulaImobiliaria.CarregaPrecosColorantesAdicional(const dataSetColorantes: IDataSet; const colorante: TColorante);
begin
end;

procedure TAbstractFormulaImobiliaria.CarregarColorantes;
var
  strSql: String;
begin
  strSql := ' SELECT         ' +
    '   COL_CODCOL   ' +
    '   , COL_CODITE ' +
    '   , ITE_CNV_ML ' +
    '   , ITE_OUTVAL ' +
    '   , ITE_ICMSAI ' +
    '   , ITE_IMPFED ' +
    '   , ITE_DESOPE ' +
    '   , ITE_PREMED ' +
    '   , ITE_IMPULT ' +
    '   , ITE_PREULT ';

  If (TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
  begin
    strSql := strSql +
      '   , COL_PRECUS AS ITE_PRECUS ' +
      '   , COL_PREVEN AS ITE_PREVEN ';
  end

  Else If (TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') Then
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ';
  end
  else
  begin
    strSql := strSql +
      '   , ITE_PRECUS               ' +
      '   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ';
  end;

  strSql := strSql +
    ' FROM                               ' +
    '   ' + GetNomeTabelaColorantes + ' C                     ' +
    '   INNER JOIN ITEGER G              ' +
    '     ON C.COL_CODITE = G.ITE_CODITE ' +
    '   INNER JOIN CADITE I              ' +
    '     ON C.COL_CODITE = I.ITE_CODITE ' +
    ' WHERE G.ITE_CODEMP = :CODEMP       ';

  GetDataSetColorantes.SQL := strSql;
  GetDataSetColorantes.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  GetDataSetColorantes.Open;
end;

constructor TAbstractFormulaImobiliaria.Create(const strTabPre: String);
begin
  inherited Create();
  Self.strTabPre := strTabPre;
end;

destructor TAbstractFormulaImobiliaria.Destroy;
begin
  dataSetColorantes := nil;
  inherited;
end;

procedure TAbstractFormulaImobiliaria.RecalcularTabelas(const dicRetorno: IDicionario);
var
  strTabelas: String;
  intContador: Integer;
begin
  strTabelas := TAutcomTintaFactory.Get().fCfgSis('TABPRC');
  If Length(strTabelas) < 7 Then
    strTabelas := strTabelas + StringOfChar('N', 7 - Length(strTabelas));

  For intContador := 1 To Length(strTabelas) Do
  Begin
    Self.strTabPre := IntToStr(intContador);
    Self.fltBasePrecoCusto := 0.0;
    Self.fltBasePrecoCustoReal := 0.0;

    Self.CarregarColorantes;
    Self.CarregaPrecosColorantes;
    Self.SetItemBase(Self.strItemBase);
    Self.CalcularPrecos;

    dicRetorno['preve' + IntToStr(intContador)] := Self.PrecoVenda + Self.BasePrecoVenda;
  End;

  dicRetorno['precus'] := Self.PrecoCusto + Self.BasePrecoCusto;
  dicRetorno['precu2'] := Self.PrecoCustoReal + Self.BasePrecoCustoReal;
end;

procedure TAbstractFormulaImobiliaria.SetItemBase(const Value: String);
var
  dataSetCalculo: IDataSet;
  strSql: String;

  function fPrecoCusto2Base: Double;
  var
    dicDados: IDicionario;
  begin
    dicDados := TAutcomTintaFactory.Get.GetDicionario;
    dicDados['preven'] := dataSetCalculo.FieldByName('ITE_PREVEN').AsFloat;
    dicDados['precus'] := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat;
    dicDados['outval'] := dataSetCalculo.FieldByName('ITE_OUTVAL').AsFloat;
    dicDados['icmsai'] := dataSetCalculo.FieldByName('ITE_ICMSAI').AsFloat;
    dicDados['impfed'] := dataSetCalculo.FieldByName('ITE_IMPFED').AsFloat;
    dicDados['desope'] := dataSetCalculo.FieldByName('ITE_DESOPE').AsFloat;

    Result := TAutcomTintaFactory.Get.fCalculaPrecoCusto2(dicDados);
  end;
begin
  Self.strItemBase := Value;
  dataSetCalculo := nil;

  Try
    Try
      dataSetCalculo := TAutcomTintaFactory.Get.fGetDataSet;
      strSql :=
        ' SELECT         ' +
        '   ITE_OUTVAL   ' +
        '   , ITE_ICMSAI ' +
        '   , ITE_IMPFED ' +
        '   , ITE_DESOPE ';

      If Value = strItemBaseOriginal Then
      Begin

        If (TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '0') Then
        begin
          strSql := strSql +
            '   , ' + GetNomeCampoCustoBase + ' AS ITE_PRECUS ' +
            '   , ' + GetNomeCampoVendaBase + ' AS ITE_PREVEN ';
        end
        Else If (TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') Then
        Begin
          strSql := strSql +
            '   , ITE_PRECUS               ' +
            '   , ITE_PREVE' + TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ';
        End
        Else
        Begin
          strSql := strSql +
            '   , ITE_PRECUS               ' +
            '   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ';
        End;

        strSql := strSql +
          ' FROM                             ' +
          '   ' + GetNomeTabelaBase + ' B                   ' +
          '   INNER JOIN ITEGER G            ' +
          '     ON ' + GetNomeCampoBaseCodIte + ' = G.ITE_CODITE ' +
          ' WHERE ITE_CODEMP = :CODEMP       ' +
          '   AND ITE_CODITE = :CODITE       ';
      End
      Else
      Begin

        If (TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL', 'PRECO_GERACAO', '0') = '1') Then
        Begin
          strSql := strSql +
            '   , ITE_PRECUS               ' +
            '   , ITE_PREVE' + TAutcomTintaFactory.Get.fArqIniTinta(0, 'GERAL', 'TABPRECO_GERACAO', '1') + ' AS ITE_PREVEN ';
        End
        Else
        Begin
          strSql := strSql +
            '   , ITE_PRECUS               ' +
            '   , ITE_PREVE' + strTabPre + ' AS ITE_PREVEN ';
        End;

        strSql := strSql +
          ' FROM                             ' +
          '   ITEGER G                       ' +
          ' WHERE ITE_CODEMP = :CODEMP       ' +
          '   AND ITE_CODITE = :CODITE       ';
      End;

      dataSetCalculo.SQL := strSql;
      dataSetCalculo.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      dataSetCalculo.ParamByName('CODITE').AsString := Value;
      dataSetCalculo.Open;

      fltBasePrecoVenda := dataSetCalculo.FieldByName('ITE_PREVEN').AsFloat;
      fltBasePrecoCusto := dataSetCalculo.FieldByName('ITE_PRECUS').AsFloat;
      fltBasePrecoCustoReal := fPrecoCusto2Base; 
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

end.
