unit untCtrReciboAdiantamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDMPExport, frxDBSet,
  frxExportPDF, UniClientDataSet, Uni, DB, System.StrUtils, untRcxRecbBaixDocs, UniDataSetProvider, frxDMPClass,
  untFuncoesSimples, untFuncoesGenerica, untValorPorExtenso, untFastPrintEditor, untRelCtrReciboAdiantamento;


Type
  TfrmCtrReciboAdiantamento = class(TForm)
    frxRelReciboColunaJ: TfrxReport;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxPDFExport: TfrxPDFExport;
    frxRelReciboSemChqJ: TfrxReport;
    frxReciboLinhaJ: TfrxReport;
    frxReciboLinhaM: TfrxReport;
    frxRelReciboBobina: TfrxReport;
    frxAuxiliar: TfrxUserDataSet;
    frxChePre: TfrxDBDataset;
    frxCheAvi: TfrxDBDataset;
    frxRelReciboColunaM: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    strTipFil: String;
    strNomImp: String;
    blnPdfInt : Boolean;
    editorFast: TFastPrintFileEditor;
    reciboAd : TRelCtrReciboAdiantamento;
    fltValRec : Double;
    procedure pImprimirModeloColuna(cdsChq : TUniClientDataset; frxRelGen : TfrxReport; intVias : Integer; cdsImpRec : TUniClientDataset);
    procedure pImprimirModeloLinha(cdsChq : TUniClientDataset; frxRelGen : TfrxReport; intVias : Integer; cdsImpRec : TUniClientDataset);
    procedure pImprimirModeloBobina(cdsChq, cdsChqPre, cdsChqVis : TUniClientDataset; frxRelGen : TfrxReport; intVias : Integer; cdsImpRec : TUniClientDataset);
    procedure pTratarImpressaoFast(cdsImpRec : TUniClientDataset; frxRelGen : TfrxReport; intVias : Integer; bTratarCopia : Boolean);
    procedure pTratarComponentesColuna(frxRelGen : TfrxReport; intVias : Integer; cdsImpRec : TUniClientDataset; iLimiteDocs : Integer);
    procedure pTratarExibicaoPaginas(frxRelGen : TfrxReport; intVias : Integer; cdsChq : TUniClientDataset);
    procedure pIniciaObjetos(Var qryImpRec : TUniQuery; Var  qryCheque : TUniQuery; Var  qryGenEmp : TUniQuery;
                             Var dspImpRec : TUniDataSetProvider; Var dspCheque : TUniDataSetProvider;
                             Var cdsImpRec : TUniClientDataset; Var cdsChq : TUniClientDataset; Var cdsChqPre : TUniClientDataset;
                             Var cdsChqVis : TUniClientDataset);
   procedure pAlimentarVias(Var intVias : Integer; cdsImpRec : TUniClientDataset);
  public
    { Public declarations }
    Class Function  fImprimeReciboLayout(cdsImpRec : TUniClientDataSet;
                                   arrCodCli : Array Of TRcxDadosCliente;
                                   cdsChqPre : TUniClientDataSet=NIL;
                                   cdsChqVis : TUniClientDataSet=NIL;
                                   strFilRel : String='';
                                   strTipRel : String='';
                                   blnPDF: Boolean = false) : Boolean;

  end;

var
  frmCtrReciboAdiantamento: TfrmCtrReciboAdiantamento;

implementation

{$R *.dfm}





procedure TfrmCtrReciboAdiantamento.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;
end;



class function TfrmCtrReciboAdiantamento.fImprimeReciboLayout(cdsImpRec : TUniClientDataSet;
                                                         arrCodCli : Array Of TRcxDadosCliente;
                                                         cdsChqPre : TUniClientDataSet=NIL;
                                                         cdsChqVis : TUniClientDataSet=NIL;
                                                         strFilRel : String='';
                                                         strTipRel : String='';
                                                         blnPDF: Boolean = false) : Boolean;
  Var
    frxRelGen: TfrxReport;
    qryGenEmp, qryCheque, qryImpRec : TUniQuery;
    blnReciboCustomizavel: Boolean;
    intCont, intVias  : integer;
    cdsChq : TUniClientDataset;
    dspImpRec: TUniDataSetProvider;
    dspCheque: TUniDataSetProvider;
