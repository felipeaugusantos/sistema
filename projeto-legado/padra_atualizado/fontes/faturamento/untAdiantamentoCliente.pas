unit untAdiantamentoCliente;

interface

uses
  Classes, SysUtils, StrUtils, Uni, untTypesSistema,
  untTefRecebimento, untCadChq, untFormaPagtoNegociada,
  UniClientDataSet, Forms, Variants, Controls, Math,
  untGravaMovCar, StdCtrls, DB, cxProgressBar, untRcxRecbBaixDocs, Winapi.Windows,
  untTCadRec, untTCadRecRepository, untTCadcliRepository, untTLock,
  Yapay.Api.Facade, System.Generics.Collections, untCtrReciboAdiantamento,
  untConstantes, untTiposPix, untTPixDao, untTefCitelUtil, untTefCitelPagueFacil,
  untTSituacaoPedidoVenda, untPreparaGeracaoTE, untInterfaceTefCitel, untRcxTResumoDeCaixa;

type
  TAdiantamento = class
    private
      blnEstornouTransacaoPendente : Boolean;
      FInfAdiantamento: TDadosAdiantamento;

      FNomeForm: String;

      strSeqRcx: String;

      objTefRecebimento: ITefRecebimento;
      arrCartoes: TCartoesResumoCaixaArray;

      cdsChqVis: TUniClientDataSet;
      cdsChqPre: TUniClientDataSet;

      fltTotCreditos: Double;
      stlDupCreditos: TStringList;
      stlLckCreditos: TStringList;

      objFormasNegociadas: TFormaPagtoNegociada;

      FLabelGravando: TLabel;

      FRegistroPix: TDadosRetornoPixConsulta;

      objTefCitelPagueFacil : ITefCitelPagueFacil;

      objResumoDeCaixa: TResumoDeCaixa;

      type
        TRotinaYapay = class
          type
            TBaixaSintetica = record
              strCodigoPortador: string;
              strPlanoContas: string;
              dtaLancamento: TDateTime;
              strNumeroDocumento: string;
              strHistorico: string;
            end;

            TCartao = record
              strCodigoCartao: string;
              strDescricaoCartao: string;
              strObservacao: string;
              strNumCCD: string;
              strNumNSU: string;
              fltValorOriginal: Double;
              fltValorPago: Double;
              fltValorTaxa: Double;
              strFormaCartao: string;
              intPrazo: int64;
              intDiasExcedentePrimeiraParcela: int64;
              intQuantidadeParcelas: Int64;
              dtaDataCadastro: TDateTime;
            end;
          var
            blnActive: Boolean;
            BaixaSintetica: TBaixaSintetica;
            Cartao: TCartao;
        end;
      var
        objRotinaYapay: TRotinaYapay;

      procedure pInformacaoGravacao(strMsg: String);

      function fValidarFechamentoCaixa(): Boolean;

      function fRealizarAdiantamento(pgbProgresso: TCxProgressBar): Boolean;

      function fDigitacaoCartoes(fltValor: Double): Boolean;

      function fReceberFormaPagamento(strCodFpg: String; fltValor: Double;
                                      strCodCar: String; intQtdPar: Integer): Boolean;

      procedure pCancelarTefDeCartoesJaConfirmados;
      procedure pGarantirCancelamentoTefRecebimento(strArquivo: String);

      procedure pCarregaImpostoProporcional(fltValor: Double; out fltValIpi,
                                            fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is: Double);

      function fChequeVis(fltValor: Double): Boolean;
      function fChequePre(fltValor: Double): Boolean;

      function fLogChq(qryLog: TDataset; intOpcao: Integer): Boolean;

      function fVerificarCheques: Boolean;

      function fGravarAdiantamento: Boolean;
      function fGravaResumoCaixa: Boolean;
      function fGravarCartoes: Boolean;
      function fGravarCheques: Boolean;
      function fBaixarCreditos: Boolean;
      function fGerarCredito: Boolean;
      function fGravaMovimentoBancario: Boolean;

      function fGravarGrynCash: Boolean;

      function fPedeFormasPagto: Boolean;
      function fPedeFormasPagtoRCX: Boolean;
      function fPedeFormasPagtoCTR: Boolean;
      function fPedeFormasPagtoCTRPagueFacil: Boolean;

      function fConfirmarAdiantamento: Boolean;
      function fSelecionarDocumento(strNumDoc, strEspDoc, strCodEmp, strOrigem: String; blnPagueFacil: Boolean; ARecebimentoPorPix: Boolean = False; APagueFacilPix: Boolean = False): Boolean;
      function fInformarDadosClienteConsumidor: Boolean;

      function RetornaPortadorOrdemPagametoPixCaixa(APortadorAtual: String; const blnValidarValor : Boolean): String;

      procedure pAtualizarValorLancamentoDocumentos;

      procedure pImprimirRecibo;

      procedure pCancelarVendaConfirmadaTefCitel;

      function fLiberarPREPTE: Boolean;

      function RealizarTFAutomatica: Boolean;

      class function AdiantamentoRecebidoPorPix(ANumeroDocumento,
                                                AEspecieDocumento,
                                                AEmpresaDocumento: String): Boolean;

      class function RetornaPlanoDeContasPix: String;
      function fRetornaDocumentosTraDoc: TArrayInfoTraDoc ;
      procedure pAlteraStatusTefConfirmadoParaCancelado(const AConfirmado: Boolean);
    protected
      constructor Create(strNomeForm, strCodOpe, strCodigoCaixa: String;
                         blnPagueFacil: Boolean = False; strTipoCartao: string = ''; intParcelas: Integer = 1);

      class function fGetSQLPedidos(strNumDoc: String = '';
                                    blnFiltrarTodasAsLojas: Boolean = False;
                                    objRotinaYapay: TRotinaYapay = nil;
                                    ARecebimentoPorPix: Boolean = False;
                                    APagFacilPix: Boolean = False): String;

    public
      objLock: TLock;

      strCodigoCaixa: String;

      destructor Destroy; override;

      class function fSelecionarCreditos(strCodCli, strOrigem: String; fltValor: Double; Var fltTotCred: Double; Var stlDupCred, stlLckCred: TStringList; strOpeLan: String = ''; objFormasNegociadas : TFormaPagtoNegociada = nil; strCrtDevSintetizadasConfDocs: String = ''): Boolean;

      class function fPermiteAlterarPedidoComAdiantamento: TPermissaoAlteracaoDePedidosQuePossuemAdiantamento;

      class function fCarregaPedidos(qryPedidos: TUniQuery): Boolean;

      class procedure pAtribuiDadosDocumento(qryPedidos: TUniQuery; var documento: TDocAdiantamento);

      class function fPermiteSelecionarPedido(documentos: TArrDocAdiantamento; ARecebidoPorPix: Boolean = False): Boolean; overload;
      class function fPermiteSelecionarPedido(strNumDoc, strEspDoc, strCodEmp, strOrigem: String): Boolean; overload;

      class function fSelecionarPedido(documentos: TArrDocAdiantamento; objLock: TLock;
        objRotinaYapay: TRotinaYapay = nil; ARecebidoPorPix: Boolean = False): Boolean;

      class procedure pConsultarAdiantamentos(strCodOpe: String);Overload;
      class procedure pConsultarAdiantamentos(strCodOpe,strNumPed,strEmpPed: String);Overload;

      class function fCarregarArrayAdiantamentos(intSeqConPar: Integer; strCodEmpPar: String): TArrAdiantamentos;

      class function fCarregarAdiantamentos(strNumDoc, strEspDoc, strCodEmp,strCodCli: String;
                                            qryAdiantamentos: TUniQuery): Boolean;

      class function fGetTotaisAdiantamento(strNumDoc, strEspDoc, strCodEmp: String): TTotaisAdiantamento;

      class function fPossuiCreditoGeradoEmAberto(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
      class function fPossuiCreditoGerado(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

      class function fGetOpeLanAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;

      class function fGetResCaiAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;

      class function fGetCodPorAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;

      class function fGetCodCtaAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;

      class function fAdiantamentoGravadoAutomaticamente(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
      class function fAdiantamentoGravadoAutomaticamentePorSeq(strSeqFgo: String): Boolean;

      class function fRealizarAdiantamentoCliente(strNomForm: String;
                                                  strCodOpe : String;
                                                  strCodigoCaixa: String;
                                                  strNumDoc : String = '';
                                                  strEspDoc : String = '';
                                                  strCodEmp : String = '';
                                                  strOrigem : String = 'RCX';
                                                  blnPagueFacil: Boolean = False;
                                                  strTipoCartao: string = '';
                                                  intParcelas: Integer = 1;
                                                  objResumoDeCaixa: TResumoDeCaixa = nil): Boolean;

      class function RealizarAdiantamentoClientePix(ANomeFormulario: String;
                                                    var ADadosDoPix: TDadosRetornoPixConsulta;
                                                    APagueFacil: Boolean = False;
                                                    AChavePedido: String = ''): Integer;

      class procedure pGravaAdiantamentoDesmembrado(strNumDocAtual,
                                                    strEspDocAtual,
                                                    strCodEmpAtual,
                                                    strNumDocNovo,
                                                    strEspDocNovo,
                                                    strCodEmpNovo: String;
                                                    AdiantamentoDocAtual,
                                                    AdiantamentoDocNovo: TTotaisAdiantamento);

      class function AdiantamentoRealizadoPorPixDeFormaParcial(ADatasetPedido: TDataset): Boolean;


      type
        TParametroRealizarAdiantamentoClienteYapay = class
          strNumDoc : String;
          strEspDoc : String;
          strCodEmp : String;
          intQuantidadeParcelas: integer;
          fltValorOriginal: Double;
          fltValorPago: Double;
          fltValorTaxa: Double;
          intPrazo: integer;
          strOrderNumber: String;
          ConsultaCobranca: TYapayFacade.TConsultaCobranca;
          Transacao: TYapayFacade.TCobrancaTransacao;
        end;
      class function fRealizarAdiantamentoClienteYapay(
        const pObjParametro: TParametroRealizarAdiantamentoClienteYapay): Boolean;

      class function fLancarDebitoAdiantamento(strNumDoc : String;
                                               strEspDoc : String;
                                               strCodEmp : String;
                                               strCodOpe : String;
                                               strDescri : String;
                                               fltValDeb : Double;
                                               intSeqCon : Integer;
                                               Var Totais: TTotaisAdiantamento;
                                               strCodCli_: String = '';
                                               strEmpBai : String = ''): Boolean;

      class function fLancarCreditoAdiantamento(strNumDoc : String;
                                                strEspDoc : String;
                                                strCodEmp : String;
                                                strCodOpe : String;
                                                strDescri : String;
                                                intSeqCon : Integer;
                                                AAutoIncremRegistro: String = ''): Boolean;

      class function fGerarCreditoSaldoAdiantamento(strNumDoc,
                                                    strEspDoc,
                                                    strCodEmp,
                                                    strNomeForm,
                                                    strCodOpe    : String;
                                                    blnPerguntar : Boolean = True;
                                                    strCodCli_   : String  = '';
                                                    fltValorCred : Double = 0.0;
                                                    intSeqConRcxExterno: Integer = -1;
                                                    strHisAdc: String = ''): Boolean;

      class function fEstornarCreditoGeradoAdiantamento(strNumDoc,
                                                        strEspDoc,
                                                        strCodEmp,
                                                        strNomeForm,
                                                        strCodOpe: String): Boolean;

      class function fAdiantamentoPossuiDebitos(strNumDoc,
                                                strEspDoc,
                                                strCodEmp,
                                                strCodCli: String;
                                                blnIgnorarEstornos: Boolean = True): Boolean;

      class function fAdiantamentoPodeSerEstornadoPeloFinanceiro(strNumDoc,
                                                                 strEspDoc,
                                                                 strCodEmp,
                                                                 strCodCli: String;
                                                                 fltValorAdiantamento: Double): Boolean;

      class function fEstornarAdiantamento(strAutIncLan: String): Boolean;

      class function fPedeValorAdiantamento(strNumDoc, strEspDoc, strCodEmp, strOrigem: String): Double; overload;
      class function fPedeValorAdiantamento(documentos: TArrDocAdiantamento): Double; overload;

      class function fHouveAlteracoesNoPedido(qryPedidos: TUniQuery): Boolean;

      class function fCarregarDadosPedido(qryPedidos: TUniQuery;
        var documentos: TArrDocAdiantamento; strOrigem: String; ARecebimentoPorPix: Boolean = False): Boolean;

      class function fAdiantamentoPossuiCreditosBaixados(strCodEmp: String;
                                                         intSeqCon: Integer): Boolean;

      class function fTrocaClienteAdiantamento(strNumDoc,
                                               strEspDoc,
                                               strCodEmp,
                                               strCodCliNov: String): Boolean;

      class procedure pDesmembraAdiantamento(strNumDocAtual,
                                             strEspDocAtual,
                                             strCodEmpAtual,
                                             strNumDocNovo,
                                             strEspDocNovo,
                                             strCodEmpNovo: String;
                                             fltTotalPedido,
                                             fltTotalPedidoNovo: Double);

      class Procedure pAtualizaDataLanctoAdiantamento(const IntSeqConAdiant: Integer; const strCodEmp : String; const dtDataMovBancaria : TDatetime; const strSeqBan : String; const blnApenasOrdemPagto : Boolean = False);
      class procedure pAtualizaVinculoComCredito(const strNumDoc, strEspDoc, strCodEmp, strCTR_CC : String);

      class function fGravaEstornoMovimentoBancario(ANumDoc: String;
                                                    AEspdoc: String;
                                                    ACodEmp: String;
                                                    ACodCli: String;
                                                    ADescri: String): Boolean;
  end;

  TReciboAdiantamento = class
    private
      qryCfgRel: TUniQuery;
      cdsImpRec: TUniClientDataSet;
      cdsChqVis: TUniClientDataSet;
      cdsChqPre: TUniClientDataSet;

      FSeqCon: Integer;
      FEmpLan: String;
      FOpeLan: String;
      FOrigem: String;

      arrCodCli : Array Of TRcxDadosCliente;
      recValRec : TRcxValoresReceb;

      FArrAdiantamentos: TArrAdiantamentos;

      procedure pCarregarDuplicatas;
      procedure pCarregarCheques;
    public
      constructor Create(intSeqCon: Integer; strEmpLan: String; strOrigem: String);
      destructor Destroy; override;

      procedure pImprimirRecibo;
  end;

Const
  strFormasPagtoAdiantamento: String = '001_002_006_007_009_012_013_';

implementation

uses
  {$IFNDEF LINUX}
    untArredondaParcelasCartoes,
  {$ENDIF LINUX}
  untFuncoesSimples, untSelPedidoAdiantamento,
  untRcxMostraCartoes, untRcxDigCartoes, untFunTef,
  untFuncoes, untCadCheques, untFuncFat, untCadRcxx,
  untRcxDigMoedas, untMovCar, untFuncoesGenerica,
  untQckRcxReciboCB, untReciboCtr, untCfgRel,
  untFastPrintEditor, untConsultarAdiantamentos,
  untGravando, untCadRec, untTCadChqRepository,
  untFatDadosCliConsumidor, untObservacao,
  untAgrupDuplicatas, untFuncoesCaixa, untSelOpcoes,
  untDuplicatas, untArredondaParcelaImpl,
  untBaixaSintetica, untFatFormasPagamento,
  untMovBan, untTBanCtrRepository,
  untAdiantamentoClienteGenerico,
  untFatGor, untMovTef, untGryncash, untTFuncoesPixAutcom,
  untLogCtr;

{ TAdiantamento }

class function TAdiantamento.fRealizarAdiantamentoCliente(strNomForm: String;
                                                          strCodOpe : String;
                                                          strCodigoCaixa: String;
                                                          strNumDoc : String = '';
                                                          strEspDoc : String = '';
                                                          strCodEmp : String = '';
                                                          strOrigem : String = 'RCX';
                                                          blnPagueFacil: Boolean = False;
                                                          strTipoCartao: string = '';
                                                          intParcelas: Integer = 1;
                                                          objResumoDeCaixa: TResumoDeCaixa = nil): Boolean;
  Var
    objAdiantamento      : TAdiantamento;
    blnReabrirSelecao    : Boolean;
    objParametrosMensagem: TParametrosMensagem;
    intContador          : Integer;
begin
  pLimparTrilhaMensagensTotem;

  Repeat
    If fEmptyStr(strCodOpe) Then
      strCodOpe := strLoginUsuarioLogado;

    objAdiantamento := TAdiantamento.Create(strNomForm, strCodOpe, strCodigoCaixa, blnPagueFacil, strTipoCartao, intParcelas);
    objAdiantamento.objResumoDeCaixa := objResumoDeCaixa;

    Try
      If Not objAdiantamento.fSelecionarDocumento(strNumDoc, strEspDoc, strCodEmp, strOrigem, blnPagueFacil) Then
        Exit(False);

      If strOrigem = 'RCX' Then
        If Not objAdiantamento.fInformarDadosClienteConsumidor Then
          Exit(False);


      If (TYapayFacade.fPedidoPossuiCobrancaAtiva(strNumDoc, strEspDoc, strCodEmp)) and
              (not TYapayFacade.fPedidoFoiPago(strNumDoc, strEspDoc, strCodEmp)) then
      begin
        objParametrosMensagem := TParametrosMensagem.Create;
        Try
          objParametrosMensagem.Titulo := 'Yapay';
          objParametrosMensagem.Texto := 'Pedido possuí Cobrança Yapay ativa!';
          objParametrosMensagem.Opcoes := ['&OK'];
          objParametrosMensagem.Url.Caption := 'Visualizar cobrança';
          objParametrosMensagem.Url.Href :=
            TYapayFacade.fLinkPagamento(TYapayFacade.fGetAutIncFatGor(strNumDoc, strEspDoc, strCodEmp));
          fMensagem(objParametrosMensagem);
        finally
          objParametrosMensagem.Free;
        end;
        Exit(False);
      end;

      Result := fChamaTelaGravando(objAdiantamento.fRealizarAdiantamento);

      If Result Then
      begin
        pMensagemOk('Adiantamento realizado com sucesso!');

        if VS_blnTefCitel then
        begin
          for intContador := 0 to length(objAdiantamento.arrCartoes) -1 do
          begin
            if fVerificaUtilizouTEFCitel(objAdiantamento.arrCartoes[intContador].strViaCli, objAdiantamento.arrCartoes[intContador].strViaLoj) then
            begin
              if objAdiantamento.arrCartoes[intContador].blnTefCnf then
              begin
                pAtualizaDadosFaturamentoTef(
                  '',
                  '',
                  IntToStr(objAdiantamento.FInfAdiantamento.intSeqCon),
                  objAdiantamento.arrCartoes[intContador].strViaCli,
                  objAdiantamento.arrCartoes[intContador].strViaLoj,
                  objAdiantamento.arrCartoes[intContador].strNumDoc,
                  objAdiantamento.arrCartoes[intContador].strDtaTra);
              end
              else
              begin
                if fFinalizaCartao(objAdiantamento.arrCartoes[intContador].strNumDoc,
                                   objAdiantamento.arrCartoes[intContador].strDtaTra,
                                   objAdiantamento.arrCartoes[intContador].strHraTra,
                                   objAdiantamento.arrCartoes[intContador].strViaCli,
                                   objAdiantamento.arrCartoes[intContador].strViaLoj,
                                   objAdiantamento.arrCartoes[intContador].strNumNsu,
                                   '',
                                   '',
                                   objAdiantamento.arrCartoes[intContador].fltValDig,
                                   objAdiantamento.arrCartoes[intContador].strViaCli + #13 + objAdiantamento.arrCartoes[intContador].strViaLoj,
                                   IntToStr(objAdiantamento.FInfAdiantamento.intSeqCon),
                                   objAdiantamento.arrCartoes[intContador].strControle) then
                begin
                  objAdiantamento.arrCartoes[intContador].strStatusCartao := 'F';
                end;
              end;
            end;
          end;
        end;
      end;

      blnReabrirSelecao := fEmptyStr(strNumDoc);
      objAdiantamento.pAlteraStatusTefConfirmadoParaCancelado(Result);
    Finally
      FreeAndNil(objAdiantamento);
    End;
  Until Not blnReabrirSelecao;
end;

class function TAdiantamento.RetornaPlanoDeContasPix: String;
begin
  Result := fCfgSis('CTAPIX', varString);

  If Result.IsEmpty Then
    Result := fCfgSis('CTAAVI', varString);
end;

function TAdiantamento.RetornaPortadorOrdemPagametoPixCaixa(
  APortadorAtual: String; const blnValidarValor : Boolean): String;
begin
  Result := APortadorAtual;

  If FInfAdiantamento.RecebidoPorPix Then
  Begin
    FRegistroPix.SeqConTransferencia := StrToInt(fRetRcxCon);

    If (Not blnValidarValor) Then
      Result := TPixDao.Create.RetornaPortadorChavePix(FRegistroPix.AutoIncremChavePix)
    Else If fFormataFloat(FInfAdiantamento.fltValLan, 2) = fFormataFloat(FRegistroPix.ValorPago, 2) Then
      Result := TPixDao.Create.RetornaPortadorChavePix(FRegistroPix.AutoIncremChavePix);

    Exit;
  End;

  If IfNull(FInfAdiantamento.ValorTFAutomatica, 0) > 0 Then
  Begin
    If Not FInfAdiantamento.PortadorTFAutomatica.IsEmpty Then
    Begin
      If (Not blnValidarValor) Then
        Result := FInfAdiantamento.PortadorTFAutomatica
      Else If fFormataFloat(FInfAdiantamento.fltValLan, 2) = fFormataFloat(FInfAdiantamento.fltValOrd, 2) Then
        Result := FInfAdiantamento.PortadorTFAutomatica;
    End;
  End;
end;

class function TAdiantamento.fLancarCreditoAdiantamento(strNumDoc, strEspDoc,
  strCodEmp, strCodOpe, strDescri: String; intSeqCon: Integer; AAutoIncremRegistro: String = ''): Boolean;
  Var
    dadosCredito: TDadosAdiantamento;
    documento   : TDocAdiantamento;
    objTotais   : TTotaisAdiantamento;
    qryConsulta : TUniQuery;
begin
  objTotais := fGetTotaisAdiantamento(strNumDoc, strEspDoc, strCodEmp);

  If objTotais.fltValLan <> 0.00 Then
    Raise Exception.Create('O saldo do adiantamento deve estar zerado para utilizar essa função!');

  qryConsulta := fCriaQuery;
  qryConsulta.SQL.Add('SELECT * FROM ADTCLI     ');

  If AAutoIncremRegistro.IsEmpty Then
  Begin
    qryConsulta.SQL.Add('WHERE ADT_NUMDOC=:NUMDOC ');
    qryConsulta.SQL.Add('  AND ADT_ESPDOC=:ESPDOC ');
    qryConsulta.SQL.Add('  AND ADT_CODEMP=:CODEMP ');
    qryConsulta.SQL.Add('  AND ADT_SEQCON=:SEQCON ');
    qryConsulta.SQL.Add('  AND ADT_TIPLAN="D"     ');
    qryConsulta.SQL.Add('ORDER BY ADT_DTALAN DESC,');
    qryConsulta.SQL.Add('         ADT_HORLAN DESC ');

    qryConsulta.ParamByName('NUMDOC').AsString  := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString  := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString  := strCodEmp;
    qryConsulta.ParamByName('SEQCON').AsInteger := intSeqCon;
  End
  Else
    qryConsulta.SQL.Add('WHERE AUTOINCREM="' + AAutoIncremRegistro + '"');

  qryConsulta.Open;

  documento.strNumDoc := strNumDoc;
  documento.strEspDoc := strEspDoc;
  documento.strCodEmp := strCodEmp;
  documento.strCodCli := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, 'CODCLI');
  documento.fltValLan := qryConsulta.FieldByName('ADT_VALLAN').AsFloat;

  dadosCredito.AddDocumento(documento);

  dadosCredito.strTipLan := 'C';
  dadosCredito.dtaDtaLan := VS_Date;
  dadosCredito.horHorLan := fTime();
  dadosCredito.strOpeLan := strCodOpe;
  dadosCredito.strEmpLan := VS_strCodEmp;
  dadosCredito.intSeqCon := intSeqCon;
  dadosCredito.strDescri := strDescri;
  dadosCredito.fltValLan := qryConsulta.FieldByName('ADT_VALLAN').AsFloat;
  dadosCredito.fltValDin := qryConsulta.FieldByName('ADT_VALDIN').AsFloat;
  dadosCredito.fltValChV := qryConsulta.FieldByName('ADT_VALCHV').AsFloat;
  dadosCredito.fltValChP := qryConsulta.FieldByName('ADT_VALCHP').AsFloat;
  dadosCredito.fltValCar := qryConsulta.FieldByName('ADT_VALCAR').AsFloat;
  dadosCredito.fltValOrd := qryConsulta.FieldByName('ADT_VALORD').AsFloat;
  dadosCredito.fltValFin := qryConsulta.FieldByName('ADT_VALFIN').AsFloat;
  dadosCredito.fltValCre := qryConsulta.FieldByName('ADT_VALCRE').AsFloat;
  dadosCredito.strEstorn := 'S';

  dadosCredito.RecebidoPorPix := False;

  Result := TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosCredito);

  If Result Then
  Begin
    qryConsulta.Edit;
    qryConsulta.FieldByName('ADT_ESTORN').AsString := 'S';
    qryConsulta.Post;
  End;

  FreeAndNil(qryConsulta);
end;

class function TAdiantamento.fLancarDebitoAdiantamento(strNumDoc,
                                                       strEspDoc,
                                                       strCodEmp,
                                                       strCodOpe,
                                                       strDescri: String;
                                                       fltValDeb: Double;
                                                       intSeqCon: Integer;
                                                       Var Totais: TTotaisAdiantamento;
                                                       strCodCli_: String = '';
                                                       strEmpBai : String = ''): Boolean;
Var
  dadosDebito: TDadosAdiantamento;
  documento: TDocAdiantamento;
  fltValModRes: Double;
begin
  {*********************************************************}
  {* CARREGA O VALOR TOTAL DO ADIANTAMENTO(S) DO PEDIDO    *}
  {******************************************************JC*}
  Totais := fGetTotaisAdiantamento(strNumDoc, strEspDoc, strCodEmp);

  If Totais.fltValLan <= 0.00 Then
  Begin
    Raise Exception.Create('Não foi encontrado saldo dísponível ' +
                           'para cálculo do lançamento de Débito do ' +
                           'Adiantamento. Verifique os adiantamentos do(s) ' +
                           'pedido(s) selecionados!');
  End;

  {*********************************************************}
  {* CALCULA O VALOR DO DEBITO QUE SERA LANCADO NO PEDIDO  *}
  {******************************************************JC*}
  If Totais.fltValLan > fltValDeb Then
    Totais.fltValLan := fltValDeb;

  {***************************************************}
  {* DEFINE EM UMA VARIAVEL O VALOR DAS MODALIDADES  *}
  {************************************************JC*}
  fltValModRes := Totais.fltValLan;

  {*********************************************************}
  {* CALCULA O VALOR EM DINHEIRO PARA LANCAMENTO DO DEBITO *}
  {******************************************************JC*}
  If fFormataFloat(fltValModRes, 2) = 0.00 Then
    Totais.fltValDin := 0.00;

  If Totais.fltValDin > fltValModRes Then
    Totais.fltValDin := fltValModRes;

  fltValModRes := fltValModRes - Totais.fltValDin;

  {***************************************************************}
  {* CALCULA O VALOR EM CHEQUE A VISTA PARA LANCAMENTO DO DEBITO *}
  {************************************************************JC*}
  If fFormataFloat(fltValModRes, 2) = 0.00 Then
    Totais.fltValChV := 0.00;

  If Totais.fltValChV > fltValModRes Then
    Totais.fltValChV := fltValModRes;

  fltValModRes := fltValModRes - Totais.fltValChV;

  {***********************************************************}
  {* CALCULA O VALOR EM CHEQUE PRE PARA LANCAMENTO DO DEBITO *}
  {********************************************************JC*}
  If fFormataFloat(fltValModRes, 2) = 0.00 Then
    Totais.fltValChP := 0.00;

  If Totais.fltValChP > fltValModRes Then
    Totais.fltValChP := fltValModRes;

  fltValModRes := fltValModRes - Totais.fltValChP;

  {*******************************************************}
  {* CALCULA O VALOR EM CARTAO PARA LANCAMENTO DO DEBITO *}
  {****************************************************JC*}
  If fFormataFloat(fltValModRes, 2) = 0.00 Then
    Totais.fltValCar := 0.00;

  If Totais.fltValCar > fltValModRes Then
    Totais.fltValCar := fltValModRes;

  fltValModRes := fltValModRes - Totais.fltValCar;

  {******************************************************************}
  {* CALCULA O VALOR EM ORDEM DE PAGAMETO PARA LANCAMENTO DO DEBITO *}
  {***************************************************************JC*}
  If fFormataFloat(fltValModRes, 2) = 0.00 Then
    Totais.fltValOrd := 0.00;

  If Totais.fltValOrd > fltValModRes Then
    Totais.fltValOrd := fltValModRes;

  fltValModRes := fltValModRes - Totais.fltValOrd;

  {**************************************************************}
  {* CALCULA O VALOR EM FINANCIAMENTO PARA LANCAMENTO DO DEBITO *}
  {***********************************************************JC*}
  If fFormataFloat(fltValModRes, 2) = 0.00 Then
    Totais.fltValFin := 0.00;

  If Totais.fltValFin > fltValModRes Then
    Totais.fltValFin := fltValModRes;

  fltValModRes := fltValModRes - Totais.fltValFin;

  {***********************************************************************}
  {* CALCULA O VALOR EM UTILIZACAO DE CREDITOS PARA LANCAMENTO DO DEBITO *}
  {********************************************************************JC*}
  If fFormataFloat(fltValModRes, 2) = 0.00 Then
    Totais.fltValCre := 0.00;

  If Totais.fltValCre > fltValModRes Then
    Totais.fltValCre := fltValModRes;

  fltValModRes := fltValModRes - Totais.fltValCre;

  {******************************************************************************}
  {* VALIDA SE O VALOR DAS MODALIDADES ESTA DE ACORDO COM O TOTAL DO LANCAMENTO *}
  {***************************************************************************JC*}
  If (fFormataFloat(fltValModRes    , 2) <> fFormataFloat(0, 2)) Or
     (fFormataFloat(Totais.fltValLan, 2) <> fFormataFloat(Totais.fltValDin +
                                                          Totais.fltValChV +
                                                          Totais.fltValChP +
                                                          Totais.fltValCar +
                                                          Totais.fltValOrd +
                                                          Totais.fltValFin +
                                                          Totais.fltValCre, 2)) Then
  Begin
    Raise Exception.Create('Ocorreu um erro no cálculo do lançamento de Débito do ' +
                           'Adiantamento. Favor entrar em contato com a Citel!');
  End;

  documento.strNumDoc := strNumDoc;
  documento.strEspDoc := strEspDoc;
  documento.strCodEmp := strCodEmp;

  If Not fEmptyStr(strCodCli_) Then
    documento.strCodCli := strCodCli_
  Else
    documento.strCodCli := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, 'CODCLI');

  documento.fltValLan := Totais.fltValLan;

  dadosDebito.AddDocumento(documento);

  dadosDebito.strTipLan := 'D';
  dadosDebito.dtaDtaLan := VS_Date;
  dadosDebito.horHorLan := fRetHoraServidor;
  dadosDebito.strOpeLan := strCodOpe;
  dadosDebito.strEmpLan := IIF(Not fEmptyStr(strEmpBai), strEmpBai, VS_strCodEmp);
  dadosDebito.intSeqCon := intSeqCon;
  dadosDebito.strDescri := strDescri;
  dadosDebito.fltValLan := Totais.fltValLan;
  dadosDebito.fltValDin := Totais.fltValDin;
  dadosDebito.fltValChV := Totais.fltValChV;
  dadosDebito.fltValChP := Totais.fltValChP;
  dadosDebito.fltValCar := Totais.fltValCar;
  dadosDebito.fltValOrd := Totais.fltValOrd;
  dadosDebito.fltValFin := Totais.fltValFin;
  dadosDebito.fltValCre := Totais.fltValCre;

  dadosDebito.RecebidoPorPix := False;

  Result := TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosDebito);
end;

function TAdiantamento.fValidarFechamentoCaixa(): Boolean;
begin
  Result := True;

  If (Not Assigned(objResumoDeCaixa)) Then
    Exit;

  If (objResumoDeCaixa.CaixaJaFoiFechado(VS_Date)) Then
  Begin
    Result := False;
    Exit;
  End;
end;

function TAdiantamento.fRealizarAdiantamento(pgbProgresso: TCxProgressBar): Boolean;
begin
  Try
    if (not objRotinaYapay.blnActive) and
       (Assigned(pgbProgresso)) and
       (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
    begin
      FLabelGravando := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
    end;

    pInformacaoGravacao('Realizando Adiantamento de Cliente ...');

    FInfAdiantamento.RecebidoPorPix := Assigned(FRegistroPix);

    Result := fPedeFormasPagto And
              fValidarFechamentoCaixa And
              fConfirmarAdiantamento;

    if (Result) and
       (not objRotinaYapay.blnActive) and
       (Not FInfAdiantamento.RecebidoPorPix) And
       (fPergunta('Imprimir Recibo?', fCfgSis('SUGREC', varBoolean))) Then
    begin
      pImprimirRecibo;
    end;

  Finally
    FLabelGravando := Nil;
  End;
end;

class procedure TAdiantamento.pConsultarAdiantamentos(strCodOpe: String);
  Var
    frmConsultarAdiantamentos : TfrmConsultarAdiantamentos;
begin
  Try
    pCriarFormularios(TfrmConsultarAdiantamentos, frmConsultarAdiantamentos);
    frmConsultarAdiantamentos.strCodOpe := strCodOpe;
    frmConsultarAdiantamentos.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmConsultarAdiantamentos);
