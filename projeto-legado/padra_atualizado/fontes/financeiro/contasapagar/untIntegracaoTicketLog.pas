unit untIntegracaoTicketLog;

interface
  uses
    System.SysUtils,
    System.Classes,
    System.StrUtils,
    System.Generics.Collections,
    Uni,
    UniClientDataSet,
    UniDataSetProvider,
    untTValidaExcel;

type
  TRetornoIntegracao = record
    ConcluidoComSucesso : Boolean;
    QuantidadeRegistrosInseridos : Integer;
    QuantidadeRegistrosComErro : Integer;
    QuantidadeRegistrosIgnorados : Integer;
  end;

  THeaderIntegracaoTicketLog = class
    private
      FIDTipoRegistro : String;
      FCNPJEmissor : String;
      FIdentificacaoEmissor : String;
      FDataPrimeiroRegistro : String;
      FHoraPrimeiroRegistro : String;
      FDataUltimoRegistro : String;
      FHoraUltimoRegistro : String;
      FDataHoraGeracaoArquivo : String;
      FPeriodoApuracaoInformacao : String;
    public
      property IDTipoRegistro : String read FIDTipoRegistro write FIDTipoRegistro;
      property CNPJEmissor : String read FCNPJEmissor write FCNPJEmissor;
      property IdentificacaoEmissor : String read FIdentificacaoEmissor write FIdentificacaoEmissor;
      property DataPrimeiroRegistro : String read FDataPrimeiroRegistro write FDataPrimeiroRegistro;
      property HoraPrimeiroRegistro : String read FHoraPrimeiroRegistro write FHoraPrimeiroRegistro;
      property DataUltimoRegistro : String read FDataUltimoRegistro write FDataUltimoRegistro;
      property HoraUltimoRegistro : String read FHoraUltimoRegistro write FHoraUltimoRegistro;
      property DataHoraGeracaoArquivo : String read FDataHoraGeracaoArquivo write FDataHoraGeracaoArquivo;
      property PeriodoApuracaoInformacao : String read FPeriodoApuracaoInformacao write FPeriodoApuracaoInformacao;
      constructor Create;
  end;

  TDetalheIntegracaoTicketLog = class
    private
      FIDTipoRegistro : String;
      FNumeroSequencial : String;
      FDataTransacao : String;
      FValorEmReais : String;
      FNumeroCartao : String;
      FQuantidadeMaterialUsado : String;
      FTipoMaterial  : String;
      FCodigoServico : String;
      FTipoAbastecimento : String;
      FPlacaVeiculo : String;
      FHodometroVeiculoNoAbastecimento : String;
      FCNPJEstabelecimento : String;
      FNomeEstabelecimento : String;
      FInformacaoAdicional1 : String;
      FInformacaoAdicional2 : String;
      FInformacaoAdicional3 : String;
      FMatriculaMotorista : String;
    public
      property IDTipoRegistro : String read FIDTipoRegistro write FIDTipoRegistro;
      property NumeroSequencial : String read FNumeroSequencial write FNumeroSequencial;
      property DataTransacao : String read FDataTransacao write FDataTransacao;
      property ValorEmReais : String read FValorEmReais write FValorEmReais;
      property NumeroCartao : String read FNumeroCartao write FNumeroCartao;
      property QuantidadeMaterialUsado : String read FQuantidadeMaterialUsado write FQuantidadeMaterialUsado;
      property TipoMaterial  : String read FTipoMaterial write FTipoMaterial;
      property CodigoServico : String read FCodigoServico write FCodigoServico;
      property TipoAbastecimento : String read FTipoAbastecimento write FTipoAbastecimento;
      property PlacaVeiculo : String read FPlacaVeiculo write FPlacaVeiculo;
      property HodometroVeiculoNoAbastecimento : String read FHodometroVeiculoNoAbastecimento write FHodometroVeiculoNoAbastecimento;
      property CNPJEstabelecimento : String read FCNPJEstabelecimento write FCNPJEstabelecimento;
      property NomeEstabelecimento : String read FNomeEstabelecimento write FNomeEstabelecimento;
      property InformacaoAdicional1 : String read FInformacaoAdicional1 write FInformacaoAdicional1;
      property InformacaoAdicional2 : String read FInformacaoAdicional2 write FInformacaoAdicional2;
      property InformacaoAdicional3 : String read FInformacaoAdicional3 write FInformacaoAdicional3;
      property MatriculaMotorista : String read FMatriculaMotorista write FMatriculaMotorista;
      function GetNumeroDuplicata(AModelo : Integer) : String;
      function GetHistorico : String;
      function GetFornecedorPorCnpj : String;
      function GetCompetencia : String;
      constructor Create;
  end;

  TListDetalheIntegracaoTicketLog = TObjectList<TDetalheIntegracaoTicketLog>;

  TTrailerIntegracaoTicketLog = class
    private
      FIDTipoRegistro : String;
      FQuantidadeRegistrosEnviados : String;
      FTotalizadorMaterialUsado : String;
      FTotalizadorValorEmReais : String;
    public
      property IDTipoRegistro : String read FIDTipoRegistro write FIDTipoRegistro;
      property QuantidadeRegistrosEnviados : String read FQuantidadeRegistrosEnviados write FQuantidadeRegistrosEnviados;
      property TotalizadorMaterialUsado : String read FTotalizadorMaterialUsado write FTotalizadorMaterialUsado;
      property TotalizadorValorEmReais : String read FTotalizadorValorEmReais write FTotalizadorValorEmReais;
      constructor Create;
  end;

  TProcessaTxt = class
    private
      FIgnoraPrimeiraLinha : Boolean;
      FHeaderIntegracao : THeaderIntegracaoTicketLog;
      FDetalheIntegracao : TListDetalheIntegracaoTicketLog;
      FTrailerIntegracao : TTrailerIntegracaoTicketLog;
      FArquivoImportacao : TStringList;
      function ProcessarLinha(ALinha : String) : Boolean;
      function LinhaEhHeader(ALinha : String) : Boolean;
      function ProcessarHeader(ALinha : String) : Boolean;
      function LinhaEhDetalhe(ALinha : String) : Boolean;
      function ProcessarDetalhe(ALinha : String) : Boolean;
      function LinhaEhTrailer(ALinha : String) : Boolean;
      function ProcessarTrailer(ALinha : String) : Boolean;
      function SelecionadoArquivoValido(ACaminhoArquivo : String) : Boolean;
    public
      property IgnoraPrimeiraLinha: Boolean read FIgnoraPrimeiraLinha write FIgnoraPrimeiraLinha;
      property HeaderIntegracao : THeaderIntegracaoTicketLog read FHeaderIntegracao write FHeaderIntegracao;
      property DetalheIntegracao : TListDetalheIntegracaoTicketLog read FDetalheIntegracao write FDetalheIntegracao;
      property TrailerIntegracao : TTrailerIntegracaoTicketLog read FTrailerIntegracao write FTrailerIntegracao;
      constructor Create;
      function ImportarArquivo(ACaminhoArquivo : String; AIgnoraPrimeiraLinha : Boolean = True) : Boolean;
      function ProcessarArquivo : Boolean;
      destructor Destroy; override;
  end;

  TProcessaCSV = class
    private
      FIgnoraPrimeiraLinha : Boolean;
      FDetalheIntegracao : TListDetalheIntegracaoTicketLog;
      FArquivoImportacao : TStringList;
      function ProcessarLinha(ALinha : String) : Boolean;
      function LinhaEhHeader(ALinha : String) : Boolean;
      function LinhaEhDetalhe(ALinha : String) : Boolean;
      function LinhaEhTrailer(ALinha : String) : Boolean;
      function ProcessarDetalhe(ALinha : String) : Boolean;
      function SelecionadoArquivoValido(ACaminhoArquivo : String) : Boolean;
    public
      property IgnoraPrimeiraLinha: Boolean read FIgnoraPrimeiraLinha write FIgnoraPrimeiraLinha;
      property DetalheIntegracao : TListDetalheIntegracaoTicketLog read FDetalheIntegracao write FDetalheIntegracao;
      constructor Create;
      function ImportarArquivo(ACaminhoArquivo : String; AIgnoraPrimeiraLinha : Boolean = True) : Boolean;
      function ProcessarArquivo : Boolean;
      destructor Destroy; override;
  end;

  TIntegracaoTicketLog = class
    private
      FExtensaoImportada : Integer;
      FProcessaTxt : TProcessaTxt;
      FProcessaCsv : TProcessaCSV;
      const
        FExtensoesPermitidas: array[0..1] of string = ('.csv', '.txt');
      function SelecionadaExtensaoPermitida(ACaminhoArquivo : String) : Boolean;
      function SelecionadoArquivoValido(ACaminhoArquivo : String; FExtensaoImportada : Integer) : Boolean;
      function DuplicataExiste(ANumeroDuplicata : String; ACodigoEmpresa : String;
        AParcela : String; ACodigoFornecedor : String; ASerie : String): Boolean;
    public
      constructor Create;
      function ImportarArquivo(ACaminhoArquivo : String; AIgnoraPrimeiraLinha : Boolean = True) : Boolean;
      function ProcessarArquivo : Boolean;
      function LancarTitulosContasPagar(AUniQuery : TUniQuery) : TRetornoIntegracao;
      function fAgrupaDetalhesPorPlaca(ADetalhe: TListDetalheIntegracaoTicketLog): TListDetalheIntegracaoTicketLog;
      procedure BaixarTitulosImportados;
      destructor Destroy; override;
  end;

