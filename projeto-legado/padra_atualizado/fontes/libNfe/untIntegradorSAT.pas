unit untIntegradorSAT;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Windows,
{$ENDIF}
  untIntegradorSATXML, Classes, SysUtils, DateUtils, Math, untInterfacesIntegradorSAT;

type
  TIntegradorSAT = Class(TInterfacedObject, IIntegradorSAT)
  private
    objIntSATXML : TIntegradorSATXML;
    FstrPastaInput : String;
    FstrPastaOutput : String;
    FintTimeout : Integer;
    FstrComponente : String;
    function fEnviaComando(intNumeroSessao: Integer; strNome, strComando: String): String;
    function fAguardaArquivoResposta(intNumeroSessao: Integer; strNome: String): String;
    procedure pAddParam(intIndex: Integer; strNome: String; strValor: AnsiString; tipoPar: TTipoParametroIntegrador; ArrRecPar: TParametrosIntegrador; blnCData: Boolean = False);
  public
    function fEnviarPagamento(intNumeroSessao: Integer; recVFPeEnvioPagto: TrecVFPeEnvioPagto): TrecVFPeRespostaSolicitacaoPagto;
    function fEnviarDadosVenda(intNumeroSessao: Integer; strCodAtivacao: AnsiString; strNumDoc, strVendaXML: AnsiString): String;
    function fCancelarUltimaVenda(intNumeroSessao: Integer; strCodAtivacao, strChave, strDadosCancelamento: AnsiString): String;
    function fRespostaFiscal(intNumeroSessao, idFila: Integer; strChaveAcessoValidador, strChaveAcesso, strNsu, strNumeroAprovacao, strBandeira, strAdquirente, strCnpj, strImpressaoFiscal, strNumeroDocumento: String): String;
    function fVerificarStatusValidador(intNumeroSessao, idFila: Integer; strChaveAcessoValidador, strCnpj: String): TrecVFPeRespostaPagtoRealizado;
    function fEnviarStatusPagamento(intNumeroSessao, intIdFila: Integer; strChaveAcessoValidador, strCodigoAutorizacao,
      strBin, strDonoCartao, strDataExpiracao, strInstituicaoFinanceira, strParcelas, strCodigoPagto, strTipo, strUltimosQuatroDigitos: String; fltValorPagto: Double): String;
    function fConsultarMFe(intNumeroSessao: Integer): String;
    function fSatAtivo(intNumeroSessao: Integer; var strMsgInt: String): Boolean;
    constructor Create(strPastaInput, strPastaOutput: String; intTimeOut: Integer; strComponente: String);
    destructor Destroy; override;
  End;

implementation

{ TIntegradorSAT }

uses untIntegradorSATLOG, untUtil;

constructor TIntegradorSAT.Create(strPastaInput, strPastaOutput: String; intTimeOut: Integer; strComponente: String);
begin
  FstrPastaInput := strPastaInput;
  FstrPastaOutput := strPastaOutput;
  FintTimeOut := intTimeOut;
  FstrComponente := strComponente;
  objIntSATXML := TIntegradorSATXML.Create;
end;

destructor TIntegradorSAT.Destroy;
begin
  FreeAndNil(objIntSATXML);
  inherited;
end;

function TIntegradorSAT.fCancelarUltimaVenda(intNumeroSessao: Integer;
  strCodAtivacao, strChave, strDadosCancelamento: AnsiString): String;
  Var
    ArrRecPar: TParametrosIntegrador;
    ArrRecCon: TParametrosIntegrador;
begin
  SetLength(ArrRecCon, 0);

  SetLength(ArrRecPar, 4);
  pAddParam(0, 'numeroSessao', AnsiString(IntToStr(intNumeroSessao)), tpiInt, ArrRecPar);
  pAddParam(1, 'codigoDeAtivacao', strCodAtivacao, tpiString, ArrRecPar);
  pAddParam(2, 'chave', strChave, tpiString, ArrRecPar);
  pAddParam(3, 'dadosCancelamento', strDadosCancelamento, tpiString, ArrRecPar, True);

  Result := fEnviaComando(intNumeroSessao,
                          'CancelarUltimaVenda',
                          objIntSATXML.fGerarXML('CancelarUltimaVenda', IntToStr(intNumeroSessao), ArrRecPar, FstrComponente, ArrRecCon)
                          );

  Result := objIntSATXML.fProcessaRespostaSucesso(Result);
end;

