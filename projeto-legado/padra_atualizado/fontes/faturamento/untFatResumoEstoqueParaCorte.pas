unit untFatResumoEstoqueParaCorte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, DB, UniClientDataSet, untFuncFat, untFuncoesSimples, BitBtnLockedIncrem,
  Datasnap.DBClient, frxClass, frxExportCSVTestabilidade, System.UITypes, untLiberacao;

type
  TfrmFatResumoEstoqueParaCorte = class(TfrmPai)
    dbgItens: TDBGridCitel;
    pnlRodape: TPanel;
    lblTotImp: TLabel;
    edtTotImp: TEditFocus;
    Label1: TLabel;
    edtTotSemEst: TEditFocus;
    edtTotComEst: TEditFocus;
    Label2: TLabel;
    btnConfirma: TBitBtnLocked;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensSALDOS: TFloatField;
    cdsItensAUTINC: TIntegerField;
    cdsItensTEMSALDOS: TBooleanField;
    cdsItensCODUNI: TStringField;
    cdsItensTIPO_FALTA: TStringField;
    cdsItensUNITAR: TFloatField;
    cdsItensTOTITE: TFloatField;
    cdsItensCORMTL: TStringField;
    cdsItensMLTITE: TFloatField;
    lblLeg: TLabel;
    cdsItensUNIORI: TFloatField;
    pnlLegendas: TPanel;
    shpCor: TShape;
    lblCor: TLabel;
    shpMlt: TShape;
    lblMlt: TLabel;
    Label4: TLabel;
    shpLiberado: TShape;
    Label5: TLabel;
    cdsItensLIBERADO: TBooleanField;
    cdsItensNUMCMP: TStringField;
    btnRetCor: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRetCorClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    dicQtdDig: TDicionario;

    fltTotalComEst: Double;
    fltTotalSemEst: Double;
    blnFechar: Boolean;
    strCfgMltVen : String;

    procedure pVerificaItens;

    procedure pSomaQtdDig(strCodIte: String; fltQtd: Double);
    function fRetQtdDig(strCodIte: String): Double;
    procedure pSeparaItensParaCorte;
    procedure pRetirarItemDoCorte;
    function fLiberacaoRetirarItensDoCorte: Boolean;
  public
    { Public declarations }
    fatVenda: TFatVenda;
  end;

var
  frmFatResumoEstoqueParaCorte: TfrmFatResumoEstoqueParaCorte;

implementation

uses untFuncFatTypes, untIFatReservaSaldo, untTFatReservaSaldo,
  untIFatEntregaFutura, untTFatEntregaFutura;

{$R *.dfm}

{ TfrmFatResumoEstoqueParaCorte }

procedure TfrmFatResumoEstoqueParaCorte.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fltTotalSemEst > 0 Then
  Begin

    If fMensagem('ATENÇÃO!', 'Confirma somente os itens disponíveis no estoque?', ['&Sim', '&Não']) = 1 Then
    Begin
      pSeparaItensParaCorte;
      ModalResult := mrOk;
    End;

  End
  Else
    ModalResult := mrOk;
end;

procedure TfrmFatResumoEstoqueParaCorte.pSeparaItensParaCorte;
  Var
    arrMatItens: TMatrizFechamento;
    arrMatItensCorte: Array Of TDadosFechamento;
    intTamMat: Integer;
    intContador: Integer;
    item: TDadosFechamento;
