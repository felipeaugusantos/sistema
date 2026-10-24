unit KitPromocao.Classes;

interface

uses Classes, StrUtils, Uni, SysUtils ,UniClientDataSet, Data.Db;

Type

  ttipoProduto = (tpNenhum, ttpGatilho, ttpBeneficiado, ttpBrinde);

  TKitPromocaoRepositorio = class
    FCdsBrinde,
    FCdsKit,
    FCdsProdutoBeneficiado,
    FCdsProdutoGatilho : TUniClientDataSet;
    FQuery             : TUniQuery;
  private
    function fCarregarKit(AIdPromocao : String) : Boolean;
    function fCarregarKitBrinde(AIdPromocao : String) : Boolean;
    function fCarregarKitDetalhes(AIdPromocao : String) : Boolean;
    function fSalvarKit(AIdPromocao : String) : Boolean;
    function fSalvarKitBrinde : Boolean;
    function fSalvarKitDetalhe : Boolean;
    function pApagarKits(AIdPromocao : String) : Boolean;
    procedure pCriarClients;
  public
    Constructor Create;
    Destructor  Destroy; override;
    function fCarregarPromocao(AIdPromocao : String) : Boolean;
    function fSalvar(AIdPromocao : String) : Boolean;

    property CdsBrinde             : TUniClientDataSet read FCdsBrinde;
    property CdsKit                : TUniClientDataSet read FCdsKit;
    property CdsProdutoBeneficiado : TUniClientDataSet read FCdsProdutoBeneficiado;
    property CdsProdutoGatilho     : TUniClientDataSet read FCdsProdutoGatilho;
  end;

  TKitPromocaoBuilder = class
    FCdsBrinde,
    FCdsKit,
    FCdsProdutoBeneficiado,
    FCdsProdutoGatilho     : TUniClientDataSet;
    FCodigoBrinde          : String;
    FDesconto              : Double;
    FDescricaoBrinde       : String;
    FDescricaoGrupo        : String;
    FDescricaoKit          : String;
    FGrupo                 : String;
    FobjRepositorio        : TKitPromocaoRepositorio;
    FQuantidade            : Double;
    FQuantidadeBrinde      : Double;
    FTipoProduto           : ttipoProduto;
    FUnidadeMedida         : String;

  private
    function fValidarBrindes(Var AMensagem : string) : Boolean;
    function fValidarClientProdutos(Var AMensagem : string) : Boolean;
    function fValidarGatilhos(var AMensagem : String) : Boolean;
    function fValidarBeneficiados(var AMensagem : String) : Boolean;
    function fValidarKits(var AMensagem : String) : Boolean;
    function fValidarProdutos(var AMensagem : String) : Boolean;
    procedure pAfterScrollCdsKit(DataSet: TDataSet);
    procedure pRefazerIdClientProdutoGatilho(AIdAntigoDoKit, AIdNovoDoKit : String);
    procedure pRefazerIdClientProdutoBeneficiado(AIdAntigoDoKit, AIdNovoDoKit : String);
    procedure pRefazerIdClientBrinde(AIdAntigoDoKit, AIdNovoDoKit : String);
  public
    Constructor Create;
    Destructor  Destroy; override;
    function fAdicionarBrinde(var AMensagem : String) : Boolean;
    function fAdicionarKit(var AMensagem : String) : Boolean;
    function fAdicionarProdutos(var AIdGerado, AMensagem : String) : Boolean;
    function fCarregarPromocao(AIdPromocao : String) : Boolean;
    function fSalvar(AIdPromocao : String) : Boolean;
    procedure pApagarKitDetalhes(AId : String; AtipoProduto : ttipoProduto; ACdsProdutosDaPromocao : TUniClientDataSet);
    procedure pFiltrarClientsProdutos;
    procedure pLimparBuilder;
    procedure pLimparClients;
    procedure pRefazerIds;

    property CdsBrinde             : TUniClientDataSet read FCdsBrinde             write FCdsBrinde;
    property CdsKit                : TUniClientDataSet read FCdsKit                write FCdsKit;
    property CdsProdutoBeneficiado : TUniClientDataSet read FCdsProdutoBeneficiado write FCdsProdutoBeneficiado;
    property CdsProdutoGatilho     : TUniClientDataSet read FCdsProdutoGatilho     write FCdsProdutoGatilho;
    property CodigoBrinde          : String            read FCodigoBrinde          write FCodigoBrinde;
    property Desconto              : Double            read FDesconto              write FDesconto;
    property DescricaoBrinde       : String            read FDescricaoBrinde       write FDescricaoBrinde;
    property DescricaoGrupo        : String            read FDescricaoGrupo        write FDescricaoGrupo;
    property DescricaoKit          : String            read FDescricaoKit          write FDescricaoKit;
    property Grupo                 : String            read FGrupo                 write FGrupo;
    property Quantidade            : Double            read FQuantidade            write FQuantidade;
    property QuantidadeBrinde      : Double            read FQuantidadeBrinde      write FQuantidadeBrinde;
    property TipoProduto           : ttipoProduto      read FtipoProduto           write FtipoProduto;
    property UnidadeMedida         : String            read FUnidadeMedida         write FUnidadeMedida;

  end;
