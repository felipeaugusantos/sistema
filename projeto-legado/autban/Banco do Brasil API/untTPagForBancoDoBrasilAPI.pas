unit untTPagForBancoDoBrasilAPI;

interface
  Uses System.Classes, System.SysUtils, System.StrUtils, untTRestSynalistAutban,
       untTiposPagFor, untTPagFor, untLogCtp, Uni, Data.DB, Rest.Json,
       System.Json, System.Generics.Collections, cxProgressBar, UniClientDataset,
       System.DateUtils, untGravando, untTRegPGI;

Type
  TDuplicataAtualizar = class
  public
    AutoIncremCadPag,
    NumeroLote: String;

    DataPagamento: TDateTime;
  end;

Type
  TPagForBancoDoBrasilAPI = class
  private
    FDadosCarteira: TPagForAPIDadosCarteira;

    FRestSynalist: TRestSynalistAutban;

    FDataInicial,
    FDataFinal: TDateTime;

    FDuplicatasRetorno: TList<TPagForRetorno>;

    FDatasetNaoBaixa,
    FRegistrosLotes: TUniClientDataset;

    FGravando: TfrmGravando;

    FPagFor: TPagFor;

    FEnviouAlgumRegistro,
    FErroExportacao: Boolean;

    FErrosGeradosExportacao: TStringList;

    FListaDuplicatasAtualizar: TList<TDuplicataAtualizar>;

    //Exportação
    function TransfereLoteBoletos(ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
    function TransfereLoteGuiaComCodigoDeBarras(ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
    function TransfereLoteTransferencias(ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
    function TransfereLoteTransferenciasSalarios(ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
    function TransfereLoteTransferenciasPix(ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
    function TransfereLoteOutrasGuiasGPS(ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
    function TransfereLoteOutrasGuiasDARF(ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
    function TransfereLoteOutrasGuiasGRU(ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;

    function DeveRealizaroEnvio(AFinalDataset: Boolean;
                                AContadorRegistros: Integer): Boolean;

    function RetornaLinkDoAmbiente(ARecurso: String): String;
    function RetornaLinkTokenDoAmbiente: String;

    procedure AtribuiDadosPixFornecedor(var AJsonTransferencia: TJSONObject;
                                            ADatasetRemessa: TDataset);
    function RetornaIDTipoChavePix(ATipoChave: String): String;

    procedure AtualizarDadosDoLoteDuplicata(AListaDuplicatasSemErro: TStringList;
                                            ATipoLote: String);

    function RetornaTextoDoErrosNaExportacao: String;

    procedure ExibeMensagensDeErrosNaExportacao(ATipoExportacao: String);

    function RetornaRegistroAPIInicial(ALinkAPI: String;
                                       AJsonEnviado: TJsonObject;
                                       ADescricao: String): TRequisicaoRegistroAPI;
    //***************

    function RetornaDataIntegerComoString(AData: TDateTime): String;
    function RetornaValorExportacao(AValor: Double): String;

    function RetornaToken: String;

    procedure VerificaStatusLancamentosExportados(var AListaDuplicatas: TStringList;
                                                      ARetorno: String);
    procedure VerificaStatusTransferenciasExportadas(var AListaDuplicatas: TStringList;
                                                         ARetorno: String);

    procedure AdicionaErrosExportacao(AJsonValue: TJsonValue);

    procedure LimpaDadosGeracaoDuplicata(AAutoIncremCadPag: String);

    function RetornaTextoDoJsonDeErros(AErro: String): String;

    //Importacao
    function ImportarTodosPagamentos(pgbStatus: TcxProgressBar): Boolean;
    procedure ImportarRegistrosBoletos(Var ALista: TList<TPagForRetorno>;
                                       Var ADatasetLotes: TUniClientDataset);
    procedure ImportarRegistrosGuiasComCodigoDeBarras(Var ALista: TList<TPagForRetorno>;
                                                      Var ADatasetLotes: TUniClientDataset);
    procedure ImportarRegistrosTransferencias(Var ALista: TList<TPagForRetorno>;
                                              Var ADatasetLotes: TUniClientDataset);
    procedure ImportarRegistrosTransferenciasPix(Var ALista: TList<TPagForRetorno>;
                                                 Var ADatasetLotes: TUniClientDataset);
    procedure ImportarRegistrosOutrasGuiasGPS(Var ALista: TList<TPagForRetorno>;
                                              Var ADatasetLotes: TUniClientDataset);
    procedure ImportarRegistrosOutrasGuiasDARF(Var ALista: TList<TPagForRetorno>;
                                               Var ADatasetLotes: TUniClientDataset);
    procedure ImportarRegistrosOutrasGuiasGRU(Var ALista: TList<TPagForRetorno>;
                                              Var ADatasetLotes: TUniClientDataset);

    procedure RetornaDadosDosPagamentos(var ADuplicatas: TList<TPagforRetorno>;
                                            ADataInicial,
                                            ADataFinal: TDateTime);

    function RetornaCodigoPeloEstadoPagamento(AEstadoPagamento: String): String;

    procedure CorrigeDatasEValores(var AValorDuplicata: String;
                                       AData: Boolean = True);
    //*****************
    procedure AguardeCincoSegundos;
    function ExtrairDDDTelefone(ANumTelefone: String): String;
  public
    constructor Create(AConfiguracao: String);
    destructor Destroy; override;

    function ExportaRemessaAoBanco(prgStatus: TcxProgressBar): Boolean;

    function ImportarPagamentos(ADataInicial,
                                ADataFinal: TDateTime;
                                var ADatasetNaoBaixa: TUniClientDataset): TList<TPagForRetorno>;

    class function RetornaDescricaoDosErros(AErro: Integer): String;

    property PagForObjeto: TPagFor read FPagFor write FPagFor;
    property DadosCarteira: TPagForAPIDadosCarteira read FDadosCarteira;
  end;

  Const
    URL_TOKEN_HOMOLOGACAO = 'https://oauth.hm.bb.com.br/oauth/token';
    URL_TOKEN_PRODUCAO = 'https://oauth.bb.com.br/oauth/token';

    URL_API_HOMOLOGACAO = 'https://api.hm.bb.com.br/pagamentos-lote/v1/[RECURSO]?gw-dev-app-key=[GW_DEV_APP_KEY]';
    URL_API_PRODUCAO = 'https://api-ip.bb.com.br/pagamentos-lote/v1/[RECURSO]?gw-dev-app-key=[GW_DEV_APP_KEY]';

implementation
Uses untFuncoesSimples, untFuncAutban;
{ TPagForBancoDoBrasilAPI }

procedure TPagForBancoDoBrasilAPI.AdicionaErrosExportacao(
  AJsonValue: TJsonValue);
  Var
    LJsonArray: TJsonArray;

    LJsonErro: TJsonValue;

    LJsonObject: TJsonObject;
begin
  Try
    LJsonObject := AJsonValue as TJsonObject;

    If Not LJsonObject.TryGetValue('errorCodes', LJsonArray) Then
    Begin
      If Not LJsonObject.TryGetValue('errors', LJsonArray) Then
        LJsonObject.TryGetValue('erros', LJsonArray);
    End;

    If LJsonArray = Nil Then
      Exit;

    For LJsonErro In LJsonArray Do
    BEgin
      If LJsonErro.Value.Equals('0') Then
        Continue;

      If FErrosGeradosExportacao.IndexOf(LJsonErro.Value) = -1 Then
        FErrosGeradosExportacao.Add(LJsonErro.Value);
    End;
  Except

  End;
end;

procedure TPagForBancoDoBrasilAPI.AguardeCincoSegundos;
begin
  Aguarde(5000);
end;

procedure TPagForBancoDoBrasilAPI.AtribuiDadosPixFornecedor(
  var AJsonTransferencia: TJSONObject; ADatasetRemessa: TDataset);
var
  LTelefoneCompleto: String;
  LDDD: String;
begin
  AJsonTransferencia.AddPair('formaIdentificacao', RetornaIDTipoChavePix(ADatasetRemessa.FieldByName('TIPCHV_PIX').AsString));

  Case StrToInt(RetornaIDTipoChavePix(ADatasetRemessa.FieldByName('TIPCHV_PIX').AsString)) Of
    1: Begin
         LTelefoneCompleto := fStrZero(fRetSomenteNumeros(ADatasetRemessa.FieldByName('CHAVE_PIX').AsString), 12);
         LDDD := ExtrairDDDTelefone(LTelefoneCompleto);

         If (Not fEmptyStr(LDDD)) Then
         Begin
           AJsonTransferencia.AddPair('dddTelefone', LDDD);
           AJsonTransferencia.AddPair('telefone', RightStr(LTelefoneCompleto, 9));
         End;
       End;
    2: AJsonTransferencia.AddPair('email', ADatasetRemessa.FieldByName('CHAVE_PIX').AsString.ToLowerInvariant);
    3: Begin
         If fRetSomenteNumeros(ADatasetRemessa.FieldByName('CHAVE_PIX').AsString).Length < 14 Then
           AJsonTransferencia.AddPair('cpf', fRetSomenteNumeros(ADatasetRemessa.FieldByName('CHAVE_PIX').AsString))
         Else
           AJsonTransferencia.AddPair('cnpj', fTiraCaracEspeciaisPonto(ADatasetRemessa.FieldByName('CHAVE_PIX').AsString));
       End;
    4: AJsonTransferencia.AddPair('identificacaoAleatoria', ADatasetRemessa.FieldByName('CHAVE_PIX').AsString);
  End;
end;

procedure TPagForBancoDoBrasilAPI.AtualizarDadosDoLoteDuplicata(AListaDuplicatasSemErro: TStringList;
  ATipoLote: String);
  Var
    LUpdate: TUniQuery;

    LDuplicataAtualizar: TDuplicataAtualizar;
begin
  If FListaDuplicatasAtualizar.Count = 0 Then
    Exit;

  LUpdate := fCriaQuery;
  Try
    LUpdate.SQL.Text := 'UPDATE CADPAG SET CTP_NUMLOT=:NUMLOT, ' +
                        '                  CTP_DTALOT=:DTALOT, ' +
                        '                  CTP_PAGLOT=:PAGLOT, ' +
                        '                  CTP_CARLOT=:CARLOT, ' +
                        '                  CTP_TIPLOT=:TIPLOT  ' +
                        'WHERE AUTOINCREM =:AUTOIN ';

    fStartTransaction;
    For LDuplicataAtualizar In FListaDuplicatasAtualizar Do
    Begin
      If AListaDuplicatasSemErro.IndexOf(LDuplicataAtualizar.AutoIncremCadPag) < 0 Then
      Begin
        LimpaDadosGeracaoDuplicata(LDuplicataAtualizar.AutoIncremCadPag);

        Continue;
      End;

      LUpdate.ParamByName('AUTOIN').AsString := LDuplicataAtualizar.AutoIncremCadPag;

      LUpdate.ParamByName('NUMLOT').AsString := LDuplicataAtualizar.NumeroLote;
      LUpdate.ParamByName('DTALOT').AsDateTime := VS_Date;
      LUpdate.ParamByName('PAGLOT').AsDateTime := LDuplicataAtualizar.DataPagamento;
      LUpdate.ParamByName('CARLOT').AsString := FDadosCarteira.Configuracao;
      LUpdate.ParamByName('TIPLOT').AsString := ATipoLote;

      LUpdate.ExecSQL;
    End;
    fCommit;
  Finally
    LUpdate.Close;

    FreeAndNil(LUpdate);

    FListaDuplicatasAtualizar.Clear;
  End;
end;

procedure TPagForBancoDoBrasilAPI.CorrigeDatasEValores(
  var AValorDuplicata: String; AData: Boolean = True);
begin
  If AData Then
  Begin
    If Not AValorDuplicata.IsEmpty Then
      AValorDuplicata := fStrZero(AValorDuplicata, 8).Insert(2, '/').Insert(5, '/');
  End
  Else
    AValorDuplicata := AValorDuplicata.Replace('.', EmptyStr).Replace(',', EmptyStr);
end;

constructor TPagForBancoDoBrasilAPI.Create(AConfiguracao: String);
begin
  FDadosCarteira := TPagForAPIDadosCarteira.Create('001', AConfiguracao);
  FRestSynalist := TRestSynalistAutban.Create;
  FPagFor := TPagFor.Create;

  FErroExportacao := False;
  FEnviouAlgumRegistro := False;

  FErrosGeradosExportacao := TStringList.Create;

  FRestSynalist.CarregaCertificados(AConfiguracao,
                                    FDadosCarteira.CertificadoPfx,
                                    EmptyStr,
                                    EmptyStr,
                                    FDadosCarteira.SenhaCertificado);
end;

destructor TPagForBancoDoBrasilAPI.Destroy;
begin
  FreeAndNil(FDadosCarteira);
  FreeAndNil(FRestSynalist);
  FreeAndNil(FPagFor);
  FreeAndNil(FErrosGeradosExportacao);
end;

function TPagForBancoDoBrasilAPI.DeveRealizaroEnvio(AFinalDataset: Boolean;
  AContadorRegistros: Integer): Boolean;
begin
  Result := False;

  If AFinalDataset Then
    Exit(True);

  If AContadorRegistros >= 99 Then
    Exit(True);
end;

procedure TPagForBancoDoBrasilAPI.ExibeMensagensDeErrosNaExportacao(ATipoExportacao: String);
begin
  If FErrosGeradosExportacao.Count = 0 Then
    Exit;

  fMensagem('ATENÇÃO', 'Uma ou mais duplicatas de ' + ATipoExportacao + ' não foram aceitas por conter algum erro. ' + #13 +
                       RetornaTextoDoErrosNaExportacao, ['&Ok']);
end;

function TPagForBancoDoBrasilAPI.ExportaRemessaAoBanco(prgStatus: TcxProgressBar): Boolean;
  Var
    LRemessa,
    LDeposito: TUniQuery;

    LExisteRegistros: Boolean;

    LMensagem: String;
begin
  LRemessa := fCriaQuery;
  LDeposito := fCriaQuery;

  FPagFor.ListaRequisicoesAPI := TList<TRequisicaoRegistroAPI>.Create;

  Result := True;

  Try
    LRemessa.SQL.Text := FPagFor.RetornaSQLExportacao('001', 'API');
    LRemessa.ParamByname('CODBCO').AsString := FDadosCarteira.CodigoBanco;
    LRemessa.Open;

    LDeposito.SQL.Text := FPagFor.RetornaSQLExportacaoDeposito('001', 'API');
    LDeposito.ParamByname('CODBCO').AsString := FDadosCarteira.CodigoBanco;
    LDeposito.ParamByname('FORMAPGTO').AsString := 'DEP';
    LDeposito.Open;

    LExisteRegistros := Not LRemessa.IsEmpty;
    If Not LExisteRegistros Then
      LExisteRegistros := Not LDeposito.IsEmpty;

    If Not LExisteRegistros Then
    Begin
      fMensagem('ATENÇÃO', 'Não existem duplicatas geradas para a exportação da remessa ao banco.', ['&Ok']);
      Exit;
    End;

    If fMensagem('ATENÇÃO', 'Deseja realmente exportar a remessa para a API do Banco do Brasil?',
                            ['&Sim', 'Não']) = 2 Then
      Exit;

    pProgresso(0, 11, prgStatus);

    FEnviouAlgumRegistro := False;

    TransfereLoteBoletos(LRemessa, prgStatus);
    TransfereLoteGuiaComCodigoDeBarras(LRemessa, prgStatus);
    TransfereLoteTransferencias(LRemessa, prgStatus);
    TransfereLoteTransferenciasSalarios(LRemessa, prgStatus);
    TransfereLoteTransferenciasPix(LRemessa, prgStatus);
    TransfereLoteOutrasGuiasGPS(LRemessa, prgStatus);
    TransfereLoteOutrasGuiasDARF(LRemessa, prgStatus);
    TransfereLoteOutrasGuiasGRU(LRemessa, prgStatus);

    pStepStatusGravacao(prgStatus, 'Aguarde... Gravando log de requisições.');
    FPagFor.GravaRegistrosRegPGI;

    pStepStatusGravacao(prgStatus, 'Aguarde... Limpando dados.');

    If FEnviouAlgumRegistro Then
      FPagFor.pApagaCadPgi('001');

    If Not FErroExportacao Then
    Begin
      LMensagem := 'Registros exportados a API com sucesso.';
      If Not FEnviouAlgumRegistro Then
        LMensagem := 'Não existem duplicatas válidas geradas para a exportação da remessa ao banco.';

      fMensagem('ATENÇÃO', LMensagem, ['&Ok']);
    End
    Else
      fMensagem('ATENÇÃO', 'Ocorreram erros durante a exportação dos registros.', ['&Ok']);
  Finally
    LRemessa.Close;
    FreeAndNil(LRemessa);

    LDeposito.Close;
    FreeAndNil(LDeposito);
  End;
end;

function TPagForBancoDoBrasilAPI.ExtrairDDDTelefone(ANumTelefone: String): String;
begin
  Result := '';
  ANumTelefone := fStrZero(ANumTelefone, 12);

  If (ANumTelefone.Length = 12) Then
  Begin
    If (Not ANumTelefone.StartsWith('0')) Then // Valida primeiro caractere do DDD
      Result := LeftStr(ANumTelefone, 2)
    Else If (ANumTelefone[2] <> '0') Then // Valida segundo caractere do DDD
      Result := Copy(ANumTelefone, 2, 2)
    Else If (ANumTelefone[3] <> '0') Then // Valida terceiro caractere do DDD
      Result := Copy(ANumTelefone, 3, 2);
  End
  Else If (ANumTelefone.Length > 12) And (ANumTelefone.StartsWith('55')) Then
  Begin
    If (ANumTelefone[3] <> '0') Then // Valida primeiro caractere após o DDI
      Result := Copy(ANumTelefone, 3, 2)
    Else If (ANumTelefone[4] <> '0') Then // Valida segundo caractere após o DDI
      Result := Copy(ANumTelefone, 4, 2);
  End;
end;

function TPagForBancoDoBrasilAPI.ImportarPagamentos(ADataInicial,
  ADataFinal: TDateTime; var ADatasetNaoBaixa: TUniClientDataset): TList<TPagForRetorno>;
  Var
    LConsulta: TUniQuery;
begin
  Result := TList<TPagForRetorno>.Create;

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT CTP_NUMLOT, CTP_TIPLOT ' +
                          'FROM CADPAG ' +
                          'WHERE CTP_CARLOT=:CARLOT ' +
                          '  AND CTP_PAGLOT BETWEEN :DTAINI AND :DTAFIN ' +
                          'GROUP BY CTP_NUMLOT ' +
                          'ORDER BY CTP_PAGLOT, CTP_NUMLOT ';

    LConsulta.ParamByName('CARLOT').AsString := FDadosCarteira.Configuracao;
    LConsulta.ParamByName('DTAINI').AsDateTime := ADataInicial;
    LConsulta.ParamByName('DTAFIN').AsDateTime := ADataFinal;

    LConsulta.Open;

    If LConsulta.isEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Não existem lotes de registros a serem importados no período selecionado.', ['&Ok']);

      Exit;
    End;

    FDataInicial := ADataInicial;
    FDataFinal := ADataFinal;

    FRegistrosLotes := fCriaClientDatSet(LConsulta);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;

  Try
    FDuplicatasRetorno := TList<TPagForRetorno>.Create;

    FDatasetNaoBaixa := ADatasetNaoBaixa;

    pCriarFormularios(TfrmGravando, FGravando);
    FGravando.lblGravando.Caption := 'Aguarde... Importando pagamentos.';
    FGravando.fExecutarAcao := ImportarTodosPagamentos;
    FGravando.ShowModal;
  Finally
    Result := FDuplicatasRetorno;

    FreeAndNil(FGravando);

    FRegistrosLotes.Close;

    FreeAndNil(FRegistrosLotes);
  End;
end;

procedure TPagForBancoDoBrasilAPI.ImportarRegistrosBoletos(
  var ALista: TList<TPagForRetorno>; var ADatasetLotes: TUniClientDataset);
  Var
    LSucesso: Boolean;

    LRetorno: String;

    LParametros: TStringList;

    LJsonObject: TJsonObject;

    LArrayLancamentos: TJsonArray;

    LLancamento: TJsonValue;

    LDuplicata: TPagForRetorno;
begin
  ADatasetLotes.Filter := 'CTP_TIPLOT=''BOLETOS'' ';
  ADatasetLotes.Filtered := True;

  If ADatasetLotes.IsEmpty Then
    Exit;

  LParametros := TStringList.Create;

  Try
    ADatasetLotes.First;

    FGravando.lblGravando.Caption := 'Aguarde... Importando Boletos.';
    pProgresso(0, ADatasetLotes.RecordCount, FGravando.pgbStatus);

    While Not ADatasetLotes.Eof Do
    Begin
      LParametros.Clear;
      LParametros.Add('Authorization: ' + RetornaToken);
      LParametros.Add('Accept: application/json');

      LSucesso := MatchStr(FRestSynalist.ExecuteRestSynalist('GET',
                                                             RetornaLinkDoAmbiente('lotes-boletos/' + ADatasetLotes.FieldByName('CTP_NUMLOT').AsString + '/solicitacao'),
                                                             LParametros,
                                                             LRetorno,
                                                             EmptyStr,
                                                             'application/json').ToString, ['200', '201']);
      pStepStatusGravacao(FGravando.pgbStatus);

      If Not LSucesso Then
      Begin
        ADatasetLotes.Next;
        Continue;
      End;

      LJsonObject := TJSONObject.ParseJSONValue(LRetorno) As TJsonObject;

      LArrayLancamentos := TJSONObject.ParseJSONValue(LJsonObject.GetValue('lancamentos').ToJSON) As TJsonArray;
      For LLancamento In LArrayLancamentos Do
      Begin
        LDuplicata := TPagForRetorno.Create;
        LDuplicata.Tipo := 'Boletos';
        LDuplicata.TipoPagamento := tppBoletos;
        LDuplicata.NumeroLotePagamento := ADatasetLotes.FieldByName('CTP_NUMLOT').AsString;
        LDuplicata.IDPagamento := LLancamento.GetValue<String>('codigoIdentificadorPagamento');
        LDuplicata.DataPagamento := LLancamento.GetValue<String>('dataPagamento');

        LDuplicata.AutoIncremDuplicata := LLancamento.GetValue<String>('codigoSeuDocumento');
        LDuplicata.CodigoBarras := LLancamento.GetValue<String>('numeroCodigoBarras');
        LDuplicata.ValorDuplicata := LLancamento.GetValue<String>('valorNominal');

        ALista.Add(LDuplicata);
      End;

      FreeAndNil(LJsonObject);

      ADatasetLotes.Delete;
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TPagForBancoDoBrasilAPI.ImportarRegistrosGuiasComCodigoDeBarras(
  var ALista: TList<TPagForRetorno>; var ADatasetLotes: TUniClientDataset);
  Var
    LSucesso: Boolean;

    LRetorno: String;

    LParametros: TStringList;

    LJsonObject: TJsonObject;

    LArrayLancamentos: TJsonArray;

    LLancamento: TJsonValue;

    LDuplicata: TPagForRetorno;
begin
  ADatasetLotes.Filter := 'CTP_TIPLOT=''GUIAS CODIGO BARRAS'' ';
  ADatasetLotes.Filtered := True;

  If ADatasetLotes.IsEmpty Then
    Exit;

  LParametros := TStringList.Create;

  Try
    ADatasetLotes.First;

    FGravando.lblGravando.Caption := 'Aguarde... Importando Guias com Código de Barras.';
    pProgresso(0, ADatasetLotes.RecordCount, FGravando.pgbStatus);

    While Not ADatasetLotes.Eof Do
    Begin
      LParametros.Clear;
      LParametros.Add('Authorization: ' + RetornaToken);
      LParametros.Add('Accept: application/json');

      LSucesso := MatchStr(FRestSynalist.ExecuteRestSynalist('GET',
                                                             RetornaLinkDoAmbiente('lotes-guias-codigo-barras/' + ADatasetLotes.FieldByName('CTP_NUMLOT').AsString + '/solicitacao'),
                                                             LParametros,
                                                             LRetorno,
                                                             EmptyStr,
                                                             'application/json').ToString, ['200', '201']);

      pStepStatusGravacao(FGravando.pgbStatus);

      If Not LSucesso Then
      Begin
        ADatasetLotes.Next;
        Continue;
      End;

      LJsonObject := TJSONObject.ParseJSONValue(LRetorno) As TJsonObject;

      LArrayLancamentos := TJSONObject.ParseJSONValue(LJsonObject.GetValue('pagamentos').ToJSON) As TJsonArray;
      For LLancamento In LArrayLancamentos Do
      Begin
        LDuplicata := TPagForRetorno.Create;
        LDuplicata.Tipo := 'lotes-guias-codigo-barras';
        LDuplicata.TipoPagamento := tppGuiaComCodigoBarras;
        LDuplicata.NumeroLotePagamento := ADatasetLotes.FieldByName('CTP_NUMLOT').AsString;
        LDuplicata.IDPagamento := LLancamento.GetValue<String>('codigoPagamento');
        LDuplicata.DataPagamento := LLancamento.GetValue<String>('dataPagamento');

        LDuplicata.AutoIncremDuplicata := LLancamento.GetValue<String>('codigoSeuDocumento');
        LDuplicata.CodigoBarras := LLancamento.GetValue<String>('codigoBarras');
        LDuplicata.ValorDuplicata := LLancamento.GetValue<String>('valorPagamento');

        ALista.Add(LDuplicata);
      End;

      FreeAndNil(LJsonObject);

      ADatasetLotes.Delete;
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TPagForBancoDoBrasilAPI.ImportarRegistrosOutrasGuiasDARF(
  var ALista: TList<TPagForRetorno>; var ADatasetLotes: TUniClientDataset);
  Var
    LSucesso: Boolean;

    LRetorno: String;

    LParametros: TStringList;

    LJsonObject,
    LJsonPagamento: TJsonObject;

    LArrayLancamentos: TJsonArray;

    LLancamento: TJsonValue;

    LDuplicata: TPagForRetorno;
begin
  ADatasetLotes.Filter := 'CTP_TIPLOT=''GUIAS-DARF'' ';
  ADatasetLotes.Filtered := True;

  If ADatasetLotes.IsEmpty Then
    Exit;

  LParametros := TStringList.Create;

  Try
    ADatasetLotes.First;

    FGravando.lblGravando.Caption := 'Aguarde... Importando DARF.';
    pProgresso(0, ADatasetLotes.RecordCount, FGravando.pgbStatus);

    While Not ADatasetLotes.Eof Do
    Begin
      LParametros.Clear;
      LParametros.Add('Authorization: ' + RetornaToken);
      LParametros.Add('Accept: application/json');

      LSucesso := MatchStr(FRestSynalist.ExecuteRestSynalist('GET',
                                                             RetornaLinkDoAmbiente('lotes-darf-preto-normal/' + ADatasetLotes.FieldByName('CTP_NUMLOT').AsString + '/solicitacao'),
                                                             LParametros,
                                                             LRetorno,
                                                             EmptyStr,
                                                             'application/json').ToString, ['200', '201']);

      pStepStatusGravacao(FGravando.pgbStatus);

      If Not LSucesso Then
      Begin
        ADatasetLotes.Next;
        Continue;
      End;

      LJsonObject := TJSONObject.ParseJSONValue(LRetorno) As TJsonObject;

      LArrayLancamentos := TJSONObject.ParseJSONValue(LJsonObject.GetValue('lancamentos').ToJSON) As TJsonArray;
      For LLancamento In LArrayLancamentos Do
      Begin
        LJsonPagamento := TJSONObject.ParseJSONValue((LLancamento as TJsonObject).GetValue('pagamento').ToJson) As TJsonObject;

        LDuplicata := TPagForRetorno.Create;
        LDuplicata.Tipo := 'guias-darf';
        LDuplicata.TipoPagamento := tppDARF;
        LDuplicata.NumeroLotePagamento := ADatasetLotes.FieldByName('CTP_NUMLOT').AsString;
        LDuplicata.IDPagamento := LJsonPagamento.GetValue<String>('id');
        LDuplicata.DataPagamento := LJsonPagamento.GetValue<String>('data');

        LDuplicata.AutoIncremDuplicata := LLancamento.GetValue<String>('codigoDocumento');
        LDuplicata.ValorDuplicata := LJsonPagamento.GetValue<String>('valorPrincipal');

        ALista.Add(LDuplicata);

        FreeAndNil(LJsonPagamento);
      End;

      FreeAndNil(LJsonObject);

      ADatasetLotes.Delete;
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TPagForBancoDoBrasilAPI.ImportarRegistrosOutrasGuiasGPS(
  var ALista: TList<TPagForRetorno>; var ADatasetLotes: TUniClientDataset);
  Var
    LSucesso: Boolean;

    LRetorno: String;

    LParametros: TStringList;

    LJsonObject: TJsonObject;

    LArrayLancamentos: TJsonArray;

    LLancamento: TJsonValue;

    LDuplicata: TPagForRetorno;
begin
  ADatasetLotes.Filter := 'CTP_TIPLOT=''GUIAS-GPS'' ';
  ADatasetLotes.Filtered := True;

  If ADatasetLotes.IsEmpty Then
    Exit;

  LParametros := TStringList.Create;

  Try
    ADatasetLotes.First;

    FGravando.lblGravando.Caption := 'Aguarde... Importando GPS.';
    pProgresso(0, ADatasetLotes.RecordCount, FGravando.pgbStatus);

    While Not ADatasetLotes.Eof Do
    Begin
      LParametros.Clear;
      LParametros.Add('Authorization: ' + RetornaToken);
      LParametros.Add('Accept: application/json');

      LSucesso := MatchStr(FRestSynalist.ExecuteRestSynalist('GET',
                                                             RetornaLinkDoAmbiente('lotes-gps/' + ADatasetLotes.FieldByName('CTP_NUMLOT').AsString + '/solicitacao'),
                                                             LParametros,
                                                             LRetorno,
                                                             EmptyStr,
                                                             'application/json').ToString, ['200', '201']);

      pStepStatusGravacao(FGravando.pgbStatus);

      If Not LSucesso Then
      Begin
        ADatasetLotes.Next;
        Continue;
      End;

      LJsonObject := TJSONObject.ParseJSONValue(LRetorno) As TJsonObject;

      LArrayLancamentos := TJSONObject.ParseJSONValue(LJsonObject.GetValue('lancamentos').ToJSON) As TJsonArray;
      For LLancamento In LArrayLancamentos Do
      Begin
        LDuplicata := TPagForRetorno.Create;
        LDuplicata.Tipo := 'guias-gps';
        LDuplicata.TipoPagamento := tppGPS;
        LDuplicata.NumeroLotePagamento := ADatasetLotes.FieldByName('CTP_NUMLOT').AsString;
        LDuplicata.IDPagamento := LLancamento.GetValue<String>('codigoIdentificadorPagamento');
        LDuplicata.DataPagamento := LLancamento.GetValue<String>('dataPagamento');

        LDuplicata.AutoIncremDuplicata := LLancamento.GetValue<String>('codigoSeuDocumento');
        LDuplicata.ValorDuplicata := LLancamento.GetValue<String>('valorPagamento');

        ALista.Add(LDuplicata);
      End;

      FreeAndNil(LJsonObject);

      ADatasetLotes.Delete;
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TPagForBancoDoBrasilAPI.ImportarRegistrosOutrasGuiasGRU(
  var ALista: TList<TPagForRetorno>; var ADatasetLotes: TUniClientDataset);
  Var
    LSucesso: Boolean;

    LRetorno: String;

    LParametros: TStringList;

    LJsonObject,
    LJsonPagamento: TJsonObject;

    LArrayLancamentos: TJsonArray;

    LLancamento: TJsonValue;

    LDuplicata: TPagForRetorno;
begin
  ADatasetLotes.Filter := 'CTP_TIPLOT=''GUIAS-GRU'' ';
  ADatasetLotes.Filtered := True;

  If ADatasetLotes.IsEmpty Then
    Exit;

  LParametros := TStringList.Create;

  Try
    ADatasetLotes.First;

    FGravando.lblGravando.Caption := 'Aguarde... Importando GRU.';
    pProgresso(0, ADatasetLotes.RecordCount, FGravando.pgbStatus);

    While Not ADatasetLotes.Eof Do
    Begin
      LParametros.Clear;
      LParametros.Add('Authorization: ' + RetornaToken);
      LParametros.Add('Accept: application/json');

      LSucesso := MatchStr(FRestSynalist.ExecuteRestSynalist('GET',
                                                             RetornaLinkDoAmbiente('lotes-gru/' + ADatasetLotes.FieldByName('CTP_NUMLOT').AsString + '/solicitacao'),
                                                             LParametros,
                                                             LRetorno,
                                                             EmptyStr,
                                                             'application/json').ToString, ['200', '201']);

      pStepStatusGravacao(FGravando.pgbStatus);

      If Not LSucesso Then
      Begin
        ADatasetLotes.Next;
        Continue;
      End;

      LJsonObject := TJSONObject.ParseJSONValue(LRetorno) As TJsonObject;

      LArrayLancamentos := TJSONObject.ParseJSONValue(LJsonObject.GetValue('lancamentos').ToJSON) As TJsonArray;
      For LLancamento In LArrayLancamentos Do
      Begin
        LJsonPagamento := TJSONObject.ParseJSONValue((LLancamento as TJsonObject).GetValue('pagamento').ToJson) As TJsonObject;

        LDuplicata := TPagForRetorno.Create;
        LDuplicata.Tipo := 'guias-gru';
        LDuplicata.TipoPagamento := tppGRU;
        LDuplicata.NumeroLotePagamento := ADatasetLotes.FieldByName('CTP_NUMLOT').AsString;
        LDuplicata.CodigoBarras := LLancamento.GetValue<String>('textoCodigoBarras');
        LDuplicata.IDPagamento := LJsonPagamento.GetValue<String>('id');
        LDuplicata.DataPagamento := LJsonPagamento.GetValue<String>('data');

        LDuplicata.AutoIncremDuplicata := LJsonPagamento.GetValue<String>('textoDescricao');
        LDuplicata.ValorDuplicata := LJsonPagamento.GetValue<String>('valorPrincipal');

        ALista.Add(LDuplicata);

        FreeAndNil(LJsonPagamento);
      End;

      FreeAndNil(LJsonObject);

      ADatasetLotes.Delete;
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TPagForBancoDoBrasilAPI.ImportarRegistrosTransferencias(
  var ALista: TList<TPagForRetorno>; var ADatasetLotes: TUniClientDataset);
  Var
    LSucesso: Boolean;

    LRetorno: String;

    LParametros: TStringList;

    LJsonObject: TJsonObject;

    LArrayLancamentos: TJsonArray;

    LLancamento: TJsonValue;

    LDuplicata: TPagForRetorno;
begin
  ADatasetLotes.Filter := 'CTP_TIPLOT=''TRANSFERENCIAS'' OR CTP_TIPLOT=''TRANSFERENCIAS-SALARIOS'' ';
  ADatasetLotes.Filtered := True;

  If ADatasetLotes.IsEmpty Then
    Exit;

  LParametros := TStringList.Create;

  Try
    ADatasetLotes.First;

    FGravando.lblGravando.Caption := 'Aguarde... Importando Transferências.';
    pProgresso(0, ADatasetLotes.RecordCount, FGravando.pgbStatus);

    While Not ADatasetLotes.Eof Do
    Begin
      LParametros.Clear;
      LParametros.Add('Authorization: ' + RetornaToken);
      LParametros.Add('Accept: application/json');

      LSucesso := MatchStr(FRestSynalist.ExecuteRestSynalist('GET',
                                                             RetornaLinkDoAmbiente(ADatasetLotes.FieldByName('CTP_NUMLOT').AsString + '/solicitacao'),
                                                             LParametros,
                                                             LRetorno,
                                                             EmptyStr,
                                                             'application/json').ToString, ['200', '201']);

      pStepStatusGravacao(FGravando.pgbStatus);

      If Not LSucesso Then
      Begin
        ADatasetLotes.Next;
        Continue;
      End;

      LJsonObject := TJSONObject.ParseJSONValue(LRetorno) As TJsonObject;

      LArrayLancamentos := TJSONObject.ParseJSONValue(LJsonObject.GetValue('pagamentos').ToJSON) As TJsonArray;
      For LLancamento In LArrayLancamentos Do
      Begin
        LDuplicata := TPagForRetorno.Create;
        LDuplicata.Tipo := 'lotes-transferencias';
        LDuplicata.TipoPagamento := tppTransferencias;
        If ADatasetLotes.FieldByName('CTP_TIPLOT').AsString.Equals('TRANSFERENCIAS-SALARIOS') Then
          LDuplicata.TipoPagamento := tppTransferenciasSalario;
        LDuplicata.NumeroLotePagamento := ADatasetLotes.FieldByName('CTP_NUMLOT').AsString;
        LDuplicata.IDPagamento := LLancamento.GetValue<String>('identificadorPagamento');
        LDuplicata.DataPagamento := LLancamento.GetValue<String>('dataPagamento');

        LDuplicata.AutoIncremDuplicata := LLancamento.GetValue<String>('descricaoPagamento');
        LDuplicata.ValorDuplicata := LLancamento.GetValue<String>('valorPagamento');

        ALista.Add(LDuplicata);
      End;

      FreeAndNil(LJsonObject);

      ADatasetLotes.Delete;
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TPagForBancoDoBrasilAPI.ImportarRegistrosTransferenciasPix(
  var ALista: TList<TPagForRetorno>; var ADatasetLotes: TUniClientDataset);
  Var
    LSucesso: Boolean;

    LRetorno: String;

    LParametros: TStringList;

    LJsonObject: TJsonObject;

    LArrayLancamentos: TJsonArray;

    LLancamento: TJsonValue;

    LDuplicata: TPagForRetorno;
begin
  ADatasetLotes.Filter := 'CTP_TIPLOT=''TRANSFERENCIAS-PIX'' ';
  ADatasetLotes.Filtered := True;

  If ADatasetLotes.IsEmpty Then
    Exit;

  LParametros := TStringList.Create;

  Try
    ADatasetLotes.First;

    FGravando.lblGravando.Caption := 'Aguarde... Importando Transferências Pix.';
    pProgresso(0, ADatasetLotes.RecordCount, FGravando.pgbStatus);

    While Not ADatasetLotes.Eof Do
    Begin
      LParametros.Clear;
      LParametros.Add('Authorization: ' + RetornaToken);
      LParametros.Add('Accept: application/json');

      LSucesso := MatchStr(FRestSynalist.ExecuteRestSynalist('GET',
                                                             RetornaLinkDoAmbiente('lotes-transferencias-pix/' + ADatasetLotes.FieldByName('CTP_NUMLOT').AsString + '/solicitacao'),
                                                             LParametros,
                                                             LRetorno,
                                                             EmptyStr,
                                                             'application/json').ToString, ['200', '201']);

      pStepStatusGravacao(FGravando.pgbStatus);

      If Not LSucesso Then
      Begin
        ADatasetLotes.Next;
        Continue;
      End;

      LJsonObject := TJSONObject.ParseJSONValue(LRetorno) As TJsonObject;

      LArrayLancamentos := TJSONObject.ParseJSONValue(LJsonObject.GetValue('listaTransferencias').ToJSON) As TJsonArray;
      For LLancamento In LArrayLancamentos Do
      Begin
        LDuplicata := TPagForRetorno.Create;
        LDuplicata.Tipo := 'lotes-transferencias-pix';
        LDuplicata.TipoPagamento := tppTransferenciasPix;
        LDuplicata.NumeroLotePagamento := ADatasetLotes.FieldByName('CTP_NUMLOT').AsString;
        LDuplicata.IDPagamento := LLancamento.GetValue<String>('identificadorPagamento');
        LDuplicata.DataPagamento := LLancamento.GetValue<String>('data');

        LDuplicata.AutoIncremDuplicata := LLancamento.GetValue<String>('descricaoPagamento');
        LDuplicata.ValorDuplicata := LLancamento.GetValue<String>('valor');

        ALista.Add(LDuplicata);
      End;

      FreeAndNil(LJsonObject);

      ADatasetLotes.Delete;
    End;
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TPagForBancoDoBrasilAPI.ImportarTodosPagamentos(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;

  Try
    ImportarRegistrosBoletos(FDuplicatasRetorno, FRegistrosLotes);
    ImportarRegistrosGuiasComCodigoDeBarras(FDuplicatasRetorno, FRegistrosLotes);
    ImportarRegistrosTransferencias(FDuplicatasRetorno, FRegistrosLotes);
    ImportarRegistrosTransferenciasPix(FDuplicatasRetorno, FRegistrosLotes);
    ImportarRegistrosOutrasGuiasGPS(FDuplicatasRetorno, FRegistrosLotes);
    ImportarRegistrosOutrasGuiasDARF(FDuplicatasRetorno, FRegistrosLotes);
    ImportarRegistrosOutrasGuiasGRU(FDuplicatasRetorno, FRegistrosLotes);

    RetornaDadosDosPagamentos(FDuplicatasRetorno,
                              FDataInicial,
                              FDataFinal);

    FPagFor.ValidarPagamentosAPI('001',
                                 FDuplicatasRetorno,
                                 FDatasetNaoBaixa,
                                 FGravando);
  Except
    On E: Exception Do
    Begin
      Result := False;

      pMensagensErro(E.Message, '[TPagForBancoDoBrasilAPI.ImportarTodosPagamentos]');
    End;
  End;
end;

procedure TPagForBancoDoBrasilAPI.LimpaDadosGeracaoDuplicata(
  AAutoIncremCadPag: String);
begin
  Try
    fExecutaSQL('UPDATE CADPAG SET CTP_BCOENV=NULL, CTP_DTAENV=NULL ' +
                'WHERE AUTOINCREM="' + AAutoIncremCadPag + '"', True);

    untLogCtp.GravaLogCtp(AAutoIncremCadPag,
                          'LIMPEZA DE REMESSA NÃO ACEITA PAGFOR API - CTP - 001',
                          'untTPagForBancoDoBrasilAPI');
  Except
    Raise;
  End;
end;

function TPagForBancoDoBrasilAPI.RetornaCodigoPeloEstadoPagamento(
  AEstadoPagamento: String): String;
begin
  Result := '00';

  AEstadoPagamento := AEstadoPagamento.ToUpperInvariant;

  If AEstadoPagamento.Equals('PAGO') Then
    Exit;

  If AEstadoPagamento.Equals('AGENDADO') Then
    Exit('900')
  Else If AEstadoPagamento.Equals('CANCELADO') Then
    Exit('901')
  Else If AEstadoPagamento.Equals('CONSISTENTE') Then
    Exit('902')
  Else If AEstadoPagamento.Equals('DEVOLVIDO') Then
    Exit('903')
  Else If AEstadoPagamento.Equals('INCONSISTENTE') Then
    Exit('904')
  Else If AEstadoPagamento.Equals('BLOQUEADO') Then
    Exit('905')
  Else If AEstadoPagamento.Equals('PENDENTE') Then
    Exit('906')
  Else If AEstadoPagamento.Equals('REJEITADO') Then
    Exit('907')
  Else If AEstadoPagamento.Equals('VENCIDO') Then
    Exit('908');
end;

procedure TPagForBancoDoBrasilAPI.RetornaDadosDosPagamentos(
  var ADuplicatas: TList<TPagforRetorno>; ADataInicial, ADataFinal: TDateTime);
  Var
    LRetorno,
    LLinkRegistro,
    LDataPagamento: String;

    LDuplicata: TPagForRetorno;

    LParametros: TStringList;

    LJsonObject: TJsonObject;

    LJsonErros: TJsonArray;

    LSucesso: Boolean;

    LDuplicatasRetorno: TList<TPagforRetorno>;
begin
  If ADuplicatas.Count = 0 Then
    Exit;

  LDuplicatasRetorno := TList<TPagforRetorno>.Create;

  LParametros := TStringList.Create;

  FGravando.lblGravando.Caption := 'Aguarde... Importando registros dos pagamentos.';
  pProgresso(0, ADuplicatas.Count, FGravando.pgbStatus);

  LJsonErros := TJsonArray.Create;

  Try
    For LDuplicata In ADuplicatas Do
    Begin
      LDataPagamento := fStrZero(LDuplicata.DataPagamento, 8).Insert(2, '/')
                                                             .Insert(5, '/');

      pStepStatusGravacao(FGravando.pgbStatus);

      If Not DateInRange(StrToDateTime(LDataPagamento), ADataInicial, ADataFinal) Then
        Continue;

      LLinkRegistro := EmptyStr;
      Case LDuplicata.TipoPagamento Of
        tppBoletos: LLinkRegistro := RetornaLinkDoAmbiente('boletos/' + LDuplicata.IDPagamento);
        tppGuiaComCodigoBarras: LLinkRegistro := RetornaLinkDoAmbiente('guias-codigo-barras/' + LDuplicata.IDPagamento);
        tppTransferencias: LLinkRegistro := RetornaLinkDoAmbiente('transferencias/' + LDuplicata.IDPagamento);
        tppTransferenciasSalario: LLinkRegistro := RetornaLinkDoAmbiente('transferencias/' + LDuplicata.IDPagamento);
        tppTransferenciasPix: LLinkRegistro := RetornaLinkDoAmbiente('pix/' + LDuplicata.IDPagamento);
        tppGPS: LLinkRegistro := RetornaLinkDoAmbiente('gps/' + LDuplicata.IDPagamento);
        tppDARF: LLinkRegistro := RetornaLinkDoAmbiente('darf-preto/' + LDuplicata.IDPagamento);
        tppGRU: LLinkRegistro := RetornaLinkDoAmbiente('gru/' + LDuplicata.IDPagamento);
      End;

      LParametros.Clear;
      LParametros.Add('Authorization: ' + RetornaToken);
      LParametros.Add('Accept: application/json');

      LSucesso := MatchStr(FRestSynalist.ExecuteRestSynalist('GET',
                                                             LLinkRegistro,
                                                             LParametros,
                                                             LRetorno,
                                                             EmptyStr,
                                                             'application/json').ToString, ['200', '201']);

      If Not LSucesso Then
        Raise Exception.Create(LRetorno);

      LJsonObject := TJSONObject.ParseJSONValue(LRetorno) As TJSONObject;

      If LDuplicata.TipoPagamento <> tppTransferenciasPix Then
        LJsonErros := TJSONObject.ParseJSONValue(LJsonObject.GetValue('listaDevolucao').ToJSON) As TJsonArray;

      LDuplicata.DataPagamento := LJsonObject.GetValue<string>('dataPagamento');
      LDuplicata.ValorPago := LJsonObject.GetValue<string>('valorPagamento');
      LDuplicata.EstadoPagamento := LJsonObject.GetValue<string>('estadoPagamento');

      LDuplicata.CodigosOcorrencia := RetornaCodigoPeloEstadoPagamento(LDuplicata.EstadoPagamento);
      If LJsonErros.Count > 0 THen
        LDuplicata.CodigosOcorrencia := LJsonErros.Items[0].GetValue<String>('codigoMotivo');

      CorrigeDatasEValores(LDuplicata.DataOcorrencia);
      CorrigeDatasEValores(LDuplicata.DataPagamento);
      CorrigeDatasEValores(LDuplicata.DataVencimento);

      CorrigeDatasEValores(LDuplicata.ValorDuplicata, False);
      CorrigeDatasEValores(LDuplicata.ValorPago, False);
      CorrigeDatasEValores(LDuplicata.ValorJuros, False);
      CorrigeDatasEValores(LDuplicata.ValorDesconto, False);

      LDuplicatasRetorno.Add(LDuplicata);

      FreeAndNil(LJsonObject);
    End;
  Finally
    FreeAndNil(LParametros);
  End;

  ADuplicatas := LDuplicatasRetorno;
end;

function TPagForBancoDoBrasilAPI.RetornaDataIntegerComoString(
  AData: TDateTime): String;
begin
  Result := FormatDateTime('ddmmyyyy', AData);

  Try
    Result := StrToInt(Result).ToString;
  Except
    Result := '0';
  end;
end;

function TPagForBancoDoBrasilAPI.RetornaLinkDoAmbiente(
  ARecurso: String): String;
begin
  Result := URL_API_PRODUCAO;
  If FDadosCarteira.Homologacao.Equals('S') Then
    Result := URL_API_HOMOLOGACAO;

  Result := Result.Replace('[RECURSO]', ARecurso)
                  .Replace('[GW_DEV_APP_KEY]', FDadosCarteira.ChaveAppAPI);
end;

function TPagForBancoDoBrasilAPI.RetornaLinkTokenDoAmbiente: String;
begin
  Result := URL_TOKEN_PRODUCAO;
  If FDadosCarteira.Homologacao.Equals('S') Then
    Result := URL_TOKEN_HOMOLOGACAO;
end;

function TPagForBancoDoBrasilAPI.RetornaRegistroAPIInicial(ALinkAPI: String;
  AJsonEnviado: TJsonObject; ADescricao: String): TRequisicaoRegistroAPI;
begin
  Result := TRequisicaoRegistroAPI.Create;
  Result.DataRegistro := VS_Date;
  Result.HoraRegistro := fRetHoraServidor;
  Result.Carteira := FDadosCarteira.Configuracao;
  Result.CodigoEmpresa := VS_strCodEmp;
  Result.LinkAPI := ALinkAPI;

  Try
    Result.JsonEnviado := TJson.Format(AJsonEnviado);
  Except
    Result.JsonEnviado := AJsonEnviado.ToJson;
  End;

  Result.DescricaoRequisicao := ADescricao;
  Result.CodigoBanco := '001';
end;

function TPagForBancoDoBrasilAPI.RetornaTextoDoErrosNaExportacao: String;
  Var
    LCodigoErro: String;
begin
  If FErrosGeradosExportacao.Count = 0 Then
    Exit(EmptyStr);

  Result := 'As duplicatas com erros, foram cancelados os dados de envio, para serem corrigidas ' +
            'e realizar a geração e exportação novamente.' + #13 +
            'Erro(s) gerado(s): ' + #13;
  For LCodigoErro In FErrosGeradosExportacao Do
  Begin
    If LCodigoErro.Equals('0') Then
      Continue;

    Result := Result + TPagForBancoDoBrasilAPI.RetornaDescricaoDosErros(StrToInt(LCodigoErro)) + #13;
  End;

  FErrosGeradosExportacao.Clear;
end;

function TPagForBancoDoBrasilAPI.RetornaTextoDoJsonDeErros(
  AErro: String): String;
  Var
    LJsonObject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LErroArray: String;
begin
  Result := AErro;
  Try
    LJsonObject := TJSONObject.ParseJSONValue(AErro) As TJsonObject;

    If LJsonObject = Nil Then
      Exit;

    If Not LJsonObject.TryGetValue('error_description', Result) Then
    Begin
      If LJsonObject.TryGetValue('erros', LJsonArray) Then
      Begin
        For LJsonValue In LJsonArray Do
        Begin
          If (LJsonValue As TJsonObject).TryGetValue('mensagem', LErroArray) Then
            Result := Result + LErroArray.Replace('Número da requisição já utilizado',
                                                  'Número da remessa já utilizado') + #13;
        End;
      End;
    End;

    If Result.IsEmpty Then
      Result := AErro;

    FreeAndNil(LJsonObject);
  Except
    Result := AErro;
  End;
end;

function TPagForBancoDoBrasilAPI.RetornaToken: String;
  Var
    LDadosEnvio: String;

    LParametros: TStringList;
    LContadorTentativas : Integer;
begin
  LContadorTentativas := 1;
  LParametros := TStringList.Create;
  LParametros.Add('Authorization: ' + FDadosCarteira.ChaveBasic);

  LDadosEnvio := 'grant_type=client_credentials&' +
                 'scope=pagamentos-lote.lotes-requisicao pagamentos-lote.transferencias-info ' +
                       'pagamentos-lote.transferencias-requisicao pagamentos-lote.cancelar-requisicao ' +
                       'pagamentos-lote.lotes-info pagamentos-lote.pagamentos-guias-sem-codigo-barras-info ' +
                       'pagamentos-lote.pagamentos-info pagamentos-lote.pagamentos-guias-sem-codigo-barras-requisicao ' +
                       'pagamentos-lote.pagamentos-codigo-barras-info pagamentos-lote.boletos-requisicao pagamentos-lote.guias-codigo-barras-info ' +
                       'pagamentos-lote.guias-codigo-barras-requisicao pagamentos-lote.transferencias-pix-info ' +
                       'pagamentos-lote.transferencias-pix-requisicao pagamentos-lote.pix-info pagamentos-lote.boletos-info ' +
                       'pagamentos-lote.lancamentos-info';

  Try
    While (LContadorTentativas <= 4) Do
    begin
      Try
        Result := 'Bearer ' + FRestSynalist.GetToken('POST',
                                                     RetornaLinkTokenDoAmbiente,
                                                     LParametros,
                                                     FDadosCarteira.Configuracao,
                                                     LDadosEnvio,
                                                     'application/x-www-form-urlencoded',
                                                     False);
      Except
        On E: Exception Do
        begin
          TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
          If LContadorTentativas >= 4 Then
          begin
            Raise Exception.Create('TOKEN-Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                                   'Erro gerado: ' + RetornaTextoDoJsonDeErros(E.Message));
          end;
        end;
      End;
      Inc(LContadorTentativas);
    end;
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TPagForBancoDoBrasilAPI.RetornaValorExportacao(AValor: Double): String;
begin
  Result := FormatFloat(',0.00', AValor);

  Result := Result.Replace('.', EmptyStr)
                  .Replace(',', '.');
end;

function TPagForBancoDoBrasilAPI.TransfereLoteBoletos(
  ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
  Var
    LJsonObject,
    LJsonBoleto: TJsonObject;

    LJsonArray: TJsonArray;

    LSequenciaRemessa,
    LContadorRegistros,
    LCodigoRetorno: Integer;

    LParametros,
    LListaDuplicatas: TStringList;

    LRetorno,
    LLiberacao,
    LRetornoLiberacao: String;

    LDuplicataAtualizar: TDuplicataAtualizar;

    LRegistroAPI: TRequisicaoRegistroAPI;
begin
  Result := True;

  ADatasetRemessa.Filter := ' CODIGO_GUIA IN ("", "-1") ' +
                            ' AND PGI_TIPPAG IN ("","1") AND FORMAPAGTO <> "DEP" AND CODFUN IS NULL ';
  ADatasetRemessa.Filtered := True;

  pStepStatusGravacao(LProgress, 'Aguarde... Exportando Boletos.');

  If ADatasetRemessa.IsEmpty Then
    Exit;

  ADatasetRemessa.First;

  LSequenciaRemessa := StrToInt(FDadosCarteira.SequencialRemessa);

  LListaDuplicatas := TStringList.Create;

  FListaDuplicatasAtualizar := TList<TDuplicataAtualizar>.Create;

  LRegistroAPI := TRequisicaoRegistroAPI.Create;  //Remover hint

  Try
    Repeat
      LJsonObject := TJsonObject.Create;
      LJsonObject.AddPair('numeroRequisicao', LSequenciaRemessa.ToString);
      LJsonObject.AddPair('codigoContrato', FDadosCarteira.Contrato);
      LJsonObject.AddPair('numeroAgenciaDebito', FDadosCarteira.CodigoAgencia);
      LJsonObject.AddPair('numeroContaCorrenteDebito', FDadosCarteira.ContaCorrente);
      LJsonObject.AddPair('digitoVerificadorContaCorrenteDebito', FDadosCarteira.DigitoContaCorrente);

      LJsonArray := TJsonArray.Create;

      Inc(LSequenciaRemessa);
      fGetBancoConfig(1, FDadosCarteira.ConfiguracaoSemEmpresa, 'PROXNUM', LSequenciaRemessa.ToString);
      FDadosCarteira.SequencialRemessa := LSequenciaRemessa.ToString;

      LContadorRegistros := 0;

      LListaDuplicatas.Clear;

      FErrosGeradosExportacao.Clear;

      While Not ADatasetRemessa.Eof Do
      Begin
        LJsonBoleto := TJsonObject.Create;
        LJsonBoleto.AddPair('numeroCodigoBarras', ADatasetRemessa.FieldByName('PGI_CODBAR').AsString);
        LJsonBoleto.AddPair('dataPagamento', RetornaDataIntegerComoString(ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime));
        LJsonBoleto.AddPair('valorPagamento', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALPAG').AsFloat));
        LJsonBoleto.AddPair('codigoSeuDocumento', ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);
        LJsonBoleto.AddPair('valorNominal', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALDUP').AsFloat));
        LJsonBoleto.AddPair('valorDesconto', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALDES').AsFloat));

        If ADatasetRemessa.FieldByName('NUMINS').AsString.Length > 11 Then
          LJsonBoleto.AddPair('codigoTipoBeneficiario',  '2')
        Else
          LJsonBoleto.AddPair('codigoTipoBeneficiario',  '1');

        LJsonBoleto.AddPair('documentoBeneficiario', ADatasetRemessa.FieldByName('NUMINS').AsString);

        LJsonArray.AddElement(LJsonBoleto);

        LListaDuplicatas.Add(ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LDuplicataAtualizar := TDuplicataAtualizar.Create;
        LDuplicataAtualizar.AutoIncremCadPag := ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString;
        LDuplicataAtualizar.NumeroLote := LJsonObject.GetValue<String>('numeroRequisicao');
        LDuplicataAtualizar.DataPagamento := ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime;
        FListaDuplicatasAtualizar.Add(LDuplicataAtualizar);

        pStepStatusGravacao(LProgress);

        ADatasetRemessa.Next;

        Try
          LContadorRegistros := LContadorRegistros + 1;
          If DeveRealizaroEnvio(ADatasetRemessa.Eof, LContadorRegistros) Then
          Begin
            FEnviouAlgumRegistro := True;

            LJsonObject.AddPair('lancamentos', LJsonArray);

            LRegistroAPI := RetornaRegistroAPIInicial(RetornaLinkDoAmbiente('lotes-boletos'),
                                                      LJsonObject,
                                                      'REGISTRO - BOLETOS');

            LParametros := TStringList.Create;
            LParametros.Add('Authorization: ' + RetornaToken);
            LParametros.Add('Accept: application/json');

            LCodigoRetorno := FRestSynalist.ExecuteRestSynalist('POST',
                                                                RetornaLinkDoAmbiente('lotes-boletos'),
                                                                LParametros,
                                                                LRetorno,
                                                                LJsonObject.ToJson,
                                                                'application/json');

            Result := MatchStr(LCodigoRetorno.ToString, ['200', '201']);

            If Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);

              VerificaStatusLancamentosExportados(LListaDuplicatas, LRetorno);

              Result := LListaDuplicatas.Count > 0;

              If Result Then
              Begin
                AtualizarDadosDoLoteDuplicata(LListaDuplicatas,
                                              'BOLETOS');

                if FDadosCarteira.LiberarPagamento.Equals('S') then
                begin
                  LLiberacao := '{' +
                                '  "numeroRequisicao": ' + LJsonObject.GetValue<String>('numeroRequisicao') + ', ' +
                                '  "indicadorFloat": "N" ' +
                                '}';


                  Result := MatchStr(FRestSynalist.ExecuteRestSynalist('POST',
                                                                       RetornaLinkDoAmbiente('liberar-pagamentos'),
                                                                       LParametros,
                                                                       LRetornoLiberacao,
                                                                       LLiberacao,
                                                                       'application/json').ToString, ['200', '201']);
                end;

                FPagFor.GravaLogCtpDuplicatas(LListaDuplicatas,
                                              'ENVIO DE REMESSA PAGFOR API - CTP - 001',
                                              'untTPagForBancoDoBrasilAPI');
              End;
            End;

            If Not Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
              LRegistroAPI.TextoErro := 'Nenhuma das duplicatas de boletos são válidas. Verifique!' + #13 +
                                        RetornaTextoDoErrosNaExportacao;

              FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

              Raise Exception.Create(LRegistroAPI.TextoErro);
            End;

            FreeAndNil(LJsonObject);

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            Break;
          End;
        Except
          On E: Exception Do
          Begin
            fRollBack;

            FErroExportacao := True;

            LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
            LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
            LRegistroAPI.TextoErro := E.Message;

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            if Copy(E.Message, 1, 6) = 'TOKEN-' then
            begin
              fMensagem('ATENÇÃO!', 'Não foi possível realizar a autenticação. ' + #10#13 +
                        'Verifique sua conexão com a internet, confirme suas credenciais e tente novamente mais tarde.', ['&OK']);
              pGravarErro(True,E.Message);
            end
            else
              pMensagensErro(E.Message, 'TPagForBancoDoBrasilAPI.TransfereLoteBoletos');

            Break;
          End;
        End;
      End;

      ExibeMensagensDeErrosNaExportacao('boletos');
    Until(ADatasetRemessa.Eof);
  Finally
    FreeAndNil(LListaDuplicatas);
    FreeAndNil(FListaDuplicatasAtualizar);
  End;
end;

function TPagForBancoDoBrasilAPI.TransfereLoteGuiaComCodigoDeBarras(
  ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
  Var
    LJsonObject,
    LJsonGuia: TJsonObject;

    LJsonArray: TJsonArray;

    LSequenciaRemessa,
    LContadorRegistros,
    LCodigoRetorno: Integer;

    LParametros,
    LListaDuplicatas: TStringList;

    LRetorno,
    LLiberacao,
    LRetornoLiberacao: String;

    LDuplicataAtualizar: TDuplicataAtualizar;

    LRegistroAPI: TRequisicaoRegistroAPI;
begin
  Result := True;

  ADatasetRemessa.Filter := 'PGI_TIPPAG NOT IN ("","1")  ' +
                            ' AND PGI_CODBAR IS NOT NULL ' +
                            ' AND CODIGO_GUIA <> "11" ' +
                            ' AND (FORMAPAGTO <> "DEP"   ' +
                            ' OR (CODIGO_GUIA NOT IN ("", "-1"))) ';
  ADatasetRemessa.Filtered := True;

  pStepStatusGravacao(LProgress, 'Aguarde... Exportando Guias com Código de Barras.');

  If ADatasetRemessa.IsEmpty Then
    Exit;

  ADatasetRemessa.First;

  LSequenciaRemessa := StrToInt(FDadosCarteira.SequencialRemessa);

  LListaDuplicatas := TStringList.Create;

  FErrosGeradosExportacao.Clear;

  FListaDuplicatasAtualizar := TList<TDuplicataAtualizar>.Create;

  LRegistroAPI := TRequisicaoRegistroAPI.Create;  //Remover hint

  Try
    Repeat
      LJsonObject := TJsonObject.Create;
      LJsonObject.AddPair('numeroRequisicao', LSequenciaRemessa.ToString);
      LJsonObject.AddPair('codigoContrato', FDadosCarteira.Contrato);
      LJsonObject.AddPair('numeroAgenciaDebito', FDadosCarteira.CodigoAgencia);
      LJsonObject.AddPair('numeroContaCorrenteDebito', FDadosCarteira.ContaCorrente);
      LJsonObject.AddPair('digitoVerificadorContaCorrenteDebito', FDadosCarteira.DigitoContaCorrente);

      LJsonArray := TJsonArray.Create;

      Inc(LSequenciaRemessa);
      fGetBancoConfig(1, FDadosCarteira.ConfiguracaoSemEmpresa, 'PROXNUM', LSequenciaRemessa.ToString);
      FDadosCarteira.SequencialRemessa := LSequenciaRemessa.ToString;

      LContadorRegistros := 0;

      LListaDuplicatas.Clear;

      While Not ADatasetRemessa.Eof Do
      Begin
        LJsonGuia := TJsonObject.Create;
        LJsonGuia.AddPair('codigoBarras', ADatasetRemessa.FieldByName('PGI_CODBAR').AsString);
        LJsonGuia.AddPair('dataPagamento', RetornaDataIntegerComoString(ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime));
        LJsonGuia.AddPair('valorPagamento', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALPAG').AsFloat));
        LJsonGuia.AddPair('codigoSeuDocumento', ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LJsonArray.AddElement(LJsonGuia);

        LListaDuplicatas.Add(ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LDuplicataAtualizar := TDuplicataAtualizar.Create;
        LDuplicataAtualizar.AutoIncremCadPag := ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString;
        LDuplicataAtualizar.NumeroLote := LJsonObject.GetValue<String>('numeroRequisicao');
        LDuplicataAtualizar.DataPagamento := ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime;
        FListaDuplicatasAtualizar.Add(LDuplicataAtualizar);

        pStepStatusGravacao(LProgress);

        ADatasetRemessa.Next;

        Try
          LContadorRegistros := LContadorRegistros + 1;
          If DeveRealizaroEnvio(ADatasetRemessa.Eof, LContadorRegistros) Then
          Begin
            FEnviouAlgumRegistro := True;

            LJsonObject.AddPair('lancamentos', LJsonArray);

            LRegistroAPI := RetornaRegistroAPIInicial(RetornaLinkDoAmbiente('lotes-guias-codigo-barras'),
                                                      LJsonObject,
                                                      'REGISTRO - GUIAS CODIGO BARRAS');

            LParametros := TStringList.Create;
            LParametros.Add('Authorization: ' + RetornaToken);
            LParametros.Add('Accept: application/json');

            LCodigoRetorno := FRestSynalist.ExecuteRestSynalist('POST',
                                                                RetornaLinkDoAmbiente('lotes-guias-codigo-barras'),
                                                                LParametros,
                                                                LRetorno,
                                                                LJsonObject.ToJson,
                                                                'application/json');

            Result := MatchStr(LCodigoRetorno.ToString, ['200', '201']);


            If Result Then
            Begin
              VerificaStatusLancamentosExportados(LListaDuplicatas, LRetorno);

              Result := LListaDuplicatas.Count > 0;

              If Result Then
              Begin
                LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
                LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);

                AtualizarDadosDoLoteDuplicata(LListaDuplicatas,
                                              'GUIAS CODIGO BARRAS');

                if FDadosCarteira.LiberarPagamento.Equals('S') then
                begin
                  LLiberacao := '{' +
                                '  "numeroRequisicao": ' + LJsonObject.GetValue<String>('numeroRequisicao') + ', ' +
                                '  "indicadorFloat": "N" ' +
                                '}';

                  Result := MatchStr(FRestSynalist.ExecuteRestSynalist('POST',
                                                                       RetornaLinkDoAmbiente('liberar-pagamentos'),
                                                                       LParametros,
                                                                       LRetornoLiberacao,
                                                                       LLiberacao,
                                                                       'application/json').ToString, ['200', '201']);
                end;

                FPagFor.GravaLogCtpDuplicatas(LListaDuplicatas,
                                              'ENVIO DE REMESSA PAGFOR API - CTP - 001',
                                              'untTPagForBancoDoBrasilAPI');
              End;
            End;

            If Not Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
              LRegistroAPI.TextoErro := 'Nenhuma das duplicatas de guias com código de barras são válidas. Verifique!' + #13 +
                                        RetornaTextoDoErrosNaExportacao;

              FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

              Raise Exception.Create(LRegistroAPI.TextoErro);
            End;

            FreeAndNil(LJsonObject);

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            Break;
          End;
        Except
          On E: Exception Do
          Begin
            fRollBack;

            FErroExportacao := True;

            LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
            LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
            LRegistroAPI.TextoErro := E.Message;

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            if Copy(E.Message, 1, 6) = 'TOKEN-' then
            begin
              fMensagem('ATENÇÃO!', 'Não foi possível realizar a autenticação. ' + #10#13 +
                        'Verifique sua conexão com a internet, confirme suas credenciais e tente novamente mais tarde.', ['&OK']);
              pGravarErro(True,E.Message);
            end
            else
              pMensagensErro(E.Message, 'TPagForBancoDoBrasilAPI.TransfereLoteGuiaComCodigoDeBarras');

            Break;
          End;
        End;
      End;

      ExibeMensagensDeErrosNaExportacao('guias com código de barras');
    Until(ADatasetRemessa.Eof);
  Finally
    FreeAndNil(LListaDuplicatas);
    FreeAndNil(FListaDuplicatasAtualizar);
  End;
end;

function TPagForBancoDoBrasilAPI.TransfereLoteOutrasGuiasDARF(
  ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
  Var
    LJsonObject,
    LJsonGuia: TJsonObject;

    LJsonArray: TJsonArray;

    LSequenciaRemessa,
    LContadorRegistros,
    LCodigoRetorno: Integer;

    LParametros,
    LListaDuplicatas: TStringList;

    LRetorno,
    LLiberacao,
    LRetornoLiberacao: String;

    LDuplicataAtualizar: TDuplicataAtualizar;

    LRegistroAPI: TRequisicaoRegistroAPI;
begin
  Result := True;

  ADatasetRemessa.Filter   := ' PGI_CODBAR IS NULL AND (CODIGO_GUIA = "2" OR CODIGO_GUIA = "3") ';
  ADatasetRemessa.Filtered := True;

  pStepStatusGravacao(LProgress, 'Aguarde... Exportando DARF.');

  If ADatasetRemessa.IsEmpty Then
    Exit;

  ADatasetRemessa.First;

  LSequenciaRemessa := StrToInt(FDadosCarteira.SequencialRemessa);

  LListaDuplicatas := TStringList.Create;

  FErrosGeradosExportacao.Clear;

  FListaDuplicatasAtualizar := TList<TDuplicataAtualizar>.Create;

  LRegistroAPI := TRequisicaoRegistroAPI.Create;  //Remover hint

  Try
    Repeat
      LJsonObject := TJsonObject.Create;
      LJsonObject.AddPair('id', LSequenciaRemessa.ToString);
      LJsonObject.AddPair('codigoContrato', FDadosCarteira.Contrato);
      LJsonObject.AddPair('numeroAgenciaDebito', FDadosCarteira.CodigoAgencia);
      LJsonObject.AddPair('numeroContaCorrenteDebito', FDadosCarteira.ContaCorrente);
      LJsonObject.AddPair('digitoVerificadorContaCorrenteDebito', FDadosCarteira.DigitoContaCorrente);

      LJsonArray := TJsonArray.Create;

      Inc(LSequenciaRemessa);
      fGetBancoConfig(1, FDadosCarteira.ConfiguracaoSemEmpresa, 'PROXNUM', LSequenciaRemessa.ToString);
      FDadosCarteira.SequencialRemessa := LSequenciaRemessa.ToString;

      LContadorRegistros := 0;

      LListaDuplicatas.Clear;

      While Not ADatasetRemessa.Eof Do
      Begin
        LJsonGuia := TJsonObject.Create;
        LJsonGuia.AddPair('dataPagamento', RetornaDataIntegerComoString(ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime));
        LJsonGuia.AddPair('valorPagamento', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALPAG').AsFloat +
                                                                   ADatasetRemessa.FieldByName('PGI_OUTENT').AsFloat));

        LJsonGuia.AddPair('codigoSeuDocumento', ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);
        LJsonGuia.AddPair('textoDescricaoPagamento', ADatasetRemessa.FieldByName('PGI_NUMDUP').AsString +
                                                     ADatasetRemessa.FieldByName('PGI_PARCEL').AsString +
                                                     ADatasetRemessa.FieldByName('PGI_CODEMP').AsString +
                                                     fPadR(ADatasetRemessa.FieldByName('PGI_SERIE_').AsString, 3, '_'));
        LJsonGuia.AddPair('codigoIdentificadorTributo', IIF(ADatasetRemessa.FieldByName('CODIGO_GUIA').AsString.Equals('2'), '16', '18'));
        LJsonGuia.AddPair('codigoReceitaTributo', ADatasetRemessa.FieldByName('PGI_CODREC').AsString);
        LJsonGuia.AddPair('codigoTipoContribuinte', '1');
        LJsonGuia.AddPair('numeroIdentificacaoContribuinte', fCampoTabela('EMP_C_G_C_',
                                                                          'CADEMP',
                                                                          ['EMP_CODEMP'],
                                                                          [ADatasetRemessa.FieldByName('PGI_CODEMP').AsString],
                                                                          False));

        LJsonGuia.AddPair('dataApuracao', fRetSomenteNumeros(DateToStr(EndOfTheMonth(StrToDate('01/' + ADatasetRemessa.FieldByName('PGI_COMPET').AsString)))));

        LJsonGuia.AddPair('numeroReferencia', '1');
        LJsonGuia.AddPair('valorPrincipal', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALDUP').AsFloat));
        LJsonGuia.AddPair('valorMulta', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALJUR').AsFloat));
        LJsonGuia.AddPair('dataVencimento', RetornaDataIntegerComoString(ADatasetRemessa.FieldByName('PGI_DTAVEN').AsDateTime));

        LJsonArray.AddElement(LJsonGuia);

        LListaDuplicatas.Add(ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LDuplicataAtualizar := TDuplicataAtualizar.Create;
        LDuplicataAtualizar.AutoIncremCadPag := ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString;
        LDuplicataAtualizar.NumeroLote := LJsonObject.GetValue<String>('id');
        LDuplicataAtualizar.DataPagamento := ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime;
        FListaDuplicatasAtualizar.Add(LDuplicataAtualizar);

        pStepStatusGravacao(LProgress);

        ADatasetRemessa.Next;

        Try
          LContadorRegistros := LContadorRegistros + 1;
          If DeveRealizaroEnvio(ADatasetRemessa.Eof, LContadorRegistros) Then
          Begin
            FEnviouAlgumRegistro := True;

            LJsonObject.AddPair('lancamentos', LJsonArray);

            LRegistroAPI := RetornaRegistroAPIInicial(RetornaLinkDoAmbiente('lotes-darf-normal-preto'),
                                                      LJsonObject,
                                                      'REGISTRO - GUIAS-DARF');

            LParametros := TStringList.Create;
            LParametros.Add('Authorization: ' + RetornaToken);
            LParametros.Add('Accept: application/json');

            LCodigoRetorno := FRestSynalist.ExecuteRestSynalist('POST',
                                                                RetornaLinkDoAmbiente('lotes-darf-normal-preto'),
                                                                LParametros,
                                                                LRetorno,
                                                                LJsonObject.ToJson,
                                                                'application/json');

            Result := MatchStr(LCodigoRetorno.ToString, ['200', '201']);

            If Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);

              VerificaStatusLancamentosExportados(LListaDuplicatas, LRetorno);

              Result := LListaDuplicatas.Count > 0;

              If Result Then
              Begin
                AtualizarDadosDoLoteDuplicata(LListaDuplicatas,
                                              'GUIAS-DARF');

                if FDadosCarteira.LiberarPagamento.Equals('S') then
                begin
                  LLiberacao := '{' +
                                '  "numeroRequisicao": ' + LJsonObject.GetValue<String>('id') + ', ' +
                                '  "indicadorFloat": "N" ' +
                                '}';

                  Result := MatchStr(FRestSynalist.ExecuteRestSynalist('POST',
                                                                       RetornaLinkDoAmbiente('liberar-pagamentos'),
                                                                       LParametros,
                                                                       LRetornoLiberacao,
                                                                       LLiberacao,
                                                                       'application/json').ToString, ['200', '201']);
                end;

                FPagFor.GravaLogCtpDuplicatas(LListaDuplicatas,
                                              'ENVIO DE REMESSA PAGFOR API - CTP - 001',
                                              'untTPagForBancoDoBrasilAPI');
              End;
            End;

            If Not Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
              LRegistroAPI.TextoErro := 'Nenhuma das duplicatas de DARF são válidas. Verifique!' + #13 +
                                        RetornaTextoDoErrosNaExportacao;

              FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

              Raise Exception.Create(LRegistroAPI.TextoErro);
            End;

            FreeAndNil(LJsonObject);

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            Break;
          End;
        Except
          On E: Exception Do
          Begin
            fRollBack;

            FErroExportacao := True;

            LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
            LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
            LRegistroAPI.TextoErro := E.Message;

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            if Copy(E.Message, 1, 6) = 'TOKEN-' then
            begin
              fMensagem('ATENÇÃO!', 'Não foi possível realizar a autenticação. ' + #10#13 +
                        'Verifique sua conexão com a internet, confirme suas credenciais e tente novamente mais tarde.', ['&OK']);
              pGravarErro(True,E.Message);
            end
            else
              pMensagensErro(E.Message, 'TPagForBancoDoBrasilAPI.TransfereLoteOutrasGuiasDARF');

            Break;
          End;
        End;
      End;

      ExibeMensagensDeErrosNaExportacao('guias darf');
    Until(ADatasetRemessa.Eof);
  Finally
    FreeAndNil(LListaDuplicatas);
    FreeAndNil(FListaDuplicatasAtualizar);
  End;
end;

function TPagForBancoDoBrasilAPI.TransfereLoteOutrasGuiasGPS(
  ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
  Var
    LJsonObject,
    LJsonGuia: TJsonObject;

    LJsonArray: TJsonArray;

    LSequenciaRemessa,
    LContadorRegistros,
    LCodigoRetorno: Integer;

    LParametros,
    LListaDuplicatas: TStringList;

    LRetorno,
    LLiberacao,
    LRetornoLiberacao: String;

    LDuplicataAtualizar: TDuplicataAtualizar;

    LRegistroAPI: TRequisicaoRegistroAPI;
begin
  Result := True;

  ADatasetRemessa.Filter   := ' CODIGO_GUIA = ''1'' ';
  ADatasetRemessa.Filtered := True;

  pStepStatusGravacao(LProgress, 'Aguarde... Exportando GPS.');

  If ADatasetRemessa.IsEmpty Then
    Exit;

  ADatasetRemessa.First;

  LSequenciaRemessa := StrToInt(FDadosCarteira.SequencialRemessa);

  LListaDuplicatas := TStringList.Create;

  FErrosGeradosExportacao.Clear;

  FListaDuplicatasAtualizar := TList<TDuplicataAtualizar>.Create;

  LRegistroAPI := TRequisicaoRegistroAPI.Create;  //Remover hint

  Try
    Repeat
      LJsonObject := TJsonObject.Create;
      LJsonObject.AddPair('numeroRequisicao', LSequenciaRemessa.ToString);
      LJsonObject.AddPair('codigoContrato', FDadosCarteira.Contrato);
      LJsonObject.AddPair('numeroAgenciaDebito', FDadosCarteira.CodigoAgencia);
      LJsonObject.AddPair('numeroContaCorrenteDebito', FDadosCarteira.ContaCorrente);
      LJsonObject.AddPair('digitoVerificadorContaCorrenteDebito', FDadosCarteira.DigitoContaCorrente);

      LJsonArray := TJsonArray.Create;

      Inc(LSequenciaRemessa);
      fGetBancoConfig(1, FDadosCarteira.ConfiguracaoSemEmpresa, 'PROXNUM', LSequenciaRemessa.ToString);
      FDadosCarteira.SequencialRemessa := LSequenciaRemessa.ToString;

      LContadorRegistros := 0;

      LListaDuplicatas.Clear;

      While Not ADatasetRemessa.Eof Do
      Begin
        LJsonGuia := TJsonObject.Create;
        LJsonGuia.AddPair('dataPagamento', RetornaDataIntegerComoString(ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime));
        LJsonGuia.AddPair('valorPagamento', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALPAG').AsFloat +
                                                                   ADatasetRemessa.FieldByName('PGI_OUTENT').AsFloat));

        LJsonGuia.AddPair('codigoSeuDocumento', ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);
        LJsonGuia.AddPair('textoDescricaoPagamento', ADatasetRemessa.FieldByName('PGI_NUMDUP').AsString +
                                                     ADatasetRemessa.FieldByName('PGI_PARCEL').AsString +
                                                     ADatasetRemessa.FieldByName('PGI_CODEMP').AsString +
                                                     fPadR(ADatasetRemessa.FieldByName('PGI_SERIE_').AsString, 3, '_'));
        LJsonGuia.AddPair('codigoIdentificadorTributoGuiaPrevidenciaSocial', '17');
        LJsonGuia.AddPair('codigoReceitaTributoGuiaPrevidenciaSocial', ADatasetRemessa.FieldByName('PGI_CODREC').AsString);
        LJsonGuia.AddPair('codigoTipoContribuinteGuiaPrevidenciaSocial', '1');
        LJsonGuia.AddPair('numeroIdentificacaoContribuinteGuiaPrevidenciaSocial', fCampoTabela('EMP_C_G_C_',
                                                                                               'CADEMP',
                                                                                               ['EMP_CODEMP'],
                                                                                               [ADatasetRemessa.FieldByName('PGI_CODEMP').AsString],
                                                                                               False));
        LJsonGuia.AddPair('mesAnoCompetenciaGuiaPrevidenciaSocial', fRetSomenteNumeros(ADatasetRemessa.FieldByName('PGI_COMPET').AsString));

        LJsonGuia.AddPair('valorPrevistoInstNacSeguridadeSocialGuiaPrevidenciaSocial', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALPAG').AsFloat));
        LJsonGuia.AddPair('valorOutroEntradaGuiaPrevidenciaSocial', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_OUTENT').AsFloat));
        LJsonGuia.AddPair('valorAtualizacaoMonetarioGuiaPrevidenciaSocial', '0.00');

        LJsonArray.AddElement(LJsonGuia);

        LListaDuplicatas.Add(ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LDuplicataAtualizar := TDuplicataAtualizar.Create;
        LDuplicataAtualizar.AutoIncremCadPag := ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString;
        LDuplicataAtualizar.NumeroLote := LJsonObject.GetValue<String>('numeroRequisicao');
        LDuplicataAtualizar.DataPagamento := ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime;
        FListaDuplicatasAtualizar.Add(LDuplicataAtualizar);

        pStepStatusGravacao(LProgress);

        ADatasetRemessa.Next;

        Try
          LContadorRegistros := LContadorRegistros + 1;
          If DeveRealizaroEnvio(ADatasetRemessa.Eof, LContadorRegistros) Then
          Begin
            FEnviouAlgumRegistro := True;

            LJsonObject.AddPair('lancamentos', LJsonArray);

            LRegistroAPI := RetornaRegistroAPIInicial(RetornaLinkDoAmbiente('lotes-gps'),
                                                      LJsonObject,
                                                      'REGISTRO - GUIAS-GPS');

            LParametros := TStringList.Create;
            LParametros.Add('Authorization: ' + RetornaToken);
            LParametros.Add('Accept: application/json');

            LCodigoRetorno := FRestSynalist.ExecuteRestSynalist('POST',
                                                                RetornaLinkDoAmbiente('lotes-gps'),
                                                                LParametros,
                                                                LRetorno,
                                                                LJsonObject.ToJson,
                                                                'application/json');

            Result := MatchStr(LCodigoRetorno.ToString, ['200', '201']);

            If Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);

              VerificaStatusLancamentosExportados(LListaDuplicatas, LRetorno);

              Result := LListaDuplicatas.Count > 0;

              If Result Then
              Begin
                AtualizarDadosDoLoteDuplicata(LListaDuplicatas,
                                              'GUIAS-GPS');

                if FDadosCarteira.LiberarPagamento.Equals('S') then
                begin
                  LLiberacao := '{' +
                                '  "numeroRequisicao": ' + LJsonObject.GetValue<String>('numeroRequisicao') + ', ' +
                                '  "indicadorFloat": "N" ' +
                                '}';

                  Result := MatchStr(FRestSynalist.ExecuteRestSynalist('POST',
                                                                       RetornaLinkDoAmbiente('liberar-pagamentos'),
                                                                       LParametros,
                                                                       LRetornoLiberacao,
                                                                       LLiberacao,
                                                                       'application/json').ToString, ['200', '201']);
                end;


                FPagFor.GravaLogCtpDuplicatas(LListaDuplicatas,
                                              'ENVIO DE REMESSA PAGFOR API - CTP - 001',
                                              'untTPagForBancoDoBrasilAPI');
              End;
            End;

            If Not Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
              LRegistroAPI.TextoErro := 'Nenhuma das duplicatas de GPS são válidas. Verifique!' + #13 +
                                        RetornaTextoDoErrosNaExportacao;

              FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

              Raise Exception.Create(LRegistroAPI.TextoErro);
            End;

            FreeAndNil(LJsonObject);

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            Break;
          End;
        Except
          On E: Exception Do
          Begin
            fRollBack;

            FErroExportacao := True;

            LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
            LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
            LRegistroAPI.TextoErro := E.Message;

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            if Copy(E.Message, 1, 6) = 'TOKEN-' then
            begin
              fMensagem('ATENÇÃO!', 'Não foi possível realizar a autenticação. ' + #10#13 +
                        'Verifique sua conexão com a internet, confirme suas credenciais e tente novamente mais tarde.', ['&OK']);
              pGravarErro(True,E.Message);
            end
            else
              pMensagensErro(E.Message, 'TPagForBancoDoBrasilAPI.TransfereLoteOutrasGuiasGPS');

            Break;
          End;
        End;
      End;

      ExibeMensagensDeErrosNaExportacao('guias gps');
    Until(ADatasetRemessa.Eof);
  Finally
    FreeAndNil(LListaDuplicatas);
    FreeAndNil(FListaDuplicatasAtualizar);
  End;
end;

function TPagForBancoDoBrasilAPI.TransfereLoteOutrasGuiasGRU(
  ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
  Var
    LJsonObject,
    LJsonGuia: TJsonObject;

    LJsonArray: TJsonArray;

    LSequenciaRemessa,
    LContadorRegistros,
    LCodigoRetorno: Integer;

    LParametros,
    LListaDuplicatas: TStringList;

    LRetorno,
    LLiberacao,
    LRetornoLiberacao: String;

    LDuplicataAtualizar: TDuplicataAtualizar;

    LRegistroAPI: TRequisicaoRegistroAPI;
begin
  Result := True;

  ADatasetRemessa.Filter   := ' CODIGO_GUIA = ''11'' ';
  ADatasetRemessa.Filtered := True;

  pStepStatusGravacao(LProgress, 'Aguarde... Exportando GRU.');

  If ADatasetRemessa.IsEmpty Then
    Exit;

  ADatasetRemessa.First;

  LSequenciaRemessa := StrToInt(FDadosCarteira.SequencialRemessa);

  LListaDuplicatas := TStringList.Create;

  FErrosGeradosExportacao.Clear;

  FListaDuplicatasAtualizar := TList<TDuplicataAtualizar>.Create;

  LRegistroAPI := TRequisicaoRegistroAPI.Create;  //Remover hint

  Try
    Repeat
      LJsonObject := TJsonObject.Create;
      LJsonObject.AddPair('numeroRequisicao', LSequenciaRemessa.ToString);
      LJsonObject.AddPair('codigoContrato', FDadosCarteira.Contrato);
      LJsonObject.AddPair('agencia', FDadosCarteira.CodigoAgencia);
      LJsonObject.AddPair('conta', FDadosCarteira.ContaCorrente);
      LJsonObject.AddPair('digitoConta', FDadosCarteira.DigitoContaCorrente);

      LJsonArray := TJsonArray.Create;

      Inc(LSequenciaRemessa);
      fGetBancoConfig(1, FDadosCarteira.ConfiguracaoSemEmpresa, 'PROXNUM', LSequenciaRemessa.ToString);
      FDadosCarteira.SequencialRemessa := LSequenciaRemessa.ToString;

      LContadorRegistros := 0;

      LListaDuplicatas.Clear;

      While Not ADatasetRemessa.Eof Do
      Begin
        LJsonGuia := TJsonObject.Create;
        LJsonGuia.AddPair('codigoBarras', ADatasetRemessa.FieldByName('PGI_CODBAR').AsString);
        LJsonGuia.AddPair('dataVencimento', RetornaDataIntegerComoString(ADatasetRemessa.FieldByName('PGI_DTAVEN').AsDateTime));
        LJsonGuia.AddPair('dataPagamento', RetornaDataIntegerComoString(ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime));
        LJsonGuia.AddPair('valorPagamento', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALPAG').AsFloat +
                                                                   ADatasetRemessa.FieldByName('PGI_OUTENT').AsFloat));

        LJsonGuia.AddPair('textoPagamento', ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);
        LJsonGuia.AddPair('mesAnoCompetencia', StrToInt(fRetSomenteNumeros(ADatasetRemessa.FieldByName('PGI_COMPET').AsString)).ToString);
        LJsonGuia.AddPair('idContribuinte', fCampoTabela('EMP_C_G_C_',
                                                         'CADEMP',
                                                         ['EMP_CODEMP'],
                                                         [ADatasetRemessa.FieldByName('PGI_CODEMP').AsString],
                                                         False));
        LJsonGuia.AddPair('valorPrincipal', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALPAG').AsFloat));

        LJsonArray.AddElement(LJsonGuia);

        LListaDuplicatas.Add(ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LDuplicataAtualizar := TDuplicataAtualizar.Create;
        LDuplicataAtualizar.AutoIncremCadPag := ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString;
        LDuplicataAtualizar.NumeroLote := LJsonObject.GetValue<String>('numeroRequisicao');
        LDuplicataAtualizar.DataPagamento := ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime;
        FListaDuplicatasAtualizar.Add(LDuplicataAtualizar);

        pStepStatusGravacao(LProgress);

        ADatasetRemessa.Next;

        Try
          LContadorRegistros := LContadorRegistros + 1;
          If DeveRealizaroEnvio(ADatasetRemessa.Eof, LContadorRegistros) Then
          Begin
            FEnviouAlgumRegistro := True;

            LJsonObject.AddPair('listaRequisicao', LJsonArray);

            LRegistroAPI := RetornaRegistroAPIInicial(RetornaLinkDoAmbiente('pagamentos-gru'),
                                                      LJsonObject,
                                                      'REGISTRO - GUIAS-GRU');

            LParametros := TStringList.Create;
            LParametros.Add('Authorization: ' + RetornaToken);
            LParametros.Add('Accept: application/json');

            LCodigoRetorno := FRestSynalist.ExecuteRestSynalist('POST',
                                                                RetornaLinkDoAmbiente('pagamentos-gru'),
                                                                LParametros,
                                                                LRetorno,
                                                                LJsonObject.ToJson,
                                                                'application/json');

            Result := MatchStr(LCodigoRetorno.ToString, ['200', '201']);

            If Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);

              VerificaStatusLancamentosExportados(LListaDuplicatas, LRetorno);

              Result := LListaDuplicatas.Count > 0;

              If Result Then
              Begin
                AtualizarDadosDoLoteDuplicata(LListaDuplicatas,
                                              'GUIAS-GRU');

                if FDadosCarteira.LiberarPagamento.Equals('S') then
                begin
                  LLiberacao := '{' +
                                '  "numeroRequisicao": ' + LJsonObject.GetValue<String>('numeroRequisicao') + ', ' +
                                '  "indicadorFloat": "N" ' +
                                '}';

                  Result := MatchStr(FRestSynalist.ExecuteRestSynalist('POST',
                                                                       RetornaLinkDoAmbiente('liberar-pagamentos'),
                                                                       LParametros,
                                                                       LRetornoLiberacao,
                                                                       LLiberacao,
                                                                       'application/json').ToString, ['200', '201']);
                end;

                FPagFor.GravaLogCtpDuplicatas(LListaDuplicatas,
                                              'ENVIO DE REMESSA PAGFOR API - CTP - 001',
                                              'untTPagForBancoDoBrasilAPI');
              End;
            End;

            If Not Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
              LRegistroAPI.TextoErro := 'Nenhuma das duplicatas de GRU são válidas. Verifique!' + #13 +
                                        RetornaTextoDoErrosNaExportacao;

              FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

              Raise Exception.Create(LRegistroAPI.TextoErro);
            End;

            FreeAndNil(LJsonObject);

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            Break;
          End;
        Except
          On E: Exception Do
          Begin
            fRollBack;

            FErroExportacao := True;

            LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
            LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
            LRegistroAPI.TextoErro := E.Message;

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            if Copy(E.Message, 1, 6) = 'TOKEN-' then
            begin
              fMensagem('ATENÇÃO!', 'Não foi possível realizar a autenticação. ' + #10#13 +
                        'Verifique sua conexão com a internet, confirme suas credenciais e tente novamente mais tarde.', ['&OK']);
              pGravarErro(True,E.Message);
            end
            else
              pMensagensErro(E.Message, 'TPagForBancoDoBrasilAPI.TransfereLoteOutrasGuiasGRU');

            Break;
          End;
        End;
      End;

      ExibeMensagensDeErrosNaExportacao('guias gru');
    Until(ADatasetRemessa.Eof);
  Finally
    FreeAndNil(LListaDuplicatas);
    FreeAndNil(FListaDuplicatasAtualizar);
  End;
end;

function TPagForBancoDoBrasilAPI.TransfereLoteTransferencias(
  ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
  Var
    LJsonObject,
    LJsonTransferencia: TJsonObject;

    LJsonArray: TJsonArray;

    LSequenciaRemessa,
    LContadorRegistros,
    LCodigoRetorno: Integer;

    LParametros,
    LListaDuplicatas: TStringList;

    LRetorno,
    LLiberacao,
    LRetornoLiberacao: String;

    LDuplicataAtualizar: TDuplicataAtualizar;

    LRegistroAPI: TRequisicaoRegistroAPI;
begin
  Result := True;

  ADatasetRemessa.Filter := 'FORMAPAGTO = "DEP" ' +
                            ' AND CODIGO_GUIA IN ("", "-1") ' +
                            ' AND CODFUN = "" AND AUTOINCREM_FORPIX IS NULL ';
  ADatasetRemessa.Filtered := True;

  pStepStatusGravacao(LProgress, 'Aguarde... Exportando Transferências.');

  If ADatasetRemessa.IsEmpty Then
    Exit;

  ADatasetRemessa.First;

  LSequenciaRemessa := StrToInt(FDadosCarteira.SequencialRemessa);

  LListaDuplicatas := TStringList.Create;

  FErrosGeradosExportacao.Clear;

  FListaDuplicatasAtualizar := TList<TDuplicataAtualizar>.Create;

  LRegistroAPI := TRequisicaoRegistroAPI.Create;  //Remover hint

  Try
    Repeat
      LJsonObject := TJsonObject.Create;
      LJsonObject.AddPair('numeroRequisicao', LSequenciaRemessa.ToString);
      LJsonObject.AddPair('codigoContrato', FDadosCarteira.Contrato);
      LJsonObject.AddPair('agenciaDebito', FDadosCarteira.CodigoAgencia);
      LJsonObject.AddPair('contaCorrenteDebito', FDadosCarteira.ContaCorrente);
      LJsonObject.AddPair('digitoVerificadorContaCorrente', FDadosCarteira.DigitoContaCorrente);
      LJsonObject.AddPair('tipoPagamento', '128');

      LJsonArray := TJsonArray.Create;

      Inc(LSequenciaRemessa);
      fGetBancoConfig(1, FDadosCarteira.ConfiguracaoSemEmpresa, 'PROXNUM', LSequenciaRemessa.ToString);
      FDadosCarteira.SequencialRemessa := LSequenciaRemessa.ToString;

      LContadorRegistros := 0;

      LListaDuplicatas.Clear;

      While Not ADatasetRemessa.Eof Do
      Begin
        LJsonTransferencia := TJsonObject.Create;
        LJsonTransferencia.AddPair('numeroCOMPE', ADatasetRemessa.FieldByName('CODBCO').AsString);
        LJsonTransferencia.AddPair('numeroISPB', '0');
        LJsonTransferencia.AddPair('agenciaCredito', ADatasetRemessa.FieldByName('CODAGE').AsString);
        LJsonTransferencia.AddPair('contaCorrenteCredito', ADatasetRemessa.FieldByName('NUMCTA').AsString);
        LJsonTransferencia.AddPair('digitoVerificadorContaCorrente', ADatasetRemessa.FieldByName('DIGCTA').AsString);

        If ADatasetRemessa.FieldByName('NUMINS').AsString.Length > 11 Then
        Begin
          LJsonTransferencia.AddPair('cpfBeneficiario', EmptyStr);
          LJsonTransferencia.AddPair('cnpjBeneficiario', ADatasetRemessa.FieldByName('NUMINS').AsString);
        End
        Else
        Begin
          LJsonTransferencia.AddPair('cpfBeneficiario', ADatasetRemessa.FieldByName('NUMINS').AsString);
          LJsonTransferencia.AddPair('cnpjBeneficiario', EmptyStr);
        End;

        LJsonTransferencia.AddPair('dataTransferencia', RetornaDataIntegerComoString(ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime));
        LJsonTransferencia.AddPair('valorTransferencia', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALPAG').AsFloat));
        LJsonTransferencia.AddPair('descricaoTransferencia',  ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LJsonArray.AddElement(LJsonTransferencia);

        LListaDuplicatas.Add(ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LDuplicataAtualizar := TDuplicataAtualizar.Create;
        LDuplicataAtualizar.AutoIncremCadPag := ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString;
        LDuplicataAtualizar.NumeroLote := LJsonObject.GetValue<String>('numeroRequisicao');
        LDuplicataAtualizar.DataPagamento := ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime;
        FListaDuplicatasAtualizar.Add(LDuplicataAtualizar);

        pStepStatusGravacao(LProgress);

        ADatasetRemessa.Next;

        Try
          LContadorRegistros := LContadorRegistros + 1;
          If DeveRealizaroEnvio(ADatasetRemessa.Eof, LContadorRegistros) Then
          Begin
            FEnviouAlgumRegistro := True;

            LJsonObject.AddPair('listaTransferencias', LJsonArray);

            LRegistroAPI := RetornaRegistroAPIInicial(RetornaLinkDoAmbiente('lotes-transferencias'),
                                                      LJsonObject,
                                                      'REGISTRO - TRANSFERENCIAS');

            LParametros := TStringList.Create;
            LParametros.Add('Authorization: ' + RetornaToken);
            LParametros.Add('Accept: application/json');

            LCodigoRetorno := FRestSynalist.ExecuteRestSynalist('POST',
                                                                RetornaLinkDoAmbiente('lotes-transferencias'),
                                                                LParametros,
                                                                LRetorno,
                                                                LJsonObject.ToJson,
                                                                'application/json');

            Result := MatchStr(LCodigoRetorno.ToString, ['200', '201']);

            If Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);

              VerificaStatusTransferenciasExportadas(LListaDuplicatas, LRetorno);

              Result := LListaDuplicatas.Count > 0;

              If Result Then
              Begin
                AtualizarDadosDoLoteDuplicata(LListaDuplicatas,
                                              'TRANSFERENCIAS');

                if FDadosCarteira.LiberarPagamento.Equals('S') then
                begin
                  LLiberacao := '{' +
                                '  "numeroRequisicao": ' + LJsonObject.GetValue<String>('numeroRequisicao') + ', ' +
                                '  "indicadorFloat": "N" ' +
                                '}';

                  Result := MatchStr(FRestSynalist.ExecuteRestSynalist('POST',
                                                                       RetornaLinkDoAmbiente('liberar-pagamentos'),
                                                                       LParametros,
                                                                       LRetornoLiberacao,
                                                                       LLiberacao,
                                                                       'application/json').ToString, ['200', '201']);
                end;

                FPagFor.GravaLogCtpDuplicatas(LListaDuplicatas,
                                              'ENVIO DE REMESSA PAGFOR API - CTP - 001',
                                              'untTPagForBancoDoBrasilAPI');
              End;
            End;

            If Not Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
              LRegistroAPI.TextoErro := 'Nenhuma das duplicatas de transferências são válidas. Verifique!' + #13 +
                                        RetornaTextoDoErrosNaExportacao;

              FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

              Raise Exception.Create(LRegistroAPI.TextoErro);
            End;
            
            FreeAndNil(LJsonObject);

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            Break;
          End;
        Except
          On E: Exception Do
          Begin
            fRollBack;

            FErroExportacao := True;

            LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
            LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
            LRegistroAPI.TextoErro := E.Message;

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            if Copy(E.Message, 1, 6) = 'TOKEN-' then
            begin
              fMensagem('ATENÇÃO!', 'Não foi possível realizar a autenticação. ' + #10#13 +
                        'Verifique sua conexão com a internet, confirme suas credenciais e tente novamente mais tarde.', ['&OK']);
              pGravarErro(True,E.Message);
            end
            else
              pMensagensErro(E.Message, 'TPagForBancoDoBrasilAPI.TransfereLoteTransferencias');

            Break;
          End;
        End;
      End;

      ExibeMensagensDeErrosNaExportacao('transferências');
    Until(ADatasetRemessa.Eof);
  Finally
    FreeAndNil(LListaDuplicatas);
    FreeAndNil(FListaDuplicatasAtualizar);
  End;
end;

function TPagForBancoDoBrasilAPI.TransfereLoteTransferenciasPix(
  ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
  Var
    LJsonObject,
    LJsonTransferencia: TJsonObject;

    LJsonArray: TJsonArray;

    LSequenciaRemessa,
    LContadorRegistros,
    LCodigoRetorno: Integer;

    LParametros,
    LListaDuplicatas: TStringList;

    LRetorno,
    LLiberacao,
    LRetornoLiberacao: String;

    LDuplicataAtualizar: TDuplicataAtualizar;

    LRegistroAPI: TRequisicaoRegistroAPI;
begin
  Result := True;

  ADatasetRemessa.Filter := 'FORMAPAGTO = "DEP" ' +
                            ' AND CODIGO_GUIA IN ("", "-1") ' +
                            ' AND CODFUN = "" AND AUTOINCREM_FORPIX IS NOT NULL ';
  ADatasetRemessa.Filtered := True;

  pStepStatusGravacao(LProgress, 'Aguarde... Exportando Transferências Pix.');

  If ADatasetRemessa.IsEmpty Then
    Exit;

  ADatasetRemessa.First;

  LSequenciaRemessa := StrToInt(FDadosCarteira.SequencialRemessa);

  LListaDuplicatas := TStringList.Create;

  FErrosGeradosExportacao.Clear;

  FListaDuplicatasAtualizar := TList<TDuplicataAtualizar>.Create;

  LRegistroAPI := TRequisicaoRegistroAPI.Create;  //Remover hint

  Try
    Repeat
      LJsonObject := TJsonObject.Create;
      LJsonObject.AddPair('numeroRequisicao', LSequenciaRemessa.ToString);
      LJsonObject.AddPair('codigoContrato', FDadosCarteira.Contrato);
      LJsonObject.AddPair('agenciaDebito', FDadosCarteira.CodigoAgencia);
      LJsonObject.AddPair('contaCorrenteDebito', FDadosCarteira.ContaCorrente);
      LJsonObject.AddPair('digitoVerificadorContaCorrente', FDadosCarteira.DigitoContaCorrente);
      LJsonObject.AddPair('tipoPagamento', '128');

      LJsonArray := TJsonArray.Create;

      Inc(LSequenciaRemessa);
      fGetBancoConfig(1, FDadosCarteira.ConfiguracaoSemEmpresa, 'PROXNUM', LSequenciaRemessa.ToString);
      FDadosCarteira.SequencialRemessa := LSequenciaRemessa.ToString;

      LContadorRegistros := 0;

      LListaDuplicatas.Clear;

      While Not ADatasetRemessa.Eof Do
      Begin
        LJsonTransferencia := TJsonObject.Create;

        LJsonTransferencia.AddPair('data', RetornaDataIntegerComoString(ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime));
        LJsonTransferencia.AddPair('valor', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALPAG').AsFloat));
        LJsonTransferencia.AddPair('descricaoPagamento', ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        AtribuiDadosPixFornecedor(LJsonTransferencia, ADatasetRemessa);


        LJsonArray.AddElement(LJsonTransferencia);

        LListaDuplicatas.Add(ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LDuplicataAtualizar := TDuplicataAtualizar.Create;
        LDuplicataAtualizar.AutoIncremCadPag := ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString;
        LDuplicataAtualizar.NumeroLote := LJsonObject.GetValue<String>('numeroRequisicao');
        LDuplicataAtualizar.DataPagamento := ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime;
        FListaDuplicatasAtualizar.Add(LDuplicataAtualizar);

        pStepStatusGravacao(LProgress);

        ADatasetRemessa.Next;

        Try
          LContadorRegistros := LContadorRegistros + 1;
          If DeveRealizaroEnvio(ADatasetRemessa.Eof, LContadorRegistros) Then
          Begin
            FEnviouAlgumRegistro := True;

            LJsonObject.AddPair('listaTransferencias', LJsonArray);

            LRegistroAPI := RetornaRegistroAPIInicial(RetornaLinkDoAmbiente('lotes-transferencias-pix'),
                                                      LJsonObject,
                                                      'REGISTRO - TRANSFERENCIAS-PIX');

            LParametros := TStringList.Create;
            LParametros.Add('Authorization: ' + RetornaToken);
            LParametros.Add('Accept: application/json');

            LCodigoRetorno := FRestSynalist.ExecuteRestSynalist('POST',
                                                                RetornaLinkDoAmbiente('lotes-transferencias-pix'),
                                                                LParametros,
                                                                LRetorno,
                                                                LJsonObject.ToJson,
                                                                'application/json');

            Result := MatchStr(LCodigoRetorno.ToString, ['200', '201']);

            If Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);

              VerificaStatusTransferenciasExportadas(LListaDuplicatas, LRetorno);

              Result := LListaDuplicatas.Count > 0;

              If Result Then
              Begin
                AtualizarDadosDoLoteDuplicata(LListaDuplicatas,
                                              'TRANSFERENCIAS-PIX');

                if FDadosCarteira.LiberarPagamento.Equals('S') then
                begin
                  LLiberacao := '{' +
                                '  "numeroRequisicao": ' + LJsonObject.GetValue<String>('numeroRequisicao') + ', ' +
                                '  "indicadorFloat": "N" ' +
                                '}';

                  Result := MatchStr(FRestSynalist.ExecuteRestSynalist('POST',
                                                                       RetornaLinkDoAmbiente('liberar-pagamentos'),
                                                                       LParametros,
                                                                       LRetornoLiberacao,
                                                                       LLiberacao,
                                                                       'application/json').ToString, ['200', '201']);
                end;

                FPagFor.GravaLogCtpDuplicatas(LListaDuplicatas,
                                              'ENVIO DE REMESSA PAGFOR API - CTP - 001',
                                              'untTPagForBancoDoBrasilAPI');
              End;
            End;

            If Not Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
              LRegistroAPI.TextoErro := 'Nenhuma das duplicatas de transferências Pix são válidas. Verifique!' + #13 +
                                        RetornaTextoDoErrosNaExportacao;

              FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

              Raise Exception.Create(LRegistroAPI.TextoErro);
            End;

            FreeAndNil(LJsonObject);

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            Break;
          End;
        Except
          On E: Exception Do
          Begin
            fRollBack;

            FErroExportacao := True;

            LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
            LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
            LRegistroAPI.TextoErro := E.Message;

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            if Copy(E.Message, 1, 6) = 'TOKEN-' then
            begin
              fMensagem('ATENÇÃO!', 'Não foi possível realizar a autenticação. ' + #10#13 +
                        'Verifique sua conexão com a internet, confirme suas credenciais e tente novamente mais tarde.', ['&OK']);
              pGravarErro(True,E.Message);
            end
            else
              pMensagensErro(E.Message, 'TPagForBancoDoBrasilAPI.TransfereLoteTransferenciasPix');

            Break;
          End;
        End;
      End;

      ExibeMensagensDeErrosNaExportacao('transferências pix');
    Until(ADatasetRemessa.Eof);
  Finally
    FreeAndNil(LListaDuplicatas);
    FreeAndNil(FListaDuplicatasAtualizar);
  End;
end;

function TPagForBancoDoBrasilAPI.TransfereLoteTransferenciasSalarios(
  ADatasetRemessa: TDataset; var LProgress: TcxProgressBar): Boolean;
  Var                                                     LJsonObject,
    LJsonTransferencia: TJsonObject;

    LJsonArray: TJsonArray;

    LSequenciaRemessa,
    LContadorRegistros,
    LCodigoRetorno: Integer;

    LParametros,
    LListaDuplicatas: TStringList;

    LRetorno,
    LLiberacao,
    LRetornoLiberacao: String;

    LDuplicataAtualizar: TDuplicataAtualizar;

    LRegistroAPI: TRequisicaoRegistroAPI;
begin
  Result := True;

  ADatasetRemessa.Filter := 'FORMAPAGTO = "DEP" ' +
                            ' AND CODIGO_GUIA IN ("", "-1") ' +
                            ' AND CODFUN <> "" ';
  ADatasetRemessa.Filtered := True;

  pStepStatusGravacao(LProgress, 'Aguarde... Exportando Transferências.');

  If ADatasetRemessa.IsEmpty Then
    Exit;

  ADatasetRemessa.First;

  LSequenciaRemessa := StrToInt(FDadosCarteira.SequencialRemessa);

  LListaDuplicatas := TStringList.Create;

  FErrosGeradosExportacao.Clear;

  FListaDuplicatasAtualizar := TList<TDuplicataAtualizar>.Create;

  LRegistroAPI := TRequisicaoRegistroAPI.Create;  //Remover hint

  Try
    Repeat
      LJsonObject := TJsonObject.Create;
      LJsonObject.AddPair('numeroRequisicao', LSequenciaRemessa.ToString);
      LJsonObject.AddPair('codigoContrato', FDadosCarteira.Contrato);
      LJsonObject.AddPair('agenciaDebito', FDadosCarteira.CodigoAgencia);
      LJsonObject.AddPair('contaCorrenteDebito', FDadosCarteira.ContaCorrente);
      LJsonObject.AddPair('digitoVerificadorContaCorrente', FDadosCarteira.DigitoContaCorrente);
      LJsonObject.AddPair('tipoPagamento', '127');

      LJsonArray := TJsonArray.Create;

      Inc(LSequenciaRemessa);
      fGetBancoConfig(1, FDadosCarteira.ConfiguracaoSemEmpresa, 'PROXNUM', LSequenciaRemessa.ToString);
      FDadosCarteira.SequencialRemessa := LSequenciaRemessa.ToString;

      LContadorRegistros := 0;

      LListaDuplicatas.Clear;

      While Not ADatasetRemessa.Eof Do
      Begin
        LJsonTransferencia := TJsonObject.Create;
        LJsonTransferencia.AddPair('numeroCOMPE', ADatasetRemessa.FieldByName('CODBCO').AsString);
        LJsonTransferencia.AddPair('numeroISPB', '0');
        LJsonTransferencia.AddPair('agenciaCredito', ADatasetRemessa.FieldByName('CODAGE').AsString);
        LJsonTransferencia.AddPair('contaCorrenteCredito', ADatasetRemessa.FieldByName('NUMCTA').AsString);
        LJsonTransferencia.AddPair('digitoVerificadorContaCorrente', ADatasetRemessa.FieldByName('DIGCTA').AsString);

        If ADatasetRemessa.FieldByName('NUMINS').AsString.Length > 11 Then
        Begin
          LJsonTransferencia.AddPair('cpfBeneficiario', EmptyStr);
          LJsonTransferencia.AddPair('cnpjBeneficiario', ADatasetRemessa.FieldByName('NUMINS').AsString);
        End
        Else
        Begin
          LJsonTransferencia.AddPair('cpfBeneficiario', ADatasetRemessa.FieldByName('NUMINS').AsString);
          LJsonTransferencia.AddPair('cnpjBeneficiario', EmptyStr);
        End;

        LJsonTransferencia.AddPair('dataTransferencia', RetornaDataIntegerComoString(ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime));
        LJsonTransferencia.AddPair('valorTransferencia', RetornaValorExportacao(ADatasetRemessa.FieldByName('PGI_VALPAG').AsFloat));
        LJsonTransferencia.AddPair('descricaoTransferencia',  ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LJsonArray.AddElement(LJsonTransferencia);

        LListaDuplicatas.Add(ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString);

        LDuplicataAtualizar := TDuplicataAtualizar.Create;
        LDuplicataAtualizar.AutoIncremCadPag := ADatasetRemessa.FieldByName('PGI_AUTOIN').AsString;
        LDuplicataAtualizar.NumeroLote := LJsonObject.GetValue<String>('numeroRequisicao');
        LDuplicataAtualizar.DataPagamento := ADatasetRemessa.FieldByName('PGI_DTAPAG').AsDateTime;
        FListaDuplicatasAtualizar.Add(LDuplicataAtualizar);

        pStepStatusGravacao(LProgress);

        ADatasetRemessa.Next;

        Try
          LContadorRegistros := LContadorRegistros + 1;
          If DeveRealizaroEnvio(ADatasetRemessa.Eof, LContadorRegistros) Then
          Begin
            FEnviouAlgumRegistro := True;

            LJsonObject.AddPair('listaTransferencias', LJsonArray);

            LRegistroAPI := RetornaRegistroAPIInicial(RetornaLinkDoAmbiente('lotes-transferencias'),
                                                      LJsonObject,
                                                      'REGISTRO - TRANSFERENCIAS-SALARIOS');

            LParametros := TStringList.Create;
            LParametros.Add('Authorization: ' + RetornaToken);
            LParametros.Add('Accept: application/json');

            LCodigoRetorno := FRestSynalist.ExecuteRestSynalist('POST',
                                                                RetornaLinkDoAmbiente('lotes-transferencias'),
                                                                LParametros,
                                                                LRetorno,
                                                                LJsonObject.ToJson,
                                                                'application/json');

            Result := MatchStr(LCodigoRetorno.ToString, ['200', '201']);

            If Result Then
            Begin
              VerificaStatusTransferenciasExportadas(LListaDuplicatas, LRetorno);

              Result := LListaDuplicatas.Count > 0;

              If Result Then
              Begin
                LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
                LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);

                AtualizarDadosDoLoteDuplicata(LListaDuplicatas,
                                              'TRANSFERENCIAS-SALARIOS');

                if FDadosCarteira.LiberarPagamento.Equals('S') then
                begin
                  LLiberacao := '{' +
                                '  "numeroRequisicao": ' + LJsonObject.GetValue<String>('numeroRequisicao') + ', ' +
                                '  "indicadorFloat": "N" ' +
                                '}';

                  Result := MatchStr(FRestSynalist.ExecuteRestSynalist('POST',
                                                                       RetornaLinkDoAmbiente('liberar-pagamentos'),
                                                                       LParametros,
                                                                       LRetornoLiberacao,
                                                                       LLiberacao,
                                                                       'application/json').ToString, ['200', '201']);
                end;

                FPagFor.GravaLogCtpDuplicatas(LListaDuplicatas,
                                              'ENVIO DE REMESSA PAGFOR API - CTP - 001',
                                              'untTPagForBancoDoBrasilAPI');
              End;
            End;

            If Not Result Then
            Begin
              LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
              LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
              LRegistroAPI.TextoErro := 'Nenhuma das duplicatas de transferências de salários são válidas. Verifique!' + #13 +
                                        RetornaTextoDoErrosNaExportacao;

              FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

              Raise Exception.Create(LRegistroAPI.TextoErro);
            End;

            FreeAndNil(LJsonObject);

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            Break;
          End;
        Except
          On E: Exception Do
          Begin
            fRollBack;

            FErroExportacao := True;

            LRegistroAPI.CodigoStatusRetorno := LCodigoRetorno;
            LRegistroAPI.JsonRecebido := TJsonUtils.Format(LRetorno);
            LRegistroAPI.TextoErro := E.Message;

            FPagFor.ListaRequisicoesAPI.Add(LRegistroAPI);

            if Copy(E.Message, 1, 6) = 'TOKEN-' then
            begin
              fMensagem('ATENÇÃO!', 'Não foi possível realizar a autenticação. ' + #10#13 +
                        'Verifique sua conexão com a internet, confirme suas credenciais e tente novamente mais tarde.', ['&OK']);
              pGravarErro(True,E.Message);
            end
            else
              pMensagensErro(E.Message, 'TPagForBancoDoBrasilAPI.TransfereLoteTransferenciasSalarios');

            Break;
          End;
        End;
      End;

      ExibeMensagensDeErrosNaExportacao('transferências salários');
    Until(ADatasetRemessa.Eof);
  Finally
    FreeAndNil(LListaDuplicatas);
    FreeAndNil(FListaDuplicatasAtualizar);
  End;
end;

procedure TPagForBancoDoBrasilAPI.VerificaStatusLancamentosExportados(
  var AListaDuplicatas: TStringList; ARetorno: String);
  Var
    LJsonObject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LQuantidade,
    LIndicadorAceite,
    LCodigoDocumento: String;
begin
  LJsonObject := TJsonObject.ParseJSONValue(ARetorno) As TJsonObject;

  Try
    If Not LJsonObject.TryGetValue<String>('quantidadeLancamentosValidos', LQuantidade) Then
      LJsonObject.TryGetValue<String>('quantidadeTotalValido', LQuantidade);

    If LQuantidade.Equals(AListaDuplicatas.Count.ToString) Then
      Exit;

    If LJsonObject.GetValue('lancamentos') <> Nil Then
      LJsonArray := LJsonObject.GetValue('lancamentos') As TJsonArray
    Else
      LJsonArray := LJsonObject.GetValue('pagamentos') As TJsonArray;
    For LJsonValue In LJsonArray Do
    Begin
      If Not LJsonValue.TryGetValue<String>('indicadorAceite', LIndicadorAceite) Then
        LJsonValue.TryGetValue<String>('indicadorMovimentoAceito', LIndicadorAceite);

      If LIndicadorAceite.Equals('N') Then
      Begin
        AdicionaErrosExportacao(LJsonValue);

        If Not LJsonValue.TryGetValue<String>('codigoSeuDocumento', LCodigoDocumento) Then
          LJsonValue.TryGetValue<String>('descricaoPagamento', LCodigoDocumento);

        AListaDuplicatas.Delete(AListaDuplicatas.IndexOf(LCodigoDocumento));

        LimpaDadosGeracaoDuplicata(LCodigoDocumento);
      End;
    End;
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

procedure TPagForBancoDoBrasilAPI.VerificaStatusTransferenciasExportadas(
  var AListaDuplicatas: TStringList; ARetorno: String);
  Var
    LJsonObject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LDescricaoTransferencia,
    LIndicadorAceite: String;
begin
  LJsonObject := TJsonObject.ParseJSONValue(ARetorno) As TJsonObject;

  Try
    If LJsonObject.GetValue<String>('quantidadeTransferenciasValidas').Equals(AListaDuplicatas.Count.ToString) Then
      Exit;

    If Not LJsonObject.TryGetValue('transferencias', LJsonArray) THen
      LJsonObject.TryGetValue('listaTransferencias', LJsonArray);

    For LJsonValue In LJsonArray Do
    Begin
      If Not (LJsonValue As TJsonObject).TryGetValue('indicadorAceite', LIndicadorAceite) Then
        LIndicadorAceite := LJsonValue.GetValue<String>('indicadorMovimentoAceito');

      If LIndicadorAceite.Equals('N') Then
      Begin
        AdicionaErrosExportacao(LJsonValue);

        If Not (LJsonValue As TJsonObject).TryGetValue('descricaoTransferencia', LDescricaoTransferencia) Then
          LDescricaoTransferencia := LJsonValue.GetValue<String>('descricaoPagamento');

        AListaDuplicatas.Delete(AListaDuplicatas.IndexOf(LDescricaoTransferencia));

        LimpaDadosGeracaoDuplicata(LDescricaoTransferencia);
      End;
    End;
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

class function TPagForBancoDoBrasilAPI.RetornaDescricaoDosErros(AErro: Integer): String;
begin
  Result := EmptyStr;

  Case AErro Of
    0: Result := Result + AErro.ToString + '-' + 'Pagamento efetuado.';
    1: Result := Result + AErro.ToString + '-' + 'Agência de crédito igual a zero. Informe o nº da Agência de Crédito.';
    2: Result := Result + AErro.ToString + '-' + 'Conta de crédito não é numérica. Informe apenas números.';
    3: Result := Result + AErro.ToString + '-' + 'Dígito conta de crédito igual a espaços. Informe o DV da conta de crédito.';
    4: Result := Result + AErro.ToString + '-' + 'CPF não é numérico. Informe apenas números.';
    5: Result := Result + AErro.ToString + '-' + 'CNPJ não é numérico. Informe apenas números.';
    6: Result := Result + AErro.ToString + '-' + 'Data do pagamento igual a zeros. Informe a data do pagamento.';
    7: Result := Result + AErro.ToString + '-' + 'Data do pagamento inválida. Informe uma data de pagamento válida.';
    8: Result := Result + AErro.ToString + '-' + 'Valor do pagamento não é númerico. Informe apenas números.';
    9: Result := Result + AErro.ToString + '-' + 'Valor do pagamento igual a zeros. Informe o valor do pagamento.';
    10: Result := Result + AErro.ToString + '-' + 'Ambos os campos Número Compensação e Número ISPB estão zerados. Informe um dos campos.';
    11: Result := Result + AErro.ToString + '-' + 'Ambos os campos Número Compensação e Número ISPB foram informados. Informe apenas um dos campos.';
    12: Result := Result + AErro.ToString + '-' + 'Ambos os campos Finalidade DOC e Finalidade TED estão zerados. Informe um dos campos.';
    13: Result := Result + AErro.ToString + '-' + 'Ambos os campos Finalidade DOC e Finalidade TED foram informados. Informe apenas um dos campos.';
    14: Result := Result + AErro.ToString + '-' + 'Número depósito judicial igual a espaços.';
    15: Result := Result + AErro.ToString + '-' + 'Digito da conta de crédito inválido.';
    16: Result := Result + AErro.ToString + '-' + 'Ambos os campos CPF e CNPJ foram informados. Informe apenas um dos campos.' + #13 +
        'Caso informado os 2 campos, nas consultas será exibido apenas os dados do CPF.';
    17: Result := Result + AErro.ToString + '-' + 'Ambos os campos CPF e CNPJ estão zerados. Informe um dos campos.';
    18: Result := Result + AErro.ToString + '-' + 'Digito do CPF inválido. Verifique o dado informado.';
    19: Result := Result + AErro.ToString + '-' + 'Dígito do CNPJ inválido. Verifique o dado informado.';
    20: Result := Result + AErro.ToString + '-' + 'Agência e conta de crédito estão iguais a de débito. Opção não permitida.';
    21: Result := Result + AErro.ToString + '-' + 'Número Compensação inválido. Verifique o dado informado.';
    22: Result := Result + AErro.ToString + '-' + 'Número ISPB diferente de zeros. Não informe o nº ISPB.';
    23: Result := Result + AErro.ToString + '-' + 'Conta de crédito igual a zeros. Informe o número da conta de crédito.';
    24: Result := Result + AErro.ToString + '-' + 'CPF igual a zeros. Obrigatório informar o nº do CPF.';
    25: Result := Result + AErro.ToString + '-' + 'CNPJ diferente de zeros. Não permitido informar CNPJ.';
    26: Result := Result + AErro.ToString + '-' + 'Conta de crédito diferente de zeros. Não permitido informar Conta de crédito.';
    27: Result := Result + AErro.ToString + '-' + 'Dígito conta de crédito diferente de espaços. Não informar dígito da conta de crédito.';
    28: Result := Result + AErro.ToString + '-' + 'Finalidade DOC diferente de zeros. Não informar finalidade DOC.';
    29: Result := Result + AErro.ToString + '-' + 'Finalidade TED diferente de zeros. Não informar finalidade TED.';
    30: Result := Result + AErro.ToString + '-' + 'Número Depósito Judicial diferente de espaços. Não informar finalidade Depósito Judicial.';
    31: Result := Result + AErro.ToString + '-' + 'Número do documento de crédito não é numérico. Informar números.';
    32: Result := Result + AErro.ToString + '-' + 'Número do documento de débito não é numérico. Informar números.';
    33: Result := Result + AErro.ToString + '-' + 'CPF não encontrado na base da receita federal';
    34: Result := Result + AErro.ToString + '-' + 'CNPJ não encontrado na base da receita federal';
    35: Result := Result + AErro.ToString + '-' + 'Conta de poupança não permitido. Para creditar poupança utilize Código Produto igual a 128 - Pagamentos Diversos.';
    36: Result := Result + AErro.ToString + '-' + 'Código COMPE deve ser igual a 1';
    37: Result := Result + AErro.ToString + '-' + 'Código ISPB deve ser igual a 0';
    38: Result := Result + AErro.ToString + '-' + 'Código de barras não é numérico. Informar números.';
    39: Result := Result + AErro.ToString + '-' + 'Código de barras igual a zeros. Informar números.';
    40: Result := Result + AErro.ToString + '-' + 'Número de inscrição do pagador não é numérico. Informar números.';
    41: Result := Result + AErro.ToString + '-' + 'Número de inscrição do beneficiário não é numérico. Informar números.';
    42: Result := Result + AErro.ToString + '-' + 'Número de inscrição do avalista não é numérico. Informar números.';
    43: Result := Result + AErro.ToString + '-' + 'Digito do CPF para o pagador inválido. Verifique o nº correto.';
    44: Result := Result + AErro.ToString + '-' + 'Digito do CPF para o beneficiário inválido. Verifique o nº correto.';
    45: Result := Result + AErro.ToString + '-' + 'Digito do CPF para o avalista inválido. Verifique o nº correto.';
    46: Result := Result + AErro.ToString + '-' + 'Digito do CNPJ para o pagador inválido. Verifique o nº correto.';
    47: Result := Result + AErro.ToString + '-' + 'Digito do CNPJ para o beneficiário inválido. Verifique o nº correto.';
    48: Result := Result + AErro.ToString + '-' + 'Digito do CNPJ para o avalista inválido. Verifique o nº correto.';
    49: Result := Result + AErro.ToString + '-' + 'Data do vencimento inválida.  Informar data válida.';
    50: Result := Result + AErro.ToString + '-' + 'Valor nominal não é numérico. Informar números.';
    51: Result := Result + AErro.ToString + '-' + 'Valor de desconto não é numérico. Informar números.';
    52: Result := Result + AErro.ToString + '-' + 'Valor de mora não é numérico. Informar números.';
    53: Result := Result + AErro.ToString + '-' + 'Data do pagamento deve ser maior ou igual ao dia atual.';
    54: Result := Result + AErro.ToString + '-' + 'Número do documento de débito igual a zeros';
    55: Result := Result + AErro.ToString + '-' + 'Data do vencimento igual a zeros. Informar data de vencimento.';
    56: Result := Result + AErro.ToString + '-' + 'Nome do beneficiário não informado';
    57: Result := Result + AErro.ToString + '-' + 'Número de inscrição do beneficiário não informado. Obrigatório informar o CPF ou CNPJ do beneficiário';
    58: Result := Result + AErro.ToString + '-' + 'Conta pagamento diferente de espaços. Não informar conta pagamento.';
    59: Result := Result + AErro.ToString + '-' + 'Ambos os campos conta de crédito e conta pagamento foram informados. Informar apenas um dos campos.';
    60: Result := Result + AErro.ToString + '-' + 'Transação cancelada pelo cliente';
    61: Result := Result + AErro.ToString + '-' + 'Código da Receita do Tributo não informado';
    62: Result := Result + AErro.ToString + '-' + 'Tipo de Identificação do Contribuinte não informado';
    63: Result := Result + AErro.ToString + '-' + 'Nº de Identificação do Contribuinte não informado';
    64: Result := Result + AErro.ToString + '-' + 'Nº de Identificação do Contribuinte não numérico';
    65: Result := Result + AErro.ToString + '-' + 'Código de Identificação do Tributo não informado';
    66: Result := Result + AErro.ToString + '-' + 'Período de apuração não informado';
    67: Result := Result + AErro.ToString + '-' + 'Número de Referência não informado';
    68: Result := Result + AErro.ToString + '-' + 'Valor Principal não é numérico';
    69: Result := Result + AErro.ToString + '-' + 'Valor Principal não informado';
    70: Result := Result + AErro.ToString + '-' + 'Valor da Multa não é numérico';
    71: Result := Result + AErro.ToString + '-' + 'Valor dos Juros/Encargos não é numérico';
    72: Result := Result + AErro.ToString + '-' + 'Data de Vencimento não informada';
    73: Result := Result + AErro.ToString + '-' + 'Mês e ano de competência não informados';
    74: Result := Result + AErro.ToString + '-' + 'Valor previsto do pagamento do INSS não é numérico';
    75: Result := Result + AErro.ToString + '-' + 'Valor previsto do pagamento do INSS não informado';
    76: Result := Result + AErro.ToString + '-' + 'Valor de Outras Entidades não é numérico';
    77: Result := Result + AErro.ToString + '-' + 'Valor de Atualização Monetária não é numérico';
    78: Result := Result + AErro.ToString + '-' + 'Valor de Atualização Monetária não é numérico';
    79: Result := Result + AErro.ToString + '-' + 'Período de apuração inválido';
    80: Result := Result + AErro.ToString + '-' + 'Conta de crédito inválida. Informe o numero sem o 45 do início.';
    81: Result := Result + AErro.ToString + '-' + 'A conta informada não pertence ao funcionário.';
    82: Result := Result + AErro.ToString + '-' + 'Pagamento permitido apenas para pessoas físicas.';
    83: Result := Result + AErro.ToString + '-' + 'Agência e Conta incorretos.';
    84: Result := Result + AErro.ToString + '-' + 'A conta informada não está ativa.';
    85: Result := Result + AErro.ToString + '-' + 'Conta não permite crédito de salário. Informe outra conta.';
    86: Result := Result + AErro.ToString + '-' + 'Ambos os campos agência de crédito e conta pagamento foram informados';
    90: Result := Result + AErro.ToString + '-' + 'Mês de competência inválido';
    91: Result := Result + AErro.ToString + '-' + 'Valor de outras deduções inválido';
    92: Result := Result + AErro.ToString + '-' + 'Valor de outros acréscimos inválido';
    93: Result := Result + AErro.ToString + '-' + 'Código da forma de identificação do cliente não foi informado';
    94: Result := Result + AErro.ToString + '-' + 'DDD do cliente do Pix não foi informado';
    95: Result := Result + AErro.ToString + '-' + 'Telefone do Cliente do Pix não foi informado';
    96: Result := Result + AErro.ToString + '-' + 'Email do cliente do Pix não foi informado';
    97: Result := Result + AErro.ToString + '-' + 'Chave Aleatória do Cliente do Pix não foi informado';
    98: Result := Result + AErro.ToString + '-' + 'Código de tipo de conta do Cliente do Pix não foi informado';
    99: Result := Result + AErro.ToString + '-' + 'Consultar o Banco para detalhar o erro';
    100: Result := Result + AErro.ToString + '-' + 'E-mail inválido';
    101: Result := Result + AErro.ToString + '-' + 'Email do cliente do PIX não deve conter caractere especial';
    102: Result := Result + AErro.ToString + '-' + 'Telefone Inválido';
    103: Result := Result + AErro.ToString + '-' + 'DDD inválido';
    104: Result := Result + AErro.ToString + '-' + 'E-mail com tamanho maior que 77 caracteres.';
    105: Result := Result + AErro.ToString + '-' + 'Conta de crédito inválida. Informe um número de conta válido.';
    106: Result := Result + AErro.ToString + '-' + 'CPF inválido. Informe um CPF válido.';
    107: Result := Result + AErro.ToString + '-' + 'CNPJ inválido. Informe um CNPJ válido.';
    108: Result := Result + AErro.ToString + '-' + 'Número do documento de crédito inválido. Informe um número válido.';
    109: Result := Result + AErro.ToString + '-' + 'Número do documento de débito inválido. Informe um número válido.';
    110: Result := Result + AErro.ToString + '-' + 'Valor do pagamento inválido. Informe um valor válido.';
    111: Result := Result + AErro.ToString + '-' + 'Valor nominal inválido. Informe um valor válido.';
    112: Result := Result + AErro.ToString + '-' + 'Valor de desconto inválido. Informe um valor válido.';
    113: Result := Result + AErro.ToString + '-' + 'Valor de mora inválido. Informe um valor válido.';
    114: Result := Result + AErro.ToString + '-' + 'Número de inscrição do beneficiário inválido. Informe um número válido.';
    115: Result := Result + AErro.ToString + '-' + 'Número de inscrição do pagador inválido. Informe um número válido.';
    116: Result := Result + AErro.ToString + '-' + 'Número de inscrição do avalista inválido. Informe um número válido.';
    117: Result := Result + AErro.ToString + '-' + 'Nº de identifiação do contribuinte DARF inválido. Informe um número válido.';
    118: Result := Result + AErro.ToString + '-' + 'Número de referência inválido. Informe um número válido.';
    119: Result := Result + AErro.ToString + '-' + 'Valor principal inválido. Informe um valor válido.';
    120: Result := Result + AErro.ToString + '-' + 'Valor da multa inválido. Informe um valor válido.';
    121: Result := Result + AErro.ToString + '-' + 'Valor dos juros/encargos inválido. Informe um valor válido.';
    122: Result := Result + AErro.ToString + '-' + 'Nº de identificação do contribuinte GPS inválido. Informe um número válido.';
    123: Result := Result + AErro.ToString + '-' + 'Valor previsto do pagamento do INSS inválido. Informe um valor válido.';
    124: Result := Result + AErro.ToString + '-' + 'Valor de outras entidades inválido. Informe um valor válido.';
    125: Result := Result + AErro.ToString + '-' + 'Valor de atualização monetária inválido. Informe um valor válido.';
    126: Result := Result + AErro.ToString + '-' + 'Valor de desconto GRU inválido. Informe um valor válido.';
    200: Result := Result + AErro.ToString + '-' + 'Insuficiência de Fundos - Débito Não Efetuado';
    201: Result := Result + AErro.ToString + '-' + 'Crédito ou Débito Cancelado pelo Pagador';
    202: Result := Result + AErro.ToString + '-' + 'Débito Autorizado pela Agência - Efetuado';
    203: Result := Result + AErro.ToString + '-' + 'Controle Inválido. Verificar campos 01, 02 e 03 do header ou segmento A, B, C, J, J52, N, O ou W do Arquivo CNAB240.';
    204: Result := Result + AErro.ToString + '-' + 'Tipo de Operação Inválido';
    205: Result := Result + AErro.ToString + '-' + 'Tipo de Serviço Inválido.' + #13 +
         'Utilize 126 para Pagamento a Fornecedores, 127 para Pagamento de Salários ou 128 para Pagamentos Diversos';
    206: Result := Result + AErro.ToString + '-' + 'Forma de Lançamento Inválida.' + #13 +
         'Para crédito em Poupança utilize Pagamentos Diversos.' + #13 +
         'Para crédito em Conta Pagamento utilize Pagamentos Diversos ou Pagamento a Fornecedores.' + #13 +
         'Para Pagamento de salário a conta de crédito deve ser do BB.';
    207: Result := Result + AErro.ToString + '-' + 'Tipo/Número de Inscrição Inválido. CPF ou CNPJ inválido.';
    208: Result := Result + AErro.ToString + '-' + 'Código de Convênio Inválido';
    209: Result := Result + AErro.ToString + '-' + 'Agência/Conta Corrente/DV Inválido';
    210: Result := Result + AErro.ToString + '-' + 'Nº Seqüencial do Registro no Lote Inválido';
    211: Result := Result + AErro.ToString + '-' + 'Código de Segmento de Detalhe Inválido';
    212: Result := Result + AErro.ToString + '-' + 'Lançamento inconsistente, rejeitado na prévia. Corrigir os dados do lançamento e enviar novo pagamento.';
    213: Result := Result + AErro.ToString + '-' + 'Nº Compe do Banco para crédito Inválido';
    214: Result := Result + AErro.ToString + '-' + 'Nº do ISPB Banco, Instituição de Pagamento para crédito Inválido';
    215: Result := Result + AErro.ToString + '-' + 'Agência Mantenedora da Conta Corrente do Favorecido Inválida';
    216: Result := Result + AErro.ToString + '-' + 'Conta Corrente/DV/Conta de Pagamento do Favorecido Inválido';
    217: Result := Result + AErro.ToString + '-' + 'Nome do Favorecido Não Informado';
    218: Result := Result + AErro.ToString + '-' + 'Data Lançamento Inválido';
    219: Result := Result + AErro.ToString + '-' + 'Tipo/Quantidade da Moeda Inválido';
    220: Result := Result + AErro.ToString + '-' + 'Valor do Lançamento Inválido';
    221: Result := Result + AErro.ToString + '-' + 'Aviso ao Favorecido - Identificação Inválida';
    222: Result := Result + AErro.ToString + '-' + 'Tipo/Número de Inscrição do Favorecido Inválido. CPF ou CNPJ do favorecido inválido.';
    223: Result := Result + AErro.ToString + '-' + 'Logradouro do Favorecido Não Informado';
    224: Result := Result + AErro.ToString + '-' + 'Nº do Local do Favorecido Não Informado';
    225: Result := Result + AErro.ToString + '-' + 'Cidade do Favorecido Não Informada';
    226: Result := Result + AErro.ToString + '-' + 'CEP/Complemento do Favorecido Inválido';
    227: Result := Result + AErro.ToString + '-' + 'Sigla do Estado do Favorecido Inválida';
    228: Result := Result + AErro.ToString + '-' + 'Nº do Banco para crédito Inválido';
    229: Result := Result + AErro.ToString + '-' + 'Código/Nome da Agência Depositária Não Informado';
    230: Result := Result + AErro.ToString + '-' + 'Seu Número Inválido';
    231: Result := Result + AErro.ToString + '-' + 'Nosso Número Inválido';
    232: Result := Result + AErro.ToString + '-' + 'Inclusão Efetuada com Sucesso';
    233: Result := Result + AErro.ToString + '-' + 'Alteração Efetuada com Sucesso';
    234: Result := Result + AErro.ToString + '-' + 'Exclusão Efetuada com Sucesso';
    235: Result := Result + AErro.ToString + '-' + 'Agência/Conta Impedida Legalmente';
    236: Result := Result + AErro.ToString + '-' + 'Empresa não pagou salário. Conta de crédito só aceita pagamento de salário.';
    237: Result := Result + AErro.ToString + '-' + 'Falecimento do mutuário';
    238: Result := Result + AErro.ToString + '-' + 'Empresa não enviou remessa do mutuário';
    239: Result := Result + AErro.ToString + '-' + 'Empresa não enviou remessa no vencimento';
    240: Result := Result + AErro.ToString + '-' + 'Valor da parcela inválida';
    241: Result := Result + AErro.ToString + '-' + 'Identificação do contrato inválida';
    242: Result := Result + AErro.ToString + '-' + 'Operação de Consignação Incluída com Sucesso';
    243: Result := Result + AErro.ToString + '-' + 'Operação de Consignação Alterada com Sucesso';
    244: Result := Result + AErro.ToString + '-' + 'Operação de Consignação Excluída com Sucesso';
    245: Result := Result + AErro.ToString + '-' + 'Operação de Consignação Liquidada com Sucesso';
    246: Result := Result + AErro.ToString + '-' + 'Reativação Efetuada com Sucesso';
    247: Result := Result + AErro.ToString + '-' + 'Suspensão Efetuada com Sucesso';
    248: Result := Result + AErro.ToString + '-' + 'Código de Barras - Código do Banco Inválido';
    249: Result := Result + AErro.ToString + '-' + 'Código de Barras - Código da Moeda Inválido';
    250: Result := Result + AErro.ToString + '-' + 'Código de Barras - Dígito Verificador Geral Inválido';
    251: Result := Result + AErro.ToString + '-' + 'Código de Barras - Valor do Título Inválido';
    252: Result := Result + AErro.ToString + '-' + 'Código de Barras - Campo Livre Inválido';
    253: Result := Result + AErro.ToString + '-' + 'Valor do Documento Inválido';
    254: Result := Result + AErro.ToString + '-' + 'Valor do Abatimento Inválido';
    255: Result := Result + AErro.ToString + '-' + 'Valor do Desconto Inválido';
    256: Result := Result + AErro.ToString + '-' + 'Valor de Mora Inválido';
    257: Result := Result + AErro.ToString + '-' + 'Valor da Multa Inválido';
    258: Result := Result + AErro.ToString + '-' + 'Valor do IR Inválido';
    259: Result := Result + AErro.ToString + '-' + 'Valor do ISS Inválido';
    260: Result := Result + AErro.ToString + '-' + 'Valor do IOF Inválido';
    261: Result := Result + AErro.ToString + '-' + 'Valor de Outras Deduções Inválido';
    262: Result := Result + AErro.ToString + '-' + 'Valor de Outros Acréscimos Inválido';
    263: Result := Result + AErro.ToString + '-' + 'Valor do INSS Inválido';
    264: Result := Result + AErro.ToString + '-' + 'Lote Não Aceito';
    265: Result := Result + AErro.ToString + '-' + 'Inscrição da Empresa Inválida para o Contrato';
    266: Result := Result + AErro.ToString + '-' + 'Convênio com a Empresa Inexistente/Inválido para o Contrato';
    267: Result := Result + AErro.ToString + '-' + 'Agência/Conta Corrente da Empresa Inexistente/Inválido para o Contrato';
    268: Result := Result + AErro.ToString + '-' + 'Tipo de Serviço Inválido para o Contrato';
    269: Result := Result + AErro.ToString + '-' + 'Conta Corrente da Empresa com Saldo Insuficiente';
    270: Result := Result + AErro.ToString + '-' + 'Lote de Serviço Fora de Seqüência';
    271: Result := Result + AErro.ToString + '-' + 'Lote de Serviço Inválido';
    272: Result := Result + AErro.ToString + '-' + 'Arquivo não aceito';
    273: Result := Result + AErro.ToString + '-' + 'Tipo de Registro Inválido';
    274: Result := Result + AErro.ToString + '-' + 'Código Remessa / Retorno Inválido';
    275: Result := Result + AErro.ToString + '-' + 'Versão de layout inválida';
    276: Result := Result + AErro.ToString + '-' + 'Mutuário não identificado';
    277: Result := Result + AErro.ToString + '-' + 'Tipo do beneficio não permite empréstimo';
    278: Result := Result + AErro.ToString + '-' + 'Beneficio cessado/suspenso';
    279: Result := Result + AErro.ToString + '-' + 'Beneficio possui representante legal';
    280: Result := Result + AErro.ToString + '-' + 'Beneficio é do tipo PA (Pensão alimentícia)';
    281: Result := Result + AErro.ToString + '-' + 'Quantidade de contratos permitida excedida';
    282: Result := Result + AErro.ToString + '-' + 'Beneficio não pertence ao Banco informado';
    283: Result := Result + AErro.ToString + '-' + 'Início do desconto informado já ultrapassado';
    284: Result := Result + AErro.ToString + '-' + 'Número da parcela inválida';
    285: Result := Result + AErro.ToString + '-' + 'Quantidade de parcela inválida';
    286: Result := Result + AErro.ToString + '-' + 'Margem consignável excedida para o mutuário dentro do prazo do contrato';
    287: Result := Result + AErro.ToString + '-' + 'Empréstimo já cadastrado';
    288: Result := Result + AErro.ToString + '-' + 'Empréstimo inexistente';
    289: Result := Result + AErro.ToString + '-' + 'Empréstimo já encerrado';
    290: Result := Result + AErro.ToString + '-' + 'Arquivo sem trailer';
    291: Result := Result + AErro.ToString + '-' + 'Mutuário sem crédito na competência';
    292: Result := Result + AErro.ToString + '-' + 'Não descontado – outros motivos';
    293: Result := Result + AErro.ToString + '-' + 'Retorno de Crédito não pago';
    294: Result := Result + AErro.ToString + '-' + 'Cancelamento de empréstimo retroativo';
    295: Result := Result + AErro.ToString + '-' + 'Outros Motivos de Glosa';
    296: Result := Result + AErro.ToString + '-' + 'Margem consignável excedida para o mutuário acima do prazo do contrato';
    297: Result := Result + AErro.ToString + '-' + 'Mutuário desligado do empregador';
    298: Result := Result + AErro.ToString + '-' + 'Mutuário afastado por licença';
    299: Result := Result + AErro.ToString + '-' + 'Primeiro nome do mutuário diferente do primeiro nome do movimento do censo ou diferente da base de Titular do Benefício';
    300: Result := Result + AErro.ToString + '-' + 'Benefício suspenso/cessado pela APS ou Sisobi';
    301: Result := Result + AErro.ToString + '-' + 'Benefício suspenso por dependência de cálculo';
    302: Result := Result + AErro.ToString + '-' + 'Benefício suspenso/cessado pela inspetoria/auditoria';
    303: Result := Result + AErro.ToString + '-' + 'Benefício bloqueado para empréstimo pelo beneficiário';
    304: Result := Result + AErro.ToString + '-' + 'Benefício bloqueado para empréstimo por TBM';
    305: Result := Result + AErro.ToString + '-' + 'Benefício está em fase de concessão de PA ou desdobramento';
    306: Result := Result + AErro.ToString + '-' + 'Benefício cessado por óbito';
    307: Result := Result + AErro.ToString + '-' + 'Benefício cessado por fraude';
    308: Result := Result + AErro.ToString + '-' + 'Benefício cessado por concessão de outro benefício';
    309: Result := Result + AErro.ToString + '-' + 'Benefício cessado: estatutário transferido para órgão de origem';
    310: Result := Result + AErro.ToString + '-' + 'Empréstimo suspenso pela APS';
    311: Result := Result + AErro.ToString + '-' + 'Empréstimo cancelado pelo banco';
    312: Result := Result + AErro.ToString + '-' + 'Crédito transformado em PAB';
    313: Result := Result + AErro.ToString + '-' + 'Término da consignação foi alterado';
    314: Result := Result + AErro.ToString + '-' + 'Fim do empréstimo ocorreu durante período de suspensão ou concessão';
    315: Result := Result + AErro.ToString + '-' + 'Empréstimo suspenso pelo banco';
    316: Result := Result + AErro.ToString + '-' + 'Não averbação de contrato – quantidade de parcelas/competências informadas ultrapassou a data limite da extinção de cota do dependente titular de benefícios';
    317: Result := Result + AErro.ToString + '-' + 'Lote Não Aceito - Totais do Lote com Diferença';
    318: Result := Result + AErro.ToString + '-' + 'Título Não Encontrado';
    319: Result := Result + AErro.ToString + '-' + 'Identificador Registro Opcional Inválido';
    320: Result := Result + AErro.ToString + '-' + 'Código Padrão Inválido';
    321: Result := Result + AErro.ToString + '-' + 'Código de Ocorrência Inválido';
    322: Result := Result + AErro.ToString + '-' + 'Complemento de Ocorrência Inválido';
    323: Result := Result + AErro.ToString + '-' + 'Alegação já Informada';
    324: Result := Result + AErro.ToString + '-' + 'Agência / Conta do Favorecido Substituída';
    325: Result := Result + AErro.ToString + '-' + 'Divergência entre o primeiro e último nome do beneficiário versus primeiro e último nome na Receita Federal';
    326: Result := Result + AErro.ToString + '-' + 'Confirmação de Antecipação de Valor';
    327: Result := Result + AErro.ToString + '-' + 'Antecipação parcial de valor';
    328: Result := Result + AErro.ToString + '-' + 'Boleto bloqueado na base. Não passível de pagamento.';
    329: Result := Result + AErro.ToString + '-' + 'Sistema em contingência – Boleto valor maior que referência';
    330: Result := Result + AErro.ToString + '-' + 'Sistema em contingência – Boleto vencido';
    331: Result := Result + AErro.ToString + '-' + 'Sistema em contingência – Boleto indexado';
    332: Result := Result + AErro.ToString + '-' + 'Beneficiário divergente.';
    333: Result := Result + AErro.ToString + '-' + 'Limite de pagamentos parciais do boleto excedido. Consulte o Beneficiário do boleto.';
    334: Result := Result + AErro.ToString + '-' + 'Boleto já liquidado. Não passível de pagamento.';
    335: Result := Result + AErro.ToString + '-' + 'Pix não efetivado';
    336: Result := Result + AErro.ToString + '-' + 'Transação interrompida devido a erro no PSP do Recebedor';
    337: Result := Result + AErro.ToString + '-' + 'Número da conta transacional encerrada no PSP do Recebedor';
    338: Result := Result + AErro.ToString + '-' + 'Tipo incorreto para a conta transacional especificada';
    339: Result := Result + AErro.ToString + '-' + 'Tipo de transação não é suportado/autorizado na conta transacional especificada';
    340: Result := Result + AErro.ToString + '-' + 'CPF/CNPJ do usuário recebedor não é consistente com o titular da conta transacional especificada';
    341: Result := Result + AErro.ToString + '-' + 'CPF/CNPJ do usuário recebedor incorreto';
    342: Result := Result + AErro.ToString + '-' + 'Ordem rejeitada pelo PSP do Recebedor';
    343: Result := Result + AErro.ToString + '-' + 'ISPB do PSP do Pagador inválido ou inexistente';
    344: Result := Result + AErro.ToString + '-' + 'Chave não cadastrada no DICT';
    345: Result := Result + AErro.ToString + '-' + 'QR Code inválido/vencido';
    346: Result := Result + AErro.ToString + '-' + 'Forma de iniciação inválida';
    347: Result := Result + AErro.ToString + '-' + 'Chave de pagamento inválida';
    348: Result := Result + AErro.ToString + '-' + 'Chave de pagamento não informada';

    //PELO ESTADO DO PAGAMENTO
    900: Result := Result + 'AGENDADO';
    901: Result := Result + 'CANCELADO';
    902: Result := Result + 'CONSISTENTE';
    903: Result := Result + 'DEVOLVIDO';
    904: Result := Result + 'INCONSISTENTE';
    905: Result := Result + 'BLOQUEADO';
    906: Result := Result + 'PENDENTE';
    907: Result := Result + 'REJEITADO';
    908: Result := Result + 'VENCIDO';

    999: Result := Result + AErro.ToString + '-' + 'Consultar o Banco para detalhar o erro';
  end;
End;

function TPagForBancoDoBrasilAPI.RetornaIDTipoChavePix(
  ATipoChave: String): String;
begin
  Result := '1';

  If ATipoChave.Equals('EMAIL') THen
    Result := '2'
  Else If ATipoChave.Equals('CNPJ-CPF') Then
    Result := '3'
  Else If ATipoChave.Equals('ALEATORIA') Then
    Result := '4';
end;

end.
