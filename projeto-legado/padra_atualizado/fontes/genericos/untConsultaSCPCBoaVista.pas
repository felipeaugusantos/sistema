unit untConsultaSCPCBoaVista;

interface

uses Classes, System.SysUtils, StrUtils, idHTTP, IdSSLOpenSSL, MSHTML, Winapi.ActiveX,
  System.Generics.Collections, System.Variants, EditFocus, Forms, untConsultaSCPC;

type

  //*****************************************
  //* Dados da consulta de pessoa física    *
  //**************************************RS*
  TInformacoesAnalisePF = class
  private
    FDebitosScpc: String;
    FConsultasAnteriores: String;
    FDevolucoesCcf: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TDebitoScpcPF = class
  private
    FTipo: String;
    FInformante: String;
    FOrgao: String;
    FDebito: TDate;
    FDisponivel: TDate;
    FValor: Double;
  public
    procedure pParseHtmlA(varElement: OleVariant);
    procedure pParseHtmlB(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TDebitosScpcPF = class
  private
    FNome: String;
    FNascimento: TDate;
    FDocumento: String;
    FNaturalidade: String;
    FDebitos: TObjectList<TDebitoScpcPF>;
    function fGetCount: Integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
    property intCount: Integer read fGetCount;
  End;

  TConsultaAnteriorPF = class
  private
    FTipo: String;
    FData: TDate;
    FInformante: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TConsultasAnterioresPF = class
  private
    FConsultas: TObjectList<TConsultaAnteriorPF>;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TDevolucaoCCF_PF = class
  private
    FNome: String;
    FBanco: String;
    FAgencia: String;
    FMotivo: String;
    FQuantidade: Integer;
    FUltimaDevolucao: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TDevolucoesCCF_PF = class
  private
    FDevolucoes: TObjectList<TDevolucaoCCF_PF>;
    function fGetQtdDevolucoes: Integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
    property intQuantidadeDevolucoes: Integer read fGetQtdDevolucoes;
  End;

  //*****************************************
  //* Dados da consulta de pessoa jurídica  *
  //**************************************RS*
  TIdentificacaoPJ = class
  private
    FRazaoSocial: String;
    FCnpj: String;
    FNire: String;
    FNomeFantasia: String;
    FRazaoAnterior: String;
    FDataRazao: String;
    FDataFundacao: String;
    FDataEncerramento: String;
    FInscrEst: String;
    FSituacaoCnpj: String;
    FDataCnpj: TDate;
    FConsultaCnpj: TDate;
    FSituacaoSintegra: String;
    FDataSintegra: TDate;
    FConsultaSintegra: TDate;
    FNaturezaJuridica: String;
    FFaixaFuncionarios: String;
    FFiliais: Integer;
    FCnaePri: String;
    FCnaeSec: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TLocalizacaoPJ = class
  private
    FEndereco: String;
    FBairro: String;
    FCidadeUF: String;
    FCep: String;
    FEnderecoMatriz: String;
    FBairroMatriz: String;
    FCidadeUFMatriz: String;
    FCepMatriz: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TComportamentoPagamentoPJ = class
  private
    FQtdFornecedores: Integer;
    FQtdTitulos: Integer;
    FAVista: Double;
    FPotual: Double;
    FAtraso6_15: Double;
    FAtraso16_30: Double;
    FAtraso31_60: Double;
    FAtraso61_: Double;
    FAtrasoMedio: Double;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TComportamentosPagamentoPJ = class
  private
    FComportamentos: TObjectList<TComportamentoPagamentoPJ>;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TReferenciasNegociosPJ = class
  private
    FDataUltimaCompra: String;
    FValorUltimaCompra: Double;
    FMediaUltimacompra: Double;
    FDataMaiorFatura: String;
    FValorMaiorFatura: Double;
    FMediaMaiorFatura: Double;
    FDataMaiorCredito: String;
    FValorMaiorCredito: Double;
    FMediaMaiorCredito: Double;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TPendenciaPJ = class
    FData: String;
    FCredor: String;
    FValor: Double;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TPendenciasPJ = class
    FQtdPendencias: Integer;
    FQtdCredores: Integer;
    FValorTotal: Double;
    FDataPrimeiro: String;
    FValorPrimeiro: Double;
    FDataMaior: String;
    FValorMaior: Double;
    FPendencias: TObjectList<TPendenciaPJ>;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TChequeSustadoPJ = class
  private
    FData: String;
    FBanco: String;
    FAgencia: String;
    FCheques: String;
    FDataOcorrencia: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TChequesSustadosPJ = Class
  private
    FDataIni: TDate;
    FDataFin: TDate;
    FCheques: TObjectList<TChequeSustadoPJ>;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TChequeSemFundoPJ = Class
  private
    FQuantidade: Integer;
    FDataUltimo: String;
    FBanco: String;
    FAgencia: String;
    FMotivo: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
    property intQuantidade: Integer read FQuantidade;
  End;

  TChequesSemFundoPJ = class
  private
    FCheques: TObjectList<TChequeSemFundoPJ>;
    function fGetCount: Integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
    property intCount: Integer read fGetCount;
  End;

  TProtestoPJ = class
  private
    FData: String;
    FVencimento: String;
    FCartorio: String;
    FCidade: String;
    FEstado: String;
    FValor: Double;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TProtestosPJ = class
  private
    FQtdTotal: Integer;
    FValorTotal: Double;
    FDataPrimeiro: String;
    FValorPrimeiro: Double;
    FDataMaior: String;
    FValorMaior: Double;
    FUltimosProtestos: TObjectList<TProtestoPJ>;
    function fGetCount: Integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
    property intCount: Integer read fGetCount;
  End;

  TAcaoPJ = class
  private
    FQuantidade: Integer;
    FTipo: String;
    FData: String;
    FVara: String;
    FUF: String;
    FCidade: String;
  public
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
  End;

  TAcoesPJ = class
  private
    FAcoes: TObjectList<TAcaoPJ>;
    function fGetCount: Integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pParseHtml(varElement: OleVariant);
    function fGetRelatorio(): String;
    property intCount: Integer read fGetCount;
  End;

  //*****************************************
  //* Classe consulta Boa Vista             *
  //**************************************RS*
  TConsultaSCPCBoaVista = class(TConsultaSCPC)
  private
    FHTTP: TidHTTP;
    FEntidade: String;
    FLogin: String;
    FSenha: String;
    FLoginAutomatico: Boolean;
    FDocConsulta: String;
    FResp: String;
    FMsgErro: String;
    FSucesso: Boolean;

    FInformacoesAnalisePF: TInformacoesAnalisePF;
    FDebitosScpcPF: TDebitosScpcPF;
    FConsultasAnterioresPF: TConsultasAnterioresPF;
    FDevolucoesInformadasCCF_PF: TDevolucoesCCF_PF;

    FIdentificacaoPJ: TIdentificacaoPJ;
    FLocalizacaoPJ: TLocalizacaoPJ;
    FComportamentosPJ: TComportamentosPagamentoPJ;
    FReferenciasNegociosPJ: TReferenciasNegociosPJ;
    FPendenciasPJ: TPendenciasPJ;
    FChequesSustadosPJ: TChequesSustadosPJ;
    FChequesSemFundoPJ: TChequesSemFundoPJ;
    FProtestosPJ: TProtestosPJ;
    FAcoesPJ: TAcoesPJ;

    procedure pParseResponse(strResponse: String);
    procedure pParsePF(varDoc: OleVariant);
    procedure pParsePJ(varDoc: OleVariant);
    function fVerTableHead(varElement: OleVariant; strTitulo: String): Boolean;
    function fAcentua(strTexto: String): String;
  protected
    function fGetMsgErro: String; override;
    function fGetRelatorio: String; override;
    function fGetQtdProtestos: Integer; override;
    function fGetQtdCheques: Integer; override;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    function fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean; override;
    procedure pSaveToFile(Const strFileName: String); override;
  end;

implementation

{ TConsultaSCPCBoaVista }

uses untFuncoesSimples;

constructor TConsultaSCPCBoaVista.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHTTP := TidHTTP.Create(Self);
  FHTTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
  FEntidade := fCfgSis('ENTBOV');

  FLogin := fCfgSis('LOGBVE');
  FSenha := fCfgSis('SENBVE');
  FLoginAutomatico := False;

  FInformacoesAnalisePF := TInformacoesAnalisePF.Create;
  FDebitosScpcPF := TDebitosScpcPF.Create;
  FConsultasAnterioresPF := TConsultasAnterioresPF.Create;
  FDevolucoesInformadasCCF_PF := TDevolucoesCCF_PF.Create;

  FIdentificacaoPJ := TIdentificacaoPJ.Create;
  FLocalizacaoPJ := TLocalizacaoPJ.Create;
  FComportamentosPJ := TComportamentosPagamentoPJ.Create;
  FReferenciasNegociosPJ := TReferenciasNegociosPJ.Create;
  FPendenciasPJ := TPendenciasPJ.Create;
  FChequesSustadosPJ := TChequesSustadosPJ.Create;
  FChequesSemFundoPJ := TChequesSemFundoPJ.Create;
  FProtestosPJ := TProtestosPJ.Create;
  FAcoesPJ := TAcoesPJ.Create;
end;

destructor TConsultaSCPCBoaVista.Destroy;
begin
  FreeAndNil(FHTTP);

  FreeAndNil(FInformacoesAnalisePF);
  FreeAndNil(FDebitosScpcPF);
  FreeAndNil(FConsultasAnterioresPF);
  FreeAndNil(FDevolucoesInformadasCCF_PF);

  FreeAndNil(FIdentificacaoPJ);
  FreeAndNil(FLocalizacaoPJ);
  FreeAndNil(FComportamentosPJ);
  FreeAndNil(FReferenciasNegociosPJ);
  FreeAndNil(FPendenciasPJ);
  FreeAndNil(FChequesSustadosPJ);
  FreeAndNil(FChequesSemFundoPJ);
  FreeAndNil(FProtestosPJ);
  FreeAndNil(FAcoesPJ);

  inherited;
end;

function TConsultaSCPCBoaVista.fAcentua(strTexto: String): String;
begin
  Result := strTexto;
  Result := AnsiReplaceStr(Result, 'inv?lida', 'inválida');
  Result := AnsiReplaceStr(Result, 'NAO', 'NÃO');
  Result := AnsiReplaceStr(Result, 'C?digo', 'Código');
  Result := AnsiReplaceStr(Result, 'n?o', 'não');
end;

function TConsultaSCPCBoaVista.fGetMsgErro: String;
begin
  Result := FMsgErro;
end;

function TConsultaSCPCBoaVista.fGetQtdCheques: Integer;
begin
  If Length(FDocConsulta) = 11 Then
    Result := FDevolucoesInformadasCCF_PF.fGetQtdDevolucoes
  Else
    Result := FChequesSemFundoPJ.intCount;
end;

function TConsultaSCPCBoaVista.fGetQtdProtestos: Integer;
begin
  If Length(FDocConsulta) = 11 Then
    Result := FDebitosScpcPF.intCount
  Else
    Result := FProtestosPJ.intCount;
end;

function TConsultaSCPCBoaVista.fGetRelatorio: String;
begin
  If Length(FDocConsulta) = 11 Then
    Result := FInformacoesAnalisePF.fGetRelatorio() +
              FDebitosScpcPF.fGetRelatorio() +
              FConsultasAnterioresPF.fGetRelatorio() +
              FDevolucoesInformadasCCF_PF.fGetRelatorio()
  Else
    Result := FIdentificacaoPJ.fGetRelatorio() +
              FLocalizacaoPJ.fGetRelatorio() +
              FComportamentosPJ.fGetRelatorio() +
              FReferenciasNegociosPJ.fGetRelatorio() +
              FPendenciasPJ.fGetRelatorio() +
              FChequesSustadosPJ.fGetRelatorio() +
              FChequesSemFundoPJ.fGetRelatorio() +
              FProtestosPJ.fGetRelatorio() +
              FAcoesPJ.fGetRelatorio();
end;

function TConsultaSCPCBoaVista.fRealizarConsulta(strDocumento, strNomeEmpresa, strCidade, strUF: String; blnSCPCAutomatico: Boolean): Boolean;
Var
  strURL: String;
  strResultado: TStringStream;
begin
  FMsgErro := '';
  FDocConsulta := strDocumento;
  Result := False;

  If Not FLoginAutomatico Then
  Begin
    FLogin := '';
    FSenha := '';
  End;

  If fEmptyStr(FLogin) Or fEmptyStr(FSenha) Then
  Begin
    If Not fInputQueryTipo('Boa Vista Serviços', 'Login:', FLogin, ttAlfanumerico) Then
      Exit;

    If Not fInputQueryTipo('Boa Vista Serviços', 'Senha:', FSenha, ttAlfanumerico, '*') Then
      Exit;
  End;

  If fEmptyStr(FEntidade) Then
  Begin
    FMsgErro :=
      'Para acessar a consulta SCPC você deve informar o código da entidade nas configurações do sistema!';
    Exit;
  End;

  strResultado := TStringStream.Create;
  Try
    strURL := 'https://integra.boavistaservicos.com.br/lac/layercon/consumir';

    strURL := strURL + '?solicitante=$CITELSOFTWARE';
    strURL := strURL + '&entidade=' + FEntidade;
    strURL := strURL + '&associado=' + FLogin;
    strURL := strURL + '&loginacesso=' + FLogin;
    strURL := strURL + '&senhaacesso=' + FSenha;
    If Length(strDocumento) = 11 Then
    Begin
      strURL := strURL + '&produto=INTEGRADASCORE';
      strURL := strURL + '&score=N';
      strURL := strURL + '&tipocredito=OU';
      strURL := strURL + '&cpf=' + strDocumento;
    End
    Else
    Begin
      strURL := strURL + '&produto=CONSULTEPJ';
      strURL := strURL + '&cnpj=' + strDocumento;
    End;
    strURL := strURL + '&mostraframe=n';

    FHTTP.HTTPOptions := FHTTP.HTTPOptions + [hoNoProtocolErrorException];
    FHTTP.Get(strURL, strResultado);

    If FHTTP.ResponseCode = 200 Then
    Begin
      strResultado.Seek(0, soFromBeginning);
      FResp := strResultado.DataString;
      pParseResponse(FResp);
      Result := FSucesso;
    End
    Else
    Begin
      FMsgErro := 'Ocorreu um erro imprevisto na consulta!' + #13#10 +
                  'Código do erro: ' + IntToStr(FHTTP.ResponseCode) + #13#10 +
                  'Descrição do erro: ' + FHTTP.ResponseText;
      Exit;
    End;

  Finally
    FreeAndNil(strResultado);
    CoFreeUnusedLibrariesEx(0,0);
  End;
end;

function TConsultaSCPCBoaVista.fVerTableHead(varElement: OleVariant;
  strTitulo: String): Boolean;
Var
  el: OleVariant;
  i: Integer;
begin
  Result := False;
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'THEAD') and ContainsText(el.innerText, strTitulo) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