implementation

uses untFuncoesSimples, System.Variants;

{ TKitPromocaoRepositorio }

constructor TKitPromocaoRepositorio.Create;
begin
  inherited;
  FQuery := fCriaQuery(Nil);
  pCriarClients;
end;

destructor TKitPromocaoRepositorio.Destroy;
begin
  if Assigned(FQuery) then
    FreeAndNil(FQuery);

  if Assigned(FCdsKit) then
    FreeAndNil(FCdsKit);

  if Assigned(FCdsProdutoGatilho) then
    FreeAndNil(FCdsProdutoGatilho);

  if Assigned(FCdsProdutoBeneficiado) then
    FreeAndNil(FCdsProdutoBeneficiado);

  if Assigned(FCdsBrinde) then
    FreeAndNil(FCdsBrinde);

  inherited;
end;

function TKitPromocaoRepositorio.fCarregarKit(AIdPromocao: String): Boolean;
begin
  Result := True;
  Try
    FQuery.Sql.Clear;
    FQuery.Sql.Text := ' SELECT * FROM CADKIT WHERE KIT_PROSEQ = :PROSEQ ';
    FQuery.ParamByName('PROSEQ').AsString := AIdPromocao;
    FQuery.Open;
    while not FQuery.Eof do
    Begin
      FCdsKit.Append;
      FCdsKit.FieldByName('AUTOINCREM').AsString := FQuery.FieldByName('AUTOINCREM').AsString;
      FCdsKit.FieldByName('KIT_PROSEQ').AsString := FQuery.FieldByName('KIT_PROSEQ').AsString;
      FCdsKit.FieldByName('KIT_DESCRI').AsString := FQuery.FieldByName('KIT_DESCRI').AsString;
      FCdsKit.Post;

      FQuery.Next;
    End;
    FQuery.Close;
  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.fCarregarPromocao]');
      Exit(False);
    end;
  End;
end;

function TKitPromocaoRepositorio.fCarregarKitBrinde(AIdPromocao: String): Boolean;
begin
  Result := True;

  Try
    FQuery.Sql.Clear;
    FQuery.Sql.Text := ' SELECT KITBRI.*, CADITE.ITE_DESITE BRI_DESITE '+
                       '   FROM KITBRI '+
                       '   JOIN CADITE ON KITBRI.BRI_CODITE = CADITE.ITE_CODITE '+
                       '   JOIN CADKIT ON KITBRI.BRI_SEQKIT = CADKIT.AUTOINCREM '+
                       '  WHERE CADKIT.KIT_PROSEQ = :PROSEQ ';
    FQuery.ParamByName('PROSEQ').AsString := AIdPromocao;
    FQuery.Open;
    while not FQuery.Eof do
    Begin
      FCdsBrinde.Append;
      FCdsBrinde.FieldByName('AUTOINCREM').AsString := FQuery.FieldByName('AUTOINCREM').AsString;
      FCdsBrinde.FieldByName('BRI_CODITE').AsString := FQuery.FieldByName('BRI_CODITE').AsString;
      FCdsBrinde.FieldByName('BRI_DESITE').AsString := FQuery.FieldByName('BRI_CODITE').AsString + '-' +
                                                       FQuery.FieldByName('BRI_DESITE').AsString;
      FCdsBrinde.FieldByName('BRI_QTDBRI').AsFloat  := FQuery.FieldByName('BRI_QTDBRI').AsFloat;
      FCdsBrinde.FieldByName('BRI_SEQKIT').AsString := FQuery.FieldByName('BRI_SEQKIT').AsString;
      FCdsBrinde.Post;

      FQuery.Next;
    End;
    FQuery.Close;
  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.fCarregarKitDetalhes]');
      Exit(False);
    end;
  End;
end;