end;

class function TAdiantamento.fEstornarAdiantamento(strAutIncLan: String): Boolean;
  Var
    qryAdtCli: TUniQuery;
    dadosLan: TDadosAdiantamento;
    documento: TDocAdiantamento;
begin
  qryAdtCli := fCriaQuery;

  With qryAdtCli, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT * FROM ADTCLI WHERE AUTOINCREM = ' + QuotedStr(strAutIncLan));

    Open;

    Edit;
    FieldByName('ADT_ESTORN').AsString := 'S';
    FieldByName('ADT_DTABAN').Clear;
    Post;

    dadosLan.strDescri := 'ESTORNO REF. LANÇAMENTO ('  +
                          'SEQ.BAIXA: ' + FieldByName('ADT_SEQCON').AsString + ' ' +
                          'DATA: '      + FieldByName('ADT_DTALAN').AsString + ' ' +
                          'HORA: '      + FieldByName('ADT_HORLAN').AsString + ' ' +
                          'EMP.: '      + FieldByName('ADT_EMPLAN').AsString + ') ';

    documento.strNumDoc := FieldByName('ADT_NUMDOC').AsString;
    documento.strEspDoc := FieldByName('ADT_ESPDOC').AsString;
    documento.strCodEmp := FieldByName('ADT_CODEMP').AsString;
    documento.strCodCli := FieldByName('ADT_CODCLI').AsString;
    documento.fltValLan := FieldByName('ADT_VALLAN').AsFloat;

    dadosLan.AddDocumento(documento);

    dadosLan.strTipLan := IIF(FieldByName('ADT_TIPLAN').AsString = 'D', 'C', 'D');
    dadosLan.dtaDtaLan := VS_Date;
    dadosLan.horHorLan := fTime();
    dadosLan.strOpeLan := strLoginUsuarioLogado;
    dadosLan.strEmpLan := VS_strCodEmp;
    dadosLan.intSeqCon := 0;  //Estorno nao possui seqcon (usado para identificar os mesmos)
    dadosLan.strEstorn := 'S';//Identifica como estorno de adiantamento
    dadosLan.strOrigem := FieldByName('ADT_ORIGEM').AsString;
    dadosLan.fltValLan := FieldByName('ADT_VALLAN').AsFloat;
    dadosLan.fltValDin := FieldByName('ADT_VALDIN').AsFloat;
    dadosLan.fltValChV := FieldByName('ADT_VALCHV').AsFloat;
    dadosLan.fltValChP := FieldByName('ADT_VALCHP').AsFloat;
    dadosLan.fltValCar := FieldByName('ADT_VALCAR').AsFloat;
    dadosLan.fltValOrd := FieldByName('ADT_VALORD').AsFloat;
    dadosLan.fltValFin := FieldByName('ADT_VALFIN').AsFloat;
    dadosLan.fltValCre := FieldByName('ADT_VALCRE').AsFloat;
    dadosLan.strCodPor := FieldByName('ADT_CODPOR').AsString;
    dadosLan.strCodCta := FieldByName('ADT_CODCTA').AsString;

    dadosLan.RecebidoPorPix := False;

    Result := TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosLan);
  End;

  FreeAndNil(qryAdtCli)
end;

class function TAdiantamento.fEstornarCreditoGeradoAdiantamento(strNumDoc,
  strEspDoc, strCodEmp, strNomeForm, strCodOpe: String): Boolean;
  Var
    qryConsulta,
    LExcluir: TUniQuery;

    blnComita  : Boolean;
    strHistor  : String;
begin

  Try
    qryConsulta := fCriaQuery;
    qryConsulta.SQL.Add('SELECT R.*, L.CTR_SEQCON AS SEQCON,        ');
    qryConsulta.SQL.Add('       A.AUTOINCREM AS INCADT              ');
    qryConsulta.SQL.Add('FROM ADTCLI A                              ');
    qryConsulta.SQL.Add('JOIN LOGCTR L ON L.CTR_SEQCON=A.ADT_SEQCON ');
    qryConsulta.SQL.Add('             AND L.CTR_CODEMP=A.ADT_EMPLAN ');
    qryConsulta.SQL.Add('             AND L.CTR_DTACAD=A.ADT_DTALAN ');
    qryConsulta.SQL.Add('             AND L.CTR_DESCRI IN("INCLUSÃO","INCLUSÃO LD")  ');
    qryConsulta.SQL.Add('             AND L.CTR_ESPDOC="CC"         ');
    qryConsulta.SQL.Add('             AND L.CTR_VALDUP=-A.ADT_VALLAN');
    qryConsulta.SQL.Add('JOIN CADREC R ON R.CTR_NUMDUP=L.CTR_NUMDUP ');
    qryConsulta.SQL.Add('             AND R.CTR_ESPDOC=L.CTR_ESPDOC ');
    qryConsulta.SQL.Add('             AND R.CTR_PARCEL=L.CTR_PARCEL ');
    qryConsulta.SQL.Add('             AND R.CTR_CODCLI=L.CTR_CODCLI ');
    qryConsulta.SQL.Add('             AND R.CTR_CODEMP=L.CTR_CODEMP ');
    qryConsulta.SQL.Add('             AND R.CTR_DTAREC IS NULL      ');
    qryConsulta.SQL.Add('             AND R.CTR_VALORI=R.CTR_VALDUP '); //sem baixas parciais
    qryConsulta.SQL.Add('WHERE A.ADT_NUMDOC=:NUMDOC                 ');
    qryConsulta.SQL.Add('  AND A.ADT_ESPDOC=:ESPDOC                 ');
    qryConsulta.SQL.Add('  AND A.ADT_CODEMP=:CODEMP                 ');
    qryConsulta.SQL.Add('  AND A.ADT_TIPLAN="D"                     ');
    qryConsulta.SQL.Add('  AND A.ADT_ESTORN<>"S"                    ');

    qryConsulta.SQL.Add('ORDER BY L.CTR_DTALOG DESC,                ');
    qryConsulta.SQL.Add('         L.CTR_HORLOG DESC                 ');

    qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;

    qryConsulta.Open;

    Result := (Not qryConsulta.IsEmpty);

    If Result Then
      Result := fPergunta('Esta operação estornará o crédito gerado e voltará ' +
                          'o valor como adiantamento. ' + #13 +
                          'Deseja realmente continuar com a operação?');

    LExcluir := fCriaQuery;

    If Result Then
    Begin

      blnComita := (Not fInTransaction) And
                   (fStartTransaction);

      LExcluir.SQL.Text := 'SELECT * FROM CADREC WHERE AUTOINCREM="' + qryConsulta.FieldByName('AUTOINCREM').AsString + '"';
      LExcluir.Open;

      untCadRec.fApagaDuplicataContasReceber(LExcluir,
                                             'untAdiantamentoCliente',
                                             'EXCLUSÃO');

      strHistor := 'REF. ESTORNO CRÉDITO DE CLIENTE DE ADIANTAMENTO DO DOCUMENTO ' +
                   strNumDoc + '-' + strEspDoc + '-' + strCodEmp + '.';

      Result := TAdiantamento.fLancarCreditoAdiantamento(strNumDoc,
                                                         strEspDoc,
                                                         strCodEmp,
                                                         strCodOpe,
                                                         strHistor,
                                                         qryConsulta.FieldByName('SEQCON').AsInteger,
                                                         qryConsulta.FieldByName('INCADT').AsString);

      If blnComita Then
        Result := fCommit;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;

      If Assigned(qryConsulta) Then
        FreeAndNil(qryConsulta);

      If Assigned(LExcluir) Then
        FreeAndNil(LExcluir);

      Raise Exception.Create('Ocorreu um erro ao estornar o crédito pelo Adiantamento de Cliente.' + #13 +
                             'Erro gerado: ' + E.Message);
    End;
  End;

  FreeAndNil(qryConsulta);
  If Result Then
    FreeAndNil(LExcluir);
end;

class function TAdiantamento.fCarregarAdiantamentos(strNumDoc,
  strEspDoc, strCodEmp,strCodCli: String; qryAdiantamentos: TUniQuery): Boolean;
begin
  With qryAdiantamentos, SQL Do
  Begin
    Close;
    Clear;

    Add('SET @SALFIN := 0');
    ExecSQL;

    Close;
    Clear;

    Add('SELECT SQL_NO_CACHE     ');
    Add('  ADT_NUMDOC AS NUMDOC, ');
    Add('  ADT_ESPDOC AS ESPDOC, ');
    Add('  ADT_CODEMP AS CODEMP, ');
    Add('  ADT_CODCLI AS CODCLI, ');
    Add('  ADT_EMPLAN AS EMPLAN, ');
    Add('  ADT_DTALAN AS DTALAN, ');
    Add('  ADT_HORLAN AS HORLAN, ');
    Add('  ADT_OPELAN AS OPELAN, ');
    Add('  ADT_DESCRI AS DESCRI, ');
    Add('  ADT_SEQCON AS SEQCON, ');
    Add('  ADT_TIPLAN AS TIPLAN, ');
    Add('  ADT_ESTORN AS ESTORN, ');
    Add('  ADT_ORIGEM AS ORIGEM, ');
    Add('  ADT_RESCAI AS RESCAI, ');
    Add('  IF(ADT_VALDIN = 0, NULL, ADT_VALDIN) AS VALDIN, ');
    Add('  IF(ADT_VALCHV = 0, NULL, ADT_VALCHV) AS VALCHV, ');
    Add('  IF(ADT_VALCHP = 0, NULL, ADT_VALCHP) AS VALCHP, ');
    Add('  IF(ADT_VALCAR = 0, NULL, ADT_VALCAR) AS VALCAR, ');
    Add('  IF(ADT_VALORD = 0, NULL, ADT_VALORD) AS VALORD, ');
    Add('  IF(ADT_VALFIN = 0, NULL, ADT_VALFIN) AS VALFIN, ');
    Add('  IF(ADT_VALCRE = 0, NULL, ADT_VALCRE) AS VALCRE, ');
    Add('  IF(ADT_VALLAN = 0, NULL, ADT_VALLAN) AS VALLAN, ');
    Add('  (@SALFIN := @SALFIN + IF(ADT_TIPLAN = "C", 1, -1) * ADT_VALLAN) AS SALFIN ');

    Add('FROM ');
    Add('  ADTCLI ');
    Add('WHERE    ');
    Add('  ADT_NUMDOC = :NUMDOC AND ');
    Add('  ADT_ESPDOC = :ESPDOC AND ');

    If Not fEmptyStr(strCodCli) Then
      Add('  ADT_CODCLI = :CODCLI AND ');

    Add('  ADT_CODEMP = :CODEMP ');
    Add('ORDER BY ');
    Add('  ADT_DTALAN, ');
    Add('  ADT_HORLAN  ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Not fEmptyStr(strCodCli) Then
      ParambyName('CODCLI').AsString := strCodCli;

    Open;

    Result := Not IsEmpty;
  End;
end;

class function TAdiantamento.fGetTotaisAdiantamento(strNumDoc,
  strEspDoc, strCodEmp: String): TTotaisAdiantamento;
  Var
    qryGen: TUniQuery;
begin
  FillChar(Result, SizeOf(Result), #0);

  If fEmptyStr(strNumDoc) Then
    Exit;

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT SQL_NO_CACHE ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) AS VALLAN, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALDIN, -ADT_VALDIN)) AS VALDIN, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALCHV, -ADT_VALCHV)) AS VALCHV, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALCHP, -ADT_VALCHP)) AS VALCHP, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALCAR, -ADT_VALCAR)) AS VALCAR, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALORD, -ADT_VALORD)) AS VALORD, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALFIN, -ADT_VALFIN)) AS VALFIN, ');
    Add('  SUM(IF(ADT_TIPLAN = "C", ADT_VALCRE, -ADT_VALCRE)) AS VALCRE, ');
    Add('  COUNT(*) AS TOTLAN ');
    Add('FROM ');
    Add('  ADTCLI ');
    Add('WHERE ');
    Add('  ADT_NUMDOC = :NUMDOC AND ');
    Add('  ADT_ESPDOC = :ESPDOC AND ');
    Add('  ADT_CODEMP = :CODEMP     ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    Result.fltValLan := FieldByName('VALLAN').AsFloat;
    Result.fltValDin := FieldByName('VALDIN').AsFloat;
    Result.fltValChV := FieldByName('VALCHV').AsFloat;
    Result.fltValChP := FieldByName('VALCHP').AsFloat;
    Result.fltValCar := FieldByName('VALCAR').AsFloat;
    Result.fltValOrd := FieldByName('VALORD').AsFloat;
    Result.fltValFin := FieldByName('VALFIN').AsFloat;
    Result.fltValCre := FieldByName('VALCRE').AsFloat;
    Result.blnExiAdt := (FieldByName('TOTLAN').AsInteger > 0);

  End;

  FreeAndNil(qryGen);
end;

class function TAdiantamento.AdiantamentoRealizadoPorPixDeFormaParcial(
  ADatasetPedido: TDataset): Boolean;
  Var
    LConsulta: TUniQuery;
    LInicioCampo: String;

    LValorPedido: Double;
begin
  Result := False;

  LInicioCampo := 'FGO_'; //F11
  If ADatasetPedido.FindField('FGO_TX_PIX') = Nil Then
    LInicioCampo := 'TMP_'; //Confirmação

  If ADatasetPedido.FieldByName(LInicioCampo + 'TX_PIX').AsString.IsEmpty Then
    Exit;

  LValorPedido := ADatasetPedido.FieldByName(LInicioCampo + 'VLRCON').AsFloat;
  If LInicioCampo.Equals('FGO_') Then
    LValorPedido := LValorPedido -
                    IfNull(ADatasetPedido.FieldByName(LInicioCampo + 'TOTBRI').AsFloat, 0) -
                    IfNull(ADatasetPedido.FieldByName(LInicioCampo + 'BOLADT').AsFloat, 0);

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT ' +
                          '  IFNULL(SUM(IF(ADT_TIPLAN = "D", ADT_VALLAN * -1, ADT_VALLAN)), 0) AS VALOR ' +
                          'FROM  ' +
                          'ADTCLI ' +
                          'WHERE ADT_NUMDOC = :NUMDOC ' +
                          '  AND ADT_ESPDOC = :ESPDOC ' +
                          '  AND ADT_CODEMP = :CODEMP ' +
                          '  AND ADT_CODCLI = :CODCLI ';

    LConsulta.ParamByName('NUMDOC').AsString := ADatasetPedido.FieldByName(LInicioCampo + 'NUMDOC').AsString;
    LConsulta.ParamByName('ESPDOC').AsString := ADatasetPedido.FieldByName(LInicioCampo + 'ESPDOC').AsString;
    LConsulta.ParamByName('CODEMP').AsString := ADatasetPedido.FieldByName(LInicioCampo + 'CODEMP').AsString;
    LConsulta.ParamByName('CODCLI').AsString := ADatasetPedido.FieldByName(LInicioCampo + 'CODCLI').AsString;
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    If fFormataFloat(LConsulta.FieldByName('VALOR').AsFloat, 2) = 0 Then
      Exit;

    If fFormataFloat(LConsulta.FieldByName('VALOR').AsFloat, 2) >= fFormataFloat(LValorPedido, 2) Then      Exit;

    fMensagem('ATENÇÃO', 'Esse pedido possui um Pix com vinculado e recebido, porém o valor foi recebido de forma parcial.' + #13 +
                         'Para continuar com o faturamento, esse pedido deve ser realizado o Estorno, gerando um crédito ' +
                         'para o cliente do valor do Pix recebido.' + #13 +
                         'Operação cancelada.', ['&Ok']);

    Result := True;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class function TAdiantamento.AdiantamentoRecebidoPorPix(ANumeroDocumento,
  AEspecieDocumento, AEmpresaDocumento: String): Boolean;
  Var
    LConsulta: TUNiQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT M.AUTOINCREM ' +
                          'FROM ADTCLI A ' +
                          'JOIN MOVPIX M ON M.MPX_SEQCON=A.ADT_SEQCON ' +
                          '             AND M.MPX_CODEMP=A.ADT_EMPLAN ' +
                          'WHERE A.ADT_NUMDOC=:NUMDOC ' +
                          '  AND A.ADT_ESPDOC=:ESPDOC ' +
                          '  AND A.ADT_CODEMP=:CODEMP ' +
                          '  AND ADT_TIPLAN="C" ' +
                          '  AND ADT_ESTORN="N" ' +
                          '  AND ADT_RECPIX="S" ';

    LConsulta.ParamByName('NUMDOC').AsString := ANumeroDocumento;
    LConsulta.ParamByName('ESPDOC').AsString := AEspecieDocumento;
    LConsulta.ParamByName('CODEMP').AsString := AEmpresaDocumento;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

constructor TAdiantamento.Create(strNomeForm, strCodOpe, strCodigoCaixa: String;
                                 blnPagueFacil: Boolean; strTipoCartao: string; intParcelas: Integer);
begin
  objRotinaYapay := TRotinaYapay.Create;
  objRotinaYapay.blnActive := False;

  blnEstornouTransacaoPendente := False;

  FillChar(FInfAdiantamento, SizeOf(FInfAdiantamento), #0);

  FNomeForm := strNomeForm;

  FLabelGravando := Nil;

  FInfAdiantamento.strOpeLan := strCodOpe;
  FInfAdiantamento.strEmpLan := VS_strCodEmp;

  SetLength(arrCartoes, 0);

  cdsChqVis := fCriaCdsCheques(nil);
  cdsChqPre := fCriaCdsCheques(nil);

  stlDupCreditos  := TStringList.Create;
  stlLckCreditos  := TStringList.Create;

  objTefRecebimento   := fCriarTefRecebimento(VS_objTef, blnPagueFacil, strTipoCartao, intParcelas);

  objTefCitelPagueFacil := fCriarTefCitelPagueFacil(strTipoCartao, intParcelas);

  objFormasNegociadas := TFormaPagtoNegociada.Create;
  objFormasNegociadas.strCodOperador := strCodOpe;

  Self.strCodigoCaixa := strCodigoCaixa;

  objLock := TLock.Create;

  objResumoDeCaixa := Nil;
end;

destructor TAdiantamento.Destroy;
  Var
    documento: TDocAdiantamento;
begin
  if Assigned(objRotinaYapay) then
    FreeAndNil(objRotinaYapay);

  For documento In FInfAdiantamento.documentos Do
  begin
    if (not fVerificaLockAtivo('FATGOR' + documento.strNumDoc +
                                          documento.strEspDoc +
                                          documento.strCodEmp +
                                          STR_TRAVA_COLETOR)) then
      objLock.fLock_Unlock( 'FATGOR' + documento.strNumDoc +
                                       documento.strEspDoc +
                                       documento.strCodEmp, False, False );
  end;

  pCancelarTefDeCartoesJaConfirmados;

  If Assigned(cdsChqVis) Then FreeAndNil(cdsChqVis);
  If Assigned(cdsChqPre) Then FreeAndNil(cdsChqPre);
  If Assigned(stlDupCreditos) Then FreeAndNil(stlDupCreditos);
  If Assigned(stlLckCreditos) Then FreeAndNil(stlLckCreditos);
  If Assigned(objFormasNegociadas) Then FreeAndNil(objFormasNegociadas);
  FreeAndNil(objLock);

  inherited;
end;

function TAdiantamento.fVerificarCheques: Boolean;
begin
  Result := True;
  If cdsChqPre.Locate('CHQ_CODBCO;CHQ_NUMAGE;CHQ_CONCOR;CHQ_NUMCHQ',
    VarArrayOf([cdsChqVis.FieldByName('CHQ_CODBCO').AsString,
                cdsChqVis.FieldByName('CHQ_NUMAGE').AsString,
                cdsChqVis.FieldByName('CHQ_CONCOR').AsString,
                cdsChqVis.FieldByName('CHQ_NUMCHQ').AsString]), []) Then
  Begin
    fMensagem('ATENÇÃO!', 'O mesmo cheque está sendo cadastrado para o Cheque a Vista e para o Cheque Pré.', ['&Ok']);
    Result := False;
  End;
end;

function TAdiantamento.fReceberFormaPagamento(strCodFpg: String; fltValor: Double;
   strCodCar: String; intQtdPar: Integer): Boolean;
  Var
    I: Integer;
    blnPergun: Boolean;

    LResumoDeCaixa: TResumoDeCaixa;
begin
  Result := True;

  blnPergun := True;
  if ( fCfgSis('USAGRY') = 'S') and ( strCodCar = fCfgSis('CARGRY') ) then
    blnPergun := False;

  If (blnPergun) and
     ( Not fPergunta('Confirma o recebimento da forma de pagamento "' +
                   fRetDesFpg(strCodFpg) + '" no valor de ' +
                   FormatFloat('R$ #,##0.00', fltValor) + ' ?') ) Then
  Begin
    Exit(False);
  End;

  If (blnEstornouTransacaoPendente) Then
  Begin
    Result := False;
    pMensagemOk('Atenção! Foi identificado estorno de transação em um ou mais cartões.' + sLineBreak +
                'Não será possível prosseguir com essa operação, finalize toda a operação e tente novamente!');
    Exit;
  End;

  pInformacaoGravacao('Realizando recebimento em "' + fRetDesFpg(strCodFpg) + '"!');

  //Recebimento em dinheiro
  If strCodFpg = '001' Then
  Begin
    FInfAdiantamento.fltValDin := fltValor;
  End
  //Recebimento em Cheque Pré
  Else If (strCodFpg = '002') Then
  Begin
    If fCfgSis('CHQRCX', varBoolean) Then
      Result := fChequePre(fltValor) And fVerificarCheques;

    If Result Then
      FInfAdiantamento.fltValChP := fltValor;
  End
  //Recebimento em Cheque a Vista
  Else If (strCodFpg = '006') Then
  Begin
    If fCfgSis('CHQRCX', varBoolean) And
       fCfgSis('CHQVIS', varBoolean) Then
    Begin
      Result := fChequeVis(fltValor) And fVerificarCheques;
    End;

    If Result Then
      FInfAdiantamento.fltValChV := fltValor;
  End
  //Recebimento em Cartão
  Else If (strCodFpg = '007') Then
  Begin
    For I := 0 To Length(FInfAdiantamento.documentos) -1 Do
    Begin
      FInfAdiantamento.documentos[I].strCodCar := strCodCar;
      FInfAdiantamento.documentos[I].intQtdPaC := intQtdPar;
    End;

    If fCfgSis('DIGCAR') = 'S' Then
      Result := fDigitacaoCartoes(fltValor);

    If Result Then                  //Permitido mais de um cartao, deve acumular
      FInfAdiantamento.fltValCar := FInfAdiantamento.fltValCar + fltValor;
  End
  //Recebimento em Ordem de Pagamento
  Else If strCodFpg = '012' Then
  Begin
    FInfAdiantamento.fltValOrd := fltValor;
  End
  //Recebimento em Financiamento
  Else If strCodFpg = '016' Then
  Begin
    FInfAdiantamento.fltValFin := fltValor;
  End
  //Recebimento em Ordem de Pagamento
  Else If strCodFpg = '013' Then
  Begin
    Result := fSelecionarCreditos(FInfAdiantamento.documentos[0].strCodCli, 'RCX',
                                  fltValor, fltTotCreditos, stlDupCreditos, stlLckCreditos,
                                  FInfAdiantamento.strOpeLan, objFormasNegociadas);
    If Result Then
      FInfAdiantamento.fltValCre := fltValor;
  End
  Else
  Begin
    Result := False;
    pMensagemOk('Forma de pagamento não disponível para adiantamento de cliente!');
  End;

  FInfAdiantamento.strCodPor := fCfgSis('PORRCX', varString);
  LResumoDeCaixa := TResumoDeCaixa.Create;
  If LResumoDeCaixa.TransferenciaOrdemPagamentoAutomatica Then
  Begin
    If (FInfAdiantamento.fltValOrd > 0) And (Not FInfAdiantamento.RecebidoPorPix)  Then
    Begin
      If FInfAdiantamento.PortadorTFAutomatica.IsEmpty Then
        FInfAdiantamento.PortadorTFAutomatica := LResumoDeCaixa.RetornaPortadorTFAutomatica;

      FInfAdiantamento.ValorTFAutomatica := FInfAdiantamento.fltValOrd;
    End;
  End;
  FreeAndNil(LResumoDeCaixa);

//  If Result Then
//    pMensagemOk('Recebimento realizado com sucesso!');
end;

function TAdiantamento.fRetornaDocumentosTraDoc: TArrayInfoTraDoc;
var
  LrecTraDoc: TInfoTraDoc ;
  LarrTraDoc: TArrayInfoTraDoc ;
begin
  Result := Nil ;

  if Length(FInfAdiantamento.documentos) = 0 then
    Exit ;

  SetLength(LarrTraDoc, 0) ;
  FillChar(LrecTraDoc, SizeOf(LrecTraDoc), #0);
  LrecTraDoc.CodEmp := VS_strCodEmp ;
  LrecTraDoc.DtaTra := Date ;
  LrecTraDoc.NumDup := FInfAdiantamento.documentos[0].strNumDoc ;
  LrecTraDoc.EspDoc := FInfAdiantamento.documentos[0].strEspDoc ;
  LrecTraDoc.Parcel := '' ;
  LrecTraDoc.EmpDoc := FInfAdiantamento.documentos[0].strCodEmp ;
  SetLength(LarrTraDoc, Length(LarrTraDoc)+1) ;
  LarrTraDoc[High(LarrTraDoc)] := LrecTraDoc ;
  Result := LarrTraDoc ;

end;

class function TAdiantamento.fSelecionarCreditos(strCodCli, strOrigem: String; fltValor: Double; Var fltTotCred: Double; Var stlDupCred, stlLckCred: TStringList; strOpeLan: String = ''; objFormasNegociadas : TFormaPagtoNegociada = nil; strCrtDevSintetizadasConfDocs: String = ''): Boolean;
  Var
    blnMostrarTela: Boolean;
    fltCreditosNegociados: Double;
    dtaDtaIni, dtaDtaFin: TDate;
    crTela: TChamaRotina;
    strMsg: String;
    frmAgrupDuplicatas: TfrmAgrupDuplicatas;
begin
  Result := False;

  If fExisteCredComProfissionalDevMerc(strCodCli, dtaDtaIni, dtaDtaFin, crTela) Then
  Begin
    Try
      strMsg := '';

      If crTela = crAgrupamento Then
      Begin
        strMsg := strMsg + 'Este cliente tem títulos em aberto no contas a receber, a serem quitados, decorrente da ';
        strMsg := strMsg + 'comissão por devolução de mercadorias. ' + sLineBreak;
        strMsg := strMsg + 'Você será encaminhado para o Agrupamento de Duplicatas para agrupar os créditos decorrentes ';
        strMsg := strMsg + 'das vendas com os débitos decorrentes da devolução. ' + sLineBreak;
        strMsg := strMsg + 'Caso o valor final do agrupamento permaneça negativo (crédito para o cliente), o crédito ';
        strMsg := strMsg + 'poderá ser usado na Utilização de Crédidos. '+ sLineBreak;
        strMsg := strMsg + 'Caso o valor final do agrupamento permaneça positivo (débito para o cliente), o cliente ';
        strMsg := strMsg + 'deverá realizar a quitação pela rotina de recebimento no caixa. ';
      End
      Else
      Begin
        strMsg := strMsg + 'Este cliente tem títulos em aberto no contas a receber, a serem quitados, decorrente da ';
        strMsg := strMsg + 'comissão por devolução de mercadorias. ' + sLineBreak;
        strMsg := strMsg + 'Contudo, ele possui créditos que deixam seu saldo devedor zerado. Você será encaminhado ';
        strMsg := strMsg + 'para a Baixa do Contas a Receber para liquidar estes títulos em aberto, sem necessidade ';
        strMsg := strMsg + 'de pagamento financeiro por parte do cliente.';
      End;

      pCriarFormularios(TfrmObservacao, frmObservacao);
      frmObservacao.lblMensagem.Caption := 'Débitos/Créditos do Cliente';
      frmObservacao.memObs.Texto := strMsg;
      frmObservacao.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmObservacao]');
    End;

    pFreeAndNil(frmObservacao);

    If crTela = crAgrupamento Then
    Begin
      pCriarFormularios(TfrmAgrupDuplicatas, frmAgrupDuplicatas);
      SetLength(frmAgrupDuplicatas.arrDocsAgrupar, 0);
      frmAgrupDuplicatas.edtCodCli.Text := strCodCli;
      frmAgrupDuplicatas.mskDtaIni.Text := DateToStr(dtaDtaIni);
      frmAgrupDuplicatas.mskDtaFin.Text := DateToStr(dtaDtaFin);
      frmAgrupDuplicatas.blnF11 := True;
      frmAgrupDuplicatas.ShowModal;

      If frmAgrupDuplicatas.taAgrupouF11 <> taNone Then
      Begin
        If frmAgrupDuplicatas.taAgrupouF11 = taAbortou Then
          fMensagem('ATENÇÃO','É necessário que agrupe todas as duplicatas de créditos para utilizar este tipo de modalidade!',['&OK']);

        pFreeAndNil(frmAgrupDuplicatas);
        Exit;
      End
      Else
        pFreeAndNil(frmAgrupDuplicatas);
    End
    Else
    Begin
      If Not TFuncoesCaixa.fChamaTelaCaixa(strOpeLan, strCodCli) Then
      Begin
        fMensagem('ATENÇÃO','É necessário que baixe todas as duplicatas de créditos para utilizar este tipo de modalidade!',['&OK']);
        Exit;
      End;
    End;
  End;

  fltCreditosNegociados := fltValor;

  fltTotCred := 0;
  stlDupCred.Clear;
  stlLckCred.Clear;

  blnMostrarTela := True;

  If strOrigem = 'RCX' Then
  Begin
    If objFormasNegociadas.fFormaPagtoSelecionada('013') Then
    Begin
      fltCreditosNegociados := objFormasNegociadas.cdsFormasNegociadas.FieldByName('VALFPG').AsFloat;
      stlDupCred.Text       := objFormasNegociadas.stlDupCreditos.Text;
      stlLckCred.Text       := objFormasNegociadas.stlLckDup.Text;
    End;

    blnMostrarTela := stlDupCred.Count = 0;
  End;

  Result := fSelecionaDuplicatasCredito(strCodCli,
                                        fltValor,
                                        stlDupCred,
                                        stlLckCred,
                                        fltTotCred,
                                        '',
                                        nil,
                                        blnMostrarTela,
                                        fltCreditosNegociados,
                                        nil,
                                        '',
                                        Not blnMostrarTela,
                                        strCrtDevSintetizadasConfDocs);
end;

function TAdiantamento.fPedeFormasPagto: Boolean;
begin
  If FInfAdiantamento.strOrigem = 'RCX' Then
    Result := fPedeFormasPagtoRCX
  Else If FInfAdiantamento.blnPagueFacil Then
    Result := fPedeFormasPagtoCTRPagueFacil
  Else
    Result := fPedeFormasPagtoCTR;
end;

function TAdiantamento.fPedeFormasPagtoCTR: Boolean;
  Var
    fltValor: Double;
    qryGen: TUniQuery;
    frmBaixaSintetica : TfrmBaixaSintetica;
    frmFatFormasPagamento : TfrmFatFormasPagamento;

    LChamaTelaValor: Boolean;
begin
  pInformacaoGravacao('Informando valor do adiantamento!');

  While True Do
  Begin
    FInfAdiantamento.fltCreGer := 0;

    fltValor := FInfAdiantamento.fltValLan;

    LChamaTelaValor := Not objRotinaYapay.blnActive;
    If LChamaTelaValor Then
    Begin
      LChamaTelaValor := Not Assigned(FRegistroPix);

      If LChamaTelaValor Then
        LChamaTelaValor := Not fDigitaValor(fltValor, 'Adiantamento');
    End;

    If LChamaTelaValor Then
        Exit(False);

    If fFormataFloat(fltValor, 2) > fFormataFloat(FInfAdiantamento.fltValLan, 2) Then
      If Not fPergunta('Deseja gerar crédito ao cliente?') Then
        Continue;

    If fFormataFloat(fltValor, 2) > fFormataFloat(FInfAdiantamento.fltValLan, 2) Then
      FInfAdiantamento.fltCreGer := fltValor - FInfAdiantamento.fltValLan
    Else
      FInfAdiantamento.fltValLan := fltValor;

    Break;
  End;

  pAtualizarValorLancamentoDocumentos;

  Try
    pCriarFormularios(TfrmBaixaSintetica, frmBaixaSintetica);
    try

      frmBaixaSintetica.dtaDtaBai := VS_Date;
      frmBaixaSintetica.blnCadPag := False;
      frmBaixaSintetica.blnVemADT := True;

      if objRotinaYapay.blnActive then
      begin
        frmBaixaSintetica.strPorBai := objRotinaYapay.BaixaSintetica.strCodigoPortador;
        frmBaixaSintetica.strCtaBai := objRotinaYapay.BaixaSintetica.strPlanoContas;
        frmBaixaSintetica.strDtaLan := DateToStr(objRotinaYapay.BaixaSintetica.dtaLancamento);
        frmBaixaSintetica.strDocBai := objRotinaYapay.BaixaSintetica.strNumeroDocumento;
        frmBaixaSintetica.strHisBai := objRotinaYapay.BaixaSintetica.strHistorico;
        frmBaixaSintetica.blnConfirma := True;
      end
      Else If Assigned(FRegistroPix) Then
      Begin
        frmBaixaSintetica.strPorBai := FRegistroPix.CodigoPortador;
        frmBaixaSintetica.strCtaBai := FRegistroPix.PlanoDeContas;
        frmBaixaSintetica.strDtaLan := FormatDateTime('dd/mm/yyyy', FRegistroPix.DataPagamento);
        frmBaixaSintetica.strDocBai := FInfAdiantamento.documentos[0].strNumDoc + '-' +
                                       FInfAdiantamento.documentos[0].strEspDoc + '-' +
                                       FInfAdiantamento.documentos[0].strCodEmp;
        frmBaixaSintetica.strHisBai := 'ADIANTAMENTO DE PEDIDO REALIZADO VIA PIX';
        frmBaixaSintetica.blnConfirma := True;
      End
      else
        frmBaixaSintetica.ShowModal;

      If Not (frmBaixaSintetica.blnConfirma) Then
      Begin
        Result := False;
        Exit;
      End;

      {*REQ*145940**********RP*}
      If Not fEmpresaTemAcessoPortador(frmBaixaSintetica.strPorBai) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Exit(False);
      End;

      With FInfAdiantamento Do
      Begin
        strCodPor := frmBaixaSintetica.strPorBai;
        strCodCta := frmBaixaSintetica.strCtaBai;
        dtaDtaLan := StrToDate(frmBaixaSintetica.strDtaLan);
        strOpeLan := strLoginUsuarioLogado;
        strDocume := frmBaixaSintetica.strDocBai;
        strDescri := IIF(fEmptyStr(frmBaixaSintetica.strHisBai),'Ref. Adiantamento - Cliente: ' +
          documentos[0].strCodCli, frmBaixaSintetica.strHisBai);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'');
      End
    End;
  finally
    pFreeAndNil(frmBaixaSintetica);
  end;

  pCriarFormularios(TfrmFatFormasPagamento,frmFatFormasPagamento);
  try
    frmFatFormasPagamento.strCodOpe           := strLoginUsuarioLogado;
    frmFatFormasPagamento.blnCtaRec           := True;
    frmFatFormasPagamento.blnGerCre           := False;
    frmFatFormasPagamento.fltValTot           := fltValor;
    frmFatFormasPagamento.edtFaturado.Enabled := False;
    frmFatFormasPagamento.edtFaturado.Visible := False;
    frmFatFormasPagamento.lblFaturado.Visible := False;
    frmFatFormasPagamento.edtFinanc.Enabled   := False;
    frmFatFormasPagamento.edtFinanc.Visible   := False;
    frmFatFormasPagamento.lblFinanc.Visible   := False;
    frmFatFormasPagamento.cdsChqPre           := cdsChqPre;
    frmFatFormasPagamento.cdsChqVis           := cdsChqVis;
    frmFatFormasPagamento.arrCartoes          := arrCartoes;
    frmFatFormasPagamento.strCliente          := FInfAdiantamento.documentos[0].strCodCli;
    frmFatFormasPagamento.strPorBai           := FInfAdiantamento.strCodPor;

    frmFatFormasPagamento.lblValCre.Top       := frmFatFormasPagamento.lblFaturado.Top;
    frmFatFormasPagamento.edtValCre.Top       := frmFatFormasPagamento.edtFaturado.Top;
    frmFatFormasPagamento.lblValCre.Left      := frmFatFormasPagamento.lblFaturado.Left -
                                                 (frmFatFormasPagamento.lblValCre.Width - frmFatFormasPagamento.lblFaturado.Width);
    frmFatFormasPagamento.edtValCre.Left      := frmFatFormasPagamento.edtFaturado.Left;
    frmFatFormasPagamento.edtValCre.Enabled   := True;
    frmFatFormasPagamento.edtValCre.Visible   := True;
    frmFatFormasPagamento.lblValCre.Visible   := True;

    frmFatFormasPagamento.lblValorRestante.Visible := True;

    {***********************************************************
    * Caso esteja configurado para aceitar somente a forma de  *
    * pagamento negociada na venda, desabilita todas as outras *
    ***********************************************************}
    If fCfgSis('SFPGPD', VarBoolean) Then
    Begin
      With frmFatFormasPagamento, FInfAdiantamento do
      Begin
        lblDinheiro.Visible := documentos[0].strCodFpg = '001';
        edtDinheiro.Visible := documentos[0].strCodFpg = '001';

        lblChequeVista.Visible := documentos[0].strCodFpg = '006';
        edtChqVista.Visible    := documentos[0].strCodFpg = '006';
        lblChequeVista.Top     := IIF(documentos[0].strCodFpg = '006',21,lblChequeVista.Top);
        edtChqVista.Top        := IIF(documentos[0].strCodFpg = '006',16,edtChqVista.Top);

        lblChequePre.Visible := documentos[0].strCodFpg = '002';
        edtChqPre.Visible    := documentos[0].strCodFpg = '002';
        lblChequePre.Top     := IIF(documentos[0].strCodFpg = '002',21,lblChequePre.Top);
        edtChqPre.Top        := IIF(documentos[0].strCodFpg = '002',16,edtChqPre.Top);

        lblCartao.Visible := documentos[0].strCodFpg = '007';
        edtCartao.Visible := documentos[0].strCodFpg = '007';
        lblCartao.Top     := IIF(documentos[0].strCodFpg = '007',21,lblCartao.Top);
        edtCartao.Top     := IIF(documentos[0].strCodFpg = '007',16,edtCartao.Top);

        lblOrdPag.Visible := documentos[0].strCodFpg = '012';
        edtOrdPag.Visible := documentos[0].strCodFpg = '012';
        lblOrdPag.Top     := IIF(documentos[0].strCodFpg = '012',21,lblOrdPag.Top);
        edtOrdPag.Top     := IIF(documentos[0].strCodFpg = '012',16,edtOrdPag.Top);

        lblValCre.Visible := False;
        edtValCre.Visible := False;

        Height := 169;
      End;
    End
    Else
      frmFatFormasPagamento.Height := 289;

    If fCfgSis('TFPF11', varBoolean) Then
    Begin
      qryGen := fCriaQuery;
      Try
        If (FInfAdiantamento.documentos[0].strEspDoc = 'PD') And (Length(FInfAdiantamento.documentos[0].strAutInc) = 20) Then
        Begin
          qryGen.Close;
          qryGen.SQL.Text := ' SELECT ' +
                             '   FPN_CODFPG, ' +
                             '   FPN_CONPAG, ' +
                             '   SUM(FPN_VALFPG) AS FPN_VALFPG, ' +
                             '   FPN_CODCAR, ' +
                             '   FPN_QTDPAR, ' +
                             '   FPN_DTACHQ  ' +
                             ' FROM ' +
                             '   FPGNEG ' +
                             ' WHERE ' +
                             '   FPN_SEQFGO = "'+FInfAdiantamento.documentos[0].strAutInc+'"'+
                             ' GROUP BY ' +
                             '   FPN_CODFPG, ' +
                             '   FPN_CONPAG, ' +
                             '   FPN_CODCAR, ' +
                             '   FPN_QTDPAR  ' ;
          qryGen.Open;

          If (Not qryGen.IsEmpty) Then
          Begin
            If qryGen.Locate('FPN_CODFPG','001',[]) Then
              frmFatFormasPagamento.fltDinheiNeg := qryGen.FieldByName('FPN_VALFPG').AsFloat;
            If qryGen.Locate('FPN_CODFPG','006',[]) Then  
              frmFatFormasPagamento.fltChqVisNeg := qryGen.FieldByName('FPN_VALFPG').AsFloat;
            If qryGen.Locate('FPN_CODFPG','002',[]) Then
              frmFatFormasPagamento.fltChqPreNeg := qryGen.FieldByName('FPN_VALFPG').AsFloat;
            If qryGen.Locate('FPN_CODFPG','007',[]) Then
              frmFatFormasPagamento.fltCartaoNeg := qryGen.FieldByName('FPN_VALFPG').AsFloat;
            If qryGen.Locate('FPN_CODFPG','012',[]) Then
              frmFatFormasPagamento.fltOrdPagNeg := qryGen.FieldByName('FPN_VALFPG').AsFloat;
            If qryGen.Locate('FPN_CODFPG','013',[]) Then
              frmFatFormasPagamento.fltValCreNeg := qryGen.FieldByName('FPN_VALFPG').AsFloat;
          End;
        End;
      Finally
        FreeAndNil(qryGen);
      End;
    End;

    if objRotinaYapay.blnActive then
    begin
      frmFatFormasPagamento.fltCartao := fltValor;
      SetLength(frmFatFormasPagamento.arrCartoes, 1);

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].strCodCar :=
        objRotinaYapay.Cartao.strCodigoCartao;

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].strDesCar :=
        objRotinaYapay.Cartao.strDescricaoCartao;

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].fltValDig := fltValor;

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].fltPerDes := 0;

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].fltValDes :=
        objRotinaYapay.Cartao.fltValorTaxa;

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].strObsCar :=
        objRotinaYapay.Cartao.strObservacao;

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].strNumCcd :=
        objRotinaYapay.Cartao.strNumCCD;

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].strNumNsu :=
        objRotinaYapay.Cartao.strNumNSU;

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].strTipCar :=
        objRotinaYapay.Cartao.strFormaCartao;

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].strCndPag :=
        fRetornaCndPagPeriod(objRotinaYapay.Cartao.intQuantidadeParcelas,
                             objRotinaYapay.Cartao.intPrazo,
                             objRotinaYapay.Cartao.intDiasExcedentePrimeiraParcela);

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].dtaDtaCad :=
        objRotinaYapay.Cartao.dtaDataCadastro;

      frmFatFormasPagamento.arrCartoes[Low(arrCartoes)].intQtdPar := objRotinaYapay.Cartao.intQuantidadeParcelas;

      frmFatFormasPagamento.ModalResult := mrOk;
    end
    Else If Assigned(FRegistroPix) Then
    Begin
      frmFatFormasPagamento.fltOrdPag := fltValor;
      frmFatFormasPagamento.ModalResult := mrOk;
    End
    else
      frmFatFormasPagamento.ShowModal;

    if frmFatFormasPagamento.ModalResult <> mrOK Then
    Begin
      Result := False;
      Exit;
    End;

    With FInfAdiantamento Do
    Begin
      fltValChP := frmFatFormasPagamento.fltChqPre;
      fltValChV := frmFatFormasPagamento.fltChqVis;
      fltValDin := frmFatFormasPagamento.fltDinhei;
      fltValCar := frmFatFormasPagamento.fltCartao;
      fltValOrd := frmFatFormasPagamento.fltOrdPag;
      fltValCre := frmFatFormasPagamento.fltValCrd;

      if (fltValCre > 0) Then
      Begin
        fltTotCreditos        := frmFatFormasPagamento.fltTotCreditos;
        stlDupCreditos.Text   := frmFatFormasPagamento.stlDupCreditos.Text;
        stlLckCreditos.Text   := frmFatFormasPagamento.stlLckCreditos.Text;
      End;

    End;

    cdsChqPre  := frmFatFormasPagamento.cdsChqPre;
    cdsChqVis  := frmFatFormasPagamento.cdsChqVis;
    arrCartoes := frmFatFormasPagamento.arrCartoes;
  finally
    pFreeAndNil(frmFatFormasPagamento);
  end;

  Result := True;
