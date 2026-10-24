unit untFatDigDtaEntFut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, ComboBoxFocus, EditFocus, Math, Uni, UniClientDataSet,
  untControleEntregaRomaneio, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatDigDtaEntFut = class(TfrmPaiConfirma)
    pnlMotivo: TPanel;
    lblMotEntFut: TLabel;
    cmbMotEntFut: TComboBoxFocus;
    lblDatEntFut: TLabel;
    mskDtaEntFut: TMaskEditFocus;
    pnlParticiona: TPanel;
    lblQtdIte: TLabel;
    edtQtdIte: TEditFocus;
    pnlAviso: TPanel;
    mmoAviso: TMemo;
    lblCliBus: TLabel;
    cmbCliBus: TComboBoxFocus;
    rdgQtdItens: TRadioGroup;
    procedure cmbMotEntFutChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtQtdIteExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskDtaEntFutExit(Sender: TObject);
    procedure mskDtaEntFutKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCliBusChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure rdgQtdItensClick(Sender: TObject);
  private

    { Private declarations }
    intQtdDec: Integer;
    intMotAnt: Integer;
    dtaDtaAnt: TDate;
    blnPrzAlt: Boolean;
    strClBAnt: String;

    Function fConfirmaParticao: Boolean;

    Procedure pHabilitaQuant;
    procedure pMostraAviso;

    Function fGetEditFormat(intDecQtd: Integer): String;
    function fValidarMulTiplo(var AQtdIte: double): boolean;
    function fGravarRequisicaoCompra(strCodIte: String; strCodCli: String;
      strCodVen: String; fltQtdEnt: Double; strNumDoc: String;
      strEspDoc: String; strEmpDoc: String): Boolean;
    function fProcessamentoRequisicaoCompra : Boolean;

  public
    { Public declarations }

    intDiaFor: Integer;
    fltQtdEnt: Double;
    fltQtdPar: Double;
    blnAltera: Boolean;
    dtaDtaRes: TDate;
    strNumDoc: String;
    strEspDoc: String;
    strCodUni: String;
    strAutInc: String;
    strCodIte: String;
    strCodEmp: String;
    strCodCli: String;
    strCodVen: String;
    fltQtdIte: Double;
    objConEnt: TControleEntregaRomaneio;

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatDigDtaEntFut: TfrmFatDigDtaEntFut;

implementation

uses untConsultas, untFuncoesSimples, untFuncoes, untFuncoesGenerica, untFuncFat, untFatRequisicaoCompras;

{$R *.dfm}

Procedure TfrmFatDigDtaEntFut.pHabilitaQuant;
Begin
  edtQtdIte.Enabled := ((cmbMotEntFut.ItemIndex <> intMotAnt) Or
                       (dtaDtaAnt <> StrToDate(mskDtaEntFut.Text)) Or
                       (strClBAnt <> Copy(frmFatDigDtaEntFut.cmbCliBus.Text,1,1))) And
                       (rdgQtdItens.ItemIndex = 0);

  lblQtdIte.Enabled := edtQtdIte.Enabled;

  If Not lblQtdIte.Enabled Then
    edtQtdIte.Text := FloatToStrF(fltQtdEnt, ffFixed, 12, intQtdDec);
End;

procedure TfrmFatDigDtaEntFut.cmbCliBusChange(Sender: TObject);
begin
  inherited;
  pHabilitaQuant;
end;

procedure TfrmFatDigDtaEntFut.cmbMotEntFutChange(Sender: TObject);
begin
  inherited;

  mskDtaEntFut.Enabled := cmbMotEntFut.ItemIndex <> 1;

  Case cmbMotEntFut.ItemIndex Of
    0: mskDtaEntFut.Text := DateToStr(VS_DATE + intDiaFor);
    1: mskDtaEntFut.Text := '31/12/9999';
    2: mskDtaEntFut.Text := DateToStr(VS_DATE);
  End;

  pHabilitaQuant;

  pMostraAviso;
end;


procedure TfrmFatDigDtaEntFut.edtQtdIteExit(Sender: TObject);
begin
  inherited;

  edtQtdIte.Text := FloatToStrF(fStrToFloat(edtQtdIte.Text) , ffFixed, 12, intQtdDec);

end;

procedure TfrmFatDigDtaEntFut.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cmbMotEntFut);
end;

function TfrmFatDigDtaEntFut.fProcessamentoRequisicaoCompra : Boolean;
  Var
    strRequisicaoCompra : String;
    strPedidosReqCompra : String;
