unit untTLayoutPedidoCompra;

interface
  uses Uni, Vcl.StdCtrls, untFuncoesSimples, SysUtils, untEditorFastImpressao,
  Classes,
  untTypesSistema, TypesLayoutPedidoCompra, Data.DB;



  Type


  IImpressaoPedidoLayout = Interface
  ['{0EF678BA-2667-498F-BC30-CDC631F056BB}']
    function fGerarPDF(AForceLocalPDF: String= ''): IImpressaoPedidoLayout;
    function fNumPed(strNumPed: String): IImpressaoPedidoLayout;
    function fCodEmp(strCodEmp: String): IImpressaoPedidoLayout;
    function fEspDoc(strEspDoc: String): IImpressaoPedidoLayout;
    function fVisPDF(blnVisPDF: Boolean): IImpressaoPedidoLayout;
    function fMltCom(blnMltCom: Boolean): IImpressaoPedidoLayout;
    function fQtdPen(blnQtdPen: Boolean): IImpressaoPedidoLayout;
    function fZonaFranca(blnZonFra: Boolean): IImpressaoPedidoLayout;
    function fCodFor(strCodFor: String): IImpressaoPedidoLayout;
    function fCodLay(strCodLay: String): IImpressaoPedidoLayout;
    function fDataDeVencimento(ADtaVen: String): IImpressaoPedidoLayout;
    function fVaiGerarAquivoPDF(blnGerPDF: Boolean): IImpressaoPedidoLayout;
    function fCaminhoPDF: String;
    function fNomImp(strNomImp: String): IImpressaoPedidoLayout;
    function fTipImp(strTipImp: String): IImpressaoPedidoLayout;
    function fSetNaoSelImp(AValue: Boolean): IImpressaoPedidoLayout;
    function fSetSemProgresso(AValue: Boolean): IImpressaoPedidoLayout;
  End;



  TImpressaoPedidoLayout = Class(TInterfacedObject, IImpressaoPedidoLayout)
  private
    FstrNumPed: String;
    FstrCodEmp: String;
    FstrEspDoc: String;
    FblnMltCom: Boolean;
    FstrCaminhoPDF: String;
    FblnVisPDF: Boolean;
    FblnQtdPen: Boolean;
    FblnZonFra: Boolean;
    FstrCodFor: String;
    FstrCodLay: String;
    FblnGerPDF: Boolean;
    FStrNomImp: String;
    FStrTipImp: String;
    FStrDtaVen: String;
    FNaoSelImp: Boolean;
    FSemProgresso: Boolean;
  public
    constructor Create;
    function fGerarPDF(AForceLocalPDF: String = ''): IImpressaoPedidoLayout;
    function fNumPed(strNumPed: String): IImpressaoPedidoLayout;
    function fCodEmp(strCodEmp: String): IImpressaoPedidoLayout;
    function fEspDoc(strEspDoc: String): IImpressaoPedidoLayout;
    function fVisPDF(blnVisPDF: Boolean): IImpressaoPedidoLayout;
    function fMltCom(blnMltCom: Boolean): IImpressaoPedidoLayout;
    function fQtdPen(blnQtdPen: Boolean): IImpressaoPedidoLayout;
    function fZonaFranca(blnZonFra: Boolean): IImpressaoPedidoLayout;
    function fCodFor(strCodFor: String): IImpressaoPedidoLayout;
    function fCodLay(strCodLay: String): IImpressaoPedidoLayout;
    function fVaiGerarAquivoPDF(blnGerPDF: Boolean): IImpressaoPedidoLayout;
    function fNomImp(strNomImp: String): IImpressaoPedidoLayout;
    function fTipImp(strTipImp: String): IImpressaoPedidoLayout;
    function fDataDeVencimento(ADtaVen: String): IImpressaoPedidoLayout;
    function fSetNaoSelImp(AValue: Boolean): IImpressaoPedidoLayout;
    function fSetSemProgresso(AValue: Boolean): IImpressaoPedidoLayout;

    function fCaminhoPDF: String;
    class function fNovo: IImpressaoPedidoLayout;
  End;

  TLayoutPedidoCompra = Class // Class(TInterfacedObject, ILayout)
  private
    FstrCodLay: String;
    FstrNomLay: String;
    FblnGerPDF: Boolean;
  public
    function fCodLay(strCodLay: String): TLayoutPedidoCompra;overload;
    function fNomLay(strNomLay: String): TLayoutPedidoCompra;overload;
    function fCodLay: String;overload;
    function fNomLay: String;overload;
    function fGerPDF(blnGerPDF: Boolean): TLayoutPedidoCompra;overload;
    function fGerPDF: Boolean;overload;
    function AsObject: TObject;
    class function Novo: TLayoutPedidoCompra;
    class procedure pCarregarLayout(cbxLayout: TComboBox; blnSomentePDF: Boolean);
    class procedure pSetLayout(cbxLayout: TComboBox; strCodLay: String);

  End;

implementation


{ TImpressaoPedidoLayout }

constructor TImpressaoPedidoLayout.Create;
begin
  FblnVisPDF := False;
  FNaoSelImp := False;
  FSemProgresso := False;