end;

function TAdiantamento.fPedeFormasPagtoCTRPagueFacil: Boolean;
Var
  I: Integer;
begin
  pInformacaoGravacao('Informando valor do adiantamento!');

  pAtualizarValorLancamentoDocumentos;

  FInfAdiantamento.strCodPor := fCfgSis('PORPGF');
  FInfAdiantamento.strCodCta := fCfgSis('CTAPGF');
  FInfAdiantamento.dtaDtaLan := VS_Date;
  FInfAdiantamento.strOpeLan := strLoginUsuarioLogado;
  FInfAdiantamento.strDocume := FInfAdiantamento.documentos[0].strNumDoc + '-' +
                                FInfAdiantamento.documentos[0].strEspDoc + '-' +
                                FInfAdiantamento.documentos[0].strCodEmp;
  FInfAdiantamento.strDescri := 'Ref. Adiantamento - Cliente: ' + FInfAdiantamento.documentos[0].strCodCli;

  If Not fEmpresaTemAcessoPortador(FInfAdiantamento.strCodPor) Then
  Begin
    fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar o portador "'
      + FInfAdiantamento.strCodPor +'". Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
    Exit(False);
  End;

  If Not fDigitacaoCartoes(FInfAdiantamento.fltValLan) Then
    Exit(False);

  FInfAdiantamento.fltValCar := FInfAdiantamento.fltValLan;

  For I := 0 To Length(FInfAdiantamento.documentos) -1 Do
  Begin
    FInfAdiantamento.documentos[I].strCodCar := arrCartoes[0].strCodCar;
    FInfAdiantamento.documentos[I].intQtdPaC := Length(arrCartoes);
  End;

  Result := True;
end;

function TAdiantamento.fPedeFormasPagtoRCX: Boolean;
  Const
    DIFERENCA_RECEBIDO_TOTAL = 0.05;
  Var
    formPagto: TFormaPagto;
    ftTotFormasTmp: Double;
    strAutInc: String;
    documento: TDocAdiantamento;
    objGryncash: TGryncash;
begin
  Result := True;

  With objFormasNegociadas Do
  Begin
    pInformacaoGravacao('Carregando formas de pagamento do pedido!');

    strAutInc := '';
    For documento In FInfAdiantamento.documentos Do
    Begin
      If strAutInc <> '' Then
        strAutInc := strAutInc + ',';
      strAutInc := strAutInc + documento.strAutInc;
    End;

    pCarregarFormasPagtoNegociadas(strAutInc);

    //Quando forma de pagamento parcelado somente carrega as formas de pagamento permitidas
    //para recebimento de adiantamento (dinheiro, cheque, cartao, credito, ordem de pagamento)
    If (FInfAdiantamento.documentos[0].strCodFpg = '009') And
       (FInfAdiantamento.documentos[0].strFpgOri <> '016')Then
    Begin
      pInformacaoGravacao('Validando forma de pagamento do pedido!');

      If cdsFormasNegociadas.IsEmpty Then
      Begin
        If fCfgSis('SFPGPD', VarBoolean) Then
        Begin
          pMensagemOk('Não é possível realizar o adiantamento deste pedido, pois ' +
                      'não foram informadas as formas de pagamento!');
          Result := False;
          Exit;
        End;
      End
      Else
      Begin
        cdsFormasNegociadas.First;
        While Not cdsFormasNegociadas.Eof Do
        Begin
          //para recebimento de adiantamento (dinheiro, cheque, cartao, credito, ordem de pagamento)
          If fPos(cdsFormasNegociadas.FieldByName('CODFPG').AsString, strFormasPagtoAdiantamento) Then
            cdsFormasNegociadas.Next
          Else
            cdsFormasNegociadas.Delete;
        End;

        If cdsFormasNegociadas.IsEmpty Then
        Begin
          If fCfgSis('SFPGPD', VarBoolean) Then
          Begin
            pMensagemOk('Não é possível realizar o adiantamento deste pedido, pois ' +
                        'não foram encontradas formas de pagamento para recebimento de adiantamento!');
            Result := False;
            Exit;
          End;
        End
        Else
        Begin
          ftTotFormasTmp := fltTotalFormasPagto;

          If Not ((fFormataFloat(FInfAdiantamento.fltValLan, 2) > 0) And
                  (fFormataFloat(ftTotFormasTmp, 2) > 0) And
                  (Abs(FInfAdiantamento.fltValLan - ftTotFormasTmp) <= DIFERENCA_RECEBIDO_TOTAL)) Then
            FInfAdiantamento.fltValLan := ftTotFormasTmp;
        End;
      End;

    End;

    //Adiciona a forma de pagamento do pedido (quando nao informada)
    If cdsFormasNegociadas.IsEmpty Then
    Begin
      If Pos(FInfAdiantamento.documentos[0].strCodFpg, '008_010_014_009_') <= 0 Then
      Begin
        FillChar(formPagto, SizeOf(formPagto), #0);

        if (fCfgSis('USAGRY') = 'S') then
        begin
          objGryncash := TGryncash.Create(nil);
          try
            if objGryncash.fUserCashBackFundsOnStore(FInfAdiantamento.documentos[0].strNomCli,
                                                     FInfAdiantamento.documentos[0].strC_G_C_,
                                                     FInfAdiantamento.documentos[0].blnCliGry,
                                                     FInfAdiantamento.documentos[0].fltCshGry,
                                                     FInfAdiantamento.documentos[0].fltVlrCon) then
            begin
              if FInfAdiantamento.documentos[0].fltCshGry > 0 then
              begin
                formPagto.strCodigo        := '007';
                formPagto.strDescricao     := 'GRYNCASH';

                formPagto.fltValor         := FInfAdiantamento.documentos[0].fltCshGry;
                formPagto.strCondPagamento := FInfAdiantamento.documentos[0].strConPag;

                formPagto.dadosCartao.pCarregaDadosCartao(fCfgSis('CARGRY'));
                formPagto.dadoscartao.intQtdParcelas := 1;

                pSelecionarFormaPagto(formPagto);
              end;
            end;
          finally
            FreeAndNil(objGryncash);
          end;
        end;

        If Assigned(FRegistroPix) Then
        Begin
          formPagto.strCodigo        := '012';
          formPagto.strDescricao     := 'ORDEM DE PAGAMENTO';

          formPagto.fltValor         := FInfAdiantamento.fltValOrd;
          formPagto.strCondPagamento := FInfAdiantamento.documentos[0].strConPag;

          pSelecionarFormaPagto(formPagto);

          objFormasNegociadas.blnAdiantamentoPedido := True;

          pAtualizarValorLancamentoDocumentos;

          Exit;
        End;

        formPagto.strCodigo        := FInfAdiantamento.documentos[0].strCodFpg;
        formPagto.strDescricao     := fRetDesFpg(formPagto.strCodigo);

        formPagto.fltValor         := FInfAdiantamento.fltValLan - FInfAdiantamento.documentos[0].fltCshGry;
        formPagto.strCondPagamento := FInfAdiantamento.documentos[0].strConPag;

        formPagto.dadosCartao.pCarregaDadosCartao(FInfAdiantamento.documentos[0].strCodCar);
        formPagto.dadoscartao.intQtdParcelas := FInfAdiantamento.documentos[0].intQtdPaC;

        pSelecionarFormaPagto(formPagto);
      End;
    End;

    objFormasNegociadas.blnAdiantamentoPedido := True;

    pInformacaoGravacao('Realizando recebimento das formas de pagamento!');

    pAtualizarValorLancamentoDocumentos;

    Result := Result And
      fRecebimentoFormasPagtoNegociadasAdiantamento(FInfAdiantamento.fltValLan,
                                                    Self.fReceberFormaPagamento);
  End;
end;

class function TAdiantamento.fPedeValorAdiantamento(strNumDoc, strEspDoc, strCodEmp, strOrigem: String): Double;
  Var
    qryPedidos: TUniQuery;
    documentos: TArrDocAdiantamento;
begin
  qryPedidos := fCriaQuery;

  With qryPedidos, SQL Do
  Begin
    Close;
    Clear;

    Add(fGetSQLPedidos(strNumDoc));

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;
  End;

  Result := 0;

  If fCarregarDadosPedido(qryPedidos, documentos, strOrigem) Then
    Result := fPedeValorAdiantamento(documentos);

  FreeAndNil(qryPedidos);
end;


class function TAdiantamento.fPedeValorAdiantamento(documentos: TArrDocAdiantamento): Double;
  Var
    fltTotLan: Double;
    fltAdtFin: Double;
    documento: TDocAdiantamento;
begin
  fltTotLan := 0;
  fltAdtFin := 0;

  For documento In documentos Do
  Begin
    fltTotLan := fltTotLan + documento.fltValLan;
    If (documento.strFpgOri = '016') And
       (fCampoTabela('FIN_VALADT', 'FATFIN', ['FIN_SEQGER'], [documento.strAutInc]) > 0) Then
    Begin
      fltAdtFin := fltAdtFin + fCampoTabela('FIN_VALADT', 'FATFIN', ['FIN_SEQGER'], [documento.strAutInc]);
    End;
  End;

  Result := fltTotLan;

  If (fltAdtFin > 0) Then
  Begin
    Result := fltAdtFin;
  End
  Else If (Pos(documentos[0].strCodFpg, '008_010_014_') > 0) Then
  Begin
    If Not fDigitaValor(Result, 'Digite o valor do adiantamento:') Then
    Begin
      Result := 0;
      Exit;
    End;

    If fFormataFloat(Result, 2) > fFormataFloat(fltTotLan, 2) Then
    Begin
      pMensagemOk('O valor do adiantamento não pode ser maior que ' +
        FormatFloat('#,##0.00', fltTotLan));
      Result := 0;
    End;
  End;

end;

class function TAdiantamento.fPermiteAlterarPedidoComAdiantamento: TPermissaoAlteracaoDePedidosQuePossuemAdiantamento;
var
  strALPDAD : String;
begin

  strALPDAD := fCfgSis('ALPDAD');

  If strALPDAD = papSimTodosOsCampos.GetValue Then
    Exit(papSimTodosOsCampos);

  If strALPDAD = papSimTodosOsCamposComExigenciaQueOValorFiqueOMesmo.GetValue Then
    Exit(papSimTodosOsCamposComExigenciaQueOValorFiqueOMesmo);

  If strALPDAD = papSimSomenteReduzindoAQuantidadeOuEliminandoProdutos.GetValue Then
    Exit(papSimSomenteReduzindoAQuantidadeOuEliminandoProdutos);

  Result := papNaoNenhumaInformacao;

end;

class function TAdiantamento.fPermiteSelecionarPedido(strNumDoc, strEspDoc, strCodEmp, strOrigem: String): Boolean;
  Var
    qryPedidos: TUniQuery;
    documentos: TArrDocAdiantamento;
    strCODFPG : String;
begin

  qryPedidos := fCriaQuery;

  With qryPedidos, SQL Do
  Begin
    Close;
    Clear;

    Add(fGetSQLPedidos(strNumDoc));

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;
  End;

  Result := fCarregarDadosPedido(qryPedidos, documentos, strOrigem);

  If Not Result Then
  Begin

    strCODFPG := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, 'CODFPG');

    pMensagemOk('Este pedido de venda está na forma de pagamento ' +strCODFPG+'-'+fRetDesFpg(strCODFPG)+ sLineBreak +
                'Não é permitido adiantamento de pedido para este tipo de forma de pagamento.');

  End;

  Result := Result And fPermiteSelecionarPedido(documentos);

  FreeAndNil(qryPedidos);
end;

class function TAdiantamento.fPossuiCreditoGerado(strNumDoc, strEspDoc,strCodEmp: String): Boolean;
  Var
    qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  qryConsulta.SQL.Add('SELECT L.*                                 ');
  qryConsulta.SQL.Add('FROM LOGCTR L                              ');
  qryConsulta.SQL.Add('JOIN CADREC R ON R.CTR_NUMDUP=L.CTR_NUMDUP ');
  qryConsulta.SQL.Add('             AND R.CTR_ESPDOC=L.CTR_ESPDOC ');
  qryConsulta.SQL.Add('             AND R.CTR_PARCEL=L.CTR_PARCEL ');
  qryConsulta.SQL.Add('             AND R.CTR_CODCLI=L.CTR_CODCLI ');
  qryConsulta.SQL.Add('             AND R.CTR_CODEMP=L.CTR_CODEMP ');
  qryConsulta.SQL.Add('             AND R.CTR_ESPDOC="CC"         ');
  qryConsulta.SQL.Add('WHERE L.CTR_DESCRI IN("INCLUSÃO","INCLUSÃO LD")  ');
  qryConsulta.SQL.Add('  AND (L.CTR_SEQCON, L.CTR_CODEMP) IN      ');
  qryConsulta.SQL.Add('      (SELECT ADT_SEQCON, ADT_EMPLAN FROM  ');
  qryConsulta.SQL.Add('       ADTCLI WHERE ADT_NUMDOC=:NUMDOC     ');
  qryConsulta.SQL.Add('                AND ADT_ESPDOC=:ESPDOC     ');
  qryConsulta.SQL.Add('                AND ADT_CODEMP=:CODEMP     ');
  qryConsulta.SQL.Add('                AND ADT_TIPLAN="D"         ');
  qryConsulta.SQL.Add('                AND ADT_SEQCON > 0         ');
  qryConsulta.SQL.Add('                AND ADT_ESTORN<>"S"        ');
  qryConsulta.SQL.Add('       )                                   ');

  qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
  qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
  qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;

  qryConsulta.Open;

  Result := (Not qryConsulta.IsEmpty);

  FreeAndNil(qryConsulta);

End;

class function TAdiantamento.fPossuiCreditoGeradoEmAberto(strNumDoc, strEspDoc,
  strCodEmp: String): Boolean;
  Var
    qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  qryConsulta.SQL.Add('SELECT L.*                                 ');
  qryConsulta.SQL.Add('FROM LOGCTR L                              ');
  qryConsulta.SQL.Add('JOIN CADREC R ON R.CTR_NUMDUP=L.CTR_NUMDUP ');
  qryConsulta.SQL.Add('             AND R.CTR_ESPDOC=L.CTR_ESPDOC ');
  qryConsulta.SQL.Add('             AND R.CTR_PARCEL=L.CTR_PARCEL ');
  qryConsulta.SQL.Add('             AND R.CTR_CODCLI=L.CTR_CODCLI ');
  qryConsulta.SQL.Add('             AND R.CTR_CODEMP=L.CTR_CODEMP ');
  qryConsulta.SQL.Add('             AND R.CTR_DTAREC IS NULL      ');
  qryConsulta.SQL.Add('             AND R.CTR_VALORI=R.CTR_VALDUP '); //sem baixas parciais
  qryConsulta.SQL.Add('WHERE L.CTR_DESCRI IN("INCLUSÃO","INCLUSÃO LD")   ');
  qryConsulta.SQL.Add('  AND (L.CTR_SEQCON, L.CTR_CODEMP, L.CTR_DTACAD) IN      ');
  qryConsulta.SQL.Add('      (SELECT ADT_SEQCON, ADT_EMPLAN, ADT_DTALAN FROM  ');
  qryConsulta.SQL.Add('       ADTCLI WHERE ADT_NUMDOC=:NUMDOC     ');
  qryConsulta.SQL.Add('                AND ADT_ESPDOC=:ESPDOC     ');
  qryConsulta.SQL.Add('                AND ADT_CODEMP=:CODEMP     ');
  qryConsulta.SQL.Add('                AND ADT_TIPLAN="D"         ');
  qryConsulta.SQL.Add('                AND ADT_SEQCON > 0         ');
  qryConsulta.SQL.Add('                AND ADT_ESTORN<>"S"        ');
  qryConsulta.SQL.Add('       )                                   ');

  qryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
  qryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
  qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;

  qryConsulta.Open;

  Result := (Not qryConsulta.IsEmpty);

  FreeAndNil(qryConsulta);
end;

class function TAdiantamento.fPermiteSelecionarPedido(documentos: TArrDocAdiantamento;
  ARecebidoPorPix: Boolean = False): Boolean;
  Var
    strPedido: String;
    documento: TDocAdiantamento;
begin
  Result := False;
  For documento In documentos Do
  Begin
    strPedido := documento.strNumDoc + '-' +
                 documento.strEspDoc + '-' +
                 documento.strCodEmp;

    {***************************************************************************}
    {* SE O PEDIDO JA POSSUI BAIXA PARCIAL O VALOR CONTABIL (GER_VLRCON) NAO É *}
    {* MAIS REFLETE O VALOR REAL DO PEDIDO (PENDENTE), ASSIM COMO NO F11 NAO   *}
    {* PERMITE SELECIONAR ESTE TIPO DE PEDIDO TAMBEM NAO PODEMOS UTILIZAR.     *}
    {***********************************************************************JC**}
    If fPedidoFaturadoParcialmente(documento.strNumDoc,
                                   documento.strEspDoc,
                                   documento.strCodEmp) Then
    Begin
      pMensagemOk('Pedido ' + strPedido + ' já foi baixado parcialmente, ' +
                  'portanto não será permitido realizar adiantamento de cliente para o mesmo!');
      Exit;
    End;

    If fPedidoBaixaEntregaFutura(documento.strNumDoc, documento.strEspDoc, documento.strCodEmp) Then
    Begin
      pMensagemOk('Pedido de baixa de entrega futura não necessita de adiantamento ('+ strPedido + ')!');
      Exit;
    End;

    {*****************************************************************************}
    {* SE O PEDIDO POSSUI CADREC BAIXADO SIGNIFICA QUE AINDA É UM PEDIDO ANTIGO, *}
    {* SENDO ASSIM NAO DEVEMOS PERMITIR SELECIONAR O MESMO PARA ADIANTAMENTO.    *}
    {*************************************************************************JC**}
    If documento.fltDupRec > 0 Then
    Begin
      pMensagemOk('Pedido ' + strPedido + ' já possui baixa em seu contas a receber, ' +
                  'portanto não será permitido realizar adiantamento de cliente para o mesmo!');
      Exit;
    End;

    If (documento.fltBolAdt > 0) And (documento.fltVlrCon <= 0) Then
    Begin
      pMensagemOk('Pedido ' + strPedido + ' já possui boletos de adiantamento no valor total de (' +
        FormatFloat('#,##0.00', documento.fltBolAdt) + '), ' +
        'portanto não será permitido realizar adiantamento de cliente para o mesmo!');
      Exit;
    End;

    If fAdiantamentoPossuiDebitos(documento.strNumDoc, documento.strEspDoc, documento.strCodEmp, documento.StrCodCli) Then
    Begin
      pMensagemOk('Não é permitido o lançamento de novos adiantamentos para o pedido ' + strPedido + ' pois ' +
                  'já existem lançamentos de débitos provenientes de Faturamento do ' +
                  'Pedido ou Geração de Crédito do saldo do(s) adiantamento(s)!');
      Exit;
    End;

//    If fCfgSis('RECPLC', VarBoolean) And (Not documento.blnLibCom) Then
//    Begin
//      pMensagemOk('Somente será permitido o recebimento do pedido ' + strPedido + ' após a ' +
//                  'liberação do mesmo pelo Departamento Comercial!');
//      Exit;
//    End;

    If fValidaTravaISETAU(fCfgSis('ADINPD', VarBoolean)) Then
    Begin

      If (Not ((documento.blnLibCom) And (documento.blnLibera))) And
         (Not ARecebidoPorPix) Then
      Begin
        pMensagemOk('Somente será permitido o recebimento deste pedido após a ' +
                    'liberação do mesmo pelo Departamento Comercial e/ou Financeiro!');
        Exit;
      End;

    End;

    If fCfgSis('SFPGPD', VarBoolean) And Not fPos(documento.strCodFpg, strFormasPagtoAdiantamento) Then
    Begin
      pMensagemOk('Forma de pagamento do pedido ' + strPedido + ' não disponível para recebimento de adiantamento de cliente!');
      Exit;
    End;

    If fVaiCalcularRetencoesServicos(documento.strNumDoc, documento.strEspDoc, documento.strCodEmp, documento.StrCodCli) Then
    Begin
      pMensagemOk('O pedido ' + strPedido + ' tem serviços com retenções, não é possível fazer o adiantamento!');
      Exit;
    End;

  End;

  Result := True;
end;

function TAdiantamento.fSelecionarDocumento(strNumDoc, strEspDoc, strCodEmp, strOrigem: String; blnPagueFacil: Boolean;
  ARecebimentoPorPix: Boolean = False; APagueFacilPix: Boolean = False): Boolean;
  Var
    qryPedidos: TUniQuery;
    documento: TDocAdiantamento;
    frmSelPedidoAdiantamento: TfrmSelPedidoAdiantamento;
    strCODFPG : String;
begin

  FInfAdiantamento.strOrigem := strOrigem;
  FInfAdiantamento.blnPagueFacil := blnPagueFacil;

  If fEmptyStr(strNumDoc) Then
  Begin
    Try
      pCriarFormularios(TfrmSelPedidoAdiantamento, frmSelPedidoAdiantamento);
      frmSelPedidoAdiantamento.strCodOpe := Self.objFormasNegociadas.strCodOperador;
      frmSelPedidoAdiantamento.strOrigem := strOrigem;
      frmSelPedidoAdiantamento.objLock   := Self.objLock;
      frmSelPedidoAdiantamento.CodigoDoCaixa := strCodigoCaixa;
      frmSelPedidoAdiantamento.ShowModal;

      Result := frmSelPedidoAdiantamento.blnConfirma;

      If (Result) Then
        For documento In frmSelPedidoAdiantamento.documentos Do
          FInfAdiantamento.AddDocumento(documento);
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

    pFreeAndNil(frmSelPedidoAdiantamento);
  End
  Else
  Begin
    qryPedidos := fCriaQuery;

    qryPedidos.Close;
    qryPedidos.SQL.Clear;

    qryPedidos.SQL.Add(fGetSQLPedidos(strNumDoc, False, objRotinaYapay, ARecebimentoPorPix, APagueFacilPix));

    If Not ARecebimentoPorPix Then
    Begin
      qryPedidos.ParamByName('NUMDOC').AsString := strNumDoc;
      qryPedidos.ParamByName('ESPDOC').AsString := strEspDoc;
      qryPedidos.ParamByName('CODEMP').AsString := strCodEmp;
    End
    Else
    Begin
      If Not APagueFacilPix Then
      Begin
        qryPedidos.ParamByName('EMPPIX').AsString := FRegistroPix.CodigoEmpresa;
        qryPedidos.ParamByName('TX_PIX').AsString := FRegistroPix.TxId;
      End
      Else
      Begin
        qryPedidos.ParamByName('NUMDOC').AsString := strNumDoc;
        qryPedidos.ParamByName('ESPDOC').AsString := strEspDoc;
        qryPedidos.ParamByName('CODEMP').AsString := strCodEmp;
      End;
    End;

    qryPedidos.Open;

    Result := fCarregarDadosPedido(qryPedidos, FInfAdiantamento.documentos, strOrigem, ARecebimentoPorPix) And
              fSelecionarPedido(FInfAdiantamento.documentos, objLock, objRotinaYapay, ARecebimentoPorPix);

    If (Not Result) and (not objRotinaYapay.blnActive) and (not ARecebimentoPorPix) Then
    Begin

      strCODFPG := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, 'CODFPG');

      pMensagemOk('Este pedido de venda está na forma de pagamento ' +strCODFPG+'-'+fRetDesFpg(strCODFPG)+ sLineBreak +
                  'Não é permitido adiantamento de pedido para este tipo de forma de pagamento.');

    End;

    FreeAndNil(qryPedidos);
  End;

  If (Result) Then
  Begin
    FInfAdiantamento.fltValLan := 0;
    For documento In FInfAdiantamento.documentos Do
      FInfAdiantamento.fltValLan := FInfAdiantamento.fltValLan + documento.fltVlrCon - documento.fltValAdt;

    If (FInfAdiantamento.strOrigem = 'RCX') And (Not ARecebimentoPorPix) then
      FInfAdiantamento.fltValLan := fPedeValorAdiantamento(FInfAdiantamento.documentos);

    FInfAdiantamento.strTipLan := 'C';
    FInfAdiantamento.strDescri := FInfAdiantamento.documentos[0].strCodCli + ' - ' +
                                  FInfAdiantamento.documentos[0].strNomCli;

    Result := FInfAdiantamento.fltValLan > 0;

    pAtualizarValorLancamentoDocumentos;
  End;