function TKitPromocaoRepositorio.fCarregarKitDetalhes(AIdPromocao: String): Boolean;
begin
  Result := True;

  Try
    FQuery.Sql.Clear;
    FQuery.Sql.Text := ' SELECT KITDET.*, CADGRU.GRU_DESGRU DET_DESGRU '+
                       '   FROM KITDET '+
                       '   JOIN CADGRU ON KITDET.DET_CODGRU = CADGRU.GRU_CODGRU '+
                       '   JOIN CADKIT ON KITDET.DET_SEQKIT = CADKIT.AUTOINCREM '+
                       '  WHERE CADKIT.KIT_PROSEQ = :PROSEQ ';
    FQuery.ParamByName('PROSEQ').AsString := AIdPromocao;
    FQuery.Open;
    while not FQuery.Eof do
    Begin
      if FQuery.FieldByName('DET_TIPPRO').AsString = 'GATILHO' then
      Begin
        FCdsProdutoGatilho.Append;
        FCdsProdutoGatilho.FieldByName('AUTOINCREM').AsString := FQuery.FieldByName('AUTOINCREM').AsString;
        FCdsProdutoGatilho.FieldByName('DET_CODGRU').AsString := FQuery.FieldByName('DET_CODGRU').AsString;
        FCdsProdutoGatilho.FieldByName('DET_DESGRU').AsString := FQuery.FieldByName('DET_CODGRU').AsString + '-' +
                                                                 FQuery.FieldByName('DET_DESGRU').AsString;
        FCdsProdutoGatilho.FieldByName('DET_CODUNI').AsString := FQuery.FieldByName('DET_CODUNI').AsString;
        FCdsProdutoGatilho.FieldByName('DET_QTDGRU').AsFloat  := FQuery.FieldByName('DET_QTDGRU').AsFloat;
        FCdsProdutoGatilho.FieldByName('DET_PERDES').AsFloat  := FQuery.FieldByName('DET_PERDES').AsFloat;
        FCdsProdutoGatilho.FieldByName('DET_TIPPRO').AsString := FQuery.FieldByName('DET_TIPPRO').AsString;
        FCdsProdutoGatilho.FieldByName('DET_SEQKIT').AsString := FQuery.FieldByName('DET_SEQKIT').AsString;
        FCdsProdutoGatilho.Post;
      End
      Else
      Begin
        FCdsProdutoBeneficiado.Append;
        FCdsProdutoBeneficiado.FieldByName('AUTOINCREM').AsString := FQuery.FieldByName('AUTOINCREM').AsString;
        FCdsProdutoBeneficiado.FieldByName('DET_CODGRU').AsString := FQuery.FieldByName('DET_CODGRU').AsString;
        FCdsProdutoBeneficiado.FieldByName('DET_DESGRU').AsString := FQuery.FieldByName('DET_CODGRU').AsString + '-' +
                                                                     FQuery.FieldByName('DET_DESGRU').AsString;
        FCdsProdutoBeneficiado.FieldByName('DET_CODUNI').AsString := FQuery.FieldByName('DET_CODUNI').AsString;
        FCdsProdutoBeneficiado.FieldByName('DET_QTDGRU').AsFloat  := FQuery.FieldByName('DET_QTDGRU').AsFloat;
        FCdsProdutoBeneficiado.FieldByName('DET_PERDES').AsFloat  := FQuery.FieldByName('DET_PERDES').AsFloat;
        FCdsProdutoBeneficiado.FieldByName('DET_TIPPRO').AsString := FQuery.FieldByName('DET_TIPPRO').AsString;
        FCdsProdutoBeneficiado.FieldByName('DET_SEQKIT').AsString := FQuery.FieldByName('DET_SEQKIT').AsString;
        FCdsProdutoBeneficiado.Post;
      End;

      FQuery.Next;
    End;
    FQuery.Close;
  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.fCarregarKitDetalhes]');
      Exit(False);
    end;
  End;
end;

function TKitPromocaoRepositorio.fCarregarPromocao(AIdPromocao: String): Boolean;
begin
  Try
    Result := fCarregarKit(AIdPromocao);
    if Result then
      Result := fCarregarKitDetalhes(AIdPromocao);
    if Result then
      Result := fCarregarKitBrinde(AIdPromocao);
  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.fCarregarPromocao]');
      Exit(False);
    end;
  End;
end;

function TKitPromocaoRepositorio.fSalvar(AIdPromocao: String): Boolean;
begin
  Result := pApagarKits(AIdPromocao);
  if Result then
    Result := fSalvarKit(AIdPromocao);
  if Result then
    Result := fSalvarKitDetalhe;
  if Result then
    Result := fSalvarKitBrinde;
end;

function TKitPromocaoRepositorio.fSalvarKit(AIdPromocao : String) : Boolean;
begin
  Result := True;
  Try
    FQuery.Sql.Clear;
    FQuery.Sql.Text := ' INSERT INTO CADKIT (AUTOINCREM, KIT_PROSEQ, KIT_DESCRI) VALUES (:AUTINC, :PROSEQ, :DESCRI) ';

    FCdsKit.DisableControls;
    FCdsKit.First;
    While not FCdsKit.Eof do
    Begin
      FQuery.ParamByName('AUTINC').AsString := FCdsKit.FieldByName('AUTOINCREM').AsString;
      FQuery.ParamByName('PROSEQ').AsString := AIdPromocao;
      FQuery.ParamByName('DESCRI').AsString := FCdsKit.FieldByName('KIT_DESCRI').AsString;

      FQuery.ExecSql;

      FCdsKit.Next;
    End;

    FCdsKit.EnableControls;
  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.fSalvarKit]');
      Exit(False);
    end;
  End;
end;