begin
  Result := False;
  pCriarFormularios(TfrmCtrReciboAdiantamento, frmCtrReciboAdiantamento);
  Try
    Try
      frmCtrReciboAdiantamento.blnPdfInt := blnPDF;

      {DEFINICAO DAS QUERYS/CDS´S E DATA PROVIDERS}
      frmCtrReciboAdiantamento.pIniciaObjetos(qryImpRec, qryCheque, qryGenEmp,
                                              dspImpRec, dspCheque, cdsImpRec,
                                              cdsChq, cdsChqPre, cdsChqVis);

      {CRIACAO DO FASTEDITOR}
      blnReciboCustomizavel := False;
      frmCtrReciboAdiantamento.editorFast := TFastPrintFileEditor.Create(Nil);
      If fEmptyStr(strFilRel) Then
        frmCtrReciboAdiantamento.editorFast.pSelectFil(FILA_IMPRESSAO_RECIBO_AD, frmCtrReciboAdiantamento.strTipFil, frmCtrReciboAdiantamento.strNomImp)
      Else
      Begin
        frmCtrReciboAdiantamento.strNomImp := strFilRel;
        frmCtrReciboAdiantamento.strTipFil := strTipRel;
      End;
      frmCtrReciboAdiantamento.reciboAd  := TRelCtrReciboAdiantamento.CreateInstance(cdsImpRec, cdsChqVis, cdsChqPre, cdsChq, frmCtrReciboAdiantamento.fltValRec, frmCtrReciboAdiantamento.strNomImp,frmCtrReciboAdiantamento.strTipFil);
      frmCtrReciboAdiantamento.editorFast.pSetFastPrintFile(frmCtrReciboAdiantamento.reciboAd);

      If not frmCtrReciboAdiantamento.reciboAd.IsEmpty Then
        blnReciboCustomizavel := frmCtrReciboAdiantamento.editorFast.fLoadReport;

      If blnReciboCustomizavel Then
      begin
        Result := True;

        For intCont := 0 To Length(arrCodCli) -1 Do
        Begin
          frmCtrReciboAdiantamento.fltValRec := arrCodCli[intCont].fltValRec;
          frmCtrReciboAdiantamento.pAlimentarVias(intVias, cdsImpRec);
          frxRelGen := frmCtrReciboAdiantamento.editorFast.FrxReport;

          If fCfgSis('RECRCX') = 'C' Then {COLUNAS}
          Begin
            frmCtrReciboAdiantamento.reciboAd.pFiltraCds( 'CODCLI = ' + QuotedStr(arrCodCli[intCont].strCodCli) );
            frmCtrReciboAdiantamento.pImprimirModeloColuna(cdsChq, frxRelGen, intVias, cdsImpRec);
          End
          Else If fCfgSis('RECRCX') = 'L' Then {LINHAS}
          Begin
            frmCtrReciboAdiantamento.pImprimirModeloLinha(cdsChq, frxRelGen, intVias, cdsImpRec);
          End
          Else If fCfgSis('RECRCX') = 'B' Then {LINHAS}
          begin
            frmCtrReciboAdiantamento.reciboAd.pFiltraCds('CODCLI = ' + QuotedStr(arrCodCli[intCont].strCodCli));
            frmCtrReciboAdiantamento.pImprimirModeloBobina(cdsChq,cdsChqPre,cdsChqVis, frxRelGen, intVias, cdsImpRec);
          End;
        End;
      End;

      FreeAndNil(frxRelGen);
      FreeAndNil(qryGenEmp);
      FreeAndNil(qryImpRec);
      FreeAndNil(qryCheque);
      FreeAndNil(dspImpRec);
      FreeAndNil(dspCheque);
      FreeAndNil(cdsChq);
      FreeAndNil(frmCtrReciboAdiantamento.editorFast);

    Except
      On E: Exception Do
      Begin
        Result := False;
        pGravarErro(True, E.message);
      End
    End


  Finally
      FreeAndNil(frmCtrReciboAdiantamento);
  End;