begin
  cdsItens.DisableControls;
  cdsItens.First;

  For item In fatVenda.arrMatItens Do
  Begin
    cdsItens.Filter := 'AUTINC = ' + intToStr(item.intAutInc); 
    cdsItens.Filtered := True;
    cdsItens.First;

    While Not cdsItens.Eof Do
    Begin
      If (cdsItensTEMSALDOS.AsBoolean) Or
         (cdsItensLIBERADO.AsBoolean) Then
      Begin
        intTamMat := arrMatItens.fGetItemIndex(item.intAutInc);

        If intTamMat = -1 Then
        Begin
          intTamMat := Length(arrMatItens);
          SetLength(arrMatItens, intTamMat+1);
          arrMatItens[intTamMat] := item;
          arrMatItens[intTamMat].fltQtdIte := cdsItensQTDITE.AsFloat;
        End
        Else
        Begin
          {************************************************************************************}
          {* Se já existe o item na matriz, agrupa a quantidade. Ao inserir autinc duplicado, *}
          {* ele é removido em: TOrdenarItensParaGravacao.pOrdenarItensPorCodigo              *}
          {*Req.230693**********************************************************************RP*}
          arrMatItens[intTamMat].fltQtdIte := arrMatItens[intTamMat].fltQtdIte + cdsItensQTDITE.AsFloat;
        End;
      End
      Else
      Begin
        intTamMat := Length(arrMatItensCorte);
        SetLength(arrMatItensCorte, intTamMat+1);
        arrMatItensCorte[intTamMat] := item;
        arrMatItensCorte[intTamMat].fltQtdIte := cdsItensQTDITE.AsFloat;
      End;

      cdsItens.Next;
    End;
  End;

  cdsItens.Filtered := False;

  //Adiciona os produtos que podem ser atendidos na matriz de produtos da venda
  SetLength(fatVenda.arrMatItens, 0);
  SetLength(fatVenda.arrMatItens, Length(arrMatItens));

  For intContador := Low(arrMatItens) To High(arrMatItens) Do
  Begin
    fatVenda.arrMatItens[intContador] := arrMatItens[intContador];
  End;

  //Adiciona os produtos que não podem ser atendidos na matriz de produtos cortados da venda
  SetLength(fatVenda.arrMatItensCorte, 0);
  SetLength(fatVenda.arrMatItensCorte, Length(arrMatItensCorte));

  For intContador := Low(arrMatItensCorte) To High(arrMatItensCorte) Do
  Begin
    fatVenda.arrMatItensCorte[intContador] := arrMatItensCorte[intContador];
  End;

  //Calcula o total geral agora somente com os produtos que podem ser atendidos nesta venda
  fatVenda.pCalculaTotGer;
  fatVenda.cdsItensCorte.Data := cdsItens.Data;
end;

procedure TfrmFatResumoEstoqueParaCorte.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Not cdsItensTEMSALDOS.AsBoolean Then
  Begin
    dbgItens.Canvas.Font.Color := clBlack;
    dbgItens.Canvas.Brush.Color := shpCor.Brush.Color;

    If (cdsItensLIBERADO.AsBoolean) Then
      dbgItens.Canvas.Brush.Color := shpLiberado.Brush.Color;
  End;

  If (strCfgMltVen = '3') And
     (cdsItensTEMSALDOS.AsBoolean) And
     (cdsItens.FieldByName('CORMTL').AsString = 'SIM') And
     ((cdsItens.FieldByName('QTDITE').AsFloat > 0) And (cdsItens.FieldByName('MLTITE').AsFloat > 0) And
      (fModDouble(cdsItens.FieldByName('QTDITE').AsFloat, cdsItens.FieldByName('MLTITE').AsFloat) <> 0)) Then
  Begin
    dbgItens.Canvas.Font.Color := shpMlt.Brush.Color;
  End;

  If (Column.Field.FieldName = 'CORMTL') And (cdsItens.FieldByName('CORMTL').AsString <> 'SIM') Then
  Begin
    dbgItens.Canvas.FillRect(Rect);
    dbgItens.Canvas.TextRect(Rect, Rect.Left, Rect.Top, '');
  End
  Else
   dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmFatResumoEstoqueParaCorte.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Not cdsItens.Active) Or
     (cdsItens.IsEmpty) Then
    Exit;

  If (Key = VK_SPACE) Then
    pRetirarItemDoCorte;
end;

procedure TfrmFatResumoEstoqueParaCorte.pRetirarItemDoCorte;
begin
  cdsItens.Edit;
  If (Not cdsItensTEMSALDOS.AsBoolean) Then
    cdsItensLIBERADO.AsBoolean := Not cdsItensLIBERADO.AsBoolean
  Else
    cdsItensLIBERADO.AsBoolean := False;
  cdsItens.Post;
end;

function TfrmFatResumoEstoqueParaCorte.fLiberacaoRetirarItensDoCorte: Boolean;
  Var
    objLiberacao : TLiberacao;
    cdsDados : TUniClientDataSet;
