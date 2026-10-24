unit untFormaPagtoNegociada;

interface

uses
  Classes, UniClientDataSet, Forms, StrUtils, DB, SysUtils, Uni, Variants, Math,
  untFuncFatTypes;

type
  TStatusNegociacao = (snNegociandoFormas, snRealizandoRecebimentoF11, snRealizandoAdiantamento);

  TfReceberFormaPagamento = function(strCodFpg: String; fltValor: Double;
                                     strCodCar: String; intQtdPar: Integer): Boolean of Object;

  TpAbrirGaveta = procedure(strConPag: String) of Object;

  TDadosCartao = record
    strCodigo: String;
    strDescricao: String;
    strStatus: String;
    strEmpresa: String;
    strTipoCartao: String;
    intMaxParcelas: Integer;
    intQtdParcelas: Integer;
    function fPesquisaCartao(frmSelf: TForm; chrKey: Char; intQtdPar: Integer): Boolean;
    procedure pCarregaDadosCartao(const strCodCar: String);
  end;

  TFormaPagto = record
    strCodigo: String;
    strDescricao: string;
    fltValor: Double;
    fltValorAntecipadoCadRec: Double;
    strCondPagamento: String;
    dadosCartao: TDadosCartao;
    dtaDataChqPre: TDateTime;
    function strDescricaoCompleta: String;
  end;

  TArrFormasPagto = Array Of TFormaPagto;

  TFormaPagtoNegociada = class
    private
      FCodCli: String;
      FOpcDoc: String;
      FCodFpg: String;
      FCodCnd: String;
      FConPag: String;
      FTotVen: Double;
      FEnt_CD: Boolean;
      FStatus: TStatusNegociacao;
      FTemRecAnt: Boolean;

      FCodOpe: String;

      FCdsFpgBkp : TUniClientDataSet;
      FCdsFpgSel : TUniClientDataSet;
      FArrFormas : TArrFormasPagto;
      FRecForPag : TfReceberFormaPagamento;
      FAbreGaveta: TpAbrirGaveta;

      FTotCred: Double;
      FDupCred: TStringList;
      FLckDup: TStringList;

      FRecAdtPed: Boolean;

      FstrNumeroDocumentoNegociado,
      FstrEspecieDocumentoNegociado,
      FstrEmpresaDocumentoNegociado : String;
      FblnUsaEmpOri : Boolean;

      procedure pMontaArrayFormasPagto(blnDescontaCreditoAutomatico: Boolean = False);
      procedure pCriaClientDataSetFormas;

      procedure pZerarValoresModalidades;

      function GetValorTroco: Double;
      function GetTotalFormasSel: Double;
      function GetValorRestante: Double;
      function GetValorRestanteReceber: Double;
      function GetValorRecebido: Double;
      function GetCreditosCliente: Double;

//      function fFormaPagtoPermitidaComCreditos(var formaPagtoSel: TFormaPagto): Boolean;

    public
      constructor Create;
      destructor Destroy; override;

      procedure pLimparFormasNegociadas;
      procedure pSalvarBackupNegociacao;
      procedure pRestaurarBackupNegociacao;

      procedure pRemoverFormaPagto(blnPergunta: Boolean = True);
      procedure pSelecionarFormaPagto(formPagto: TFormaPagto);

      function fTemFormaPagtoAVistaSelecionada: Boolean;
      function fTemFormaPagtoAPrazoSelecionada: Boolean;

      function fTemFormaPagtoComRecebimento: Boolean;
      function fTemFormaPagtoJaRecebidaParc: Boolean;

      function fTemFormaPagtoNaoPermitidaComAReceber(Var strDesFpg: String): Boolean;

      function fCartaoJaInformado(strCodCar: String): Boolean;
      function fTipoDeCartaoJaInformado(strTipCar: String): Boolean;
      function fGetQuantidadeCartoesNegociados: Integer;

      function fFormaPagtoSelecionada(strCodFpg: String): Boolean; overload;
      function fFormaPagtoSelecionada(const AintAutoInc: Integer): Boolean; overload;
      function fGetFormasPagtoSelecionadas: String;
      function fValorFormaPagtoSelecionada(strCodFpg: String): Double;
      function fBuscaDuplicatasSelecionadas: String;
      function fPedeFormasPagamento(strOpcDoc, strCodCli, strCodFpg, strCodCnd, strConPag: String;
                                    blnEnt_CD, blnTemRecAnt: Boolean; fltTotVen: Double; blnMostrarTela: Boolean;
                                    blnDescontaCreditoAutomatico: Boolean = False; blnUsaEmpOri: Boolean = False): Boolean;

      function fRecebimentoFormasPagtoNegociadasF11(fltTotVen: Double;
        fFuncaoReceber: TfReceberFormaPagamento; pProcAbrirGaveta: TpAbrirGaveta): Boolean;

      function fRecebimentoFormasPagtoNegociadasAdiantamento(fltTotVen: Double;
        fFuncaoReceber: TfReceberFormaPagamento): Boolean;

      function fRecebimentoCompleto(blnMsg: Boolean = True): Boolean;
      function fSelecionarCreditos(blnDescontaCreditoAutomatico: Boolean = False; blnUsaEmpOri: Boolean = False): Boolean;

      procedure pRealizarRecebimento;

      procedure pAcertarValorModalidadesNovoPedidoF11(modalidades: TDadosModalidades; strConPag: String);
      procedure pAdicionarModalidadesNovoPedidoF11(strCodFpg, strConPag: String; fltValor: Double);
      procedure pAcertaValorComTrocoModalidadesNovoPedidoF11(var modalidades: TDadosModalidades);

      procedure pAcertarValorModalidadesDesmembramento(fltTotGer: Double);

      function fSalvarFormasPagtoNegociadas(strAutIncFatGor: String): Boolean;
      function fSalvarFormasPagtoNegociadasDesmembramento(strAutIncFatGor: String; fltTotGer: Double): Boolean;
      function fSalvarFormasPagtoNegociadasNovoPedidoF11(modalidades: TDadosModalidades; strConPag, strAutIncFatGor: String): Boolean;

      procedure pCarregarFormasPagtoNegociadas(strAutIncPed: String);
      function fVerificaAutoincremVazio(AIncPed: String): String;

      function fMaxParcCartaoCondicaoPagto: Integer;

      function fValidaFormaPagto(var formaPagtoSel: TFormaPagto): Boolean;
      function fValidaValorFormaPagto(var formaPagtoSel: TFormaPagto; blnUtilizaCreditoOutrasFormasPagamento: Boolean = False): Boolean;
      function fValidaCodigoCartao(var formaPagtoSel: TFormaPagto): Boolean;
      function fValidaQuantidadeParcelasCartao(var formaPagtoSel: TFormaPagto): Boolean;
      function fValidaCondicaoPagamento(var formaPagtoSel: TFormaPagto): Boolean;
      function fCodChqPre: String;

      function fConfirmarFormasPagamento(blnMsg: Boolean = True): Boolean;

      {******************}
      {* DADOS DA VENDA *}
      {***************JC*}
      property fltTotalVenda: Double Read FTotVen Write FTotVen;

      property fltTotalFormasPagto: Double Read GetTotalFormasSel;
      property fltValorRestante: Double Read GetValorRestante;

      property fltValorRecebido: Double Read GetValorRecebido;
      property fltValorRestanteReceber: Double Read GetValorRestanteReceber;
      property fltValorTroco: Double Read GetValorTroco;

      property blnTemRecebimentoAnterior: Boolean Read FTemRecAnt Write FTemRecAnt;

      property strCodOperador: String Read FCodOpe Write FCodOpe;

      property strOpcaoVenda: String Read FOpcDoc Write FOpcDoc;
      property strCodCliente: String Read FCodCli Write FCodCli;
      property strCodFormaPagto: String Read FCodFpg Write FCodFpg;
      property strCodCondPagto: String Read FCodCnd Write FCodCnd;
      property strCondicaoPagto: String Read FConPag Write FConPag;
      property blnEntregaPeloCD: Boolean Read FEnt_CD Write FEnt_CD;
      property fltCreditosCliente: Double Read GetCreditosCliente;

      property stlDupCreditos: TStringList Read FDupCred;
      property stlLckDup: TStringList read FLckDup;
      property fltTotCreditos: Double Read FTotCred;

      property cdsFormasNegociadas: TUniClientDataSet Read FCdsFpgSel;
      property arrFormasPagamento: TArrFormasPagto Read FArrFormas;

      property blnAdiantamentoPedido: Boolean Read FRecAdtPed Write FRecAdtPed;

      property StatusNegociacao: TStatusNegociacao read FStatus;
      property fReceberFormaPagamento: TfReceberFormaPagamento Read FRecForPag;

      property pAbrirGaveta: TpAbrirGaveta Read FAbreGaveta;

      property strNumeroDocumentoNegociado  : String read FstrNumeroDocumentoNegociado  write FstrNumeroDocumentoNegociado;
      property strEspecieDocumentoNegociado : String read FstrEspecieDocumentoNegociado write FstrEspecieDocumentoNegociado;
      property strEmpresaDocumentoNegociado : String read FstrEmpresaDocumentoNegociado write FstrEmpresaDocumentoNegociado;
  end;

  TUnificarCartoesNegociados = class
    private
      FNegociacao: TFormaPagtoNegociada;
      FCartoes   : TUniClientDataSet;

      function fTemCartaoRecebido(var strCarRec: String): Boolean;
      function fGetCartaoPrincipal: Integer;
      function fGetQtdMarcados: Integer;

    public
      constructor Create(objNegociacao: TFormaPagtoNegociada);
      Destructor Destroy; override;

      function fUnificarCartoesNegociados: Boolean;

      property cdsCartoes: TUniClientDataSet Read FCartoes;
  end;