implementation

  uses
    untFuncoesSimples,
    untFuncoes,
    untBaixaCtaPagar;

{ THeaderIntegracaoTicketLog }

constructor THeaderIntegracaoTicketLog.Create;
begin
  inherited Create;
  FIDTipoRegistro := '000';
  FCNPJEmissor := EmptyStr;
  FIdentificacaoEmissor := EmptyStr;
  FDataPrimeiroRegistro := EmptyStr;
  FHoraPrimeiroRegistro := EmptyStr;
  FDataUltimoRegistro := EmptyStr;
  FHoraUltimoRegistro := EmptyStr;
  FDataHoraGeracaoArquivo := EmptyStr;
  FPeriodoApuracaoInformacao := EmptyStr;
end;

{ TDetalheIntegracaoTicketLog }

constructor TDetalheIntegracaoTicketLog.Create;
begin
  inherited Create;
  FIDTipoRegistro := '100';
  FNumeroSequencial := EmptyStr;
  FDataTransacao := EmptyStr;
  FValorEmReais := EmptyStr;
  FNumeroCartao := EmptyStr;
  FQuantidadeMaterialUsado := EmptyStr;
  FTipoMaterial  := EmptyStr;
  FCodigoServico := EmptyStr;
  FTipoAbastecimento := EmptyStr;
  FPlacaVeiculo := EmptyStr;
  FHodometroVeiculoNoAbastecimento := EmptyStr;
  FCNPJEstabelecimento := EmptyStr;
  FNomeEstabelecimento := EmptyStr;
  FInformacaoAdicional1 := EmptyStr;
  FInformacaoAdicional2 := EmptyStr;
  FInformacaoAdicional3 := EmptyStr;
  FMatriculaMotorista := EmptyStr;
end;

function TDetalheIntegracaoTicketLog.GetCompetencia: String;
var
  LDataFormatada : TDateTime;
begin
  Result := FormatDateTime('mm/yyyy', VS_Date);
  if Length(FDataTransacao) = 8 then
  begin
    LDataFormatada := EncodeDate(StrToInt(Copy(FDataTransacao, 5, 4)),
                                 StrToInt(Copy(FDataTransacao, 3, 2)),
                                 StrToInt(Copy(FDataTransacao, 1, 2)));

    Result := FormatDateTime('mm/yyyy', LDataFormatada);
  end;
end;