function TIntegradorSAT.fSatAtivo(intNumeroSessao: Integer; var strMsgInt: String): Boolean;
Begin
  Try
    strMsgInt := fConsultarMFe(intNumeroSessao);
    Result := (Pos('em operacao', fRemoveAcento(strMsgInt)) > 0);
  Except
    On E: Exception Do
    Begin
      Result := False;
      If fEmptyStr(strMsgInt) Then
        strMsgInt := E.Message
      Else
        strMsgInt := strMsgInt + sLineBreak + E.Message;
    End;
  End;
End;

function TIntegradorSAT.fConsultarMFe(intNumeroSessao: Integer): String;
  Var
    ArrRecPar: TParametrosIntegrador;
    ArrRecCon: TParametrosIntegrador;
begin
  SetLength(ArrRecCon, 0);

  SetLength(ArrRecPar, 1);
  pAddParam(0, 'numeroSessao', AnsiString(IntToStr(intNumeroSessao)), tpiInt, ArrRecPar);

  Result := fEnviaComando(intNumeroSessao,
                          'ConsultarMFe',
                          objIntSATXML.fGerarXML('ConsultarMFe', IntToStr(intNumeroSessao), ArrRecPar, FstrComponente, ArrRecCon)
                          );

  Result := objIntSATXML.fProcessaRespostaSucesso(Result);
end;

function TIntegradorSAT.fEnviarDadosVenda(intNumeroSessao: Integer;
  strCodAtivacao, strNumDoc, strVendaXML: AnsiString): String;
  Var
    ArrRecPar: TParametrosIntegrador;
    ArrRecCon: TParametrosIntegrador;
begin
  SetLength(ArrRecCon, 0);

  SetLength(ArrRecPar, 4);
  pAddParam(0, 'numeroSessao', AnsiString(IntToStr(intNumeroSessao)), tpiInt, ArrRecPar);
  pAddParam(1, 'codigoDeAtivacao', strCodAtivacao, tpiString, ArrRecPar);
  pAddParam(2, 'dadosVenda', strVendaXML, tpiString, ArrRecPar, True);
  pAddParam(3, 'nrDocumento', strNumDoc, tpiString, ArrRecPar);

  Result := fEnviaComando(intNumeroSessao,
                          'EnviarDadosVenda',
                          objIntSATXML.fGerarXML('EnviarDadosVenda', IntToStr(intNumeroSessao), ArrRecPar, FstrComponente, ArrRecCon)
                          );

  Result := objIntSATXML.fProcessaRespostaSucesso(Result);
end;

function TIntegradorSAT.fEnviarPagamento(intNumeroSessao: Integer;
                                         recVFPeEnvioPagto: TrecVFPeEnvioPagto): TrecVFPeRespostaSolicitacaoPagto;
  Var
    ArrRecPar: TParametrosIntegrador;
    ArrRecCon: TParametrosIntegrador;
    strXMLResposta : String;