implementation

{ TDadosCartao }

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncoes, untPesqAux,
  untFatFormaPagtoNegociada, untConstantes, untCadRcxx, untObservacao,
  untAgrupDuplicatas, untFuncoesCaixa, untFuncFat, untAdiantamentoCliente;

function TDadosCartao.fPesquisaCartao(frmSelf: TForm; chrKey: Char; intQtdPar: Integer): Boolean;
  Var
    arrCartao: TConsultasArray;
    qryCartao: TUniQuery;
begin
  inherited;
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    qryCartao := fCriaQuery;

    If fPesqCartao(frmSelf, nil, nil, qryCartao, chrKey, arrCartao,
                   True, True, False, False, False) Then
    Begin
      pCarregaDadosCartao(qryCartao.FieldByName('CAR_CODCAR').AsString);
      Result := True;
    End;

    FreeAndNil(qryCartao);
  End;
end;

procedure TDadosCartao.pCarregaDadosCartao(const strCodCar: String);
  Var
    qryCartao: TUniQuery;
begin
  qryCartao := fCriaQuery;
  pPesquisaCadCar(qryCartao, qryCartao, strCodCar);

  strCodigo      := qryCartao.FieldByName('CAR_CODCAR').AsString;
  strDescricao   := qryCartao.FieldByName('CAR_DESCAR').AsString;
  strStatus      := qryCartao.FieldByName('CAR_STATUS').AsString;
  strEmpresa     := qryCartao.FieldByName('CAR_CODEMP').AsString;
  intQtdParcelas := qryCartao.FieldByName('CAR_SUGPAR').AsInteger;
  intMaxParcelas := qryCartao.FieldByName('CAR_MAXPAR').AsInteger;
  strTipoCartao  := qryCartao.FieldByName('CAR_TIPCAR').AsString;

  FreeAndNil(qryCartao);
end;

{ TFormaPagto }

function TFormaPagto.strDescricaoCompleta: String;
  Var
    strDias: String;
begin
  Result := strDescricao;

  If Not fEmptyStr(dadosCartao.strCodigo) Then
  Begin
    If dadosCartao.strTipoCartao = 'D' Then
      Result := Result + ' DE DÉBITO'

    Else If dadosCartao.strTipoCartao = 'C' Then
      Result := Result + ' DE CRÉDITO';

    If (dadosCartao.strTipoCartao <> 'D') Or (dadosCartao.intQtdParcelas > 1) Then
      Result := Result + ' em ' + intToStr(dadosCartao.intQtdParcelas) + 'X';

    Result := Result + ' (' + dadosCartao.strCodigo + ' - ' + dadosCartao.strDescricao + ')';
  End
  Else If strCondPagamento <> '01000' Then
  Begin
    strDias := fTransform(Copy(strCondPagamento, 3, Length(strCondPagamento) -2), 3, ', ');

    Result := Result + ' em ' + LeftStr(strCondPagamento, 2) + 'X';
    Result := Result + ' ('   + LeftStr(strDias, Length(strDias) -2) + ' dias)';
  End
  Else If (strCondPagamento = '01000') And (strCodigo = '002') And (dtaDataChqPre > 0) Then
  Begin
    Result := Result + ' (para ' + FormatDateTime('dd/mm/yyyy', dtaDataChqPre) + ')';
  End;
end;

{ TFormaPagtoNegociada }

constructor TFormaPagtoNegociada.Create;
begin
  FTotCred    := 0;
  FDupCred    := TStringList.Create;
  FDupCred.Duplicates := dupIgnore;

  FRecAdtPed  := False;

  FLckDup     := TStringList.Create;
  FCodOpe     := strLoginUsuarioLogado;
  FStatus     := snNegociandoFormas;
  FblnUsaEmpOri := False;

  SetLength(FArrFormas, 0);
  pCriaClientDataSetFormas;
end;

destructor TFormaPagtoNegociada.Destroy;
begin
  FreeAndNil(FDupCred);
  FreeAndNil(FLckDup);
  FreeAndNil(FCdsFpgSel);
  FreeAndNil(FCdsFpgBkp);
  SetLength(FArrFormas, 0);
  inherited;
end;

function TFormaPagtoNegociada.fFormaPagtoSelecionada(
  strCodFpg: String): Boolean;
begin
  Result := FCdsFpgSel.Locate('CODFPG', strCodFpg, []);
end;

function TFormaPagtoNegociada.fFormaPagtoSelecionada(
  const AintAutoInc: Integer): Boolean;
begin
  Result := FCdsFpgSel.Locate('AUTOINC', AintAutoInc, []);
end;

function TFormaPagtoNegociada.fValorFormaPagtoSelecionada(strCodFpg: String): Double;
begin
  If FCdsFpgSel.Locate('CODFPG', strCodFpg, []) Then
    Result := FCdsFpgSel.FieldByName('VALFPG').AsFloat
  Else
    Result := 0;
end;

function TFormaPagtoNegociada.fVerificaAutoincremVazio(AIncPed: String): String;
begin
  Result := TrimRight(AIncPed);

  If fEmptyStr(Result) Then
    Raise ExceptionAutCom.Create('O autoincrem nao pode estar vazio, favor verificar os registros!');
end;

function TFormaPagtoNegociada.fTemFormaPagtoJaRecebidaParc: Boolean;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := False;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    Result := cdsTmp.FieldByName('VALANT').AsFloat > 0;
    If Result Then
      Break;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.fBuscaDuplicatasSelecionadas: String;
begin
  Result := FDupCred.Text;
end;

function TFormaPagtoNegociada.fTemFormaPagtoAVistaSelecionada: Boolean;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := False;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    Result := cdsTmp.FieldByName('CONPAG').AsString = '01000';
    If Result Then
      Break;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.fTemFormaPagtoComRecebimento: Boolean;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := False;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    Result := cdsTmp.FieldByName('VALREC').AsFloat > 0;
    If Result Then
      Break;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.fCartaoJaInformado(strCodCar: String): Boolean;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := False;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    If (cdsTmp.FieldByName('CODFPG').AsString = '007') And
       (cdsTmp.FieldByName('CODCAR').AsString = strCodCar) Then
    Begin
      Result := True;
      Break;
    End;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.fTipoDeCartaoJaInformado(
  strTipCar: String): Boolean;
  Var
    cdsTmp: TUniClientDataSet;
    cartao: TDadosCartao;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := False;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    If cdsTmp.FieldByName('CODFPG').AsString = '007' Then
    Begin
      cartao.pCarregaDadosCartao(cdsTmp.FieldByName('CODCAR').AsString);
      If cartao.strTipoCartao = strTipCar Then
      Begin
        Result := True;
        Break;
      End;
    End;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.fTemFormaPagtoAPrazoSelecionada: Boolean;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := False;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    Result := cdsTmp.FieldByName('CONPAG').AsString <> '01000';
    If Result Then
      Break;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.fTemFormaPagtoNaoPermitidaComAReceber(Var strDesFpg: String): Boolean;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := False;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    If Not fFormaPagtoPermitidaComAReceber(cdsTmp.FieldByName('CODFPG').AsString) Then
    Begin
      Result    := True;
      strDesFpg := cdsTmp.FieldByName('DESFPG').AsString;
      Break;
    End;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

(*function TFormaPagtoNegociada.fFormaPagtoPermitidaComCreditos(var formaPagtoSel: TFormaPagto): Boolean;
  Var
    cdsTmp: TUniClientDataSet;
begin
  Result := True;

  If fFormaPagtoSelecionada('013') And (Not blnAdiantamentoPedido) Then
  Begin
    cdsTmp := TUniClientDataSet.Create(nil);
    cdsTmp.Data := FCdsFpgSel.Data;

    {********************************************************************************}
    {* QUANDO É UTILIZAÇÃO DE CRÉDITOS, SÓ PODE UTILIZAR FORMAS À VISTA OU A PRAZO. *}
    {*****************************************************************************MV*}
    With cdsTmp Do
    Begin
      First;
      While (Not Eof) Do
      Begin
        //Caso selecionou uma forma de pagamento a prazo
        If (Pos(formaPagtoSel.strCodigo, '008_010_') > 0) Then
        Begin
          //verifica se ja nao possui uma condicao de pagamento a vista
          If (Pos(FieldByName('CODFPG').AsString, '008_010_013_') <= 0) Then
          Begin
            fMensagem('', 'Não é permitido a utilização de ' +
              fRetDesFpg('008') + ' ou ' + fRetDesFpg('010') + '.', ['&Ok']);
            Result := False;
            Break;
          End;
        End
        Else
        //Caso selecionou uma forma de pagamento a vista
        Begin
          //verifica se ja nao possui uma condicao de pagamento a prazo
          If (Pos(FieldByName('CODFPG').AsString, '008_010_') > 0) Then
          Begin
            fMensagem('', 'Já foi inserido a modalidade ' +
              fRetDesFpg(FieldByName('CODFPG').AsString)  + ', portanto só é permitido utilizar ' +
              fRetDesFpg('008') + ' ou ' + fRetDesFpg('010') + '.', ['&Ok']);
            Result := False;
            Break;
          End;
        End;
        Next;
      End;
    End;

    FreeAndNil(cdsTmp);
  End;
end;*)