function TKitPromocaoRepositorio.fSalvarKitBrinde: Boolean;
begin
  Result := True;
  Try
    FQuery.Sql.Clear;
    FQuery.Sql.Text := ' INSERT INTO KITBRI (AUTOINCREM, BRI_CODITE, BRI_QTDBRI, BRI_SEQKIT) VALUES '+
      '(:AUTINC, :CODITE, :QTDBRI, :SEQKIT) ';

    FCdsBrinde.Filtered := False;
    FCdsBrinde.DisableControls;
    FCdsBrinde.First;
    While not FCdsBrinde.Eof do
    Begin
      FQuery.ParamByName('AUTINC').AsString := FCdsBrinde.FieldByName('AUTOINCREM').AsString;
      FQuery.ParamByName('CODITE').AsString := FCdsBrinde.FieldByName('BRI_CODITE').AsString;
      FQuery.ParamByName('QTDBRI').AsString := FCdsBrinde.FieldByName('BRI_QTDBRI').AsString;
      FQuery.ParamByName('SEQKIT').AsString := FCdsBrinde.FieldByName('BRI_SEQKIT').AsString;

      FQuery.ExecSql;

      FCdsBrinde.Next;
    End;
    FCdsBrinde.EnableControls;
    FCdsBrinde.Filtered := True;

  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.fSalvarKitBrinde]');
      Exit(False);
    end;
  End;

end;

function TKitPromocaoRepositorio.fSalvarKitDetalhe: Boolean;
  var
    LIdx : Integer;
    LCdsProduto: TUniClientDataSet;
begin
  Result := True;
  Try
    FQuery.Sql.Clear;
    FQuery.Sql.Text := ' INSERT INTO KITDET (AUTOINCREM, DET_CODGRU, DET_CODUNI, DET_QTDGRU, DET_PERDES, DET_TIPPRO, DET_SEQKIT) VALUES '+
      '(:AUTINC, :CODGRU, :CODUNI, :QTDGRU, :PERDES, :TIPPRO, :SEQKIT) ';

    for LIdx := 1 to 2 do
    Begin
      if LIdx = 1 then
        LCdsProduto := FCdsProdutoGatilho
      else
        LCdsProduto := FCdsProdutoBeneficiado;

      LCdsProduto.Filtered := False;
      LCdsProduto.DisableControls;
      LCdsProduto.First;
      While not LCdsProduto.Eof do
      Begin
        FQuery.ParamByName('AUTINC').AsString := LCdsProduto.FieldByName('AUTOINCREM').AsString;
        FQuery.ParamByName('CODGRU').AsString := LCdsProduto.FieldByName('DET_CODGRU').AsString;
        FQuery.ParamByName('CODUNI').AsString := LCdsProduto.FieldByName('DET_CODUNI').AsString;
        FQuery.ParamByName('QTDGRU').AsFloat := LCdsProduto.FieldByName('DET_QTDGRU').AsFloat;
        FQuery.ParamByName('PERDES').AsFloat := LCdsProduto.FieldByName('DET_PERDES').AsFloat;
        FQuery.ParamByName('TIPPRO').AsString := LCdsProduto.FieldByName('DET_TIPPRO').AsString;
        FQuery.ParamByName('SEQKIT').AsString := LCdsProduto.FieldByName('DET_SEQKIT').AsString;

        FQuery.ExecSql;

        LCdsProduto.Next;
      End;
      LCdsProduto.EnableControls;
      LCdsProduto.Filtered := True;
    End;
  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.fSalvarKitDetalhe]');
      Exit(False);
    end;
  End;
end;

function TKitPromocaoRepositorio.pApagarKits(AIdPromocao: String): Boolean;
begin
  Result := True;
  Try
    FQuery.Sql.Clear;
    FQuery.Sql.Text := ' DELETE FROM CADKIT WHERE KIT_PROSEQ = :PROSEQ ';
    FQuery.ParamByName('PROSEQ').AsString := AIdPromocao;
    FQuery.ExecSql;
  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.pApagarKits]');
      Exit(False);
    end;
  End;
end;