function TDetalheIntegracaoTicketLog.GetFornecedorPorCnpj: String;
begin
  Result := EmptyStr;
  if not fEmptyStr(FCNPJEstabelecimento) then
    Result := fCampoTabela('FOR_CODFOR','CADFOR', ['FOR_CODEMP','FOR_C_G_C_'], [VS_strCodEmp, FCNPJEstabelecimento], False);

  if fEmptyStr(Result) then
  begin
    Result := fCfgSis('FORTKT', varString);

    if fEmptyStr(Result) then
      raise Exception.Create('Fornecedor não definido no arquivo de importação e Fornecedor padrão não definido ("FORTKT").');
  end;
end;

function TDetalheIntegracaoTicketLog.GetHistorico: String;
begin
  Result := 'Informação Adicional 1: ' + FInformacaoAdicional1 + sLineBreak +
            'Informação Adicional 1: ' + FInformacaoAdicional2 + sLineBreak +
            'Informação Adicional 1: ' + FInformacaoAdicional3 + sLineBreak +
            'Numero Cartão: ' + FNumeroCartao;
end;

function TDetalheIntegracaoTicketLog.GetNumeroDuplicata(AModelo : Integer) : String;
begin
  case AModelo of
    0: Result := fStrZero(NumeroSequencial, 12);
    1: Result := fStrZero(FDataTransacao + FNumeroSequencial, 12);
    else
      raise Exception.Create('Extensão de arquivo não suportada.');
  end;
end;

{ TTrailerIntegracaoTicketLog }

constructor TTrailerIntegracaoTicketLog.Create;
begin
  inherited Create;
  FIDTipoRegistro := '200';
  FQuantidadeRegistrosEnviados := EmptyStr;
  FTotalizadorMaterialUsado := EmptyStr;
  FTotalizadorValorEmReais := EmptyStr;
end;

{ TIntegracaoTicketLog }

constructor TIntegracaoTicketLog.Create;
begin
  inherited Create;

  FProcessaTxt := TProcessaTxt.Create;
  FProcessaCsv := TProcessaCSV.Create;
end;

destructor TIntegracaoTicketLog.Destroy;
begin
  if Assigned(FProcessaTxt) Then
    FreeAndNil(FProcessaTxt);

  if Assigned(FProcessaCsv) Then
    FreeAndNil(FProcessaCsv);

  inherited Destroy;
end;

function TIntegracaoTicketLog.DuplicataExiste(ANumeroDuplicata : String;
  ACodigoEmpresa : String; AParcela : String; ACodigoFornecedor : String; ASerie : String): Boolean;
Var
  LSQL: String;
  LQryCtp: TUniQuery;
begin
  LQryCtp := fCriaQuery(Nil);
  try
    LSQL := '';
    LSQL := LSQL + 'SELECT SQL_NO_CACHE ';
    LSQL := LSQL + '  CTP_NUMDUP ';
    LSQL := LSQL + 'FROM ';
    LSQL := LSQL + '  CADPAG ';
    LSQL := LSQL + 'WHERE ';
    LSQL := LSQL + '  CTP_NUMDUP =:NUMDUP AND ';
    LSQL := LSQL + '  CTP_CODEMP =:CODEMP AND ';
    LSQL := LSQL + '  CTP_PARCEL =:PARCEL AND ';
    LSQL := LSQL + '  CTP_CODFOR =:CODFOR     ';
    LSQL := LSQL + '  AND CTP_SERIE_ =:SERIE_ ';

    LQryCtp.Close;
    LQryCtp.SQL.Clear;
    LQryCtp.SQL.Add(LSQL);
    LQryCtp.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    LQryCtp.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LQryCtp.ParamByName('PARCEL').AsString := AParcela;
    LQryCtp.ParamByName('CODFOR').AsString := ACodigoFornecedor;
    LQryCtp.ParamByName('SERIE_').AsString := ASerie;
    LQryCtp.Open;

    Result := Not LQryCtp.IsEmpty;
  finally
    FreeAndNil(LQryCtp);
  end;
end;

function TIntegracaoTicketLog.SelecionadaExtensaoPermitida(ACaminhoArquivo: String): Boolean;
var
  LContador : Integer;
  LExtensao : String;
begin
  Result := False;
  FExtensaoImportada := -1;

  if fEmptyStr(ACaminhoArquivo) then
    Exit;

  LExtensao := LowerCase(ExtractFileExt(ACaminhoArquivo));
  for LContador := Low(FExtensoesPermitidas) to High(FExtensoesPermitidas) do
  begin
    Result := (LExtensao = FExtensoesPermitidas[LContador]);
    if Result Then
    begin
      FExtensaoImportada := LContador;
      Exit;
    end;
  end;

end;

function TIntegracaoTicketLog.SelecionadoArquivoValido(ACaminhoArquivo: String;
  FExtensaoImportada: Integer): Boolean;
begin
  case FExtensaoImportada of
    0 : Result := FProcessaCsv.SelecionadoArquivoValido(ACaminhoArquivo);
    1 : Result := FProcessaTxt.SelecionadoArquivoValido(ACaminhoArquivo);
    else
      raise Exception.Create('Extensão de arquivo não suportada.');
  end;
end;

function TIntegracaoTicketLog.ImportarArquivo(ACaminhoArquivo: String; AIgnoraPrimeiraLinha: Boolean = True): Boolean;
begin
  Result := False;

  if fEmptyStr(ACaminhoArquivo) then
    Exit;

  if not FileExists(ACaminhoArquivo) then
    Exit;

  if not SelecionadaExtensaoPermitida(ACaminhoArquivo) then
    Exit;

  if not SelecionadoArquivoValido(ACaminhoArquivo, FExtensaoImportada) then
    Exit;

  case FExtensaoImportada of
    0 : Result := FProcessaCsv.ImportarArquivo(ACaminhoArquivo, AIgnoraPrimeiraLinha);
    1 : Result := FProcessaTxt.ImportarArquivo(ACaminhoArquivo, AIgnoraPrimeiraLinha);
    else
      raise Exception.Create('Extensão de arquivo não suportada.');
  end;
end;

Function TIntegracaoTicketLog.fAgrupaDetalhesPorPlaca(ADetalhe: TListDetalheIntegracaoTicketLog): TListDetalheIntegracaoTicketLog;
var
  LRegistro, LExistente: TDetalheIntegracaoTicketLog;
  LDetalheAgrupada: TListDetalheIntegracaoTicketLog;
  LPlacas: TDictionary<string, TDetalheIntegracaoTicketLog>;
  LValorNovo, LValorAtual: double;