begin
  Result := True;
  cdsDados := TUniClientDataSet.Create(Self);
  Try
    pCloneDataSet(cdsDados, cdsItens);

    objLiberacao := TLiberacao.Create;
    Try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Resumo de itens sem estoque para corte - Permitir retirar todos os itens do corte - Botão [ F2 ]');
      objLiberacao.objMsgLibera.pAddSeparador(67);
      objLiberacao.objMsgLibera.pAddTexto('Cliente: '+fatVenda.strCodCli + '-' + fatVenda.strCliNom);
      objLiberacao.objMsgLibera.pAddSeparador(67);
      objLiberacao.objMsgLibera.pAddTexto('Produtos a serem cortados: ');
      objLiberacao.objMsgLibera.pAddSeparador(67);

      cdsDados.First;
      cdsDados.Filter := 'TEMSALDOS=False';
      cdsDados.Filtered := True;

      If cdsDados.IsEmpty Then
        Exit;

      While Not cdsDados.Eof Do
      Begin
        objLiberacao.objMsgLibera.pAddTexto(cdsDados.FieldByName('CODITE').AsString + '-' + cdsDados.FieldByName('DESITE').AsString);
        cdsDados.Next;
      End;

      objLiberacao.objMsgLibera.pAddTexto(' ');

      objLiberacao.strDirAce := 'PERRETITECORTE';
      objLiberacao.strMsgSen := 'Retirar todos os itens do corte';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCliente := fatVenda.strCodCli + '-' + fatVenda.strCliNom;
      objLiberacao.strCpfCnpj := fatVenda.strCliCgc;

      If (Not objLiberacao.fLibera) Then
        Result := False;

    Finally
      FreeAndNil(objLiberacao);
    End;
  Finally
    FreeAndNil(cdsDados);
  End;
end;

procedure TfrmFatResumoEstoqueParaCorte.btnRetCorClick(Sender: TObject);
begin
  inherited;

  cdsItens.DisableControls;
  Try
    If (btnRetCor.Caption = '[ F2 ] Retirar todos os itens do corte') Then
    Begin
      If Not fLiberacaoRetirarItensDoCorte THen
        Exit;
    End;

    cdsItens.First;
    while not cdsItens.Eof do
    begin
      pRetirarItemDoCorte;
      cdsItens.Next;
    end;

    btnRetCor.Caption := IIF(btnRetCor.Caption = '[ F2 ] Retirar todos os itens do corte',
                             '[ F2 ] Adicionar todos os itens no corte',
                             '[ F2 ] Retirar todos os itens do corte');
  Finally
    cdsItens.EnableControls;
  End;
end;


procedure TfrmFatResumoEstoqueParaCorte.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(dicQtdDig);
end;

procedure TfrmFatResumoEstoqueParaCorte.FormCreate(Sender: TObject);
begin
  inherited;
  blnFechar := False;
  dicQtdDig := TDicionario.Create;

  pSetaCodIte(cdsItensCODITE);
  cdsItens.CreateDataSet;

  strCfgMltVen := fCfgSis('MLTVEN', varString);
end;

procedure TfrmFatResumoEstoqueParaCorte.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F2) Then
    btnRetCor.Click;
end;

procedure TfrmFatResumoEstoqueParaCorte.FormPaint(Sender: TObject);
begin
  inherited;
  If (fltTotalSemEst <= 0) And (Not blnFechar) Then
  Begin
    blnFechar := True;
    ModalResult := mrOk;
  End;
end;

procedure TfrmFatResumoEstoqueParaCorte.FormShow(Sender: TObject);
begin
  inherited;
  pVerificaItens;

  Case strCfgMltVen[1] Of
    '2':Begin
          dbgItens.Columns[4].Visible := False;
          shpMlt.Visible := False;
          lblMlt.Visible := False;
        End;

    '1',
    '4':Begin
          shpMlt.Visible := False;
          lblMlt.Visible := False;
        End;
  End;

  lblLeg.Visible := dbgItens.Columns[4].Visible;

  pSetFocus(btnConfirma);
end;

function TfrmFatResumoEstoqueParaCorte.fRetQtdDig(strCodIte: String): Double;
begin
  Result := IfNull(dicQtdDig[strCodIte], 0.0);