begin
  Result := True;

  If (fCfgSis('TRAAME', varBoolean)) And (intMotAnt = 0) And (cmbMotEntFut.ItemIndex > 0) Then
  Begin
    strRequisicaoCompra := fRetornaRequisicaoCompra(strNumDoc,
                                                    strEspDoc,
                                                    strCodEmp,
                                                    strCodIte);
    If (Not fEmptyStr(strRequisicaoCompra)) Then
    Begin
      strPedidosReqCompra := fPedidosRequisicaoCompra(strRequisicaoCompra, VS_strCodEmp);
      If (Not fEmptyStr(strPedidosReqCompra)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este registro está vinculado à requisição de compra "'+strRequisicaoCompra+'", '+
                              'que foi vinculada ao(s) pedido(s) de compra: '+strPedidosReqCompra+'. '+
                              'Para alterar o motivo, é necessário retirar a requisição do(s) pedido(s) de compra!', ['&Ok']);
        Exit(False)
      End
      Else
      Begin
        If (fMensagem('ATENÇÃO!', 'Este registro está vinculado à requisição de compra "'+strRequisicaoCompra+'", '+
                                  'porém sem pedido de compra vinculado. Se alterar o motivo esta requisição será excluída. '+
                                  'Confirma a alteração?', ['&Sim', '&Não']) = 1) Then
        Begin
          pExcluiRequisicaoCompra(strRequisicaoCompra, VS_strCodEmp, Self.Name);
        End
        Else
          Exit(False)
      End;
    End;
  End;

  If (fCfgSis('QGRTMF', varBoolean)) And
     (fCfgSis('FALPRO', varBoolean) Or fCfgSis('FALVEN', varBoolean)) And
     (intMotAnt > 0) And (cmbMotEntFut.ItemIndex = 0) Then
  Begin
    If (fMensagem('ATENÇÃO!', 'Se alterar o motivo será gerado uma requisição de compra. Confirma a alteração?', ['&Sim', '&Não']) = 1) Then
    Begin
      If (edtQtdIte.Enabled) And (StrToFloatDef(edtQtdIte.Text, 0) > 0) Then
        fltQtdIte := StrToFloatDef(edtQtdIte.Text, 0);

      Result := fGravarRequisicaoCompra(strCodIte,
                                        strCodCli,
                                        strCodVen,
                                        fltQtdIte,
                                        strNumDoc,
                                        strEspDoc,
                                        strCodEmp);
    End
    Else
      Exit(False)
  End;
end;

procedure TfrmFatDigDtaEntFut.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrok Then
  Begin
    If (Not fVerificaCampos) Or (Not fConfirmaParticao) Then
      Action := caNone
    Else
    Begin
      blnAltera := (edtQtdIte.Enabled) or (rdgQtdItens.ItemIndex = 1);
      If (Not fProcessamentoRequisicaoCompra) Then
        Action := caNone;
    End;
  End;
end;

procedure TfrmFatDigDtaEntFut.FormCreate(Sender: TObject);
begin
  inherited;

  fltQtdEnt := 0;
  fltQtdPar := 0;
  intDiaFor := 0;
  fltQtdIte := 0;
  intQtdDec := fCfgSis('DECQTD', varInteger);

  edtQtdIte.EditFormat := fGetEditFormat(intQtdDec);

  blnPrzAlt := False;
end;

procedure TfrmFatDigDtaEntFut.FormShow(Sender: TObject);
begin
  inherited;

  blnAltera := False;
  intMotAnt := cmbMotEntFut.ItemIndex;
  dtaDtaAnt := StrToDate(mskDtaEntFut.Text);
  strClBAnt := Copy(frmFatDigDtaEntFut.cmbCliBus.Text,1,1);

  If intMotAnt = 2 Then {PREVISÃO}
    dtaDtaRes := StrToDate(mskDtaEntFut.Text)
  Else
    dtaDtaRes := 0;

  edtQtdIte.Text := FloatToStrF(fltQtdEnt, ffFixed, 12, intQtdDec);

  mskDtaEntFut.Enabled := cmbMotEntFut.ItemIndex <> 1;

  pnlParticiona.Visible := fltQtdEnt > 0;

  If Not pnlParticiona.Visible Then
    Self.Height := Self.Height - pnlParticiona.Height;

  cmbCliBus.Visible := fCfgSis('CLBUEF',varBoolean);
  lblCliBus.Visible := cmbCliBus.Visible;

  pMostraAviso;
end;