function TFormaPagtoNegociada.fGetFormasPagtoSelecionadas: String;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := '';
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    Result := Result + cdsTmp.FieldByName('CODFPG').AsString + '_';
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.fGetQuantidadeCartoesNegociados: Integer;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := 0;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    If cdsTmp.FieldByName('CODFPG').AsString = '007' Then
      Inc(Result);
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.fMaxParcCartaoCondicaoPagto: Integer;
begin
  If (fCfgSis('PFLCLI',varBoolean)) Then
    Result := fCampoTabela('CND_MAXCAR','CADCND',['CND_CODIGO'],[FCodCnd])
  Else
    Result := 0;
end;

function TFormaPagtoNegociada.fRecebimentoCompleto(blnMsg: Boolean = True): Boolean;
begin
  Result := Not FCdsFpgSel.IsEmpty;
  FCdsFpgSel.First;

  While Not FCdsFpgSel.Eof Do
  Begin
    If FCdsFpgSel.FieldByName('FPGREC').AsString <> 'S' Then
    Begin
      If blnMsg Then
        pMensagemOk('A forma de pagamento "' + FCdsFpgSel.FieldByName('DESFPG').AsString +
          '" ainda não foi recebida. Favor receber a mesma para prosseguir com a venda!');
      Result := False;
      Break;
    End;
    FCdsFpgSel.Next;
  End;
end;

function TFormaPagtoNegociada.fPedeFormasPagamento(strOpcDoc, strCodCli, strCodFpg, strCodCnd, strConPag: String;
                                                   blnEnt_CD, blnTemRecAnt: Boolean; fltTotVen: Double; blnMostrarTela: Boolean;
                                                   blnDescontaCreditoAutomatico: Boolean = False; blnUsaEmpOri: Boolean = False): Boolean;
begin
  FStatus := snNegociandoFormas;
  FOpcDoc := strOpcDoc;
  FTotVen := fltTotVen;
  FTemRecAnt := blnTemRecAnt;
  FblnUsaEmpOri := blnUsaEmpOri;

  If FCodCli <> strCodCli Then
  Begin
    FCodCli := strCodCli;
    FCdsFpgSel.EmptyDataSet;
  End;

  If FEnt_CD <> blnEnt_CD Then
  Begin
    FEnt_CD := blnEnt_CD;
    FCdsFpgSel.EmptyDataSet;
  End;

  If FCodFpg <> strCodFpg Then
  Begin
    FCodFpg := strCodFpg;
    FCdsFpgSel.EmptyDataSet;
  End;

  If Not blnMostrarTela Then
  Begin
    FCdsFpgSel.EmptyDataSet;
  End;

  If FCodCnd <> strCodCnd Then
  Begin
    FCodCnd := strCodCnd;
    FCdsFpgSel.EmptyDataSet;
  End;

  If FConPag <> strConPag Then
  Begin
    FConPag := strConPag;
    FCdsFpgSel.EmptyDataSet;
  End;

  If FTotVen <= 0.00 Then
  Begin
    pZerarValoresModalidades;
    Result := True;
    Exit;
  End;

  pMontaArrayFormasPagto(blnDescontaCreditoAutomatico);

  Result := True;

  If FTotVen <= 0 Then
  Begin
    FCdsFpgSel.EmptyDataSet;
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatFormaPagtoNegociada, frmFatFormaPagtoNegociada);
    frmFatFormaPagtoNegociada.objFormasPagto := Self;

    If Not blnMostrarTela Then
    Begin
      frmFatFormaPagtoNegociada.blnUtilizaCreditoOutrasFormasPagamento := blnDescontaCreditoAutomatico;
      frmFatFormaPagtoNegociada.pOnShowForm;
      frmFatFormaPagtoNegociada.cbxModalidades.ItemIndex := 0;

      If (FCodFpg = '013') Or (blnDescontaCreditoAutomatico) Then
        Result := Result And frmFatFormaPagtoNegociada.fSelecionarCreditos(blnDescontaCreditoAutomatico, blnUsaEmpOri);

      Result := Result And frmFatFormaPagtoNegociada.fInserirFormaPagto;

      If Result Then
        frmFatFormaPagtoNegociada.btnConfirma.Click;
    End
    Else
      frmFatFormaPagtoNegociada.ShowModal;

    Result := Result And frmFatFormaPagtoNegociada.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmFatFormaPagtoNegociada);
end;

function TFormaPagtoNegociada.fRecebimentoFormasPagtoNegociadasAdiantamento(
  fltTotVen: Double; fFuncaoReceber: TfReceberFormaPagamento): Boolean;
begin
  FStatus     := snRealizandoAdiantamento;
  FTotVen     := fltTotVen;
  FRecForPag  := fFuncaoReceber;
  FAbreGaveta := nil;

  pMontaArrayFormasPagto;

  If FTotVen <= 0.00 Then
  Begin
    pZerarValoresModalidades;
    Result := True;
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatFormaPagtoNegociada, frmFatFormaPagtoNegociada);
    frmFatFormaPagtoNegociada.objFormasPagto := Self;
    frmFatFormaPagtoNegociada.ShowModal;
    Result := frmFatFormaPagtoNegociada.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmFatFormaPagtoNegociada);
end;

function TFormaPagtoNegociada.fRecebimentoFormasPagtoNegociadasF11(fltTotVen: Double;
  fFuncaoReceber: TfReceberFormaPagamento; pProcAbrirGaveta: TpAbrirGaveta): Boolean;
begin
  FStatus     := snRealizandoRecebimentoF11;
  FTotVen     := fltTotVen;
  FRecForPag  := fFuncaoReceber;
  FAbreGaveta := pProcAbrirGaveta;

  pMontaArrayFormasPagto;

  If FTotVen <= 0.00 Then
  Begin
    pZerarValoresModalidades;
    Result := True;
    Exit;
  End;

  Try
    pCriarFormularios(TfrmFatFormaPagtoNegociada, frmFatFormaPagtoNegociada);
    frmFatFormaPagtoNegociada.objFormasPagto := Self;
    frmFatFormaPagtoNegociada.ShowModal;
    Result := frmFatFormaPagtoNegociada.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmFatFormaPagtoNegociada);
end;

function TFormaPagtoNegociada.GetCreditosCliente: Double;
begin
  Result := Abs(fGetTotalCreditosCliente(strCodCliente, FblnUsaEmpOri));
end;

procedure TFormaPagtoNegociada.pZerarValoresModalidades;
begin
  FCdsFpgSel.First;
  While Not FCdsFpgSel.EOF Do
  Begin
    FCdsFpgSel.Edit;
    FCdsFpgSel.FieldByName('VALFPG').AsFloat := 0.00;
    FCdsFpgSel.Post;
    FCdsFpgSel.Next;
  End;
end;

function TFormaPagtoNegociada.GetTotalFormasSel: Double;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := 0;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    Result := Result + cdsTmp.FieldByName('VALFPG').AsFloat;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.GetValorTroco: Double;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := 0;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    Result := Result + cdsTmp.FieldByName('VALTRO').AsFloat;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.GetValorRecebido: Double;
  Var
    cdsTmp: TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(nil);
  cdsTmp.Data := FCdsFpgSel.Data;

  Result := 0;
  cdsTmp.First;
  While Not cdsTmp.Eof Do
  Begin
    Result := Result + cdsTmp.FieldByName('VALREC').AsFloat;
    cdsTmp.Next;
  End;

  FreeAndNil(cdsTmp);
end;

function TFormaPagtoNegociada.GetValorRestante: Double;
begin
  Result := fltTotalVenda - fltTotalFormasPagto;
end;

function TFormaPagtoNegociada.GetValorRestanteReceber: Double;
begin
  Result := fltTotalVenda - fltValorRecebido + fltValorTroco;
end;

procedure TFormaPagtoNegociada.pMontaArrayFormasPagto(blnDescontaCreditoAutomatico: Boolean = False);
  Var
    qryCadFpg: TUniQuery;
    stlForPag: TStringList;
    stlCndPag: TStringList;
    blnAddFpg: Boolean;
    strPatIni: String;
    strCodEcf: String;
