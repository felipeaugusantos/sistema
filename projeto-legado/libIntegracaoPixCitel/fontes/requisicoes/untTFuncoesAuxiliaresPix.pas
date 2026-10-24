unit untTFuncoesAuxiliaresPix;

interface

Uses
{$IFDEF LINUX}
{$ELSE}
{$ENDIF}
  untTiposPix, System.Json, System.SysUtils, System.StrUtils, untIDataset,
  System.Generics.Collections, System.DateUtils, System.Classes, System.Variants;

Type
  TFuncoesPix = class
  private
    class function TransformaDataRetornoTDateTime(ADataRetornoPix: String): TDateTime;

    class function TransformaMesNumerico(AMesString: String): String;

    class procedure RetornaDadosDoGrupoPix(AJsonObject: TJsonObject;
                                           var ARetorno: TDadosRetornoPixConsulta);

    class procedure RetornaDadosDoGrupoDevolucoes(AJsonArray: TJsonArray;
                                                  var ARetorno: TDadosRetornoPixConsulta);

    class function RetornaValorLocation(AJsonObject: TJsonObject): String;

    class function RetornaValorTextoQRCode(AJsonObject: TJsonObject): String;

    class function RetornaErro400PorBanco(ACodigoBanco,
                                          ARetornoErro: String): String;
    class function RetornaErro400Banco001(ARetornoErro: String): String;

    class function RetiraQuebraLinha(AText : String): String;
  public
    class function RetornaJsonDadosRequisicao(ADadosRequisicao: TDadosRequisicaoPixAVista;
                                              ACodigoBanco: String = ''): String;

    class function RetornaDadosDoRetornoPixAVista(ARequisicao,
                                                  ARetorno,
                                                  AAutoIncremPix: String;
                                                  AUtilizaShipay: Boolean = False;
                                                  AUtilizaTefScope: Boolean = False): TDadosRetornoPixAVista;

    class function RetornaDadosDoRetornoPixConsulta(ARetorno: String;
                                                    ARequisicao: String = ''): TDadosRetornoPixConsulta;
    class function RetornaDadosDoRetornoPixConsultaPeriodo(ARetorno: String): TDadosRetornoPixConsultaRecebidos;

    class function RetornaDadosDoRetornoPixDevolucao(ARetorno: String;
                                                     AUtilizaShipay: Boolean = False): TDadosRetornoPixDevolucao;

    class function RetornaMensagemErroRequisicao(ARetorno: String): String;
    class function RetornoErro503ComPaginaHTML(ARetorno: String): Boolean;

    class function AdicionaTextoQRCode(ARetorno, ATextoQRCode: String): String;

    class function AdicionaLinkCitelJson(ARetornoCobranca,
                                         ARetornoAPICitel: String;
                                         AApenasResultado: Boolean = False): String;

    class function RetornaChaveBasic(AClientID,
                                     AClientSecret: String): String;

    class function RetornaDadosAlteracao(ADadosRequisicao: String;
                                         ABanco: String = '';
                                         AUtilizaShipay: Boolean = False): String;

    class function CRC16CCITT(texto: string): WORD;

    class function CorrigeDadosRetorno(ARetorno: String): String;

    class function RetornaCobrancaPorTxIdBtgPactual(ARetorno, ATxIdPix: String): String;

    class function CorrigeCamposRequisicaoPorBanco(ARequisicao, ACodigoBanco: String): String;

    class function VerificaPixComStatusConcluidoEComValorPago(ARegistroPix: TDadosRetornoPixConsulta): Boolean;

    class function GeraJsonErro(ACodigoBanco,
                                AErro,
                                AExceptionMessage: String): String;

    class function RetornaErroPeloCodigo(ACodigoBanco,
                                         ACodigoErro,
                                         AMensagemErro,
                                         ARetornoErro: String): String;

    class function RetornaLinkCitel(AChaveLink: String;
                                    AHomologacao: String = ''): String;

    class function RetornaValorCampoJson(ACampo,
                                         ATextoJson: String;
                                         ACampoObjetoJson: Boolean = False): String;

    class function RetornaValorJson(AObjeto: TJsonObject;
                                    ANomeCampo: String): String;

    class function RetornaDadosDoRetornoWebhook(ADadosRetorno,
                                                ADadosRetornoCertificado: String): TDadosWebhook;

    class function RetornaResultadoRequisicao(ACodigoStatus,
                                              ARetornoStatus: String): String;

    class procedure CloneObjetoConsultaPix(AObjetoOriginal: TDadosRetornoPixConsulta;
                                           out ANovoObjeto: TDadosRetornoPixConsulta);

    class function TransformaTDateTimeEmStringZulu(ADataHora: TDateTime): String;

    class function RetornaCaminhoIntegracaoPixDll(ACaminhoExe: String): String;

    class procedure LiberaLibIntegracaoPix(Var AHandlePix: THandle);
    
    { SHIPAY}
    class function RetornaJsonDadosRequisicaoShipay(ADadosRequisicao: TDadosRequisicaoPixAVista): String;

    class function RetornaDadosDoRetornoPixAVistaShipay(ARequisicao,
                                                        ARetorno,
                                                        AAutoIncremPix: String): TDadosRetornoPixAVista;

    class function RetornaDadosDoRetornoPixConsultaShipay(ARetorno,
                                                          ARequisicao: String): TDadosRetornoPixConsulta;

    class function RetornaOrderRefShipay(ARequisicao: String): String;

    { BTG PACTUAL }
    class function RetornaJsonDadosRequisicaoBtgPactual(ADadosRequisicao: String): String; overload;
    class function RetornaJsonDadosRequisicaoBtgPactual(ADadosRequisicao: TDadosRequisicaoPixAVista): String; overload;

    class function RetornaDadosDoRetornoPixAVistaBtgPactual(ARequisicao,
                                                            ARetorno,
                                                            AAutoIncremPix: String): TDadosRetornoPixAVista;

    class function RetornaDadosDoRetornoPixConsultaBtgPactual(ARetorno,
                                                              ARequisicao: String): TDadosRetornoPixConsulta;
  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  untFuncoesSimples, WinAPI.Windows, Vcl.Forms,
{$ENDIF}
  System.NetEncoding;

{ TFuncoesPix }

class function TFuncoesPix.AdicionaLinkCitelJson(ARetornoCobranca,
  ARetornoAPICitel: String; AApenasResultado: Boolean = False): String;
  Var
    LJsonObject: TJsonObject;
begin
  Result := ARetornoCobranca;

  If Pos('"link":', ARetornoAPICitel) = 0 Then
    Exit;

  Try
    LJsonObject := TJSONObject.ParseJSONValue(ARetornoAPICitel) as TJSONObject;

    If LJsonObject.GetValue('link') = Nil Then
      Exit;

    If Not AApenasResultado Then
    Begin
      Result := LeftStr(Result, Result.Length - 1);
      Result := Result + ', "linkCitel": "' + LJsonObject.GetValue<String>('link') + '"}';
    End
    Else
      Result := LJsonObject.GetValue<String>('link');
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

class function TFuncoesPix.AdicionaTextoQRCode(ARetorno, ATextoQRCode: String): String;
begin
  Result := ARetorno;

  If Pos('STATUS', Result.ToUpper) = 0 Then
    Exit;

  If ATextoQRCode.IsEmpty THen
    Exit;

  Result := LeftStr(Result, Result.Length - 1) + ',"textoImagemQRcode": "' + ATextoQRCode + '"}';
end;

class procedure TFuncoesPix.CloneObjetoConsultaPix(
  AObjetoOriginal: TDadosRetornoPixConsulta;
  out ANovoObjeto: TDadosRetornoPixConsulta);