End;





procedure TfrmCtrReciboAdiantamento.pImprimirModeloColuna(cdsChq : TUniClientDataset; frxRelGen : TfrxReport; intVias : Integer; cdsImpRec : TUniClientDataset);
Var intCont, iLimiteDocs : Integer;
    cdsAux : TUniClientDataset;
    reciboAdInt : TRelCtrReciboAdiantamento;
begin
  Try
    If (strTipFil = 'M') Then
      iLimiteDocs := 16
    else
      iLimiteDocs := 22;

    {INSTANCIO INTERNAMENTE O RECIBO POIS O CLIENT SERÁ MODIFICADO}
    If cdsImpRec.RecordCount > iLimiteDocs Then
    Begin
      cdsAux := TUniClientDataSet.Create(NIL);
      cdsImpRec.IndexFieldNames := 'NUMDOC';
      cdsAux := fCriaClientDatset(cdsImpRec);
      cdsAux.Open;

      reciboAdInt   := TRelCtrReciboAdiantamento.CreateInstance(cdsAux, nil, nil, cdsChq,fltValRec, strNomImp,strTipFil);
    End
    Else
    Begin
      reciboAdInt   := TRelCtrReciboAdiantamento.CreateInstance(cdsImpRec, nil, nil, cdsChq,fltValRec, strNomImp,strTipFil);
    End;
    editorFast.pSetFastPrintFile(reciboAdInt);
    If not reciboAdInt.IsEmpty Then
      editorFast.fLoadReport;

    frxRelGen := editorFast.FrxReport;

    pTratarExibicaoPaginas(frxRelGen, intVias, cdsChq);
    pTratarComponentesColuna(frxRelGen, intVias, cdsImpRec,iLimiteDocs);

    pTratarImpressaoFast(cdsImpRec, frxRelGen,intVias, strTipFil = 'M');

    If cdsImpRec.RecordCount > iLimiteDocs Then
    Begin
      For intCont := 0 To iLimiteDocs - 1 Do
      Begin
        cdsImpRec.First;
        cdsImpRec.Delete;
      End;

      if cdsAux <> nil then
        FreeAndNil(cdsAux);

      pImprimirModeloColuna(cdsChq, frxRelGen, intVias, cdsImpRec);
    End;
  Except
    On E: Exception Do
    Begin
      raise exception.create(E.message);
    End;
  End;
End;

procedure TfrmCtrReciboAdiantamento.pTratarExibicaoPaginas(frxRelGen : TfrxReport; intVias : Integer; cdsChq : TUniClientDataset);
Var intContVias : Integer;
Begin
  If (strTipFil <> 'M') Then {JATO}
  begin
    If intVias > 1 Then
    Begin
      For intContVias := 1 To intVias Do
        frxRelGen.Pages[intContVias].Visible := True;

      {********************************************}
      { Se as vias do recibo saem cada uma em meia }
      { folha não imprime informações do cheque.   }
      {*****************************************MA*}
       If (fCfgSis('LAYREC') <> '1') Then
       Begin
         If Not cdsChq.IsEmpty Then
         Begin
            {*********************************}
            { Pagamento realizado com chegue  }
            {******************************MA*}
            For intContVias := 1 To intVias Do
              frxRelGen.Pages[intContVias + 5].Visible := True;
         End;
       End;
    End;
  End;
End;