end;

procedure TAdiantamento.pGarantirCancelamentoTefRecebimento(strArquivo: String);
begin
  While (Not objTefRecebimento.fCancelarRecebimento(strArquivo)) Do
    Application.ProcessMessages;
end;

class procedure TAdiantamento.pGravaAdiantamentoDesmembrado(strNumDocAtual,
  strEspDocAtual, strCodEmpAtual, strNumDocNovo, strEspDocNovo,
  strCodEmpNovo: String; AdiantamentoDocAtual,
  AdiantamentoDocNovo: TTotaisAdiantamento);
var
  qryAdiantamento: TUniQuery;
  qryAdiantamentoNovo: TUniQuery;
  intContador: Integer;
  strAutInc: String;
  strAutIncAdtOri: String;
begin
  qryAdiantamento := fCriaQuery;
  qryAdiantamentoNovo := fCriaQuery;

  try
    qryAdiantamento.Close;
    qryAdiantamento.SQL.Clear;
    qryAdiantamento.SQL.Add('SELECT * FROM ADTCLI');
    qryAdiantamento.SQL.Add('WHERE ADT_NUMDOC = :NUMDOC');
    qryAdiantamento.SQL.Add('AND ADT_ESPDOC = :ESPDOC');
    qryAdiantamento.SQL.Add('AND ADT_CODEMP = :CODEMP');
    qryAdiantamento.SQL.Add('AND ADT_TIPLAN = "C"');
    qryAdiantamento.ParamByName('NUMDOC').AsString := strNumDocAtual;
    qryAdiantamento.ParamByName('ESPDOC').AsString := strEspDocAtual;
    qryAdiantamento.ParamByName('CODEMP').AsString := strCodEmpAtual;
    qryAdiantamento.Open;

    if qryAdiantamento.IsEmpty then
      Exit;

    strAutInc := qryAdiantamento.FieldByName('AUTOINCREM').AsString;

    strAutIncAdtOri := fCampoTabela('ADT_ADTORI', 'ADTCLI', ['AUTOINCREM'], [strAutInc], False);


    qryAdiantamentoNovo.Close;
    qryAdiantamentoNovo.SQL.Clear;
    qryAdiantamentoNovo.SQL.Add('SELECT * FROM ADTCLI WHERE FALSE');
    qryAdiantamentoNovo.Open;

    qryAdiantamentoNovo.Append;
    for intContador := 0 to qryAdiantamento.FieldCount - 1 do
    begin
      qryAdiantamentoNovo.Fields[intContador].Value := qryAdiantamento.Fields[intContador].Value;
    end;

    qryAdiantamentoNovo.FieldByName('ADT_VALLAN').AsFloat := AdiantamentoDocNovo.fltValLan;
    qryAdiantamentoNovo.FieldByName('ADT_VALDIN').AsFloat := AdiantamentoDocNovo.fltValDin;
    qryAdiantamentoNovo.FieldByName('ADT_VALCAR').AsFloat := AdiantamentoDocNovo.fltValCar;
    qryAdiantamentoNovo.FieldByName('ADT_VALCHP').AsFloat := AdiantamentoDocNovo.fltValChP;
    qryAdiantamentoNovo.FieldByName('ADT_VALCHV').AsFloat := AdiantamentoDocNovo.fltValChV;
    qryAdiantamentoNovo.FieldByName('ADT_VALCRE').AsFloat := AdiantamentoDocNovo.fltValCre;
    qryAdiantamentoNovo.FieldByName('ADT_VALORD').AsFloat := AdiantamentoDocNovo.fltValOrd;
    qryAdiantamentoNovo.FieldByName('ADT_VALFIN').AsFloat := AdiantamentoDocNovo.fltValFin;
    qryAdiantamentoNovo.FieldByName('ADT_VALJUR').AsFloat := AdiantamentoDocNovo.fltValJur;
    qryAdiantamentoNovo.FieldByName('ADT_DTALAN').AsDateTime := fRetDataServidor;
    qryAdiantamentoNovo.FieldByName('ADT_HORLAN').AsDateTime := fRetHoraServidor;
    qryAdiantamentoNovo.FieldByName('ADT_NUMDOC').AsString := strNumDocNovo;
    qryAdiantamentoNovo.FieldByName('ADT_ESPDOC').AsString := strEspDocNovo;
    qryAdiantamentoNovo.FieldByName('ADT_CODEMP').AsString := strCodEmpNovo;
    qryAdiantamentoNovo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ADTCLI', strCodEmpNovo);

    qryAdiantamentoNovo.Post;

    qryAdiantamento.Close;
    qryAdiantamento.SQL.Clear;
    qryAdiantamento.SQL.Add('UPDATE ADTCLI');
    qryAdiantamento.SQL.Add('SET ADT_VALLAN = :VALLAN');
    qryAdiantamento.SQL.Add(', ADT_VALDIN = :VALDIN');
    qryAdiantamento.SQL.Add(', ADT_VALCAR = :VALCAR');
    qryAdiantamento.SQL.Add(', ADT_VALCHP = :VALCHP');
    qryAdiantamento.SQL.Add(', ADT_VALCHV = :VALCHV');
    qryAdiantamento.SQL.Add(', ADT_VALCRE = :VALCRE');
    qryAdiantamento.SQL.Add(', ADT_VALORD = :VALORD');
    qryAdiantamento.SQL.Add(', ADT_VALFIN = :VALFIN');
    qryAdiantamento.SQL.Add(', ADT_VALJUR = :VALJUR');
    qryAdiantamento.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryAdiantamento.ParamByName('VALLAN').AsFloat := AdiantamentoDocAtual.fltValLan;
    qryAdiantamento.ParamByName('VALDIN').AsFloat := AdiantamentoDocAtual.fltValDin;
    qryAdiantamento.ParamByName('VALCAR').AsFloat := AdiantamentoDocAtual.fltValCar;
    qryAdiantamento.ParamByName('VALCHP').AsFloat := AdiantamentoDocAtual.fltValChP;
    qryAdiantamento.ParamByName('VALCHV').AsFloat := AdiantamentoDocAtual.fltValChV;
    qryAdiantamento.ParamByName('VALCRE').AsFloat := AdiantamentoDocAtual.fltValCre;
    qryAdiantamento.ParamByName('VALORD').AsFloat := AdiantamentoDocAtual.fltValOrd;
    qryAdiantamento.ParamByName('VALFIN').AsFloat := AdiantamentoDocAtual.fltValFin;
    qryAdiantamento.ParamByName('VALJUR').AsFloat := AdiantamentoDocAtual.fltValJur;
    qryAdiantamento.ParamByName('AUTINC').AsString := strAutInc;

    qryAdiantamento.ExecSQL;

    if AdiantamentoDocNovo.fltValCar > 0 then
      pAcertaHistoricoMovCarPeloDesmembramentoPedido(strNumDocNovo, strEspDocNovo, strCodEmpNovo, strAutIncAdtOri);

    if (AdiantamentoDocNovo.fltValChV > 0) or (AdiantamentoDocNovo.fltValChP > 0) Then
      pAcertaHistoricoCadChqPeloDesmembramentoPedido(strNumDocNovo, strEspDocNovo, strCodEmpNovo, strAutIncAdtOri);
  finally
    FreeAndNil(qryAdiantamento);
    FreeAndNil(qryAdiantamentoNovo);
  end;
end;

procedure TAdiantamento.pImprimirRecibo;
  Var
    objRecibo: TReciboAdiantamento;
begin
  If Not FInfAdiantamento.blnPagueFacil Then
  Begin
    pInformacaoGravacao('Aguarde, Imprimindo Recibo...');
    objRecibo := TReciboAdiantamento.Create(FInfAdiantamento.intSeqCon, FInfAdiantamento.strEmpLan, FInfAdiantamento.strOrigem);
    objRecibo.pImprimirRecibo;
    FreeAndNil(objRecibo);
  End;
end;

procedure TAdiantamento.pInformacaoGravacao(strMsg: String);
begin
  If Assigned(FLabelGravando) Then
  Begin
    FLabelGravando.Caption := strMsg;
    Application.ProcessMessages;
  End;
end;

class function TAdiantamento.RealizarAdiantamentoClientePix(
  ANomeFormulario: String; var ADadosDoPix: TDadosRetornoPixConsulta;
  APagueFacil: Boolean = False;  AChavePedido: String = ''): Integer;
  Var
    LAdiantamento: TAdiantamento;

    LSelecionouDocumento: Boolean;

    LDadosPedido: TUniClientDataSet;

    LOperador: String;

    LRecibo: TReciboAdiantamento;
begin
  Result := 0;

  pLimparTrilhaMensagensTotem;

  LDadosPedido := TPixDao.RetornaDadosPedidoPix(ADadosDoPix.TxId,
                                                ADadosDoPix.CodigoEmpresa);

  If LDadosPedido.IsEmpty Then
    LDadosPedido := TPixDao.RetornaDadosPedidoPagueFacil(AChavePedido);

  Try
    If LDadosPedido.IsEmpty Then
      Exit(0);

    LAdiantamento := TAdiantamento.Create(ANomeFormulario, strLoginUsuarioLogado, '');

    LDadosPedido.First;

    LAdiantamento.FRegistroPix := ADadosDoPix;
    LAdiantamento.FInfAdiantamento.fltValOrd := ADadosDoPix.ValorPago;

    If ADadosDoPix.OrigemAdiantamento.IsEmpty Then
      ADadosDoPix.OrigemAdiantamento := 'CTR';

    LSelecionouDocumento :=
      LAdiantamento.fSelecionarDocumento(LDadosPedido.FieldByName('FGO_NUMDOC').AsString,
                                         LDadosPedido.FieldByName('FGO_ESPDOC').AsString,
                                         LDadosPedido.FieldByName('FGO_CODEMP').AsString,
                                         ADadosDoPix.OrigemAdiantamento,
                                         False,
                                         True,
                                         APagueFacil);

    LAdiantamento.FInfAdiantamento.fltValDin := 0.00;
    LAdiantamento.FInfAdiantamento.fltValChV := 0.00;
    LAdiantamento.FInfAdiantamento.fltValChP := 0.00;
    LAdiantamento.FInfAdiantamento.fltValCar := 0.00;
    LAdiantamento.FInfAdiantamento.fltValFin := 0.00;
    LAdiantamento.FInfAdiantamento.fltValCre := 0.00;

    LAdiantamento.FInfAdiantamento.blnPagueFacil := False;

    If Not LSelecionouDocumento Then
      Exit(0);

    If LAdiantamento.fRealizarAdiantamento(nil) Then
    Begin
      Result := LAdiantamento.FInfAdiantamento.intSeqCon;

      ADadosDoPix.MovBanBaixa := LAdiantamento.FRegistroPix.MovbanBaixa;

      LOperador := strLoginUsuarioLogado;
      If ADadosDoPix.OrigemAdiantamento = 'RCX' Then
      Begin
        ADadosDoPix.SeqConTransferencia := LAdiantamento.FRegistroPix.SeqConTransferencia;
        LOperador := VS_strCodigoOperadorLogadoCaixa;
      End;

      ADadosDoPix.NumeroDoPedido := LDadosPedido.FieldByName('FGO_NUMDOC').AsString + '-' +
                                    LDadosPedido.FieldByName('FGO_ESPDOC').AsString + '-' +
                                    LDadosPedido.FieldByName('FGO_CODEMP').AsString;

      LDadosPedido.Next;

      While Not LDadosPedido.Eof Do
      Begin
        ADadosDoPix.NumeroDoPedido := ADadosDoPix.NumeroDoPedido +
                                      ', ' + LDadosPedido.FieldByName('FGO_NUMDOC').AsString + '-' +
                                             LDadosPedido.FieldByName('FGO_ESPDOC').AsString + '-' +
                                             LDadosPedido.FieldByName('FGO_CODEMP').AsString;

        LDadosPedido.Next;
      End;

      ADadosDoPix.CodigoDoCliente := LDadosPedido.FieldByName('FGO_CODCLI').AsString;
      ADadosDoPix.SeqConRecebimento := LAdiantamento.FInfAdiantamento.intSeqCon;

      If Not LDadosPedido.FieldByName('FGO_TX_PIX').AsString.IsEmpty Then
      Begin
        If MatchStr(TPixDao.RetornaStatusSePedidoPossuirPix(LDadosPedido.FieldByName('FGO_EMPPIX').AsString,
                                                            LDadosPedido.FieldByName('FGO_TX_PIX').AsString), STATUS_PIX_PAGO) Then
        Begin
          Result := 0;
          fRollback;
          fMensagem('ATENÇÃO', 'A cobrança Pix QRCode desse pedido já foi recebida pelo Autcom.' + #13 +
                               'Recarregue-o para atualizar os dados.', ['Ok']);
          Exit;
        End;
      End;

      TFuncoesPixAutcom.GravarRegistroPixBaixadoFaturamento(ADadosDoPix,
                                                            LDadosPedido.FieldByName('FGO_TX_PIX').AsString.IsEmpty,
                                                            ADadosDoPix.OrigemAdiantamento = 'RCX',
                                                            ADadosDoPix.OrigemAdiantamento = 'RCX',
                                                            LOperador,
                                                            ANomeFormulario,
                                                            '');

      TFuncoesPixAutcom.RealizaLiberacaoDePedidosComPixPago(ADadosDoPix.CodigoEmpresa,
                                                            ADadosDoPix.Txid,
                                                            strLoginUsuarioLogado);

      If (ADadosDoPix.OrigemAdiantamento = 'RCX') Then
        pAtualizaDataLanctoAdiantamento(ADadosDoPix.SeqConRecebimento, ADadosDoPix.CodigoEmpresa, ADadosDoPix.DataGravacaoMovBan, ADadosDoPix.SeqLanTransferencia)
      Else
        pAtualizaDataLanctoAdiantamento(ADadosDoPix.SeqConRecebimento, ADadosDoPix.CodigoEmpresa, LAdiantamento.FInfAdiantamento.dtaDtaBan, LAdiantamento.FInfAdiantamento.strSeqBan);

      fCommit;

      If Not APagueFacil Then
      Begin
        If fPergunta('Imprimir Recibo?', fCfgSis('SUGREC', varBoolean)) Then
        Begin
          LRecibo := TReciboAdiantamento.Create(ADadosDoPix.SeqconRecebimento,
                                                VS_strCodEmp,
                                                ADadosDoPix.OrigemAdiantamento);

          LRecibo.pImprimirRecibo;

          FreeAndNil(LRecibo);
        End;
      End;
    End
    Else
      fRollBack;
  Finally
    LDadosPedido.Close;

    FreeAndNil(LDadosPedido);

    If Assigned(LAdiantamento) Then
      FreeAndNil(LAdiantamento);
  End;
end;

function TAdiantamento.RealizarTFAutomatica: Boolean;
  Var
    LResumoDeCaixa: TResumoDeCaixa;

    LRealizadaGravacao: Boolean;

    LSeqconTFAutomatica: Integer;
begin
  Result := True;

  LResumoDeCaixa := TResumoDeCaixa.Create;

  Try
    If Not LResumoDeCaixa.TransferenciaOrdemPagamentoAutomatica Then
      Exit;

    If IfNull(FInfAdiantamento.ValorTFAutomatica, 0) = 0 Then
      Exit;

    If FInfAdiantamento.PortadorTFAutomatica.IsEmpty Then
      Exit;

    LSeqconTFAutomatica := StrToInt(fRetRcxCon(VS_strCodEmp));

    LRealizadaGravacao := LResumoDeCaixa.InserirRegistroTFOrdemPagtoCaixa(FInfAdiantamento.strOpeLan,
                                                                          VS_strCodEmp,
                                                                          FInfAdiantamento.dtaDtaLan,
                                                                          FInfAdiantamento.ValorTFAutomatica,
                                                                          strCodigoCaixa,
                                                                          LSeqconTFAutomatica,
                                                                          FInfAdiantamento.intSeqCon,
                                                                          'N',
                                                                          FInfAdiantamento.PortadorTFAutomatica);
    If LRealizadaGravacao Then
      LRealizadaGravacao := LResumoDeCaixa.InserirRegistroTFOrdemPagtoNaMOVBAN(FInfAdiantamento.strOpeLan,
                                                                               VS_strCodEmp,
                                                                               FInfAdiantamento.dtaDtaLan,
                                                                               FInfAdiantamento.ValorTFAutomatica,
                                                                               strCodigoCaixa,
                                                                               EmptyStr,
                                                                               LSeqconTFAutomatica,
                                                                               FInfAdiantamento.PortadorTFAutomatica,
                                                                               FNomeForm,
                                                                               strSeqRcx);

    If LRealizadaGravacao Then
      pAtualizaDataLanctoAdiantamento(FInfAdiantamento.intSeqCon, VS_strCodEmp, LResumoDeCaixa.DataGrvMovBanAdiantamento, LResumoDeCaixa.SeqLanTransferencia, (fCfgSis('DEAMRC', varString) = 'S'));

    If Not LRealizadaGravacao Then
    Begin
      Result := False;

      Raise Exception.Create('Não foi possível realizar a gravação da transferência automática de ordem de pagamento.');
    End;
  Finally
    FreeAndNil(LResumoDeCaixa);
  End;
end;

procedure TAdiantamento.pAlteraStatusTefConfirmadoParaCancelado(const AConfirmado: Boolean);
var
  LContCartao : Integer;
begin
  if AConfirmado then
    Exit;

  if not fAutoConfirmaTransacaoPendenteEstaAtivada then
    Exit;

  for LContCartao := 0 to  Length(arrCartoes) - 1 do
  begin
    if arrCartoes[LContCartao].blnTefCnf then
    begin
      arrCartoes[LContCartao].strStatusCartao := 'FC';
    end;
  end ;
end;

class procedure TAdiantamento.pAtribuiDadosDocumento(qryPedidos: TUniQuery;
  var documento: TDocAdiantamento);
begin
  With documento Do
  Begin
    strAutInc := qryPedidos.FieldByName('AUTOINCREM').AsString;
    strSeqDmp := qryPedidos.FieldByName('FGO_SEQDMP').AsString;
    strNumDoc := qryPedidos.FieldByName('FGO_NUMDOC').AsString;
    strEspDoc := qryPedidos.FieldByName('FGO_ESPDOC').AsString;
    strCodEmp := qryPedidos.FieldByName('FGO_CODEMP').AsString;
    strCodCli := qryPedidos.FieldByName('FGO_CODCLI').AsString;
    strCodVen := qryPedidos.FieldByName('FGO_CODVEN').AsString;
    dtaDtaEnt := qryPedidos.FieldByName('FGO_DTAENT').AsDateTime;
    horHorEnt := qryPedidos.FieldByName('FGO_HORENT').AsDateTime;

    fltVlrCon := qryPedidos.FieldByName('FGO_VLRCON').AsFloat -
                 qryPedidos.FieldByName('FGO_TOTBRI').AsFloat -
                 qryPedidos.FieldByName('FGO_BOLADT').AsFloat;

    fltBolAdt := qryPedidos.FieldByName('FGO_BOLADT').AsFloat;

    fltTotIpi := qryPedidos.FieldByName('FGO_TOTIPI').AsFloat;
    fltTotRet := qryPedidos.FieldByName('FGO_TOTRET').AsFloat;
    fltDesAce := qryPedidos.FieldByName('FGO_DESACE').AsFloat;
    fltTotFre := qryPedidos.FieldByName('FGO_TOTFRE').AsFloat;
    pCarregaTotalReformaPedido(strAutInc, fltTotCbs, fltTotIbs, fltTot_Is);

    fltDupRec := TFatVenda.fTotalDuplicataQuitada(strNumDoc, strEspDoc, strCodEmp, strCodCli);
    fltValAdt := fGetTotaisAdiantamento(strNumDoc, strEspDoc, strCodEmp).fltValLan;

    fltValLan := fltVlrCon - fltValAdt;

    blnEnt_CD := qryPedidos.FieldByName('FGO_ENT_CD').AsString = 'S';

    strCodCnd := qryPedidos.FieldByName('FGO_CODCND').AsString;
    strCodFpg := qryPedidos.FieldByName('FGO_CODFPG').AsString;
    strFpgOri := qryPedidos.FieldByName('FGO_FPGORI').AsString;
    strConPag := qryPedidos.FieldByName('FGO_CONPAG').AsString;
    blnLibCom := qryPedidos.FieldByName('FGO_LIBCOM').AsInteger = 1;
    blnLibera := qryPedidos.FieldByName('FGO_LIBERA').AsInteger > 0;
    strCodCar := qryPedidos.FieldByName('FGO_CODCAR').AsString;
    intQtdPaC := qryPedidos.FieldByName('FGO_QTDPAC').AsInteger;

    If fClienteConsumidor(qryPedidos.FieldByName('CLI_NOMCLI').AsString) Then
    Begin
      strNomCli := qryPedidos.FieldByName('FGO_NOMCON').AsString;
      strEndere := qryPedidos.FieldByName('FGO_ENDCON').AsString;
      strBairro := qryPedidos.FieldByName('FGO_BAICON').AsString;
      strEndCom := '';
      strEndNum := '';
      strC_E_P_ := qryPedidos.FieldByName('FGO_CEPCON').AsString;
      strCodCid := qryPedidos.FieldByName('FGO_CIDCON').AsString;
      strFone01 := qryPedidos.FieldByName('FGO_TELCON').AsString;
      strCgcCpf := qryPedidos.FieldByName('FGO_CGCCPF').AsString;
      strC_G_C_ := qryPedidos.FieldByName('FGO_CGCCON').AsString;
      strEmail_ := qryPedidos.FieldByName('FGO_EMLCON').AsString;
      strNum_Rg := qryPedidos.FieldByName('FGO_R_GCON').AsString;
      strNumIes := qryPedidos.FieldByName('FGO_IESCON').AsString;
      strCodAti := qryPedidos.FieldByName('FGO_CODATI').AsString;
      dtaNascon := qryPedidos.FieldByName('FGO_NASCON').AsDateTime;
    End
    Else
    Begin
      strNomCli := qryPedidos.FieldByName('CLI_NOMCLI').AsString;
      strEndere := qryPedidos.FieldByName('CLI_ENDERE').AsString;
      strBairro := qryPedidos.FieldByName('CLI_BAIRRO').AsString;
      strEndCom := qryPedidos.FieldByName('CLI_ENDCOM').AsString;
      strEndNum := qryPedidos.FieldByName('CLI_ENDNUM').AsString;
      strC_E_P_ := qryPedidos.FieldByName('CLI_C_E_P_').AsString;
      strCodCid := qryPedidos.FieldByName('CLI_CODCID').AsString;
      strFone01 := qryPedidos.FieldByName('CLI_FONE01').AsString;
      strCgcCpf := qryPedidos.FieldByName('CLI_CGCCPF').AsString;
      strC_G_C_ := qryPedidos.FieldByName('CLI_C_G_C_').AsString;
      strEmail_ := qryPedidos.FieldByName('CLI_EMAIL_').AsString;
      strNum_Rg := qryPedidos.FieldByName('CLI_NUMR_G').AsString;
      strNumIes := qryPedidos.FieldByName('CLI_I_E_S_').AsString;
      strCodAti := '';
      dtaNascon := 0;
    End;

    strNomCid := fRetNomCidade(strCodCid);
    strEstado := fRetNomCidade(strCodCid, 1);
  End;
end;

procedure TAdiantamento.pAtualizarValorLancamentoDocumentos;
  Var
    I: Integer;
    fltFator : Double;
    fltTotLan: Double;
    fltTotDif: Double;
begin
  If Length(FInfAdiantamento.documentos) = 1 Then
  Begin
    FInfAdiantamento.documentos[0].fltValLan := FInfAdiantamento.fltValLan;
    Exit;
  End;

  fltTotLan := 0;
  For I := 0 To Length(FInfAdiantamento.documentos) -1 Do
    With FInfAdiantamento.documentos[I] Do
    Begin
      fltValLan := fltVlrCon - fltValAdt;
      fltTotLan := fltTotLan + fltValLan;
    End;

  If Assigned(FRegistroPix) Then
  Begin
    If fFormataFloat(FRegistroPix.ValorPago, 2) = fFormataFloat(FInfAdiantamento.fltValOrd, 2) Then
    Begin
      For I := 0 To Length(FInfAdiantamento.documentos) -1 Do
      Begin
        fltFator  := FInfAdiantamento.documentos[I].fltValLan / fltTotLan;
        FInfAdiantamento.documentos[I].fltValLan := fFormataFloat(FRegistroPix.ValorPago * fltFator, 2);
      End;

      fltTotLan := 0;
      For I := 0 To Length(FInfAdiantamento.documentos) -1 Do
        fltTotLan := fltTotLan + FInfAdiantamento.documentos[I].fltValLan;

      fltTotDif := fFormataFloat(FRegistroPix.ValorPago - fltTotLan, 2);

      If fltTotDif <> 0.00 Then
        FInfAdiantamento.documentos[0].fltValLan := FInfAdiantamento.documentos[0].fltValLan + fltTotDif;

      Exit;
    End;
  End;

  For I := 0 To Length(FInfAdiantamento.documentos) -1 Do
    With FInfAdiantamento.documentos[I] Do
    Begin
      fltFator  := fltValLan / fltTotLan;
      fltValLan := fFormataFloat(FInfAdiantamento.fltValLan * fltFator, 2);
    End;

  fltTotLan := 0;
  For I := 0 To Length(FInfAdiantamento.documentos) -1 Do
    fltTotLan := fltTotLan + FInfAdiantamento.documentos[I].fltValLan;

  fltTotDif := fFormataFloat(FInfAdiantamento.fltValLan - fltTotLan, 2);

  If fltTotDif <> 0.00 Then
    FInfAdiantamento.documentos[0].fltValLan :=
      FInfAdiantamento.documentos[0].fltValLan + fltTotDif;
end;

procedure TAdiantamento.pCancelarTefDeCartoesJaConfirmados;
  Var
    cartao: TCartoesResumoCaixa;
begin
  If (Vs_blnTefCitel) Then
  Begin
    pCancelarVendaConfirmadaTefCitel;
  End
  Else
  Begin
    For cartao In arrCartoes Do
    Begin
      If (FileExists(cartao.strArqTef)) Then
      Begin
        pGarantirCancelamentoTefRecebimento(cartao.strArqTef);
      End;
    End;
  End;
end;

procedure TAdiantamento.pCarregaImpostoProporcional(fltValor: Double; Out fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is: Double);
  Var
    documento: TDocAdiantamento;
    fltTotVlrCon: Double;
    fltProporcao: Double;
begin
  fltValIpi := 0;
  fltValRet := 0;
  fltValAce := 0;
  fltValFre := 0;
  fltValCbs := 0;
  fltValIbs := 0;
  fltVal_Is := 0;
  fltTotVlrCon := 0;

  For documento In FInfAdiantamento.documentos Do
    fltTotVlrCon := fltTotVlrCon + documento.fltVlrCon;

  fltProporcao := 0;
  //Calcula a proporcao do valor sendo recebido sobre o valor total do documento
  If (fltTotVlrCon > 0) Then
    fltProporcao := fltValor / fltTotVlrCon;

  For documento In FInfAdiantamento.documentos Do
  Begin
    //Aplica o fator para calcular o valor dos impostos sendo recebido
    fltValIpi := fltValIpi + documento.fltTotIpi * fltProporcao;
    fltValRet := fltValRet + documento.fltTotRet * fltProporcao;
    fltValAce := fltValAce + documento.fltDesAce * fltProporcao;
    fltValFre := fltValFre + documento.fltTotFre * fltProporcao;
    fltValCbs := fltValCbs + documento.fltTotCbs * fltProporcao;
    fltValIbs := fltValIbs + documento.fltTotIbs * fltProporcao;
    fltVal_Is := fltVal_Is + documento.fltTot_Is * fltProporcao;
  End;
end;

class procedure TAdiantamento.pConsultarAdiantamentos(strCodOpe, strNumPed,strEmpPed: String);
  Var
    FfrmConsultarAdiantamentos : TfrmConsultarAdiantamentos;
begin
  Try
    pCriarFormularios(TfrmConsultarAdiantamentos, FfrmConsultarAdiantamentos);
    FfrmConsultarAdiantamentos.strCodOpe := strCodOpe;
    FfrmConsultarAdiantamentos.pApenasConsulta(strNumPed,strEmpPed);
    FfrmConsultarAdiantamentos.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(FfrmConsultarAdiantamentos);
end;

class procedure TAdiantamento.pDesmembraAdiantamento(strNumDocAtual,
  strEspDocAtual, strCodEmpAtual, strNumDocNovo, strEspDocNovo,
  strCodEmpNovo: String; fltTotalPedido, fltTotalPedidoNovo: Double);
var
  AdiantamentoTotal,
  AdiantamentoDocAtual,
  AdiantamentoDocNovo: TTotaisAdiantamento;
  fltTotalPedidoAtual,
  fltFator: Double;
  intContador: Integer;