procedure TConsultaSCPCBoaVista.pParsePF(varDoc: OleVariant);
Var
  el: OleVariant;
  i: Integer;
begin
  For i := 0 to varDoc.body.all.length - 1 Do
  Begin
    el := varDoc.body.all.item(i);
    If (el.tagName = 'DIV') and (el.id = 'resumoconsulta') Then
      FInformacoesAnalisePF.pParseHtml(el)
    Else If (el.tagName = 'DIV') and (el.id = 'debitosscpc') Then
      FDebitosScpcPF.pParseHtml(el)
    Else If (el.tagName = 'DIV') and (el.id = 'consultasantspc') Then
      FConsultasAnterioresPF.pParseHtml(el)
    Else If (el.tagName = 'DIV') and (el.id = 'ChequeDevolvidoCCF') Then
      FDevolucoesInformadasCCF_PF.pParseHtml(el);
  End;
end;

procedure TConsultaSCPCBoaVista.pParsePJ(varDoc: OleVariant);
Var
  el: OleVariant;
  i: Integer;
begin
  For i := 0 to varDoc.body.all.length - 1 Do
  Begin
    el := varDoc.body.all.item(i);
    If (el.tagName = 'DIV') And (el.className = 'cnt-resultado') Then
    Begin
      If fVerTableHead(el, 'IDENTIFICAÇÃO') Then
        FIdentificacaoPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'LOCALIZAÇÃO') Then
        FLocalizacaoPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'COMPORTAMENTO DE PAGAMENTOS') Then
        FComportamentosPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'REFERENCIAIS DE NEGÓCIOS') Then
        FReferenciasNegociosPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'PENDÊNCIAS E RESTRIÇÕES FINANCEIRAS') Then
        FPendenciasPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'CHEQUES SUSTADOS MOTIVO 21') Then
        FChequesSustadosPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'CHEQUES SEM FUNDO') Then
        FChequesSemFundoPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'PROTESTOS') Then
        FProtestosPJ.pParseHtml(el)
      Else If fVerTableHead(el, 'RECUPERAÇÕES, FALÊNCIAS E AÇÕES JUDICIAIS') Then
        FAcoesPJ.pParseHtml(el);
    End;
  End;