procedure TKitPromocaoRepositorio.pCriarClients;
begin
  FCdsKit := TUniClientDataSet.Create(nil);
  FCdsKit.FieldDefs.Add('AUTOINCREM', ftString, 20, False);
  FCdsKit.FieldDefs.Add('KIT_PROSEQ', ftString, 20, False);
  FCdsKit.FieldDefs.Add('KIT_DESCRI', ftString, 100, False);
  FCdsKit.CreateDataSet;

  FCdsProdutoGatilho := TUniClientDataSet.Create(nil);
  FCdsProdutoGatilho.FieldDefs.Add('AUTOINCREM', ftString, 20, False);
  FCdsProdutoGatilho.FieldDefs.Add('DET_CODGRU', ftString, 20, False);
  FCdsProdutoGatilho.FieldDefs.Add('DET_DESGRU', ftString,100, False);
  FCdsProdutoGatilho.FieldDefs.Add('DET_CODUNI', ftString, 20, False);
  FCdsProdutoGatilho.FieldDefs.Add('DET_QTDGRU', ftfloat,   0, False);
  FCdsProdutoGatilho.FieldDefs.Add('DET_PERDES', ftfloat,   0, False);
  FCdsProdutoGatilho.FieldDefs.Add('DET_TIPPRO', ftString, 20, False);
  FCdsProdutoGatilho.FieldDefs.Add('DET_SEQKIT', ftString, 20, False);
  FCdsProdutoGatilho.CreateDataSet;

  FCdsProdutoBeneficiado := TUniClientDataSet.Create(nil);
  FCdsProdutoBeneficiado.FieldDefs.Add('AUTOINCREM', ftString, 20, False);
  FCdsProdutoBeneficiado.FieldDefs.Add('DET_CODGRU', ftString, 20, False);
  FCdsProdutoBeneficiado.FieldDefs.Add('DET_DESGRU', ftString,100, False);
  FCdsProdutoBeneficiado.FieldDefs.Add('DET_CODUNI', ftString, 20, False);
  FCdsProdutoBeneficiado.FieldDefs.Add('DET_QTDGRU', ftfloat,   0, False);
  FCdsProdutoBeneficiado.FieldDefs.Add('DET_PERDES', ftfloat,   0, False);
  FCdsProdutoBeneficiado.FieldDefs.Add('DET_TIPPRO', ftString, 20, False);
  FCdsProdutoBeneficiado.FieldDefs.Add('DET_SEQKIT', ftString, 20, False);
  FCdsProdutoBeneficiado.CreateDataSet;

  FCdsBrinde := TUniClientDataSet.Create(nil);
  FCdsBrinde.FieldDefs.Add('AUTOINCREM', ftString, 20, False);
  FCdsBrinde.FieldDefs.Add('BRI_CODITE', ftString, 20, False);
  FCdsBrinde.FieldDefs.Add('BRI_DESITE', ftString,100, False);
  FCdsBrinde.FieldDefs.Add('BRI_QTDBRI', ftfloat,   0, False);
  FCdsBrinde.FieldDefs.Add('BRI_SEQKIT', ftString, 20, False);
  FCdsBrinde.CreateDataSet;
end;

{ TKitPromocaoBuilder }

constructor TKitPromocaoBuilder.Create;
begin
  FobjRepositorio     := TKitPromocaoRepositorio.Create;

  FCdsKit             := FobjRepositorio.CdsKit;
  FCdsKit.AfterScroll := pAfterScrollCdsKit;

  FCdsProdutoGatilho      := FobjRepositorio.CdsProdutoGatilho;
  FCdsProdutoBeneficiado  := FobjRepositorio.CdsProdutoBeneficiado;
  FCdsBrinde              := FobjRepositorio.CdsBrinde;
end;

destructor TKitPromocaoBuilder.Destroy;
begin
  if Assigned(FobjRepositorio) then
    FreeAndNil(FobjRepositorio);
  inherited;
end;

function TKitPromocaoBuilder.fAdicionarBrinde(var AMensagem: String): Boolean;
begin
  Result := True;

  Try
    if not fValidarBrindes(AMensagem) then
      Exit(False);

    FCdsBrinde.Append;
    FCdsBrinde.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('KITBRI', VS_strCodEmp);
    FCdsBrinde.FieldByName('BRI_CODITE').AsString := FCodigoBrinde;
    FCdsBrinde.FieldByName('BRI_DESITE').AsString := FCodigoBrinde +' - ' + FDescricaoBrinde;
    FCdsBrinde.FieldByName('BRI_QTDBRI').AsFloat  := FQuantidadeBrinde;
    FCdsBrinde.FieldByName('BRI_SEQKIT').AsString := FCdsKit.FieldByName('AUTOINCREM').AsString;
    FCdsBrinde.Post;

    pFiltrarClientsProdutos;
  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.fAdicionarBrinde]');
      Exit(False);
    end;
  End;
end;

function TKitPromocaoBuilder.fAdicionarKit(var AMensagem: String): Boolean;
begin
  Result := True;

  Try
     if not fValidarKits(AMensagem) then
      Exit(False);

    FCdsKit.Append;
    FCdsKit.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADKIT', VS_strCodEmp);
    FCdsKit.FieldByName('KIT_DESCRI').AsString := FDescricaoKit;
    FCdsKit.Post;

    FDescricaoKit := '';
  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.fAdicionarKit]');
      Exit(False);
    end;
  End;
end;