begin
  ANovoObjeto := TDadosRetornoPixConsulta.Create;

  ANovoObjeto.Status := AObjetoOriginal.Status;
  ANovoObjeto.Expiracao := AObjetoOriginal.Expiracao;
  ANovoObjeto.LinkQrCode := AObjetoOriginal.LinkQrCode;
  ANovoObjeto.TextoQrCode := AObjetoOriginal.TextoQrCode;
  ANovoObjeto.Txid := AObjetoOriginal.Txid;
  ANovoObjeto.Revisao := AObjetoOriginal.Revisao;
  ANovoObjeto.EndToEndId := AObjetoOriginal.EndToEndId;

  ANovoObjeto.CPFCNPJDevedor := AObjetoOriginal.CPFCNPJDevedor;
  ANovoObjeto.NomeDevedor := AObjetoOriginal.NomeDevedor;

  ANovoObjeto.CPFCNPJPagador := AObjetoOriginal.CPFCNPJPagador;
  ANovoObjeto.NomePagador := AObjetoOriginal.NomePagador;

  ANovoObjeto.ChavePix := AObjetoOriginal.ChavePix;
  ANovoObjeto.SolicitacaoPagador := AObjetoOriginal.SolicitacaoPagador;
  ANovoObjeto.InformacaoPagador := AObjetoOriginal.InformacaoPagador;

  ANovoObjeto.InformacoesAdicionais := AObjetoOriginal.InformacoesAdicionais;

  ANovoObjeto.CodigoEmpresa := AObjetoOriginal.CodigoEmpresa;
  ANovoObjeto.CodigoPortador := AObjetoOriginal.CodigoPortador;
  ANovoObjeto.PlanoDeContas := AObjetoOriginal.PlanoDeContas;
  ANovoObjeto.AutoIncremMovPix := AObjetoOriginal.AutoIncremMovPix;
  ANovoObjeto.AutoIncremChavePix := AObjetoOriginal.AutoIncremChavePix;
  ANovoObjeto.MovbanBaixa := AObjetoOriginal.MovbanBaixa;
  ANovoObjeto.NumeroDoPedido := AObjetoOriginal.NumeroDoPedido;
  ANovoObjeto.CodigoDoCliente := AObjetoOriginal.CodigoDoCliente;
  ANovoObjeto.NumeroDasDuplicatas := AObjetoOriginal.NumeroDasDuplicatas;
  ANovoObjeto.CodigoOperadorRobo := AObjetoOriginal.CodigoOperadorRobo;

  ANovoObjeto.JsonRetorno := AObjetoOriginal.JsonRetorno;
  ANovoObjeto.JSonChavePix := AObjetoOriginal.JSonChavePix;
  ANovoObjeto.JSonRequisicao := AObjetoOriginal.JSonRequisicao;

  ANovoObjeto.LinkCitel := AObjetoOriginal.LinkCitel;

  ANovoObjeto.CodigoDoCaixa := AObjetoOriginal.CodigoDoCaixa;
  ANovoObjeto.RecebidoPeloF11 := AObjetoOriginal.RecebidoPeloF11;
  ANovoObjeto.OrigemAdiantamento := AObjetoOriginal.OrigemAdiantamento;
  ANovoObjeto.CriadoPelo := AObjetoOriginal.CriadoPelo;

  ANovoObjeto.Valor := AObjetoOriginal.Valor;
  ANovoObjeto.ValorPago := AObjetoOriginal.ValorPago;

  ANovoObjeto.DataCriacao := AObjetoOriginal.DataCriacao;
  ANovoObjeto.DataPagamento := AObjetoOriginal.DataPagamento;
  ANovoObjeto.DataCaixa := AObjetoOriginal.DataCaixa;

  ANovoObjeto.DataCriacaoString := AObjetoOriginal.DataCriacaoString;
  ANovoObjeto.DataPagamentoString := AObjetoOriginal.DataPagamentoString;

  ANovoObjeto.Devolucoes := AObjetoOriginal.Devolucoes;

  ANovoObjeto.OrderRef := AObjetoOriginal.OrderRef;
  ANovoObjeto.TipoCobranca := AObjetoOriginal.TipoCobranca;
  ANovoObjeto.UtilizaShipay := AObjetoOriginal.UtilizaShipay;
  ANovoObjeto.ChaveParaCreditoCliente := AObjetoOriginal.ChaveParaCreditoCliente;

  ANovoObjeto.SeqConRecebimento := AObjetoOriginal.SeqConRecebimento;
  ANovoObjeto.SeqConTransferencia := AObjetoOriginal.SeqConTransferencia;
  ANovoObjeto.QuantidadeDevolucoes := AObjetoOriginal.QuantidadeDevolucoes;

  ANovoObjeto.DadosDevolucao := AObjetoOriginal.DadosDevolucao;
end;