Begin
  LDetalheAgrupada := TListDetalheIntegracaoTicketLog.Create();
  LPlacas := TDictionary<string, TDetalheIntegracaoTicketLog>.Create;
  Try
    For LRegistro in ADetalhe Do
    Begin
      If not LPlacas.ContainsKey(LRegistro.PlacaVeiculo) Then
      Begin
        // Clona o objeto
        LExistente := TDetalheIntegracaoTicketLog.Create;

        LExistente.IDTipoRegistro := LRegistro.IDTipoRegistro;
        LExistente.NumeroSequencial := LRegistro.NumeroSequencial;
        LExistente.DataTransacao := LRegistro.DataTransacao;
        LExistente.ValorEmReais := LRegistro.ValorEmReais;
        LExistente.NumeroCartao := LRegistro.NumeroCartao;
        LExistente.QuantidadeMaterialUsado := LRegistro.QuantidadeMaterialUsado;
        LExistente.TipoMaterial := LRegistro.TipoMaterial;
        LExistente.CodigoServico := LRegistro.CodigoServico;
        LExistente.TipoAbastecimento := LRegistro.TipoAbastecimento;
        LExistente.PlacaVeiculo := LRegistro.PlacaVeiculo;
        LExistente.HodometroVeiculoNoAbastecimento := LRegistro.HodometroVeiculoNoAbastecimento;
        LExistente.CNPJEstabelecimento := LRegistro.CNPJEstabelecimento;
        LExistente.NomeEstabelecimento := LRegistro.NomeEstabelecimento;
        LExistente.InformacaoAdicional1 := LRegistro.InformacaoAdicional1;
        LExistente.InformacaoAdicional2 := LRegistro.InformacaoAdicional2;
        LExistente.InformacaoAdicional3 := LRegistro.InformacaoAdicional3;
        LExistente.MatriculaMotorista := LRegistro.MatriculaMotorista;

        case FExtensaoImportada of
          0: LExistente.ValorEmReais := FormatFloat('0.00',StringToFloat(LRegistro.ValorEmReais));
          1: LExistente.ValorEmReais := FormatFloat('0.00',(StringToFloat(LExistente.ValorEmReais)/100) );
        End;

        LPlacas.Add(LRegistro.PlacaVeiculo, LExistente);
        LDetalheAgrupada.Add(LExistente);
      End
      Else
      Begin
        LExistente := LPlacas.Items[LRegistro.PlacaVeiculo];

        case FExtensaoImportada of
          0: Begin
               // Soma ValorEmReais
               LValorAtual := StringToFloat(LExistente.ValorEmReais);
               LValorNovo  := StringToFloat(LRegistro.ValorEmReais);
               LExistente.ValorEmReais := FormatFloat('0.00', LValorAtual + LValorNovo);
             End;
          1: Begin
               // Soma ValorEmReais
               LValorAtual := StringToFloat(LExistente.ValorEmReais);
               LValorNovo  := (StringToFloat(LRegistro.ValorEmReais)/100);
               LExistente.ValorEmReais := FormatFloat('0.00', LValorAtual + LValorNovo);
             End;
        End;

      End;
    End;

    Result := LDetalheAgrupada;
  Finally
    LPlacas.Free;
  End;
End;

function TIntegracaoTicketLog.LancarTitulosContasPagar(AUniQuery: TUniQuery): TRetornoIntegracao;
var
  LRegistro : TDetalheIntegracaoTicketLog;
  LDetalheIntegracao : TListDetalheIntegracaoTicketLog;
  LAutoIncrem: String;
  LScriptInsert : String;
  LContaImportacao : String;
  LPortadorImportacao : String;
  LCentroCustosImportacao : String;
