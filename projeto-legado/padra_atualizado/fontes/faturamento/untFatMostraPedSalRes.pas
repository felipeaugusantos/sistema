unit untFatMostraPedSalRes;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, UniClientDataSet,
  Grids, DBGridCitel, DBGrids, Menus, EditFocus, AppEvnts, DB, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, Uni, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGridCitel, cxClasses,
  cxGridLevel, cxGrid, cxCurrencyEdit, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxLabel, cxTextEdit;

type
  TfrmFatMostraPedSalRes = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    edtItem: TEditFocus;
    dtsSalRes: TDataSource;
    pnlTotais: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtTotCor: TEditFocus;
    edtTotRes: TEditFocus;
    cxgItensLevel1: TcxGridLevel;
    cxgItensTableView: TcxGridDBTableViewCitel;
    cxgItens: TcxGridCitel;
    Se_adicionar_uma_coluna_modifique_o_FormCreate: TcxGridDBColumn;
    FDO_NUMDOC: TcxGridDBColumn;
    FDO_ESPDOC: TcxGridDBColumn;
    FDO_CODEMP: TcxGridDBColumn;
    FDO_CODVEN: TcxGridDBColumn;
    FDO_DTAENT: TcxGridDBColumn;
    FGO_PREVIS: TcxGridDBColumn;
    FDO_DTENTR: TcxGridDBColumn;
    CLI_NOMCLI: TcxGridDBColumn;
    FDO_QTDPED: TcxGridDBColumn;
    FDO_QTDGAR: TcxGridDBColumn;
    FDO_QTDORP: TcxGridDBColumn;
    EQU_NUMOSE: TcxGridDBColumn;
    EQU_STATUS: TcxGridDBColumn;
    FGO_CORTE_: TcxGridDBColumn;
    TABELA: TcxGridDBColumn;
    FDO_UNITAR: TcxGridDBColumn;
    DOCENT: TcxGridDBColumn;
    btnPedVen: TBitBtnLocked;
    CODREQ: TcxGridDBColumn;
    chkSemReq: TCheckBox;
    NOMVEN: TcxGridDBColumn;
    SEPIMP: TcxGridDBColumn;
    CLI_CODCLI: TcxGridDBColumn;
    FDO_QTDEND: TcxGridDBColumn;
    FDO_QTPD_F: TcxGridDBColumn;
    LDO_QTDSEP: TcxGridDBColumn;
    CID_NOMCID: TcxGridDBColumn;
    CID_ESTADO: TcxGridDBColumn;
    LDO_NUMLOT: TcxGridDBColumn;
    FDO_QTDDEV: TcxGridDBColumn;
    procedure btnFecharClick(Sender: TObject);
    procedure dbeItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgItensTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgItensTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPedVenClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkSemReqClick(Sender: TObject);
  private
    { Private declarations }
    Procedure pAfterScroll(dataSet: TDataSet);

  public
    pMostraDocumentoSalRes: TMostraDocumentoReimpressao;
    Class Procedure pExibeDocsSaldosReservado(strCodIte, strCodEmp : String;
       pMostraDocumentoSalRes: TMostraDocumentoReimpressao = Nil;
       blnMostrarRequisicao: Boolean = False; blnExibeCidade : boolean = False; blnMaximizado : boolean = false;
       dtaInicial: TDateTime = 0; dtaFinal: TDateTime = 0; tfdTipoFiltroData: TTipoFiltroDataAnaliseProducao = tfdNenhum);
  end;


implementation

uses untFuncoesSimples, UITypes, untIFatReservaSaldo, untTFatReservaSaldo;

{$R *.dfm}

procedure TfrmFatMostraPedSalRes.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraPedSalRes.btnPedVenClick(Sender: TObject);
begin
  inherited;

  If Not btnPedVen.Visible Then
    Exit;

  If Not Assigned(pMostraDocumentoSalRes) Then
    Exit;

  With dtsSalRes.DataSet Do
  pMostraDocumentoSalRes(FieldByName('FDO_NUMDOC').AsString,
                         FieldByName('FDO_ESPDOC').AsString,
                         FieldByName('FDO_CODEMP').AsString,
                         '');
