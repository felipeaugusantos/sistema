unit untTDisparaEnvioEmailPedidoDeCompraAutomatico;

interface
  uses Windows, Forms,sysUtils, classes, untDisparaEmailAutEnt, untPnlDadosPedCompra, untTypesSistema, Uni,
    untOpcoesExcelPedCompra, untTLayoutPedidoCompra, TypesLayoutPedidoCompra;

  Type


    TDisparaEnvioEmailPedidoDeCompraAutomatico =  Class
    private
      FOperador: String;
      FCodigoFornedor: String;
      FEspecieDocumento: String;
      FGerarPDF: Boolean;
      FGerarXLS: Boolean;
      FArrPedidosCompra: TArrPedidosCompra;
      strArquivos: string;
      FoptCodigo: String;
      FRecOpcaoImpressao: TRecOpcaoImpressao;
    protected
      procedure pProcessaDisparo;
      function fMontaPedidos(APedidos: string): TArrPedidosCompra;
      procedure pGeraPDF(ANumped, ACodemp: string);
      function fDefineEmpresaDestinoPedidoCompra(AstrNumPed, AstrCodemp, AstrCodFornecedor, AstrEspecieDocumento: String): String;
    public
      function fEspDoc(strEspDoc: String): TDisparaEnvioEmailPedidoDeCompraAutomatico;
      function fCodigo(optCodigo: String): TDisparaEnvioEmailPedidoDeCompraAutomatico;
      function fGeraPDFEmailAutomatico(ANumped: string; ACodemp: String; ACodFor: string; ACodEmpDes: String; blnSemProgresso: Boolean = False): String;
      function SetRecOpcaoImpressa(AVAlue: TRecOpcaoImpressao): TDisparaEnvioEmailPedidoDeCompraAutomatico;
      class procedure pDisparaEmailAutomatico;
  End;

implementation

uses
  untTLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD, untFuncoesSimples,
  untOpcPdfPedidoCompra;

{ TDisparaEnvioEmailPedidoDeCompraAutomatico }

function TDisparaEnvioEmailPedidoDeCompraAutomatico.fMontaPedidos(
  APedidos: string): TArrPedidosCompra;
  var Pedidos: TStringList;
      i: integer;
      posSeparador: integer;
begin
  Pedidos := TStringList.Create;
  Try
    Pedidos.Delimiter := '|';
    Pedidos.StrictDelimiter := True;
    Pedidos.DelimitedText:= APedidos;
    SetLength(Result, Pedidos.Count);
    For i := 0 To  Pedidos.Count-1 do
    Begin
      posSeparador := Pos(';', Pedidos[i]);
      Result[i].FNumeroPedidoCompra := Copy(Pedidos[i], 0, posSeparador -1);
      Result[i].FCodigoEmpresa := Copy(Pedidos[i], posSeparador + 1, Length(Pedidos[i]));
      Result[i].FCodigoEmpresaDestino := fDefineEmpresaDestinoPedidoCompra(Result[i].FNumeroPedidoCompra,Result[i].FCodigoEmpresa, FCodigoFornedor, FEspecieDocumento);
    End;
  Finally
    FreeAndNil(Pedidos);
  End;
end;

class procedure TDisparaEnvioEmailPedidoDeCompraAutomatico.pDisparaEmailAutomatico;
var DisparaEnvioEmailPedidoDeCompraAutomatico: TDisparaEnvioEmailPedidoDeCompraAutomatico;
begin
  DisparaEnvioEmailPedidoDeCompraAutomatico := TDisparaEnvioEmailPedidoDeCompraAutomatico.Create;
  Try
    DisparaEnvioEmailPedidoDeCompraAutomatico.pProcessaDisparo;
  Finally
    FreeAndNil(DisparaEnvioEmailPedidoDeCompraAutomatico);
  End;
end;

procedure TDisparaEnvioEmailPedidoDeCompraAutomatico.pGeraPDF(ANumped, ACodemp: string);
var PedidosCompra: TPedidosCompra;
begin
  strArquivos := '';
  If FGerarPDF Then
  Begin
    For PedidosCompra in FArrPedidosCompra do
    Begin
      If PedidosCompra.FNumeroPedidoCompra = ANumped Then
        If PedidosCompra.FCodigoEmpresa = ACodemp Then
        strArquivos := strArquivos + fGeraPDFEmailAutomatico(PedidosCompra.FNumeroPedidoCompra, PedidosCompra.FCodigoEmpresa, FCodigoFornedor, PedidosCompra.FCodigoEmpresaDestino) + ';';
    End;
  End;
end;


function TDisparaEnvioEmailPedidoDeCompraAutomatico.fCodigo(
  optCodigo: String): TDisparaEnvioEmailPedidoDeCompraAutomatico;