begin
  Result.ConcluidoComSucesso := False;
  Result.QuantidadeRegistrosInseridos := 0;
  Result.QuantidadeRegistrosComErro := 0;
  Result.QuantidadeRegistrosIgnorados := 0;

  if not Assigned(AUniQuery) Then
    Exit;

  if not AUniQuery.Connection.Connected Then
    Exit;

  LContaImportacao := fCfgSis('CTATKT', varString);
  if fEmptyStr(LContaImportacao) then
    raise Exception.Create('Necessário configurar a Conta padrão de importação TicketLog ("CTATKT").');

  LPortadorImportacao := fCfgSis('PORTKT', varString);
  if fEmptyStr(LPortadorImportacao) then
    raise Exception.Create('Necessário configurar o Portador padrão de importação TicketLog ("PORTKT").');

  LCentroCustosImportacao := fCfgSis('EVETKT', varString);
  if fCfgSis('CTPOBE', varBoolean) then
  begin
    if fEmptyStr(LCentroCustosImportacao) then
    begin
      raise Exception.Create('Quando a configuração "CTPOBE" estiver marcada como "S", ' +
                             'é necessário informar o Centro de Custos na configuração "EVETKT".');
    end;
  end;

  LScriptInsert := EmptyStr;
  LScriptInsert := LScriptInsert + 'INSERT INTO CADPAG( AUTOINCREM, CTP_CODFOR, CTP_NUMDUP, CTP_PARCEL, ';
  LScriptInsert := LScriptInsert + '		     CTP_CODEMP, CTP_SEQBAI, CTP_CODCTA, CTP_DTACAD, ';
  LScriptInsert := LScriptInsert + '		     CTP_DTAVEN, CTP_VALDUP, CTP_VALORI, CTP_PREVIS, ';
  LScriptInsert := LScriptInsert + '		     CTP_VEIOBO, CTP_VEIONF, CTP_HIST01, CTP_HIST02, ';
  LScriptInsert := LScriptInsert + '		     CTP_HISBAI, CTP_VALPAG, CTP_VALJUR, CTP_VALDES, ';
  LScriptInsert := LScriptInsert + '		     CTP_DESSUJ, CTP_JURSUJ, CTP_USACHQ, CTP_CODVEN, ';
  LScriptInsert := LScriptInsert + '		     CTP_TIPDOC, CTP_NUMDOC, CTP_CODPOR, CTP_DEPOSI, ';
  LScriptInsert := LScriptInsert + '		     CTP_RESCAI, CTP_PAGANT, CTP_CODOPE, CTP_USOCON, ';
  LScriptInsert := LScriptInsert + '		     CTP_COMPET, CTP_DESANT, CTP_JURANT, CTP_VALANT, ';
  if not fEmptyStr(LCentroCustosImportacao) then
  begin
    LScriptInsert := LScriptInsert + '           CTP_QTDDIA, CTP_GRVORI, CTP_SERIE_, CTP_CODEVE) ';
  end
  else
  begin
    LScriptInsert := LScriptInsert + '           CTP_QTDDIA, CTP_GRVORI, CTP_SERIE_) ';
  end;
  LScriptInsert := LScriptInsert + '         VALUES( :AUTOINCREM,:CTP_CODFOR,:CTP_NUMDUP,:CTP_PARCEL, ';
  LScriptInsert := LScriptInsert + '             :CTP_CODEMP,:CTP_SEQBAI,:CTP_CODCTA,:CTP_DTACAD, ';
  LScriptInsert := LScriptInsert + '             :CTP_DTAVEN,:CTP_VALDUP,:CTP_VALORI,:CTP_PREVIS, ';
  LScriptInsert := LScriptInsert + '             :CTP_VEIOBO,:CTP_VEIONF,:CTP_HIST01,:CTP_HIST02, ';
  LScriptInsert := LScriptInsert + '             :CTP_HISBAI,:CTP_VALPAG,:CTP_VALJUR,:CTP_VALDES, ';
  LScriptInsert := LScriptInsert + '             :CTP_DESSUJ,:CTP_JURSUJ,:CTP_USACHQ,:CTP_CODVEN, ';
  LScriptInsert := LScriptInsert + '             :CTP_TIPDOC,:CTP_NUMDOC,:CTP_CODPOR,:CTP_DEPOSI, ';
  LScriptInsert := LScriptInsert + '             :CTP_RESCAI,:CTP_PAGANT,:CTP_CODOPE,:CTP_USOCON, ';
  LScriptInsert := LScriptInsert + '             :CTP_COMPET,:CTP_DESANT,:CTP_JURANT,:CTP_VALANT, ';
  if not fEmptyStr(LCentroCustosImportacao) then
  begin
    LScriptInsert := LScriptInsert + '           :CTP_QTDDIA,:CTP_GRVORI,:CTP_SERIE_,:CTP_CODEVE) ';
  end
  else
  begin
    LScriptInsert := LScriptInsert + '           :CTP_QTDDIA,:CTP_GRVORI,:CTP_SERIE_) ';
  end;

  case FExtensaoImportada of
    0 : LDetalheIntegracao := FProcessaCsv.DetalheIntegracao;
    1 : LDetalheIntegracao := FProcessaTxt.DetalheIntegracao;
    else
      raise Exception.Create('Extensão de arquivo não suportada.');
  end;

  if not Assigned(LDetalheIntegracao) then
    Exit;

  //Agrupa detalhes por placas
  LDetalheIntegracao := fAgrupaDetalhesPorPlaca(LDetalheIntegracao);

  for LRegistro in LDetalheIntegracao do
  begin
    if DuplicataExiste(LRegistro.GetNumeroDuplicata(FExtensaoImportada),
                       VS_strCodEmp,
                       'A',
                       LRegistro.GetFornecedorPorCnpj,
                       'PA') Then
    begin
      Inc(Result.QuantidadeRegistrosIgnorados);
      Continue;
    end;

    try

      LAutoIncrem := fRetAutoIncrem('CADPAG', VS_strCodEmp);

      AUniQuery.Close;
      AUniQuery.SQL.Clear;
      AUniQuery.SQL.Text := LScriptInsert;
      AUniQuery.ParamByName('AUTOINCREM').AsString := LAutoIncrem;
      AUniQuery.ParamByName('CTP_CODFOR').AsString := LRegistro.GetFornecedorPorCnpj;
      AUniQuery.ParamByName('CTP_NUMDUP').AsString := LRegistro.GetNumeroDuplicata(FExtensaoImportada);
      AUniQuery.ParamByName('CTP_PARCEL').AsString := 'A';
		  AUniQuery.ParamByName('CTP_CODEMP').AsString := VS_strCodEmp;
      AUniQuery.ParamByName('CTP_SEQBAI').AsInteger := 0;
      AUniQuery.ParamByName('CTP_CODCTA').AsString := LContaImportacao;
      AUniQuery.ParamByName('CTP_DTACAD').AsDate := VS_Date;
		  AUniQuery.ParamByName('CTP_DTAVEN').AsDate := VS_Date;
      AUniQuery.ParamByName('CTP_VALDUP').AsFloat := StringToFloat(LRegistro.ValorEmReais);
      AUniQuery.ParamByName('CTP_VALORI').AsFloat := StringToFloat(LRegistro.ValorEmReais);
      AUniQuery.ParamByName('CTP_PREVIS').AsString := 'N';
		  AUniQuery.ParamByName('CTP_VEIOBO').AsString := 'N';
      AUniQuery.ParamByName('CTP_VEIONF').AsString := 'N';
      AUniQuery.ParamByName('CTP_HIST01').AsString := LRegistro.GetHistorico;
      AUniQuery.ParamByName('CTP_HIST02').AsString := EmptyStr;
		  AUniQuery.ParamByName('CTP_HISBAI').AsString := EmptyStr;
      AUniQuery.ParamByName('CTP_VALPAG').AsFloat := 0;
      AUniQuery.ParamByName('CTP_VALJUR').AsFloat := 0;
      AUniQuery.ParamByName('CTP_VALDES').AsFloat := 0;
		  AUniQuery.ParamByName('CTP_DESSUJ').AsFloat := 0;
      AUniQuery.ParamByName('CTP_JURSUJ').AsFloat := 0;
      AUniQuery.ParamByName('CTP_USACHQ').AsString := 'N';
      AUniQuery.ParamByName('CTP_CODVEN').AsString := strLoginUsuarioLogado;
		  AUniQuery.ParamByName('CTP_TIPDOC').AsInteger := 1;
      AUniQuery.ParamByName('CTP_NUMDOC').AsString := LRegistro.GetNumeroDuplicata(FExtensaoImportada);
      AUniQuery.ParamByName('CTP_CODPOR').AsString := LPortadorImportacao;
      AUniQuery.ParamByName('CTP_DEPOSI').AsString := 'N';
		  AUniQuery.ParamByName('CTP_RESCAI').AsString := 'N';
      AUniQuery.ParamByName('CTP_PAGANT').AsString := 'N';
      AUniQuery.ParamByName('CTP_CODOPE').AsString := strLoginUsuarioLogado;
      AUniQuery.ParamByName('CTP_USOCON').AsString := 'N';
		  AUniQuery.ParamByName('CTP_COMPET').AsString := LRegistro.GetCompetencia;
      AUniQuery.ParamByName('CTP_DESANT').AsFloat := 0;
      AUniQuery.ParamByName('CTP_JURANT').AsFloat := 0;
      AUniQuery.ParamByName('CTP_VALANT').AsFloat := StringToFloat(LRegistro.ValorEmReais);
		  AUniQuery.ParamByName('CTP_QTDDIA').AsInteger := 0;
      AUniQuery.ParamByName('CTP_GRVORI').AsFloat := StringToFloat(LRegistro.ValorEmReais);
      AUniQuery.ParamByName('CTP_SERIE_').AsString := 'PA';
      if not fEmptyStr(LCentroCustosImportacao) then
        AUniQuery.ParamByName('CTP_CODEVE').AsString := LCentroCustosImportacao;
      AUniQuery.Execute;

      Inc(Result.QuantidadeRegistrosInseridos);
    except on E: Exception do
      begin
        Inc(Result.QuantidadeRegistrosComErro);
      end;
    end;
  end;

  if Result.QuantidadeRegistrosComErro = 0 Then
    Result.ConcluidoComSucesso := True;