end;

procedure TConsultaSCPCBoaVista.pParseResponse(strResponse: String);
Var
  doc: OleVariant;
  el: OleVariant;
  i: Integer;
begin
  FSucesso := True;

  doc := CoHTMLDocument.Create as IHTMLDocument2;
  doc.write(strResponse);
  doc.Close;

  FMsgErro := '';

  For i := 0 to doc.body.all.length - 1 Do
  Begin
    el := doc.body.all.item(i);
    If (el.tagName = 'SPAN') And ((el.className = 'war-header') Or (el.className = 'err-header')) Then
      FMsgErro := FMsgErro + Trim(el.innerText);
    If (el.tagName = 'LI') And (Not fEmptyStr(FMsgErro)) Then
      FMsgErro := FMsgErro + #13#10 + fAcentua(Trim(el.innerText));
  End;

  If Not fEmptyStr(FMsgErro) Then
    FSucesso := False
  Else
  Begin
    If Length(FDocConsulta) = 11 Then
      pParsePF(doc)
    Else
      pParsePJ(doc);
  End;
end;

procedure TConsultaSCPCBoaVista.pSaveToFile(const strFileName: String);
var
  stlTexto: TStringList;
begin
  inherited;
  If Not DirectoryExists(ExtractFilePath(strFileName)) Then
    fCriaDiretorio(ExtractFilePath(strFileName));

  stlTexto := TStringList.Create;
  Try
    stlTexto.Text := Self.fGetRelatorio;
    stlTexto.SaveToFile(strFileName);

    stlTexto.Text := FResp;
    stlTexto.SaveToFile(AnsiReplaceStr(strFileName, ExtractFileExt(strFileName), '.html'));
  Finally
    FreeAndNil(stlTexto);
  End;
end;

{ TInformacoesAnalise }

function TInformacoesAnalisePF.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            '                  Informações para Análise                   ' + #13#10 +
            '-------------------------------------------------------------' + #13#10 +
            'Débitos no SCPC:                ' + FDebitosScpc + #13#10 +
            'Consultas Anteriores no SCPC:   ' + FConsultasAnteriores + #13#10 +
            'Devoluções Informadas pelo CCF: ' + FDevolucoesCcf + #13#10 + #13#10;
end;

procedure TInformacoesAnalisePF.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;
begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TH') and (el.innerText = 'Débitos no SCPC') Then
      FDebitosScpc := Trim(varElement.all.item(i + 1).innerText)
    Else If (el.tagName = 'TH') and (el.innerText = 'Consultas Anteriores no SCPC') Then
      FConsultasAnteriores := Trim(varElement.all.item(i + 1).innerText)
    Else If (el.tagName = 'TH') and (el.innerText = 'Devoluções Informadas pelo CCF') Then
      FDevolucoesCcf := Trim(varElement.all.item(i + 1).innerText);
  End;
end;

{ TDebitoScpc }

function TDebitoScpcPF.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            'Tipo:       ' + FTipo + #13#10 +
            'Informante: ' + FInformante + #13#10 +
            'Orgao:      ' + FOrgao + #13#10 +
            'Débito:     ' + DateToStr(FDebito) + #13#10 +
            'Disponível: ' + DateToStr(FDisponivel) + #13#10 +
            'Valor:      ' + FormatFloat('#,##0.00', FValor) + #13#10;
end;

procedure TDebitoScpcPF.pParseHtmlA(varElement: OleVariant);
begin
  FTipo       := Trim(varElement.all.item(1).getAttribute('original-title'));
  FInformante := Trim(varElement.all.item(2).innerText);
  FDebito     := StrToDate(varElement.all.item(6).innerText);
  FDisponivel := StrToDate(varElement.all.item(7).innerText);
  FValor      := fStrToFloat(varElement.all.item(9).innerText);
end;

procedure TDebitoScpcPF.pParseHtmlB(varElement: OleVariant);
begin
  FOrgao      := Trim(varElement.all.item(1).innerText);
end;

{ TDebitosScpc }

constructor TDebitosScpcPF.Create;
begin
  inherited Create;
  FDebitos := TObjectList<TDebitoScpcPF>.Create();
end;

destructor TDebitosScpcPF.Destroy;
begin
  FreeAndNil(FDebitos);
  inherited;
end;

function TDebitosScpcPF.fGetCount: Integer;
begin
  Result := FDebitos.Count;
end;

function TDebitosScpcPF.fGetRelatorio: String;
Var
  objDebito: TDebitoScpcPF;
begin
  If FDebitos.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                       Débitos do SCPC                       ' + #13#10 +
              '-------------------------------------------------------------' + #13#10 +
              'Nome:         ' + FNome + #13#10 +
              'Nascimento:   ' + IfThen(FNascimento > 0, DateToStr(FNascimento), '') + #13#10 +
              'CPF:          ' + FDocumento + #13#10 +
              'Naturalidade: ' + FNaturalidade + #13#10;

    For objDebito In FDebitos Do
      Result := Result + objDebito.fGetRelatorio;

    Result := Result + #13#10;
  End;
end;

procedure TDebitosScpcPF.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;
  objDebito: TDebitoScpcPF;
begin
  objDebito := Nil;
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TH') and (el.innerText = 'Nome') Then
      FNome := Trim(varElement.all.item(i + 4).innerText)
    Else If (el.tagName = 'TH') and (el.innerText = 'Nascimento') Then
      FNascimento := StrToDate(varElement.all.item(i + 4).innerText)
    Else If (el.tagName = 'TH') and (el.innerText = 'CPF') Then
      FDocumento := Trim(varElement.all.item(i + 4).innerText)
    Else If (el.tagName = 'TH') and (el.innerText = 'Naturalidade') Then
      FNaturalidade := Trim(varElement.all.item(i + 3).innerText)
    Else If (el.tagName = 'TR') and (el.className = 'linharegA') Then
    Begin
      objDebito := TDebitoScpcPF.Create;
      objDebito.pParseHtmlA(el);
      FDebitos.Add(objDebito);
    End
    Else If (el.tagName = 'TR') and (el.className = 'linharegB') Then
      objDebito.pParseHtmlB(el);
  End;