begin
  stlForPag := TStringList.Create;
  stlCndPag := TStringList.Create;

  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

  If (fCfgSis('USATPC') = 'S') Then
    pCarregaFormasPagto(FCodCli, stlForPag, stlCndPag);

  SetLength(FArrFormas, 0);

  qryCadFpg := fCriaQuery;

  With qryCadFpg, SQL Do
  Begin
    Close;
    Clear;

    //Recebimento de adiantamento de pedido caixa
    If FRecAdtPed Then
    Begin
      Add('SELECT  ');
      Add('  F.FPG_CODIGO, ');
      Add('  F.FPG_DESCRI  ');
      Add('FROM ');
      Add('  CADFPG F ');
      Add('WHERE ');
      Add('  F.FPG_CODIGO IN ( "001",  ');//Dinheiro
      Add('                    "002",  ');//Cheque Pre
      Add('                    "006",  ');//Cheque a Vista
      Add('                    "007",  ');//Cartao
      Add('                    "012",  ');//Ordem de Pagamento
      Add('                    "013" ) ');//Utilizacao de Creditos
      Add(TFatVenda.fFiltroFormasPagamentoF11(FCodCli, FCodFpg, FConPag, FCodOpe, Self, FRecAdtPed));
    End
    //Parcelado (Negociado no pedido para recebimento F11)
    Else If FCodFpg = '009' Then
    Begin
      Add('SELECT  ');
      Add('  F.FPG_CODIGO, ');
      Add('  F.FPG_DESCRI  ');
      Add('FROM ');
      Add('  CADFPG F ');

      If Not fEmptyStr(strCodEcf) Then
      Begin
        Add('JOIN FPGECF FE ON FE.FPG_CODIGO = F.FPG_CODIGO      ');
        Add('JOIN ECFMOD E ON E.ECF_CODECF = FE.ECF_CODECF AND   ');
        Add('                 E.ECF_CODEMP = FE.ECF_CODEMP AND   ');
        Add('                 E.ECF_CODMOD = FE.ECF_CODMOD AND   ');
        Add('                 E.ECF_CODECF = "' + strCodEcf + '" ');
      End;

      Add('WHERE ');
      Add('  F.FPG_MOSMOD = "S" AND   ');
      Add('  F.FPG_STATUS = "A" AND   ');
      Add('  F.FPG_CODIGO IN ( "001",  ');//Dinheiro
      Add('                    "002",  ');//Cheque Pre
      Add('                    "006",  ');//Cheque a Vista
      Add('                    "007",  ');//Cartao
      Add('                    "008",  ');//Boleto
      Add('                    "012",  ');//Ordem de Pagamento
      Add('                    "013",  ');//Utilizacao de Creditos
      Add('                    "015" ) ');//A Receber
    End
    //Outra forma de pagamento (carrega somente a propria)
    Else
    Begin
      Add('SELECT  ');
      Add('  F.FPG_CODIGO, ');
      Add('  F.FPG_DESCRI  ');
      Add('FROM ');
      Add('  CADFPG F ');
      Add('WHERE ');
      Add('  F.FPG_CODIGO = "' + FCodFpg + '" ');

      If blnDescontaCreditoAutomatico Then
        Add(' OR F.FPG_CODIGO = 013 ');
    End;

    Open;

    First;
    While Not Eof Do
    Begin
      blnAddFpg := True;

      If (stlForPag.Count > 0) And
         (stlForPag.IndexOf(FieldByName('FPG_CODIGO').AsString) = -1) Then
      Begin
        blnAddFpg := False;
      End
      Else If (FieldByName('FPG_CODIGO').AsString = '013') And
              (LeftStr(strCondicaoPagto, 2) = '12') Then
      Begin
        blnAddFpg := False;
      End;

      If blnAddFpg Then
      Begin
        SetLength(FArrFormas, Length(FArrFormas) + 1);
        With FArrFormas[Length(FArrFormas) - 1] Do
        Begin
          strCodigo        := FieldByName('FPG_CODIGO').AsString;
          strDescricao     := FieldByName('FPG_DESCRI').AsString;
          fltValor         := 0.00;
          strCondPagamento := '01000';
          dadosCartao.pCarregaDadosCartao('');
        End;
      End;

      Next;
    End;
  End;

  FreeAndNil(stlForPag);
  FreeAndNil(stlCndPag);
  FreeAndNil(qryCadFpg);
end;

procedure TFormaPagtoNegociada.pRemoverFormaPagto(blnPergunta: Boolean = True);
begin
  If Not FCdsFpgSel.IsEmpty Then
  Begin
    If FCdsFpgSel.FieldByName('VALREC').AsFloat > 0 Then
    Begin
      pMensagemOk('Não é possível remover uma forma de pagamento que já tenha recebimento realizado!');
      Exit;
    End;

    If Not blnPergunta Or fPergunta('Deseja remover a forma de pagamento selecionada?') Then
      FCdsFpgSel.Delete;
  End;
end;

procedure TFormaPagtoNegociada.pRestaurarBackupNegociacao;
begin
  FCdsFpgSel.Data := FCdsFpgBkp.Data;
  TFloatField(FCdsFpgSel.FieldByName('VALFPG')).DisPlayFormat := '#,##0.00';
  TFloatField(FCdsFpgSel.FieldByName('VALREC')).DisPlayFormat := '#,##0.00';
  TFloatField(FCdsFpgSel.FieldByName('VALTRO')).DisPlayFormat := '#,##0.00';
end;

procedure TFormaPagtoNegociada.pSalvarBackupNegociacao;
begin
  FCdsFpgBkp.Data := FCdsFpgSel.Data;
end;

procedure TFormaPagtoNegociada.pSelecionarFormaPagto(formPagto: TFormaPagto);
begin
  If (Not fEmptyStr(formPagto.dadosCartao.strCodigo)) And (FCdsFpgSel.Locate('CODCAR', formPagto.dadosCartao.strCodigo, [])) Then
  Begin
    fMensagem('Atenção!', 'O cartão (' + formPagto.dadosCartao.strCodigo + ') já foi inserido.', ['&OK']);
    Exit;
  End;

  FCdsFpgSel.Append;
  FCdsFpgSel.FieldByName('CODFPG').AsString  := formPagto.strCodigo;
  FCdsFpgSel.FieldByName('DESFPG').AsString  := formPagto.strDescricaoCompleta;
  FCdsFpgSel.FieldByName('VALFPG').AsFloat   := formPagto.fltValor;
  FCdsFpgSel.FieldByName('VALANT').AsFloat   := formPagto.fltValorAntecipadoCadRec;
  FCdsFpgSel.FieldByName('CONPAG').AsString  := formPagto.strCondPagamento;
  FCdsFpgSel.FieldByName('CODCAR').AsString  := formPagto.dadosCartao.strCodigo;
  FCdsFpgSel.FieldByName('QTDPAR').AsInteger := formPagto.dadoscartao.intQtdParcelas;
  if fDataValida(formPagto.dtaDataChqPre) then
    FCdsFpgSel.FieldByName('DTACHQ').AsDateTime:= formPagto.dtaDataChqPre;
  FCdsFpgSel.FieldByName('VALREC').AsFloat   := 0.00;
  FCdsFpgSel.FieldByName('VALTRO').AsFloat   := 0.00;
  If (fFormataFloat(formPagto.fltValorAntecipadoCadRec, 2) > 0) And
     (fFormataFloat(formPagto.fltValorAntecipadoCadRec, 2) = fFormataFloat(formPagto.fltValor, 2)) Then
    FCdsFpgSel.FieldByName('FPGREC').AsString  := 'S'
  Else
    FCdsFpgSel.FieldByName('FPGREC').AsString  := 'N';
  FCdsFpgSel.Post;
end;

procedure TFormaPagtoNegociada.pCriaClientDataSetFormas;
begin
  FCdsFpgSel := TUniClientDataSet.Create(nil);

  With FCdsFpgSel Do
  Begin
    FieldDefs.Add('AUTOINC', ftAutoInc,000);
    FieldDefs.Add('CODFPG', ftString,  003);
    FieldDefs.Add('DESFPG', ftString,  255);
    FieldDefs.Add('VALFPG', ftFloat,   000);
    FieldDefs.Add('CONPAG', ftString,  074);
    FieldDefs.Add('CODCAR', ftString,  005);
    FieldDefs.Add('QTDPAR', ftInteger, 000);
    FieldDefs.Add('VALANT', ftFloat,   000);
    FieldDefs.Add('VALREC', ftFloat,   000);
    FieldDefs.Add('VALTRO', ftFloat,   000);
    FieldDefs.Add('FPGREC', ftString,  001);
    FieldDefs.Add('DTACHQ', ftDateTime,000);
    CreateDataSet;
    TFloatField(FieldByName('VALFPG')).DisPlayFormat := '#,##0.00';
    TFloatField(FieldByName('VALREC')).DisPlayFormat := '#,##0.00';
    TFloatField(FieldByName('VALTRO')).DisPlayFormat := '#,##0.00';
    TFloatField(FieldByName('VALANT')).DisPlayFormat := '#,##0.00';
  End;

  FCdsFpgBkp := TUniClientDataSet.Create(nil);
  FCdsFpgBkp.Data := FCdsFpgSel.Data;
end;

procedure TFormaPagtoNegociada.pLimparFormasNegociadas;
begin
  FCdsFpgSel.EmptyDataSet;
end;

function TFormaPagtoNegociada.fSalvarFormasPagtoNegociadas(strAutIncFatGor: String): Boolean;
  Var
    qryGen: TUniQuery;
    strAutIncCadRec: String;
begin
  Result := True;

  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'SELECT * FROM FPGNEG WHERE FALSE';
  qryGen.Open;

  FCdsFpgSel.First;
  While Not FCdsFpgSel.Eof do
  Begin
    qryGen.Append;

    qryGen.FieldByName('FPN_SEQFGO').AsString  := strAutIncFatGor;
    qryGen.FieldByName('FPN_CODFPG').AsString  := FCdsFpgSel.FieldByName('CODFPG').AsString;
    qryGen.FieldByName('FPN_VALFPG').AsFloat   := FCdsFpgSel.FieldByName('VALFPG').AsFloat;
    qryGen.FieldByName('FPN_CONPAG').AsString  := FCdsFpgSel.FieldByName('CONPAG').AsString;
    qryGen.FieldByName('FPN_QTDPAR').AsInteger := FCdsFpgSel.FieldByName('QTDPAR').AsInteger;
    if (not FCdsFpgSel.FieldByName('DTACHQ').IsNull) and (fDataValida(FCdsFpgSel.FieldByName('DTACHQ').AsDateTime)) then
      qryGen.FieldByName('FPN_DTACHQ').AsDateTime:= FCdsFpgSel.FieldByName('DTACHQ').AsDateTime;

    If fEmptyStr(FCdsFpgSel.FieldByName('CODCAR').AsString) Then
      qryGen.FieldByName('FPN_CODCAR').Value := Null
    Else
      qryGen.FieldByName('FPN_CODCAR').AsString := FCdsFpgSel.FieldByName('CODCAR').AsString;

    qryGen.Post;

    FCdsFpgSel.Next;
  End;

  If fFormaPagtoSelecionada('013') Then
  Begin
    qryGen.Close;
    qryGen.SQL.Text := 'SELECT * FROM FPNCRE WHERE FALSE';
    qryGen.Open;

    For strAutIncCadRec In FDupCred Do
    Begin
      qryGen.Append;
      qryGen.FieldByName('FPN_SEQFGO').AsString  := strAutIncFatGor;
      qryGen.FieldByName('FPN_SEQCTR').AsString  := strAutIncCadRec.DeQuotedString;
      qryGen.Post;
    End;
  End;

  FreeAndNil(qryGen);