begin
  AdiantamentoTotal := fGetTotaisAdiantamento(strNumDocAtual, strEspDocAtual, strCodEmpAtual);

  if AdiantamentoTotal.fltValLan <= 0 Then
    Exit;

  intContador := 1;
  AdiantamentoDocAtual.fltValLan := 0;
  AdiantamentoDocNovo.fltValLan := 0;
  fltTotalPedidoAtual := fltTotalPedido - fltTotalPedidoNovo;

  while intContador < 9 do
  begin

    Case intContador of
      1:Begin
          fltFator := fFormataFloat(AdiantamentoTotal.fltValDin / fltTotalPedido, 2);
          AdiantamentoDocAtual.fltValDin := fFormataFloat(fltTotalPedidoAtual * fltFator, 2);
          AdiantamentoDocNovo.fltValDin := fFormataFloat(fltTotalPedidoNovo * fltFator, 2);
          AdiantamentoDocAtual.fltValLan := AdiantamentoDocAtual.fltValLan + AdiantamentoDocAtual.fltValDin;
          AdiantamentoDocNovo.fltValLan := AdiantamentoDocNovo.fltValLan + AdiantamentoDocNovo.fltValDin;
        End;

      2:Begin
          fltFator := fFormataFloat(AdiantamentoTotal.fltValChV / fltTotalPedido, 2);
          AdiantamentoDocAtual.fltValChV := fFormataFloat(fltTotalPedidoAtual * fltFator, 2);
          AdiantamentoDocNovo.fltValChV := fFormataFloat(fltTotalPedidoNovo * fltFator, 2);
          AdiantamentoDocAtual.fltValLan := AdiantamentoDocAtual.fltValLan + AdiantamentoDocAtual.fltValChV;
          AdiantamentoDocNovo.fltValLan := AdiantamentoDocNovo.fltValLan + AdiantamentoDocNovo.fltValChV;
        End;

      3:Begin
          fltFator := fFormataFloat(AdiantamentoTotal.fltValChP / fltTotalPedido, 2);
          AdiantamentoDocAtual.fltValChP := fFormataFloat(fltTotalPedidoAtual * fltFator, 2);
          AdiantamentoDocNovo.fltValChP := fFormataFloat(fltTotalPedidoNovo * fltFator, 2);
          AdiantamentoDocAtual.fltValLan := AdiantamentoDocAtual.fltValLan + AdiantamentoDocAtual.fltValChP;
          AdiantamentoDocNovo.fltValLan := AdiantamentoDocNovo.fltValLan + AdiantamentoDocNovo.fltValChP;
        End;

      4:Begin
          fltFator := fFormataFloat(AdiantamentoTotal.fltValCar / fltTotalPedido, 2);
          AdiantamentoDocAtual.fltValCar := fFormataFloat(fltTotalPedidoAtual * fltFator, 2);
          AdiantamentoDocNovo.fltValCar := fFormataFloat(fltTotalPedidoNovo * fltFator, 2);
          AdiantamentoDocAtual.fltValLan := AdiantamentoDocAtual.fltValLan + AdiantamentoDocAtual.fltValCar;
          AdiantamentoDocNovo.fltValLan := AdiantamentoDocNovo.fltValLan + AdiantamentoDocNovo.fltValCar;
        End;

      5:Begin
          fltFator := fFormataFloat(AdiantamentoTotal.fltValOrd / fltTotalPedido, 2);
          AdiantamentoDocAtual.fltValOrd := fFormataFloat(fltTotalPedidoAtual * fltFator, 2);
          AdiantamentoDocNovo.fltValOrd := fFormataFloat(fltTotalPedidoNovo * fltFator, 2);
          AdiantamentoDocAtual.fltValLan := AdiantamentoDocAtual.fltValLan + AdiantamentoDocAtual.fltValOrd;
          AdiantamentoDocNovo.fltValLan := AdiantamentoDocNovo.fltValLan + AdiantamentoDocNovo.fltValOrd;
        End;

      6:Begin
          fltFator := fFormataFloat(AdiantamentoTotal.fltValFin / fltTotalPedido, 2);
          AdiantamentoDocAtual.fltValFin := fFormataFloat(fltTotalPedidoAtual * fltFator, 2);
          AdiantamentoDocNovo.fltValFin := fFormataFloat(fltTotalPedidoNovo * fltFator, 2);
          AdiantamentoDocAtual.fltValLan := AdiantamentoDocAtual.fltValLan + AdiantamentoDocAtual.fltValFin;
          AdiantamentoDocNovo.fltValLan := AdiantamentoDocNovo.fltValLan + AdiantamentoDocNovo.fltValFin;
        End;

      7:Begin
          fltFator := fFormataFloat(AdiantamentoTotal.fltValCre / fltTotalPedido, 2);
          AdiantamentoDocAtual.fltValCre := fFormataFloat(fltTotalPedidoAtual * fltFator, 2);
          AdiantamentoDocNovo.fltValCre := fFormataFloat(fltTotalPedidoNovo * fltFator, 2);
          AdiantamentoDocAtual.fltValLan := AdiantamentoDocAtual.fltValLan + AdiantamentoDocAtual.fltValCre;
          AdiantamentoDocNovo.fltValLan := AdiantamentoDocNovo.fltValLan + AdiantamentoDocNovo.fltValCre;
        End;

      8:Begin
          fltFator := fFormataFloat(AdiantamentoTotal.fltValJur / fltTotalPedido, 2);
          AdiantamentoDocAtual.fltValJur := fFormataFloat(fltTotalPedidoAtual * fltFator, 2);
          AdiantamentoDocNovo.fltValJur := fFormataFloat(fltTotalPedidoNovo * fltFator, 2);
          AdiantamentoDocAtual.fltValLan := AdiantamentoDocAtual.fltValLan + AdiantamentoDocAtual.fltValJur;
          AdiantamentoDocNovo.fltValLan := AdiantamentoDocNovo.fltValLan + AdiantamentoDocNovo.fltValJur;
        End;

    End;

    Inc(intContador);
  end;

  pGravaAdiantamentoDesmembrado(strNumDocAtual,
                                strEspDocAtual,
                                strCodEmpAtual,
                                strNumDocNovo,
                                strEspDocNovo,
                                strCodEmpNovo,
                                AdiantamentoDocAtual,
                                AdiantamentoDocNovo);
end;

function TAdiantamento.fDigitacaoCartoes(fltValor: Double): Boolean;
  Var
    fltValIpi,
    fltValRet,
    fltValAce,
    fltValFre,
    fltValCbs,
    fltValIbs,
    fltVal_Is: Double;
    intTamMat: Integer;

    strCodCar: String;
    strDesCar: String;
    fltValDig: Double;
    dtaDatTra: TDateTime;
    fltValDes: Double;
    fltPerDes: Double;
    strCndPag: String;
    strObsCar: String;
    strNumCcd: String;
    strNumNsu: String;
    strArquivoTef: String;
    strTipCar: String;
    strSessaoTef : String;
    frmRcxDigCartoes : TfrmRcxDigCartoes;
    strViaCli: String;
    strViaLoj: String;
    strNumDoc: String;
    strDtaTra: String;
    strHraTra: String;
    strStatusCartao: String;
    strChaPix: String;
    strPixS_N: String;
    strCodigoCarteiraDigital: String;
    strCodigoTipoOperacaoCartao: String;
    strCodigoBandeira: String;
    LstrControle: String;
begin
  fltValDig := 0.0;
  fltValDes := 0.0;
  fltPerDes := 0.0;
  dtaDatTra := 0;

  Try
    pCriarFormularios(TfrmRcxDigCartoes, frmRcxDigCartoes);

    frmRcxDigCartoes.fltTotDig := 0.0;
    frmRcxDigCartoes.fltTotGer := fltValor;
    frmRcxDigCartoes.fltMaxDig := fltValor;
    frmRcxDigCartoes.blnTraVal := True;
    frmRcxDigCartoes.edtTotCar.ReadOnly := True;
    frmRcxDigCartoes.edtTotCar.TabStop  := False;
    frmRcxDigCartoes.arrCartoes := arrCartoes;
    frmRcxDigCartoes.blnF11    := True;
    frmRcxDigCartoes.objTefRecebimento := objTefRecebimento;
    frmRcxDigCartoes.blnTefRcx := fCfgSis('TEFREC', varBoolean);
    frmRcxDigCartoes.blnExecutandoPeloFaturamento := True;
    frmRcxDigCartoes.objTefCitelPagueFacil := objTefCitelPagueFacil;

    if VS_AutoatendimentoPagueFacil then
      frmRcxDigCartoes.blnExecutandoPeloFaturamento := False;

    If Not fEmptyStr(FInfAdiantamento.documentos[0].strCodCar) Then
    Begin
      frmRcxDigCartoes.strCodCar     := FInfAdiantamento.documentos[0].strCodCar;
      frmRcxDigCartoes.blnEhGrynCash := (frmRcxDigCartoes.strCodCar = fCfgSis('CARGRY'));
      if frmRcxDigCartoes.blnEhGrynCash then
      begin
        frmRcxDigCartoes.strNumCcd      := '.';
        frmRcxDigCartoes.edtNumCcd.Text := '.';
        frmRcxDigCartoes.strNumNsu      := '.';
        frmRcxDigCartoes.edtNumNsu.Text := '.';
      end;

      frmRcxDigCartoes.intQtdPar     := FInfAdiantamento.documentos[0].intQtdPaC;
      frmRcxDigCartoes.intQtdNeg     := FInfAdiantamento.documentos[0].intQtdPaC;

      If (Not fVerificaAcessoSistema('F11ALTCAR', FInfAdiantamento.strOpeLan)) and (not fTefHabilitado) Then
      Begin
        frmRcxDigCartoes.edtCodCar.ReadOnly := True;
        frmRcxDigCartoes.edtQtdPar.ReadOnly := True;
      End;
    End;

    frmRcxDigCartoes.strOpcDoc := 'AD';

    frmRcxDigCartoes.arrDocCartoes := fRetornaDocumentosTraDoc ;

    frmRcxDigCartoes.strRcxCodOpe := FInfAdiantamento.strOpeLan;

    If (frmRcxDigCartoes.fVaiExibirPerguntaTefPos) Then
      frmRcxDigCartoes.blnPermiteDigitarDados := False;

    If (FInfAdiantamento.blnPagueFacil) or
       (frmRcxDigCartoes.blnEhGrynCash) Then
      frmRcxDigCartoes.pExecutarSemTela
    Else
      frmRcxDigCartoes.ShowModal;

    If FInfAdiantamento.blnPagueFacil Then
      SetForegroundWindow(Application.Handle);

    strCodCar := frmRcxDigCartoes.edtCodCar.Text;
    strDesCar := frmRcxDigCartoes.edtDesCar.Text;
    fltValDig := frmRcxDigCartoes.fltValDig;
    dtaDatTra := frmRcxDigCartoes.dtaDatTra;
    fltValDes := frmRcxDigCartoes.fltValDes;
    strCndPag := frmRcxDigCartoes.mskCndPag.Text;
    strNumCcd := frmRcxDigCartoes.edtNumCcd.Text;
    strNumNsu := fPadL(frmRcxDigCartoes.edtNumNsu.Text, 14, '0');
    strObsCar := frmRcxDigCartoes.edtObsCar.Text;
    fltPerDes := frmRcxDigCartoes.fltPerDes;
    strArquivoTef := frmRcxDigCartoes.strArquivoTef;
    strTipCar := IIF(frmRcxDigCartoes.blnTipPOS, 'POS', 'TEF');
    strViaCli := frmRcxDigCartoes.strArqViaCliente;
    strViaLoj := frmRcxDigCartoes.strArqViaLojista;
    strNumDoc := frmRcxDigCartoes.strNumDoc;
    strDtaTra := frmRcxDigCartoes.strDtaTra;
    strHraTra := frmRcxDigCartoes.strHraTra;
    strStatusCartao := 'P';
    strChaPix := frmRcxDigCartoes.strChaPix;
    strPixS_N := frmRcxDigCartoes.strPixS_N;
    strCodigoCarteiraDigital := frmRcxDigCartoes.strCodigoCarteiraDigital;
    strCodigoTipoOperacaoCartao := frmRcxDigCartoes.strCodigoTipoOperacaoCartao;
    strCodigoBandeira := frmRcxDigCartoes.strCodigoBandeira;
    LstrControle := frmRcxDigCartoes.strControle;

    Result    := frmRcxDigCartoes.blnConfirma;
    strSessaoTef := frmRcxDigCartoes.strSessaoTef;

    If Not Result Then
      pCapturarMensagemTotem('TEF',
        'fDigitacaoCartoes não confirmado.' +
        ' Cartão: '     + strCodCar +
        ' Parcelas: '   + frmRcxDigCartoes.edtQtdPar.Text +
        ' NSU: '        + strNumNsu +
        ' CCD: '        + strNumCcd +
        ' ArqTef: '     + strArquivoTef +
        ' SessaoTef: '  + strSessaoTef);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmRcxDigCartoes);

  If (Result) Then
  Begin
    pCarregaImpostoProporcional(fltValDig, fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is);

    intTamMat := Length(arrCartoes);
    SetLength(arrCartoes, intTamMat+1);
    arrCartoes[intTamMat].intCodSeq := intTamMat;
    arrCartoes[intTamMat].strCodCar := strCodCar;
    arrCartoes[intTamMat].strDesCar := strDesCar;
    arrCartoes[intTamMat].fltValDig := fltValDig;
    arrCartoes[intTamMat].strCndPag := strCndPag;
    arrCartoes[intTamMat].strObsCar := strObsCar;
    arrCartoes[intTamMat].fltValDes := fltValDes;
    arrCartoes[intTamMat].strNumCcd := strNumCcd;
    arrCartoes[intTamMat].fltPerDes := fltPerDes;
    arrCartoes[intTamMat].strArqTef := strArquivoTef;
    arrCartoes[intTamMat].strTipCar := strTipCar;
    arrCartoes[intTamMat].dtaDtaTra := dtaDatTra;

    arrCartoes[intTamMat].fltValIpi := fltValIpi;
    arrCartoes[intTamMat].fltValRet := fltValRet;
    arrCartoes[intTamMat].fltValAce := fltValAce;
    arrCartoes[intTamMat].fltValFre := fltValFre;
    arrCartoes[intTamMat].fltValCbs := fltValCbs;
    arrCartoes[intTamMat].fltValIbs := fltValIbs;
    arrCartoes[intTamMat].fltVal_Is := fltVal_Is;
    arrCartoes[intTamMat].strPorCar := fCfgSis('PORCRT');
    arrCartoes[intTamMat].strCtaCar := fCfgSis('CTTRCR');

    If Assigned(VS_objTef) And (strTipCar = 'TEF') Then
    begin
      arrCartoes[intTamMat].strNumNsu := fPadL(VS_objTef.strNumNsu, 14, '0');
      arrCartoes[intTamMat].strPixS_N := VS_objTef.StrPixS_N;
      arrCartoes[intTamMat].strChaPix := VS_objTef.StrChaPix;
      arrCartoes[intTamMat].strCodigoCarteiraDigital := '' ;
      arrCartoes[intTamMat].strControle := '' ;
    end
    Else
    begin
      arrCartoes[intTamMat].strNumNsu := fPadL(strNumNsu, 14, '0');
      arrCartoes[intTamMat].strPixS_N := strPixS_N;
      arrCartoes[intTamMat].strChaPix := strChaPix;
      arrCartoes[intTamMat].strCodigoCarteiraDigital := strCodigoCarteiraDigital ;
      arrCartoes[intTamMat].strControle := LstrControle ;
    end;

    arrCartoes[intTamMat].strConteudoArquivo := '';

    If Not fEmptyStr(strArquivoTef) Then
    begin
      if (Vs_blnTefCitel) then
        arrCartoes[intTamMat].strConteudoArquivo := strArquivoTef
      else
        arrCartoes[intTamMat].strConteudoArquivo := fLerConteudoArquivo(strArquivoTef);
    end;

    if (VS_blnTefCitel) then
    begin
      arrCartoes[intTamMat].strViaCli := strViaCli;
      arrCartoes[intTamMat].strViaLoj := strViaLoj;
      arrCartoes[intTamMat].strNumDoc := strNumDoc;
      arrCartoes[intTamMat].strDtaTra := strDtaTra;
      arrCartoes[intTamMat].strHraTra := strHraTra;
      arrCartoes[intTamMat].strStatusCartao := strStatusCartao;
      if fAutoConfirmaTransacaoPendenteEstaAtivada then
      begin
        arrCartoes[intTamMat].strCodigoTipoOperacaoCartao := strCodigoTipoOperacaoCartao;
        arrCartoes[intTamMat].strCodigoBandeira := strCodigoBandeira;
        arrCartoes[intTamMat].blnTefCnf := fAutoConfirmarTransacaoTef(arrCartoes[intTamMat]);
        if arrCartoes[intTamMat].blnTefCnf then
          arrCartoes[intTamMat].strStatusCartao := 'F';
      end;
    end;
  End
  Else
  Begin
    if (Vs_blnTefCitel) then
      pCancelarVendaConfirmadaTefCitel
    Else
      pGarantirCancelamentoTefRecebimento(strArquivoTef);
  End;

end;

function TAdiantamento.fChequePre(fltValor: Double): Boolean;
Begin
  Result := True;

  cdsChqPre.EmptyDataSet;

  With cdsChqPre Do
  Begin
    Try
      pCriarFormularios(TfrmCadCheques,frmCadCheques);
      frmCadCheques.blnTroChq         := False; {(fCfgSis('TROCHQ', varBoolean))}
      frmCadCheques.strCodOpe         := FInfAdiantamento.strOpeLan;
      frmCadCheques.blnResCai         := True;
      frmCadCheques.blnResumida       := True;
      frmCadCheques.blnGravacaoFisica := False;
      frmCadCheques.fltValTot         := fltValor;
      frmCadCheques.blnPrazo          := True;
      frmCadCheques.cdsChqRcx         := cdsChqPre;
      frmCadCheques.blnTravaCli       := True;

      frmCadCheques.cdsChqOutroTip.Data := cdsChqVis.Data;

      frmCadCheques.RotinaChamada := 'ADIANTAMENTO DE CLIENTES';

      With FInfAdiantamento.documentos[0], objFormasNegociadas Do
      Begin
        frmCadCheques.strCliente := strCodCli;
        frmCadCheques.strConPag  := strConPag;

        If fFormaPagtoSelecionada('002') Then
        Begin
          frmCadCheques.strConPag := cdsFormasNegociadas.FieldByName('CONPAG').AsString;
          If (objFormasNegociadas.strCodFormaPagto = '009') And (cdsFormasNegociadas.FieldByName('DTACHQ').AsDateTime > 0) Then
            frmCadCheques.dtaDataChqPre := cdsFormasNegociadas.FieldByName('DTACHQ').AsDateTime; 
        End;

        frmCadCheques.strConPag := fGetCondicaoPrazo(frmCadCheques.strConPag);

        If frmCadCheques.strConPag = '01000' Then
          frmCadCheques.strConPag := '';

        If Length(FInfAdiantamento.documentos) = 1 Then
          frmCadCheques.strDocume  := strNumDoc + 'A' + strEspDoc + strCodEmp + 'PRZ'
        Else
          frmCadCheques.strDocume  := 'DIVERSOS-PRZ';
      End;

      frmCadCheques.ShowModal;

      cdsChqPre.Data := frmCadCheques.cdsTabela.Data;

      If IsEmpty Or (Not frmCadCheques.blnConfima) Then
      Begin
        Result := False;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

    pFreeAndNil(frmCadCheques);
  End;
End;

function TAdiantamento.fChequeVis(fltValor: Double): Boolean;
Begin
  Result := True;

  cdsChqVis.EmptyDataSet;

  With cdsChqVis Do
  Begin
    Try
      pCriarFormularios(TfrmCadCheques,frmCadCheques);
      frmCadCheques.blnTroChq         := False; {(fCfgSis('TROCHQ', varBoolean))}
      frmCadCheques.strCodOpe         := FInfAdiantamento.strOpeLan;
      frmCadCheques.blnResumida       := True;
      frmCadCheques.blnResCai         := True;
      frmCadCheques.blnGravacaoFisica := False;
      frmCadCheques.fltValTot         := fltValor;
      frmCadCheques.blnPrazo          := False;
      frmCadCheques.cdsChqRcx         := cdsChqVis;
      frmCadCheques.dbeDtaCad.Enabled := False;
      frmCadCheques.dbeDtaCad.TabStop := False;
      frmCadCheques.dbeDtaVen.Enabled := False;
      frmCadCheques.dbeDtaVen.TabStop := False;
      frmCadCheques.blnTravaCli       := True;

      frmCadCheques.cdsChqOutroTip.Data := cdsChqPre.Data;

      frmCadCheques.RotinaChamada := 'ADIANTAMENTO DE CLIENTES';

      With FInfAdiantamento.documentos[0] Do
      Begin
        frmCadCheques.strCliente := strCodCli;

        If Length(FInfAdiantamento.documentos) = 1 Then
          frmCadCheques.strDocume  := strNumDoc + 'A' + strEspDoc + strCodEmp + 'AVI'
        Else
          frmCadCheques.strDocume  := 'DIVERSOS-AVI';
      End;

      frmCadCheques.ShowModal;

      cdsChqVis.Data := frmCadCheques.cdsTabela.Data;

      If IsEmpty Or (Not frmCadCheques.blnConfima) Then
      Begin
        Result := False;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

    pFreeAndNil(frmCadCheques);
  End;

End;

function TAdiantamento.fConfirmarAdiantamento: Boolean;
  Var
    strInfConfCar : String;
    blnJaCommitou: boolean;
    strMensagemErroTEF: string;

  function fEtapa(const AstrEtapa: String; const AblnResultado: Boolean): Boolean;
  begin
    Result := AblnResultado;

    If Not Result Then
      pCapturarMensagemTotem('Adiantamento',
        'Etapa "' + AstrEtapa + '" retornou falso - adiantamento não concluído.');
  end;

begin
  pInformacaoGravacao('Aguarde, Confirmando Adiantamento...');

  If (FInfAdiantamento.fltValChV = 0) And cdsChqVis.Active Then
    cdsChqVis.EmptyDataSet;

  If (FInfAdiantamento.fltValChP = 0) And cdsChqPre.Active Then
    cdsChqPre.EmptyDataSet;

  If (FInfAdiantamento.fltValCre = 0) Then
  Begin
    stlDupCreditos.Clear;
  End;

  If (FInfAdiantamento.fltValCar = 0) And (Length(arrCartoes) > 0) Then
  Begin
    pAlteraStatusTefConfirmadoParaCancelado(False);
    pCancelarTefDeCartoesJaConfirmados;
    SetLength(arrCartoes, 0);
  End;