end;

procedure TIntegracaoTicketLog.BaixarTitulosImportados;
var
  LfrmBaixaCtaPagar: TfrmBaixaCtaPagar;
  LContaImportacao : String;
  LPortadorImportacao : String;
begin

  LContaImportacao := fCfgSis('CTATKT', varString);
  if fEmptyStr(LContaImportacao) then
    Exit;

  LPortadorImportacao := fCfgSis('PORTKT', varString);
  if fEmptyStr(LPortadorImportacao) then
    Exit;

  pCriarFormularios(TfrmBaixaCtaPagar, LfrmBaixaCtaPagar);
  Try
    LfrmBaixaCtaPagar.strChamada := '[TIntegracaoTicketLog.pBaixaTitulosImportados]';
    LfrmBaixaCtaPagar.pnlCabecalho.Enabled := False;
    LfrmBaixaCtaPagar.pnlCabecalho.Visible := False;
    LfrmBaixaCtaPagar.btnIniBus.Enabled         := False;
    LfrmBaixaCtaPagar.btnLocProx.Enabled        := False;
    LfrmBaixaCtaPagar.fraPlanoDeContas.MskCodCta.Text := LContaImportacao;
    LfrmBaixaCtaPagar.edtCodPor.Text   := LPortadorImportacao;
    LfrmBaixaCtaPagar.mskDtaCadIni.Text := DateToStr(VS_Date);
    LfrmBaixaCtaPagar.mskDtaCadFin.Text := DateToStr(VS_Date);
    LfrmBaixaCtaPagar.mskDtaIni.Text := DateToStr(VS_Date);
    LfrmBaixaCtaPagar.mskDtaFin.Text := DateToStr(VS_Date);

    Sleep(1000); //NÃO RETIRAR
    LfrmBaixaCtaPagar.btnConsultar.Click;
    LfrmBaixaCtaPagar.ShowModal;

  finally
    FreeAndNil(LfrmBaixaCtaPagar);
  End;
end;

function TIntegracaoTicketLog.ProcessarArquivo: Boolean;
begin
  try

    case FExtensaoImportada of
      0 : Result := FProcessaCsv.ProcessarArquivo;
      1 : Result := FProcessaTxt.ProcessarArquivo;
      else
        raise Exception.Create('Extensão de arquivo não suportada.');
    end;

  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;

end;

{ TProcessaTxt }

constructor TProcessaTxt.Create;
begin
  inherited Create;

  FIgnoraPrimeiraLinha := True;
  FHeaderIntegracao := THeaderIntegracaoTicketLog.Create;
  FDetalheIntegracao := TListDetalheIntegracaoTicketLog.Create;
  FTrailerIntegracao := TTrailerIntegracaoTicketLog.Create;
end;

destructor TProcessaTxt.Destroy;
begin
  if Assigned(FHeaderIntegracao) Then
    FreeAndNil(FHeaderIntegracao);

  if Assigned(FDetalheIntegracao) Then
    FreeAndNil(FDetalheIntegracao);

  if Assigned(FTrailerIntegracao) Then
    FreeAndNil(FTrailerIntegracao);

  if Assigned(FArquivoImportacao) Then
    FreeAndNil(FArquivoImportacao);

  inherited Destroy;
end;

function TProcessaTxt.ImportarArquivo(ACaminhoArquivo: String;
  AIgnoraPrimeiraLinha: Boolean): Boolean;
begin
  if Assigned(FArquivoImportacao) then
    FreeAndNil(FArquivoImportacao);

  FArquivoImportacao := TStringList.Create;
  FArquivoImportacao.LoadFromFile(ACaminhoArquivo);

  Result := (FArquivoImportacao.Count > 0);
end;

function TProcessaTxt.LinhaEhDetalhe(ALinha: String): Boolean;
begin
  Result := Copy(ALinha, 1, 3).Equals('100');
end;

function TProcessaTxt.LinhaEhHeader(ALinha: String): Boolean;
begin
  Result := Copy(ALinha, 1, 3).Equals('000');
end;