procedure TfrmCtrReciboAdiantamento.pTratarComponentesColuna(frxRelGen : TfrxReport; intVias : Integer; cdsImpRec : TUniClientDataset; iLimiteDocs : Integer);
Var intContVias : Integer;
begin
  If (strTipFil <> 'M') Then {JATO}
  begin
    frxRelGen.FindObject('rllContinua').Visible := (cdsImpRec.RecordCount > iLimiteDocs);
    For intContVias := 2 To intVias - 1 Do
    Begin
      frxRelGen.FindObject('rllContinua' + IntToStr(intContVias) + 'Via').Visible := (cdsImpRec.RecordCount > iLimiteDocs);
    End;

    If (fCfgSis('LAYREC') <> '1') Then
    Begin
      if (fCfgSis('INFREC',varBoolean)) then
        TfrxFooter(frxRelGen.FindObject('rlbCheques')).Child := TfrxChild(frxRelGen.FindObject('rlbEmpresa'))
      else
        TfrxFooter(frxRelGen.FindObject('rlbCheques')).Child := TfrxChild(frxRelGen.FindObject('rlbEmpresa2'));
    End;
  End
  Else
  Begin
    frxRelGen.FindObject('rllContinuaEmp').Visible := (cdsImpRec.RecordCount > iLimiteDocs);
    frxRelGen.FindObject('rllContinuaEmp2').Visible := (cdsImpRec.RecordCount > iLimiteDocs);
  End;
End;



procedure TfrmCtrReciboAdiantamento.pImprimirModeloLinha(cdsChq : TUniClientDataset; frxRelGen : TfrxReport; intVias : Integer; cdsImpRec : TUniClientDataset);
begin
  Try
    //blnResCai = True;
    frxRelGen.FindObject('fooChePre').Visible := (Not cdsChq.IsEmpty);
    pTratarImpressaoFast(cdsImpRec, frxRelGen, intVias, True);
 Except
   On E: Exception Do
   Begin
     raise exception.create(E.message);
   End;
 End;

End;

procedure TfrmCtrReciboAdiantamento.pImprimirModeloBobina(cdsChq, cdsChqPre, cdsChqVis : TUniClientDataset; frxRelGen : TfrxReport; intVias : Integer; cdsImpRec : TUniClientDataset);
 Var
   intCont : Integer;
Begin

  Try
    if Assigned(frxRelGen.FindObject('chiAvisoCheque')) then
      frxRelGen.FindObject('chiAvisoCheque').Visible := (Assigned(cdsChq) And cdsChq.Active And (Not cdsChq.IsEmpty));
    if Assigned(frxRelGen.FindObject('chiChePre')) then
      frxRelGen.FindObject('chiChePre').Visible := (Assigned(cdsChqPre) And cdsChqPre.Active And (Not cdsChqPre.IsEmpty));
    if Assigned(frxRelGen.FindObject('chiCheAvi')) then
      frxRelGen.FindObject('chiCheAvi').Visible := (Assigned(cdsChqVis) And cdsChqVis.Active And (Not cdsChqVis.IsEmpty));

    If Assigned(cdsChqPre) Then
    Begin
      If cdsChqPre.Active Then
        cdsChqPre.First;
    End;

    If Assigned(cdsChqVis) Then
    Begin
      If cdsChqVis.Active Then
        cdsChqVis.First;
    End;

    For intCont := 1 To fCfgSis('QTDSAL', varInteger) Do
      if Assigned(frxRelGen.FindObject('rllSalto')) then
        TfrxMemoView(frxRelGen.FindObject('rllSalto')).Lines.Add('');

    {ESSE MODELO BOBINA NÃO IMPRIME MAIS QUE 1 VIA}
    pTratarImpressaoFast(cdsImpRec, frxRelGen, 1, False);
  Except
    On E: Exception Do
    Begin
      raise exception.create(E.message);
    End;
  End;
End;

procedure TfrmCtrReciboAdiantamento.pTratarImpressaoFast(cdsImpRec : TUniClientDataset; frxRelGen : TfrxReport; intVias : Integer; bTratarCopia : Boolean);
Var sNomeArquivo : String;
    intCont : Integer;