//  If Not fPergunta('Confirma adiantamento?') Then
//    Exit;

  blnJaCommitou := False;
  Try
    {*************************************************}
    {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
    {*********************************************JC**}
    FInfAdiantamento.intSeqCon := StrToInt(fRetRcxCon);

    FInfAdiantamento.strCodPorOrdPagto := FInfAdiantamento.strCodPor;
    If FInfAdiantamento.strOrigem = 'RCX' Then
    Begin
      FInfAdiantamento.strCodPor := RetornaPortadorOrdemPagametoPixCaixa(FInfAdiantamento.strCodPor, True);
      FInfAdiantamento.strCodPorOrdPagto := RetornaPortadorOrdemPagametoPixCaixa(FInfAdiantamento.strCodPor, False);
    End;

    {*************************************************}
    {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
    {*********************************************JC**}
    fRetSequencialMovCar('MOVCAR', VS_strCodEmp, arrCartoes);

    Result := fEtapa('fStartTransaction', fStartTransaction);

    If (FInfAdiantamento.strOrigem = 'RCX') Then
      Result := Result And fEtapa('fGravaResumoCaixa', fGravaResumoCaixa)
    Else
    begin
      if (objRotinaYapay.blnActive) then
      begin
        if (Length(arrCartoes) > 0) and
           (fStatusCndPag(arrCartoes[Low(arrCartoes)].strCndPag) = A_VISTA) then
          Result := Result And fEtapa('fGravaMovimentoBancario', fGravaMovimentoBancario);
      end
      else
        Result := Result And fEtapa('fGravaMovimentoBancario', fGravaMovimentoBancario);
    end;

    Result := Result And fEtapa('fGravarAdiantamento', fGravarAdiantamento);
    Result := Result And fEtapa('fLiberarPREPTE', fLiberarPREPTE);
    Result := Result And fEtapa('fGravarCartoes', fGravarCartoes);
    Result := Result And fEtapa('fGravarCheques', fGravarCheques);
    Result := Result And fEtapa('fBaixarCreditos', fBaixarCreditos);
    Result := Result And fEtapa('fGerarCredito', fGerarCredito);
    Result := Result And fEtapa('fGravarGrynCash', fGravarGrynCash);
    Result := Result And fEtapa('RealizarTFAutomatica', RealizarTFAutomatica);

    pInformacaoGravacao('Aguarde, Concluindo Adiantamento...');

    If Result Then
    begin
      If Not FInfAdiantamento.RecebidoPorPix Then
      Begin
        fCommit;
        blnJaCommitou := True;
      End;
    end
    Else
      fRollBack;

    If (FInfAdiantamento.fltValCar > 0.0) And (fCfgSis('USACTC', varBoolean)) Then
    Begin
      If Not objTefRecebimento.fConfirmaCartoes(strInfConfCar) Then
      Begin
        strMensagemErroTEF := 'Ocorreu um problema na confirmação do TEF.' +
                              'Favor verificar se os cartões foram confirmados.' + sLineBreak +
                              strInfConfCar;
        fMensagem('Atenção!', strMensagemErroTEF, ['&Ok']);
        pGravarErro(True, '[TAdiantamento.fConfirmarAdiantamento] -> (objTefRecebimento.fConfirmaCartoes) - ' + strMensagemErroTEF);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pGravarErro(True,'[TAdiantamento.fConfirmarAdiantamento] - ' + E.message + sLineBreak + e.StackTrace);
      pMensagensErro(E.Message, '');
    End;
  End;

  If Result Then
    pInformacaoGravacao('Adiantamento realizado com sucesso!')
  Else
    pInformacaoGravacao('Adiantamento não foi concluído!');

  if blnJaCommitou then
    Result := True;
end;

class function TAdiantamento.fGravaEstornoMovimentoBancario(ANumDoc: String;
                                                            AEspdoc: String;
                                                            ACodEmp: String;
                                                            ACodCli: String;
                                                            ADescri: String): Boolean;
Var
  LCreDeb: String;
  LSeqLan: String;
  LConsultaMovBan: TUniQuery;
  LSeqLanCred: String;
  lstBanCtr: TBanCtrRepository;
begin
  LSeqLanCred := fCampoTabela('CTB_SEQLAN', 'MOVBAN', ['CTB_NUMDOC', 'CTB_CODEMP', 'CTB_CREDEB', 'CTB_CODCLI'],
                                                      [ANumDoc, ACodEmp, 'C', ACodCli]);
  LSeqLan     := EmptyStr;
  Try
    LConsultaMovBan := TMovBanFunc.RetornaMovBanPorSeqLan(LSeqLanCred);

    If Not LConsultaMovBan.IsEmpty Then
    Begin
      LCreDeb := 'D';

      lstBanCtr := TBanCtrRepository.Create;
      lstBanCtr.fAdd(ANumDoc,
                     'A',
                     AEspdoc,
                     ACodEmp,
                     ACodCli,
                     ADescri,
                     '',
                     0,
                     LConsultaMovBan.FieldByName('CTB_VALLAN').AsFloat);

      LSeqLan := fGravaMovBan(LConsultaMovBan.FieldByName('CTB_CODCTA').AsString,
                              LConsultaMovBan.FieldByName('CTB_CODPOR').AsString,
                              LConsultaMovBan.FieldByName('CTB_CODOPE').AsString,
                              fNow(),
                              fTime,
                              LConsultaMovBan.FieldByName('CTB_NUMDOC').AsString,
                              LCreDeb,
                              LConsultaMovBan.FieldByName('CTB_CODEMP').AsString,
                              LConsultaMovBan.FieldByName('CTB_VALLAN').AsFloat,
                              ADescri,
                              EmptyStr,
                              LConsultaMovBan.FieldByName('CTB_CODCLI').AsString,
                              LConsultaMovBan.FieldByName('CTB_CODFOR').AsString,
                              LConsultaMovBan.FieldByName('CTB_NUMDUP').AsString,
                              LConsultaMovBan.FieldByName('CTB_SEQBAI').AsInteger,
                              LConsultaMovBan.FieldByName('CTB_PARCEL').AsString,
                              LConsultaMovBan.FieldByName('CTB_EMPDUP').AsString,
                              LConsultaMovBan.FieldByName('CTB_SERIE_').AsString,
                              LConsultaMovBan.FieldByName('CTB_CODEVE').AsString,
                              LConsultaMovBan.FieldByName('CTB_DOCBAI').AsString,
                              lstBanCtr.fGetList,
                              0,
                              0,
                              LConsultaMovBan.FieldByName('CTB_COMPET').AsString
                              );

      Result := Not fEmptyStr(LSeqLan);
    End
    Else
      Exit(True);

  Finally
    FreeAndNil(lstBanCtr);
  End;
end;

function TAdiantamento.fGravarAdiantamento: Boolean;
begin
  pInformacaoGravacao('Aguarde, Gravando Adiantamento...');

  FInfAdiantamento.dtaDtaLan := VS_Date;
  FInfAdiantamento.horHorLan := fTime();

  if objRotinaYapay.blnActive then
  begin
    FInfAdiantamento.dtaDtaLan := TDate(objRotinaYapay.BaixaSintetica.dtalancamento);
    FInfAdiantamento.horHorLan := TTime(objRotinaYapay.BaixaSintetica.dtalancamento);
  end;

  If FInfAdiantamento.RecebidoPorPix Then
    FInfAdiantamento.strEmpLan := FRegistroPix.CodigoEmpresa;
  
  Result := TAdiantamentoGenerico.fGravaAdiantamentoCliente(FInfAdiantamento);

  Result := Result And TAdiantamentoGenerico.fLiberaPedidoRetiraExpedicaoImpressaoSeparacaoMedianteAdiantamento(FInfAdiantamento);
end;

function TAdiantamento.fLiberarPREPTE: Boolean;
Var
  intIndex: Integer;
  documento: TDocAdiantamento;

  function fVaiLiberarPREPTEDocumento(): Boolean;
    Var
      strSitPed: String;
  begin
    Result := False;

    If (Not fExisteRegistroPREPTEDocumento(documento.strNumDoc,
                                           documento.strEspDoc,
                                           documento.strCodEmp)) Then
      Exit;

    strSitPed := TSituacaoPedidoVenda.fRetornaSituacaoAdiantamento(documento.strCodEmp,
                                                                   documento.strNumDoc,
                                                                   documento.strEspDoc);

    If (Not (strSitPed = apRealizado.fGetLegendaTexto)) then
      Exit;

    Result := True;
  end;
begin
  Result := True;

  If (Not (fCfgSis('LIBETE', VarInteger) = 1)) Then
    Exit;

  For intIndex := 0 To PRed(Length(FInfAdiantamento.documentos)) Do
  Begin
    documento := FInfAdiantamento.documentos[intIndex];

    If (Not fVaiLiberarPREPTEDocumento()) Then
      Continue;

    Result := TPreparaGeracaoTE.fLiberaItensDocumento(documento.strNumDoc,
                                                      documento.strEspDoc,
                                                      documento.strCodEmp);

    If (Not Result) Then
      Break;
  End;
end;

function TAdiantamento.fBaixarCreditos: Boolean;
begin
  With FInfAdiantamento Do
  Begin
    Result := True;
    If fltValCre > 0 Then
    Begin
      pInformacaoGravacao('Aguarde, Baixando duplicata(s) de crédito...');

      Result := Result And
        TFatVenda.fBaixaDuplicatasCredito(dtaDtaLan,
                                          VS_strCodEmp,
                                          documentos[0].strCodCli,
                                          fRetNomCliente(documentos[0].strCodCli),
                                          strOpeLan,
                                          documentos[0].strCodVen,
                                          IIF(strOrigem='RCX',fCfgSis('PORRCX'),strCodPor),
                                          '',
                                          '',
                                          '',
                                          fltValCre,
                                          stlDupCreditos,
                                          False,
                                          IIF(strOrigem='RCX',True,False), //Gravar Caixa (Caso True, passar o código do caixa)
                                          intSeqCon,
                                          FNomeForm,
                                          '',
                                          '',
                                          strCodPor,
                                          strCodCta,
                                          '',
                                          strCodigoCaixa); //Codigo do Caixa
    End;
  End;
end;

function TAdiantamento.fGravaResumoCaixa: Boolean;
  Var
    I: Integer;

    LRecebidoPorPix: String;
begin
  pInformacaoGravacao('Aguarde, Gravando Resumo de Caixa...');
  Result := True;

  untCadRcxx.intContaReg := Length(FInfAdiantamento.documentos);

  LRecebidoPorPix := 'N';
  If FInfAdiantamento.RecebidoPorPix Then
  Begin
    LRecebidoPorPix := 'S';

    If FRegistroPix.OrigemAdiantamento = 'RCX' Then
    Begin
      If strCodigoCaixa.IsEmpty Then
        strCodigoCaixa := FRegistroPix.CodigoDoCaixa;
    End;
  End;

  For I := 0 To Length(FInfAdiantamento.documentos) -1 Do
    Result := Result And
      fGravaCadRcx(strSeqRcx,                                         //autoincrem
                   FInfAdiantamento.documentos[I].strCodCli,          //Código do Cliente
                   FInfAdiantamento.strOpeLan,                        //Operador
                   FInfAdiantamento.documentos[I].strNumDoc,          //Documento
                   FInfAdiantamento.documentos[I].strEspDoc,          //Espécie
                   VS_strCodEmp,                                      //Empresa
                   FInfAdiantamento.dtaDtaLan,                        //Data de Cadastro
                   fTime(),                                           //Hora de Cadastro
                   FInfAdiantamento.documentos[I].strNumDoc,          //Duplicata
                   'A',                                               //Parcela
                   FInfAdiantamento.strDescri,                        //Descrição
                   '',                                                //Juros - Desconto
                   '',                                                //Identificação de Fechamento
                   '',                                                //Forma de Pagamento
                   FInfAdiantamento.documentos[I].fltValLan,          //Valor do Documento
                   0,                                                 //Desconto Recebido
                   0,                                                 //Juros Recebido
                   IIF(I > 0, 0, FInfAdiantamento.fltValDin),         //Valor em dinheiro
                   IIF(I > 0, 0, FInfAdiantamento.fltValChV),         //Valor em Cheque à Vista
                   IIF(I > 0, 0, FInfAdiantamento.fltValChP),         //Valor em Cheque Pré
                   IIF(I > 0, 0, FInfAdiantamento.fltValCar),         //Valor em Cartão
                   IIF(I > 0, 0, FInfAdiantamento.fltValOrd),         //Valor em Ordem de Pagamento
                   IIF(I > 0, 0, FInfAdiantamento.fltValCre),         //Valor de Crédito de Cliente
                   IIF(I > 0, 0, FInfAdiantamento.fltValFin),         //Valor em Financiamento
                   0.0,                                               //Valor em outras modalidades
                   0.0,                                               //Valor de venda a prazo
                   '',                                                //Num. do Romaneio
                   FInfAdiantamento.intSeqCon,                        //Sequencial de Controle
                   0,                                                 //Sequencial de Baixa (Duplicata)
                   fCfgSisL('SQFCRX'),                                //Sequencial de Fechamento parcial de caixa
                   FInfAdiantamento.documentos[0].strCodEmp,          //Empresa da duplicata
                   '',                                                //Motivo do desconto
                   1,                                                 //Identificação do Caixa
                   0,
                   0,
                   0,
                   0,
                   0,
                   'N',
                   '',
                   strCodigoCaixa,
                   '',
                   0.00,
                   False,
                   0.00,
                   '',
                   0,
                   LRecebidoPorPix);
end;

class function TAdiantamento.fHouveAlteracoesNoPedido(
  qryPedidos: TUniQuery): Boolean;
  Var
    dtaDtaEnt: TDateTime;
    horHorEnt: TDateTime;
begin
  Result := False;

  dtaDtaEnt := fCampoTabela('FGO_DTAENT', 'FATGOR', ['AUTOINCREM'],
    [qryPedidos.FieldByName('AUTOINCREM').AsString]);

  horHorEnt := fCampoTabela('FGO_HORENT', 'FATGOR', ['AUTOINCREM'],
    [qryPedidos.FieldByName('AUTOINCREM').AsString]);

  If dtaDtaEnt <> qryPedidos.FieldByName('FGO_DTAENT').AsDateTime Then
    Exit(True);

  If horHorEnt <> qryPedidos.FieldByName('FGO_HORENT').AsDateTime Then
    Exit(True);
end;

function TAdiantamento.fInformarDadosClienteConsumidor: Boolean;
  Var
    I: Integer;
    blnConsumidorInvalido: Boolean;

  function fValidaCPFConsumidor(doc: TDocAdiantamento): Boolean;
  begin
    Result := True;

    If Not fClienteConsumidor(fRetNomCliente(doc.strCodCli)) Then
      Exit;

    If fEmptyStr(doc.strC_G_C_) Then
      Exit(False);

    If fStringRepetida(doc.strC_G_C_) Then
      Exit(False);

    If Not fValidaCnpjCpf(doc.strCgcCpf,
                          doc.strC_G_C_, False) Then
      Exit(False);
  end;

begin
  Result := True;
  blnConsumidorInvalido := False;

  For I := 0 To Length(FInfAdiantamento.documentos) -1 Do
    blnConsumidorInvalido := blnConsumidorInvalido Or
      (Not fValidaCPFConsumidor(FInfAdiantamento.documentos[I]));

  If Not blnConsumidorInvalido Then
    Exit;

  If Not fPergunta('Deseja informar os dados do cliente consumidor?') Then
    Exit;

  Try
    pCriarFormularios(TfrmFatDadosCliConsumidor, frmFatDadosCliConsumidor);

    {*******************************************}
    {* CARREGANDO DADOS                        *}
    {****************************************AF*}
    frmFatDadosCliConsumidor.strCodCli      := FInfAdiantamento.documentos[0].strCodCli;           // - Código
    frmFatDadosCliConsumidor.edtNomCli.Text := FInfAdiantamento.documentos[0].strNomCli;           // - Nome
    frmFatDadosCliConsumidor.edtEndere.Text := FInfAdiantamento.documentos[0].strEndere;           // - Endereco
    frmFatDadosCliConsumidor.edtBairro.Text := FInfAdiantamento.documentos[0].strBairro;           // - Bairro
    frmFatDadosCliConsumidor.mskNumCep.Text := FInfAdiantamento.documentos[0].strC_E_P_;           // - Cep
    frmFatDadosCliConsumidor.edtCodCid.Text := FInfAdiantamento.documentos[0].strCodCid;           // - Cod. Cidade
    frmFatDadosCliConsumidor.edtNomCid.Text := FInfAdiantamento.documentos[0].strNomCid;           // - Cidade
    frmFatDadosCliConsumidor.edtEstado.Text := FInfAdiantamento.documentos[0].strEstado;           // - Estado
    frmFatDadosCliConsumidor.mskTelCon.Text := FInfAdiantamento.documentos[0].strFone01;           // - Telefone
    frmFatDadosCliConsumidor.edtCgcCpf.Text := FInfAdiantamento.documentos[0].strCgcCpf;           // - CGC/CPF
    frmFatDadosCliConsumidor.mskNumCgc.Text := FInfAdiantamento.documentos[0].strC_G_C_;           // - CNPJ
    frmFatDadosCliConsumidor.edtInsEst.Text := FInfAdiantamento.documentos[0].strNumIes;           // - Ins.Estadual
    frmFatDadosCliConsumidor.edtRgCli.Text  := FInfAdiantamento.documentos[0].strNum_RG;           // - Rg
    frmFatDadosCliConsumidor.edtCodAtividade.Text := FInfAdiantamento.documentos[0].strCodAti;     // - Codigo da Atividade
    If Not fEmptyStr(FInfAdiantamento.documentos[0].strCodAti) Then
      frmFatDadosCliConsumidor.edtNomAtividade.Text := fCampoTabela('ATI_DESATI', 'CADATI', ['ATI_CODATI'], [FInfAdiantamento.documentos[0].strCodAti]);

    frmFatDadosCliConsumidor.blnNasCon := FInfAdiantamento.documentos[0].dtaNasCon > 0;
    If FInfAdiantamento.documentos[0].dtaNasCon > 0 Then
      frmFatDadosCliConsumidor.mskDtaNas.Text := DateToStr(FInfAdiantamento.documentos[0].dtaNasCon);// - Data de Nascimento;

    If fEmptyStr(FInfAdiantamento.documentos[0].strEstado) Then
      frmFatDadosCliConsumidor.strEstado    := fRetUFEmpresa
    Else
      frmFatDadosCliConsumidor.strEstado    := FInfAdiantamento.documentos[0].strEstado;           // - Estado

    frmFatDadosCliConsumidor.blnCGCRep      := False;
    frmFatDadosCliConsumidor.edtEmail_.Text := FInfAdiantamento.documentos[0].strEmail_;           // - Email para NFe

    frmFatDadosCliConsumidor.blnUtilizarPreCadastroConsumidor := False;
    frmFatDadosCliConsumidor.strOpcDoc      := 'PD';
    frmFatDadosCliConsumidor.objVenda       := nil;

    frmFatDadosCliConsumidor.ShowModal;

    Result := frmFatDadosCliConsumidor.blnConfirma;

    {*******************************************}
    {* DADOS ALTERADOS                         *}
    {****************************************AF*}
    If frmFatDadosCliConsumidor.blnConfirma Then
      For I := 0 To Length(FInfAdiantamento.documentos) -1 Do
      Begin
        If fValidaCPFConsumidor(FInfAdiantamento.documentos[I]) Then
          Continue;

        FInfAdiantamento.documentos[I].strNomCli := frmFatDadosCliConsumidor.edtNomCli.Text;             // - Nome
        FInfAdiantamento.documentos[I].strEndere := frmFatDadosCliConsumidor.edtEndere.Text;             // - Endereco
        FInfAdiantamento.documentos[I].strBairro := frmFatDadosCliConsumidor.edtBairro.Text;             // - Bairro
        FInfAdiantamento.documentos[I].strC_E_P_ := frmFatDadosCliConsumidor.mskNumCep.Text;             // - Cep
        FInfAdiantamento.documentos[I].strCodCid := frmFatDadosCliConsumidor.edtCodCid.Text;             // - Cód. Cidade
        FInfAdiantamento.documentos[I].strNomCid := frmFatDadosCliConsumidor.edtNomCid.Text;             // - Cidade
        FInfAdiantamento.documentos[I].strEstado := frmFatDadosCliConsumidor.edtEstado.Text;             // - Estado
        FInfAdiantamento.documentos[I].strFone01 := frmFatDadosCliConsumidor.mskTelCon.Text;             // - Telefone
        FInfAdiantamento.documentos[I].strC_G_C_ := frmFatDadosCliConsumidor.mskNumCgc.Text;             // - CNPJ
        FInfAdiantamento.documentos[I].strNum_RG := frmFatDadosCliConsumidor.edtRgCli.Text;              // - RG
        FInfAdiantamento.documentos[I].strCodAti := frmFatDadosCliConsumidor.edtCodAtividade.Text;       // - Codigo da Atividade
        FInfAdiantamento.documentos[I].dtaNasCon := strToDateDef(frmFatDadosCliConsumidor.mskDtaNas.Text, 0);// - Data de Nascimento;

        If fEmptyStr(frmFatDadosCliConsumidor.edtCgcCpf.Text) Then
          FInfAdiantamento.documentos[I].strCgcCpf := '0'
        Else
          FInfAdiantamento.documentos[I].strCgcCpf := frmFatDadosCliConsumidor.edtCgcCpf.Text;           // - CGC/CPF

        FInfAdiantamento.documentos[I].strNumIes := frmFatDadosCliConsumidor.edtInsEst.Text;             // - Ins.Estadual
        FInfAdiantamento.documentos[I].strEmail_ := frmFatDadosCliConsumidor.edtEmail_.Text;             // - Email para NFe

        pAtualizaDadosConsumidor(FInfAdiantamento.documentos[I].strNumDoc,
                                 FInfAdiantamento.documentos[I].strEspDoc,
                                 FInfAdiantamento.documentos[I].strCodEmp,
                                 FInfAdiantamento.documentos[I].strCodCli,
                                 FInfAdiantamento.documentos[I].strC_G_C_,
                                 FInfAdiantamento.documentos[I].strNomCli,
                                 FInfAdiantamento.documentos[I].strEndere,
                                 FInfAdiantamento.documentos[I].strBairro,
                                 FInfAdiantamento.documentos[I].strC_E_P_,
                                 FInfAdiantamento.documentos[I].strCodCid,
                                 FInfAdiantamento.documentos[I].strEstado,
                                 FInfAdiantamento.documentos[I].strFone01,
                                 FInfAdiantamento.documentos[I].strCgcCpf,
                                 FInfAdiantamento.documentos[I].strNumIes,
                                 FInfAdiantamento.documentos[I].strNum_Rg,
                                 FInfAdiantamento.documentos[I].strEmail_,
                                 FInfAdiantamento.documentos[I].strCodAti, {Codigo da Atividade}
                                 FInfAdiantamento.documentos[I].dtaNasCon {Data de Nascimento});
      End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmFatDadosCliConsumidor);
end;

function TAdiantamento.fGravarCheques: Boolean;
  Var
    fltValIpi,
    fltValRet,
    fltValAce,
    fltValFre,
    fltValCbs,
    fltValIbs,
    fltVal_Is: Double;
Begin
  Try
    Result := True;

    With cdsChqPre Do
    Begin

      If (Active) And (Not IsEmpty) Then
      Begin
        First;

        pInformacaoGravacao('Aguarde, Gravando Cheques(Pré)...');

        While (Not Eof) Do
        Begin
          Application.ProcessMessages;

          pCarregaImpostoProporcional(FieldByName('CHQ_VALCHQ').AsFloat, fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is);

          Result := Result And
                    fGravaCheque(FieldByName('CHQ_CODBCO').AsString,
                                 FieldByName('CHQ_NUMAGE').AsString,
                                 FieldByName('CHQ_CONCOR').AsString,
                                 FieldByName('CHQ_NUMCHQ').AsString,
                                 FieldByName('CHQ_CODCLI').AsString,
                                 FieldByName('CHQ_NOMEMI').AsString,
                                 FieldByName('CHQ_ENDERE').AsString,
                                 FieldByName('CHQ_TELEMI').AsString,
                                 FieldByName('CHQ_CGCCPF').AsString,
                                 FieldByName('CHQ_C_G_C_').AsString,
                                 FieldByName('CHQ_HIST01').AsString,
                                 FieldByName('CHQ_HIST02').AsString,
                                 FieldByName('CHQ_CTADEP').AsString,
                                 FieldByName('CHQ_DOCDEP').AsString,
                                 FieldByName('CHQ_CODPOR').AsString,
                                 FieldByName('CHQ_CODCTA').AsString,
                                 FieldByName('CHQ_MOTDEV').AsString,
                                 FieldByName('CHQ_FORREP').AsString,
                                 FieldByName('CHQ_OBSREP').AsString,
                                 FieldByName('CHQ_CODEMP').AsString,
                                 FieldByName('CHQ_NUMNOT').AsString,
                                 FieldByName('CHQ_PORCUS').AsString,
                                 untCadRcxx.strDocChq + 'PRZ',
                                 'N',
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 FieldByName('CHQ_DTADEP').AsDateTime,
                                 FieldByName('CHQ_DTADEV').AsDateTime,
                                 FieldByName('CHQ_DTARDP').AsDateTime,
                                 FieldByName('CHQ_DTAREP').AsDateTime,
                                 FieldByName('CHQ_DTACUS').AsDateTime,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 '',
                                 FInfAdiantamento.intSeqCon,
                                 VS_strCodEmp,
                                 IIF(FInfAdiantamento.strOrigem = 'RCX', 1, 0),
                                 FieldByName('CHQ_TELCHE').AsString,
                                 FieldByName('CHQ_TELNUM').AsString,
                                 FieldByName('CHQ_CODOPE').AsString,
                                 FieldByName('CHQ_CODCMC').AsString,
                                 fltValIpi,
                                 fltValRet,
                                 fltValAce,
                                 fltValFre,
                                 FieldByName('CHQ_PORCHQ').AsString,
                                 FNomeForm,
                                 FieldByName('CHQ_NAODEP').AsString,
                                 FieldByName('CHQ_CODCID').AsString,
                                 IIF(FInfAdiantamento.strOrigem = 'RCX', strCodigoCaixa, ''),
                                 '',
                                 FInfAdiantamento.documentos[0].strIncAdt,
                                 fltValCbs,
                                 fltValIbs,
                                 fltVal_Is);

          {********************************}
          {* INSERE NO ARRAY DO CADCHQ(X) *}
          {*****************************JU*}
          If Result Then
            Result := fLogChq(cdsChqPre, 1);
          Next;
        End;

      End;

    End;

   {************************************}
   {* CHEQUE A VISTA                   *}
   {*********************************AF*}
    With cdsChqVis Do
    Begin

      If (Active) And (Not IsEmpty) Then
      Begin

        cdsChqVis.First;

        pInformacaoGravacao('Aguarde, Gravando Cheques(A Vista)...');

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          pCarregaImpostoProporcional(FieldByName('CHQ_VALCHQ').AsFloat, fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is);

          fGravaCheque( FieldByName('CHQ_CODBCO').AsString,
                        FieldByName('CHQ_NUMAGE').AsString,
                        FieldByName('CHQ_CONCOR').AsString,
                        FieldByName('CHQ_NUMCHQ').AsString,
                        FieldByName('CHQ_CODCLI').AsString,
                        FieldByName('CHQ_NOMEMI').AsString,
                        FieldByName('CHQ_ENDERE').AsString,
                        FieldByName('CHQ_TELEMI').AsString,
                        FieldByName('CHQ_CGCCPF').AsString,
                        FieldByName('CHQ_C_G_C_').AsString,
                        FieldByName('CHQ_HIST01').AsString,
                        FieldByName('CHQ_HIST02').AsString,
                        FieldByName('CHQ_CTADEP').AsString,
                        FieldByName('CHQ_DOCDEP').AsString,
                        FieldByName('CHQ_CODPOR').AsString,
                        FieldByName('CHQ_CODCTA').AsString,
                        FieldByName('CHQ_MOTDEV').AsString,
                        FieldByName('CHQ_FORREP').AsString,
                        FieldByName('CHQ_OBSREP').AsString,
                        FieldByName('CHQ_CODEMP').AsString,
                        FieldByName('CHQ_NUMNOT').AsString,
                        FieldByName('CHQ_PORCUS').AsString,
                        untCadRcxx.strDocChq + 'AVI',
                        'N',
                        FieldByName('CHQ_DTACAD').AsDateTime,
                        FieldByName('CHQ_DTAVEN').AsDateTime,
                        FieldByName('CHQ_DTADEP').AsDateTime,
                        FieldByName('CHQ_DTADEV').AsDateTime,
                        FieldByName('CHQ_DTARDP').AsDateTime,
                        FieldByName('CHQ_DTAREP').AsDateTime,
                        FieldByName('CHQ_DTACUS').AsDateTime,
                        FieldByName('CHQ_VALCHQ').AsFloat,
                        '',
                        FInfAdiantamento.intSeqCon,
                        VS_strCodEmp,
                        1,
                        FieldByName('CHQ_TELCHE').AsString,
                        FieldByName('CHQ_TELNUM').AsString,
                        FieldByName('CHQ_CODOPE').AsString,
                        FieldByName('CHQ_CODCMC').AsString,
                        fltValIpi,
                        fltValRet,
                        fltValAce,
                        fltValFre,
                        FieldByName('CHQ_PORCHQ').AsString,
                        FNomeForm,
                        FieldByName('CHQ_NAODEP').AsString,
                        FieldByName('CHQ_CODCID').AsString,
                        IIF(FInfAdiantamento.strOrigem = 'RCX', strCodigoCaixa, ''),
                        '',
                        FInfAdiantamento.documentos[0].strIncAdt,
                        fltValCbs,
                        fltValIbs,
                        fltVal_Is);

            {********************************}
            {* INSERE NO ARRAY DO CADCHQ(X) *}
            {*****************************JU*}
            Result := fLogChq(cdsChqVis, 2);

          Next;
        End;

      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

End;

function TAdiantamento.fGravarGrynCash: Boolean;
var
  objGryncash: TGryncash;
begin
  Result := True;
  {*************************************************}
  {* SALVA O VALOR NA CSHBCK DO CASHBACK UTILIZADO *}
  {***********************************************BL}
  if (FInfAdiantamento.documentos[0].blnCliGry) and
     (fCfgSis('USAGRY') = 'S') then
  begin
    objGryncash := TGryncash.Create(nil);
    try
      if not objGryncash.fSalvaCashBack(FInfAdiantamento.documentos[0].strCodEmp,
                                        FInfAdiantamento.documentos[0].strEspDoc,
                                        FInfAdiantamento.documentos[0].strNumDoc,
                                        FInfAdiantamento.documentos[0].fltCshGry) then
        Exit(False);

    finally
      FreeAndNil(objGryncash);
    end;
  end;
end;

function TAdiantamento.fGerarCredito: Boolean;
  Var
    objCadRec  : TCadRec;
    objCtrRep  : TCadRecRepository;
    strPortador: String;
begin
  If fFormataFloat(FInfAdiantamento.fltCreGer, 2) <= 0 Then
    Exit(True);

  pInformacaoGravacao('Aguarde, gerando duplicata(s) de crédito...');

  strPortador := fRetornaPortadorCliente(FInfAdiantamento.documentos[0].strCodCli);

  If fEmptyStr(strPortador) Then
    strPortador := FInfAdiantamento.strCodPor;

  objCadRec            := TCadRec.Create;
  objCadRec.AUTOINCREM := fRetAutoIncrem('CADREC', VS_strCodEmp);
  objCadRec.CTR_NUMDUP := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);
  objCadRec.CTR_PARCEL := 'A';
  objCadRec.CTR_SEQBAI := 0;
  objCadRec.CTR_ESPDOC := 'CC';
  objCadRec.CTR_CODEMP := VS_strCodEmp;
  objCadRec.objCodCli  := TCAdCliRepository.Create.fRetCadCli(FInfAdiantamento.documentos[0].strCodCli);
  objCadRec.CTR_CODVEN := FInfAdiantamento.documentos[0].strCodVen;
  objCadRec.CTR_CODDIG := FInfAdiantamento.strOpeLan;
  objCadRec.CTR_CODPOR := strPortador;
  objCadRec.CTR_DTACAD := VS_Date;
  objCadRec.CTR_DTAVEN := VS_Date;
  objCadRec.CTR_VALDUP := fFormataFloat(-FInfAdiantamento.fltCreGer, 2);
  objCadRec.CTR_VALORI := fFormataFloat(-FInfAdiantamento.fltCreGer, 2);
  objCadRec.CTR_GRVORI := fFormataFloat(-FInfAdiantamento.fltCreGer, 2);
  objCadRec.CTR_HIST01 := 'REF. LANC. CREDITO ADIANTAMENTO';
  objCadRec.CTR_VALJUR := 0.00;
  objCadRec.CTR_VALDES := 0.00;
  If Not fEmptyStr(fCfgSis('CTR_CC')) Then
    objCadRec.CTR_CODCTA := fCfgSis('CTR_CC');

  objCtrRep := TCadRecRepository.Create;
  objCtrRep.pGravar(objCadRec);

  objCadRec.CTR_SEQCON := FInfAdiantamento.intSeqCon;
  objCadRec.CTR_RESCAI := IIF(FInfAdiantamento.strOrigem = 'CTR', 0, 1);

  untLogCtr.GravaLogCtr(objCadRec.AUTOINCREM,
                        'INCLUSÃO',
                        'untAdiantamentoCliente',
                        strLoginUsuarioLogado,
                        objCadRec.CTR_SEQCON,
                        objCadRec.CTR_RESCAI);

  If Assigned(objCtrRep) Then
    FreeandNil(objCtrRep);

  Result := True;
end;

function TAdiantamento.fGravarCartoes: Boolean;
  Var
    strCodCar: String;
    strDesCar: String;
    fltValTot: Double;
    strConPag: String;
    strNumCcd: String;
    strHisTor: String;
    fltPerCar: Double;
    fltValDes: Double;
    strTipCar: String;
    strNumNsu: String;
    strDocumentos: String;
    documento: TDocAdiantamento;

    dtaDatTra: TDateTime;

    fltCarIpi: Double;
    fltCarRet: Double;
    fltCarAce: Double;
    fltCarFre: Double;
    fltCarCbs: Double;
    fltCarIbs: Double;
    fltCar_Is: Double;

    intContador1: Integer;
    intContador2: Integer;
    intContCopia: Integer;

    arrDuplicata,
    arrDuplOri  : TArrDigDuplicArray;

    arrDuplicCarIpi: TArrDigDuplicArray;
    arrDuplicCarRet: TArrDigDuplicArray;
    arrDuplicCarAce: TArrDigDuplicArray;
    arrDuplicCarFre: TArrDigDuplicArray;
    arrDuplicCarCbs: TArrDigDuplicArray;
    arrDuplicCarIbs: TArrDigDuplicArray;
    arrDuplicCar_Is: TArrDigDuplicArray;

    objArredondaParcela: IArredondaParcela;

    dtaDtaLan: TDateTime;

    strDocumeCartao: String;

    lstValOri: TList<Double>;
    lstValSta: TList<Double>;
    lstValDup: TList<Double>;
    fltValOri: Double;
    fltValDup: Double;
    fltValSta: Double;
    fltValTax: Double;
    fltResto: Double;

    strChaPix: String;
    strPixS_N: String;
    strCodigoCarteiraDigital: String;
    LstrControle: String;

    LDataBaseCartao: TDateTime;
    LTipoParcelamento: String;
begin
  Result := True;
  {*******************************************}
  {* REALIZA GRAVAÇÃO DO CARTÃO              *}
  {****************************************MV*}
  If (FInfAdiantamento.fltValCar > 0.0) And
     (fCfgSis('USACTC', varBoolean) And fCfgSis('DIGCAR', varBoolean)) Then
  Begin
    pInformacaoGravacao('Aguarde, Gravando Cartões...');

    For intContador1 := 0 To Length(arrCartoes) -1 Do
    Begin

      strCodCar := arrCartoes[intContador1].strCodCar;
      strDesCar := arrCartoes[intContador1].strDesCar;
      fltValTot := arrCartoes[intContador1].fltValDig;
      strConPag := arrCartoes[intContador1].strCndPag;
      strNumCcd := arrCartoes[intContador1].strNumCcd;
      strHisTor := arrCartoes[intContador1].strObsCar;
      fltPerCar := arrCartoes[intContador1].fltPerDes;
      fltValDes := arrCartoes[intContador1].fltValDes;
      strTipCar := arrCartoes[intContador1].strTipCar;
      dtaDatTra := arrCartoes[intContador1].dtaDtaTra;

      fltCarIpi := arrCartoes[intContador1].fltValIpi;
      fltCarRet := arrCartoes[intContador1].fltValRet;
      fltCarAce := arrCartoes[intContador1].fltValAce;
      fltCarFre := arrCartoes[intContador1].fltValFre;
      fltCarCbs := arrCartoes[intContador1].fltValCbs;
      fltCarIbs := arrCartoes[intContador1].fltValIbs;
      fltCar_Is := arrCartoes[intContador1].fltVal_Is;
      strNumNsu := IIF(objRotinaYapay.blnActive, arrCartoes[intContador1].strNumNsu, fPadL(arrCartoes[intContador1].strNumNsu, 14, '0'));
      strChaPix := arrCartoes[intContador1].strChaPix;
      strPixS_N := arrCartoes[intContador1].strPixS_N;
      strCodigoCarteiraDigital := arrCartoes[intContador1].strCodigoCarteiraDigital;
      LstrControle := arrCartoes[intContador1].strControle;

      LTipoParcelamento := '';

      {$IFNDEF LINUX}
        LTipoParcelamento := fCampoTabela('CAR_ARRPAR', 'CADCAR', ['CAR_CODCAR'], [strCodCar]);

        If (strTipCar = 'POS') And (LTipoParcelamento <> 'N') Then
          objArredondaParcela := TArredondaParCartaoPos.fArredondamentoParcelas(strCodCar)
        Else
          objArredondaParcela := fArredondamentoParcelas(strCodCar);
      {$ELSE}
        objArredondaParcela := fArredondamentoParcelas(strCodCar);
      {$ENDIF LINUX}

      dtaDtaLan := VS_Date;
      if objRotinaYapay.blnActive then
        dtaDtaLan := TDate(objRotinaYapay.Cartao.dtaDataCadastro);

      LDataBaseCartao := RetornaDataBaseCartao(dtaDtaLan, dtaDatTra);

      fDigDuplicVar(strConPag, 0, fltValTot, False, False, False, LDataBaseCartao, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);
      SetLength(arrDuplOri, Length(arrDuplicata));

      For intContCopia := 0 To Length(arrDuplicata) - 1 Do
        arrDuplOri[intContCopia] := arrDuplicata[intContCopia];

      fDigDuplicVar(strConPag, 0, fltValDes, False, False, False, LDataBaseCartao, False, arrDuplicata   , 0, 'N', False, False, 0, objArredondaParcela);
      fDigDuplicVar(strConPag, 0, fltCarIpi, False, False, False, LDataBaseCartao, False, arrDuplicCarIpi, 0, 'N', False, False, 0, objArredondaParcela);
      fDigDuplicVar(strConPag, 0, fltCarRet, False, False, False, LDataBaseCartao, False, arrDuplicCarRet, 0, 'N', False, False, 0, objArredondaParcela);
      fDigDuplicVar(strConPag, 0, fltCarAce, False, False, False, LDataBaseCartao, False, arrDuplicCarAce, 0, 'N', False, False, 0, objArredondaParcela);
      fDigDuplicVar(strConPag, 0, fltCarFre, False, False, False, LDataBaseCartao, False, arrDuplicCarFre, 0, 'N', False, False, 0, objArredondaParcela);
      fDigDuplicVar(strConPag, 0, fltCarCbs, False, False, False, LDataBaseCartao, False, arrDuplicCarCbs, 0, 'N', False, False, 0, objArredondaParcela);
      fDigDuplicVar(strConPag, 0, fltCarIbs, False, False, False, LDataBaseCartao, False, arrDuplicCarIbs, 0, 'N', False, False, 0, objArredondaParcela);
      fDigDuplicVar(strConPag, 0, fltCar_Is, False, False, False, LDataBaseCartao, False, arrDuplicCar_Is, 0, 'N', False, False, 0, objArredondaParcela);

      intContador2 := 0;

      strDocumentos := '';
      For documento In FInfAdiantamento.documentos Do
      Begin
        If strDocumentos <> '' Then strDocumentos := strDocumentos + ', ';
          strDocumentos := strDocumentos + documento.strNumDoc + 'A-' +
                                           documento.strEspDoc + '-' +
                                           documento.strCodEmp;
      End;

      lstValOri := nil;
      lstValSta := nil;
      lstValDup := nil;

      if objRotinaYapay.blnActive then
      begin
        lstValOri := TList<Double>.Create;
        lstValOri.Clear;

        lstValSta := TList<Double>.Create;
        lstValSta.Clear;

        lstValDup := TList<Double>.Create;
        lstValDup.Clear;

        fltValOri := objRotinaYapay.Cartao.fltValorPago;
        fltValOri := fltValOri / objRotinaYapay.Cartao.intQuantidadeParcelas;
        fltValOri := fTruncaFloat(fltValOri, 2);

        fltValSta := objRotinaYapay.Cartao.fltValorOriginal;
        fltValSta := fltValSta / objRotinaYapay.Cartao.intQuantidadeParcelas;
        fltValSta := fTruncaFloat(fltValSta, 2);

        fltValDup := objRotinaYapay.Cartao.fltValorPago;
        fltValDup := fltValDup / objRotinaYapay.Cartao.intQuantidadeParcelas;
        fltValDup := fTruncaFloat(fltValDup, 2);

        for intContador2 := Low(arrDuplicata) to High(arrDuplicata) do
        begin
          lstValOri.Add(fltValOri);
          lstValSta.Add(fltValSta);
          lstValDup.Add(fltValDup);

          if intContador2 = High(arrDuplicata) then
          begin
            fltResto := objRotinaYapay.Cartao.fltValorPago - (fltValOri * objRotinaYapay.Cartao.intQuantidadeParcelas);
            lstValOri[intContador2] := fltValOri + fTruncaFloat(fltResto, 2);

            fltResto := objRotinaYapay.Cartao.fltValorOriginal - (fltValSta * objRotinaYapay.Cartao.intQuantidadeParcelas);
            lstValSta[intContador2] := fltValSta + fTruncaFloat(fltResto, 2);

            fltResto := objRotinaYapay.Cartao.fltValorPago - (fltValDup * objRotinaYapay.Cartao.intQuantidadeParcelas);
            lstValDup[intContador2] := fltValDup + fTruncaFloat(fltResto, 2);
          end;
        end;
        intContador2 := 0;
      end;

      While (intContador2 < Length(arrDuplicata)) And (Not fEmptyStr(arrDuplicata[intContador2].strSequen)) Do
      Begin
        fltValOri := arrDuplicata[intContador2].curValor;
        fltValDup := arrDuplicata[intContador2].curValor;
        fltValSta := arrDuplOri[intContador2].curValor;
        fltValTax := arrDuplOri[intContador2].curValor - arrDuplicata[intContador2].curValor;

        if objRotinaYapay.blnActive then
        begin
          fltValOri := lstValOri[intContador2];
          fltValDup := lstValDup[intContador2];
          fltValSta := lstValSta[intContador2];
          fltValTax := fltValSta - fltValDup;
        end;

        strDocumeCartao := untCadRcxx.strDocume + '-000';

        If FInfAdiantamento.blnPagueFacil Then
          With FInfAdiantamento.documentos[0] Do
            strDocumeCartao := untFuncoesSimples.fDocumeCar(
              strNumDoc, strEspDoc, strCodEmp, intContador1);

        If SameValue(fltValDup, 0) Then
        Begin
          Result := False;
          fRollback;
          pMensagemOk('O valor do cartão não pode ser zero, verifique os dados e tente novamente. '+
                      'Caso o erro persista, favor entrar em contato com a Citel.');
          Break;
        End;

        If SameValue(fltValOri, 0) Then
        Begin
          Result := False;
          fRollback;
          pMensagemOk('O valor original do cartão não pode ser zero, verifique os dados e tente novamente. '+
                      'Caso o erro persista, favor entrar em contato com a Citel.');
          Break;
        End;

        If SameValue(fltValSta, 0) Then
        Begin
          Result := False;
          fRollback;
          pMensagemOk('O valor do cartão sem taxa não pode ser zero, verifique os dados e tente novamente. '+
                      'Caso o erro persista, favor entrar em contato com a Citel.');
          Break;
        End;

        Result := fGravaMovCar('untAdiantamentoCliente',
                               'INCLUSÃO',
                               arrCartoes[intContador1].strNumDup,
                               FInfAdiantamento.documentos[0].strCodCli,
                               arrDuplicata[intContador2].strSequen,
                               VS_strCodEmp,
                               strCodCar,
                               dtaDtaLan,
                               StrToDate(arrDuplicata[intContador2].dtaDtaVen),
                               fltValOri, 
                               fltValDup, 
                               strHisTor,
                               'REF. AO DOC(S). ' + strDocumentos,
                               strConPag,
                               0,
                               0.0,
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               fltPerCar,
                               fltValSta, 
                               fltValTax, 
                               strNumCcd,
                               strDocumeCartao,
                               '',
                               FInfAdiantamento.intSeqCon,
                               VS_strCodEmp,
                               FInfAdiantamento.strOpeLan,
                               FInfAdiantamento.strOrigem = 'RCX',
                               '',
                               'F',
                               '',
                               strTipCar,
                               arrDuplicCarIpi[intContador2].curValor,
                               arrDuplicCarRet[intContador2].curValor,
                               arrDuplicCarAce[intContador2].curValor,
                               arrDuplicCarFre[intContador2].curValor,
                               strNumNsu,
                               '',
                               dtaDatTra,
                               0,
                               0,
                               0,
                               IIF(FInfAdiantamento.strOrigem = 'RCX', strCodigoCaixa, ''),
                               objRotinaYapay.blnActive,
                               '',
                               strChaPix,
                               strPixS_N,
                               0,
                               False,
                               strCodigoCarteiraDigital,
                               LstrControle,
                               FInfAdiantamento.documentos[0].strIncAdt,
                               0,
                               '',
                               '',
                               '',
                               arrDuplicCarCbs[intContador2].curValor,
                               arrDuplicCarIbs[intContador2].curValor,
                               arrDuplicCar_Is[intContador2].curValor);

        Inc(intContador2);

        If (Not Result) Then
          Break;
      End;

      if objRotinaYapay.blnActive then
      begin
        lstValOri.free;
        lstValSta.free;
        lstValDup.free;
      end;


      Result := Result And fGravaMovTef(FInfAdiantamento.intSeqCon,
                                        VS_strCodEmp,
                                        arrCartoes[intContador1].strNumDup,
                                        VS_strCodEmp,
                                        FInfAdiantamento.documentos[0].strCodCli,
                                        arrCartoes[intContador1].strConteudoArquivo);
    End;

  End;

end;

function TAdiantamento.fLogChq(qryLog: TDataset; intOpcao: Integer): Boolean;
  Var
    repCadChq: TCadChqRepository;
    strHist: String;
begin

  Try
    Result := True;
    strHist := 'INSERINDO CHQ. ' + IIF(intOpcao = 1, 'PRE. ', 'VIS. ') + '(' + FNomeForm +'.fLogChq)';

    repCadChq := TCadChqRepository.Create;
    With qryLog Do
    Begin
      repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                          FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                          strHist);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  FreeAndNil(repCadChq);

end;