function TKitPromocaoBuilder.fAdicionarProdutos(var AIdGerado, AMensagem: String): Boolean;
begin
  Result := True;

  Try
    if not fValidarProdutos(AMensagem) then
      Exit(False);

    AIdGerado := fRetAutoIncrem('KITDET', VS_strCodEmp);

    if FTipoProduto = ttpGatilho then
    Begin
      FCdsProdutoGatilho.Append;
      FCdsProdutoGatilho.FieldByName('AUTOINCREM').AsString := AIdGerado;
      FCdsProdutoGatilho.FieldByName('DET_CODGRU').AsString := FGrupo;
      FCdsProdutoGatilho.FieldByName('DET_DESGRU').AsString := FGrupo +' - ' + FDescricaoGrupo;
      FCdsProdutoGatilho.FieldByName('DET_CODUNI').AsString := FUnidadeMedida;
      FCdsProdutoGatilho.FieldByName('DET_QTDGRU').AsFloat  := FQuantidade;
      FCdsProdutoGatilho.FieldByName('DET_PERDES').AsFloat  := FDesconto;
      FCdsProdutoGatilho.FieldByName('DET_TIPPRO').AsString := 'GATILHO';
      FCdsProdutoGatilho.FieldByName('DET_SEQKIT').AsString := FCdsKit.FieldByName('AUTOINCREM').AsString;
      FCdsProdutoGatilho.Post;
    End
    Else
    if FTipoProduto = ttpBeneficiado then
    Begin

      if fEmptyStr(FGrupo) then
        Exit(True);

      FCdsProdutoBeneficiado.Append;
      FCdsProdutoBeneficiado.FieldByName('AUTOINCREM').AsString := AIdGerado;
      FCdsProdutoBeneficiado.FieldByName('DET_CODGRU').AsString := FGrupo;
      FCdsProdutoBeneficiado.FieldByName('DET_DESGRU').AsString := FGrupo +' - ' + FDescricaoGrupo;
      FCdsProdutoBeneficiado.FieldByName('DET_CODUNI').AsString := FUnidadeMedida;
      FCdsProdutoBeneficiado.FieldByName('DET_PERDES').AsFloat  := FDesconto;
      FCdsProdutoBeneficiado.FieldByName('DET_QTDGRU').AsFloat  := FQuantidade;
      FCdsProdutoBeneficiado.FieldByName('DET_TIPPRO').AsString := 'BENEFICIADO';
      FCdsProdutoBeneficiado.FieldByName('DET_SEQKIT').AsString := FCdsKit.FieldByName('AUTOINCREM').AsString;
      FCdsProdutoBeneficiado.Post;
    End;

    pFiltrarClientsProdutos;

  Except
    On E: Exception Do
    begin
      pMensagensErro(e.Message, '[TKitPromocaoRepositorio.fAdicionarKit]');
      Exit(False);
    end;
  End;
end;

function TKitPromocaoBuilder.fValidarBeneficiados(var AMensagem: String): Boolean;
  var
    LcdsGatilho,
    LcdsBeneficiado : TuniClientDataSet;
begin
  Result := True;

  LcdsGatilho := TuniClientDataSet.Create(Nil);
  pCloneDataSet(LcdsGatilho, FCdsProdutoGatilho);
  LcdsGatilho.Filtered := False;

  LcdsBeneficiado := TuniClientDataSet.Create(Nil);
  pCloneDataSet(LcdsBeneficiado, FCdsProdutoBeneficiado);
  LcdsBeneficiado.Filtered := False;

  Try
    if LcdsGatilho.Locate('DET_CODGRU;DET_CODUNI',
                   VarArrayOf([FGrupo, FUnidadeMedida]),
                   []) then
    Begin
      AMensagem := 'Grupo\Unidade informada como beneficiado já é gatilho neste ou de outro kit. Este conjunto não pode assumir '+
      'as duas funções na mesma promoção.';
      Exit(False);
    End;

    if LcdsBeneficiado.Locate('DET_SEQKIT;DET_CODGRU;DET_CODUNI',
                   VarArrayOf([FCdsKit.FieldByName('AUTOINCREM').AsString, FGrupo, FUnidadeMedida]),
                   []) then
    Begin
      AMensagem := 'Grupo\Unidade informada como beneficiado já está presente neste kit.';
      Exit(False);
    End;
  Finally
    FreeAndNil(LcdsGatilho);
    FreeAndNil(LcdsBeneficiado);
  End;
end;

function TKitPromocaoBuilder.fValidarBrindes(var AMensagem: string): Boolean;
begin
  Result := True;

  if fEmptyStr(FCdsKit.FieldByName('AUTOINCREM').AsString) then
  Begin
    AMensagem := 'É necessário criar um Kit antes de adicionar produtos.';
    Exit(False);
  End;

  FCdsBrinde.DisableControls;
  FCdsBrinde.First;
  while not FCdsBrinde.Eof do
  Begin
    if FCdsBrinde.FieldByName('BRI_CODITE').AsString   = FCodigoBrinde then
    Begin
      AMensagem := 'Brinde já informado para este Kit.';
      FCdsBrinde.EnableControls;
      Exit(False);
    End;
    FCdsBrinde.Next;
  End;
  FCdsBrinde.EnableControls;
end;

function TKitPromocaoBuilder.fValidarClientProdutos(var AMensagem: string): Boolean;
begin
  Result := True;

  if FTipoProduto = ttpGatilho then
  begin
    if not fValidarGatilhos(AMensagem) then
      Exit(False);
  end
  Else
  Begin
    if not fValidarBeneficiados(AMensagem) then
      Exit(False);
  End;