function TProcessaTxt.LinhaEhTrailer(ALinha: String): Boolean;
begin
  Result := Copy(ALinha, 1, 3).Equals('200');
end;

function TProcessaTxt.ProcessarDetalhe(ALinha: String): Boolean;
var
  LDetalhe : TDetalheIntegracaoTicketLog;
begin
  Result := False;
  if not Assigned(FDetalheIntegracao) Then
    Exit;

  LDetalhe := TDetalheIntegracaoTicketLog.Create;
  LDetalhe.IDTipoRegistro   := Copy(ALinha, 1, 3);                   // 001 a 003
  LDetalhe.NumeroSequencial := Copy(ALinha, 4, 4);                   // 004 a 007
  LDetalhe.DataTransacao := Copy(ALinha, 8, 8);                      // 008 a 015
  LDetalhe.ValorEmReais  := Copy(ALinha, 16, 11);                    // 016 a 026
  LDetalhe.NumeroCartao  := Copy(ALinha, 27, 16);                    // 027 a 042
  LDetalhe.QuantidadeMaterialUsado := Copy(ALinha, 43, 6);           // 043 a 048
  LDetalhe.TipoMaterial  := Copy(ALinha, 49, 2);                     // 049 a 050
  LDetalhe.CodigoServico := Copy(ALinha, 51, 30);                    // 051 a 080
  LDetalhe.TipoAbastecimento := Copy(ALinha, 81, 11);                // 081 a 091
  LDetalhe.PlacaVeiculo := Copy(ALinha, 92, 7);                      // 092 a 098
  LDetalhe.HodometroVeiculoNoAbastecimento := Copy(ALinha, 99, 7);   // 099 a 105
  LDetalhe.CNPJEstabelecimento  := Copy(ALinha, 106, 14);            // 106 a 119
  LDetalhe.NomeEstabelecimento  := Copy(ALinha, 120, 50);            // 120 a 169
  LDetalhe.InformacaoAdicional1 := Copy(ALinha, 170, 30);            // 170 a 199
  LDetalhe.InformacaoAdicional2 := Copy(ALinha, 200, 30);            // 200 a 229
  LDetalhe.InformacaoAdicional3 := Copy(ALinha, 230, 30);            // 230 a 259
  LDetalhe.MatriculaMotorista   := Copy(ALinha, 260, 10);            // 260 a 269

  Result := (FDetalheIntegracao.Add(LDetalhe) > -1);
end;

function TProcessaTxt.ProcessarHeader(ALinha: String): Boolean;
begin
  Result := False;
  if not Assigned(FHeaderIntegracao) Then
    Exit;

  HeaderIntegracao.IDTipoRegistro := Copy(ALinha, 1, 3);               // 001 a 003
  HeaderIntegracao.CNPJEmissor    := Copy(ALinha, 4, 14);              // 004 a 017
  HeaderIntegracao.IdentificacaoEmissor := Copy(ALinha, 18, 32);       // 018 a 049
  HeaderIntegracao.DataPrimeiroRegistro := Copy(ALinha, 50, 8);        // 050 a 057
  HeaderIntegracao.HoraPrimeiroRegistro := Copy(ALinha, 58, 6);        // 058 a 063
  HeaderIntegracao.DataUltimoRegistro   := Copy(ALinha, 64, 8);        // 064 a 071
  HeaderIntegracao.HoraUltimoRegistro   := Copy(ALinha, 72, 6);        // 072 a 077
  HeaderIntegracao.DataHoraGeracaoArquivo := Copy(ALinha, 78, 23);     // 078 a 100
  HeaderIntegracao.PeriodoApuracaoInformacao := Copy(ALinha, 101, 50); // 101 a 150

  Result := True;
end;

function TProcessaTxt.ProcessarArquivo: Boolean;
var
  LContador : Integer;
  LIndiceLinha : Integer;
  LLinhaErro : Integer;
begin
  Result := False;

  LIndiceLinha := 0;
  LLinhaErro := 0;

  if FIgnoraPrimeiraLinha then
    Inc(LIndiceLinha);

  try
    for LContador := LIndiceLinha to Pred(FArquivoImportacao.Count) do
    begin
      LLinhaErro := LContador;
      Result := ProcessarLinha(FArquivoImportacao[LContador]);
      if not Result Then
        Exit;
    end;
  except on E: Exception do
    begin
      raise Exception.Create(Format(E.Message, [LLinhaErro]));
    end;
  end;

end;

function TProcessaTxt.ProcessarLinha(ALinha: String): Boolean;
begin
  Result := False;
  if fEmptyStr(ALinha) Then
    Exit;

  try
    if LinhaEhHeader(ALinha) Then
    begin
      Result := ProcessarHeader(ALinha);
      Exit;
    end;

    if LinhaEhDetalhe(ALinha) Then
    begin
      Result := ProcessarDetalhe(ALinha);
      Exit;
    end;

    if LinhaEhTrailer(ALinha) Then
    begin
      Result := ProcessarTrailer(ALinha);
      Exit;
    end;
  except on E: Exception do
    begin
      raise Exception.Create('Falha ao processar a linha %d. Motivo: ' + E.Message);
    end;
  end;

end;

function TProcessaTxt.ProcessarTrailer(ALinha: String): Boolean;
begin
  Result := False;
  if not Assigned(FTrailerIntegracao) Then
    Exit;

  TrailerIntegracao.IDTipoRegistro := Copy(ALinha, 1, 3);                // 001 a 003
  TrailerIntegracao.QuantidadeRegistrosEnviados := Copy(ALinha, 4, 6);   // 004 a 009
  TrailerIntegracao.TotalizadorMaterialUsado    := Copy(ALinha, 10, 10); // 010 a 019
  TrailerIntegracao.TotalizadorValorEmReais     := Copy(ALinha, 20, 10); // 020 a 029

  Result := True;
end;

function TProcessaTxt.SelecionadoArquivoValido(
  ACaminhoArquivo: String): Boolean;