class function TAdiantamento.fCarregarArrayAdiantamentos(intSeqConPar: Integer;
  strCodEmpPar: String): TArrAdiantamentos;
  Var
    qryAdtCli: TUniQuery;
    qryPedido: TUniQuery;
begin
  SetLength(Result, 0);

  qryAdtCli := fCriaQuery;

  With qryAdtCli, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM ADTCLI WHERE ADT_SEQCON =:SEQCON AND ADT_EMPLAN =:CODEMP');

    ParamByName('SEQCON').AsInteger := intSeqConPar;
    ParamByName('CODEMP').AsString  := strCodEmpPar;

    Open;
    First;

    SetLength(Result, RecordCount);

    While Not Eof Do
    Begin
      With Result[recNo-1] Do
      Begin
        FillChar(Result[recNo-1], SizeOf(Result[recNo-1]), #0);

        SetLength(documentos, 1);
        documentos[0].strNumDoc := FieldByName('ADT_NUMDOC').AsString;
        documentos[0].strEspDoc := FieldByName('ADT_ESPDOC').AsString;
        documentos[0].strCodEmp := FieldByName('ADT_CODEMP').AsString;
        documentos[0].strCodCli := FieldByName('ADT_CODCLI').AsString;

        fltValLan := FieldByName('ADT_VALLAN').AsFloat;
        dtaDtaLan := FieldByName('ADT_DTALAN').AsDateTime;
        horHorLan := FieldByName('ADT_HORLAN').AsDateTime;
        strEmpLan := FieldByName('ADT_EMPLAN').AsString;
        strOpeLan := FieldByName('ADT_OPELAN').AsString;
        fltValDin := FieldByName('ADT_VALDIN').AsFloat;
        fltValChV := FieldByName('ADT_VALCHV').AsFloat;
        fltValChP := FieldByName('ADT_VALCHP').AsFloat;
        fltValCar := FieldByName('ADT_VALCAR').AsFloat;
        fltValOrd := FieldByName('ADT_VALORD').AsFloat;
        fltValFin := FieldByName('ADT_VALFIN').AsFloat;
        fltValCre := FieldByName('ADT_VALCRE').AsFloat;
        strTipLan := FieldByName('ADT_TIPLAN').AsString;
        strDescri := FieldByName('ADT_DESCRI').AsString;
        strEstorn := FieldByName('ADT_ESTORN').AsString;
        intSeqCon := FieldByName('ADT_SEQCON').AsInteger;

        RecebidoPorPix := FieldByName('ADT_RECPIX').AsString = 'S';

        qryPedido := fCriaQuery;

        qryPedido.Close;
        qryPedido.SQL.Clear;

        qryPedido.SQL.Add(fGetSQLPedidos(documentos[0].strNumDoc));

        qryPedido.ParamByName('NUMDOC').AsString := documentos[0].strNumDoc;
        qryPedido.ParamByName('ESPDOC').AsString := documentos[0].strEspDoc;
        qryPedido.ParamByName('CODEMP').AsString := documentos[0].strCodEmp;

        qryPedido.Open;

        fCarregarDadosPedido(qryPedido, documentos, strOrigem);

        FreeAndNil(qryPedido);
      End;

      Next;
    End;

    Close;
  End;

  FreeAndNil(qryAdtCli);
end;

class function TAdiantamento.fGerarCreditoSaldoAdiantamento(strNumDoc,
                                                            strEspDoc,
                                                            strCodEmp,
                                                            strNomeForm,
                                                            strCodOpe    : String;
                                                            blnPerguntar : Boolean = True;
                                                            strCodCli_   : String  = '';
                                                            fltValorCred : Double = 0.0;
                                                            intSeqConRcxExterno: Integer = -1;
                                                            strHisAdc: String = ''): Boolean;
Var
  blnComita: Boolean;
  totAdtCli: TTotaisAdiantamento;
  intSeqCon: Integer;
  strCodCli: String;
  strDocCre: String;
  strHistor: String;
  blnResCaiAdt: Boolean;

  LRecebidoPorPix: Boolean;

  LPortador,
  LPlanoDeContasPix: String;
  strSeqRec : String;
begin

  totAdtCli := fGetTotaisAdiantamento(strNumDoc, strEspDoc, strCodEmp);

  If totAdtCli.fltValLan <= 0.00 Then
  Begin
    pMensagemOk('Não há saldo disponível para gerar documento de crédito para o cliente!');
    Exit(False);
  End;

  LRecebidoPorPix := False;
  If totAdtCli.fltValOrd > 0 Then
    LRecebidoPorPix := AdiantamentoRecebidoPorPix(strNumDoc, strEspDoc, strCodEmp);

  If fFormataFloat(fltValorCred, 2) <= 0.00 Then
    fltValorCred := totAdtCli.fltValLan;

  If fFormataFloat(fltValorCred, 2) > fFormataFloat(totAdtCli.fltValLan, 2) Then
  Begin
    pMensagemOk('O Valor do crédito não pode ser maior que o saldo disponível de adiantamentos do pedido!');
    Exit(False);
  End;

  If blnPerguntar Then
  Begin
    If Not fPergunta('Esta operação transformará o saldo de adiantamento do pedido ' +
                     strNumDoc + '-' + strEspDoc + '-' + strCodEmp + ', no valor de ' +
                     FormatFloat('R$ #,##0.00', fltValorCred) +
                     ' em crédito no conta corrente do cliente. ' +
                     'Deseja continuar a operação?') Then
    Begin
      Exit(False);
    End;
  End;

  LPortador := fCfgSis('PCTRCC');
  If LPortador.IsEmpty Then
    LPortador := fCampoTabela('CND_CODPOR', 'CADCND', ['CND_CODIGO'], [fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, 'CODCND')]);

  If LPortador.IsEmpty Then
  Begin
    If fInTransaction Then
      fRollback;

    pMensagemOk('O sistema irá gerar um crédito nessa operação e a configuração do portador está vazia. '+
                'Faça o ajuste ou peça para o responsável ajustar a configuração e depois refaça a operação. '+sLineBreak+
                '[CFG_PCTRCC[ - Portador - Geração de Crédito de Cliente provenientes de adiantamento!');
    Exit(False);
  End;

  If Not fEmptyStr(strCodCli_) Then
    strCodCli := strCodCli_
  Else
    strCodCli := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, 'CODCLI');

  strHistor := 'REF. SALDO DE ADIANTAMENTO DO PEDIDO ' +
    strNumDoc + '-' + strEspDoc + '-' + strCodEmp + ', TRANSFORMADO EM CRÉDITO' + IIF(fEmptyStr(strHisAdc),'.',strHisAdc);

  LPlanoDeContasPix := EmptyStr;
  If LRecebidoPorPix Then
    LPlanoDeContasPix := RetornaPlanoDeContasPix;

  Try
    blnComita := False;

    If Not fInTransaction Then
    Begin
      fStartTransaction;
      blnComita := True;
    End;

    strDocCre := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);
    If (intSeqConRcxExterno = -1) Then
      intSeqCon := StrToInt(fRetRcxCon)
    Else
      intSeqCon := intSeqConRcxExterno;

    blnResCaiAdt := fGetResCaiAdiantamento(strNumDoc, strEspDoc, strCodEmp, strCodCli);

    Result := fGravaCadRec(strSeqRec,
                           strNomeForm,
                           'INCLUSÃO',
                           strDocCre,                                                          // Duplicata
                           'A',                                                                // Parcela
                           0,                                                                  // Sequencial de Baixa
                           'CC',                                                               // Espécie
                           strCodCli,                                                          // Cliente
                           VS_strCodEmp,                                                       // Empresa
                           strCodOpe,                                                          // Vendedor
                           strCodOpe,                                                          // Digitador
                           LPortador,                                                          // Portador
                           VS_Date,                                                            // Data de Cadastro
                           VS_Date,                                                            // Data de Vencimento
                           -fltValorCred,                                                      // Valor da Duplicata
                           -fltValorCred,                                                      // Valor Original
                           0.0,                                                                // Despesa de Cobrança
                           'N',                                                                // Desconto
                           strHistor,                                                          // Histórico 1
                           '',                                                                 // Histórico 2
                           '',                                                                 // Portador da Baixa
                           '',                                                                 // Centro de Custo da Baixa
                           '',                                                                 // Operador da Baixa
                           '',                                                                 // Documento da Baixa
                           0.0,                                                                // Valor do Recebimento
                           0,                                                                  // Data do Recebimento
                           'S',
                           '',                                                                 // Código do Evento
                           '',                                                                 // Código Velho (CONVERSÃO)
                           '',                                                                 // Tipo de Fora (Condição de Pagamento)
                           '',                                                                 // Código da Condição de Pagamento
                           False,
                           LPlanoDeContasPix,                                                  // Codigo do Centro de Custo
                           intSeqCon,                                                                  // Sequencial de Controle
                           0,
                           '',                                                                 // Observação de Agrupamento 1
                           '',                                                                 // Observação de Agrupamento 2
                           '',                                                                 // Observação de Agrupamento 3
                           '',
                           0,
                           IIF(blnResCaiAdt, 1, 0),
                           0,
                           0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           '',
                           0,
                           0,
                           'N',
                           0,
                           0,
                           totAdtCli.fltValChP,
                           totAdtCli.fltValChV,
                           totAdtCli.fltValDin + totAdtCli.fltValCre,
                           totAdtCli.fltValCar,
                           totAdtCli.fltValOrd,
                           totAdtCli.fltValFin);

    pAtualizaVinculoComCredito(strNumDoc, strEspDoc, strCodEmp, strSeqRec);

    strHistor := 'REF. SALDO ADIANTAMENTO TRANSFORMADO ' +
      'EM CREDITO (' + strDocCre + '-CC-' + VS_strCodEmp + ')';

    Result := Result And fLancarDebitoAdiantamento(strNumDoc,
                                                   strEspDoc,
                                                   strCodEmp,
                                                   strCodOpe,
                                                   strHistor,
                                                   fltValorCred,
                                                   intSeqCon,
                                                   totAdtCli,
                                                   strCodCli_);

    If blnComita Then
    Begin
      If Result Then
        fCommit
      Else
        fRollback;
    End;

  Except
    On E: Exception Do
    Begin
      fRollback;
      Result := False;
      pMensagensErro(E.Message, '[fGerarCreditoSaldoAdiantamento]');
    End;
  End;

end;

class function TAdiantamento.fAdiantamentoGravadoAutomaticamente(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
var
  qryAdiantamento: TUniQuery;
begin
  Result := False;

  If Not fCfgSis('BADAUT', varBoolean) Then
    Exit;

  qryAdiantamento := fCriaQuery;

  Try
    With qryAdiantamento Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT ADT_NUMDOC FROM ADTCLI ');
      SQL.Add('WHERE ADT_NUMDOC = :NUMDOC AND ');
      SQL.Add('      ADT_ESPDOC = :ESPDOC AND ');
      SQL.Add('      ADT_CODEMP = :CODEMP AND ');
      SQL.Add('      ADT_CODCLI = :CODCLI AND ');
      SQL.Add('      ADT_TIPLAN = "C"         ');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      Open;

      Result := Not IsEmpty;

      Close;
    End;

  Finally
    FreeAndNil(qryAdiantamento);
  End;
end;

class function TAdiantamento.fAdiantamentoGravadoAutomaticamentePorSeq(strSeqFgo: String): Boolean;
var
  qryAdiantamento: TUniQuery;
begin
  Result := False;

  If Not fCfgSis('BADAUT', varBoolean) Then
    Exit;

  qryAdiantamento := fCriaQuery;

  Try
    With qryAdiantamento Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT A.AUTOINCREM FROM FATGOR F ');
      SQL.Add('INNER JOIN ADTCLI A ON A.ADT_NUMDOC = F.FGO_NUMDOC AND ');
      SQL.Add('		       A.ADT_ESPDOC = F.FGO_ESPDOC AND ');
      SQL.Add('		       A.ADT_CODEMP = F.FGO_CODEMP AND ');
      SQL.Add('		       A.ADT_CODCLI = F.FGO_CODCLI ');
      SQL.Add('WHERE F.AUTOINCREM = ' + strSeqFgo);

      Open;

      Result := Not IsEmpty;

      Close;
    End;

  Finally
    FreeAndNil(qryAdiantamento);
  End;
end;

class function TAdiantamento.fGetCodCtaAdiantamento(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): String;
begin
  Result := fCampoTabela('ADT_CODCTA', 'ADTCLI', ['ADT_NUMDOC', 'ADT_ESPDOC',
    'ADT_CODEMP', 'ADT_CODCLI','ADT_TIPLAN','ADT_ESTORN'], [strNumDoc, strEspDoc, strCodEmp, strCodCli, 'C', 'N']);
end;

class function TAdiantamento.fGetCodPorAdiantamento(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): String;
begin
  Result := fCampoTabela('ADT_CODPOR', 'ADTCLI', ['ADT_NUMDOC', 'ADT_ESPDOC',
    'ADT_CODEMP', 'ADT_CODCLI','ADT_TIPLAN','ADT_ESTORN'], [strNumDoc, strEspDoc, strCodEmp, strCodCli, 'C', 'N']);
end;

class function TAdiantamento.fGetOpeLanAdiantamento(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): String;
begin
  Result := fCampoTabela('ADT_OPELAN', 'ADTCLI', ['ADT_NUMDOC', 'ADT_ESPDOC',
    'ADT_CODEMP', 'ADT_CODCLI','ADT_TIPLAN','ADT_ESTORN'], [strNumDoc, strEspDoc, strCodEmp, strCodCli, 'C', 'N']);
end;

class function TAdiantamento.fGetResCaiAdiantamento(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): Boolean;
begin
  Result := fCampoTabela('ADT_RESCAI',
                         'ADTCLI',
                         ['ADT_NUMDOC',
                          'ADT_ESPDOC',
                          'ADT_CODEMP',
                          'ADT_CODCLI',
                          'ADT_TIPLAN',
                          'ADT_ESTORN'],
                         [strNumDoc,
                          strEspDoc,
                          strCodEmp,
                          strCodCli,
                          'C',
                          'N']) = '1';
end;

class function TAdiantamento.fGetSQLPedidos(strNumDoc: String = '';
                                            blnFiltrarTodasAsLojas: Boolean = False;
                                            objRotinaYapay: TRotinaYapay = nil;
                                            ARecebimentoPorPix: Boolean = False;
                                            APagFacilPix: Boolean = False): String;
  Const
    SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO = ' IFNULL( ' +
      ' ( SELECT '+
      '     SUM( IF(ADT_TIPLAN = "D", ADT_VALLAN * -1, ADT_VALLAN) ) '+
      '   FROM                            '+
      '     ADTCLI                        '+
      '   WHERE ADT_CODCLI = FGO_CODCLI   '+
      '     AND ADT_NUMDOC = FGO_NUMDOC   '+
      '     AND ADT_ESPDOC = FGO_ESPDOC   '+
      '     AND ADT_CODEMP = FGO_CODEMP ), 0) ';
begin
  Result := '';
  Result := Result +  'SELECT SQL_NO_CACHE ';
  Result := Result +  '  FGO_DTAENT, ';
  Result := Result +  '  FGO_HORENT, ';
  Result := Result +  '  FGO_NUMDOC, ';
  Result := Result +  '  FGO_ESPDOC, ';
  Result := Result +  '  FGO_CODEMP, ';
  Result := Result +  '  FGO_CODCLI, ';
  Result := Result +  '  FGO_CODVEN, ';
  Result := Result +  '  FGO_VLRCON, ';
  Result := Result +  '  IFNULL(FGO_TOTBRI, 0) AS FGO_TOTBRI, ';
  Result := Result +  '  FGO_BOLADT, ';
  Result := Result +  '  FGO_TOTIPI, ';
  Result := Result +  '  FGO_TOTRET, ';
  Result := Result +  '  FGO_DESACE, ';
  Result := Result +  '  FGO_TOTFRE, ';
  Result := Result +  '  FGO_ENT_CD, ';
  Result := Result +  '  IF(FGO_ENT_CD = "S", FGO_EMP_CD, FGO_CODEMP) AS EMPDES, ';
  Result := Result +  '  FGO_CODCND, ';
  Result := Result +  '  FGO_CODFPG AS FGO_FPGORI, ';
  Result := Result +  '  IF(FGO_CODFPG = "016", "009", FGO_CODFPG) AS FGO_CODFPG, ';
  Result := Result +  '  FPG_DESCRI, ';
  Result := Result +  '  FGO_CONPAG, ';
  Result := Result +  '  FGO_LIBCOM, ';
  Result := Result +  '  FGO_LIBERA, ';
  Result := Result +  '  FGO_CODCAR, ';
  Result := Result +  '  FGO_QTDPAC, ';
  Result := Result +  '  FGO_TX_PIX, ';
  Result := Result +  '  FGO_EMPPIX, ';
  Result := Result +  '  CND_CNDPAG, ';
  Result := Result +  '  CND_DESCRI, ';
  Result := Result +  '  CAST("" AS CHAR(255)) AS CONPAG, ';

  //Dados do cliente (cadastro)
  Result := Result +  '  CLI_CODCLI, ';
  Result := Result +  '  CLI_NOMCLI, ';
  Result := Result +  '  CLI_CGCCPF, ';
  Result := Result +  '  CLI_C_G_C_, ';
  Result := Result +  '  CLI_C_E_P_, ';
  Result := Result +  '  CLI_CODCID, ';
  Result := Result +  '  CLI_ENDERE, ';
  Result := Result +  '  CLI_ENDNUM, ';
  Result := Result +  '  CLI_BAIRRO, ';
  Result := Result +  '  CLI_ENDCOM, ';
  Result := Result +  '  CLI_FONE01, ';
  Result := Result +  '  CLI_EMAIL_, ';
  Result := Result +  '  CLI_NUMR_G, ';
  Result := Result +  '  CLI_I_E_S_, ';

  //Dados cliente consumidor
  Result := Result +  '  FGO_NOMCON, ';
  Result := Result +  '  FGO_CGCCPF, ';
  Result := Result +  '  FGO_CGCCON, ';
  Result := Result +  '  FGO_CEPCON, ';
  Result := Result +  '  FGO_CIDCON, ';
  Result := Result +  '  FGO_ENDCON, ';
  Result := Result +  '  FGO_BAICON, ';
  Result := Result +  '  FGO_TELCON, ';
  Result := Result +  '  FGO_EMLCON, ';
  Result := Result +  '  FGO_R_GCON, ';
  Result := Result +  '  FGO_IESCON, ';
  Result := Result +  '  FGO_NASCON, ';
  Result := Result +  '  FGO_CODATI, ';

  Result := Result +  '  FGO_MEN001, ';
  Result := Result +  '  FGO_MEN002, ';
  Result := Result +  '  FGO_MENEXP, ';
  Result := Result +  '  FGO_MENEX2, ';
  Result := Result +  '  FGO_MENEX3, ';
  Result := Result +  '  FGO_MENEX4, ';

  //Nome do cliente
  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI',
                                             'CONCAT(FGO_CODCLI, " - ", FGO_NOMCON)',
                                             'CONCAT(FGO_CODCLI, " - ", CLI_NOMCLI)') +
                                             ' AS NOMCLI, ';
  //Dados do vendedor
  Result := Result +  '  CONCAT(OPE_CODOPE, " - ", OPE_NOMOPE) AS NOMVEN, ';

  //Valor do adiantamento ja realizado
  Result := Result +  SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' AS VLRADT,';

  //Situação do adiantamento (Pendente, Parcialmente, Realizado)
  Result := Result +  '   CASE ';
  Result := Result +  '     WHEN ' + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' = 0 THEN "Pendente" ';
  Result := Result +  '     WHEN ' + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' < (FGO_VLRCON - IFNULL(FGO_TOTBRI, 0) - FGO_BOLADT) THEN "Parcialmente" ';
  Result := Result +  '     ELSE "Realizado" ';
  Result := Result +  '   END AS SITADT, ';

  Result := Result +  '  FGO_TIPOPE, ';

  Result := Result +  '  EXTGOR.FGO_SEQDMP, ';//Sequencial de desmembramento de pedido
  Result := Result +  '  FATGOR.AUTOINCREM  ';

  if (fCfgSis('CONEQU') = 'S') then
  begin
    Result := Result +  '  , EQUGER.EQU_NUMOSE ';

    if (fCfgSis('PROSER') = 'S') then
      Result := Result +  '  , EQUGER.EQU_PROTOC ';
  end;

  Result := Result +  'FROM  ';
  Result := Result +  '  FATGOR ';
  Result := Result +  '  LEFT JOIN CADCLI ON CADCLI.CLI_CODCLI = FATGOR.FGO_CODCLI ';
  Result := Result +  '  LEFT JOIN CADOPE ON CADOPE.OPE_CODOPE = FATGOR.FGO_CODVEN ';
  Result := Result +  '  LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  Result := Result +  '  LEFT JOIN CADATI ON CADATI.ATI_CODATI = EXTGOR.FGO_CODATI ';
  Result := Result +  '  LEFT JOIN CADCND ON CADCND.CND_CODIGO = FATGOR.FGO_CODCND ';
  Result := Result +  '  LEFT JOIN CADFPG ON CADFPG.FPG_CODIGO = IF(FATGOR.FGO_CODFPG = "016", "009", FATGOR.FGO_CODFPG) ';
  Result := Result +  '  LEFT JOIN EQUGER ON FATGOR.FGO_NUMDOC = EQUGER.EQU_NUMPED ';
  Result := Result +  '                   AND FATGOR.FGO_CODEMP = EQUGER.EQU_EMPPED ';
  Result := Result +  '                   AND FATGOR.FGO_ESPDOC = EQUGER.EQU_TIPPED ';
  Result := Result +  'WHERE ';

  If Not ARecebimentoPorPix Then
  Begin
    If blnFiltrarTodasAsLojas Then
      Result := Result +  '  ((' + fGetSQLInEmpresasAcesso('FGO_CODEMP') + ') OR (' + fGetSQLInEmpresasAcesso('FGO_EMP_CD') + ')) AND '
    Else
    Begin
      If fEmptyStr(strNumDoc) Then
        Result := Result +  '  ((FGO_CODEMP = :CODEMP) OR (FGO_EMP_CD = :CODEMP)) AND '
      Else
        Result := Result +  '  FGO_CODEMP = :CODEMP AND '
    End;

    Result := Result +  '  FGO_ESPDOC = :ESPDOC AND ';

    If fEmptyStr(strNumDoc) Then
      Result := Result +  '  FGO_JAFATU = 0       AND '
    Else
      Result := Result +  '  FGO_NUMDOC = :NUMDOC AND ';
  End
  Else
  Begin
    If Not APagFacilPix Then
    Begin
      Result := Result +  '  EXTGOR.FGO_EMPPIX=:EMPPIX AND ';
      Result := Result +  '  EXTGOR.FGO_TX_PIX=:TX_PIX AND ';
    End
    Else
    Begin
      Result := Result +  '  FATGOR.FGO_NUMDOC=:NUMDOC AND ';
      Result := Result +  '  FATGOR.FGO_ESPDOC=:ESPDOC AND ';
      Result := Result +  '  FATGOR.FGO_CODEMP=:CODEMP AND ';
    End;
  End;

  if (Assigned(objRotinaYapay)) and (objRotinaYapay.blnActive) then
    Result := Result +  '  TRUE /*PEDIDO YAPAY*/ '
  Else If ARecebimentoPorPix Then
    Result := Result +  '  TRUE /*PEDIDO PIX*/ '
  else If fCfgSis('TFPF11', VarBoolean) Or fCfgSis('SFPGPD', VarBoolean) Then
    Result := Result +  '  LOCATE(FGO_CODFPG, "' + strFormasPagtoAdiantamento + '_015_016_") '
  Else
    Result := Result +  '  LOCATE(FGO_CODFPG, "' + strFormasPagtoAdiantamento + '_008_010_014_015_016_") ';

  if fCfgSis('CONSIG', varBoolean) then
    Result := Result + ' AND FGO_ENVCON = "N" ';

  Result := Result +  'ORDER BY  ';
  Result := Result +  '  FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP ';
end;

class function TAdiantamento.fCarregaPedidos(qryPedidos: TUniQuery): Boolean;
begin
  With qryPedidos, SQL Do
  Begin
    Close;
    Clear;

    Add(fGetSQLPedidos('', fCfgSis('ADTALL', varBoolean)));

    ParamByName('ESPDOC').AsString := 'PD';
    If Not fCfgSis('ADTALL', varBoolean) Then
      ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    TStringField(FieldByName('FGO_NUMDOC')).Alignment := taCenter;
    TStringField(FieldByName('FGO_ESPDOC')).Alignment := taCenter;
    TStringField(FieldByName('FGO_CODEMP')).Alignment := taCenter;
    TStringField(FieldByName('CONPAG'    )).ReadOnly  := False;

    TStringField(FieldByName('EMPDES'    )).Alignment := taCenter;

    TFloatField(FieldByName('FGO_VLRCON')).Alignment     := taRightJustify;
    TFloatField(FieldByName('FGO_VLRCON')).DisplayFormat := '#,##0.00';

    TFloatField(FieldByName('VLRADT')).Alignment     := taRightJustify;
    TFloatField(FieldByName('VLRADT')).DisplayFormat := '#,##0.00';

    TFloatField(FieldByName('FGO_TOTBRI')).Alignment     := taRightJustify;
    TFloatField(FieldByName('FGO_TOTBRI')).DisplayFormat := '#,##0.00';

    TFloatField(FieldByName('FGO_BOLADT')).Alignment     := taRightJustify;
    TFloatField(FieldByName('FGO_BOLADT')).DisplayFormat := '#,##0.00';

    TDateTimeField(FieldByName('FGO_DTAENT')).Alignment := taCenter;
    TDateTimeField(FieldByName('FGO_HORENT')).Alignment := taCenter;

    Result := Not IsEmpty;
  End;
end;

class function TAdiantamento.fCarregarDadosPedido(qryPedidos: TUniQuery;
  var documentos: TArrDocAdiantamento; strOrigem: String; ARecebimentoPorPix: Boolean = False): Boolean;
  Var
    strAutInc: String;
    strSeqDmp: String;
    strCodFpg: String;
    strCodCli: String;
    arrPedidos: TStringArray;
    strSelecionados: String;

  function fNumeroPedido: String;
  begin
    Result := qryPedidos.FieldByName('FGO_NUMDOC').AsString + '-' +
              qryPedidos.FieldByName('FGO_ESPDOC').AsString + '-' +
              qryPedidos.FieldByName('FGO_CODEMP').AsString;

    If qryPedidos.FieldByName('FGO_ENT_CD').AsString <> 'S' Then
      Result := Result + ' (Faturamento na própria loja)'
    Else
      Result := Result + ' (Faturamento na loja ' +
        qryPedidos.FieldByName('EMPDES').AsString+ ')';
  end;

  function fSelecionarVariosPedidosParaAdiantamento: Boolean;
  begin
    strSelecionados := '';

    qryPedidos.First;

    While Not qryPedidos.Eof Do
    Begin
      If ARecebimentoPorPix Then
        strSelecionados := strSelecionados + '"' +
                           fNumeroPedido + '", ';

      pAddDados(arrPedidos, fNumeroPedido);
      qryPedidos.Next;
    End;

    If Not ARecebimentoPorPix Then
      strSelecionados := untSelOpcoes.fSelOpcoes('Selecionar pedidos para adiantamento', arrPedidos, True);

    If fEmptyStr(strSelecionados) Then
      Exit(False);

    SetLength(documentos, 0);

    qryPedidos.First;

    While Not qryPedidos.Eof Do
    Begin
      If Pos(fNumeroPedido, strSelecionados) > 0 Then
      Begin
        SetLength(documentos, Length(documentos) + 1);
        pAtribuiDadosDocumento(qryPedidos, documentos[Length(documentos)-1]);
      End;
      qryPedidos.Next;
    End;

    qryPedidos.First;

    Result := True;
  end;

  procedure pSelecionarPedidoAtualParaAdiantamento;
  begin
    qryPedidos.Filtered := False;
    qryPedidos.Filter   := '';
    qryPedidos.Locate('AUTOINCREM', strAutInc, []);//Para posicionar novamente no pedido correto
    SetLength(documentos, 1);
    pAtribuiDadosDocumento(qryPedidos, documentos[0]);
  end;

begin
  inherited;
  Result := False;

  If qryPedidos.IsEmpty Then
    Exit;

  strAutInc := qryPedidos.FieldByName('AUTOINCREM').AsString;
  strSeqDmp := qryPedidos.FieldByName('FGO_SEQDMP').AsString;
  strCodCli := qryPedidos.FieldByName('FGO_CODCLI').AsString;
  strCodFpg := qryPedidos.FieldByName('FGO_CODFPG').AsString;

  If (strOrigem = 'CTR') And
     (Not fClienteConsumidor(qryPedidos.FieldByName('CLI_NOMCLI').AsString)) Then
  Begin
    Try
      qryPedidos.Filtered := False;
      qryPedidos.Filter   := 'FGO_CODCLI = ' + strCodCli.QuotedString + ' AND ' +
                             'FGO_VLRCON > VLRADT ';

      If fCfgSis('SFPGPD', VarBoolean) Then
        qryPedidos.Filter := qryPedidos.Filter +
          ' AND FGO_CODFPG = ' + strCodFpg.QuotedString;

      qryPedidos.Filtered := True;

      If (Not ARecebimentoPorPix) And
         ((qryPedidos.RecordCount <= 1) Or
         (Not fPergunta('Este cliente possui outros pedidos em aberto. ' +
           'Deseja selecionar todos os pedidos para realizar um único adiantamento?'))) Then
      Begin
        pSelecionarPedidoAtualParaAdiantamento;
      End
      Else If Not fSelecionarVariosPedidosParaAdiantamento Then
        Exit(False);
    Finally
      qryPedidos.Filtered := False;
      qryPedidos.Filter   := '';
    End;
  End
  Else If Not fEmptyStr(strSeqDmp) And (strOrigem = 'RCX') Then
  Begin
    Try
      qryPedidos.Filtered := False;
      qryPedidos.Filter   := 'FGO_SEQDMP = ' + strSeqDmp.QuotedString;
      qryPedidos.Filtered := True;

      If (Not ARecebimentoPorPix) And
         ((qryPedidos.RecordCount = 1) Or
          (Not fPergunta('Este documento possui origem em desmembramento de pedidos. '+
            'Deseja selecionar todos os pedidos para realizar um único adiantamento?'))) Then
      Begin
        pSelecionarPedidoAtualParaAdiantamento;
      End
      Else If Not fSelecionarVariosPedidosParaAdiantamento Then
        Exit(False);
    Finally
      qryPedidos.Filtered := False;
      qryPedidos.Filter   := '';
    End;
  End
  Else
  Begin
    If Not ARecebimentoPorPix Then
      pSelecionarPedidoAtualParaAdiantamento
    Else
      fSelecionarVariosPedidosParaAdiantamento;
  End;

  Result := True;
end;

class function TAdiantamento.fAdiantamentoPossuiCreditosBaixados(strCodEmp: String;
  intSeqCon: Integer): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT C.AUTOINCREM ' +
                          'FROM LOGCTR L ' +
                          'LEFT JOIN CADREC C ON C.CTR_NUMDUP=L.CTR_NUMDUP ' +
                          '                  AND C.CTR_PARCEL=L.CTR_PARCEL ' +
                          '                  AND C.CTR_ESPDOC=L.CTR_ESPDOC ' +
                          '                  AND C.CTR_CODEMP=L.CTR_CODEMP ' +
                          '                  AND C.CTR_CODCLI=L.CTR_CODCLI ' +
                          'WHERE L.CTR_SEQCON=:SEQCON ' +
                          '  AND L.CTR_CODEMP=:CODEMP ' +
                          '  AND L.CTR_ESPDOC="CC" ' +
                          '  AND L.CTR_DESCRI IN("INCLUSÃO", "INCLUSÃO LD") ' +
                          '  AND C.CTR_DTAREC IS NOT NULL ';

    LConsulta.ParamByName('SEQCON').AsInteger := intSeqCon;
    LConsulta.ParamByName('CODEMP').AsString  := strCodEmp;
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

class function TAdiantamento.fAdiantamentoPossuiDebitos(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String; blnIgnorarEstornos: Boolean = True): Boolean;
  Var
    qryAdiantamentos: TUniQuery;
begin
  Try
    Result := False;

    qryAdiantamentos := fCriaQuery;

    If fCarregarAdiantamentos(strNumDoc, strEspDoc, strCodEmp, strCodCli, qryAdiantamentos) Then
    Begin
      qryAdiantamentos.First;

      While Not qryAdiantamentos.EOF Do
      Begin
        If (qryAdiantamentos.FieldByName('TIPLAN').AsString = 'D') Then
        Begin
          If blnIgnorarEstornos Then
            Result := qryAdiantamentos.FieldByName('ESTORN').AsString <> 'S'
          Else
            Result := True;
        End;

        If Result Then
          Break;

        qryAdiantamentos.Next;
      End;
    End;

  Finally
    FreeAndNil(qryAdiantamentos);
  End;
end;

class function TAdiantamento.fAdiantamentoPodeSerEstornadoPeloFinanceiro(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String; fltValorAdiantamento: Double): Boolean;
  Var
    qryAdiantamentos: TUniQuery;
    fltSaldoFinal   : Double;
begin
  Try
    Result := False;

    qryAdiantamentos := fCriaQuery;

    If fCarregarAdiantamentos(strNumDoc, strEspDoc, strCodEmp, strCodCli, qryAdiantamentos) Then
    Begin
      qryAdiantamentos.Last;

      fltSaldoFinal := fFormataFloat(qryAdiantamentos.FieldByName('SALFIN').AsFloat, 2);

      Result := fltSaldoFinal >= fltValorAdiantamento;
    End;

  Finally
    FreeAndNil(qryAdiantamentos);
  End;