end;

function TKitPromocaoBuilder.fValidarGatilhos(var AMensagem: String): Boolean;
  var
    LcdsGatilho ,
    LcdsBeneficiado : TuniClientDataSet;
begin
  Result := True;

  LcdsGatilho := TuniClientDataSet.Create(Nil);
  pCloneDataSet(LcdsGatilho, FCdsProdutoGatilho);
  LcdsGatilho.Filtered := False;

  LcdsBeneficiado := TuniClientDataSet.Create(Nil);
  pCloneDataSet(LcdsBeneficiado, FCdsProdutoBeneficiado);
  LcdsBeneficiado.Filtered := False;

  Try
    if LcdsGatilho.Locate('DET_CODGRU;DET_CODUNI;DET_QTDGRU',
                   VarArrayOf([FGrupo, FUnidadeMedida, FQuantidade]),
                   []) then
    Begin
      AMensagem := 'Grupo\Unidade\Quantidade informada como gatilho já está presente nesta promoção.';
      Exit(False);
    End;

    if LcdsGatilho.Locate('DET_SEQKIT;DET_CODGRU;DET_CODUNI',
                   VarArrayOf([FCdsKit.FieldByName('AUTOINCREM').AsString, FGrupo, FUnidadeMedida]),
                   []) then
    Begin
      AMensagem := 'Grupo\Unidade informada como gatilho já está presente neste kit.';
      Exit(False);
    End;

    if LcdsBeneficiado.Locate('DET_CODGRU;DET_CODUNI',
                   VarArrayOf([FGrupo, FUnidadeMedida]),
                   []) then
    Begin
      AMensagem := 'Grupo\Unidade informada como gatilho já é beneficiado neste ou de outro kit. Este conjunto não pode assumir '+
      'as duas funções na mesma promoção.';
      Exit(False);
    End;
  Finally
    FreeAndNil(LcdsGatilho);
    FreeAndNil(LcdsBeneficiado);
  End;

end;

function TKitPromocaoBuilder.fValidarKits(var AMensagem: String): Boolean;
begin
  Result := True;

  FCdsKit.DisableControls;
  FCdsKit.First;

  while not FCdsKit.Eof do
  Begin
    if FCdsKit.FieldByName('KIT_DESCRI').AsString   = FDescricaoKit then
    Begin
      AMensagem := 'Descrição para Kit já informada para essa promoção.';
      FCdsKit.EnableControls;
      Exit(False);
    End;
    FCdsKit.Next;
  End;

  FCdsKit.EnableControls;
end;

function TKitPromocaoBuilder.fValidarProdutos(var AMensagem: String): Boolean;
begin
  if fEmptyStr(FCdsKit.FieldByName('AUTOINCREM').AsString) then
  Begin
    AMensagem := 'É necessário criar um Kit antes de adicionar produtos.';
    Exit(False);
  End;

  Result := fValidarClientProdutos(AMensagem);
end;

procedure TKitPromocaoBuilder.pAfterScrollCdsKit(DataSet: TDataSet);
begin
  pFiltrarClientsProdutos;
end;

procedure TKitPromocaoBuilder.pApagarKitDetalhes(AId : String; AtipoProduto : ttipoProduto; ACdsProdutosDaPromocao : TUniClientDataSet);
  var
    LCds : TUniClientDataSet;
begin
  if AtipoProduto = ttpGatilho then
    LCds := FCdsProdutoGatilho
  Else
    LCds := FCdsProdutoBeneficiado;

  if LCds.Locate('AUTOINCREM', AId, []) then
  Begin
    LCds.Delete;

    ACdsProdutosDaPromocao.DisableControls;
    ACdsProdutosDaPromocao.Last;
    while not ACdsProdutosDaPromocao.Bof do
    Begin
      if ACdsProdutosDaPromocao.FieldByName('IPR_SEQKIT').AsString = AId then
        ACdsProdutosDaPromocao.Delete
      else
        ACdsProdutosDaPromocao.Prior;
    End;
    ACdsProdutosDaPromocao.EnableControls;
  End;

  pFiltrarClientsProdutos;
end;

function TKitPromocaoBuilder.fCarregarPromocao(AIdPromocao : String) : Boolean;
begin
  pLimparClients;
  Result := FobjRepositorio.fCarregarPromocao(AIdPromocao);
end;

function TKitPromocaoBuilder.fSalvar(AIdPromocao: String): Boolean;
begin
  Result := FobjRepositorio.fSalvar(AIdPromocao);
end;