end;

procedure TfrmFatResumoEstoqueParaCorte.pSomaQtdDig(strCodIte: String;
  fltQtd: Double);
begin
  dicQtdDig[strCodIte] := fRetQtdDig(strCodIte) + fltQtd;
end;

procedure TfrmFatResumoEstoqueParaCorte.pVerificaItens;
  Var
    item: TDadosFechamento;
    strNumLot: String;
    strCodEmp: String;
    fltSaldoAtual: Double;
    strSemEst: String;
    blnPedSen: Boolean;
    blnSemEst: Boolean;
    blnCorteMulti: Boolean;
    fltSaldoAtualizado: Double;
    fltMltIte: Double;
    strTipoFalta: String;

    function fTotalItem(item: TDadosFechamento; fltQtdOri, fltQtdIte: Double): Double;
    begin
      Result := item.fltTotIte -
                item.fltDesEsp +
                item.fltValIpi +
                item.fltValRet +
                item.fltValFre +
                item.fltDesAce +
                item.fltValCBS +
                item.fltValIBS +
                item.fltVal_IS;
      Result := Result / fltQtdOri * fltQtdIte;
    end;

begin
  fltTotalComEst := 0;
  fltTotalSemEst := 0;

  For item In fatVenda.arrMatItens Do
  Begin

    If (fCfgSis('ITESER', varString) = item.strCodIte) Or
      (fCfgSis('SERTER', varString) = item.strCodIte) Then
      Continue;

    fatVenda.strIdePro := item.strIdePro;
    strCodEmp := IIF(fEmptyStr(item.strEmpIte), VS_strCodEmp, item.strEmpIte);
    strNumLot := IIF(fatVenda.fIgnorarLote(strCodEmp, item.strCodIte), '', item.strNumLot);
    fltSaldoAtual := fRetSaldosEmpresa(item.strCodIte, strCodEmp, strNumLot);

    If fCfgSis('SALCOR', varBoolean) And fUsaQtdPendenteEntregaFutura Then
      fltSaldoAtual := fltSaldoAtual + TEntregaFutura.New(
                                         TParamEF.New()
                                           .CodIte(item.strCodIte)
                                           .CodEmp(strCodEmp)
                                           .Lote(strNumLot)
                                           .Faturamento(True)
                                         ).Total();

    fatVenda.fVerificaQtdEstoque(strCodEmp, fatVenda.strOpcDoc, item.strEntSai,
      fatVenda.strNumOrc, intToStr(item.intAutInc), item.strCodIte, item.strCodAca, item.strEmpAca,
      item.strDesIte, item.strEntRet, item.strEntFut, item.strMotFut, item.fltQtdIte,
      fRetQtdDig(item.strCodIte), 0, fltSaldoAtual, False, strSemEst, False,
      blnPedSen, blnSemEst, item.recForTin, False, '', True);

    fltSaldoAtualizado := fltSaldoAtual -
                          fRetQtdDig(item.strCodIte) - TSaldoReservado.New(
                                                         TReservaParametros.New()
                                                           .EmpresaItem(strCodEmp)
                                                           .CodigoItem(item.strCodIte)
                                                           .CodEmpresa(strCodEmp)
                                                           .NumeroLote(strNumLot)
                                                           .NumeroDocumento(fatVenda.strNumOrc)
                                                           .TipoFiltroDocumento(IIF(fEmptyStr(fatVenda.strNumOrc), tfdTodos, tfdIgnorarDocumento))
                                                           .DesconsideraPedidosCorte(Not fatVenda.blnPedCorte)
                                                         ).fGetQuantidade();

    fltMltIte := fRetMltVenItem(item.strCodIte);
    fltSaldoAtualizado := fMenorMultiploValido(fltSaldoAtualizado, fltMltIte, True, blnCorteMulti);

    If (blnSemEst) Then
    Begin
      strTipoFalta := 'I';
      If (fltSaldoAtualizado > 0) Then
      Begin
        strTipoFalta := 'Q';
        cdsItens.Append;
        cdsItensCODITE.AsString  := item.strCodIte;
        cdsItensDESITE.AsString  := item.strDesIte;
        cdsItensCODUNI.AsString  := item.strCodUni;
        cdsItensQTDITE.AsFloat   := fltSaldoAtualizado;
        cdsItensSALDOS.AsFloat   := fltSaldoAtual;
        cdsItensAUTINC.AsInteger := item.intAutInc;
        cdsItensTEMSALDOS.AsBoolean := True;
        cdsItensLIBERADO.AsBoolean := False;
        cdsItensTIPO_FALTA.AsString := strTipoFalta;
        cdsItensUNIORI.AsFloat  := item.fltUniOri;
        cdsItensUNITAR.AsFloat  := item.fltUniTar;
        cdsItensTOTITE.AsFloat  := cdsItensQTDITE.AsFloat * cdsItensUNITAR.AsFloat;
        cdsItensNUMCMP.AsString := item.strNumCmp;
        If blnCorteMulti Then
        Begin
          cdsItensMLTITE.AsFloat := fltMltIte;
          cdsItensCORMTL.AsString := 'SIM';
        End;
        cdsItens.Post;
        fltTotalComEst := fltTotalComEst + fTotalItem(item,
          item.fltQtdIte, fltSaldoAtualizado);
      End;

      cdsItens.Append;
      cdsItensCODITE.AsString  := item.strCodIte;
      cdsItensDESITE.AsString  := item.strDesIte;
      cdsItensCODUNI.AsString  := item.strCodUni;
      cdsItensQTDITE.AsFloat   := IIF(fltSaldoAtualizado < 0,
                                      item.fltQtdIte,
                                      item.fltQtdIte - fltSaldoAtualizado);
      cdsItensSALDOS.AsFloat   := fltSaldoAtual;
      cdsItensAUTINC.AsInteger := item.intAutInc;
      cdsItensTEMSALDOS.AsBoolean := (Not blnSemEst);
      cdsItensLIBERADO.AsBoolean := False;
      cdsItensTIPO_FALTA.AsString := strTipoFalta;
      cdsItensUNIORI.AsFloat  := item.fltUniOri;
      cdsItensUNITAR.AsFloat  := item.fltUniTar;
      cdsItensTOTITE.AsFloat  := cdsItensQTDITE.AsFloat * cdsItensUNITAR.AsFloat;
      cdsItensNUMCMP.AsString := item.strNumCmp;
      If blnCorteMulti Then
      Begin
        cdsItensMLTITE.AsFloat := fltMltIte;
        cdsItensCORMTL.AsString := 'SIM';
      End;
      cdsItens.Post;

      fltTotalSemEst := fltTotalSemEst + fTotalItem(item, item.fltQtdIte,
        cdsItensQTDITE.AsFloat);
    End
    Else
    Begin
      cdsItens.Append;
      cdsItensCODITE.AsString  := item.strCodIte;
      cdsItensDESITE.AsString  := item.strDesIte;
      cdsItensCODUNI.AsString  := item.strCodUni;
      cdsItensQTDITE.AsFloat   := item.fltQtdIte;
      cdsItensSALDOS.AsFloat   := fltSaldoAtual;
      cdsItensAUTINC.AsInteger := item.intAutInc;
      cdsItensTEMSALDOS.AsBoolean := True;
      cdsItensLIBERADO.AsBoolean := False;
      cdsItensUNIORI.AsFloat  := item.fltUniOri;
      cdsItensUNITAR.AsFloat  := item.fltUniTar;
      cdsItensTOTITE.AsFloat  := item.fltTotIte;
      cdsItensNUMCMP.AsString := item.strNumCmp;
      cdsItens.Post;

      fltTotalComEst := fltTotalComEst + fTotalItem(item,
        item.fltQtdIte, item.fltQtdIte);
    End;

    pSomaQtdDig(item.strCodIte, item.fltQtdIte);
  End;

  edtTotComEst.Text := FloatToStrF(fatVenda.fltTotGer - fltTotalSemEst, ffNumber, 12, 2);
  edtTotSemEst.Text := FloatToStrF(fatVenda.fltTotGer - fltTotalComEst, ffNumber, 12, 2);
  edtTotImp.Text := FloatToStrF(fatVenda.fltTotGer, ffNumber, 12, 2);
end;

end.