end;

{ TConsultaAnterior }

function TConsultaAnteriorPF.fGetRelatorio: String;
begin
  Result := 'Tipo:       ' + FTipo + #13#10 +
            'Data:       ' + DateToStr(FData) + #13#10 +
            'Informante: ' + FInformante + #13#10;
end;

procedure TConsultaAnteriorPF.pParseHtml(varElement: OleVariant);
begin
  FTipo       := Trim(varElement.all.item(1).getAttribute('original-title'));
  FData       := StrToDate(varElement.all.item(2).innerText);
  FInformante := Trim(varElement.all.item(3).innerText);
end;

{ TConsultasAnteriores }

constructor TConsultasAnterioresPF.Create;
begin
  inherited Create;
  FConsultas := TObjectList<TConsultaAnteriorPF>.Create();
end;

destructor TConsultasAnterioresPF.Destroy;
begin
  FreeAndNil(FConsultas);
  inherited;
end;

function TConsultasAnterioresPF.fGetRelatorio: String;
Var
  objConsulta: TConsultaAnteriorPF;
begin
  If FConsultas.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                     Consultas Anteriores                    ' + #13#10 +
              '-------------------------------------------------------------' + #13#10;

    For objConsulta In FConsultas Do
    Begin
      If objConsulta <> FConsultas.First Then
        Result := Result + '-------------------------------------------------------------' + #13#10;

      Result := Result + objConsulta.fGetRelatorio;
    End;

    Result := Result + #13#10;
  End;
end;

procedure TConsultasAnterioresPF.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;
  objConsulta: TConsultaAnteriorPF;
begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TR') and ((el.className = 'consultaant') or (el.className = 'consultaantz')) Then
    Begin
      objConsulta := TConsultaAnteriorPF.Create;
      objConsulta.pParseHtml(el);
      FConsultas.Add(objConsulta);
    End;
  End;
end;

{ TIdentificacaoPJ }

function TIdentificacaoPJ.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            '                        IDENTIFICAÇÃO                        ' + #13#10 +
            '-------------------------------------------------------------' + #13#10;
  If Not fEmptyStr(FRazaoSocial) Then
    Result := Result + 'Razão Social:          ' + FRazaoSocial + #13#10;
  If Not fEmptyStr(FCnpj) Then
    Result := Result + 'CNPJ:                  ' + FCnpj + #13#10;
  If Not fEmptyStr(FNire) Then
    Result := Result + 'Nire:                  ' + FNire + #13#10;
  If Not fEmptyStr(FNomeFantasia) Then
    Result := Result + 'Nome Fantasia:         ' + FNomeFantasia + #13#10;
  If Not fEmptyStr(FRazaoAnterior) Then
    Result := Result + 'Razão Anterior:        ' + FRazaoAnterior + #13#10;
  If Not fEmptyStr(FDataRazao) Then
    Result := Result + 'Razaõ anterior até:    ' + FDataRazao + #13#10;
  If Not fEmptyStr(FDataFundacao) Then
    Result := Result + 'Data da Fundação:      ' + FDataFundacao + #13#10;
  If Not fEmptyStr(FDataEncerramento) Then
    Result := Result + 'Data de Encerramento:  ' + FDataEncerramento + #13#10;
  If Not fEmptyStr(FInscrEst) Then
    Result := Result + 'Inscr. Est.:           ' + FInscrEst + #13#10;
  If Not fEmptyStr(FSituacaoCnpj) Then
    Result := Result + 'Situação do CNPJ:      ' + FSituacaoCnpj + #13#10;
  If (FDataCnpj > 0) Then
    Result := Result + 'Data:                  ' + DateToStr(FDataCnpj) + #13#10;
  If (FConsultaCnpj > 0) Then
    Result := Result + 'Consultado em:         ' + DateToStr(FConsultaCnpj) + #13#10;
  If Not fEmptyStr(FSituacaoSintegra) Then
    Result := Result + 'Situação SINTEGRA:     ' + FSituacaoSintegra + #13#10;
  If (FDataSintegra > 0) Then
    Result := Result + 'Data:                  ' + DateToStr(FDataSintegra) + #13#10;
  If (FConsultaSintegra > 0) Then
    Result := Result + 'Consultado em:         ' + DateToStr(FConsultaSintegra) + #13#10;
  If Not fEmptyStr(FNaturezaJuridica) Then
    Result := Result + 'Natureza Jurídica:     ' + FNaturezaJuridica + #13#10;
  If Not fEmptyStr(FFaixaFuncionarios) Then
    Result := Result + 'Faixa de funcionários: ' + FFaixaFuncionarios + #13#10;
  If (FFiliais > 0) Then
    Result := Result + 'Filiais:               ' + IntToStr(FFiliais) + #13#10;
  If Not fEmptyStr(FCnaePri) Then
    Result := Result + 'Ramo de Atividade Primário - CNAE: ' + FCnaePri + #13#10;
  If Not fEmptyStr(FCnaeSec) Then
    Result := Result + 'Ramo de Atividade secundário:      ' + FCnaeSec + #13#10;
  Result := Result + #13#10;
end;

procedure TIdentificacaoPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;
  blnSitCnpj,
  blnSitSintegra,
  blnRazaoAnterior: Boolean;