end;

function TFormaPagtoNegociada.fSalvarFormasPagtoNegociadasDesmembramento(
  strAutIncFatGor: String; fltTotGer: Double): Boolean;
begin
  Try
    Result := False;
    pSalvarBackupNegociacao;
    pAcertarValorModalidadesDesmembramento(fltTotGer);
    Result := fSalvarFormasPagtoNegociadas(strAutIncFatGor);
  Finally
    pRestaurarBackupNegociacao;
  End;
end;

function TFormaPagtoNegociada.fSelecionarCreditos(blnDescontaCreditoAutomatico: Boolean = False; blnUsaEmpOri: Boolean = False): Boolean;
  Var
    fltValNeg: Double;
    dtaDtaIni, dtaDtaFin: TDate;
    crTela: TChamaRotina;
    strMsg: String;
    frmAgrupDuplicatas: TfrmAgrupDuplicatas;
begin
  Result := False;

  If FCodFpg = '013' Then
    fltValNeg := FTotVen
  Else
    fltValNeg := 0;

  If fExisteCredComProfissionalDevMerc(FCodCli, dtaDtaIni, dtaDtaFin, crTela) Then
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
        strMsg := strMsg + 'poderá ser usado na Utilização de Créditos. '+ sLineBreak;
        strMsg := strMsg + 'Caso o valor final do agrupamento permaneça positivo (débito para o cliente), o operador ';
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
      frmAgrupDuplicatas.edtCodCli.Text := FCodCli;
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
      If Not TFuncoesCaixa.fChamaTelaCaixa(FCodOpe, FCodCli) Then
      Begin
        fMensagem('ATENÇÃO','É necessário que baixe todas as duplicatas de créditos para utilizar este tipo de modalidade!',['&OK']);
        Exit;
      End;
    End;
  End;

  Result := fSelecionaDuplicatasCredito(FCodCli, FTotVen, FDupCred,
                                        FLckDup, FTotCred, '', nil,
                                        not blnDescontaCreditoAutomatico, fltValNeg, Nil, FOpcDoc, False, '', blnDescontaCreditoAutomatico, blnUsaEmpOri);
end;

function TFormaPagtoNegociada.fSalvarFormasPagtoNegociadasNovoPedidoF11(
  modalidades: TDadosModalidades; strConPag, strAutIncFatGor: String): Boolean;
begin
  Try
    Result := False;
    pSalvarBackupNegociacao;
    pLimparFormasNegociadas;

    pAcertaValorComTrocoModalidadesNovoPedidoF11(modalidades);
    pAcertarValorModalidadesNovoPedidoF11(modalidades, strConPag);
    Result := fSalvarFormasPagtoNegociadas(strAutIncFatGor);
  Finally
    pRestaurarBackupNegociacao;
  End;
end;

procedure TFormaPagtoNegociada.pAdicionarModalidadesNovoPedidoF11(strCodFpg, strConPag: String; fltValor: Double);
  Var
    formaPagtoSel: TFormaPagto;
