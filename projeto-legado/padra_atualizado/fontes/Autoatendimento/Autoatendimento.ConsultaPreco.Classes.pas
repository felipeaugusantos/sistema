unit Autoatendimento.ConsultaPreco.Classes;

interface

uses
  System.SysUtils, System.StrUtils, System.Classes, Autoatendimento.ConsultaPreco.Interfaces,
  System.Generics.Collections, Winapi.ShlObj, System.Math;

type
  TAutoatendimentoConsultaAtributos = class(TInterfacedObject, IAutoatendimentoConsultaAtributos)
  private
    FGrupo: String;
    FDescricao: String;
    FValor: String;
  public
    constructor Create(AGrupo, ADescricao, AValor: String);
  public
    function Grupo: String;
    function Descricao: String;
    function Valor: String;
  end;

  TAutoatendimentoConsultaEmbalagem = class(TInterfacedObject, IAutoatendimentoConsultaEmbalagem)
  Private
    FCodigo: String;
    FCodigoBarras: String;
  public
    constructor Create(ACodigo, ACodigoBarras: String);
  public
    function TabelaPreco: String;
    function PrecoVenda: Double;
    function Quantidade: Double;
  end;

  TAutoatendimentoConsultaProduto = class(TInterfacedObject, IAutoatendimentoConsultaProduto)
  private
    FCodigo: String;
    FCodigoBarras: String;
    FPathImagem: String;
    FAtributos: TList<IAutoatendimentoConsultaAtributos>;
    FSimilares: TList<IAutoatendimentoConsultaProduto>;
    FAgregados: TList<IAutoatendimentoConsultaProduto>;
    FEmbalagem: TAutoatendimentoConsultaEmbalagem;
  private
    procedure CarregarAtributos;
    procedure CarregarSimilares;
    procedure CarregarAgregados;
    procedure DeletarImagem;
  private
    function TabelaPrecoPadrao: String;
    function BuscarPrecoPromocao: Double;
    function BuscarPrecoEmbalagemFechada: Double;
  public
    constructor Create(ACodigo, ACodigoBarras: String);
    destructor Destroy; override;
  public
    function Codigo: String;
    function Descricao: String;
    function PrecoVenda: Double;
    function PrecoTabela(): Double;
    function UnidadeVenda: String;
    function TextoAdicionalPreco: String;
    function PathImagemPrincipal: String;
    function PathVideoApresentacao: String;
    function DetalhesUtilizacao: String;
    function EmbalagemFechada: Boolean;
    function QuantidadeEmbalagem: Double;
    function EmPromocao(): Boolean;
    function DadosTecnicos: TList<IAutoatendimentoConsultaAtributos>;
    function ProdutosSimilares: TList<IAutoatendimentoConsultaProduto>;
    function ProdutosAgregados: TList<IAutoatendimentoConsultaProduto>;
  end;

  TAutoatendimentoConsultaPreco = class(TInterfacedObject, IAutoatendimentoConsultaPreco)
  public
    function Consultar(ACodigoBarras: String): IAutoatendimentoConsultaProduto;
    function PathLogotipoEmpresa(): String;
    function SegmentoCliente(): String;
  end;

implementation

uses
  untConstantes, untFuncoesSimples, Uni, untFatProdAgregados, untCadPro, cxImage,
  untFuncoesImagem, untTypesSistema, untFuncoesCXGrid;

{ TAutoatendimentoConsultaAtributos }

constructor TAutoatendimentoConsultaAtributos.Create(AGrupo, ADescricao, AValor: String);
begin
  FGrupo := AGrupo;
  FDescricao := ADescricao;
  FValor := AValor;
end;

function TAutoatendimentoConsultaAtributos.Descricao: String;
begin
  Result := FDescricao;
end;

function TAutoatendimentoConsultaAtributos.Grupo: String;
begin
  Result := FGrupo;
end;

function TAutoatendimentoConsultaAtributos.Valor: String;
begin
  Result := FValor;
end;

{ TAutoatendimentoConsultaProduto }

procedure TAutoatendimentoConsultaProduto.CarregarAgregados;
Var
  LQuery: TUniQuery;