end;

procedure TfrmFatMostraPedSalRes.chkSemReqClick(Sender: TObject);
begin
  inherited;

  If chkSemReq.Checked Then
  Begin
    dtsSalRes.DataSet.Filter   := 'CODREQ = ''''';
    dtsSalRes.DataSet.Filtered := True;
  End Else
  Begin
    dtsSalRes.DataSet.Filtered := False;
  End;
end;

procedure TfrmFatMostraPedSalRes.cxgItensTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Assigned(dtsSalRes.DataSet) Then
  Begin
    If pnlTotais.Visible Then
    Begin
      With dtsSalRes.DataSet Do
      Begin
        If Not Active Or IsEmpty Then
          Exit;

          If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  FGO_CORTE_.Index]) = 'S' Then
              ACanvas.Font.Color := clRed
          Else
            ACanvas.Font.Color := clBlue;

      End;
    End;

  End;
end;

procedure TfrmFatMostraPedSalRes.cxgItensTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
  Begin
    btnFechar.Click;
  End;
end;

procedure TfrmFatMostraPedSalRes.dbeItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
  Begin
    btnFechar.Click;
  End;
end;

procedure TfrmFatMostraPedSalRes.FormCreate(Sender: TObject);
begin

  inherited;
  {******************************************************************************}
  {* EXIBE Nº DA O.S. E STATUS SÓ SE UTILIZAR ROTINA DE CONSERTO DE EQUIPAMENTO *}
  {***************************************************************************AL*}

  EQU_NUMOSE.Visible := fCfgSis('CONEQU', varBoolean);
  EQU_STATUS.Visible := fCfgSis('CONEQU', varBoolean);
  FDO_NUMDOC.Width := 80;

  pMostraDocumentoSalRes := Nil;

  LDO_QTDSEP.Visible := fUsaRotinaWMS;
  LDO_NUMLOT.Visible := fUsaRotinaWMS;

end;

procedure TfrmFatMostraPedSalRes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  Case Key Of
    VK_F5: btnPedVen.Click;
  End;

end;

Procedure TfrmFatMostraPedSalRes.pAfterScroll(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    btnPedVen.Visible := SameText(FieldByName('FDO_ESPDOC').AsString, 'PD');
  End;
End;

procedure TfrmFatMostraPedSalRes.FormShow(Sender: TObject);
  Var
    fltQtdCorte,
    fltQtdReser: Double;
begin
  inherited;

  pnlTotais.Visible := (fCfgSis('PRCTPV') = '2') And
                       (dtsSalRes.DataSet.FindField('FGO_CORTE_') <> nil);

  If pnlTotais.Visible Then
  Begin
    fltQtdCorte := 0.000;
    fltQtdReser := 0.000;

    With dtsSalRes.DataSet Do
    Begin
      First;
      While Not Eof Do
      Begin
        If FieldByName('FGO_CORTE_').AsString = 'S' Then
          fltQtdCorte := fltQtdCorte + FieldByName('FDO_QTDPED').AsFloat
        Else
          fltQtdReser := fltQtdReser + FieldByName('FDO_QTDPED').AsFloat +
                                       FieldByName('FDO_QTDORP').AsFloat +
                                       FieldByName('FDO_QTDGAR').AsFloat;
        Next;
      End;
      First;

      TFloatField(FieldByName('FDO_QTDPED')).DisplayFormat := '#,##0.0000';
      TFloatField(FieldByName('FDO_QTDORP')).DisplayFormat := '#,##0.0000';
      TFloatField(FieldByName('FDO_QTDGAR')).DisplayFormat := '#,##0.0000';
      TFloatField(FieldByName('FDO_QTDEND')).DisplayFormat := '#,##0.0000';
      TFloatField(FieldByName('LDO_QTDSEP')).DisplayFormat := '#,##0.0000';
    End;

    edtTotCor.Text := FormatFloat('#,#0.0000', fltQtdCorte);
    edtTotRes.Text := FormatFloat('#,#0.0000', fltQtdReser);
  End;

  If Assigned(pMostraDocumentoSalRes) Then
  Begin
    With dtsSalRes.DataSet Do
    AfterScroll := pAfterScroll;
    pAfterScroll(dtsSalRes.DataSet);
  End;

end;

Class Procedure TfrmFatMostraPedSalRes.pExibeDocsSaldosReservado(strCodIte, strCodEmp : String;
                   pMostraDocumentoSalRes: TMostraDocumentoReimpressao = Nil;
                   blnMostrarRequisicao: Boolean = False; blnExibeCidade : boolean = False; blnMaximizado : boolean = false;
                   dtaInicial: TDateTime = 0; dtaFinal: TDateTime = 0; tfdTipoFiltroData: TTipoFiltroDataAnaliseProducao = tfdNenhum);
  Var
    strSQL    : String;
    cdsSalRes : TUniClientDataSet;
    qrySalRes : TUniQuery;
    strEmp_CD : String;
    fltCnvMl,
    fltQtdeIte: Double;
    regEndDoc: TEndDocumento;
    strNumOpe : String;
    stlListaEmpresas: TStringList;
    intContador: Integer;
    frmFatMostraPedSalRes : TfrmFatMostraPedSalRes;

    function fRetQtdSeparada(ANumDoc, AEspDoc, AEmpDoc, ACodIte : String) : Double;
      Const
        SQL = 'SELECT                              '+
              '  IFNULL(SUM(LDO_QTDSEP), 0) AS TOT '+
              'FROM                         '+
              '  FATDOR                     '+
              '  LEFT JOIN LOTDOR ON (LOTDOR.LDO_SEQFDO = FATDOR.AUTOINCREM) '+
              'WHERE                      '+
              '  FDO_NUMDOC = :NUMDOC AND '+
              '  FDO_ESPDOC = :ESPDOC AND '+
              '  FDO_CODEMP = :CODEMP AND '+
              '  FDO_CODITE = :CODITE';
      Var
        qrySalSep : TUniQuery;
    begin

      Result := 0;

      If ANumDoc.IsEmpty Then
        Exit;

      If AEspDoc.IsEmpty Then
        Exit;

      If AEmpDoc.IsEmpty Then
        Exit;

      If ACodIte.IsEmpty Then
        Exit;

      qrySalSep := fCriaQuery();

      Try

        qrySalSep.Close;
        qrySalSep.SQL.Clear;
        qrySalSep.SQL.Add(SQL);
        qrySalSep.ParamByName('NUMDOC').AsString := ANumDoc;
        qrySalSep.ParamByName('ESPDOC').AsString := AEspDoc;
        qrySalSep.ParamByName('CODEMP').AsString := AEmpDoc;
        qrySalSep.ParamByName('CODITE').AsString := ACodIte;
        qrySalSep.Open;

        Result := qrySalSep.FieldByName('TOT').AsFloat;

      Finally
        FreeAndNil(qrySalSep);
      End;

    end;

begin
  inherited;

  stlListaEmpresas := TStringList.Create;
  stlListaEmpresas.CommaText := strCodEmp;

  cdsSalRes := TUniClientDataSet.Create(Nil);
  cdsSalRes.FieldDefs.Add('FDO_NUMDOC', ftString, fTamDocCadRec, False);
  cdsSalRes.FieldDefs.Add('FDO_CODEMP', ftString, 03, False);
  cdsSalRes.FieldDefs.Add('FDO_CODVEN', ftString, 03, False);
  cdsSalRes.FieldDefs.Add('OPE_NOMOPE', ftString, 100, False);
  cdsSalRes.FieldDefs.Add('FDO_DTAENT', ftDate,   00, False);
  cdsSalRes.FieldDefs.Add('FGO_PREVIS', ftDate,   00, False);
  cdsSalRes.FieldDefs.Add('FDO_DTENTR', ftDate,   00, False);
  cdsSalRes.FieldDefs.Add('CLI_CODCLI', ftString, 08, False);
  cdsSalRes.FieldDefs.Add('CLI_NOMCLI', ftString, 60, False);
  cdsSalRes.FieldDefs.Add('FDO_QTDPED', ftFloat,  00, False);
  cdsSalRes.FieldDefs.Add('FDO_QTDGAR', ftFloat,  00, False);
  cdsSalRes.FieldDefs.Add('FDO_QTDORP', ftFloat,  00, False);
  cdsSalRes.FieldDefs.Add('FDO_QTDEND', ftFloat,  00, False);
  cdsSalRes.FieldDefs.Add('FDO_QTDDEV', ftFloat,  00, False);
  cdsSalRes.FieldDefs.Add('LDO_QTDSEP', ftFloat,  00, False);
  cdsSalRes.FieldDefs.Add('EQU_NUMOSE', ftString, 06, False);
  cdsSalRes.FieldDefs.Add('EQU_STATUS', ftString, 20, False);
  cdsSalRes.FieldDefs.Add('FGO_CORTE_', ftString, 01, False);
  cdsSalRes.FieldDefs.Add('FDO_ESPDOC', ftString, 02, False);
  cdsSalRes.FieldDefs.Add('FDO_UNITAR', ftFloat , 00, False);
  cdsSalRes.FieldDefs.Add('TABELA'    , ftString, 50, False);
  cdsSalRes.FieldDefs.Add('DOCENT'    , ftString, 50, False);
  cdsSalRes.FieldDefs.Add('CODREQ'    , ftString, 50, False);
  cdsSalRes.FieldDefs.Add('SEPIMP'    , ftString, 8 , False);
  cdsSalRes.FieldDefs.Add('NUMLOT'    , ftString, 200, False);
  If blnExibeCidade Then
  Begin
    cdsSalRes.FieldDefs.Add('CID_NOMCID', ftString, 40, False);
    cdsSalRes.FieldDefs.Add('CID_ESTADO', ftString, 2 , False);
  End;
  cdsSalRes.CreateDataSet;

  qrySalRes := fCriaQuery(Nil);

  For intContador := 0 To stlListaEmpresas.Count - 1 Do
  Begin
    strEmp_CD := fCfgSis('EMP_CD', varString, stlListaEmpresas[intContador]);

    strSQL    := fGetSQLSaldoRes(strEmp_CD,  blnMostrarRequisicao, blnExibeCidade, dtaInicial, dtaFinal, tfdTipoFiltroData);

    With qrySalRes Do
    Begin
      fltCnvMl := fCampoTabela('ITE_CNV_ML','CADITE',['ITE_CODITE'],[strCodIte]);
      If  fltCnvMl = 0 Then
        fltCnvMl := 1;

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := stlListaEmpresas[intContador];
      ParamByName('CODITE').AsString := strCodIte;

      If Assigned(qrySalRes.FindParam('EMPITE')) Then
        ParamByName('EMPITE').AsString := stlListaEmpresas[intContador];

      If Assigned(qrySalRes.FindParam('DTAINI')) Then
        ParamByName('DTAINI').AsDateTime := dtaInicial;

      If Assigned(qrySalRes.FindParam('DTAFIN')) Then
        ParamByName('DTAFIN').AsDateTime := dtaFinal;

      Open;

      If (Not IsEmpty) Then
      Begin

        First;
        While Not Eof Do
        Begin
          If (FieldByName('FDO_QTDPED').AsFloat = 0) And (FieldByName('FDO_QTDGAR').AsFloat = 0) Then
            fltQtdeIte := TSaldoReservado.New(
                            TReservaParametros.New()
                              .EmpresaItem(stlListaEmpresas[intContador])
                              .CodigoItem(strCodIte)
                              .NumeroDocumento(FieldByName('FDO_NUMDOC').AsString)
                              .CodEmpresa(stlListaEmpresas[intContador])
                              .TipoFiltroDocumento(tfdFiltrarDocumento)
                              .TipoReserva(trsPedidoVenda)
                              .DesconsideraPedidosCorte(False)
                              .DesconsideraPedidosEnderecamento(True)
                            ).fGetQuantidade()
          Else
            fltQtdeIte := FieldByName('FDO_QTDPED').AsFloat;


          If (fltQtdeIte > 0) Or (FieldByName('FDO_QTDGAR').AsFloat > 0) Or
             (FieldByName('FDO_QTDORP').AsFloat > 0) Or (FieldByName('FDO_QTDEND').AsFloat > 0) Then
          Begin
            cdsSalRes.Append;

            If blnMostrarRequisicao Then
              cdsSalRes.FieldByName('CODREQ').AsString   := FieldByName('CODREQ').AsString;

            cdsSalRes.FieldByName('FDO_NUMDOC').AsString   := FieldByName('FDO_NUMDOC').AsString;
            cdsSalRes.FieldByName('FDO_CODEMP').AsString   := FieldByName('FDO_CODEMP').AsString;
            cdsSalRes.FieldByName('FDO_CODVEN').AsString   := FieldByName('FDO_CODVEN').AsString;
            cdsSalRes.FieldByName('OPE_NOMOPE').AsString   := FieldByName('OPE_NOMOPE').AsString;
            cdsSalRes.FieldByName('FDO_DTAENT').AsDateTime := FieldByName('FDO_DTAENT').AsDateTime;

            if not FieldByName('FDO_DTENTR').IsNull then
              cdsSalRes.FieldByName('FDO_DTENTR').AsDateTime := FieldByName('FDO_DTENTR').AsDateTime
            else
              cdsSalRes.FieldByName('FDO_DTENTR').Clear;

            if not FieldByName('FGO_PREVIS').IsNull then
              cdsSalRes.FieldByName('FGO_PREVIS').AsDateTime := FieldByName('FGO_PREVIS').AsDateTime
            else
              cdsSalRes.FieldByName('FGO_PREVIS').Clear;

            cdsSalRes.FieldByName('CLI_CODCLI').AsString   := FieldByName('CLI_CODCLI').AsString;
            cdsSalRes.FieldByName('CLI_NOMCLI').AsString   := FieldByName('CLI_NOMCLI').AsString;

            cdsSalRes.FieldByName('FDO_QTDPED').AsFloat    := fltQtdeIte * fltCnvMl;

            cdsSalRes.FieldByName('FDO_QTDEND').AsFloat    := FieldByName('FDO_QTDEND').AsFloat * fltCnvMl;
            cdsSalRes.FieldByName('FDO_QTDDEV').AsFloat    := FieldByName('DEVPEN').AsFloat * fltCnvMl;
            cdsSalRes.FieldByName('FDO_QTDGAR').AsFloat    := FieldByName('FDO_QTDGAR').AsFloat * fltCnvMl;
            cdsSalRes.FieldByName('FDO_QTDORP').AsFloat    := FieldByName('FDO_QTDORP').AsFloat * fltCnvMl;
            cdsSalRes.FieldByName('EQU_NUMOSE').AsString   := FieldByName('EQU_NUMOSE').AsString;
            cdsSalRes.FieldByName('EQU_STATUS').AsString   := FieldByName('EQU_STATUS').AsString;
            cdsSalRes.FieldByName('FGO_CORTE_').AsString   := FieldByName('FGO_CORTE_').AsString;
            cdsSalRes.FieldByName('FDO_ESPDOC').AsString   := FieldByName('FDO_ESPDOC').AsString;
            cdsSalRes.FieldByName('FDO_UNITAR').AsFloat    := FieldByName('FDO_UNITAR').AsFloat;
            cdsSalRes.FieldByName('NUMLOT').AsString       := FieldByName('NUMLOT').AsString;

            If (FieldByName('TABELA').AsString = 'MOVGAD') Then
              cdsSalRes.FieldByName('TABELA').AsString := 'GARANTIA'
            Else If (FieldByName('TABELA').AsString = 'DETPRO') Then
              cdsSalRes.FieldByName('TABELA').AsString := 'ORD.PROD.'
            Else
            If not fEmptyStr(FieldByName('FGO_ORDIND').AsString) Then
            Begin
              strNumOpe := fCampoTabela('CONCAT("OP-", ORD_CODORD, " ", DATE_FORMAT(ORD_DTACAD,"%d/%m/%y"))', 'ORDGER', ['AUTOINCREM'], [FieldByName('FGO_ORDIND').AsString]);
              cdsSalRes.FieldByName('TABELA').AsString := 'RESERVA - ' + strNumOpe;
              cdsSalRes.FieldByName('CLI_NOMCLI').Clear;
            End
            Else
              cdsSalRes.FieldByName('TABELA').AsString := 'PEDIDO';

            cdsSalRes.FieldByName('SEPIMP').AsString := FieldByName('SEPIMP').AsString;

            pEnderecamentoToDocumento(FieldByName('FGO_DOCEND').AsString, regEndDoc);

            With regEndDoc Do
            If Not fEmptyStr(strNumDoc) Then
              cdsSalRes.FieldByName('DOCENT').AsString := strEspDoc + '-' + strNumDoc + '-' + stlListaEmpresas[intContador] + '-' + strSerie_ + '-' +
                 strCliFor + '-' + IIF(strTip_FC = 'C', fRetNomCliente(strCliFor), fRetNomFornecedor(strCliFor));

            If fUsaRotinaWMS Then
              cdsSalRes.FieldByName('LDO_QTDSEP').AsFloat := fRetQtdSeparada(cdsSalRes.FieldByName('FDO_NUMDOC').AsString,
                                                                             cdsSalRes.FieldByName('FDO_ESPDOC').AsString,
                                                                             cdsSalRes.FieldByName('FDO_CODEMP').AsString,
                                                                             strCodIte);
            If blnExibeCidade Then
            Begin
              cdsSalRes.FieldByName('CID_NOMCID').AsString := FieldByName('CID_NOMCID').AsString;
              cdsSalRes.FieldByName('CID_ESTADO').AsString := FieldByName('CID_ESTADO').AsString;
            End;

            cdsSalRes.Post;
          End;

          Next;
        End; {While Not Eof Do}

      End; {If (Not IsEmpty) Then}

    End; {With qrySalRes Do}

  End; {For intContador := 0 To stlListaEmpresas.Count - 1 Do}

  If Not cdsSalRes.IsEmpty Then
  Begin

    Try
      pCriarFormularios(TfrmFatMostraPedSalRes, frmFatMostraPedSalRes);
      frmFatMostraPedSalRes.pMostraDocumentoSalRes := pMostraDocumentoSalRes;
      frmFatMostraPedSalRes.CODREQ.Visible    := blnMostrarRequisicao;
      frmFatMostraPedSalRes.chkSemReq.Visible := blnMostrarRequisicao;

      frmFatMostraPedSalRes.CID_NOMCID.Visible := blnExibeCidade;
      frmFatMostraPedSalRes.CID_ESTADO.Visible := blnExibeCidade;

      if blnMaximizado then
        frmFatMostraPedSalRes.WindowState := wsMaximized;

      frmFatMostraPedSalRes.dtsSalRes.DataSet := cdsSalRes;
      frmFatMostraPedSalRes.edtItem.Text := strCodIte + ' - ' + fRetNomProduto(strCodIte);
      frmFatMostraPedSalRes.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatMostraPedSalRes.pExibeDocsSaldosReservado]');
    End;
    pFreeAndNil(frmFatMostraPedSalRes);

  End
  Else
    fMensagem('', 'Não há pedidos reservando esse item!', ['&O k']);

  qrySalRes.Close;

  FreeAndNil(cdsSalRes);
  FreeAndNil(qrySalRes);
  FreeAndNil(stlListaEmpresas);
end;

end.