begin
  With recVFPeEnvioPagto Do
  Begin
    SetLength(ArrRecCon, 1);
    pAddParam(0, 'chaveAcessoValidador', AnsiString(strChaveAcessoValidador), tpiInt, ArrRecCon);

    // ---------------------------------------------------------------------------

    SetLength(ArrRecPar, 35);

    pAddParam(00, 'ChaveRequisicao', AnsiString(strChaveRequisicao), tpiGuid, ArrRecPar);
    pAddParam(01, 'Estabelecimento', AnsiString(strEstabelecimento), tpiString, ArrRecPar);
    pAddParam(02, 'SerialPos', AnsiString(strSerialPos), tpiString, ArrRecPar);
    pAddParam(03, 'Cnpj', AnsiString(strCnpjContrib), tpiString, ArrRecPar);
    pAddParam(04, 'ValorOperacaoSujeitaIcms', AnsiString(fFloatToStrVirgula(fltValorOperacaoSujeitaIcms, 12, 2)), tpiDecimal, ArrRecPar);
    pAddParam(05, 'ValorTotalVenda', AnsiString(fFloatToStrVirgula(fltValorTotalVenda, 12, 2)), tpiDecimal, ArrRecPar);
    pAddParam(06, 'ValorTransacao', AnsiString(fFloatToStrVirgula(fltValorTransacao, 12, 2)), tpiDecimal, ArrRecPar);
    pAddParam(07, 'CodigoLoja', AnsiString(strCodigoLoja), tpiString, ArrRecPar);
    pAddParam(08, 'TipoEndereco', '', tpiString, ArrRecPar);
    pAddParam(09, 'CodigoPdv', AnsiString(strCodigoPDV), tpiString, ArrRecPar);
    pAddParam(10, 'ReferenciaItem', '', tpiString, ArrRecPar);
    pAddParam(11, 'CPF', AnsiString(strCpfCli), tpiString, ArrRecPar);
    pAddParam(12, 'Cidade', AnsiString(strCidadeCli), tpiString, ArrRecPar);
    pAddParam(13, 'Nome', '', tpiString, ArrRecPar);
    pAddParam(14, 'Complemento', '', tpiString, ArrRecPar);
    pAddParam(15, 'QuantidadeParcelas', AnsiString(IntToStr(intQtdParcelas)), tpiInt, ArrRecPar);
    pAddParam(16, 'Quantidade', AnsiString(IntToStr(intQtdItens)), tpiInt, ArrRecPar);
    pAddParam(17, 'Pais', 'BRASIL', tpiString, ArrRecPar);
    pAddParam(18, 'IcmsBase', AnsiString(fFloatToStrVirgula(fltIcmsBase, 12, 2)), tpiDecimal, ArrRecPar);
    pAddParam(19, 'DataTransacao', AnsiString(FormatDateTime('dd/mm/yyyy', dtaDtaTransacao)), tpiDateTime, ArrRecPar);
    pAddParam(20, 'ValorProduto', AnsiString(fFloatToStrVirgula(fltValorTotalProduto, 12, 2)), tpiDecimal, ArrRecPar);
    pAddParam(21, 'Celular', AnsiString(strCelular), tpiString, ArrRecPar);
    pAddParam(22, 'Bairro', AnsiString(strBairro), tpiString, ArrRecPar);
    pAddParam(23, 'ReferenciaTransacao', '', tpiString, ArrRecPar);
    pAddParam(24, 'ValorProdutoEmCentavos', AnsiString(fFloatToStrVirgula(fltValorUnitarioProdutoEmCentavos, 12, 2)), tpiDecimal, ArrRecPar);
    pAddParam(25, 'Numero', '', tpiString, ArrRecPar);
    pAddParam(26, 'Nome', AnsiString(strNomeDoCliente), tpiString, ArrRecPar);
    pAddParam(27, 'Estado', AnsiString(strEstado), tpiString, ArrRecPar);
    pAddParam(28, 'Rua', AnsiString(strEndereco), tpiString, ArrRecPar);
    pAddParam(29, 'CEP', AnsiString(strCep), tpiString, ArrRecPar);
    pAddParam(30, 'OrigemPagamento', AnsiString(strOrigemPagto), tpiString, ArrRecPar);
    pAddParam(31, 'HabilitarMultiplosPagamentos', 'false', tpiBool, ArrRecPar);
    pAddParam(32, 'HabilitarControleAntiFraude', 'false', tpiBool, ArrRecPar);
    pAddParam(33, 'CodigoMoeda', 'BRL', tpiString, ArrRecPar);
    pAddParam(34, 'EmitirCupomNFCE', 'false', tpiBool, ArrRecPar);
  End;

  strXMLResposta := fEnviaComando(intNumeroSessao,
                                  'EnviarPagamento',
                                  objIntSATXML.fGerarXML('EnviarPagamento', IntToStr(intNumeroSessao), ArrRecPar, 'VFP-e', ArrRecCon)
                                  );

  Result := objIntSATXML.fProcessaRespostaSolicitacaoPagamento(strXMLResposta);
end;

function TIntegradorSAT.fEnviarStatusPagamento(
  intNumeroSessao, intIdFila: Integer; strChaveAcessoValidador, strCodigoAutorizacao, strBin, strDonoCartao, strDataExpiracao, strInstituicaoFinanceira, strParcelas, strCodigoPagto, strTipo, strUltimosQuatroDigitos: String; fltValorPagto: Double): String;  // Utilizado no TEF
  Var
    ArrRecPar: TParametrosIntegrador;
    ArrRecCon: TParametrosIntegrador;