begin
  If Assigned(FAgregados) Then
    Exit;

  FAgregados := TList<IAutoatendimentoConsultaProduto>.Create;

  LQuery := fCriaQuery(nil);

  Try
    LQuery.SQL.Text := TfrmFatProdAgregados.fGetSQLItensAgregados(FCodigo, VS_strCodEmp, TabelaPrecoPadrao);
    LQuery.Open;

    LQuery.First;
    While Not LQuery.Eof Do
    Begin
      FAgregados.Add(TAutoatendimentoConsultaProduto.Create(LQuery.FieldByName('CODITE').AsString, ''));
      LQuery.Next;
    End;

  Finally
    FreeAndNil(LQuery);
  End;

end;

procedure TAutoatendimentoConsultaProduto.CarregarAtributos;
Var
  LQuery: TUniQuery;
begin
  If Assigned(FAtributos) Then
    Exit;

  FAtributos := TList<IAutoatendimentoConsultaAtributos>.Create;

  LQuery := fCriaQuery(nil);

  Try
    LQuery.SQL.Text := SQL_ATRIBUTOS_PRODUTO;
    LQuery.ParamByName('CODITE').AsString := FCodigo;
    LQuery.Open;

    LQuery.First;
    While Not LQuery.Eof Do
    Begin
      FAtributos.Add(TAutoatendimentoConsultaAtributos.Create(LQuery.FieldByName('Grupo').AsString,
        LQuery.FieldByName('Descricao').AsString, LQuery.FieldByName('Valor').AsString));
      LQuery.Next;
    End;

  Finally
    FreeAndNil(LQuery);
  End;

end;

procedure TAutoatendimentoConsultaProduto.CarregarSimilares;
Var
  LCodigo: String;
  LSimilares: TArray<String>;
begin
  If Assigned(FSimilares) Then
    Exit;

  FSimilares := TList<IAutoatendimentoConsultaProduto>.Create;

  LCodigo := fCampoTabela('ITE_CODSIM', 'CADITE', ['ITE_CODITE'], [FCodigo], False);

  If LCodigo.IsEmpty Then
    Exit;

  LSimilares := String(fCampoTabela('GROUP_CONCAT(ITE_CODITE ORDER BY ITE_DESITE)', 'CADITE', ['ITE_CODSIM'],
    [LCodigo], False)).Split([',']);

  For LCodigo In LSimilares Do
    If Not LCodigo.Equals(FCodigo) Then
      FSimilares.Add(TAutoatendimentoConsultaProduto.Create(LCodigo, ''));
end;

function TAutoatendimentoConsultaProduto.Codigo: String;
begin
  Result := FCodigo;
end;

constructor TAutoatendimentoConsultaProduto.Create(ACodigo, ACodigoBarras: String);
begin
  FCodigo := ACodigo;
  FCodigoBarras := ACodigoBarras;
  FEmbalagem := TAutoatendimentoConsultaEmbalagem.Create(ACodigo, ACodigoBarras);
end;

function TAutoatendimentoConsultaProduto.DadosTecnicos: TList<IAutoatendimentoConsultaAtributos>;
begin
  CarregarAtributos;
  Result := FAtributos;
end;

procedure TAutoatendimentoConsultaProduto.DeletarImagem;
begin
  If (FPathImagem <> '') And FileExists(FPathImagem) Then
    DeleteFile(FPathImagem);
end;

function TAutoatendimentoConsultaProduto.Descricao: String;
begin
  Result := fRetNomProduto(FCodigo);
end;

destructor TAutoatendimentoConsultaProduto.Destroy;
begin
  FreeAndNil(FAtributos);
  FreeAndNil(FSimilares);
  FreeAndNil(FAgregados);
  DeletarImagem;
  inherited;
end;

function TAutoatendimentoConsultaProduto.DetalhesUtilizacao: String;
begin
  Result := fCampoTabela('ITE_DETUTI', 'ITEDTE', ['ITE_CODITE'], [FCodigo], False);
end;

function TAutoatendimentoConsultaProduto.EmbalagemFechada: Boolean;
begin
  Result := QuantidadeEmbalagem > 1;