end;

class function TAdiantamento.fSelecionarPedido(documentos: TArrDocAdiantamento; objLock: TLock;
  objRotinaYapay: TRotinaYapay = nil; ARecebidoPorPix: Boolean = False): Boolean;
  Var
    strDocumento: String;
    documento: TDocAdiantamento;
begin
  Result := False;

  If Not fPermiteSelecionarPedido(documentos, ARecebidoPorPix) Then
    Exit;

  For documento In documentos Do
  Begin
    strDocumento := documento.strNumDoc + '-' + documento.strEspDoc;

    If documento.fltValAdt > 0 Then
    Begin
      If (documento.strCodFpg = '009') Or (documento.fltValAdt >= documento.fltVlrCon) Then
      Begin
        pMensagemOk('Pedido ' + strDocumento + ' já possui adiantamento(s) no valor total de (' +
          FormatFloat('#,##0.00', documento.fltValAdt) + '), portanto ' +
          'não é possível realizar um novo adiantamento!');
        Exit;
      End
      Else If Not fPergunta('Pedido ' + strDocumento + ' já possui um adiantamento no valor de (' +
                    FormatFloat('#,##0.00', documento.fltValAdt) + '), deseja realizar ' +
                    'um novo adiantamento para o valor restante?') Then
      Begin
        Exit;
      End;
    End;

    If Not objLock.fLock_Unlock( 'FATGOR' + documento.strNumDoc +
                                            documento.strEspDoc +
                                            documento.strCodEmp, True, False) and
      (not fVerificaLockAtivo('FATGOR' + documento.strNumDoc +
                                            documento.strEspDoc +
                                            documento.strCodEmp +
                                            STR_TRAVA_COLETOR)) Then
    Begin
      if (not Assigned(objRotinaYapay)) or (not objRotinaYapay.blnActive) then
      begin
        fMensagem('', 'Pedido ' + strDocumento + ' está sendo utilizado em Outra Estação por ' +
                      fGetHostLock('FATGOR' + documento.strNumDoc +
                                              documento.strEspDoc +
                                              documento.strCodEmp)  + '!', ['&Ok']);
      end;
      Exit;
    End;

  End;

  Result := True;
end;

class function TAdiantamento.fTrocaClienteAdiantamento(strNumDoc, strEspDoc,
  strCodEmp, strCodCliNov: String): Boolean;
var
  qryTroCli: TUniQuery;
begin
  qryTroCli := fCriaQuery;
  try
    try
      qryTroCli.Close;
      qryTroCli.SQL.Text :=
      ' UPDATE '+
      '   ADTCLI '+
      ' SET '+
      '   ADT_CODCLI = :CCLNOV '+
      '  ,ADT_DESCRI = :DESCRI '+
      ' WHERE '+
      '   ADT_CODCLI = :CODCLI AND '+
      '   ADT_NUMDOC = :NUMDOC AND '+
      '   ADT_ESPDOC = :ESPDOC AND '+
      '   ADT_CODEMP = :CODEMP ';

      qryTroCli.ParamByName('CCLNOV').AsString := strCodCliNov;
      qryTroCli.ParamByName('DESCRI').AsString := strCodCliNov + ' - ' + fRetNomCliente(strCodCliNov);

      qryTroCli.ParamByName('CODCLI').AsString := fRetornaInformacaoVenda(strNumDoc, strEspDoc, strCodEmp, 'CODCLI');
      qryTroCli.ParamByName('NUMDOC').AsString := strNumDoc;
      qryTroCli.ParamByName('ESPDOC').AsString := strEspDoc;
      qryTroCli.ParamByName('CODEMP').AsString := strCodEmp;
      qryTroCli.ExecSql;

      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryTroCli);
  end;
end;

{ TReciboAdiantamento }

constructor TReciboAdiantamento.Create(intSeqCon: Integer; strEmpLan: String; strOrigem: String);
begin
  FSeqCon   := intSeqCon;
  FEmpLan   := strEmpLan;
  FOrigem   := strOrigem;
  qryCfgRel := fCriaQuery;
  cdsChqVis := fCriaCdsCheques(nil);
  cdsChqPre := fCriaCdsCheques(nil);
  cdsImpRec := fCriaClientDatasetReciboCTR;
end;

destructor TReciboAdiantamento.Destroy;
begin
  If Assigned(qryCfgRel) Then FreeAndNil(qryCfgRel);
  If Assigned(cdsImpRec) Then FreeAndNil(cdsImpRec);
  If Assigned(cdsChqVis) Then FreeAndNil(cdsChqVis);
  If Assigned(cdsChqPre) Then FreeAndNil(cdsChqPre);
  inherited;
end;

procedure TReciboAdiantamento.pImprimirRecibo;
  Var
    strNomPro : String;
    strNomFil : String;
    strTipImp : String;
    intIndex  : Integer;
    strCaixa  : String;
    LFormaPagamento : String;
Begin
  If Not cdsImpRec.Active Then
    cdsImpRec.Open;

  cdsImpRec.EmptyDataSet;
  cdsChqVis.EmptyDataSet;
  cdsChqPre.EmptyDataSet;

  FArrAdiantamentos := TAdiantamento.fCarregarArrayAdiantamentos(FSeqCon, FEmpLan);

  strCaixa := '';
  If (FOrigem = 'RCX') And (fCfgSis('TPFCCX') = 'C') Then
  Begin
    strCaixa := fCampoTabela('RCX_CODCAX',
                             'CADRCXX',
                             ['RCX_SEQCON', 'RCX_CODEMP'],
                             [FSeqCon, FEmpLan]);
  End;

  For intIndex := Low(FArrAdiantamentos) To High(FArrAdiantamentos) Do
  With FArrAdiantamentos[intIndex] Do
  Begin
    cdsImpRec.Insert;
    cdsImpRec.FieldByName('CODCLI').AsString   := documentos[0].strCodCli;
    cdsImpRec.FieldByName('NOMCLI').AsString   := documentos[0].strNomCli;
    cdsImpRec.FieldByName('ENDERE').AsString   := documentos[0].strEndere;
    cdsImpRec.FieldByName('ENDNUM').AsString   := documentos[0].strEndNum;
    cdsImpRec.FieldByName('ENDCMP').AsString   := documentos[0].strEndCom;
    cdsImpRec.FieldByName('BAIRRO').AsString   := documentos[0].strBairro;
    cdsImpRec.FieldByName('C_E_P_').AsString   := documentos[0].strC_E_P_;
    cdsImpRec.FieldByName('CIDADE').AsString   := documentos[0].strNomCid;
    cdsImpRec.FieldByName('ESTADO').AsString   := documentos[0].strEstado;
    cdsImpRec.FieldByName('C_G_C_').AsString   := documentos[0].strC_G_C_;
    cdsImpRec.FieldByName('FONE01').AsString   := documentos[0].strFone01;
    cdsImpRec.FieldByName('DESCRI').AsString   := documentos[0].strCodCli + '-' + documentos[0].strNomCli;
    cdsImpRec.FieldByName('NUMDOC').AsString   := documentos[0].strNumDoc;
    cdsImpRec.FieldByName('PARCEL').AsString   := 'A';
    cdsImpRec.FieldByName('ESPDOC').AsString   := documentos[0].strEspDoc;
    cdsImpRec.FieldByName('CODEMP').AsString   := documentos[0].strCodEmp;
    cdsImpRec.FieldByName('DTACAD').AsDateTime := documentos[0].dtaDtaEnt;
    cdsImpRec.FieldByName('DTAVEN').AsDateTime := documentos[0].dtaDtaEnt;
    cdsImpRec.FieldByName('DTAREC').AsDateTime := dtaDtaLan;
    cdsImpRec.FieldByName('HORREC').AsDateTime := horHorLan;
    cdsImpRec.FieldByName('CODVEN').AsString   := documentos[0].strCodVen;
    cdsImpRec.FieldByName('SEQBAI').AsInteger  := 0;
    cdsImpRec.FieldByName('SEQCON').AsInteger  := intSeqCon;
    cdsImpRec.FieldByName('NOSNUM').AsString   := '';
    cdsImpRec.FieldByName('VALDOC').AsFloat    := IIF(strTipLan = 'C', fltValLan, -fltValLan);
    cdsImpRec.FieldByName('VALORI').AsFloat    := IIF(strTipLan = 'C', fltValLan, -fltValLan);
    cdsImpRec.FieldByName('VALJUR').AsFloat    := 0.0;
    cdsImpRec.FieldByName('VALDES').AsFloat    := 0.0;
    cdsImpRec.FieldByName('VALREC').AsFloat    := IIF(strTipLan = 'C', fltValLan, -fltValLan);
    If Not strCaixa.IsEmpty Then
      cdsImpRec.FieldByName('RCX_CAIXA').AsString:= 'CAIXA: ' + strCaixa;

    cdsImpRec.FieldByName('RECPIX').AsString   := 'N';
    If RecebidoPorPix Then
      cdsImpRec.FieldByName('RECPIX').AsString   := 'S';


    LFormaPagamento := '';

    if fltValDin <> 0 then
      LFormaPagamento := LFormaPagamento + 'Dinheiro: R$ ' + FormatFloat('#,##0.00', fltValDin) + sLineBreak;

    if fltValCar <> 0 then
      LFormaPagamento := LFormaPagamento + 'Cartao: R$ ' + FormatFloat('#,##0.00', fltValCar) + sLineBreak;

    if fltValChP <> 0 then
      LFormaPagamento := LFormaPagamento + 'Cheque Pre: R$ ' + FormatFloat('#,##0.00', fltValChP) + sLineBreak;

    if fltValChV <> 0 then
      LFormaPagamento := LFormaPagamento + 'Cheque Vista: R$ ' + FormatFloat('#,##0.00', fltValChV) + sLineBreak;

    if fltValOrd <> 0 then
      LFormaPagamento := LFormaPagamento + 'Ordem Pagto: R$ ' + FormatFloat('#,##0.00', fltValOrd) + sLineBreak;

    if fltValCre <> 0 then
      LFormaPagamento := LFormaPagamento + 'Credito: R$ ' + FormatFloat('#,##0.00', fltValCre) + sLineBreak;

    if RecebidoPorPix then
      LFormaPagamento := LFormaPagamento + 'PIX: R$ ' + FormatFloat('#,##0.00', fltValLan) + sLineBreak;

    if LFormaPagamento.EndsWith(sLineBreak) then
      Delete(LFormaPagamento,
         Length(LFormaPagamento) - Length(sLineBreak) + 1,
         Length(sLineBreak));

    cdsImpRec.FieldByName('DESFPG').AsString := uppercase(LFormaPagamento);

    cdsImpRec.Post;

    If Length(arrCodCli) = 0 Then
    Begin
      SetLength(arrCodCli, 1);
      arrCodCli[0].strCodCli := documentos[0].strCodCli;
      arrCodCli[0].strNomCli := documentos[0].strCodCli + '-' + documentos[0].strNomCli;
      arrCodCli[0].strCepCli := documentos[0].strC_E_P_;
      arrCodCli[0].strCidCli := documentos[0].strNomCid + '-'  + documentos[0].strEstado;
      arrCodCli[0].strEndCli := documentos[0].strEndere + ', ' + documentos[0].strEndNum + ' - ' + documentos[0].strBairro;
    End;

    FOpeLan := strOpeLan;

    {Lanca o credito juntamente com dinheiro (contas a receber nao tem campo proprio para creditos)}
    recValRec.strDinRec := FloatToStr(fStrToFloat(recValRec.strDinRec) + fltValDin * IIF(strTipLan = 'C', 1, -1));
    recValRec.strDinRec := FloatToStr(fStrToFloat(recValRec.strDinRec) + fltValCre * IIF(strTipLan = 'C', 1, -1));
    recValRec.strCreRec := FloatToStr(fStrToFloat(recValRec.strCreRec) + fltValCre * -1);
    recValRec.strCarRec := FloatToStr(fStrToFloat(recValRec.strCarRec) + fltValCar * IIF(strTipLan = 'C', 1, -1));
    recValRec.strChqPre := FloatToStr(fStrToFloat(recValRec.strChqPre) + fltValChP * IIF(strTipLan = 'C', 1, -1));
    recValRec.strChqVis := FloatToStr(fStrToFloat(recValRec.strChqVis) + fltValChV * IIF(strTipLan = 'C', 1, -1));
    recValRec.strOrdRec := FloatToStr(fStrToFloat(recValRec.strOrdRec) + fltValOrd * IIF(strTipLan = 'C', 1, -1));

    arrCodCli[0].fltValRec := arrCodCli[0].fltValRec + fltValLan * IIF(strTipLan = 'C', 1, -1);
  End;

  If Length(FArrAdiantamentos) > 0 Then
  Begin
    pCarregarDuplicatas;
    pCarregarCheques;

    pCarregaConfImpr(qryCfgRel, 'frmSelPedidoAdiantamento');
    If qryCfgRel.IsEmpty Then
      pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixa');

    fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

    strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;

    If fEmptyStr(strNomPro) Then
      strNomPro := 'frmRcxResumoCaixa';

    blnCalculaTotais := False;


    if TFrmCtrReciboAdiantamento.fImprimeReciboLayout(cdsImpRec,
                                                      arrCodCli,
                                                      cdsChqPre,
                                                      cdsChqVis,
                                                      strNomFil,
                                                      strTipImp,
                                                      False) = False then
      pImpRecBaiDoc(cdsImpRec,
                  fCfgSis('RECRCX'),
                  FSeqCon,
                  FOpeLan,
                  arrCodCli,
                  recValRec,
                  cdsChqPre,
                  cdsChqVis,
                  strNomPro,
                  strNomFil,
                  strTipImp,
                  False,
                  '',
                  '');
  End;

End;

procedure TReciboAdiantamento.pCarregarDuplicatas;
  Const
    CAMPOS_CADREC: String = 'CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, ' +
                            'CTR_DTACAD, CTR_DTAVEN, CTR_DTAREC, CTR_CODVEN, ' +
                            'CTR_SEQBAI, CTR_SEQCON, CTR_NOSNUM, CTR_VALREC, ' +
                            'CTR_VALJUR, CTR_VALCOB, CTR_VALDES, CTR_VALORI, ' +
                            'CTR_VALDES, CTR_VALREC, CTR_DINHEI, CTR_CHQAVI, ' +
                            'CTR_CHQPRE, CTR_CARTAO, CTR_ORDPAG  ';
  Var
    qryDup: TUniQuery;
Begin
  qryDup := fCriaQuery;

  With qryDup, SQL, FArrAdiantamentos[0], documentos[0] Do
  Begin
    Close;
    Clear;

    Add('SELECT SQL_NO_CACHE ');
    Add('  ' + CAMPOS_CADREC);
    Add('FROM ');
    Add('  CADREC ');
    Add('WHERE    ');
    Add('  CTR_SEQCON = :SEQCON AND ');
    Add('  CTR_EMPBAI = :EMPBAI     ');
    Add('ORDER BY ');
    Add('  CTR_NUMDUP, CTR_ESPDOC, CTR_CODEMP, CTR_PARCEL, CTR_SEQBAI ');

    ParamByName('SEQCON').AsInteger := FSeqCon;
    ParamByName('EMPBAI').AsString  := FEmpLan;

    Open;

    First;
    While Not Eof Do
    Begin
      cdsImpRec.Insert;
      cdsImpRec.FieldByName('CODCLI').AsString   := strCodCli;
      cdsImpRec.FieldByName('NOMCLI').AsString   := strNomCli;
      cdsImpRec.FieldByName('ENDERE').AsString   := strEndere;
      cdsImpRec.FieldByName('ENDNUM').AsString   := strEndNum;
      cdsImpRec.FieldByName('ENDCMP').AsString   := strEndCom;
      cdsImpRec.FieldByName('BAIRRO').AsString   := strBairro;
      cdsImpRec.FieldByName('C_E_P_').AsString   := strC_E_P_;
      cdsImpRec.FieldByName('CIDADE').AsString   := strNomCid;
      cdsImpRec.FieldByName('ESTADO').AsString   := strEstado;
      cdsImpRec.FieldByName('C_G_C_').AsString   := strC_G_C_;
      cdsImpRec.FieldByName('FONE01').AsString   := strFone01;
      cdsImpRec.FieldByName('DESCRI').AsString   := strCodCli + '-' + strNomCli;

      cdsImpRec.FieldByName('NUMDOC').AsString   := FieldByName('CTR_NUMDUP').AsString;
      cdsImpRec.FieldByName('PARCEL').AsString   := FieldByName('CTR_PARCEL').AsString;
      cdsImpRec.FieldByName('ESPDOC').AsString   := FieldByName('CTR_ESPDOC').AsString;
      cdsImpRec.FieldByName('CODEMP').AsString   := FieldByName('CTR_CODEMP').AsString;
      cdsImpRec.FieldByName('DTACAD').AsDateTime := FieldByName('CTR_DTACAD').AsDateTime;
      cdsImpRec.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
      cdsImpRec.FieldByName('DTAREC').AsDateTime := FieldByName('CTR_DTAREC').AsDateTime;
      cdsImpRec.FieldByName('HORREC').AsDateTime := horHorLan;
      cdsImpRec.FieldByName('CODVEN').AsString   := FieldByName('CTR_CODVEN').AsString;
      cdsImpRec.FieldByName('SEQBAI').AsInteger  := FieldByName('CTR_SEQBAI').AsInteger;
      cdsImpRec.FieldByName('SEQCON').AsInteger  := FieldByName('CTR_SEQCON').AsInteger;
      cdsImpRec.FieldByName('NOSNUM').AsString   := FieldByName('CTR_NOSNUM').AsString;

      cdsImpRec.FieldByName('VALDOC').AsFloat    := FieldByName('CTR_VALREC').AsFloat -
                                                    FieldByName('CTR_VALJUR').AsFloat -
                                                    FieldByName('CTR_VALCOB').AsFloat +
                                                    FieldByName('CTR_VALDES').AsFloat;

      cdsImpRec.FieldByName('VALORI').AsFloat    := FieldByName('CTR_VALORI').AsFloat;
      cdsImpRec.FieldByName('VALJUR').AsFloat    := FieldByName('CTR_VALJUR').AsFloat;
      cdsImpRec.FieldByName('VALDES').AsFloat    := FieldByName('CTR_VALDES').AsFloat;
      cdsImpRec.FieldByName('VALREC').AsFloat    := FieldByName('CTR_VALREC').AsFloat;
      cdsImpRec.Post;

      If FieldByName('CTR_VALREC').AsFloat > 0 Then
      Begin
        {O Valor dos creditos esta junto com o valor em dinheiro ( no contas a receber nao tem campo proprio)}
        recValRec.strDinRec := FloatToStr(fStrToFloat(recValRec.strDinRec) + FieldByName('CTR_DINHEI').AsFloat);
        recValRec.strCarRec := FloatToStr(fStrToFloat(recValRec.strCarRec) + FieldByName('CTR_CARTAO').AsFloat);
        recValRec.strChqPre := FloatToStr(fStrToFloat(recValRec.strChqPre) + FieldByName('CTR_CHQPRE').AsFloat);
        recValRec.strChqVis := FloatToStr(fStrToFloat(recValRec.strChqVis) + FieldByName('CTR_CHQAVI').AsFloat);
        recValRec.strOrdRec := FloatToStr(fStrToFloat(recValRec.strOrdRec) + FieldByName('CTR_ORDPAG').AsFloat);
      End
      Else
      Begin
        {Deduz o valor dos creditos da modalidade dinheiro, restanto somente o que realmente foi dinheiro}
        recValRec.strDinRec := FloatToStr(fStrToFloat(recValRec.strDinRec) - Abs(FieldByName('CTR_VALREC').AsFloat));
      End;

      arrCodCli[0].fltValRec := arrCodCli[0].fltValRec + FieldByName('CTR_VALREC').AsFloat;

      Next;
    End;
  End;
  FreeAndNil(qryDup);
end;

procedure TReciboAdiantamento.pCarregarCheques;
  Var
    qryCadChq: TUniQuery;

  procedure pAddCheque(Var cdsCheque: TUniClientDataSet);
    Var
      field: TField;
  begin
    cdsCheque.Append;

    For field In cdsCheque.Fields Do
    Begin
      If qryCadChq.FindField(field.FieldName) <> nil Then
        field.Value := qryCadChq.FindField(field.FieldName).Value;
    End;

    cdsCheque.Post;
  end;

Begin
  qryCadChq := fCriaQuery;

  With qryCadChq, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT * FROM CADCHQ ');
    Add('WHERE CHQ_SEQCON = :SEQCON AND ');
    Add('      CHQ_CODEMP = :CODEMP ');

    ParamByName('SEQCON').AsInteger := FSeqCon;
    ParamByName('CODEMP').AsString  := FEmpLan;

    Open;

    First;
    While Not Eof Do
    Begin
      If FieldByName('CHQ_DTACAD').AsDateTime =
         FieldByName('CHQ_DTAVEN').AsDateTime Then
      Begin
        pAddCheque(cdsChqVis);
      End
      Else
        pAddCheque(cdsChqPre);
      Next;
    End;
  End;

  FreeAndNil(qryCadChq);
end;

function TAdiantamento.fGravaMovimentoBancario: Boolean;
Var
  strSeqLanCre : String;
  fltValLan    : Double;
  lstBanCtr    : TBanCtrRepository;
  dtaDtaLan: TDate;
  horHorLan: TTime;

  LEmpresa: String;
begin
  fltValLan := FInfAdiantamento.fltValLan +
               FInfAdiantamento.fltCreGer -
               FInfAdiantamento.fltValCre;

  // Se usou créditos o valor pode estar zerado.
  // Nesse caso não lança na MOVBAN.
  If fltValLan <= 0 Then
  Begin
    Result := True;
    Exit;
  End;

  pInformacaoGravacao('Aguarde, Gravando Movimento Bancário...');

  lstBanCtr := TBanCtrRepository.Create;

  dtaDtaLan := FInfAdiantamento.dtaDtaLan;
  horHorLan := fTime();
  if objRotinaYapay.blnActive then
  begin
    dtaDtaLan := TDate(objRotinaYapay.BaixaSintetica.dtalancamento);
    horHorLan := TTime(objRotinaYapay.BaixaSintetica.dtalancamento);
    fltValLan := fltValLan - objRotinaYapay.Cartao.fltValorTaxa;
  end;

  LEmpresa := VS_strCodEmp;
  If Assigned(FRegistroPix) Then
  Begin
    LEmpresa := FRegistroPix.CodigoEmpresa;

    If MatchStr(FRegistroPix.Status, STATUS_PIX_PAGO) Then
    Begin
      If fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [FInfAdiantamento.strCodPor]) = 'S' Then
        dtaDtaLan := fAcertaDataParaDiaUtil(FInfAdiantamento.dtaDtaLan);
    End;
  End;

  FInfAdiantamento.dtaDtaBan := dtaDtaLan;

  lstBanCtr.fAdd(FInfAdiantamento.documentos[0].strNumDoc,
                 'A',
                 FInfAdiantamento.documentos[0].strEspdoc,
                 FInfAdiantamento.documentos[0].strCodEmp,
                 FInfAdiantamento.documentos[0].strCodCli,
                 FInfAdiantamento.strDescri,
                 '',
                 FInfAdiantamento.intSeqCon,
                 fltValLan);

  strSeqLanCre := fGravaMovBan(FInfAdiantamento.strCodCta,           // Centro de Custo
                               FInfAdiantamento.strCodPor,           // Portador
                               strLoginUsuarioLogado,                // Operador
                               dtaDtaLan,                            // Data do Lançamento
                               horHorLan,                            // Hora do Lançamento
                               FInfAdiantamento.documentos[0].strNumDoc, // Documento
                               'C',                                  // Credito / Debito
                               LEmpresa,                         // Empresa
                               fltValLan,                            // Valor Documento
                               FInfAdiantamento.strDescri,           // Historico 1
                               '',                                   // Historico 2
                               FInfAdiantamento.documentos[0].strCodCli, // Cliente
                               '',                                   // Fornecedor
                               '',                                   // Numero da Duplicata
                               FInfAdiantamento.intSeqCon,           // Sequencial Duplicata
                               '',                                   // Parcela da Duplicata
                               '',                                   // Empresa da Duplicata
                               '',                                   // Série
                               //'',                                 // Sequencial de Lançamento
                               '',                                   // Código do Evento
                               '',                                   // Documento da Baixa
                               lstBanCtr.fGetList);                  // Log Bancário

  FInfAdiantamento.strSeqBan := strSeqLanCre;

  Result := (Not fEmptyStr(strSeqLanCre));

  FreeAndNil(lstBanCtr);

  If Assigned(FRegistroPix) Then
    FRegistroPix.MovbanBaixa := strSeqLanCre;
end;

class function TAdiantamento.fRealizarAdiantamentoClienteYapay(
  const pObjParametro: TParametroRealizarAdiantamentoClienteYapay): Boolean;
Var
  objAdiantamento: TAdiantamento;
  blnSelecionouDocumento: Boolean;
  objQryCartao: TUniQuery;
begin
  objAdiantamento := TAdiantamento.Create('', strLoginUsuarioLogado, '');
  Try
    objAdiantamento.objRotinaYapay.blnActive := True;
    objAdiantamento.objRotinaYapay.BaixaSintetica.strCodigoPortador := fCfgSis('YAPPOR');
    objAdiantamento.objRotinaYapay.BaixaSintetica.strPlanoContas := fCfgSis('YAPPLC');
    objAdiantamento.objRotinaYapay.BaixaSintetica.dtaLancamento := pObjParametro.Transacao.Created_at;

    objAdiantamento.objRotinaYapay.BaixaSintetica.strNumeroDocumento :=
      pObjParametro.strNumDoc +
      pObjParametro.strEspDoc +
      pObjParametro.strCodEmp;

    objAdiantamento.objRotinaYapay.BaixaSintetica.strHistorico :=
      'YAPAY COBRANÇA ID: ' + pObjParametro.ConsultaCobranca.TabelaParametros.Id.ToString +
      ' TRANSAÇÃO ID: ' + pObjParametro.Transacao.Id.ToString;

    objAdiantamento.objRotinaYapay.Cartao.strCodigoCartao := fCfgSis('YAPCAR');
    objAdiantamento.objRotinaYapay.Cartao.intQuantidadeParcelas := pObjParametro.intQuantidadeParcelas;
    objAdiantamento.objRotinaYapay.Cartao.dtaDataCadastro := pObjParametro.Transacao.Created_at;
    objQryCartao := fCriaQuery;
    try
      objQryCartao.SQL.Text :=
        'SELECT CAR_DESCAR,' + sLineBreak +
        '       CAR_TIPTAX,' + sLineBreak +
        '       CAR_PERDES,' + sLineBreak +
        '       CAR_PERIOD,' + sLineBreak +
        '       CAR_EXCDIA' + sLineBreak +
        '  FROM CADCAR' + sLineBreak +
        ' WHERE CAR_CODCAR = :CODCAR';
      objQryCartao.ParamByName('CODCAR').AsString :=
        objAdiantamento.objRotinaYapay.Cartao.strCodigoCartao;

      objQryCartao.Open;

      objAdiantamento.objRotinaYapay.Cartao.strDescricaoCartao :=
        objQryCartao.FieldByName('CAR_DESCAR').AsString;

      objAdiantamento.objRotinaYapay.Cartao.fltValorTaxa := pObjParametro.fltValorTaxa;

      objAdiantamento.objRotinaYapay.Cartao.fltValorOriginal := pObjParametro.fltValorOriginal;
      objAdiantamento.objRotinaYapay.Cartao.fltValorPago := pObjParametro.fltValorPago;

      objAdiantamento.objRotinaYapay.Cartao.intPrazo := pObjParametro.intPrazo;

      objAdiantamento.objRotinaYapay.Cartao.intDiasExcedentePrimeiraParcela := 0;

      objQryCartao.Close;
    finally
      if Assigned(objQryCartao) then
        FreeAndNil(objQryCartao);
    end;

    objAdiantamento.objRotinaYapay.Cartao.strObservacao :=
      objAdiantamento.objRotinaYapay.BaixaSintetica.strHistorico;

    objAdiantamento.objRotinaYapay.Cartao.strNumCCD := pObjParametro.Transacao.Id.ToString;

    objAdiantamento.objRotinaYapay.Cartao.strNumNSU := pObjParametro.strOrderNumber;

    objAdiantamento.objRotinaYapay.Cartao.strFormaCartao := 'POS';

    blnSelecionouDocumento :=
      objAdiantamento.fSelecionarDocumento(pObjParametro.strNumDoc,
                                           pObjParametro.strEspDoc,
                                           pObjParametro.strCodEmp,
                                           'CTR',
                                           False);

    If Not blnSelecionouDocumento Then
      Exit(False);

    Result := objAdiantamento.fRealizarAdiantamento(nil);
  Finally
    FreeAndNil(objAdiantamento);
  End;

end;

procedure TAdiantamento.pCancelarVendaConfirmadaTefCitel;
var
  intContCartao : Integer;
begin
  for intContCartao := 0 to  Length(arrCartoes) - 1 do
  begin
    if fVerificaUtilizouTEFCitel(arrCartoes[intContCartao].strViaCli, arrCartoes[intContCartao].strViaLoj) then
    begin
      if arrCartoes[intContCartao].strStatusCartao = 'P' then
      begin
        try
          pEstornaTransacaoPendente(False,
                                    arrCartoes[intContCartao].strDtaTra,
                                    arrCartoes[intContCartao].strHraTra,
                                    arrCartoes[intContCartao].strNumDoc,
                                    '');

          blnEstornouTransacaoPendente := True;
        finally
          arrCartoes[intContCartao].strStatusCartao := 'C';

          pGravaTransacaoEstornada(arrCartoes[intContCartao].strNumDoc,
                                   arrCartoes[intContCartao].strNumNsu,
                                   arrCartoes[intContCartao].strDtaTra,
                                   arrCartoes[intContCartao].strHraTra,
                                   '',
                                   '',
                                   arrCartoes[intContCartao].fltValDig,
                                   arrCartoes[intContCartao].strControle);
        end;
      end
      else if fAutoConfirmaTransacaoPendenteEstaAtivada and
        (arrCartoes[intContCartao].strStatusCartao = 'FC') then
      begin
        if fCancelaTransacaoEfetivada(
          fAjustaIdentificadorEstornoTef(arrCartoes[intContCartao]),
          arrCartoes[intContCartao].fltValDig,
          arrCartoes[intContCartao].strDtaTra,
          arrCartoes[intContCartao].strCodigoCarteiraDigital,
          arrCartoes[intContCartao].strCodigoTipoOperacaoCartao,
          arrCartoes[intContCartao].strCodigoBandeira) then
        begin
          arrCartoes[intContCartao].strStatusCartao := 'C';
        end;
        blnEstornouTransacaoPendente := True;
      end;
    end;
  end;
end;

class procedure TAdiantamento.pAtualizaDataLanctoAdiantamento(const intSeqConAdiant: Integer; const strCodEmp : String; const dtDataMovBancaria : TDatetime; const strSeqBan : String; const blnApenasOrdemPagto : Boolean = False);
var
  qryUpdDtMov: TUniQuery;
begin
  qryUpdDtMov := fCriaQuery;
  try
    qryUpdDtMov.Close;
    qryUpdDtMov.SQL.Add(' UPDATE ADTCLI ');
    qryUpdDtMov.SQL.Add('    SET ADT_DTABAN = :DTAMOV ');
    If (Not fEmptyStr(strSeqBan)) Then
    Begin
      qryUpdDtMov.SQL.Add('     ,ADT_SEQBAN = :SEQBAN ');
      qryUpdDtMov.ParamByName('SEQBAN').AsString := strSeqBan;
    End;
    qryUpdDtMov.SQL.Add('  WHERE ADT_SEQCON = :SEQCON ');
    qryUpdDtMov.SQL.Add('    AND ADT_CODEMP = :CODEMP ');

    If (blnApenasOrdemPagto) Then
      qryUpdDtMov.SQL.Add(' AND ADT_VALORD > 0 ');

    qryUpdDtMov.ParamByName('DTAMOV').AsDatetime := dtDataMovBancaria;
    qryUpdDtMov.ParamByName('SEQCON').AsInteger  := intSeqConAdiant;
    qryUpdDtMov.ParamByName('CODEMP').AsString   := strCodEmp;
    qryUpdDtMov.ExecSql;
  finally
    FreeAndNil(qryUpdDtMov);
  end;
end;

class procedure TAdiantamento.pAtualizaVinculoComCredito(const strNumDoc, strEspDoc, strCodEmp, strCTR_CC : String);
  Var
    qryAdtCli : TUniQuery;
begin
  qryAdtCli := fCriaQuery;
  Try
    qryAdtCli.Close;
    qryAdtCli.SQL.Clear;
    qryAdtCli.SQL.Add(' UPDATE ADTCLI ');
    qryAdtCli.SQL.Add('    SET ADT_CTR_CC = :CTR_CC ');
    qryAdtCli.SQL.Add('  WHERE ADT_NUMDOC = :NUMDOC ');
    qryAdtCli.SQL.Add('    AND ADT_ESPDOC = :ESPDOC ');
    qryAdtCli.SQL.Add('    AND ADT_CODEMP = :CODEMP ');
    qryAdtCli.SQL.Add('    AND ADT_TIPLAN = "C" ');
    qryAdtCli.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAdtCli.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAdtCli.ParamByName('CODEMP').AsString := strCodEmp;
    qryAdtCli.ParamByName('CTR_CC').AsString := strCTR_CC;
    qryAdtCli.ExecSQL;
  Finally
    FreeAndNil(qryAdtCli);
  End;
end;

end.