begin
  blnSitCnpj := False;
  blnSitSintegra := False;
  blnRazaoAnterior := False;

  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Razão Social') Then
      FRazaoSocial := Trim(fReplaceStr(el.parentElement.innerText, 'Razão Social', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'CNPJ') Then
      FCnpj := Trim(fReplaceStr(el.parentElement.innerText, 'CNPJ', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Nire') Then
      FNire := Trim(fReplaceStr(el.parentElement.innerText, 'Nire', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Nome Fantasia') Then
      FNomeFantasia := Trim(fReplaceStr(el.parentElement.innerText, 'Nome Fantasia', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Razão Anterior') Then
    Begin
      FRazaoAnterior := Trim(fReplaceStr(el.parentElement.innerText, 'Razão Anterior', ''));
      blnRazaoAnterior := True;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Data') And blnRazaoAnterior Then
    Begin
      FDataRazao := Trim(fReplaceStr(el.parentElement.innerText, 'Data', ''));
      blnRazaoAnterior := False;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Data de Fundação') Then
      FDataFundacao := Trim(fReplaceStr(el.parentElement.innerText, 'Data de Fundação', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Data de Encerramento') Then
      FDataEncerramento := Trim(fReplaceStr(el.parentElement.innerText, 'Data de Encerramento', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Inscr. Est.') Then
      FInscrEst := Trim(fReplaceStr(el.parentElement.innerText, 'Inscr. Est.', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Situação do CNPJ') Then
    Begin
      FSituacaoCnpj := Trim(fReplaceStr(el.parentElement.innerText, 'Situação do CNPJ', ''));
      blnSitCnpj := True;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Data') And blnSitCnpj Then
      FDataCnpj := StrToDate(Trim(fReplaceStr(el.parentElement.innerText, 'Data', '')))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Consultado em') And blnSitCnpj Then
    Begin
      FConsultaCnpj := StrToDate(Trim(fReplaceStr(el.parentElement.innerText, 'Consultado em', '')));
      blnSitCnpj := False;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Situação SINTEGRA') Then
    Begin
      FSituacaoSintegra := Trim(fReplaceStr(el.parentElement.innerText, 'Situação SINTEGRA', ''));
      blnSitSintegra := True;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Data') And blnSitSintegra Then
      FDataSintegra := StrToDate(Trim(fReplaceStr(el.parentElement.innerText, 'Data', '')))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Consultado em') And blnSitSintegra Then
    Begin
      FConsultaSintegra := StrTodate(Trim(fReplaceStr(el.parentElement.innerText, 'Consultado em', '')));
      blnSitSintegra := False;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Natureza Jurídica') Then
      FNaturezaJuridica := Trim(fReplaceStr(el.parentElement.innerText, 'Natureza Jurídica', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Faixa de Funcionários') Then
      FFaixaFuncionarios := Trim(fReplaceStr(el.parentElement.innerText, 'Faixa de Funcionários', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Filiais') Then
      FFiliais := Trunc(fStrToFloat(Trim(fReplaceStr(el.parentElement.innerText, 'Filiais ', ''))))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Ramo de Atividade Primário') Then
      FCnaePri := Trim(fReplaceStr(el.parentElement.innerText, 'Ramo de Atividade Primário - CNAE', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Ramo de Atividade secundário') Then
      FCnaeSec := Trim(fReplaceStr(el.parentElement.innerText, 'Ramo de Atividade secundário', ''));
  End;
end;

{ TLocalizacaoPJ }

function TLocalizacaoPJ.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            '                         LOCALIZAÇÃO                         ' + #13#10 +
            '-------------------------------------------------------------' + #13#10;
  If Not fEmptyStr(FEndereco) Then
    Result := Result + 'Endereço:           ' + FEndereco + #13#10;
  If Not fEmptyStr(FBairro) Then
    Result := Result + 'Bairro:             ' + FBairro + #13#10;
  If Not fEmptyStr(FCidadeUF) Then
    Result := Result + 'Cidade - UF:        ' + FCidadeUF + #13#10;
  If Not fEmptyStr(FCep) Then
    Result := Result + 'CEP:                ' + FCep + #13#10;
  If Not fEmptyStr(FEnderecoMatriz) Then
    Result := Result + 'Endereço da Matriz: ' + FEnderecoMatriz + #13#10;
  If Not fEmptyStr(FBairroMatriz) Then
    Result := Result + 'Bairro da Matriz:   ' + FBairroMatriz + #13#10;
  If Not fEmptyStr(FCidadeUFMatriz) Then
    Result := Result + 'Cidade - UF:        ' + FCidadeUFMatriz + #13#10;
  If Not fEmptyStr(FCepMatriz) Then
    Result := Result + 'CEP:                ' + FCepMatriz + #13#10 + #13#10;
end;

procedure TLocalizacaoPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;
  blnMatriz: Boolean;
begin
  blnMatriz := False;
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);

    If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Endereço') Then
      FEndereco := Trim(fReplaceStr(el.parentElement.innerText, 'Endereço', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Bairro') Then
      FBairro := Trim(fReplaceStr(el.parentElement.innerText, 'Bairro', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Cidade - UF') And (Not blnMatriz) Then
      FCidadeUF := Trim(fReplaceStr(el.parentElement.innerText, 'Cidade - UF', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'CEP') And (Not blnMatriz) Then
      FCep := Trim(fReplaceStr(el.parentElement.innerText, 'CEP', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Endereço da Matriz') Then
    Begin
      FEnderecoMatriz := Trim(fReplaceStr(el.parentElement.innerText, 'Endereço da Matriz', ''));
      blnMatriz := True;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Bairro da matriz') Then
    Begin
      FBairroMatriz := Trim(fReplaceStr(el.parentElement.innerText, 'Bairro da matriz', ''));
      blnMatriz := True;
    End
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'Cidade - UF') And blnMatriz Then
      FCidadeUFMatriz := Trim(fReplaceStr(el.parentElement.innerText, 'Cidade - UF', ''))
    Else If (el.tagName = 'STRONG') and (Trim(el.innerText) = 'CEP') And blnMatriz Then
      FCepMatriz := Trim(fReplaceStr(el.parentElement.innerText, 'CEP', ''));
  End;
end;

{ TChequeSustado }

function TChequeSustadoPJ.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            'Data:               ' + FData + #13#10 +
            'Banco:              ' + FBanco + #13#10 +
            'Agência:            ' + FAgencia + #13#10 +
            'Cheques:            ' + FCheques + #13#10 +
            'Data da ocorrência: ' + FDataOcorrencia + #13#10;
end;

procedure TChequeSustadoPJ.pParseHtml(varElement: OleVariant);
begin
  FData           := Trim(varElement.children.item(0).innerText);
  FBanco          := Trim(varElement.children.item(1).innerText);
  FAgencia        := Trim(varElement.children.item(2).innerText);
  FCheques        := Trim(varElement.children.item(3).innerText);
  FDataOcorrencia := Trim(varElement.children.item(4).innerText);
end;

{ TChequesSustados }

constructor TChequesSustadosPJ.Create;
begin
  inherited Create;
  FCheques := TObjectList<TChequeSustadoPJ>.Create;
end;

destructor TChequesSustadosPJ.Destroy;
begin
  FreeAndNil(FCheques);
  inherited;
end;

function TChequesSustadosPJ.fGetRelatorio: String;
Var
  objCheque: TChequeSustadoPJ;
begin
  If FCheques.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                  CHEQUES SUSTADOS MOTIVO 21                 ' + #13#10 +
              '-------------------------------------------------------------' + #13#10 +
              'Período: ' + DateToStr(FDataIni) + ' a ' + DateToStr(FDataFin) + #13#10;

    For objCheque In FCheques Do
      Result := Result + objCheque.fGetRelatorio;

    Result := Result + #13#10;
  End;
end;

procedure TChequesSustadosPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParsePeriodo(varTBody: OleVariant);
  Var
    strContent: String;
  Begin
    strContent := varTBody.children.item(0).innerText;
    If ContainsText(strContent, 'Período:') Then
    Begin
      strContent := Trim(fReplaceStr(strContent, 'Período:', ''));
      FDataIni   := StrToDate(Copy(strContent, 1, 10));
      strContent := Trim(Copy(strContent, Pos('à', strContent) + 1, Length(strContent)));
      FDataFin   := StrToDate(Copy(strContent, 1, 10));
    End;
  End;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    objCheque: TChequeSustadoPJ;
  Begin
    For j := 2 to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objCheque := TChequeSustadoPJ.Create;
      objCheque.pParseHtml(elTr);
      FCheques.Add(objCheque);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParsePeriodo(el);
      pParseItens(el);
      Break;
    End;
  End;
end;

{ TChequeSemFundo }

function TChequeSemFundoPJ.fGetRelatorio: String;
begin
  Result := 'Quantidade:     ' + IntToStr(FQuantidade) + #13#10 +
            'Data do último: ' + FDataUltimo + #13#10 +
            'Banco:          ' + FBanco + #13#10 +
            'Agência:        ' + FAgencia + #13#10 +
            'Motivo:         ' + FMotivo + #13#10;
end;

procedure TChequeSemFundoPJ.pParseHtml(varElement: OleVariant);
begin
  FQuantidade := Trunc(fStrToFloat(Trim(varElement.children.item(0).innerText)));
  FDataUltimo := Trim(varElement.children.item(1).innerText);
  FBanco      := Trim(varElement.children.item(2).innerText);
  FAgencia    := Trim(varElement.children.item(3).innerText);
  FMotivo     := Trim(varElement.children.item(4).innerText);
end;

{ TChequesSemFundo }

constructor TChequesSemFundoPJ.Create;
begin
  inherited Create;
  FCheques := TObjectList<TChequeSemFundoPJ>.Create;
end;

destructor TChequesSemFundoPJ.Destroy;
begin
  FreeAndNil(FCheques);
  inherited;
end;

function TChequesSemFundoPJ.fGetCount: Integer;
Var
  objCheque: TChequeSemFundoPJ;
begin
  Result := 0;
  For objCheque In FCheques Do
    Result := Result + objCheque.intQuantidade;
end;

function TChequesSemFundoPJ.fGetRelatorio: String;
Var
  objCheque: TChequeSemFundoPJ;
begin
  If FCheques.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                      CHEQUES SEM FUNDO                      ' + #13#10 +
              '-------------------------------------------------------------' + #13#10;

    For objCheque In FCheques Do
    Begin
      If objCheque <> FCheques.First Then
        Result := Result + '-------------------------------------------------------------' + #13#10;

      Result := Result + objCheque.fGetRelatorio;
    End;

    Result := Result + #13#10;
  End;
end;

procedure TChequesSemFundoPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    objCheque: TChequeSemFundoPJ;
  Begin
    For j := 3 to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objCheque := TChequeSemFundoPJ.Create;
      objCheque.pParseHtml(elTr);
      FCheques.Add(objCheque);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParseItens(el);
      Break;
    End;
  End;
end;

{ TProtestoPJ }

function TProtestoPJ.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            'Data:       ' + FData + #13#10 +
            'Vencimento: ' + FVencimento + #13#10 +
            'Cartório:   ' + FCartorio + #13#10 +
            'Cidade:     ' + FCidade + #13#10 +
            'Estado:     ' + FEstado + #13#10 +
            'Valor:      ' + FormatFloat('#,##0.00', FValor) + #13#10;
end;

procedure TProtestoPJ.pParseHtml(varElement: OleVariant);
begin
  FData       := Trim(varElement.children.item(0).innerText);
  FVencimento := Trim(varElement.children.item(1).innerText);
  FCartorio   := Trim(varElement.children.item(2).innerText);
  FCidade     := Trim(varElement.children.item(3).innerText);
  FEstado     := Trim(varElement.children.item(4).innerText);
  FValor      := fStrToFloat(Trim(varElement.children.item(5).innerText));
end;

{ TProtestosPJ }

constructor TProtestosPJ.Create;
begin
  inherited Create;
  FUltimosProtestos := TObjectList<TProtestoPJ>.Create();
end;

destructor TProtestosPJ.Destroy;
begin
  FreeAndNil(FUltimosProtestos);
  inherited;
end;

function TProtestosPJ.fGetCount: Integer;
begin
  Result := FUltimosProtestos.Count;
end;

function TProtestosPJ.fGetRelatorio: String;
Var
  objProtesto: TProtestoPJ;
begin
  If FUltimosProtestos.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                          PROTESTOS                          ' + #13#10 +
              '-------------------------------------------------------------' + #13#10 +
              'Total de protestos: ' + IntToStr(FQtdTotal) + #13#10 +
              'Valor:              ' + FormatFloat('#,##0.00', FValorTotal) + #13#10;
              If Not fEmptyStr(FDataPrimeiro) Then
              Begin
                Result := Result +
                'Data do primeiro:   ' + FDataPrimeiro + #13#10 +
                'Valor do primeiro:  ' + FormatFloat('#,##0.00', FValorPrimeiro) + #13#10;
              End;
              If Not fEmptyStr(FDataMaior) Then
              Begin
                Result := Result +
                'Data do maior:      ' + FDataMaior + #13#10 +
                'Valor do maior:     ' + FormatFloat('#,##0.00', FValorMaior) + #13#10;
              End;

    For objProtesto In FUltimosProtestos Do
      Result := Result + objProtesto.fGetRelatorio;

    Result := Result + #13#10;
  End;
end;

procedure TProtestosPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseCabecalho(varTBody: OleVariant);
  Var
    strContent: String;
  Begin
    If varTBody.children.item(0).children.length > 1 Then
    Begin
      strContent := varTBody.children.item(0).children.item(1).InnerText;
      If ContainsText(strContent, 'Total de Protestos:') Then
      Begin
        strContent := Trim(fReplaceStr(strContent, 'Total de Protestos:', ''));
        FQtdTotal := Trunc(fStrToFloat(strContent));
      End;
    End;

    If varTBody.children.item(0).children.length > 2 Then
    Begin
      strContent := varTBody.children.item(0).children.item(2).InnerText;
      If ContainsText(strContent, 'Valor (R$):') Then
      Begin
        strContent := Trim(fReplaceStr(strContent, 'Valor (R$):', ''));
        FValorTotal := fStrToFloat(strContent);
      End;
    End;

    If varTBody.children.length > 2 Then
    Begin
      If ContainsText(varTBody.children.item(2).children.item(0).InnerText, 'Primeiro:') Then
      Begin
        FDataPrimeiro := varTBody.children.item(2).children.item(1).InnerText;
        FValorPrimeiro := fStrToFloat(varTBody.children.item(2).children.item(2).InnerText);
      End;
    End;

    If varTBody.children.length > 3 Then
    Begin
      If ContainsText(varTBody.children.item(3).children.item(0).InnerText, 'Maior:') Then
      Begin
        FDataMaior := varTBody.children.item(3).children.item(1).InnerText;
        FValorMaior := fStrToFloat(varTBody.children.item(3).children.item(2).InnerText);
      End;
    End;
  End;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    intPrimeiroItem: Integer;
    objProtesto: TProtestoPJ;
  Begin
    intPrimeiroItem := varTBody.children.length;
    For j := 0 to varTBody.children.length - 1 Do
    Begin
      If ContainsText(varTBody.children.item(j).InnerText, 'Últimas Ocorrências') Then
      Begin
        intPrimeiroItem := j + 2;
        Break;
      End;
    End;

    For j := intPrimeiroItem to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objProtesto := TProtestoPJ.Create;
      objProtesto.pParseHtml(elTr);
      FUltimosProtestos.Add(objProtesto);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParseCabecalho(el);
      pParseItens(el);
      Break;
    End;
  End;
end;

{ TAcaoPJ }

function TAcaoPJ.fGetRelatorio: String;
begin
  Result := 'Quantidade:         ' + IntToStr(FQuantidade) + #13#10 +
            'Tipo de ocorrência: ' + FTipo + #13#10 +
            'Data:               ' + FData + #13#10 +
            'Vara:               ' + FVara + #13#10 +
            'UF:                 ' + FUF + #13#10 +
            'Cidade:             ' + FCidade + #13#10;
end;

procedure TAcaoPJ.pParseHtml(varElement: OleVariant);
begin
  FQuantidade := Trunc(fStrToFloat(Trim(varElement.children.item(0).innerText)));
  FTipo       := Trim(varElement.children.item(1).innerText);
  FData       := Trim(varElement.children.item(2).innerText);
  FVara       := Trim(varElement.children.item(3).innerText);
  FUF         := Trim(varElement.children.item(4).innerText);
  FCidade     := Trim(varElement.children.item(5).innerText);
end;

{ TAcoesPJ }

constructor TAcoesPJ.Create;
begin
  inherited Create;
  FAcoes := TObjectList<TAcaoPJ>.Create();
end;

destructor TAcoesPJ.Destroy;
begin
  FreeAndNil(FAcoes);
  inherited;
end;

function TAcoesPJ.fGetCount: Integer;
begin
  Result := FAcoes.Count;
end;

function TAcoesPJ.fGetRelatorio: String;
Var
  objAcao: TAcaoPJ;
begin
  If FAcoes.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '          RECUPERAÇÕES, FALÊNCIAS E AÇÕES JUDICIAIS          ' + #13#10 +
              '-------------------------------------------------------------' + #13#10;

    For objAcao In FAcoes Do
    Begin
      If objAcao <> FAcoes.First Then
        Result := Result + '-------------------------------------------------------------' + #13#10;

      Result := Result + objAcao.fGetRelatorio;
    End;

    Result := Result + #13#10;
  End;
end;

procedure TAcoesPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    objAcao: TAcaoPJ;
  Begin
    For j := 1 to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objAcao := TAcaoPJ.Create;
      objAcao.pParseHtml(elTr);
      FAcoes.Add(objAcao);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParseItens(el);
      Break;
    End;
  End;
end;

{ TComportamentoPagamentoPJ }

function TComportamentoPagamentoPJ.fGetRelatorio: String;
begin
  Result := 'Fornecedores:                  ' + IntToStr(FQtdFornecedores) + #13#10 +
            'Títulos:                       ' + IntToStr(FQtdTitulos) + #13#10 +
            'À Vista (%):                   ' + FormatFloat('#,##0.00', FAVista) + #13#10 +
            'Pontual (%):                   ' + FormatFloat('#,##0.00', FPotual) + #13#10 +
            '6 a 15 dias de atraso (%):     ' + FormatFloat('#,##0.00', FAtraso6_15) + #13#10 +
            '16 a 30 dias de atraso (%):    ' + FormatFloat('#,##0.00', FAtraso16_30) + #13#10 +
            '31 a 60 dias de atraso (%):    ' + FormatFloat('#,##0.00', FAtraso31_60) + #13#10 +
            'Mais de 60 dias de atraso (%): ' + FormatFloat('#,##0.00', FAtraso61_) + #13#10 +
            'Atraso médio (dias):           ' + FormatFloat('#,##0.00', FAtrasoMedio) + #13#10;
end;

procedure TComportamentoPagamentoPJ.pParseHtml(varElement: OleVariant);
begin
  FQtdFornecedores := Trunc(fStrToFloat(Trim(varElement.children.item(1).innerText)));
  FQtdTitulos      := Trunc(fStrToFloat(Trim(varElement.children.item(2).innerText)));
  FAVista          := fStrToFloat(Trim(varElement.children.item(3).innerText));
  FPotual          := fStrToFloat(Trim(varElement.children.item(4).innerText));
  FAtraso6_15      := fStrToFloat(Trim(varElement.children.item(5).innerText));
  FAtraso16_30     := fStrToFloat(Trim(varElement.children.item(6).innerText));
  FAtraso31_60     := fStrToFloat(Trim(varElement.children.item(7).innerText));
  FAtraso61_       := fStrToFloat(Trim(varElement.children.item(8).innerText));
  FAtrasoMedio     := fStrToFloat(Trim(varElement.children.item(9).innerText));
end;

{ TComportamentosPagamentoPJ }

constructor TComportamentosPagamentoPJ.Create;
begin
  inherited Create;
  FComportamentos := TObjectList<TComportamentoPagamentoPJ>.Create();
end;

destructor TComportamentosPagamentoPJ.Destroy;
begin
  FreeAndNil(FComportamentos);
  inherited;
end;

function TComportamentosPagamentoPJ.fGetRelatorio: String;
Var
  objComp: TComportamentoPagamentoPJ;
begin
  If FComportamentos.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                 COMPORTAMENTO DE PAGAMENTOS                 ' + #13#10 +
              '-------------------------------------------------------------' + #13#10;

    For objComp In FComportamentos Do
    Begin
      If objComp <> FComportamentos.First Then
        Result := Result + '-------------------------------------------------------------' + #13#10;

      Result := Result + objComp.fGetRelatorio;
    End;

    Result := Result + #13#10;
  End;
end;

procedure TComportamentosPagamentoPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    objComp: TComportamentoPagamentoPJ;
  Begin
    For j := 2 to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objComp := TComportamentoPagamentoPJ.Create;
      objComp.pParseHtml(elTr);
      FComportamentos.Add(objComp);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParseItens(el);
      Break;
    End;
  End;
end;

{ TReferenciasNegociosPJ }

function TReferenciasNegociosPJ.fGetRelatorio: String;
begin
  If (FValorUltimaCompra > 0) Or (FValorMaiorFatura > 0) Or (FValorMaiorCredito > 0) Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '                   REFERÊNCIAIS DE NEGÓCIOS                  ' + #13#10 +
              '-------------------------------------------------------------' + #13#10 +
              'Data da última compra:  ' + FDataUltimaCompra + #13#10 +
              'Valor da última compra: ' + FormatFloat('#,##0.00', FValorUltimaCompra) + #13#10 +
              'Média da última compra: ' + FormatFloat('#,##0.00', FMediaUltimacompra) + #13#10 +
              'Data da maior fatura:   ' + FDataMaiorFatura + #13#10 +
              'Valor da maior fatura:  ' + FormatFloat('#,##0.00', FValorMaiorFatura) + #13#10 +
              'Média da maior fatura:  ' + FormatFloat('#,##0.00', FMediaMaiorFatura) + #13#10 +
              'Data do maior crédito:  ' + FDataMaiorCredito + #13#10 +
              'Valor do maior crédito: ' + FormatFloat('#,##0.00', FValorMaiorCredito) + #13#10 +
              'Média do maior crédito: ' + FormatFloat('#,##0.00', FMediaMaiorCredito) + #13#10 + #13#10;
  End;
end;

procedure TReferenciasNegociosPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseInfo(varTBody: OleVariant);
  Begin
    If ContainsText(varTBody.children.item(1).children.item(0).InnerText, 'Última Compra') Then
    Begin
      FDataUltimaCompra  := varTBody.children.item(1).children.item(1).InnerText;
      FValorUltimaCompra := fStrToFloat(varTBody.children.item(1).children.item(2).InnerText);
      FMediaUltimacompra := fStrToFloat(varTBody.children.item(1).children.item(3).InnerText);
    End;
    If ContainsText(varTBody.children.item(2).children.item(0).InnerText, 'Maior Fatura') Then
    Begin
      FDataMaiorFatura  := varTBody.children.item(2).children.item(1).InnerText;
      FValorMaiorFatura := fStrToFloat(varTBody.children.item(2).children.item(2).InnerText);
      FMediaMaiorFatura := fStrToFloat(varTBody.children.item(2).children.item(3).InnerText);
    End;
    If ContainsText(varTBody.children.item(3).children.item(0).InnerText, 'Maior Crédito') Then
    Begin
      FDataMaiorCredito  := varTBody.children.item(3).children.item(1).InnerText;
      FValorMaiorCredito := fStrToFloat(varTBody.children.item(3).children.item(2).InnerText);
      FMediaMaiorCredito := fStrToFloat(varTBody.children.item(3).children.item(3).InnerText);
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      pParseInfo(el);
      Break;
    End;
  End;
end;

{ TPendenciaPJ }

function TPendenciaPJ.fGetRelatorio: String;
begin
  Result := '-------------------------------------------------------------' + #13#10 +
            'Data:   ' + FData + #13#10 +
            'Credor: ' + FCredor + #13#10 +
            'Valor:  ' + FormatFloat('#,##0.00', FValor) + #13#10;
end;

procedure TPendenciaPJ.pParseHtml(varElement: OleVariant);
begin
  FData   := Trim(varElement.children.item(0).innerText);
  FCredor := Trim(varElement.children.item(1).innerText);
  FValor  := fStrToFloat(Trim(varElement.children.item(2).innerText));
end;

{ TPendenciasPJ }

constructor TPendenciasPJ.Create;
begin
  inherited Create;
  FPendencias := TObjectList<TPendenciaPJ>.Create();
end;

destructor TPendenciasPJ.Destroy;
begin
  FreeAndNil(FPendencias);
  inherited;
end;

function TPendenciasPJ.fGetRelatorio: String;
Var
  objPendencia: TPendenciaPJ;
begin
  If FPendencias.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '             PENDÊNCIAS E RESTRIÇÕES FINANCEIRAS             ' + #13#10 +
              '-------------------------------------------------------------' + #13#10 +
              'Total de Pendências: ' + IntToStr(FQtdPendencias) + #13#10 +
              'Total de Credores;   ' + IntToStr(FQtdCredores) + #13#10 +
              'Valor:               ' + FormatFloat('#,##0.00', FValorTotal) + #13#10 +
              'Data do primeiro:    ' + FDataPrimeiro + #13#10 +
              'Valor do primeiro:   ' + FormatFloat('#,##0.00', FValorPrimeiro) + #13#10 +
              'Data do maior:       ' + FDataMaior + #13#10 +
              'Valor do maior:      ' + FormatFloat('#,##0.00', FValorMaior) + #13#10;

    For objPendencia In FPendencias Do
      Result := Result + objPendencia.fGetRelatorio;

    Result := Result + #13#10;
  End;
end;

procedure TPendenciasPJ.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;

  procedure pParseCabecalho(varTBody: OleVariant);
  Var
    strContent: String;
  Begin
    If varTBody.children.item(0).children.length > 0 Then
    Begin
      strContent := varTBody.children.item(0).children.item(0).InnerText;
      If ContainsText(strContent, 'Total de Pendências:') Then
      Begin
        strContent := Trim(fReplaceStr(strContent, 'Total de Pendências:', ''));
        FQtdPendencias := Trunc(fStrToFloat(strContent));
      End;
    End;

    If varTBody.children.item(0).children.length > 1 Then
    Begin
      strContent := varTBody.children.item(0).children.item(1).InnerText;
      If ContainsText(strContent, 'Total de Credores:') Then
      Begin
        strContent := Trim(fReplaceStr(strContent, 'Total de Credores:', ''));
        FQtdCredores := Trunc(fStrToFloat(strContent));
      End;
    End;

    If varTBody.children.item(0).children.length > 2 Then
    Begin
      strContent := varTBody.children.item(0).children.item(2).InnerText;
      If ContainsText(strContent, 'Valor (R$):') Then
      Begin
        strContent := Trim(fReplaceStr(strContent, 'Valor (R$):', ''));
        FValorTotal := fStrToFloat(strContent);
      End;
    End;

    If varTBody.children.length > 2 Then
    Begin
      If ContainsText(varTBody.children.item(2).children.item(0).InnerText, 'Primeiro') Then
      Begin
        FDataPrimeiro := varTBody.children.item(2).children.item(1).InnerText;
        FValorPrimeiro := fStrToFloat(varTBody.children.item(2).children.item(2).InnerText);
      End;
    End;

    If varTBody.children.length > 3 Then
    Begin
      If ContainsText(varTBody.children.item(3).children.item(0).InnerText, 'Maior') Then
      Begin
        FDataMaior := varTBody.children.item(3).children.item(1).InnerText;
        FValorMaior := fStrToFloat(varTBody.children.item(3).children.item(2).InnerText);
      End;
    End;
  End;

  procedure pParseItens(varTBody: OleVariant);
  Var
    elTr: OleVariant;
    j: Integer;
    objPendencia: TPendenciaPJ;
  Begin
    For j := 2 to varTBody.children.length - 1 Do
    Begin
      elTr := varTBody.children.item(j);
      objPendencia := TPendenciaPJ.Create;
      objPendencia.pParseHtml(elTr);
      FPendencias.Add(objPendencia);
    End;
  End;

  function fVerPrimeiroTR(varElement: OleVariant; strTitulo: String): Boolean;
  Var
    elTr: OleVariant;
    k: Integer;
  Begin
    Result := False;
    For k := 0 to varElement.parentElement.all.length - 1 Do
    Begin
      elTr := varElement.parentElement.all.item(k);
      If (elTr.tagName = 'TR') Then
      Begin
        Result := ContainsText(elTr.innerText, strTitulo);
        Break;
      End;
    End;
  End;

begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TBODY') Then
    Begin
      If fVerPrimeiroTR(el, 'PENDÊNCIAS E RESTRIÇÕES FINANCEIRAS') Then
        pParseCabecalho(el);
      If fVerPrimeiroTR(el, 'Últimas Ocorrências') Then
        pParseItens(el);
    End;
  End;
end;

{ TDevolucaoCCF_PF }

function TDevolucaoCCF_PF.fGetRelatorio: String;
begin
  Result := 'Nome:       ' + FNome    + #13#10 +
            'Banco:      ' + FBanco   + #13#10 +
            'Agência:    ' + FAgencia + #13#10 +
            'Motivo:     ' + FMotivo  + #13#10 +
            'Quantidade: ' + IntToStr(FQuantidade) + #13#10 +
            'Último:     ' + FUltimaDevolucao      + #13#10;
end;

procedure TDevolucaoCCF_PF.pParseHtml(varElement: OleVariant);
begin
  FNome       := Trim(varElement.children.item(0).innerText);
  FBanco      := Trim(varElement.children.item(1).innerText);
  FAgencia    := Trim(varElement.children.item(2).innerText);
  FMotivo     := Trim(varElement.children.item(3).innerText);
  FQuantidade := Trunc(fStrToFloat(Trim(varElement.children.item(4).innerText)));
  FUltimaDevolucao := Trim(varElement.children.item(5).innerText);
end;

{ TDevolucoesCCF_PF }

constructor TDevolucoesCCF_PF.Create;
begin
  inherited Create;
  FDevolucoes:= TObjectList<TDevolucaoCCF_PF>.Create();
end;

destructor TDevolucoesCCF_PF.Destroy;
begin
  FreeAndNil(FDevolucoes);
  inherited;
end;

function TDevolucoesCCF_PF.fGetQtdDevolucoes: Integer;
Var
  objDevolucao: TDevolucaoCCF_PF;
  intQtd: Integer;
begin
  intQtd := 0;
  If FDevolucoes.Count > 0 Then
  begin
    For objDevolucao In FDevolucoes Do
      intQtd := intQtd + objDevolucao.FQuantidade;
  end;

  Result := intQtd;
end;

function TDevolucoesCCF_PF.fGetRelatorio: String;
Var
  objDevolucao: TDevolucaoCCF_PF;
begin
  If FDevolucoes.Count > 0 Then
  Begin
    Result := '-------------------------------------------------------------' + #13#10 +
              '               Devoluções Informadas pelo CCF                ' + #13#10 +
              '-------------------------------------------------------------' + #13#10;

    For objDevolucao In FDevolucoes Do
    Begin
      If objDevolucao <> FDevolucoes.First Then
        Result := Result + '-------------------------------------------------------------' + #13#10;

      Result := Result + objDevolucao.fGetRelatorio;
    End;

    Result := Result + #13#10;
  End;

end;

procedure TDevolucoesCCF_PF.pParseHtml(varElement: OleVariant);
Var
  el: OleVariant;
  i: Integer;
  objDevolucao: TDevolucaoCCF_PF;
begin
  For i := 0 to varElement.all.length - 1 Do
  Begin
    el := varElement.all.item(i);
    If (el.tagName = 'TR') and ((el.className = 'consultaant') or (el.className = 'consultaantz')) Then
    Begin
      objDevolucao := TDevolucaoCCF_PF.Create;
      objDevolucao.pParseHtml(el);
      FDevolucoes.Add(objDevolucao);
    End;
  End;

end;

end.