begin
  Result := False;

  if Assigned(FArquivoImportacao) then
    FreeAndNil(FArquivoImportacao);

  FArquivoImportacao := TStringList.Create;
  FArquivoImportacao.LoadFromFile(ACaminhoArquivo);

  if FArquivoImportacao.Count < 3 then
    Exit;

  if not LinhaEhHeader(FArquivoImportacao[0]) then
    Exit;

  if not LinhaEhDetalhe(FArquivoImportacao[1]) then
    Exit;

  if not LinhaEhTrailer(FArquivoImportacao[Pred(FArquivoImportacao.Count)]) then
    Exit;

  Result := True;
end;

{ TProcessaCSV }

constructor TProcessaCSV.Create;
begin
  inherited Create;

  FIgnoraPrimeiraLinha := True;
  FDetalheIntegracao := TListDetalheIntegracaoTicketLog.Create;
end;

destructor TProcessaCSV.Destroy;
begin
  if Assigned(FDetalheIntegracao) then
    FreeAndNil(FDetalheIntegracao);

  inherited Destroy;
end;

function TProcessaCSV.ImportarArquivo(ACaminhoArquivo: String;
  AIgnoraPrimeiraLinha: Boolean): Boolean;
begin
  if Assigned(FArquivoImportacao) then
    FreeAndNil(FArquivoImportacao);

  FArquivoImportacao := TStringList.Create;
  FArquivoImportacao.LoadFromFile(ACaminhoArquivo);

  Result := (FArquivoImportacao.Count > 0);
end;

function TProcessaCSV.LinhaEhDetalhe(ALinha: String): Boolean;
begin
  Result := False;
  if fEmptyStr(ALinha) then
    Exit;

  Result := not ALinha.StartsWith('Total');
end;

function TProcessaCSV.LinhaEhHeader(ALinha: String): Boolean;
var
  LCampos : TArray<string>;
begin
  Result := False;
  LCampos := ALinha.Split([';']);

  if Length(LCampos) < 41 then
    Exit;

  if not LCampos[0].StartsWith('CODIGO TRANSACAO') then
    Exit;

  if not LCampos[5].StartsWith('PLACA') then
    Exit;

  if not LCampos[35].StartsWith('NUMERO CARTAO') then
    Exit;

  Result := True;
end;

function TProcessaCSV.LinhaEhTrailer(ALinha: String): Boolean;
begin
  Result := False;
  if fEmptyStr(ALinha) then
    Exit;

  Result := ALinha.StartsWith('Total');
end;

function TProcessaCSV.ProcessarDetalhe(ALinha: String): Boolean;
var
  LDetalhe : TDetalheIntegracaoTicketLog;
  LCampos : TArray<string>;
begin
  Result := False;
  if not Assigned(FDetalheIntegracao) Then
    Exit;

  if fEmptyStr(ALinha) then
    Exit;

  LCampos := ALinha.Split([';']);

  LDetalhe := TDetalheIntegracaoTicketLog.Create;
  LDetalhe.IDTipoRegistro   := LCampos[0];
  LDetalhe.NumeroSequencial := LCampos[0];
  LDetalhe.DataTransacao := LCampos[4];
  LDetalhe.ValorEmReais  := LCampos[19];
  LDetalhe.NumeroCartao  := LCampos[35];
  LDetalhe.QuantidadeMaterialUsado := LCampos[14];
  LDetalhe.TipoMaterial  := LCampos[13];
  LDetalhe.CodigoServico := LCampos[12];
  LDetalhe.TipoAbastecimento := LCampos[13];
  LDetalhe.PlacaVeiculo := LCampos[5];
  LDetalhe.HodometroVeiculoNoAbastecimento := LCampos[16];
  LDetalhe.CNPJEstabelecimento  := EmptyStr;
  LDetalhe.NomeEstabelecimento  := LCampos[21];
  LDetalhe.InformacaoAdicional1 := LCampos[27];
  LDetalhe.InformacaoAdicional2 := LCampos[28];
  LDetalhe.InformacaoAdicional3 := LCampos[29];
  LDetalhe.MatriculaMotorista   := LCampos[10];

  Result := (FDetalheIntegracao.Add(LDetalhe) > -1);
end;

function TProcessaCSV.ProcessarArquivo: Boolean;
var
  LContador : Integer;
  LIndiceLinha : Integer;
  LLinhaErro : Integer;
begin
  Result := False;

  LIndiceLinha := 0;
  LLinhaErro := 0;

  if FIgnoraPrimeiraLinha then
    Inc(LIndiceLinha);

  try
    for LContador := LIndiceLinha to Pred(FArquivoImportacao.Count) do
    begin
      if not LinhaEhDetalhe(FArquivoImportacao[LContador]) Then
      begin
        Result := True;
        Exit;
      end;

      LLinhaErro := LContador;
      Result := ProcessarLinha(FArquivoImportacao[LContador]);
      if not Result Then
        Exit;
    end;
  except on E: Exception do
    begin
      raise Exception.Create(Format(E.Message, [LLinhaErro]));
    end;
  end;

end;

function TProcessaCSV.ProcessarLinha(ALinha: String): Boolean;
begin
  Result := False;
  if fEmptyStr(ALinha) Then
    Exit;

  try
    if LinhaEhDetalhe(ALinha) Then
      Result := ProcessarDetalhe(ALinha);
  except on E: Exception do
    begin
      raise Exception.Create('Falha ao processar a linha %d. Motivo: ' + E.Message);
    end;
  end;
end;

function TProcessaCSV.SelecionadoArquivoValido(
  ACaminhoArquivo: String): Boolean;
begin
  Result := False;

  if Assigned(FArquivoImportacao) then
    FreeAndNil(FArquivoImportacao);

  FArquivoImportacao := TStringList.Create;
  FArquivoImportacao.LoadFromFile(ACaminhoArquivo);

  if FArquivoImportacao.Count < 3 then
    Exit;

  if not LinhaEhHeader(FArquivoImportacao[0]) then
    Exit;

  if not LinhaEhDetalhe(FArquivoImportacao[1]) then
    Exit;

  if not LinhaEhTrailer(FArquivoImportacao[Pred(FArquivoImportacao.Count)]) then
    Exit;

  Result := True;
end;

end.