class function TFuncoesPix.RetiraQuebraLinha(AText : String): String;
begin
  AText := StringReplace(AText, #$D, '', [rfReplaceAll]);
  AText := StringReplace(AText, #$A, '', [rfReplaceAll]);
  AText := StringReplace(AText, #13, '', [rfReplaceAll]);
  AText := StringReplace(AText, #10, '', [rfReplaceAll]);
  Result := AText;
end;

class function TFuncoesPix.CorrigeCamposRequisicaoPorBanco(ARequisicao,
  ACodigoBanco: String): String;
  Var
    LJsonObject,
    LJsonValue,
    LJsonDevedor: TJsonObject;
begin
  Result := ARequisicao;

  LJsonObject := TJSONObject.ParseJSONValue(ARequisicao) as TJSONObject;

  If LJsonObject = Nil THen
    Exit;

  Try
    If MatchStr(ACodigoBanco, ['756']) Then
    Begin
      LJsonValue := LJsonObject.GetValue('calendario') as TJSONObject;

      Result := '{' + #13;

      Result := Result + '  "calendario": {' + #13;
      Result := Result + '    "expiracao": ' + LJsonValue.GetValue<string>('expiracao') + #13;
      Result := Result + '  },' + #13;

      If LJsonObject.GetValue('devedor') <> Nil Then
      Begin
        LJsonDevedor := TJSONObject.ParseJSONValue(LJsonObject.GetValue('devedor').ToJson) as TJSONObject;
        LJsonDevedor.Pairs[0].JsonValue := TJsonString.Create(RetiraQuebraLinha(LJsonDevedor.Pairs[0].JsonValue.Value));
        LJsonDevedor.Pairs[1].JsonValue := TJsonString.Create(RetiraQuebraLinha(LJsonDevedor.Pairs[1].JsonValue.Value));

        Result := Result + '"develor": ' + LJsonDevedor.ToJSON + ',' + #13;
      End;

      Result := Result + '"valor": ' + LJsonObject.GetValue('valor').ToJSON + ',' + #13;

      Result := Result + '    "chave": "' + LJsonObject.GetValue<string>('chave') + '",' + #13;
      Result := Result + '    "solicitacaoPagador": "' + LJsonObject.GetValue<string>('solicitacaoPagador') + '"';

      If LJsonObject.GetValue('infoAdicionais') <> Nil Then
      Begin
        Result := Result + ',' + #13;

        Result := Result + '"infoAdicionais": ' + LJsonObject.GetValue('infoAdicionais').ToJSON;

      End;

      Result := Result + #13 + '}';

      FreeAndNil(LJsonValue);

      Exit;
    End;

    If LJsonObject.GetValue('devedor') <> Nil Then
    Begin
      LJsonDevedor := TJSONObject.ParseJSONValue(LJsonObject.GetValue('devedor').ToJson) as TJSONObject;
      LJsonDevedor.Pairs[0].JsonValue := TJsonString.Create(RetiraQuebraLinha(LJsonDevedor.Pairs[0].JsonValue.Value));
      LJsonDevedor.Pairs[1].JsonValue := TJsonString.Create(RetiraQuebraLinha(LJsonDevedor.Pairs[1].JsonValue.Value));

      LJsonObject.RemovePair('devedor');
      LJsonObject.AddPair('devedor', LJsonDevedor);

      Result := LJsonObject.ToJSON;

      FreeAndNil(LJsonDevedor);
    End;
  Except
    Result := ARequisicao;
  End;
end;

class function TFuncoesPix.CorrigeDadosRetorno(ARetorno: String): String;
begin
  Result := ARetorno.Replace(#$A, ' ').Trim();
  Result := Result.Replace('Ãº', 'ú');
  Result := Result.Replace('Ã§', 'ç');
  Result := Result.Replace('Ã£', 'ã');
  Result := Result.Replace('Ã©', 'é');
  Result := Result.Replace('Ã-', 'í');
  Result := Result.Replace('Ãµ', 'õ');
  Result := Result.Replace('Ãª', 'ê');
  Result := Result.Replace('Ã¡', 'á');
end;

class function TFuncoesPix.RetornaCaminhoIntegracaoPixDll(
  ACaminhoExe: String): String;
  Const
    DLL_PIX = 'libIntegracaoPixCitel.dll';
begin
  Result := ACaminhoExe + DLL_PIX;

  If Not FileExists(Result) Then
    Raise Exception.Create('O arquivo ' + DLL_PIX + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');
end;

class function TFuncoesPix.RetornaChaveBasic(AClientID,
  AClientSecret: String): String;
  Var
    LBase64: TBase64Encoding;
begin
  Result := '';

  If AClientID.IsEmpty Then
    Exit;

  If AClientSecret.IsEmpty Then
    Exit;

  Try
    LBase64 := TBase64Encoding.Create(0);

    Result := 'Basic ' + LBase64.Encode(AClientID + ':' + AClientSecret);
  Finally
    FreeAndNil(LBase64);
  End;
end;

class function TFuncoesPix.RetornaCobrancaPorTxIdBtgPactual(ARetorno,
  ATxIdPix: String): String;
  Var
    LJsonobject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;
begin
  Result := ARetorno;

  LJsonObject := TJsonObject.ParseJSONValue(ARetorno) As TJsonObject;

  If LJsonObject = Nil Then
    Exit;

  LJsonArray := TJsonObject.ParseJSONValue(LJsonObject.GetValue('data').ToJson) As TJsonArray;

  For LJsonValue In LJsonArray Do
  Begin
    //If ATxIdPix.Equals(LJsonValue.GetValue<String>('txId')) Then
      Exit(LJsonValue.ToJSON);
  End;
end;

class function TFuncoesPix.RetornaDadosAlteracao(
  ADadosRequisicao: String; ABanco: String = '';
  AUtilizaShipay: Boolean = False): String;
  Var
    LJsonObject,
    LJsonValor: TJsonObject;

    LFloatShipay: Double;
begin
  LJsonObject := TJSONObject.ParseJSONValue(ADadosRequisicao) as TJSONObject;

  Result := '{';

  If Not AUtilizaShipay Then
  Begin
    LJsonValor := LJSONObject.GetValue('valor') as TJSONObject;

    If LJsonValor.GetValue<string>('original') <> '0.00' Then
    Begin
      Result := Result + '"valor": {';

      If ABanco = '237' Then
        Result := Result + '"modalidadeAlteracao": 0, ';

      Result := Result + '"original": "' + LJsonValor.GetValue<string>('original') + '"} ';
    End;

    If LJSONObject.GetValue('status') <> Nil Then
    Begin
      If LJSONObject.GetValue<String>('status') = 'REMOVIDA_PELO_USUARIO_RECEBEDOR' Then
      Begin
        If Result <> '{' Then
          Result := Result + ',';

        Result := Result + '"status": "REMOVIDA_PELO_USUARIO_RECEBEDOR"';
      End;
    End;
  End
  Else
  Begin
    LFloatShipay := 0;
    If LJSONObject.GetValue('total') <> Nil Then
      LFloatShipay := fStrToFloat(StringReplace(LJsonObject.GetValue<String>('total'), '.', ',', []));

    If LJSONObject.GetValue('total_order') <> Nil Then
      LFloatShipay := fStrToFloat(StringReplace(LJsonObject.GetValue<String>('total_order'), '.', ',', []));

    Result := Result + '"total_order": ' + LFloatShipay.ToString;
  End;

  Result := Result + '}';

  LJsonObject.Free;
end;

class procedure TFuncoesPix.RetornaDadosDoGrupoDevolucoes(
  AJsonArray: TJsonArray; var ARetorno: TDadosRetornoPixConsulta);
  Var
    LJsonValue: TJsonValue;

    LDadosDevolucao: TDadosRetornoPixDevolucao;
begin
  If AJsonArray = Nil Then
    Exit;

  For LJsonValue In AJsonArray Do
  Begin
    LDadosDevolucao := RetornaDadosDoRetornoPixDevolucao(LJsonValue.ToJSON, False);

    ARetorno.DadosDevolucao.Add(LDadosDevolucao);
  End;
end;

class procedure TFuncoesPix.RetornaDadosDoGrupoPix(AJsonObject: TJsonObject;
  var ARetorno: TDadosRetornoPixConsulta);
  Var
    LJsonObjectValue,
    LJsonObjectPagador: TJSONObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LListaEndToEndId: TStringList;
begin
  ARetorno.ValorPago := 0;

  LListaEndToEndId := TStringList.Create;
  Try
    If AJsonObject.GetValue('pix') <> Nil Then
    Begin
      ARetorno.JsonChavePix := AJsonObject.GetValue('pix').ToJSON;

      LJsonArray := AJsonObject.GetValue('pix') as TJsonArray;

      ARetorno.DadosDevolucao := TList<TDadosRetornoPixDevolucao>.Create;

      For LJsonValue In LJsonArray Do
      Begin
        ARetorno.EndToEndId := LJsonValue.GetValue<String>('endToEndId');
        If LListaEndToEndId.IndexOf(ARetorno.EndToEndId) > -1 Then
          Continue;

        LListaEndToEndId.Add(ARetorno.EndToEndId);

        ARetorno.ValorPago := ARetorno.ValorPago + fStrToFloat(StringReplace(LJsonValue.GetValue<String>('valor'), '.', ',', []));
        ARetorno.DataPagamento := TransformaDataRetornoTDateTime(LJsonValue.GetValue<String>('horario'));
        ARetorno.DataPagamentoString := LJsonValue.GetValue<String>('horario');

        LJsonObjectPagador := LJsonValue as TJSONObject;
        If LJsonObjectPagador.GetValue('pagador') <> Nil Then
        Begin
          LJsonObjectValue := LJsonObjectPagador.GetValue('pagador') as TJSONObject;

          If LJsonObjectValue.GetValue('cnpj') <> Nil Then
          Begin
            If LJsonObjectValue.GetValue<String>('cnpj') <> EmptyStr Then
              ARetorno.CPFCNPJPagador := LJsonObjectValue.GetValue<String>('cnpj');
          End;

          If LJsonObjectValue.GetValue('cpf') <> Nil Then
          Begin
            If LJsonObjectValue.GetValue<String>('cpf') <> EmptyStr Then
              ARetorno.CPFCNPJPagador := LJsonObjectValue.GetValue<String>('cpf');
          End;

          ARetorno.NomePagador := LJsonObjectValue.GetValue<String>('nome');
        End;

        If (LJsonValue as TJsonObject).GetValue('infoPagador') <> Nil Then
          ARetorno.InformacaoPagador :=  LJsonValue.GetValue<String>('infoPagador');

        If (LJsonValue as TJsonObject).GetValue('devolucoes') <> Nil Then
          RetornaDadosDoGrupoDevolucoes((LJsonValue as TJsonObject).GetValue('devolucoes') as TJsonArray,
                                        ARetorno);
      End;
    End;
  Finally
    FreeAndNil(LListaEndToEndId);
  End;
end;

class function TFuncoesPix.RetornaDadosDoRetornoPixAVista(ARequisicao,
  ARetorno, AAutoIncremPix: String; AUtilizaShipay: Boolean = False; AUtilizaTefScope: Boolean = False): TDadosRetornoPixAVista;
  Var
    LJsonObject,
    LJsonObjectValue: TJSONObject;
begin
  If AUtilizaShipay Then
  Begin
    Result := RetornaDadosDoRetornoPixAVistaShipay(ARequisicao,
                                                   ARetorno,
                                                   AAutoIncremPix);

    Exit;
  End;

  If ARetorno.Contains('"pixKey":') Then
    Exit(RetornaDadosDoRetornoPixAVistaBtgPactual(ARequisicao,
                                                  ARetorno,
                                                  AAutoIncremPix));

  Try
    Result := TDadosRetornoPixAVista.Create;

    Result.JsonRetorno := ARetorno;
    Result.JsonRequisicao := ARequisicao;

    LJsonObject := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;

    Result.Status := LJsonObject.GetValue<String>('status');

    LJsonObjectValue := LJsonObject.GetValue('calendario') as TJSONObject;
    Result.DataCriacao := TransformaDataRetornoTDateTime(LJsonObjectValue.GetValue<String>('criacao'));
    Result.DataCriacaoString := LJsonObjectValue.GetValue<String>('criacao');
    Result.Expiracao := LJsonObjectValue.GetValue<String>('expiracao');

    Result.LinkQrCode := RetornaValorLocation(LJsonObject);

    Result.TextoQrCode := RetornaValorTextoQRCode(LJsonObject);

    Result.Txid := LJsonObject.GetValue<String>('txid');
    Result.Revisao := LJsonObject.GetValue<String>('revisao');

    If LJsonObject.GetValue('devedor') <> Nil Then
    Begin
      LJsonObjectValue := LJsonObject.GetValue('devedor') as TJSONObject;

      If LJsonObjectValue.GetValue('cnpj') <> Nil Then
      Begin
        Result.CPFCNPJDevedor := LJsonObjectValue.GetValue<String>('cnpj');
        Result.TipoDoDevedor := '1';
      End
      Else
      Begin
        If LJsonObjectValue.GetValue('cpf') <> Nil Then
          Result.CPFCNPJDevedor := LJsonObjectValue.GetValue<String>('cpf');
        Result.TipoDoDevedor := '2';
      End;
      Result.NomeDevedor := LJsonObjectValue.GetValue<String>('nome');
    End;

    LJsonObjectValue := LJsonObject.GetValue('valor') as TJSONObject;
    Result.Valor := fStrToFloat(StringReplace(LJsonObjectValue.GetValue<String>('original'), '.', ',', []));

    Result.ChavePix := LJsonObject.GetValue<String>('chave');
    Result.AutoIncremChavePix := AAutoIncremPix;

    If LJsonObject.GetValue('solicitacaoPagador') <> Nil Then
      Result.SolicitacaoPagador := LJsonObject.GetValue<String>('solicitacaoPagador');

    If LJsonObject.GetValue('linkCitel') <> Nil Then
      Result.LinkCitel := LJsonObject.GetValue<String>('linkCitel');

    if AUtilizaTefScope then
      Result.UtilizaTefScope := 'S';
  Finally
    FreeAndNil(LJsonObject);
  End;

end;

class function TFuncoesPix.RetornaDadosDoRetornoPixAVistaBtgPactual(ARequisicao,
  ARetorno, AAutoIncremPix: String): TDadosRetornoPixAVista;
  Var
    LJsonObject,
    LJsonObjectRequisicao,
    LJsonObjectValue: TJSONObject;
begin
  LJsonObject := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;
  LJsonObjectRequisicao := TJSONObject.ParseJSONValue(ARequisicao) as TJSONObject;

  Result := TDadosRetornoPixAVista.Create;

  Result.JsonRetorno := ARetorno;
  Result.JsonRequisicao := ARequisicao;

  Result.Status := RetornaValorJson(LJsonObject, 'status');

  Result.DataCriacao := Now;
  Result.DataCriacaoString := FormatDateTime('yyyy/mm/dd hh:mm:ss', Result.DataCriacao);
  Result.Expiracao := RetornaValorJson(LJsonObjectRequisicao, 'expiresIn');

  Result.Txid := RetornaValorJson(LJsonObject, 'txId');
  Result.Revisao := '0';

  Result.TextoQrCode := RetornaValorJson(LJsonObject, 'emv');

  LJsonObjectValue := LJsonObject.GetValue('location') as TJSONObject;
  Result.OrderRef := RetornaValorJson(LJsonObjectValue, 'id');

  If LJsonObjectRequisicao.GetValue('payer') <> Nil Then
  Begin
    Result.TipoDoDevedor := '1';
    LJsonObjectValue := LJsonObjectRequisicao.GetValue('payer') as TJSONObject;

    Result.CPFCNPJDevedor := RetornaValorJson(LJsonObjectValue, 'taxId').Replace('-', EmptyStr)
                                                                        .Replace('/', EmptyStr)
                                                                        .Replace('.', EmptyStr)
                                                                        .Replace(' ', EmptyStr);
    If  Result.CPFCNPJDevedor.Length < 14 Then
      Result.TipoDoDevedor := '2';

    Result.NomeDevedor := RetornaValorJson(LJsonObjectValue, 'name');

    LJsonObjectValue.Free;
  End;

  LJsonObjectValue := LJsonObject.GetValue('amount') as TJSONObject;
  Result.Valor :=  fStrToFloat(RetornaValorJson(LJsonObjectValue, 'value').Replace('.', ','));
  LJsonObjectValue.Free;

  Result.ChavePix := RetornaValorJson(LJsonObject, 'pixKey');

  Result.LinkCitel := RetornaValorJson(LJsonObject, 'linkCitel');

  Result.AutoIncremChavePix := AAutoIncremPix;

  Result.UtilizaShipay := 'N';
end;

class function TFuncoesPix.RetornaDadosDoRetornoPixAVistaShipay(ARequisicao,
  ARetorno, AAutoIncremPix: String): TDadosRetornoPixAVista;
  Var
    LJsonObject,
    LJsonObjectRequisicao,
    LJsonObjectValue: TJSONObject;
begin
  Try
    Result := TDadosRetornoPixAVista.Create;

    Result.JsonRetorno := ARetorno;
    Result.JsonRequisicao := ARequisicao;

    LJsonObject := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;
    LJsonObjectRequisicao := TJSONObject.ParseJSONValue(ARequisicao) as TJSONObject;

    Result.Status := LJsonObject.GetValue<String>('status');

    Result.DataCriacao := Now;
    Result.DataCriacaoString := FormatDateTime('yyyy/mm/dd hh:mm:ss', Result.DataCriacao);
    Result.Expiracao := '3600';

    If LJsonObject.GetValue('expiration_date') <> Nil Then
    Begin
      Result.DataCriacao := TransformaDataRetornoTDateTime(LJsonObject.GetValue<String>('created_at'));
      Result.DataCriacaoString := LJsonObject.GetValue<String>('created_at');
      Result.Expiracao := SecondsBetween(Result.DataCriacao,
                                         TransformaDataRetornoTDateTime(LJsonObject.GetValue<String>('expiration_date'))).ToString;
    End;

    Result.Txid := LJsonObject.GetValue<String>('order_id');
    Result.Revisao := '0';

    Result.TextoQrCode := RetornaValorTextoQRCode(LJsonObject);

    Result.OrderRef := LJsonObjectRequisicao.GetValue<String>('order_ref');
    If LJsonObjectRequisicao.GetValue('buyer') <> Nil Then
    Begin
      Result.TipoDoDevedor := '1';
      LJsonObjectValue := LJsonObjectRequisicao.GetValue('buyer') as TJSONObject;

      Result.CPFCNPJDevedor := LJsonObjectValue.GetValue<String>('cpf_cnpj').Replace('-', EmptyStr)
                                                                            .Replace('/', EmptyStr)
                                                                            .Replace('.', EmptyStr)
                                                                            .Replace(' ', EmptyStr);
      If  Result.CPFCNPJDevedor.Length < 14 Then
        Result.TipoDoDevedor := '2';

      Result.NomeDevedor := LJsonObjectValue.GetValue<String>('name');

      LJsonObjectValue.Free;
    End;

    Result.Valor :=  fStrToFloat(StringReplace(LJsonObjectRequisicao.GetValue<String>('total'), '.', ',', []));

    If LJsonObject.GetValue('pix_dict_key') <> Nil Then
      Result.ChavePix := LJsonObject.GetValue<String>('pix_dict_key')
    Else If LJsonObjectRequisicao.GetValue('pix_dict_key') <> Nil Then
      Result.ChavePix := LJsonObjectRequisicao.GetValue<String>('pix_dict_key');

    If LJsonObject.GetValue('linkCitel') <> Nil Then
      Result.LinkCitel := LJsonObject.GetValue<String>('linkCitel');

    Result.AutoIncremChavePix := AAutoIncremPix;

    Result.UtilizaShipay := 'S';
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

class function TFuncoesPix.RetornaDadosDoRetornoPixConsulta(
  ARetorno: String; ARequisicao: String = ''): TDadosRetornoPixConsulta;
  Var
    LJsonObject,
    LJsonObjectValue: TJSONObject;
    LValor: String;
begin
  If Pos('"order_id"', ARetorno) +
     Pos('"external_id"', ARetorno) > 0 Then
  Begin
    Result := RetornaDadosDoRetornoPixConsultaShipay(ARetorno,
                                                     ARequisicao);

    Exit;
  End;

  If ARetorno.Contains('"pixKey":') Then
    Exit(RetornaDadosDoRetornoPixConsultaBtgPactual(ARetorno,
                                                    ARequisicao));

  Try
    Result := TDadosRetornoPixConsulta.Create;

    If ARetorno.IsEmpty Then
      Exit;

    Result.JsonRetorno := ARetorno;

    LJsonObject := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;

    If LJsonObject.GetValue('status') = Nil Then
      Exit;

    Result.Status := LJsonObject.GetValue<String>('status');

    LJsonObjectValue := LJsonObject.GetValue('calendario') as TJSONObject;
    Result.DataCriacao := TransformaDataRetornoTDateTime(LJsonObjectValue.GetValue<String>('criacao'));
    Result.DataCriacaoString := LJsonObjectValue.GetValue<String>('criacao');
    Result.Expiracao := LJsonObjectValue.GetValue<String>('expiracao');

    Result.Txid := LJsonObject.GetValue<String>('txid');
    Result.Revisao := LJsonObject.GetValue<String>('revisao');

    Result.LinkQrCode := RetornaValorLocation(LJsonObject);

    Result.TextoQrCode := RetornaValorTextoQRCode(LJsonObject);

    If LJsonObject.GetValue('devedor') <> Nil Then
    Begin
      LJsonObjectValue := LJsonObject.GetValue('devedor') as TJSONObject;

      If LJsonObjectValue.GetValue('cnpj') <> Nil Then
        Result.CPFCNPJDevedor := LJsonObjectValue.GetValue<String>('cnpj')
      Else If LJsonObjectValue.GetValue('cpf') <> Nil Then
        Result.CPFCNPJDevedor := LJsonObjectValue.GetValue<String>('cpf');

      If LJsonObjectValue.GetValue('nome') <> Nil Then
        Result.NomeDevedor := LJsonObjectValue.GetValue<String>('nome');
    End;

    LJsonObjectValue := LJsonObject.GetValue('valor') as TJSONObject;
    Result.Valor := fStrToFloat(StringReplace(LJsonObjectValue.GetValue<String>('original'), '.', ',', []));

    Result.ChavePix := LJsonObject.GetValue<String>('chave');

    If LJsonObject.GetValue('solicitacaoPagador') <> Nil Then
      Result.SolicitacaoPagador := LJsonObject.GetValue<String>('solicitacaoPagador');

    If LJsonObject.GetValue('linkCitel') <> Nil Then
      Result.LinkCitel := LJsonObject.GetValue<String>('linkCitel');

    LJsonObject.TryGetValue<String>('tefscope', LValor);
    If LValor.ToUpper = 'S' Then
      Result.UtilizaTefScope := 'S';

    RetornaDadosDoGrupoPix(LJsonObject, Result);
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

class function TFuncoesPix.RetornaDadosDoRetornoPixConsultaBtgPactual(ARetorno,
  ARequisicao: String): TDadosRetornoPixConsulta;
  Var
    LJsonObject,
    LJsonObjectRequisicao,
    LJsonObjectValue: TJSONObject;
begin
  Result := TDadosRetornoPixConsulta.Create;

  If ARetorno.IsEmpty Then
    Exit;

  Try
    Result.JsonRetorno := ARetorno;

    LJsonObject := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;
    LJsonObjectRequisicao := TJSONObject.ParseJSONValue(ARequisicao) as TJSONObject;

    If LJsonObject.GetValue('status') = Nil Then
      Exit;

    Result.Status := RetornaValorJson(LJsonObject, 'status');

    Result.DataCriacao := fNow;
    Result.DataCriacaoString := FormatDateTime('yyyy/mm/dd hh:mm:ss', Result.DataCriacao);
    Result.Expiracao := RetornaValorJson(LJsonObjectRequisicao, 'expiresIn');

    Result.Txid := RetornaValorJson(LJsonObject, 'txId');
    Result.UtilizaShipay := 'N';

    LJsonObjectValue := LJsonObject.GetValue('location') as TJSONObject;
    Result.OrderRef := RetornaValorJson(LJsonObjectValue, 'id');

    Result.Revisao := '0';

    Result.LinkQrCode := '';

    Result.TextoQrCode := RetornaValorTextoQRCode(LJsonObject);

    If LJsonObjectRequisicao.GetValue('payer') <> Nil Then
    Begin
      LJsonObjectValue := LJsonObjectRequisicao.GetValue('payer') as TJSONObject;

      Result.CPFCNPJDevedor := RetornaValorJson(LJsonObjectValue, 'taxId');

      Result.NomeDevedor := RetornaValorJson(LJsonObjectValue, 'name');

      LJsonObjectValue.Free;
    End;

    Result.ChavePix := RetornaValorJson(LJsonObjectRequisicao, 'pixKey');

    LJsonObjectValue := LJsonObjectRequisicao.GetValue('amount') as TJSONObject;

    Result.Valor := fStrToFloat(RetornaValorJson(LJsonObjectValue, 'original').Replace('.', ','));

    If LJsonObject.GetValue('paymentInfo') <> Nil Then
    Begin
      LJsonObjectValue := LJsonObject.GetValue('paymentInfo') as TJSONObject;

      Result.ValorPago := fStrToFloat(RetornaValorJson(LJsonObjectValue, 'paidAmount').Replace('.', ','));
      Result.EndToEndId := RetornaValorJson(LJsonObjectValue, 'endToEndId');

      Result.DataPagamento := TransformaDataRetornoTDateTime(RetornaValorJson(LJsonObjectValue, 'paymentDate'));
      Result.DataPagamentoString := RetornaValorJson(LJsonObjectValue, 'paymentDate');
    End;

    Result.DadosDevolucao := TList<TDadosRetornoPixDevolucao>.Create;
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

class function TFuncoesPix.RetornaDadosDoRetornoPixConsultaPeriodo(
  ARetorno: String): TDadosRetornoPixConsultaRecebidos;
  Var
    LJsonObject: TJSONObject;

    LJsonObjectValue: TJSONObject;
begin
  Try
    Result := TDadosRetornoPixConsultaRecebidos.Create;

    LJsonObject := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;

    Result.Status := 'CONCLUIDA';

    Result.DataPagamento := TransformaDataRetornoTDateTime(LJsonObject.GetValue<String>('horario'));
    
    Result.Txid := LJsonObject.GetValue<String>('txid');
    Result.EndToEndId := LJsonObject.GetValue<String>('endToEndId');

    If LJsonObject.GetValue('pagador') <> Nil Then
    Begin
      LJsonObjectValue := LJsonObject.GetValue('pagador') as TJSONObject;

      If LJsonObjectValue.GetValue('cnpj') <> Nil Then
        Result.CPFCNPJPagador := LJsonObjectValue.GetValue<String>('cnpj')
      Else
        Result.CPFCNPJPagador := LJsonObjectValue.GetValue<String>('cpf');

      Result.NomeDevedor := LJsonObjectValue.GetValue<String>('nome');
    End;

    Result.Valor := fStrToFloat(StringReplace(LJsonObject.GetValue<String>('valor'), '.', ',', []));

    Result.informacaoPagador := LJsonObject.GetValue<String>('infoPagador');
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

class function TFuncoesPix.RetornaDadosDoRetornoPixConsultaShipay(ARetorno,
  ARequisicao: String): TDadosRetornoPixConsulta;
  Var
    LJsonObject,
    LJsonObjectValue,
    LJsonObjectRequisicao: TJSONObject;

    LDadosDevolucao: TDadosRetornoPixDevolucao;
begin
  Result := TDadosRetornoPixConsulta.Create;

  If ARetorno.IsEmpty Then
    Exit;

  Try
    Result.JsonRetorno := ARetorno;

    LJsonObject := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;
    LJsonObjectRequisicao := TJSONObject.ParseJSONValue(ARequisicao) as TJSONObject;

    If LJsonObject.GetValue('status') = Nil Then
      Exit;

    Result.Status := LJsonObject.GetValue<String>('status');

    Result.DataCriacao := TransformaDataRetornoTDateTime(LJsonObject.GetValue<String>('created_at'));
    Result.DataCriacaoString := LJsonObject.GetValue<String>('created_at');
    Result.Expiracao := '3600';
    If LJsonObject.GetValue('expiration_date') <> Nil Then
      Result.Expiracao := SecondsBetween(Result.DataCriacao,
                                         TransformaDataRetornoTDateTime(LJsonObject.GetValue<String>('expiration_date'))).ToString;

    Result.Txid := LJsonObject.GetValue<String>('order_id');
    Result.OrderRef := LJsonObject.GetValue<String>('external_id');
    Result.UtilizaShipay := 'S';

    Result.Revisao := '0';

    Result.LinkQrCode := '';

    Result.TextoQrCode := RetornaValorTextoQRCode(LJsonObject);

    If LJsonObjectRequisicao.GetValue('buyer') <> Nil Then
    Begin
      LJsonObjectValue := LJsonObjectRequisicao.GetValue('buyer') as TJSONObject;

      Result.CPFCNPJDevedor := LJsonObjectValue.GetValue<String>('cpf_cnpj');

      Result.NomeDevedor := LJsonObjectValue.GetValue<String>('name');

      LJsonObjectValue.Free;
    End;

    Result.Valor := fStrToFloat(StringReplace(LJsonObject.GetValue<String>('total_order'), '.', ',', []));

    Result.ChavePix := LJsonObjectRequisicao.GetValue<String>('pix_dict_key');

    Result.ValorPago := fStrToFloat(StringReplace(LJsonObject.GetValue<String>('paid_amount'), '.', ',', []));

    If LJsonObject.GetValue('linkCitel') <> Nil Then
      Result.LinkCitel := LJsonObject.GetValue<String>('linkCitel');

    If LJsonObject.GetValue('payment_date') <> Nil Then
    Begin
      If LJsonObject.GetValue<String>('payment_date') <> '' Then
      Begin
        Result.EndToEndId := LJsonObject.GetValue<String>('wallet_payment_id');
        Result.DataPagamento := TransformaDataRetornoTDateTime(LJsonObject.GetValue<String>('payment_date'));
        Result.DataPagamentoString := LJsonObject.GetValue<String>('payment_date');
      End;
    End;

    Result.DadosDevolucao := TList<TDadosRetornoPixDevolucao>.Create;

    If Result.Status = 'refunded' Then
    Begin
      LDadosDevolucao := TDadosRetornoPixDevolucao.Create;

      LDadosDevolucao.Status := Result.Status;
      LDadosDevolucao.Id := Result.Txid;
      LDadosDevolucao.rtrId := Result.Txid;
      LDadosDevolucao.JsonRetorno := ARetorno;
      LDadosDevolucao.Valor := Result.ValorPago;
      LDadosDevolucao.DataSolicitacao := TransformaDataRetornoTDateTime(LJsonObject.GetValue<String>('updated_at'));
      LDadosDevolucao.DataDevolucao := TransformaDataRetornoTDateTime(LJsonObject.GetValue<String>('updated_at'));

      Result.DadosDevolucao.Add(LDadosDevolucao);
    End;
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

class function TFuncoesPix.RetornaDadosDoRetornoPixDevolucao(
  ARetorno: String; AUtilizaShipay: Boolean = False): TDadosRetornoPixDevolucao;
  Var
    LJsonObject: TJSONObject;

    LJsonObjectValue: TJSONObject;
begin
  Result := TDadosRetornoPixDevolucao.Create;

  If AUtilizaShipay Then
    Exit;

  Try
    LJsonObject := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;

    If LJsonObject.GetValue('status') = Nil Then
      Exit;

    Result.Status := LJsonObject.GetValue<string>('status');

    Result.Id := LJsonObject.GetValue<string>('id');
    Result.rtrId := LJsonObject.GetValue<string>('rtrId');

    If LJsonObject.GetValue('motivo') <> Nil Then
      Result.Motivo := LJsonObject.GetValue<string>('motivo');

    Result.JsonRetorno := ARetorno;

    Result.Valor := fStrToFloat(StringReplace(LJsonObject.GetValue<String>('valor'), '.', ',', []));;

    LJsonObjectValue := LJsonObject.GetValue('horario') as TJSONObject;

    Result.DataSolicitacao := TransformaDataRetornoTDateTime(LJsonObjectValue.GetValue<String>('solicitacao'));

    If LJsonObjectValue.GetValue('liquidacao') <> Nil Then
    Begin
      If Not Trim(LJsonObjectValue.GetValue<String>('liquidacao')).IsEmpty Then
        Result.DataDevolucao := TransformaDataRetornoTDateTime(LJsonObjectValue.GetValue<String>('liquidacao'));
    End;
  Finally
    FreeAndNil(LJsonObject);
  End;
end;

class function TFuncoesPix.RetornaDadosDoRetornoWebhook(
  ADadosRetorno, ADadosRetornoCertificado: String): TDadosWebhook;
  Var
    LResultado: String;
begin
  Result := TDadosWebhook.Create;

  If MatchStr(RetornaValorCampoJson('codigo', ADadosRetorno), ['200', '201']) Then
    LResultado := RetornaValorCampoJson('resultado', ADadosRetorno, True);

  Result.ClientId := RetornaValorCampoJson('clientId', LResultado);
  Result.ClientSecret := RetornaValorCampoJson('clientSecret', LResultado);
  Result.Status := RetornaValorCampoJson('acaoStatus', LResultado);
  Result.CNPJCliente := RetornaValorCampoJson('numeroCnpjCliente', LResultado);
  Result.MensagemRetorno := RetornaValorCampoJson('mensagemRetorno', LResultado);
  Result.DataStatus := RetornaValorCampoJson('dataHoraStatus', LResultado);

  Try
    If Not Result.DataStatus.IsEmpty Then
      Result.DataStatus := FormatDateTime('dd/mm/yyyy hh:mm:ss', TransformaDataRetornoTDateTime(Result.DataStatus));
  Except
    Result.DataStatus := '';
  End;

  If MatchStr(RetornaValorCampoJson('codigo', ADadosRetornoCertificado), ['200', '201']) Then
    LResultado := RetornaValorCampoJson('resultado', ADadosRetornoCertificado, True);

  Result.CertificadoCrt := RetornaValorCampoJson('certificadoCrt', LResultado);
  Result.CertificadoKey := RetornaValorCampoJson('certificadoKey', LResultado);
  Result.ValidadeCertificado := TransformaDataRetornoTDateTime(RetornaValorCampoJson('validadeCertificado', LResultado));
end;

class function TFuncoesPix.RetornaErro400Banco001(ARetornoErro: String): String;
  Var
    LJsonObject: TJSONObject;

    LJsonValue: TJsonValue;

    LJsonArray: TJsonArray;

    LCampoErro: String;
begin
  If ARetornoErro.IsEmpty Then
    Exit(EmptyStr);

  Try
    LJsonObject := TJSONObject.ParseJSONValue(ARetornoErro) as TJSONObject;
  Except
    Exit(EmptyStr);
  End;

  Try
    //Versão API 1
    If LJsonObject.GetValue('erros') <> Nil Then
    Begin
      LJsonArray := LJsonObject.GetValue('erros') As TJsonArray;

      For LJsonValue In LJsonArray Do
        Result := Result + LJsonValue.GetValue<string>('mensagem') + ' ';
    End
    Else //Versão API 2
    Begin
      LCampoErro := 'detail';
      If RetornaValorCampoJson(LCampoErro, ARetornoErro).IsEmpty Then
      Begin
        LCampoErro := 'message';
        If RetornaValorCampoJson(LCampoErro, ARetornoErro).IsEmpty Then
          Exit(EmptyStr);
      End;

      Result := RetornaValorCampoJson(LCampoErro, ARetornoErro);
      If RetornaValorCampoJson('code', ARetornoErro) = '301' Then
        Result := Result + ' Verifique se a chave Pix da conta está correta.';
    End;
  Finally
    LJsonObject.Free;
  End;
end;

class function TFuncoesPix.RetornaErro400PorBanco(ACodigoBanco,
  ARetornoErro: String): String;
  Var
    LJsonObject: TJSONObject;

    LJsonValue: TJsonValue;

    LJsonArray: TJsonArray;
begin
  Result := '';

  If RightStr(ACodigoBanco, 1) = 'S' Then
  Begin
    LJsonObject := TJSONObject.ParseJSONValue(ARetornoErro) as TJSONObject;

    If LJsonObject.GetValue('message') = Nil Then
      Exit;

    Result := Result + LJsonObject.GetValue<string>('message') + ' ';

    LJsonObject.Free;
  End
  Else If ACodigoBanco = '001' Then
    Result := RetornaErro400Banco001(ARetornoErro)
  Else If MatchStr(ACodigoBanco, ['237', '341', '748']) Then
  Begin
    LJsonObject := TJSONObject.ParseJSONValue(ARetornoErro) as TJSONObject;
    If LJsonObject = Nil Then
      Exit;

    Try
      If LJsonObject.GetValue('violacoes') = Nil Then
      Begin
        If LJsonObject.GetValue('message') <> Nil Then
        Begin
          Result := LJsonObject.GetValue<string>('message');

          If Result.Contains('Invalid Scope') Then
            Result := 'As credenciais utilizadas não permitem a utilização desse recurso.' + #13 +
                      'Verifique se as credenciais estão corretas ou se a versão da API corresponde a credencial utilizada.';
        End;

        Exit;
      End;

      LJsonArray := LJsonObject.GetValue('violacoes') As TJsonArray;

      For LJsonValue In LJsonArray Do
        Result := Result + LJsonValue.GetValue<string>('razao') + ' ';
    Finally
      LJsonObject.Free;
    End;
  End
  Else If ACodigoBanco = '756' Then
  Begin
    Try
      LJsonObject := TJSONObject.ParseJSONValue(ARetornoErro) as TJSONObject;

      If LJsonObject.GetValue('status') = Nil Then
        Exit;

      Result := LJsonObject.GetValue<string>('detail') + ' ';

      LJsonObject.Free;
    Except
      Result := ARetornoErro;
    End;
  End
  Else If ACodigoBanco = '033' Then
  Begin
    LJsonObject := TJSONObject.ParseJSONValue(ARetornoErro) as TJSONObject;

    If LJsonObject.GetValue('httpStatus') = Nil Then
      Exit;

    Result := LJsonObject.GetValue<string>('details') + ' ';

    LJsonObject.Free;
  End;
end;

class function TFuncoesPix.RetornaErroPeloCodigo(ACodigoBanco, ACodigoErro,
  AMensagemErro, ARetornoErro: String): String;
  Var
    LJsonObject: TJSONObject;

    LJsonValue: TJsonValue;

    LJsonArray: TJsonArray;
begin
  Result := AMensagemErro;

  If ACodigoErro = '400' Then
    Result := RetornaErro400PorBanco(ACodigoBanco,
                                     ARetornoErro)

  Else If MatchStr(ACodigoErro, ['403', '401']) Then
    Result := 'Verifique as chaves de autorização e certificados Pix da conta bancária.'
  Else If ACodigoErro = '404' Then
  Begin
    Try
      LJsonObject := TJSONObject.ParseJSONValue(ARetornoErro) as TJSONObject;

      If LJsonObject.GetValue('status') <> Nil Then
      Begin
        If LJsonObject.GetValue('violacoes') <> Nil Then
        Begin
          LJsonArray := LJsonObject.GetValue('violacoes') as TJsonArray;

          Result := '';
          For LJsonValue In LJsonArray Do
            Result := Result + LJsonValue.GetValue<string>('razao') + '. ';
        End
        Else If RetornaValorCampoJson('detail', ARetornoErro) <> EmptyStr Then
          Result := RetornaValorCampoJson('detail', ARetornoErro);
      End;

      LJsonObject.Free;

    Except
      Result := AMensagemErro;
    End;
  End

  Else If ACodigoErro = '409' Then
  Begin
    Try
      LJsonObject := TJSONObject.ParseJSONValue(ARetornoErro) as TJSONObject;

      If LJsonObject.GetValue('status') <> Nil Then
        Result := LJsonObject.GetValue<string>('detail') + '. ';

      LJsonObject.Free;

    Except
      Result := AMensagemErro;
    End;
  End

  Else If ACodigoErro = '500' Then
  Begin
    Result := 'Erro interno da API do banco. Esse pode estar com alguma instabilidade.' + #13 +
              'Tente novamente mais tarde.';

    If AMensagemErro.ToLower.Contains('certificado') Then
      Result := AMensagemErro;
  End
  Else If ACodigoErro = '504' Then
    Result := 'Tempo esgotado ao acesso a API do banco. Esse pode estar com alguma instabilidade.' + #13 +
              'Tente novamente mais tarde.';
end;

class function TFuncoesPix.RetornaJsonDadosRequisicao(
  ADadosRequisicao: TDadosRequisicaoPixAVista; ACodigoBanco: String = ''): String;
  Var
    LContador: Integer;
begin
  If ADadosRequisicao.UtilizaShipay.Equals('S') Then
  Begin
    Result := RetornaJsonDadosRequisicaoShipay(ADadosRequisicao);

    Exit;
  End;

  If ACodigoBanco.Equals('208') Then
    Exit(TFuncoesPix.RetornaJsonDadosRequisicaoBtgPactual(ADadosRequisicao));

  Result := '{' + #13;

  Result := Result + '  "calendario": {' + #13;
  If ACodigoBanco <> '756' Then
    Result := Result + '    "expiracao": "' + ADadosRequisicao.Expiracao.ToString + '"' + #13
  Else
    Result := Result + '    "expiracao": ' + ADadosRequisicao.Expiracao.ToString + #13;
  Result := Result + '  },' + #13;

  If Not ADadosRequisicao.NomeDevedor.IsEmpty Then
  Begin
    Result := Result + '  "devedor": {' + #13;
    If ADadosRequisicao.TipoDevedor = '1' Then
      Result := Result + '    "cnpj": "' + ADadosRequisicao.CPFCNPJDevedor + '",' + #13
    Else
      Result := Result + '    "cpf": "' + ADadosRequisicao.CPFCNPJDevedor + '",' + #13;
    Result := Result + '    "nome": "' + LeftStr(fTiraEnter(fTiraCaracEspeciais(ADadosRequisicao.NomeDevedor)), 200) + '"' + #13;
    Result := Result + '  },' + #13;
  End;

  Result := Result + '  "valor": {' + #13;
  Result := Result + '    "original": "' + ADadosRequisicao.Valor + '"' + #13;
  Result := Result + '  },' + #13;

  Result := Result + '    "chave": "' + ADadosRequisicao.ChavePix + '",' + #13;
  Result := Result + '    "solicitacaoPagador": "' + LeftStr(ADadosRequisicao.SolicitacaoPagador, 140) + '"';

  If Not ADadosRequisicao.InformacoesAdicionais[0][0].IsEmpty Then
  Begin
    Result := Result + ',' + #13;

    Result := Result + '  "infoAdicionais": [' + #13;

    For LContador := 0 To 8 Do
    Begin
      If ADadosRequisicao.InformacoesAdicionais[LContador][0].IsEmpty Then
        Break;

      Result := Result + '    {' + #13;
      Result := Result + '      "nome": "' + LeftStr(ADadosRequisicao.InformacoesAdicionais[LContador][0], 50) + '",' + #13;
      Result := Result + '      "valor": "' + LeftStr(ADadosRequisicao.InformacoesAdicionais[LContador][1], 200) + '"' + #13;
      Result := Result + '    },' + #13;
    End;


    Result := LeftStr(Result, Result.Length - 2) + '  ]';
  End;

  Result := Result + #13 + '}';
end;

class function TFuncoesPix.RetornaJsonDadosRequisicaoBtgPactual(
  ADadosRequisicao: TDadosRequisicaoPixAVista): String;
  Var
    LJsonResult,
    LJsonAmount,
    LJsonPayer: TJsonObject;
begin
  LJsonResult := TJsonObject.Create;
  LJsonAmount := TJsonObject.Create;
  LJsonPayer := TJsonObject.Create;

  Try
    LJsonResult.AddPair('pixKey', ADadosRequisicao.ChavePix);
    LJsonResult.AddPair('expiresIn', TJsonNumber.Create(ADadosRequisicao.Expiracao));

    LJsonAmount.AddPair('original', TJsonNumber.Create(ADadosRequisicao.Valor));
    LJsonAmount.AddPair('allowCustomerChangeValue', TJSONBool.Create(False));

    LJsonResult.AddPair('amount', LJsonAmount);

    LJsonResult.AddPair('displayText', LeftStr(ADadosRequisicao.SolicitacaoPagador, 140));

    If Not ADadosRequisicao.NomeDevedor.IsEmpty Then
    Begin
      LJsonPayer.AddPair('name',  fTiraEnter(fTiraCaracEspeciais(ADadosRequisicao.NomeDevedor)));
      LJsonPayer.AddPair('taxId',  ADadosRequisicao.CPFCNPJDevedor);
      LJsonResult.AddPair('payer', LJsonPayer);
    End;

    Result := LJsonResult.ToJSON;

    If Not Result.Contains('"pixKey":') Then
      Result := '{"pixKey": "", ' + RightStr(Result, Result.Length - 1);
  Finally
    FreeAndNil(LJsonResult);
  End;
end;

class function TFuncoesPix.RetornaJsonDadosRequisicaoBtgPactual(
  ADadosRequisicao: String): String;
  Var
    LJsonObject,
    LJsonValue,

    LJsonResult,
    LJsonAmount,
    LJsonPayer: TJsonObject;
begin
  LJsonObject := TJSONObject.ParseJSONValue(ADadosRequisicao) as TJSONObject;

  LJsonValue := LJsonObject.GetValue('calendario') as TJSONObject;

  LJsonResult := TJsonObject.Create;
  LJsonAmount := TJsonObject.Create;
  LJsonPayer := TJsonObject.Create;

  Try
    LJsonResult.AddPair('pixKey', RetornaValorJson(LJsonObject, 'chave'));
    LJsonResult.AddPair('expiresIn', TJsonNumber.Create(RetornaValorJson(LJsonValue, 'expiracao')));

    LJsonValue := LJsonObject.GetValue('valor') as TJSONObject;

    LJsonAmount.AddPair('original', TJsonNumber.Create(RetornaValorJson(LJsonValue, 'original')));
    LJsonAmount.AddPair('allowCustomerChangeValue', TJSONBool.Create(False));

    LJsonResult.AddPair('amount', LJsonAmount);

    LJsonResult.AddPair('displayText', LeftStr(RetornaValorJson(LJsonObject, 'solicitacaoPagador'), 140));

    If LJsonObject.GetValue('devedor') <> Nil Then
    Begin
      LJsonValue := LJsonObject.GetValue('devedor') as TJSONObject;

      LJsonPayer.AddPair('name',  RetornaValorJson(LJsonValue, 'nome'));

      If Not RetornaValorJson(LJsonValue, 'cpf').IsEmpty Then
        LJsonPayer.AddPair('taxId',  RetornaValorJson(LJsonValue, 'cpf'))
      Else
        LJsonPayer.AddPair('taxId',  RetornaValorJson(LJsonValue, 'cnpj'));
      LJsonResult.AddPair('payer', LJsonPayer);
    End;

    Result := LJsonResult.ToJSON;

    If Not Result.Contains('"pixKey":') Then
      Result := '{"pixKey": ""' + RightStr(Result, Result.Length - 1);
  Finally
    FreeAndNil(LJsonResult);

    FreeAndNil(LJsonObject);
  End;
end;

class function TFuncoesPix.RetornaJsonDadosRequisicaoShipay(
  ADadosRequisicao: TDadosRequisicaoPixAVista): String;
begin
  Result := '{' + #13;


  If Not ADadosRequisicao.NomeDevedor.IsEmpty Then
    Result := Result + '  "buyer": {' + #13 +
                       '            "cpf_cnpj": "' + ADadosRequisicao.CPFCNPJDevedor + '", ' + #13 +
                       '            "name": "' + fTiraEnter(fTiraCaracEspeciais(ADadosRequisicao.NomeDevedor)) + '"' + #13 +
                       '  },';

  Result := Result + '  "callback_url": null, ' + #13 +
                     '  "order_ref": "[ORDREF]", ' + #13 +
                     '  "pix_dict_key": "'+ ADadosRequisicao.ChavePix + '", ' + #13 +
                     '  "total": ' + ADadosRequisicao.Valor + ', ' + #13 +
                     '  "wallet": "shipay-pagador", ';

  If ADadosRequisicao.TipoCobranca.ToLowerInvariant = 'variavel' Then
  Begin
    Result := Result + '  "expiration": ' + ADadosRequisicao.Expiracao.ToString + ', ' + #13;

    Result := Result.Replace('"callback_url": null' , '"callback_url": "https://webhook.com"');

    Result := Result.Replace('"wallet": "shipay-pagador"' , '"wallet": "pix"');
  End;

  Result := Result + '  "items": [';

  Result := Result + '    {' + #13;
  Result := Result + '      "item_title": "' + LeftStr(ADadosRequisicao.TextoItemShipay, 50) + '",' + #13;
  Result := Result + '      "unit_price": ' + ADadosRequisicao.Valor + ',' + #13;
  Result := Result + '      "quantity": 1' + #13;
  Result := Result + '    }' + #13;

  Result := Result + ']';

  Result := Result + #13 + '}';
End;

class function TFuncoesPix.RetornaLinkCitel(AChaveLink: String;
  AHomologacao: String = ''): String;
begin
  If AChaveLink.IsEmpty Then
    Exit('');

  Result := 'https://pix.citelsoftware.com.br/' + AChaveLink;
end;

class function TFuncoesPix.RetornaMensagemErroRequisicao(
  ARetorno: String): String;
  Var
    LJsonObject: TJSONObject;
begin
  Result := '';

  If ARetorno.IsEmpty Then
    Exit;

  If RetornoErro503ComPaginaHTML(ARetorno) Then
    Exit('Código 503 - O servidor do banco pode estar passando por manutenção ou com sobrecarga.' + #13 +
         '             Tente novamente mais tarde.');

  Try
    LJsonObject := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;

    If LJsonObject = Nil Then
      Exit;

    If LJsonObject.GetValue('erro') = Nil Then
      Exit;

    If  LJsonObject.GetValue<String>('erro') <> 'sim' Then
      Exit;

    Result := CorrigeDadosRetorno(LJsonObject.GetValue<String>('mensagem'));
  Finally
    If Assigned(LJsonObject) Then
      FreeAndNil(LJsonObject);
  End;
end;

class function TFuncoesPix.RetornaOrderRefShipay(ARequisicao: String): String;
  Var
    LJsonObject: TJSONObject;
begin
  Result := '';

  If ARequisicao.IsEmpty Then
    Exit;

  Try
    LJsonObject := TJSONObject.ParseJSONValue(ARequisicao) as TJSONObject;

    If LJsonObject = Nil Then
      Exit;

    If LJsonObject.GetValue('order_ref') = Nil Then
      Exit;

    Result := LJsonObject.GetValue<String>('order_ref');
  Finally
    If Assigned(LJsonObject) Then
      FreeAndNil(LJsonObject);
  End;
end;

class function TFuncoesPix.RetornaResultadoRequisicao(ACodigoStatus,
  ARetornoStatus: String): String;
  Var
    LJsonObject: TJSonObject;
begin
  Try
    LJsonObject := TJSONObject.ParseJSONValue(ARetornoStatus) as TJSONObject;

    If LJsonObject = Nil Then
      Raise Exception.Create('');

    Result := '{"codigo": "' + ACodigoStatus + '", ' +
              ' "resultado": ' + ARetornoStatus.Trim + '}';

    If RetornaValorJson(LJsonObject, 'codigo').Equals('992') Then
      Result := ARetornoStatus.Trim;

    LJsonObject.Free;
  Except
    If ACodigoStatus = '500' Then
    Begin
      If ARetornoStatus.Contains('alert bad certificate') Then
        ARetornoStatus := 'Erro na validação do certificado na API, pois esse é inválido.' + #13 +
                          'Verifique se o certificado está cadastrado na Conta Bancária e se esse está vinculado a API.'
      Else If ARetornoStatus.Contains('alert certificate unknown') Then
        ARetornoStatus := 'Erro na validação do certificado na API, pois esse não é reconhecido pela API.' + #13 +
                          'Verifique se o certificado que está cadastrado na Conta Bancária está vinculado a API.';
    End;

    Result := '{"codigo": "' + ACodigoStatus + '", ' +
              ' "resultado": "' + ARetornoStatus.Trim + '"}';
  End;
end;

class function TFuncoesPix.RetornaValorCampoJson(ACampo,
  ATextoJson: String; ACampoObjetoJson: Boolean = False): String;
  Var
    LJsonObject: TJSONObject;
begin
  Result := '';

  If MatchStr(ATextoJson, [EmptyStr, '[]', '{}']) Then
    Exit;

  Try
    LJsonObject := TJSONObject.ParseJSONValue(ATextoJson) as TJSONObject;

    If LJsonObject.GetValue(ACampo) <> Nil Then
    Begin
      If ACampoObjetoJson Then
      Begin
        Try
          Result := LJsonObject.GetValue(ACampo).ToJSON;

          Exit;
        Except
          Result := LJsonObject.GetValue<string>(ACampo);
        End;
      End;

      Result := LJsonObject.GetValue<string>(ACampo);
    End;

    FreeAndNil(LJsonObject);
  Except
    Exit;
  End;
end;

class function TFuncoesPix.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := EmptyStr;

  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

class function TFuncoesPix.RetornaValorLocation(
  AJsonObject: TJsonObject): String;
begin
  Result := '';

  If AJsonObject.GetValue('location') <> Nil Then
    Result := AJsonObject.GetValue<String>('location');

  If AJsonObject.GetValue('payloadURL') <> Nil Then
    Result := AJsonObject.GetValue<String>('payloadURL');
end;

class function TFuncoesPix.RetornaValorTextoQRCode(
  AJsonObject: TJsonObject): String;
begin
  Result := '';

  If AJsonObject.GetValue('textoImagemQRcode') <> Nil Then
    Result := AJsonObject.GetValue<String>('textoImagemQRcode');

  If AJsonObject.GetValue('pixCopiaECola') <> Nil Then
    Result := AJsonObject.GetValue<String>('pixCopiaECola');

  If AJsonObject.GetValue('brcode') <> Nil Then
    Result := AJsonObject.GetValue<String>('brcode');

  If AJsonObject.GetValue('qr_code_text') <> Nil Then
    Result := AJsonObject.GetValue<String>('qr_code_text');
end;

class function TFuncoesPix.RetornoErro503ComPaginaHTML(
  ARetorno: String): Boolean;
begin
  Result := ARetorno.Contains('{"codigo": "503"');
  If Result Then
    Result := ARetorno.Contains('resultado": "<html>');
end;

class function TFuncoesPix.TransformaDataRetornoTDateTime(
  ADataRetornoPix: String): TDateTime;
  Var
    LDataString: String;
begin
  LDataString := Concat(Copy(ADataRetornoPix, 9,2), '/',
                        Copy(ADataRetornoPix, 6,2), '/',
                        Copy(ADataRetornoPix, 1,4), ' ',
                        Copy(ADataRetornoPix, 12,8));

  Try
    Result := StrToDateTime(LDataString);
  Except
    LDataString := Concat(Copy(ADataRetornoPix, 6,2), '/',
                          TransformaMesNumerico(Copy(ADataRetornoPix, 9,3)), '/',
                          Copy(ADataRetornoPix, 13,4), ' ',
                          Copy(ADataRetornoPix, 18,8));

    Result := StrToDateTime(LDataString);
  End;
end;

class function TFuncoesPix.TransformaMesNumerico(AMesString: String): String;
  Var
    LPosicao: TStringList;
begin
  LPosicao := TStringList.Create;

  Try
    LPosicao.Add('JAN');
    LPosicao.Add('FEB');
    LPosicao.Add('MAR');
    LPosicao.Add('APR');
    LPosicao.Add('MAY');
    LPosicao.Add('JUN');
    LPosicao.Add('JUL');
    LPosicao.Add('AUG');
    LPosicao.Add('SEP');
    LPosicao.Add('OCT');
    LPosicao.Add('NOV');
    LPosicao.Add('DEC');

    Result := (LPosicao.IndexOf(AMesString.ToUpperInvariant) + 1).ToString;

    If Result.Length = 1 Then
      Result := '0' + Result;
  Finally
    FreeAndNil(LPosicao);
  End;
end;

class function TFuncoesPix.TransformaTDateTimeEmStringZulu(
  ADataHora: TDateTime): String;
begin
  Result := FormatDateTime('yyyy-mm-dd hh:mm:ss.zzz', ADataHora);

  Result := LeftStr(Result, 10) + 'T' + RightStr(Result, Result.Length - 11) + 'Z';
end;

class function TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(
  ARegistroPix: TDadosRetornoPixConsulta): Boolean;
begin
  Result := MatchStr(ARegistroPix.Status, STATUS_PIX_PAGO);

  If Result Then
    Result := ARegistroPix.ValorPago > 0;
end;

{http://www.activedelphi.com.br/forum/viewtopic.php?t=90470&sid=fdb97ce2cb097731b9d6dc13ce32bd9c}
class function TFuncoesPix.CRC16CCITT(texto: string): WORD;
const
  polynomial = $1021;
var
  crc: WORD;
  i, j: Integer;
  b: Byte;
  bit, c15: Boolean;
begin
  crc := $FFFF;
  for i := 1 to length(texto) do
  begin
    b := Byte(texto[i]);
    for j := 0 to 7 do
    begin
      bit := (((b shr (7 - j)) and 1) = 1);
      c15 := (((crc shr 15) and 1) = 1);
      crc := crc shl 1;
      if (c15 xor bit) then
        crc := crc xor polynomial;
    end;
  end;
  Result := crc and $FFFF;
end;

class function TFuncoesPix.GeraJsonErro(ACodigoBanco, AErro,
  AExceptionMessage: String): String;
begin
  If AErro.IsEmpty Then
    Result := '';

  Result := '{' +
            '  "erro": "sim", ' +
            '  "mensagem": "' + AErro.Replace('"', EmptyStr) + fTiraCaracEspeciais(AExceptionMessage) + '" ' +
            '}';
end;

class procedure TFuncoesPix.LiberaLibIntegracaoPix(var AHandlePix: THandle);
begin
{$IFDEF LINUX}
{$ELSE}
  If AHandlePix = 0 Then
    Exit;

  FreeLibrary(AHandlePix);
  AHandlePix := 0;
{$ENDIF}
end;

end.