end;

function TImpressaoPedidoLayout.fCaminhoPDF: String;
begin
  Result := FstrCaminhoPDF;
end;

function TImpressaoPedidoLayout.fCodFor(
  strCodFor: String): IImpressaoPedidoLayout;
begin
  Result := Self;
  FstrCodFor := strCodFor;
end;

function TImpressaoPedidoLayout.fCodLay(
  strCodLay: String): IImpressaoPedidoLayout;
begin
  Result := Self;
  FstrCodLay := strCodLay;
end;

function TImpressaoPedidoLayout.fDataDeVencimento(
  ADtaVen: String): IImpressaoPedidoLayout;
begin
  Result := Self;
  FStrDtaVen := ADtaVen;
end;

function TImpressaoPedidoLayout.fVaiGerarAquivoPDF(
  blnGerPDF: Boolean): IImpressaoPedidoLayout;
begin
  Result := Self;
  FblnGerPDF := blnGerPDF;
end;


function TImpressaoPedidoLayout.fCodEmp(strCodEmp: String): IImpressaoPedidoLayout;
begin
  Result := Self;
  FstrCodEmp := strCodEmp;
end;

function TImpressaoPedidoLayout.fEspDoc(strEspDoc: String): IImpressaoPedidoLayout;
begin
  Result := Self;
  FstrEspDoc := strEspDoc;
end;

function TImpressaoPedidoLayout.fGerarPDF(AForceLocalPDF: String= ''): IImpressaoPedidoLayout;
Var
  objImpressao: TEditorFastImpressao;
Begin
  Result := Self;
  objImpressao := TEditorFastImpressao.Create(Nil);
  try
    With objImpressao Do
    Begin
      recDocume.strCodLay :=  FstrCodLay;
      recDocume.strNumDoc := FstrNumPed;// cdsConsulta.FieldByName('PCG_NUMPED').AsString;
      recDocume.strCodIte := '';
      recDocume.strCodCli := FstrCodFor;
      recDocume.strCodEmp := FstrCodEmp; //cdsConsulta.FieldByName('PCG_CODEMP').AsString;
      recDocume.strEspDoc := FstrEspDOC; //cdsConsulta.FieldByName('PCG_ESPDOC').AsString;
      tpeTipoEtiqueta     := tpePedidoCompra;
      recDocume.intQtdImp := 1;
      recDocume.blnReimpr := False;
      recDocume.blnDocCan := False;
      recDocume.blnQtdOri := False;
      recDocume.blnConfir := False;
      recDocume.blnDocSep := False;
      recDocume.blnImpExpedicao := False;
      recDocume.blnFilEmp := False;
      recDocume.blnImpFil := False;
      recDocume.blnSepFut := False;
      recDocume.blnEnt_CD := False;
      recDocume.blnSimples               := False;
      recDocume.blnSempreEntr            := False;
      recDocume.blnRequisicao            := False;
      recDocume.blnLocFisEmpEmi          := False;
      recDocume.blnAgruparItensSeparacao := False;
      recDocume.blnVisPdf := FblnVisPDF;
      recDocume.strSaida  := 'P';
      recDocume.strPasPdf := AForceLocalPDF;
      recDocume.blnNaoSelImp := FNaoSelImp;
      recDocume.blnSemProgesso := FSemProgresso;

      recDocume.blnZonaFranca  := FblnZonFra;
      recDocume.blnMltCom  := FblnMltCom;
      recDocume.blnQtdPen  := FblnQtdPen;
      recDocume.strNomImp := FstrNomImp;
      recDocume.strTipImp := FstrTipImp;
      recDocume.strDtaVen := FStrDtaVen;

      If FblnGerPDF Then
        fImprimeDocumento(tpaPDF, '', '')
      Else
        fImprimeDocumento(tpaNormal, '', '');
      FstrCaminhoPDF := strArqPDF;
    End;

  Finally
    FreeAndNil(objImpressao);
  End;
end;

function TImpressaoPedidoLayout.fNomImp(strNomImp: String): IImpressaoPedidoLayout;
begin
  Result := Self;
  FstrNomImp := strNomImp;
end;

class function TImpressaoPedidoLayout.fNovo: IImpressaoPedidoLayout;
begin
  Result := TImpressaoPedidoLayout.Create;
end;

function TImpressaoPedidoLayout.fNumPed(strNumPed: String): IImpressaoPedidoLayout;
begin
  Result := Self;
  FstrNumPed := strNumPed;
end;

function TImpressaoPedidoLayout.fVisPDF(blnVisPDF: Boolean): IImpressaoPedidoLayout;
begin
  Result := Self;
  FblnVisPDF := blnVisPDF;
end;

function TImpressaoPedidoLayout.fZonaFranca(blnZonFra: Boolean): IImpressaoPedidoLayout;
begin
  Result := Self;
  FblnZonFra := blnZonFra;
end;

function TImpressaoPedidoLayout.fMltCom(blnMltCom: Boolean): IImpressaoPedidoLayout;
begin
  Result := Self;
  FblnMltCom := blnMltCom;