begin
  While fFormaPagtoSelecionada(strCodFpg) Do
    FCdsFpgSel.Delete;

  If fFormataFloat(fltValor, 2) <> 0.00 Then
  Begin
    FillChar(formaPagtoSel, SizeOf(formaPagtoSel), #0);

    formaPagtoSel.strCodigo        := strCodFpg;
    formaPagtoSel.strDescricao     := fRetDesFpg(strCodFpg);
    formaPagtoSel.fltValor         := Abs(fltValor);
    formaPagtoSel.strCondPagamento := '01000';

    If MatchStr(strCodFpg, ['002', '008', '010']) Then
      formaPagtoSel.strCondPagamento := fGetCondicaoPrazo(strConPag);

    pSelecionarFormaPagto(formaPagtoSel);
  End;
end;

procedure TFormaPagtoNegociada.pAcertarValorModalidadesDesmembramento(fltTotGer: Double);
  Var
    fltTotFpg: Double;
    fltTotDif: Double;
begin
  If FCdsFpgSel.IsEmpty Then
    Exit;

  fltTotFpg := GetTotalFormasSel;

  FCdsFpgSel.First;
  While Not FCdsFpgSel.Eof Do
  Begin
    FCdsFpgSel.Edit;
    FCdsFpgSel.FieldByName('VALFPG').AsFloat := fFormataFloat(fltTotGer *
      (FCdsFpgSel.FieldByName('VALFPG').AsFloat / fltTotFpg), 2);
    FCdsFpgSel.Post;
    FCdsFpgSel.Next;
  End;

  fltTotDif := fFormataFloat(fltTotGer, 2) -
               fFormataFloat(GetTotalFormasSel, 2);

  If fltTotDif <> 0 Then
  Begin
    FCdsFpgSel.Edit;
    FCdsFpgSel.FieldByName('VALFPG').AsFloat := fFormataFloat(
      FCdsFpgSel.FieldByName('VALFPG').AsFloat + fltTotDif, 2);
    FCdsFpgSel.Post;
  End;

  FCdsFpgSel.First;
end;

procedure TFormaPagtoNegociada.pAcertarValorModalidadesNovoPedidoF11(modalidades: TDadosModalidades; strConPag: String);
begin
  pAdicionarModalidadesNovoPedidoF11('001', strConPag, modalidades.fltValDin);
  pAdicionarModalidadesNovoPedidoF11('002', strConPag, modalidades.fltValCqP);
  pAdicionarModalidadesNovoPedidoF11('006', strConPag, modalidades.fltValCqV);
  pAdicionarModalidadesNovoPedidoF11('007', strConPag, modalidades.fltValCar);
  pAdicionarModalidadesNovoPedidoF11('008', strConPag, modalidades.fltFatura);
  pAdicionarModalidadesNovoPedidoF11('012', strConPag, modalidades.fltValOrd);
  pAdicionarModalidadesNovoPedidoF11('013', strConPag, modalidades.fltValCre);
  pAdicionarModalidadesNovoPedidoF11('015', strConPag, modalidades.fltVlARec);
end;

procedure TFormaPagtoNegociada.pAcertaValorComTrocoModalidadesNovoPedidoF11(
  var modalidades: TDadosModalidades);
begin
  If (modalidades.optTroco = otTroco) And (modalidades.fltValorTroco > 0) And (modalidades.fltValDin >= modalidades.fltValorTroco) Then
    modalidades.fltValDin := modalidades.fltValDin - modalidades.fltValorTroco;

  If (modalidades.optTrocoPre = otTroco) And (modalidades.fltValorTrocoPre > 0) And (modalidades.fltValDin >= modalidades.fltValorTrocoPre) Then
    modalidades.fltValDin := modalidades.fltValDin - modalidades.fltValorTrocoPre;

  If (modalidades.optTrocoCar = otTroco) And (modalidades.fltValorTrocoCar > 0) And (modalidades.fltValDin >= modalidades.fltValorTrocoCar) Then
    modalidades.fltValDin := modalidades.fltValDin - modalidades.fltValorTrocoCar;

  If (modalidades.optTrocoDinheiro = otTroco) And (modalidades.fltValorTrocoDinheiro > 0) And (modalidades.fltValDin >= modalidades.fltValorTrocoDinheiro) Then
    modalidades.fltValDin := modalidades.fltValDin - modalidades.fltValorTrocoDinheiro;
end;

procedure TFormaPagtoNegociada.pCarregarFormasPagtoNegociadas(strAutIncPed: String);
  Var
    qryGen: TUniQuery;
    qryAdt: TUniQuery;
    formPagto: TFormaPagto;
    strAutInc: String;
    stlAutInc: TStringList;
begin
  If fEmptyStr(strAutIncPed) Then
    Exit;

  stlAutInc := Nil;
  qryGen := Nil;
  qryAdt := Nil;

  Try
    Try
      stlAutInc := TStringList.Create;
      stlAutInc.CommaText := strAutIncPed;

      strAutIncPed := '';
      For strAutInc In stlAutInc Do
      Begin
        If strAutIncPed <> '' Then
          strAutIncPed := strAutIncPed + ', ';
        strAutIncPed := strAutIncPed + strAutInc.Trim.QuotedString;
      End;

      strAutIncPed := fVerificaAutoincremVazio(strAutIncPed);

      FDupCred.Clear;
      FLckDup.Clear;
      FCdsFpgSel.EmptyDataSet;

      qryGen := fCriaQuery;
      qryAdt := fCriaQuery;

      qryGen.Close;
      qryGen.SQL.Text := ' SELECT   ' +
                         '   FGO_CODCLI, FGO_CODFPG, FGO_CODCND, FGO_CONPAG, FGO_ENT_CD ' +
                         ' FROM     ' +
                         '   FATGOR ' +
                         ' WHERE    ' +
                         '   AUTOINCREM IN(' + strAutIncPed + ') ';
      qryGen.Open;

      FCodCli := qryGen.FieldByName('FGO_CODCLI').AsString;
      FCodFpg := qryGen.FieldByName('FGO_CODFPG').AsString;
      FCodCnd := qryGen.FieldByName('FGO_CODCND').AsString;
      FConPag := qryGen.FieldByName('FGO_CONPAG').AsString;
      FEnt_CD := qryGen.Locate('FGO_ENT_CD', 'S', []);

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
                         '   FPN_SEQFGO IN (' + strAutIncPed + ') ' +
                         ' GROUP BY ' +
                         '   FPN_CODFPG, ' +
                         '   FPN_CONPAG, ' +
                         '   FPN_CODCAR, ' +
                         '   FPN_QTDPAR  ' ;


      If fCfgSis('TFPF11', varBoolean) Then
      Begin
        If (Length(strAutIncPed) = 22) Then
        Begin
          qryAdt.Close;
          qryAdt.SQL.Text := ' SELECT '+
                             '   SUM(IF(ADT_TIPLAN = "C", ADT_VALDIN, -ADT_VALDIN)) AS "001", '+
                             '   SUM(IF(ADT_TIPLAN = "C", ADT_VALCHV, -ADT_VALCHV)) AS "006", '+
                             '   SUM(IF(ADT_TIPLAN = "C", ADT_VALCHP, -ADT_VALCHP)) AS "002", '+
                             '   SUM(IF(ADT_TIPLAN = "C", ADT_VALCAR, -ADT_VALCAR)) AS "007", '+
                             '   SUM(IF(ADT_TIPLAN = "C", ADT_VALORD, -ADT_VALORD)) AS "012", '+
                             '   SUM(IF(ADT_TIPLAN = "C", ADT_VALCRE, -ADT_VALCRE)) AS "013"  '+
                             ' FROM ADTCLI '+
                             '    INNER JOIN FATGOR ON ADT_NUMDOC = FGO_NUMDOC AND '+
                             '                         ADT_ESPDOC = FGO_ESPDOC AND '+
                             '                         ADT_CODEMP = FGO_CODEMP AND '+
                             '                         ADT_CODCLI = FGO_CODCLI     '+
                             ' WHERE FATGOR.AUTOINCREM = '+strAutIncPed;
          qryAdt.Open;
        End;
      End;

      qryGen.Open;

      qryGen.First;
      While Not qryGen.Eof do
      Begin

        If TAdiantamento.fAdiantamentoGravadoAutomaticamentePorSeq(strAutIncPed) And
           (qryGen.FieldByName('FPN_CODFPG').AsString = '013') Then
        Begin
          qryGen.Next;
          Continue;
        End;

        FillChar(formPagto, SizeOf(formPagto), #0);

        formPagto.strCodigo        := qryGen.FieldByName('FPN_CODFPG').AsString;
        formPagto.strDescricao     := fRetDesFpg(formPagto.strCodigo);

        If (qryAdt.Active) Then
          If (Not qryAdt.IsEmpty) Then
            If (qryAdt.FindField(formPagto.strCodigo) <> Nil) Then
              formPagto.fltValorAntecipadoCadRec := qryAdt.FindField(formPagto.strCodigo).AsFloat;

        formPagto.fltValor := qryGen.FieldByName('FPN_VALFPG').AsFloat;
        formPagto.strCondPagamento := qryGen.FieldByName('FPN_CONPAG').AsString;
        formPagto.dtaDataChqPre    := qryGen.FieldByName('FPN_DTACHQ').AsDateTime;
    
        formPagto.dadosCartao.pCarregaDadosCartao(qryGen.FieldByName('FPN_CODCAR').AsString);
        formPagto.dadoscartao.intQtdParcelas := qryGen.FieldByName('FPN_QTDPAR').AsInteger;

        pSelecionarFormaPagto(formPagto);

        qryGen.Next;
      End;

      If fFormaPagtoSelecionada('013') Then
      Begin
        qryGen.Close;
        qryGen.SQL.Text := 'SELECT DISTINCT FPN_SEQCTR FROM FPNCRE WHERE FPN_SEQFGO IN (' + strAutIncPed + ') ';
        qryGen.Open;

        qryGen.First;
        While Not qryGen.Eof do
        Begin
          FDupCred.Add(qryGen.FieldByName('FPN_SEQCTR').AsString.QuotedString);
          qryGen.Next;
        End;
      End;
    Except
      On E: ExceptionAutCom Do
      Begin
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryAdt);
    FreeAndNil(qryGen);
    FreeAndNil(stlAutInc);
  End;
end;

procedure TFormaPagtoNegociada.pRealizarRecebimento;
  Var
    fltValRec: Double;
    fltValCar: Double;
    fltValDin: Double;
    fltTroco : Double;
    strCodFpg: String;
    strCodCar: String;
    intQtdPar: Integer;
    LstrMensagem : String;
    LintAutoInc : Integer;
begin
  With FCdsFpgSel Do
  Begin
    LintAutoInc := FieldByName('AUTOINC').AsInteger ;
    strCodFpg := FieldByName('CODFPG').AsString;
    strCodCar := FieldByName('CODCAR').AsString;
    intQtdPar := FieldByName('QTDPAR').AsInteger;
    fltValRec := FieldByName('VALFPG').AsFloat - FieldByName('VALREC').AsFloat - FieldByName('VALANT').AsFloat;

    If (strCodFpg <> '013') And fFormaPagtoSelecionada('013') And
       (FieldByName('FPGREC').AsString <> 'S') And (Not blnAdiantamentoPedido) Then
    Begin
      fMensagem('ATENÇÃO!', 'A forma de pagamento "' +  FieldByName('DESFPG').AsString + '" ' +
        'deve ser recebida antes das outras formas de pagamento!', ['&Ok']);
      Exit;
    End;

    If (strCodFpg = '013') And fFormaPagtoSelecionada('013') And (fCfgSis('UTICRE') = 'N') And
       (FieldByName('FPGREC').AsString <> 'S') And (Not blnAdiantamentoPedido) Then
    Begin
      fMensagem('ATENÇÃO!', 'A forma de pagamento "' +  FieldByName('DESFPG').AsString + '" ' +
        'não pode ser recebida quando a configuração "CFG_UTICRE" estiver gravada como "Não"!', ['&Ok']);
      Exit;
    End;

    //Necessario para posicionar novamente na forma de pagamento em recebimento
    If Not fFormaPagtoSelecionada(LintAutoInc) Then
      Exit;

    If FieldByName('FPGREC').AsString = 'S' Then
    Begin
      pMensagemOk('Esta forma de pagamento já foi recebida!');
      Exit;
    End;

    if (strCodFpg = '013') And
       fFormaPagtoSelecionada('013') and
       (FStatus = snRealizandoRecebimentoF11) and
       (not fValidaRecebimentoDeCreditoPorPortador(FstrNumeroDocumentoNegociado,
                                                   FstrEspecieDocumentoNegociado,
                                                   FstrEmpresaDocumentoNegociado,
                                                   LstrMensagem))  then
    Begin
      fMensagem('ATENÇÃO!', LstrMensagem, ['&Ok']);
      Exit;
    End;

    If (strCodFpg = '007') And (Not blnAdiantamentoPedido) Then
    Begin
      fltValCar := fltValRec;

      If Not fDigitaValor(fltValCar, 'Recebimento em Cartão') Then
        Exit;

      If fFormataFloat(fltValCar, 2) > fFormataFloat(fltValRec, 2) Then
      Begin
        pMensagemOk('O valor do cartão não pode ser maior que R$ ' +
          FormatFloat('#,##0.00', fltValRec)+ '. Verifique o valor digitado!');
        Exit;
      End
      Else
        fltValRec := fltValCar;
    End;

    fltTroco := 0.00;

    If (strCodFpg = '001') {And (Not blnAdiantamentoPedido)} Then
    Begin
      fltValDin := fltValRec;

      If Not fDigitaValor(fltValDin, 'Recebimento em Dinheiro') Then
        Exit;

      If fFormataFloat(fltValDin, 2) < fFormataFloat(fltValRec, 2) Then
      Begin
        pMensagemOk('O valor em Dinheiro não pode ser menor que R$ ' +
          FormatFloat('#,##0.00', fltValRec)+ '. Verifique o valor digitado!');
        Exit;
      End;

      fltTroco  := fltValDin - fltValRec;
      fltValRec := fltValDin;
    End;

    If fReceberFormaPagamento(strCodFpg, fltValRec - fltTroco, strCodCar, intQtdPar) Then
    Begin
      //Necessario para posicionar no registro correto
      If fFormaPagtoSelecionada(LintAutoInc) Then
      Begin
        Edit;
        FieldByName('VALREC').AsFloat  := FieldByName('VALREC').AsFloat + fltValRec;
        FieldByName('VALTRO').AsFloat  := fltTroco;

        If fFormataFloat(FieldByName('VALREC').AsFloat, 2) + fFormataFloat(FieldByName('VALANT').AsFloat, 2) >=
           fFormataFloat(FieldByName('VALFPG').AsFloat, 2) Then
        Begin
          FieldByName('FPGREC').AsString := 'S';
        End;

        Post;

        //Quando receber dinheiro, cheque ou cartao vai abrir a gaveta
        If fPos(strCodFpg, '001_002_006_007_') And Assigned(pAbrirGaveta) Then
          pAbrirGaveta('01000');
      End;
    End;

  End;
end;

function TFormaPagtoNegociada.fCodChqPre: String;
begin
  Result := '002';
  If (fStatusCndPag(strCondicaoPagto) = A_VISTA) Then
  Begin
    Result := '';
  End;
end;

function TFormaPagtoNegociada.fValidaFormaPagto(var formaPagtoSel: TFormaPagto): Boolean;
  Var
    strDesFpg: String;
begin
  Result := True;

  If fEmptyStr(formaPagtoSel.strCodigo) Then
  Begin
    fMensagem('', 'Selecione a forma de pagamento!', ['&Ok']);
    Result := False;
  End
  Else If (formaPagtoSel.strCodigo <> '007') And //Deve permitir informar mais de um cartão
          (fFormaPagtoSelecionada(formaPagtoSel.strCodigo)) Then
  Begin
    fMensagem('', 'Esta forma de pagamento já foi selecionada!', ['&Ok']);
    Result := False;
  End
  Else If (Pos(formaPagtoSel.strCodigo, fCodChqPre+'_008_010_') > 0) And
          (fStatusCndPag(strCondicaoPagto) = A_VISTA) Then
  Begin
    fMensagem('', 'Forma de pagamento "' + formaPagtoSel.strDescricao +
      '" não é permitida pois a condição de pagamento do documento é a Vista!', ['&Ok']);
    Result := False;
  End
  Else If (Pos(formaPagtoSel.strCodigo, '008_010_') > 0) And
          (fClienteConsumidor(fRetNomCliente(strCodCliente), False, True)) Then
  Begin
    fMensagem('', 'Forma de pagamento "' + formaPagtoSel.strDescricao + '" não é ' +
      'permitida para cliente consumidor!', ['&Ok']);
    Result := False;
  End
  Else If (formaPagtoSel.strCodigo = '013') And (fltCreditosCliente = 0) Then
  Begin
    fMensagem('', 'Forma de pagamento "' + formaPagtoSel.strDescricao + '" não é ' +
      'permitida pois o cliente não possui créditos disponíveis!', ['&Ok']);
    Result := False;
  End
  Else If (formaPagtoSel.strCodigo = '013') And
          (Not FCdsFpgSel.IsEmpty) And (Not blnAdiantamentoPedido) Then
  Begin
    fMensagem('', 'Forma de pagamento "' + formaPagtoSel.strDescricao + '" não permitida ' +
      'pois já foram selecionadas outras formas de Pagamento. Para utilizar esta forma de pagamento ' +
      'ela deve ser a primeira selecionada!', ['&Ok']);
    Result := False;
  End
  Else If (fConPagComEntrada(strCondicaoPagto)) And
          (Pos(formaPagtoSel.strCodigo, fCodChqPre+'_008_010_') > 0) And
          (Not blnTemRecebimentoAnterior) And
          (Not fTemFormaPagtoAVistaSelecionada) Then
  Begin
    fMensagem('', 'Forma de pagamento "' + formaPagtoSel.strDescricao + '" não permitida ' +
      'pois a condição de pagamento do documento possui uma parcela a vista e ainda não ' +
      'foi selecionada nenhuma forma de pagamento a vista!', ['&Ok']);
    Result := False;
  End
  Else If (Pos(formaPagtoSel.strCodigo, fCodChqPre+'_008_010_') > 0) And
          (fTemFormaPagtoAPrazoSelecionada) Then
  Begin
    fMensagem('', 'Forma de pagamento "' + formaPagtoSel.strDescricao + '" não permitida ' +
      'pois já foi selecionada outra forma de pagamento a prazo!', ['&Ok']);
    Result := False;
  End
  Else If (formaPagtoSel.strCodigo = '015') And fTemFormaPagtoNaoPermitidaComAReceber(strDesFpg) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa modalidade de recebimento não é permitida com a modalidade (' +
                          strDesFpg + ') já informada!', ['&Ok']);
    Result := False;
  End
  Else If (fFormaPagtoSelecionada('015')) And
          (Not fFormaPagtoPermitidaComAReceber(formaPagtoSel.strCodigo)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A modalidade já escolhida (' + FCdsFpgSel.FieldByName('DESFPG').AsString + ') não pode ser ' +
                          'utilizada em conjunto com outra modalidade que não seja ' +
                          fDescricaoFormasPagtoPermitidasComAReceber + '.', ['&Ok']);
    Result := False;
  End
  Else If (fFormaPagtoSelecionada('015')) And (FCdsFpgSel.RecordCount > 1) Then
  Begin
    fMensagem('', 'Forma de pagamento "' + FCdsFpgSel.FieldByName('DESFPG').AsString + '" já foi selecionada ' +
                  'com outra forma de pagamento e a mesma não deve ser combinada com mais de ' +
                  'uma forma de pagamento!', ['&Ok']);
    Result := False;
  End
  Else If (formaPagtoSel.strCodigo = '015') And (FCdsFpgSel.RecordCount > 1) Then
  Begin
    fMensagem('', 'Forma de pagamento "' + formaPagtoSel.strDescricao + '" não permitida ' +
                  'pois já foram selecionadas ' + FCdsFpgSel.RecordCount.ToString + ' formas de pagamento e '+
                  'a mesma não deve ser combinada com mais de uma forma de pagamento!', ['&Ok']);
    Result := False;
  End;

//  Result := Result And fFormaPagtoPermitidaComCreditos(formaPagtoSel);
end;

function TFormaPagtoNegociada.fValidaValorFormaPagto(var formaPagtoSel: TFormaPagto; blnUtilizaCreditoOutrasFormasPagamento: Boolean = False): Boolean;
begin
  Result := True;
  If fFormataFloat(formaPagtoSel.fltValor, 2) <= 0.00 Then
  Begin
    fMensagem('', 'O valor da forma de pagamento deve ser maior que zero!', ['&Ok']);
    Result := False;
  End
  Else If (fFormataFloat(formaPagtoSel.fltValor, 2) > fFormataFloat(fltValorRestante, 2)) Then
  Begin
    fMensagem('','O valor da forma de pagamento não deve ser maior que o valor restante ' +
      '(' + FormatFloat('#,##0.00', fltValorRestante) + ')!', ['&Ok']);
    Result := False;
  End
  Else If (formaPagtoSel.strCodigo = '013') And (Not blnUtilizaCreditoOutrasFormasPagamento) And
          (fFormataFloat(formaPagtoSel.fltValor, 2) > fFormataFloat(fltTotCreditos, 2)) Then
  Begin
    fMensagem('', 'O valor não pode ser maior que os créditos selecionados!', ['&Ok']);
    Result := False;
  End
  Else If (formaPagtoSel.strCodigo = '013') And (Not blnUtilizaCreditoOutrasFormasPagamento) And
          (fFormataFloat(fltCreditosCliente, 2) < fFormataFloat(formaPagtoSel.fltValor, 2)) Then
  Begin
    fMensagem('', 'O valor não pode ser maior que os créditos disponíveis do cliente!', ['&Ok']);
    Result := False;
  End;
end;

function TFormaPagtoNegociada.fValidaCodigoCartao(var formaPagtoSel: TFormaPagto): Boolean;
begin
  Result := True;
  With formaPagtoSel.dadosCartao Do
  Begin
    If (fEmptyStr(strCodigo)) Then
    Begin
      fMensagem('', 'O código do cartão deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaDadosCartao(strCodigo);
      If strStatus = 'N' Then
      Begin
        fMensagem('', 'Esse cartão está inativo!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(strDescricao) Then
      Begin
        fMensagem('', 'Esse cartão não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else If (Not fEmptyStr(strEmpresa)) And (strEmpresa <> VS_strCodEmp) Then
      Begin
        fMensagem('', 'Cartão da empresa (' + strEmpresa + '), ' +
          'portanto não pode ser utilizado.', ['&Ok']);
        Result := False;
      End;
//COMENTADO PELO REQUISITO 87052
//      Else If (strTipoCartao = 'D') And fTipoDeCartaoJaInformado('D') Then
//      Begin
//        fMensagem('', 'Já foi informado um cartão de débito!', ['&Ok']);
//        Result := False;
//      End;
    End;
  End;
end;

function TFormaPagtoNegociada.fValidaQuantidadeParcelasCartao(var formaPagtoSel: TFormaPagto): Boolean;

  function fMaxParcela: Double;
  begin
    Result := fCfgSis('PARCAR', varInteger);

    If fMaxParcCartaoCondicaoPagto > 0 Then
      Result := Min(Result, fMaxParcCartaoCondicaoPagto);

    If formaPagtoSel.dadosCartao.intMaxParcelas > 0 Then
      Result := Min(Result, formaPagtoSel.dadosCartao.intMaxParcelas);
  end;

begin
  Result := True;
  With formaPagtoSel.dadosCartao Do
  Begin
    If intQtdParcelas <= 0 Then
    Begin
      fMensagem('', 'O quantidade de parcelas deve ser maior que zero!', ['&Ok']);
      Result := False;
    End
    Else If (fMaxParcela > 0) And (intQtdParcelas > fMaxParcela) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser menor ou ' +
        'igual a ' + fMaxParcela.ToString + '!', ['&Ok']);
      Result := False;
    End;
  End;
end;

function TFormaPagtoNegociada.fValidaCondicaoPagamento(var formaPagtoSel: TFormaPagto): Boolean;
begin
  Result := True;
  If fEmptyStr(fTiraCaracEspeciais(formaPagtoSel.strCondPagamento)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser informada!', ['&O k']);
    Result := False;
  End
  Else If Not fValidaCndPag(formaPagtoSel.strCondPagamento, formaPagtoSel.strCondPagamento, VS_Date) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento ' + fFormataCondPag(formaPagtoSel.strCondPagamento) + ' ' +
      'não é valida!' + #13#10 + 'Verifique se informou todas as parcelas e se as mesmas estão em ordem progressiva, ' +
      'exemplos válidos: (01)000, (01)030, (03)030.060.090', ['&O k']);
    Result := False;
  End
  Else If fEmptyStr(formaPagtoSel.strCondPagamento) Then
  Begin
    Result := False;
  End
  Else If (fClienteConsumidor(fRetNomCliente(strCodCliente)))And
          (fStatusCndPag(formaPagtoSel.strCondPagamento) = A_PRAZO) And
          (Not fCfgSis('PRZCON', varBoolean)) Then
  Begin
    fMensagem('','A condição de pagamento não pode ser a prazo para cliente consumidor!',['&OK']);
    Result := False;
  End
  Else If (Pos(formaPagtoSel.strCodigo, IIF(FCodFpg = '009', fCodChqPre, '002')+'_008_010_') > 0) And
          (fStatusCndPag(formaPagtoSel.strCondPagamento) = A_VISTA) Then
  Begin
    fMensagem('', 'A condição de pagamento não pode ser a vista!', ['&OK']);
    Result := False;
  End
  Else If (Pos(formaPagtoSel.strCodigo, IIF(FCodFpg = '009',fCodChqPre,'002')+'_008_010_') > 0) And
          (fConPagComEntrada(formaPagtoSel.strCondPagamento)) Then
  Begin
    fMensagem('', 'Foi selecionado ' + formaPagtoSel.strDescricao + ', portanto não é ' +
      'permitido informar um vencimento a vista!', ['&OK']);
    Result := False;
  End
  Else If (fStatusCndPag(formaPagtoSel.strCondPagamento) <> A_VISTA) And
          (Pos(formaPagtoSel.strCodigo, '001_006_007_012_013_015_') > 0) And
          (Not blnAdiantamentoPedido) Then
  Begin
    fMensagem('', 'A condição de pagamento deve ser a vista!', ['&OK']);
    Result := False;
  End;
end;

function TFormaPagtoNegociada.fConfirmarFormasPagamento(blnMsg: Boolean = True): Boolean;
  Var 
    strFilter: String;
    blnFiltered: Boolean;
begin
  Result := True;
  With FCdsFpgSel Do
  Begin
    If StatusNegociacao In [snNegociandoFormas, snRealizandoAdiantamento] Then
    Begin
      If fFormataFloat(fltTotalVenda, 2) <> fFormataFloat(fltTotalFormasPagto, 2) Then
      Begin
        If blnMsg Then
          pMensagemOk('O valor total digitado deve ser igual a R$ ' + FormatFloat('#,##0.00', fltTotalVenda) + ' !');
        Result := False;
      End
      Else If (fFormaPagtoSelecionada('008') Or fFormaPagtoSelecionada('010')) And
              (Not blnTemRecebimentoAnterior) And (RecordCount = 1) Then
      Begin
        If blnMsg Then
          fMensagem('', 'Não deve ser digitado apenas "' + FieldByName('DESFPG').AsString + '"!', ['&OK']);
        Result := False;
      End
      Else If blnMsg And
              fFormaPagtoSelecionada('001') And
              (Not fVerificaSaldoMaximo(FieldByName('VALFPG').AsFloat, strCodOperador)) Then
        Result := False;
    End;
    If StatusNegociacao In [snRealizandoRecebimentoF11, snRealizandoAdiantamento] Then
    Begin
      Result := Result And fRecebimentoCompleto(blnMsg);
      
      strFilter   := FCdsFpgSel.Filter;
      blnFiltered := FCdsFpgSel.Filtered;
      Try
        FCdsFpgSel.Filter := '((VALANT > 0) AND (VALREC = VALANT))';
        FCdsFpgSel.Filtered := True;

        While Not FCdsFpgSel.IsEmpty Do
          FCdsFpgSel.Delete;
      Finally
       FCdsFpgSel.Filter   := strFilter;
       FCdsFpgSel.Filtered := blnFiltered;
      End;
    End;
  End;
end;

{ TUnificarCartoesNegociados }

constructor TUnificarCartoesNegociados.Create(
  objNegociacao: TFormaPagtoNegociada);
begin
  FNegociacao := objNegociacao;
  FCartoes    := TUniClientDataSet.Create(nil);

  With FCartoes Do
  Begin
    FieldDefs.Add('AUTOINC', ftInteger,000);
    FieldDefs.Add('CODCAR', ftString,  005);
    FieldDefs.Add('DESCAR', ftString,  255);
    FieldDefs.Add('VALCAR', ftFloat,   000);
    FieldDefs.Add('QTDPAR', ftInteger, 000);
    FieldDefs.Add('VALREC', ftFloat,   000);
    FieldDefs.Add('MARCAD', ftString,  001);

    CreateDataSet;

    IndexFieldNames := 'DESCAR';//ordenar por descricao

    TFloatField(FieldByName('VALCAR')).DisPlayFormat := '#,##0.00';
    TFloatField(FieldByName('VALREC')).DisPlayFormat := '#,##0.00';
  End;

  With objNegociacao.cdsFormasNegociadas Do
  Begin
    First;

    While Not Eof Do
    Begin
      If FieldByName('CODFPG').AsString = '007' Then
      Begin
        FCartoes.Append;
        FCartoes.FieldByName('AUTOINC').AsInteger  := FieldByName('AUTOINC').AsInteger;
        FCartoes.FieldByName('CODCAR').AsString  := FieldByName('CODCAR').AsString;
        FCartoes.FieldByName('DESCAR').AsString  := FieldByName('DESFPG').AsString;
        FCartoes.FieldByName('VALCAR').AsFloat   := FieldByName('VALFPG').AsFloat;
        FCartoes.FieldByName('VALREC').AsFloat   := FieldByName('VALREC').AsFloat;
        FCartoes.FieldByName('QTDPAR').AsInteger := FieldByName('QTDPAR').AsInteger;
        FCartoes.FieldByName('MARCAD').AsString  := 'S';
        FCartoes.Post;
      End;
      Next;
    End;

    First;
  End;

end;

destructor TUnificarCartoesNegociados.Destroy;
begin
  FreeAndNil(FCartoes);
  inherited;
end;

function TUnificarCartoesNegociados.fGetCartaoPrincipal: Integer;
  Var
    intQtdPar: Integer;
begin
  Result := -1;
  intQtdPar := 999;
  FCartoes.First;
  While Not FCartoes.Eof Do
  Begin
    If FCartoes.FieldByName('MARCAD').AsString = 'S' Then
    Begin
      If fRetTipoCartao(FCartoes.FieldByName('CODCAR').AsString) = 'D' Then
      Begin
        Result := FCartoes.FieldByName('AUTOINC').AsInteger;
        Break;
      End
      Else If FCartoes.FieldByName('QTDPAR').AsInteger < intQtdPar Then
      Begin
        Result    := FCartoes.FieldByName('AUTOINC').AsInteger;
        intQtdPar := FCartoes.FieldByName('QTDPAR').AsInteger;
      End;
    End;
    FCartoes.Next;
  End;
  FCartoes.First;
end;

function TUnificarCartoesNegociados.fGetQtdMarcados: Integer;
begin
  Result := 0;
  FCartoes.First;
  While Not FCartoes.Eof Do
  Begin
    If FCartoes.FieldByName('MARCAD').AsString = 'S' Then
      Inc(Result);
    FCartoes.Next;
  End;
  FCartoes.First;
end;

function TUnificarCartoesNegociados.fTemCartaoRecebido(var strCarRec: String): Boolean;
  Var
    LintCarPri: Integer;
begin
  strCarRec := '';
  Result    := False;
  LintCarPri := fGetCartaoPrincipal;

  FCartoes.First;

  While Not FCartoes.Eof Do
  Begin
    If FCartoes.FieldByName('MARCAD').AsString = 'S' Then
    Begin
      If (FCartoes.FieldByName('VALREC').AsFloat > 0) And
         (FCartoes.FieldByName('AUTOINC').AsInteger <> LintCarPri) Then
      Begin
        Result    := True;
        strCarRec := FCartoes.FieldByName('DESCAR').AsString;
        Break;
      End;
    End;
    FCartoes.Next;
  End;

  FCartoes.First;

end;

function TUnificarCartoesNegociados.fUnificarCartoesNegociados: Boolean;
  Var
    strCarRec: String;
    LintCarPri: Integer;
    LintCodCar: Integer;
    fltValCar: Double;
begin
  If fGetQtdMarcados <= 1 Then
  Begin
    pMensagemOk('Devem ser selecionados pelo menos dois cartões pra unificar!');
    Exit(False);
  End;

  If fTemCartaoRecebido(strCarRec) Then
  Begin
    pMensagemOk('Não é possível unificar o cartão "' + strCarRec + '", pois o mesmo já foi recebido!');
    Exit(False);
  End;

  LintCarPri := fGetCartaoPrincipal;

  //Validacao de seguranca, para tratar erros de programa
  If Not FNegociacao.fFormaPagtoSelecionada(LintCarPri) Then
  Begin
    pMensagemOk('Não é possível unificar os cartões, cartão principal não encontrado!');
    Exit(False);
  End;

  If Not fPergunta('Confirma unificação dos cartões selecionados?') Then
    Exit(False);

  FCartoes.First;

  While Not FCartoes.Eof Do
  Begin
    If FCartoes.FieldByName('MARCAD').AsString = 'S' Then
    Begin
      LintCodCar := FCartoes.FieldByName('AUTOINC').AsInteger;
      fltValCar := FCartoes.FieldByName('VALCAR').AsFloat;

      With FNegociacao, cdsFormasNegociadas Do
      Begin
        If LintCodCar <> LintCarPri Then
        Begin
          If fFormaPagtoSelecionada(LintCodCar) Then
          Begin
            pRemoverFormaPagto(False);//Remove o cartao anterior

            If fFormaPagtoSelecionada(LintCarPri) Then//Posiciona no cartao principal
            Begin
              Edit;
              FieldByName('VALFPG').AsFloat  := FieldByName('VALFPG').AsFloat + fltValCar;//Soma o valor do cartao excluido
              FieldByName('FPGREC').AsString := 'N';//Marca como nao recebido (caso estaja sim)
              Post;
            End;
          End;
        End;
      End;

    End;
    FCartoes.Next;
  End;

  FCartoes.First;

  Result := True;
end;

end.