function TfrmFatDigDtaEntFut.fGravarRequisicaoCompra(strCodIte: String;
  strCodCli: String; strCodVen: String; fltQtdEnt: Double; strNumDoc: String;
  strEspDoc: String; strEmpDoc: String): Boolean;
  Var
    cdsMovRcd : TUniClientDataSet;
    qryMovRcd : TUniQuery;
    strCodSeq : String;
begin
  qryMovRcd := fCriaQuery();
  Try
    qryMovRcd.SQL.Add('SELECT * FROM MOVRCD WHERE FALSE');
    qryMovRcd.Open;

    cdsMovRcd := fCriaClientDatset(qryMovRcd, True);
    Try
      cdsMovRcd.Insert;
      cdsMovRcd.FieldByName('RCD_CODITE').AsString := strCodIte;
      cdsMovRcd.FieldByName('RCD_DESITE').AsString := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte]);;
      cdsMovRcd.FieldByName('RCD_OBSERV').AsString := 'Requisição de compra gerada através da rotina de "Alteração do Motivo da Entrega Futura"';
      cdsMovRcd.FieldByName('RCD_CODEMP').AsString := VS_strCodEmp;
      cdsMovRcd.FieldByName('RCD_QTDITE').AsFloat  := fltQtdEnt;
      cdsMovRcd.FieldByName('RCD_DOCPDV').AsString := strNumDoc;
      cdsMovRcd.FieldByName('RCD_ESPPDV').AsString := strEspDoc;
      cdsMovRcd.FieldByName('RCD_EMPPDV').AsString := strEmpDoc;
      cdsMovRcd.Post;

      Result := TfrmFatRequisicaoCompras.
                  fGravaRequisicaoCompra(strCodSeq, strCodCli, strCodVen,
                                         EmptyStr, cdsMovRcd, False);
    Finally
      FreeAndNil(cdsMovRcd);
    End;
  Finally
    FreeAndNil(qryMovRcd);
  End;
end;

function TfrmFatDigDtaEntFut.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
var
  LQtdIte: Double;
Begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaEntFut) And mskDtaEntFut.Enabled Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaEntFut.Text)) Then
      Begin
        fMensagem('','A data de entrega futura deve ser preenchida!', ['&OK']);
        Result := False;
      End Else
      Begin

        Case cmbMotEntFut.ItemIndex Of
          0: Begin
               If StrToDate(mskDtaEntFut.Text) < VS_DATE + intDiaFor Then
               Begin
                 If Not blnPrzAlt Then
                 Begin
                   If fMensagem('','O prazo de entrega está menor que o prazo de entrega do fornecedor. Confirma mesmo assim?', ['&Sim', '&Não']) = 2 Then
                     Result := False
                   Else
                   Begin
                     blnPrzAlt := True;
                     btnConfirma.Click;
                   End;
                 End;
               End;
             End;

          1: mskDtaEntFut.Text := '31/12/9999';

          2: Begin

               If (StrToDate(mskDtaEntFut.Text) < VS_Date) Then
               Begin
                 fMensagem('','A data deve ser maior ou igual a data atual!', ['&OK']);
                 Result := False;
               End

               Else If Assigned(objConEnt) Then
               Begin
                 If (Not objConEnt.fDataExisteNaMatriz(StrToDateDef(mskDtaEntFut.Text, 0), objConEnt.arrDtaOri)) Then
                 Begin
                   If (Not objConEnt.fDataDisponivel(StrToDateDef(mskDtaEntFut.Text, 0))) Then
                   Begin
                     fMensagem('ATENÇÃO!', 'Data não disponível para entrega!', ['&Ok']);
                     Result := False;
                   End;
                 End;
               End;

             End;

        End;

      End;

      If Result Then
        pHabilitaQuant;
    End

    Else If Sender = edtQtdIte Then
    Begin

      If pnlParticiona.Visible Then
      Begin
        LQtdIte := fStrToFloat(edtQtdIte.Text);

        If fEmptyStr(edtQtdIte.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Quantidade deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If fStrToFloat(edtQtdIte.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A Quantidade deve ser maior que Zero!', ['&O k']);
          Result := False;
        End
        Else If RoundTo(fStrToFloat(edtQtdIte.Text), -intQtdDec) > RoundTo(fltQtdEnt, -intQtdDec) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Quantidade deve ser menor ou igual a ' + FloatToStrF(fltQtdEnt , ffFixed, 12, intQtdDec) + '!', ['&O k']);
          Result := False;
        End
        Else If (fItemNaoFracionavel(strEspDoc, strCodUni)) And
                (Not fCfgSis('VENVID', varBoolean)) And //venda vidro
                (Not fCfgSis('VENMAD', varBoolean)) And //venda medeireira
                (Frac(fStrToFloat(edtQtdIte.Text)) <> 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é possível informar valor fracionado para este produto!', ['&Ok']);
          Result := False;
        End
        Else if (not fValidarMulTiplo(LQtdIte)) then
        Begin
          Result := False;
          edtQtdIte.Text := FloatToStrF(LQtdIte, ffFixed, 12, intQtdDec);
        End

        Else If RoundTo(fStrToFloat(edtQtdIte.Text) - fltQtdEnt, -intQtdDec) = 0 Then
               fltQtdPar := 0

        Else fltQtdPar := RoundTo(fStrToFloat(edtQtdIte.Text), -intQtdDec);

        If (fltQtdPar > 0) And (Not fEmptyStr(strAutInc)) Then
        Begin
          If (fCampoTabela('IFNULL(SEP_QTDIMP, 0)', 'SEPFUT', ['SEP_SEQGER'], [strAutInc]) > 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Existe uma separação impressa para esse item'+#13+
                                  'Limpe essa separação pelo botão "[ F9 ] Desfazer Separação" '+
                                  'na rotina "Entrega Futura - Impressão da Separação", antes de alterar a quantidade desse item!', ['&Ok']);
            Result := False;
            edtQtdIte.Text := FloatToStrF(LQtdIte, ffFixed, 12, intQtdDec);
          End;
        End;
      End;

    End;

  End;

  If Not Result Then
  Begin

    If Sender.Enabled Then
      pSetFocus(Sender);
  End;

End;

function TfrmFatDigDtaEntFut.fValidarMulTiplo(var AQtdIte: double): boolean;
var
  LMltVen,
  LValor: Double;
begin
  Result := True;

  LMltVen := fCampoTabela('ITE_MLTVEN', 'CADITE', ['ITE_CODITE'], [strCodIte]);

  if LMltVen = 0 then
    Exit;

  LValor := fFormataFloatInterna(AQtdIte / LMltVen, 4);

  if (LValor - Int(LValor)) > 0 then
  begin
    AQtdIte := Int(((AQtdIte + LMltVen) / LMltVen)) * LMltVen;
    fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(LMltVen, ffNumber, 12, 3), ['&OK']);
    Result := False;
  end;
end;

procedure TfrmFatDigDtaEntFut.mskDtaEntFutExit(Sender: TObject);
begin
  inherited;
  pHabilitaQuant;
end;

procedure TfrmFatDigDtaEntFut.mskDtaEntFutKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (cmbMotEntFut.ItemIndex = 2) And
     Assigned(objConEnt) And
     fPesqControleEntrega(Self, mskDtaEntFut, Key) And
     fValidaCampos(mskDtaEntFut, True) Then
    SelectNext(ActiveControl, True, True);

end;

Function TfrmFatDigDtaEntFut.fConfirmaParticao: Boolean;
Begin

  Result := (fltQtdEnt = 0) Or
            (RoundTo(fStrToFloat(edtQtdIte.Text), -intQtdDec) = RoundTo(fltQtdEnt, -intQtdDec)) Or
            fPergunta('Confirma a partição do item com as novas informações?');

End;

function TfrmFatDigDtaEntFut.fGetEditFormat(intDecQtd: Integer): String;
  Var
    intDec : Integer;
begin
  If intDecQtd <= 0 Then
    intDec := 2
  Else
    intDec := intDecQtd;
  Result := '#,' + StringOfChar('#', intDec) + '0.' + StringOfChar('0', intDec);
end;

procedure TfrmFatDigDtaEntFut.pMostraAviso;
Begin
  pnlAviso.Visible := False;

  Self.ClientHeight := pnlMotivo.Height +
                       IIF(pnlParticiona.Visible, pnlParticiona.Height, 0) +
                       IIF(pnlAviso.Visible, pnlAviso.Height, 0) +
                       pnlStatus.Height + pnlBotoes.Height;
End;

procedure TfrmFatDigDtaEntFut.rdgQtdItensClick(Sender: TObject);
begin
  inherited;
  edtQtdIte.Enabled := ((cmbMotEntFut.ItemIndex <> intMotAnt) Or
                       (dtaDtaAnt <> StrToDate(mskDtaEntFut.Text)) Or
                       (strClBAnt <> Copy(frmFatDigDtaEntFut.cmbCliBus.Text,1,1))) And
                       (rdgQtdItens.ItemIndex = 0);

  lblQtdIte.Enabled := edtQtdIte.Enabled;
end;

end.