end;

function TImpressaoPedidoLayout.fQtdPen(blnQtdPen: Boolean): IImpressaoPedidoLayout;
Begin
  Result := Self;
  FblnQtdPen := blnQtdPen;
End;



function TImpressaoPedidoLayout.fSetNaoSelImp(
  AValue: Boolean): IImpressaoPedidoLayout;
begin
  FNaoSelImp := AValue;
  Result := Self;
end;

function TImpressaoPedidoLayout.fSetSemProgresso(AValue: Boolean): IImpressaoPedidoLayout;
Begin
  FSemProgresso := AValue;
  Result := Self;
End;

function TImpressaoPedidoLayout.fTipImp(strTipImp: String): IImpressaoPedidoLayout;
begin
  Result := Self;
  FstrTipImp := strTipImp;

end;

{ TLayout }

function TLayoutPedidoCompra.fCodLay(strCodLay: String): TLayoutPedidoCompra;
begin
  Result := Self;
  FstrCodLay := strCodLay;
end;

function TLayoutPedidoCompra.AsObject: TObject;
begin
  Result := TObject(Self);
end;

function TLayoutPedidoCompra.fCodLay: String;
begin
  Result := FStrCodLay;
end;

function TLayoutPedidoCompra.fNomLay(strNomLay: String): TLayoutPedidoCompra;
begin
  Result := Self;
  FstrNomLay := strNomLay;
end;

function TLayoutPedidoCompra.fNomLay: String;
begin
  Result := FStrNomLay;
end;

function TLayoutPedidoCompra.fGerPDF(blnGerPDF: Boolean): TLayoutPedidoCompra;
begin
  Result := Self;
  FblnGerPDF := blnGerPDF;
end;

function TLayoutPedidoCompra.fGerPDF: Boolean;
begin
  Result := FblnGerPDF;
end;

class function TLayoutPedidoCompra.Novo: TLayoutPedidoCompra;
begin
  Result := TLayoutPedidoCompra.Create;
end;

class procedure TLayoutPedidoCompra.pCarregarLayout(cbxLayout: TComboBox; blnSomentePDF: Boolean);
Var
  objQuery: TUniQuery;
begin
  objQuery := fCriaQuery;
  Try
    objQuery.SQL.Add(' SELECT * FROM LAYETI        ');
    objQuery.SQL.Add('  WHERE LAY_CODEMP = :CODEMP ');
    objQuery.SQL.Add('    AND LAY_TIPLAY = :TIPLAY ');
    objQuery.SQL.Add('    AND LAY_PADRAO = "S"     ');
    objQuery.SQL.Add('   ORDER BY LAY_CTRSEQ, LAY_PADRAO, LAY_DESCRI ');
    objQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    objQuery.ParamByName('TIPLAY').AsInteger := 214;
    objQuery.Open;

    cbxLayout.Items.Clear;
    While Not objQuery.Eof Do
    Begin
      cbxLayout.Items.AddObject(objQuery.FieldByName('LAY_DESCRI').AsString,
          TLayoutPedidoCompra
            .Novo
            .fCodLay(objQuery.FieldByName('LAY_CODLAY').AsString)
            .fNomLay(objQuery.FieldByName('LAY_DESCRI').AsString)
            .fGerPDF(IIF(blnSomentePDF, True, (objQuery.FieldByName('LAY_GERPDF').AsString = 'S')))
            .AsObject
            );
      objQuery.Next;
    End;
    cbxLayout.Items.AddObject('PADRÃO AUTCOM (SEM EDITOR)', nil);
    cbxLayout.ItemIndex := 0;
  Finally
    FreeAndNil(objQuery);
  End;

End;



class procedure TLayoutPedidoCompra.pSetLayout(cbxLayout: TComboBox;
  strCodLay: String);
Var
  objQuery: TUniQuery;
  strDescricaoLayout: String;
begin
  objQuery := fCriaQuery;
  Try
    objQuery.SQL.Add(' SELECT * FROM LAYETI        ');
    objQuery.SQL.Add('  WHERE LAY_CODEMP = :CODEMP ');
    objQuery.SQL.Add('    AND LAY_TIPLAY = :TIPLAY ');
    objQuery.SQL.Add('    AND LAY_PADRAO = "S"     ');
    objQuery.SQL.Add('    AND LAY_CODLAY = :CODLAY ');
    objQuery.SQL.Add('   ORDER BY LAY_CTRSEQ, LAY_PADRAO, LAY_DESCRI ');
    objQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    objQuery.ParamByName('TIPLAY').AsInteger := 214;
    objQuery.ParamByName('CODLAY').AsString := strCodLay;
    objQuery.Open;

    If Not objQuery.IsEmpty Then
    Begin
      strDescricaoLayout := objQuery.FieldByName('LAY_DESCRI').AsString;
      if cbxLayout.Items.IndexOf(strDescricaoLayout) > 0 Then
        cbxLayout.ItemIndex := cbxLayout.Items.IndexOf(strDescricaoLayout);
    End;

  Finally
    FreeAndNil(objQuery);
  End;
end;

end.