begin
  SetLength(ArrRecCon, 1);
  pAddParam(0, 'chaveAcessoValidador', AnsiString(strChaveAcessoValidador), tpiInt, ArrRecCon);

  // ---------------------------------------------------------------------------

  SetLength(ArrRecPar, 11);

  pAddParam(00, 'CodigoAutorizacao',     AnsiString(strCodigoAutorizacao), tpiString, ArrRecPar);
  pAddParam(01, 'Bin',                   AnsiString(strBin), tpiString, ArrRecPar);
  pAddParam(02, 'DonoCartao',            AnsiString(strDonoCartao), tpiString, ArrRecPar);
  pAddParam(03, 'DataExpiracao',         AnsiString(strDataExpiracao), tpiString, ArrRecPar);
  pAddParam(04, 'InstituicaoFinanceira', AnsiString(strInstituicaoFinanceira), tpiString, ArrRecPar);
  pAddParam(05, 'Parcelas',              AnsiString(strParcelas), tpiString, ArrRecPar);
  pAddParam(06, 'CodigoPagamento',       AnsiString(strCodigoPagto), tpiString, ArrRecPar);
  pAddParam(07, 'ValorPagamento',        AnsiString(AnsiString(fFloatToStrVirgula(fltValorPagto, 12, 2))), tpiDecimal, ArrRecPar);
  pAddParam(08, 'idFila',                AnsiString(IntToStr(intIdFila)), tpiInt, ArrRecPar);
  pAddParam(09, 'Tipo',                  AnsiString(strTipo), tpiString, ArrRecPar); // Tipo da Bandeira
  pAddParam(10, 'UltimosQuatroDigitos',  AnsiString(strUltimosQuatroDigitos), tpiString, ArrRecPar);

  Result := fEnviaComando(intNumeroSessao,
                          'EnviarStatusPagamento',
                          objIntSATXML.fGerarXML('EnviarStatusPagamento', IntToStr(intNumeroSessao), ArrRecPar, 'VFP-e', ArrRecCon)
                          );

  Result := objIntSATXML.fProcessaRespostaSucesso(Result);
end;

function TIntegradorSAT.fRespostaFiscal(intNumeroSessao, idFila: Integer; strChaveAcessoValidador, strChaveAcesso, strNsu, strNumeroAprovacao, strBandeira, strAdquirente, strCnpj, strImpressaoFiscal, strNumeroDocumento: String): String;
  Var
    ArrRecPar: TParametrosIntegrador;
    ArrRecCon: TParametrosIntegrador;
begin
  SetLength(ArrRecCon, 1);
  pAddParam(0, 'chaveAcessoValidador', AnsiString(strChaveAcessoValidador), tpiInt, ArrRecCon);

  // ---------------------------------------------------------------------------

  SetLength(ArrRecPar, 9);

  pAddParam(00, 'idFila',            AnsiString(IntToStr(idFila)), tpiInt, ArrRecPar);
  pAddParam(01, 'ChaveAcesso',       AnsiString(strChaveAcesso), tpiString, ArrRecPar);
  pAddParam(02, 'Nsu',               AnsiString(strNsu), tpiString, ArrRecPar);
  pAddParam(03, 'NumerodeAprovacao', AnsiString(strNumeroAprovacao), tpiString, ArrRecPar);
  pAddParam(04, 'Bandeira',          AnsiString(strBandeira), tpiString, ArrRecPar); // Ex: Master
  pAddParam(05, 'Adquirente',        AnsiString(strAdquirente), tpiString, ArrRecPar); // Ex: Cielo
  pAddParam(06, 'CNPJ',              AnsiString(strCnpj), tpiString, ArrRecPar); // do Contribuinte
  pAddParam(07, 'ImpressaoFiscal',   AnsiString(strImpressaoFiscal), tpiString, ArrRecPar); // Texto do Extrato do CF-e ou Danfe para impressão no POS
  pAddParam(08, 'NumeroDocumento',   AnsiString(strNumeroDocumento), tpiString, ArrRecPar); // Número do documento fiscal autorizado para geração de QRCODE

  Result := fEnviaComando(intNumeroSessao,
                          'RespostaFiscal',
                          objIntSATXML.fGerarXML('RespostaFiscal', IntToStr(intNumeroSessao), ArrRecPar, 'VFP-e', ArrRecCon)
                          );

  Result := objIntSATXML.fProcessaRespostaSucesso(Result);
end;

function TIntegradorSAT.fVerificarStatusValidador(intNumeroSessao, idFila: Integer; strChaveAcessoValidador, strCnpj: String): TrecVFPeRespostaPagtoRealizado; // Utilizado no POS
  Var
    ArrRecPar: TParametrosIntegrador;
    ArrRecCon: TParametrosIntegrador;
    strXMLResposta : String;
