unit untImpressaoPedidoCompra;

interface

uses
  Classes,
  SysUtils,
  StrUtils,
  Uni,
  untTypesSistema,
  untFuncoesSimples,
  untConfiguraImpressaoPedidoCompra,
  untTLayoutPedidoCompra,
  TypesLayoutPedidoCompra;

Type


  TImprimePedidoCompa = Class
  Private

    blnLibImp,
    blnLibPcm: Boolean;

    FFornecedorUnicoExportacao: Boolean;

    objImpressaoRel: TConfiguraImpressaoPedidoCompra;

    {Procedure pCarregaFilaPedido;

    Function fPedePathArq: Boolean;}

    Procedure pCarregarDadosPedidoExportacao(const strAutPcg: String);

    Function fCarregaDadosPedidoExportacao(const intQtdReg: Integer): Boolean;
  Public

    constructor Create;

    Destructor Destroy; override;

    Function fPodeImprimirPedido(strNumPed, strEspDoc, strCodEmp: String; blnDarMensagemErro: Boolean): Boolean;
    Function fPedeDadosImpressao: Boolean;

    Procedure pImprime(blnCarregarFila: Boolean = True);

    Procedure pPodeAdicionarPedido(strValue: String; Var blnAdd: boolean);

    Procedure pCarregaDadosPedido(strNumPed, strEspDoc, strCodEmp, strAutPcg: String);

    Procedure pImprimePedido(stlListaSelecao: TStringList);

    Procedure pSetFornecedorUnicoExportacao(blnFornecedorUnico: Boolean);
  End;


implementation

uses
  untCfgRel,
  untEntEtiquetas,
  untFuncoesPedido,
  untPedidoCompraTXT,
  untPedidoCompraImpr, untOpcPdfPedidoCompra;

Function TImprimePedidoCompa.fPodeImprimirPedido(strNumPed, strEspDoc, strCodEmp: String; blnDarMensagemErro: Boolean): Boolean;
Begin
  Result := True;

  If (strEspDoc = 'PD')                                 And
     blnLibPcm                                          And
     (Not fPedidoCompraLIberado(strNumPed, strCodEmp))  And
     (Not blnLibImp) Then
  Begin
    Result := False;

    If blnDarMensagemErro Then
      fMensagem('', 'Pedido de Compra ainda não foi liberado (Liberação de Pedidos de Compra)!', ['&O K']);
  End;
End;

Procedure TImprimePedidoCompa.pPodeAdicionarPedido(strValue: String; Var blnAdd: boolean);
Begin
  pCarregaDadosPedido('', '', '', strValue);

  blnAdd := fPodeImprimirPedido(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed,
                               TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc,
                               TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp,
                               True);
End;

procedure TImprimePedidoCompa.pSetFornecedorUnicoExportacao(
  blnFornecedorUnico: Boolean);
begin
  FFornecedorUnicoExportacao := blnFornecedorUnico;
end;