begin
  If blnPDFInt Then
  Begin
    sNomeArquivo := cdsImpRec.FieldByName('NUMDOC').asString + cdsImpRec.FieldByName('PARCEL').asString +
                    cdsImpRec.FieldByName('ESPDOC').asString + cdsImpRec.FieldByName('CODEMP').asString +  fCfgSis('RECRCX');

    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'ReciboAdiantamento') Then
      CreateDir(ExtractFilePath(Application.ExeName) + 'ReciboAdiantamento');

    frxPDFExport.FileName    := sNomeArquivo + '.pdf';
    frxPDFExport.DefaultPath := ExtractFilePath(Application.ExeName) + 'ReciboAdiantamento';
    frxPDFExport.ShowDialog := False;
    frxPDFExport.ShowProgress := False;
  End;


  {EXECUTA O PRINT MAIS DE UMA VEZ, DE ACORDO COM AS VIAS, APENAS PARA ALGUNS RELATORIOS}
  If (bTratarCopia = False) Then
    intVias := 1;

  For intCont := 1 to intVias Do
  Begin
    If frxRelGen.PrepareReport Then
    Begin
      if blnPdfInt then
        frxRelGen.Export(frxPDFExport)
      else
        editorFast.pPrint;
    End;
  End;
end;

procedure TfrmCtrReciboAdiantamento.pIniciaObjetos(Var qryImpRec : TUniQuery; Var  qryCheque : TUniQuery; Var  qryGenEmp : TUniQuery;
                                                   Var dspImpRec : TUniDataSetProvider; Var dspCheque : TUniDataSetProvider;
                                                   Var cdsImpRec : TUniClientDataset; Var cdsChq : TUniClientDataset; Var cdsChqPre : TUniClientDataset;
                                                   Var cdsChqVis : TUniClientDataset);
Var intCont : Integer;
Begin
  {DEFINICAO DAS QUERYS/CDS´S E DATA PROVIDERS}
  qryImpRec := fCriaQuery;
  dspImpRec := TUniDataSetProvider.Create(Nil);
  dspImpRec.DataSet := qryImpRec;
  cdsImpRec.SetProvider(dspImpRec);

  qryCheque := fCriarQuery('SELECT * FROM CADCHQ WHERE FALSE');
  cdsChq := TUniClientDataSet.Create(Nil);
  For intCont := 0 To qryCheque.Fields.Count -1 Do
  begin
    cdsChq.FieldDefs.Add(qryCheque.Fields[intCont].FieldName,qryCheque.Fields[intCont].DataType,qryCheque.Fields[intCont].Size,False);
  End;
  dspCheque := TUniDataSetProvider.Create(Nil);
  dspCheque.DataSet := qryCheque;
  cdsChq.SetProvider(dspCheque);
  cdsChq.CreateDataSet;
  cdsChq.Open;
   pAdicionaCheques(cdsChqPre, cdsChq);
  pAdicionaCheques(cdsChqVis, cdsChq);

  qryGenEmp := fCriaQuery;
  fCadEmp('NOMEMP', qryGenEmp);
End;

procedure TfrmCtrReciboAdiantamento.pAlimentarVias(Var intVias : Integer; cdsImpRec : TUniClientDataset);
Begin
  {TRATAMENTO DE VIAS}
  If fCfgSis('RECRCX') = 'B' Then {Bobina}
  Begin
    If cdsImpRec.FieldByName('ESPDOC').AsString = 'LC' Then
      intVias := fCfgSis('VIASLC', varInteger)
    Else
      intVias := fCfgSis('VIAREC', varInteger);
  End
  else
  begin
    If cdsImpRec.FieldByName('ESPDOC').AsString = 'LC' Then
      intVias := fCfgSis('VIASLC', varInteger)
    Else If cdsImpRec.FieldByName('ESPDOC').AsString = 'PG' Then
      intVias := fCfgSis('VIASPG', varInteger)
    Else If cdsImpRec.FieldByName('ESPDOC').AsString = 'LD' Then
      intVias := fCfgSis('VIASLD', varInteger)
    Else
      intVias := fCfgSis('VIAREC', varInteger);
  End;
  editorFast.intNumeroVias :=  intVias;
End;






end.