end;

function TAutoatendimentoConsultaProduto.EmPromocao: Boolean;
begin
  Result := BuscarPrecoPromocao > 0;
end;

function TAutoatendimentoConsultaProduto.PathImagemPrincipal: String;
Var
  LImage: TCxImage;
  LPath: String;
begin
  If (FPathImagem <> '') And FileExists(FPathImagem) Then
    Exit(FPathImagem);

  Result := '';

  LImage := TCxImage.Create(nil);
  Try
    If fCarregaImagemProduto(FCodigo, LImage.Picture) = riOk Then
    Begin
      LPath := GetSpecialFolderPath(CSIDL_APPDATA, False) + '\Autcom\';

      If Not DirectoryExists(LPath) Then
        CreateDir(LPath);

      FPathImagem := LPath + FCodigoBarras + '_' + RandomRange(1, 99999).ToString() + '.JPEG';

      While FileExists(FPathImagem) Do
        FPathImagem := LPath + FCodigoBarras + '_' + RandomRange(1, 99999).ToString() + '.JPEG';

      LImage.Picture.SaveToFile(FPathImagem);

      Result := FPathImagem;
    End;
  Finally
    FreeAndNil(LImage);
  End;
end;

function TAutoatendimentoConsultaProduto.PathVideoApresentacao: String;
begin
  Result := fCampoTabela('ITE_PATVID', 'ITEDTE', ['ITE_CODITE'], [FCodigo], False);
end;

function TAutoatendimentoConsultaProduto.BuscarPrecoEmbalagemFechada: Double;
begin
  Result := 0;

  If Not EmbalagemFechada Then
    Exit;

  If Not fCfgSis('PRVEMB', VarBoolean) Then
    Exit;

  If (fCfgSis('PREEMB', VarInteger) = 1) And (FEmbalagem.PrecoVenda > 0.00) Then
    Exit(FEmbalagem.PrecoVenda);

  If (fCfgSis('PREEMB', VarInteger) = 2) Then
  Begin
    If FEmbalagem.TabelaPreco.IsEmpty Then
      Exit;

    If FEmbalagem.TabelaPreco = 'F' Then
      Exit;

    If (fEmptyStr(FEmbalagem.TabelaPreco)) Or
      (SameText(VS_strTabVen[StrToInt(FEmbalagem.TabelaPreco)], 'N')) Then
      Raise EAutoatendimentoConsultaPrecoError.Create('Produto ' + FCodigo + #13#10 +
        'Esta embalagem está configurada para utilizar uma tabela de preço inválida!');

    Result := fRetornaPrecoCodBarraEmb(FCodigo, FCodigoBarras, VS_strCodEmp, FEmbalagem.TabelaPreco, False);
  End;

end;

function TAutoatendimentoConsultaProduto.BuscarPrecoPromocao: Double;
Var
  fltPreCus, fltPreVen, fltComVar, fltComAta, fltComDis, fltQtdDis, fltDesF07: Double;
  blnParticiona, blnPromo: Boolean;
  strComPro: String;
  strCodPromocao: String;
begin
  Result := 0;
  If (fRetornaPrecosPromocao(FCodigo, '', VS_Date, 1, 0, 0, 0, fltPreCus, fltPreVen, fltComVar, fltComAta,
    fltComDis, fltQtdDis, fltDesF07, strComPro, strCodPromocao, blnParticiona, blnPromo,
    TabelaPrecoPadrao, '')) Then
  Begin
    Result := fltPreVen;
  End;
end;

function TAutoatendimentoConsultaProduto.PrecoTabela: Double;
begin
  Result := 0;
  Try
    Result := fRetPrecoVenda(FCodigo, TabelaPrecoPadrao, VS_strCodEmp);
  Finally
    If FEmbalagem.Quantidade > 1 Then
      Result := fFormataFloat(FEmbalagem.Quantidade * Result, 2);

    If fFormataFloat(Result, 2) <= 0 Then
      Raise EAutoatendimentoConsultaPrecoError.Create('Produto ' + FCodigo + #13#10 +
        'Não foi possível retornar o preço deste produto!');
  End;