begin
  Result := Self;
  FoptCodigo := optCodigo;
end;

function TDisparaEnvioEmailPedidoDeCompraAutomatico.fDefineEmpresaDestinoPedidoCompra(
  AstrNumPed, AstrCodemp, AstrCodFornecedor, AstrEspecieDocumento: String): String;
begin
  Result := fCampoTabela('IFNULL(PCG_EMPDES,"")', 'PCMGER', ['PCG_NUMPED', 'PCG_CODEMP','PCG_CODFOR','PCG_ESPDOC'], [AstrNumPed, AstrCodemp, AstrCodFornecedor, AstrEspecieDocumento ]);
end;

function TDisparaEnvioEmailPedidoDeCompraAutomatico.fEspDoc(
  strEspDoc: String): TDisparaEnvioEmailPedidoDeCompraAutomatico;
begin
  Result := Self;
  FEspecieDocumento := strEspDoc;
end;

function TDisparaEnvioEmailPedidoDeCompraAutomatico.fGeraPDFEmailAutomatico(ANumPed: string; ACodEmp: String; ACodFor: string; ACodEmpDes: String; blnSemProgresso: Boolean = False): String;
var strDirGravacao,
    strNomeArquivo,
    strExecutavel: String;
    objConfig : TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD;
    strDtaVen: String;
    strDtaFat,
    strCndPag: String;
    dtaDtaAux: TDate;
    arrDuplicata: TarrDuplicata;
    intQtdPar: Integer;
    curVTotal: Currency;
    intContador: Integer;
    qryCons: TUniQuery;
    strTipExp: String;