begin
  SetLength(ArrRecCon, 1);
  pAddParam(0, 'chaveAcessoValidador', AnsiString(strChaveAcessoValidador), tpiInt, ArrRecCon);

  // ---------------------------------------------------------------------------

  SetLength(ArrRecPar, 2);

  pAddParam(00, 'idFila', AnsiString(IntToStr(idFila)), tpiInt, ArrRecPar);
  pAddParam(01, 'CNPJ',   AnsiString(strCnpj), tpiString, ArrRecPar); // do Contribuinte

  strXMLResposta := fEnviaComando(intNumeroSessao,
                                  'VerificarStatusValidador',
                                  objIntSATXML.fGerarXML('VerificarStatusValidador', IntToStr(intNumeroSessao), ArrRecPar, 'VFP-e', ArrRecCon)
                                  );

  Result := objIntSATXML.fProcessaRespostaPagamentoRealizado(strXMLResposta);
end;

procedure TIntegradorSAT.pAddParam(intIndex: Integer; strNome: String; strValor: AnsiString; tipoPar: TTipoParametroIntegrador; ArrRecPar: TParametrosIntegrador; blnCData: Boolean = False);
begin
  FillChar(ArrRecPar[intIndex], SizeOf(ArrRecPar[intIndex]), #0);
  ArrRecPar[intIndex].strNome := strNome;
  ArrRecPar[intIndex].strValor := strValor;
  ArrRecPar[intIndex].tipoPar := tipoPar;
  ArrRecPar[intIndex].blnCData := blnCData;
end;

function TIntegradorSAT.fEnviaComando(intNumeroSessao: Integer; strNome, strComando: String): String;
  Var
    stlArquivo : TStringList;
    dtaLocTimeOut, dtaActualTime : TDateTime;
    strNomeArquivo : String;
begin
  Result := '';
  stlArquivo := TStringList.Create;
  Try
    strNomeArquivo := fBarraNoFinal(FstrPastaInput) + strNome + '-' + IntToStr(intNumeroSessao) + '.tmp';

    stlArquivo.Add(strComando);
    stlArquivo.SaveToFile(strNomeArquivo);

    TIntegradorSATLOG.pLog(stlArquivo, 'fEnviaComando');

    RenameFile(strNomeArquivo, ChangeFileExt(strNomeArquivo,'.xml'));

    dtaActualTime := Now;

    If FintTimeout <= 0 Then
      dtaLocTimeOut := IncSecond(dtaActualTime, 30)
    Else
      dtaLocTimeOut := IncSecond(dtaActualTime, FintTimeout);

    Result := fAguardaArquivoResposta(intNumeroSessao, strNome);

    While (Trim(Result) = '') And
          (dtaActualTime < dtaLocTimeOut) Do
    Begin
      Result := fAguardaArquivoResposta(intNumeroSessao, strNome);
      Sleep(50);
      dtaActualTime := Now;
    End;
  Finally
    FreeAndNil(stlArquivo);
  End;

  If (Trim(Result) = '') Then
    Raise Exception.Create('Sem Resposta do Integrador');
end;

function TIntegradorSAT.fAguardaArquivoResposta(intNumeroSessao: Integer; strNome: String): String;
  Var
    stlArquivo, stlArqResp : TStringList;
    intCnt : Integer;
    strErro : String;
begin
  stlArquivo := TStringList.Create;
  stlArqResp := TStringList.Create;
  Try
    stlArqResp.Clear;
    pFindFiles(fBarraNoFinal(FstrPastaOutput) + '*.xml', stlArqResp);
    Sleep(50);

    For intCnt := 0 To stlArqResp.Count-1 Do
    Begin
      stlArquivo.Clear;
      stlArquivo.LoadFromFile(stlArqResp[intCnt]);

      If (objIntSATXML.fIdentificarRetorno(intNumeroSessao, stlArquivo.Text)) Then
      Begin
        TIntegradorSATLOG.pLog(stlArquivo, 'fAguardaArquivoResposta');

        strErro := objIntSATXML.fProcessaRespostaErro(stlArquivo.Text);

        If (Trim(strErro)='') Then
        Begin
          Result := Trim(stlArquivo.Text);
          DeleteFile(PChar(stlArqResp[intCnt]));
          Exit;
        End
        Else
          Raise Exception.Create(strErro);
      End;
    End;
  Finally
    FreeAndNil(stlArqResp);
    FreeAndNil(stlArquivo);
  End;
end;

end.