procedure TKitPromocaoBuilder.pFiltrarClientsProdutos;
begin
  FCdsProdutoGatilho.Filter   := 'DET_SEQKIT = ' + QuotedStr(FCdsKit.FieldByName('AUTOINCREM').AsString);
  If (Not FCdsProdutoGatilho.Filtered) Then
    FCdsProdutoGatilho.Filtered := True;

  FCdsProdutoBeneficiado.Filter   := 'DET_SEQKIT = ' + QuotedStr(FCdsKit.FieldByName('AUTOINCREM').AsString);
  If (Not FCdsProdutoBeneficiado.Filtered) Then
    FCdsProdutoBeneficiado.Filtered := True;

  if FCdsBrinde.Filtered Then
    FCdsBrinde.Filtered := False;
  FCdsBrinde.Filter   := 'BRI_SEQKIT = ' + QuotedStr(FCdsKit.FieldByName('AUTOINCREM').AsString);
  If (Not FCdsBrinde.Filtered) Then
    FCdsBrinde.Filtered := True;
end;

procedure TKitPromocaoBuilder.pLimparBuilder;
begin
  FGrupo             := '';
  FUnidadeMedida     := '';
  FQuantidade        := 0;
  FDesconto          := 0;
  FTipoProduto       := tpNenhum;
  FCodigoBrinde      := '';
  FDescricaoBrinde   := '';
  FQuantidadeBrinde  := 0;
end;

procedure TKitPromocaoBuilder.pLimparClients;
begin
  FCdsKit.EmptyDataSet;
  FCdsProdutoGatilho.EmptyDataSet;
  FCdsProdutoBeneficiado.EmptyDataSet;
  FCdsBrinde.EmptyDataSet;
end;

procedure TKitPromocaoBuilder.pRefazerIds;
  var
    LIdAntigo : String;
begin
  FCdsKit.DisableControls;
  FCdsProdutoGatilho.DisableControls;
  FCdsProdutoBeneficiado.DisableControls;
  FCdsBrinde.DisableControls;

  FCdsKit.First;
  while not FCdsKit.Eof do
  Begin
    LIdAntigo := FCdsKit.FieldByName('AUTOINCREM').AsString;

    FCdsKit.Edit;
    FCdsKit.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADKIT', VS_strCodEmp);
    FCdsKit.Post;

    pRefazerIdClientBrinde(LIdAntigo, FCdsKit.FieldByName('AUTOINCREM').AsString);
    pRefazerIdClientProdutoBeneficiado(LIdAntigo, FCdsKit.FieldByName('AUTOINCREM').AsString);
    pRefazerIdClientProdutoGatilho(LIdAntigo, FCdsKit.FieldByName('AUTOINCREM').AsString);

    FCdsKit.Next;
  End;

  FCdsKit.EnableControls;
  FCdsProdutoGatilho.EnableControls;
  FCdsProdutoBeneficiado.EnableControls;
  FCdsBrinde.EnableControls;
end;

procedure TKitPromocaoBuilder.pRefazerIdClientBrinde(AIdAntigoDoKit, AIdNovoDoKit: String);
begin
  FCdsBrinde.First;
  while not FCdsBrinde.Eof do
  Begin
    if FCdsBrinde.FieldByName('BRI_SEQKIT').AsString = AIdAntigoDoKit then
    Begin
      FCdsBrinde.Edit;
      FCdsBrinde.FieldByName('BRI_SEQKIT').AsString := AIdNovoDoKit;
      FCdsBrinde.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('KITBRI', VS_strCodEmp);
      FCdsBrinde.Post;
    End;

    FCdsBrinde.Next;
  End;
end;

procedure TKitPromocaoBuilder.pRefazerIdClientProdutoBeneficiado(AIdAntigoDoKit, AIdNovoDoKit: String);
begin
  FCdsProdutoBeneficiado.First;
  while not FCdsProdutoBeneficiado.Eof do
  Begin
    if FCdsProdutoBeneficiado.FieldByName('DET_SEQKIT').AsString = AIdAntigoDoKit then
    Begin
      FCdsProdutoBeneficiado.Edit;
      FCdsProdutoBeneficiado.FieldByName('DET_SEQKIT').AsString := AIdNovoDoKit;
      FCdsProdutoBeneficiado.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('KITDET', VS_strCodEmp);
      FCdsProdutoBeneficiado.Post;
    End;

    FCdsProdutoBeneficiado.Next;
  End;
end;

procedure TKitPromocaoBuilder.pRefazerIdClientProdutoGatilho(AIdAntigoDoKit, AIdNovoDoKit: String);
begin
  FCdsProdutoGatilho.First;
  while not FCdsProdutoGatilho.Eof do
  Begin
    if FCdsProdutoGatilho.FieldByName('DET_SEQKIT').AsString = AIdAntigoDoKit then
    Begin
      FCdsProdutoGatilho.Edit;
      FCdsProdutoGatilho.FieldByName('DET_SEQKIT').AsString := AIdNovoDoKit;
      FCdsProdutoGatilho.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('KITDET', VS_strCodEmp);
      FCdsProdutoGatilho.Post;
    End;

    FCdsProdutoGatilho.Next;
  End;
end;

end.