Begin
  strExecutavel := ExtractFilePath(Application.ExeName);
  If (FEspecieDocumento  = 'PD') Then
  Begin
    {*******************************************}
    {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
    {****************************************LU*}
    If Not DirectoryExists(strExecutavel + 'PedidoCompra') Then
    Begin
      CreateDir(strExecutavel + 'PedidoCompra');
    End;
    strDirGravacao := strExecutavel + 'PedidoCompra';
  End
  Else
  Begin
    If Not DirectoryExists(strExecutavel + 'OrcamentoCompra') Then
    Begin
      CreateDir(strExecutavel + 'OrcamentoCompra');
    End;
    strDirGravacao := strExecutavel + 'OrcamentoCompra';
  End;

  If (FEspecieDocumento  = 'PD') Then
    strNomeArquivo := strDirGravacao + '\PD_' + ANumPed+ '_AUT.xls'
  Else
    strNomeArquivo := strDirGravacao + '\OR_' + ANumPed + '_AUT.xls';

  If FoptCodigo.IsEmpty Then
    objConfig := TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.Create(fMontaChaveEnvioAutomaticoEmail(opcIncluscaoEmail.fGetCode, VS_StrCodEmp))
  Else
    objConfig := TLeConfiguracaoEmaiAutomaticoPedidoDeCompraPFD.Create(fMontaChaveEnvioAutomaticoEmail(FoptCodigo, VS_StrCodEmp));

  If (Not objConfig.blnTemCadInt) And (FRecOpcaoImpressao.strOrigemPedido = 'S') then
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao := FRecOpcaoImpressao;

  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpCompleto;
  case objConfig.rdgQuantidade of
    0: TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpCompleto;
    1: TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpPendente;
    2: TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte := tqpNaoExibir;
  End;

  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpDtaVen :=  objConfig.chkImpVen;
  strTipExp := objConfig.edtTipExp;
  If FGerarXLS Then
    strTipExp := 'E';

  If (objConfig.edtCodLay <> '') And
    (strTipExp <> 'E') Then
  begin
    strDtaVen := '';
    qryCons := fCriaQuery;
    Try
      qryCons.SQL.Add('SELECT PCG_DTAFAT, PCG_CONPAG ');
      qryCons.SQL.Add('  FROM PCMGER ');
      qryCons.SQL.Add(' WHERE PCG_NUMPED = "'+ANumPed+'"');
      qryCons.SQL.Add('   AND PCG_CODEMP = "'+ACodEmp+'"');
      qryCons.SQL.Add('   AND PCG_ESPDOC = "'+FEspecieDocumento+'"');
      qryCons.SQL.Add('   AND PCG_NUMCTN = 0');
      qryCons.Open;
      strDtaFat := qryCons.FieldByName('PCG_DTAFAT').AsString;
      strCndPag := qryCons.FieldByName('PCG_CONPAG').AsString;
    Finally
      FreeAndNil(qryCons)
    End;

    If strDtaFat <> '' Then
    Begin
      pZeraDigDuplic(arrDuplicata);
      If VS_Date > StrToDate(strDtaFat) Then
        dtaDtaAux := VS_Date
      Else
        dtaDtaAux := StrToDate(strDtaFat);

      fDigDuplicSemTela(arrDuplicata,
                        intQtdPar,
                        curVTotal,
                        strCndPag,
                        0,
                        0,
                        False,
                        False,
                        dtaDtaAux,
                        False);

      For intContador := 0 To Length(arrDuplicata)-1 Do
      Begin
        If Not fEmptyStr(arrDuplicata[intContador].dtaDtaVen) Then
        Begin
          If (intContador = 0) Then
            strDtaVen := arrDuplicata[intContador].dtaDtaVen
          Else
            strDtaVen := strDtaVen + ' / '+ arrDuplicata[intContador].dtaDtaVen;
        End;
      End;
    End;

    Result := TImpressaoPedidoLayout
              .fNovo
              .fCodFor(ACodFor)
              .fCodEmp(ACodEmp)
              .fNumPed(ANumPed)
              .fEspDoc(FEspecieDocumento)
              .fDataDeVencimento(strDtaVen)
              .fVisPDF(False)
              .fQtdPen(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.tipQtdIte = tqpPendente)
              .fZonaFranca(fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')))
              .fMltCom(objConfig.chkMltCmp)
              .fCodLay(objConfig.edtCodLay)
              .fSetNaoSelImp(True)
              .fVaiGerarAquivoPDF(True)
              .fSetSemProgresso(blnSemProgresso)
              .fGerarPDF
              .fCaminhoPDF;
  end
  Else
  begin
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao := FRecOpcaoImpressao;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strNumPed := ANumPed;
    TfraOpcPdfPedidoCompra.pCarregaSelecaoExcel(False);
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodEmp :=  ACodEmp;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEspDoc := FEspecieDocumento;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodFor := ACodFor;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strEmpDes := ACodEmpDes;
    If objConfig.blnTemCadInt or ((not objConfig.blnTemCadInt) and (FRecOpcaoImpressao.strOrigemPedido <> 'S')) Then
    begin
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnMltCmp :=  objConfig.chkMltCmp;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strCodLay :=  objConfig.edtCodLay;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.chrOrdDig :=  objConfig.gbOrdem;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.intOrient :=  objConfig.rdgOrientacao;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpObs :=  objConfig.chkImpObs;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnSemPre :=  Not objConfig.chkPreco;

      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnComMar :=  objConfig.chkMarca;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodFab :=  objConfig.chkCodFab;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnLocFis :=  objConfig.chkLocFis;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnCodBar :=  objConfig.chkCodbarras;
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.blnImpRef :=  objConfig.ChkImpReferencia;
    end;
    TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strTipExp := 'XLS';
    If strTipExp <> 'E' Then
      TfraOpcPdfPedidoCompra.RecOpcaoImpressao.strTipExp := 'PDF';

    Result :=  TGeraEmail.fGeraEmail(TfraOpcPdfPedidoCompra.RecOpcaoImpressao,
                                   ANumPed,
                                   FEspecieDocumento,
                                   ACodEmpDes,
                                   ACodEmp,
                                   fCfgSis('DARROR', varBoolean),
                                   strNomeArquivo,
                                   False,
                                   nil,
                                   '',
                                   '',
                                   True);
    If strTipExp = 'E' Then
      Result := strDirGravacao + Result;

  End;
End;


procedure TDisparaEnvioEmailPedidoDeCompraAutomatico.pProcessaDisparo;
var PedidosCompra: TPedidosCompra;
    lStrLoginUsuarioLogado: String;
begin
  FOperador := ParamStr(2);
  lStrLoginUsuarioLogado := StrLoginUsuarioLogado;
  try
    strLoginUsuarioLogado := FOperador;
    FGerarPDF := ParamStr(3) = 'S';
    FGerarXLS := ParamStr(4) = 'S';
    FCodigoFornedor := ParamStr(5);
    FEspecieDocumento := ParamStr(6);
    FArrPedidosCompra := fMontaPedidos(ParamStr(7));
    For PedidosCompra in FArrPedidosCompra do
    Begin
      pGeraPDF(PedidosCompra.FNumeroPedidoCompra, PedidosCompra.FCodigoEmpresa);
      TEmaAutEnt.pDispatchAutomaticEmailsPedidoCompra(FOperador, FCodigoFornedor, FEspecieDocumento, PedidosCompra.FNumeroPedidoCompra, PedidosCompra.FCodigoEmpresa, strArquivos, True);
    End;
  finally
    StrLoginUsuarioLogado := lStrLoginUsuarioLogado;
  end;

end;

function TDisparaEnvioEmailPedidoDeCompraAutomatico.SetRecOpcaoImpressa(AVAlue: TRecOpcaoImpressao): TDisparaEnvioEmailPedidoDeCompraAutomatico;
begin
  FRecOpcaoImpressao := AVAlue;
  Result := Self;

End;
      

end.