end;

function TAutoatendimentoConsultaProduto.PrecoVenda: Double;
Var
  LPrecoPromocao: Double;
  LPrecoEmbalagem: Double;
begin
  Result := 0;
  Try
    LPrecoPromocao := BuscarPrecoPromocao;

    If LPrecoPromocao > 0 Then
      Exit(LPrecoPromocao);

    LPrecoEmbalagem := BuscarPrecoEmbalagemFechada;

    If LPrecoEmbalagem > 0 Then
      Exit(LPrecoEmbalagem);

    Result := fRetPrecoVenda(FCodigo, TabelaPrecoPadrao, VS_strCodEmp);
  Finally
    If FEmbalagem.Quantidade > 1 Then
      Result := fFormataFloat(FEmbalagem.Quantidade * Result, 2);

    If fFormataFloat(Result, 2) <= 0 Then
      Raise EAutoatendimentoConsultaPrecoError.Create('Produto ' + FCodigo + #13#10 +
        'Não foi possível retornar o preço deste produto!');
  End;
end;

function TAutoatendimentoConsultaProduto.ProdutosAgregados: TList<IAutoatendimentoConsultaProduto>;
begin
  CarregarAgregados;
  Result := FAgregados;
end;

function TAutoatendimentoConsultaProduto.ProdutosSimilares: TList<IAutoatendimentoConsultaProduto>;
begin
  CarregarSimilares;
  Result := FSimilares;
end;

function TAutoatendimentoConsultaProduto.QuantidadeEmbalagem: Double;
begin
  Result := FEmbalagem.Quantidade;
end;

function TAutoatendimentoConsultaProduto.TabelaPrecoPadrao: String;
begin
  Result := fCfgSis('ACPTBP');
end;

function TAutoatendimentoConsultaProduto.TextoAdicionalPreco: String;
begin
  Result := fCfgSis('ACPTAP');
end;

function TAutoatendimentoConsultaProduto.UnidadeVenda: String;
begin
  Result := fRetSiglaUnidadePorCodIte(FCodigo);
end;

{ TAutoatendimentoConsultaPreco }

function TAutoatendimentoConsultaPreco.Consultar(ACodigoBarras: String): IAutoatendimentoConsultaProduto;
Var
  LCodigo: String;
begin
  LCodigo := fCodigoDeBarrasToCodIte(ACodigoBarras);

  If LCodigo.IsEmpty Then
    Raise EAutoatendimentoConsultaPrecoError.Create('Nenhum produto encontrado com este código de barras!');

  Result := TAutoatendimentoConsultaProduto.Create(LCodigo, ACodigoBarras);
end;

function TAutoatendimentoConsultaPreco.PathLogotipoEmpresa: String;
begin
  Result := fCfgSis('ACPIML');
end;

function TAutoatendimentoConsultaPreco.SegmentoCliente: String;
begin
  Result := fCfgSis('ACPSEG');
end;

{ TAutoatendimentoConsultaEmbalagem }

constructor TAutoatendimentoConsultaEmbalagem.Create(ACodigo, ACodigoBarras: String);
begin
  FCodigo := ACodigo;
  FCodigoBarras := ACodigoBarras;
end;

function TAutoatendimentoConsultaEmbalagem.PrecoVenda: Double;
begin
  Result := fCampoTabela('BAR_PREVEN', 'ITEBAR', ['BAR_CODBAR', 'BAR_CODITE'],
    [FCodigoBarras, FCodigo]);
end;

function TAutoatendimentoConsultaEmbalagem.Quantidade: Double;
begin
  Result := fCampoTabela('BAR_EMBALA', 'ITEBAR', ['BAR_CODBAR', 'BAR_CODITE'],
    [FCodigoBarras, FCodigo]);
end;

function TAutoatendimentoConsultaEmbalagem.TabelaPreco: String;
begin
  Result := fCampoTabela('BAR_TABPRE', 'ITEBAR', ['BAR_CODBAR', 'BAR_CODITE'],
    [FCodigoBarras, FCodigo]);
end;

end.