constructor TImprimePedidoCompa.Create;
Begin
  blnLibPcm := fCfgSis('LIBPCM', varBoolean);
  blnLibImp := fCfgSis('LIBIMP', varBoolean);

  FillChar(TfraOpcPdfPedidoCompra.RecOpcaoImpressao, Sizeof(TRecOpcaoImpressao), #0);

  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intQtdVias := 1;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intQtdOrd  := 1;
  FFornecedorUnicoExportacao := False;

  objImpressaoRel := TConfiguraImpressaoPedidoCompra.Create(Nil, True);
End;

Destructor TImprimePedidoCompa.Destroy;
Begin

  FreeAndNil(objImpressaoRel);
End;

Function TImprimePedidoCompa.fCarregaDadosPedidoExportacao(const intQtdReg: Integer): Boolean;
begin
  Result := False;

  If (intQtdReg <= 1) Then
    Exit;

  If Not FFornecedorUnicoExportacao Then
    Exit;

  Result := True;
end;

Function TImprimePedidoCompa.fPedeDadosImpressao: Boolean;
Begin
  Try
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.IntOpcao  := 0;
//    recOpcoes.blnResAOb := False;

    {*************************************************************************}
    {* CASO USE TINTA DE MAQUINA, NÃO PERGUNTA SE EXPORTA PARA SUVINIL/CORAL *}
    {* SENÃO VAI PARA A IMPRESSORA DIRETO.                                   *}
    {**********************************************************************LU*}
    pCriarFormularios(TfrmPedidoCompraImpr, frmPedidoCompraImpr);
    If (fCfgSis('USATMQ') = 'N') Then
    Begin
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao := 1;
    End;


    frmPedidoCompraImpr.objImpressaoRel := objImpressaoRel;

    frmPedidoCompraImpr.ShowModal;


    Result := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImprime;
  Except
    On E: Exception Do
    Begin
      Result := False;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImprime := False;
      pMensagensErro(E.Message, '[TImprimePedidoCompa.fPedeDadosImpressao]');
    End;
  End;

  pFreeAndNil(frmPedidoCompraImpr);
End;
{
Procedure TImprimePedidoCompa.pCarregaFilaPedido;
  Var
    qryCfgRel: TUniQuery;
begin
  qryCfgRel := fCriaQuery;
  pCarregaConfImpr(qryCfgRel, 'frmPedidoDeCompra');
  fPreImpressao(qryCfgRel, recOpcoes.strNomeFila, recOpcoes.strTipImp, False);
  FreeAndNil(qryCfgRel);
End;
}
Procedure TImprimePedidoCompa.pImprime(blnCarregarFila: Boolean = True);
Begin
  With TfraOpcPdfPedidoCompra.RecOpcaoImpressao Do
  Begin

    If blnImprime Then
    Begin
      objImpressaoRel.fImprimeRelatorio(strEspDoc, strCodEmp, strNumPed);

      If Not objImpressaoRel.blnImpressaoRel Then
        pImprimirPedido(TfraOpcPdfPedidoCompra.RecOpcaoImpressao,
                        strNumPed,
                        strEspDoc,
                        strCodEmp,
                        strPathArq,
                        strNomeFila,
                        strTipImp,
                        True,   //blnReimpr: Boolean = False;
                        strCondPagBosh,
                        False,  //blnEsconderMensagem: boolean = False;
                        True,  //blnVeSePodeImprimir: Boolean = True;
                        blnCarregarFila,
                        blnExcRes); //blnCarregarFila: Boolean = True;

    End;
    if TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao = 13 then
      exit;

    if TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao = 20 then
      exit;

    If (blnImpOrd) Then
      pImprimirOrdemCarregamento(strNumPed, strEspDoc, strCodEmp, intQtdOrd, False, blnOrdDig);

    If fCfgSis('PEDETI', varBoolean) Then
      TfrmEntEtiquetas.pImpEtiPedidoDeCompra(strNumPed, strEspDoc, strCodFor);


  End; {With recOpcoes Do}
End;

Procedure TImprimePedidoCompa.pCarregaDadosPedido(strNumPed, strEspDoc, strCodEmp, strAutPcg: String);
  Var
    qryPedido: TUniQuery;
Begin
  qryPedido := fCriaQuery(Nil);

  qryPedido.SQL.Text := ' SELECT ' +
                        '   PCG_CODEMP, ' +
                        '   PCG_ESPDOC, ' +
                        '   PCG_NUMPED, ' +
                        '   PCG_EMPDES, ' +
                        '   PCG_CODFOR, ' +
                        '   PCG_CONPAG  ' +
                        ' FROM            ' +
                        '   PCMGER        ' +
                        '  WHERE          ';

                        If fEmptyStr(strAutPcg) Then
                        Begin
                         qryPedido.SQL.Text := qryPedido.SQL.Text +
                                               ' PCG_NUMPED = :NUMPED AND PCG_ESPDOC = :ESPDOC AND PCG_CODEMP = :CODEMP ';

                         qryPedido.ParamByName('NUMPED').AsString := strNumPed;
                         qryPedido.ParamByName('CODEMP').AsString := strCodEmp;
                         qryPedido.ParamByName('ESPDOC').AsString := strEspDoc;
                        End Else
                        Begin
                          qryPedido.SQL.Text := qryPedido.SQL.Text + ' AUTOINCREM = :AUTINC ';

                          qryPedido.ParamByName('AUTINC').AsString := strAutPcg;
                         End;

    qryPedido.Open;

    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes      := qryPedido.FieldByName('PCG_EMPDES').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor      := qryPedido.FieldByName('PCG_CODFOR').AsString;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCondPagBosh := qryPedido.FieldByName('PCG_CONPAG').AsString;

    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed      := qryPedido.FieldByName('PCG_NUMPED').AsString;;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc      := qryPedido.FieldByName('PCG_ESPDOC').AsString;;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp      := qryPedido.FieldByName('PCG_CODEMP').AsString;;

    If fEmptyStr(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes) Then
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes := VS_strCodEmp;

  FreeAndNil(qryPedido);
End;

procedure TImprimePedidoCompa.pCarregarDadosPedidoExportacao(
  const strAutPcg: String);
  Var
    qryPedido: TUniQuery;
Begin
  qryPedido := fCriaQuery(Nil);

  Try
    qryPedido.SQL.Text := ' SELECT ' +
                          '   PCG_CODFOR    ' +
                          ' FROM            ' +
                          '   PCMGER        ' +
                          '  WHERE          ';

    qryPedido.SQL.Text := qryPedido.SQL.Text + ' AUTOINCREM = :AUTINC ';

    qryPedido.ParamByName('AUTINC').AsString := strAutPcg;

    qryPedido.Open;

    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor := qryPedido.FieldByName('PCG_CODFOR').AsString;
  Finally
    FreeAndNil(qryPedido);
  End;
end;

{
Function TImprimePedidoCompa.fPedePathArq: Boolean;
Begin
  pCriarFormularios(TfrmPedidoCompraTXT, frmPedidoCompraTXT);
  frmPedidoCompraTXT.intOpcao := 0;
  frmPedidoCompraTXT.ShowModal;
  recOpcoes.strPathArq := frmPedidoCompraTXT.strPathArq;
  Result := frmPedidoCompraTXT.blnConfirma;
  FreeAndNil(frmPedidoCompraTXT);
End;
}
Procedure TImprimePedidoCompa.pImprimePedido(stlListaSelecao: TStringList);
  Var
    intContador: Integer;
    strNomArqs: String;
    blnCarregarFila: Boolean;
Begin
  blnCarregarFila := True;

  If stlListaSelecao.Count = 0 Then
    Exit;

  FillChar(TfraOpcPdfPedidoCompra.RecOpcaoImpressao, Sizeof(TRecOpcaoImpressao), #0);

  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intQtdVias := 1;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intQtdOrd  := 1;

  strNomArqs := '';

  If stlListaSelecao.Count = 1 Then
  Begin
    pCarregaDadosPedido('', '', '', stlListaSelecao[0]);
  End;

  If fCarregaDadosPedidoExportacao(stlListaSelecao.Count) Then
  Begin
    pCarregarDadosPedidoExportacao(stlListaSelecao[0]);
  End;

  If Not fPedeDadosImpressao Then
    Exit;
  {
  Case recOpcoes.intOpcao Of
    1, 5:   pCarregaFilaPedido;
    10, 12: If Not fPedePathArq Then
              Exit;
  End;
  }
  For intContador := 0 To stlListaSelecao.Count -1 Do
  Begin

    If stlListaSelecao.Count > 1 Then
    Begin
      pCarregaDadosPedido('', '', '', stlListaSelecao[intContador]);

      If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao = 11 Then
        TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCondPagBosh := fCampoTabela('CND_CODCND', 'BOSCH_CADCND', ['CND_AUTCOM'], [TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCondPagBosh]);
    End;

    pImprime(blnCarregarFila);

    Case TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOpcao Of
      10, 12: If fEmptyStr(strNomArqs) Then
                strNomArqs := TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNomArq
              Else
                strNomArqs := strNomArqs + ', ' + TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNomArq;
    End;

    blnCarregarFila := False;
  End;

  If Not fEmptyStr(strNomArqs) Then
    pMensagemOk('Arquivos gerados em ' + TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strPathArq + ': ' + strNomArqs);
End;

end.
