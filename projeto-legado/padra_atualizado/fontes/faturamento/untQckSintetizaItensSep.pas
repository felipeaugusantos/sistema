unit untQckSintetizaItensSep;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, Uni, StrUtils,
  frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  MaskUtils, untIFuncoes, untCfgRel, frxDMPClass, Forms, Data.DB, untZClient, UniClientDataSet, Vcl.ComCtrls,
  Datasnap.DBClient, MemDS, DBAccess, Datasnap.Provider, UniDataSetProvider,
  Vcl.Dialogs, System.Variants;

type
  TfrmQckSintetizaItensSep = class(TForm)
    frxItensSintetizados1: TfrxDBDataset;
    frxReport: TfrxReport;
    frxReport40CJ: TfrxReport;
    frxReportWMS: TfrxReport;
    frxReportWMSOndaGrossa: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    function fLayoutPossuiSaldoDisponivel(frx: TfrxReport): Boolean;
    procedure pCalculaSaldoDisponivelItens();
  private
    { Private declarations }
  public
    { Public declarations }

    cdsRelatorio  : TZClient;

    strNumeroOnda : String;
    strNumeroDcto : String;

    procedure pImprimir(strSQL,
                        strFila,
                        strDestino,
                        strSeparador  : String;
                        strNumeroOnda : String = '';
                        blnOndaGrossa : Boolean = False;
                        blnOndaFina   : Boolean = False;
                        strNomImp     : String = '';
                        blnExibeMsg   : Boolean = True;
                        blnSolicitarImpressora : Boolean = False);
  end;

var
  frmQckSintetizaItensSep: TfrmQckSintetizaItensSep;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica, untTypesSistema, untGravando,
  untGeraExcel, untModulo;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TfrtQckTeste }

procedure TfrmQckSintetizaItensSep.DataModuleCreate(Sender: TObject);
var
  intContador: integer;
begin
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;

  End;
end;

procedure TfrmQckSintetizaItensSep.pImprimir(strSQL,
                                             strFila,
                                             strDestino,
                                             strSeparador  : String;
                                             strNumeroOnda : String = '';
                                             blnOndaGrossa : Boolean = False;
                                             blnOndaFina   : Boolean = False;
                                             strNomImp     : String = '';
                                             blnExibeMsg   : Boolean = True;
                                             blnSolicitarImpressora : Boolean = False);
var
  strTipImp     : String;
  strDoc        : String;
  stlDocs       : TStringList;
  Documento     : TArray<String>;
  blnImpressao  : Boolean;
  strQtdPedidos : String;
  blnPodeImprimir : Boolean;
  blnEstaImprimindoOndaFinaOuGrossa : Boolean;
  strImpressoraSolicitada : String;
begin

  Self.strNumeroOnda := strNumeroOnda;

  blnImpressao := False;

  cdsRelatorio := TZClient.Create(Self, strSQL);
  cdsRelatorio.fAbreClient(True, 'pImprimir');

  frxItensSintetizados1.DataSet := cdsRelatorio;

  try

    blnEstaImprimindoOndaFinaOuGrossa := (blnOndaGrossa Or blnOndaFina);

    blnPodeImprimir := (cdsRelatorio.RecordCount > 0);

    If (blnPodeImprimir) And (blnSolicitarImpressora) Then
    Begin
      strImpressoraSolicitada := EmptyStr;
      If (Not TCfgRel.fExecutePrintDialog(strImpressoraSolicitada)) Then
        Exit;
      strNomImp := strImpressoraSolicitada;
    End;

    If fEmptyStr(strNomImp) Then
      pCarregaConfImprRel(strFila, strNomImp, strTipImp);

    If blnPodeImprimir Then
      If fUsaOndaSeparacaoAgrupamento Then
        If Not blnEstaImprimindoOndaFinaOuGrossa Then
          blnPodeImprimir := False;

    If FileExists(ExtractFilePath(Application.ExeName)+'SEPARACAO_POR_ONDA_40COLS.FR3') Then
    Begin

      frxReport40CJ.LoadFromFile(ExtractFilePath(Application.ExeName)+'SEPARACAO_POR_ONDA_40COLS.FR3');
      frxReport40CJ.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
      frxReport40CJ.PrintOptions.ShowDialog := fEmptyStr(strNomImp);

      frxReport40CJ.Script.Variables['DATA'] := cdsRelatorio.FieldByName('DTAIMP').AsString;
      frxReport40CJ.Script.Variables['HORA'] := cdsRelatorio.FieldByName('HORIMP').AsString;
      frxReport40CJ.Script.Variables['SEPARADOR'] := cdsRelatorio.FieldByName('NSEPEX').AsString;

      If Assigned(cdsRelatorio.FindField('VENDEDOR')) Then
        frxReport40CJ.Script.Variables['VENDEDOR']  := StringReplace(cdsRelatorio.FieldByName('VENDEDOR').AsString, '|', ', ', [rfReplaceAll])
      Else
        frxReport40CJ.Script.Variables['VENDEDOR']  := EmptyStr;

      if frxReport40CJ.PrepareReport then
      begin
        blnImpressao := True;
        if strDestino = 'V' then
        begin
          If blnPodeImprimir Then
            pPreviewReport(strFila, 'Impressão onda separação (itens sintetizados)', frxReport40CJ);
        end
        else
        begin
          frxReport40CJ.PrintOptions.Copies := 1;
          If blnPodeImprimir Then
            pPrintReport(strFila, 'Impressão onda separação (itens sintetizados)', strNomImp, frxReport40CJ);
        end;
      end;

    End
    Else
    Begin

      {Onda + WMS}
      If (fUsaOndaSeparacaoExpedicaoWMS) And (fUsaRotinaWMS) Then
      Begin

        {** Onda Grossa = Agrupamento de Ondas Finas **}
        If (fUsaOndaSeparacaoAgrupamento) And (blnOndaGrossa) Then
        Begin

          frxReportWMSOndaGrossa.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
          frxReportWMSOndaGrossa.PrintOptions.ShowDialog := fEmptyStr(strNomImp);

          if frxReportWMSOndaGrossa.PrepareReport then
          begin
            blnImpressao := True;
            if strDestino = 'V' then
            begin
              pPreviewReport(strFila, 'Impressão onda grossa separação (itens sintetizados)', frxReportWMSOndaGrossa);
            end
            else
            begin
              frxReportWMSOndaGrossa.PrintOptions.Copies := 1;
              pPrintReport(strFila, 'Impressão onda grossa separação (itens sintetizados)', strNomImp, frxReportWMSOndaGrossa);
            end;
          end;

        End
        Else
        Begin
          If FileExists(ExtractFilePath(Application.ExeName)+'FR3\SEPARACAO_POR_ONDA_WMS.FR3') Then
            frxReportWMS.LoadFromFile(ExtractFilePath(Application.ExeName)+'FR3\SEPARACAO_POR_ONDA_WMS.FR3');

          If (frxReportWMS.FindComponent('memOndaFina') <> Nil) Then
            If (frxReportWMS.FindComponent('memOndaFina') Is TfrxMemoView) Then
              TfrxMemoView(frxReportWMS.FindComponent('memOndaFina')).Visible := blnOndaFina;

          frxReportWMS.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
          frxReportWMS.PrintOptions.ShowDialog := fEmptyStr(strNomImp);

          if frxReportWMS.PrepareReport then
          begin
            blnImpressao := True;
            if strDestino = 'V' then
            begin
              If blnPodeImprimir Then
                pPreviewReport(strFila, 'Impressão onda separação (itens sintetizados)', frxReportWMS);
            end
            else
            begin
              frxReportWMS.PrintOptions.Copies := 1;
              If blnPodeImprimir Then
                pPrintReport(strFila, 'Impressão onda separação (itens sintetizados)', strNomImp, frxReportWMS);
            end;
          end;

        End;

      End
      Else
      Begin
        If FileExists(ExtractFilePath(Application.ExeName)+'FR3\SEPARACAO_POR_ONDA.FR3') Then
          frxReport.LoadFromFile(ExtractFilePath(Application.ExeName)+'FR3\SEPARACAO_POR_ONDA.FR3');

        if (fLayoutPossuiSaldoDisponivel(frxReport)) then
          pCalculaSaldoDisponivelItens();

        frxReport.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
        frxReport.PrintOptions.ShowDialog := fEmptyStr(strNomImp);

        if frxReport.PrepareReport then
        begin
          blnImpressao := True;
          if strDestino = 'V' then
          begin
            If blnPodeImprimir Then
              pPreviewReport(strFila, 'Impressão onda separação (itens sintetizados)', frxReport);
          end
          else
          begin
            frxReport.PrintOptions.Copies := 1;
            If blnPodeImprimir Then
              pPrintReport(strFila, 'Impressão onda separação (itens sintetizados)', strNomImp, frxReport);
          end;
        end;

      End;

    End;

    If (blnImpressao) Then
    Begin

      stlDocs := TStringList.Create;
      stlDocs.Duplicates := dupIgnore;
      Try
        cdsRelatorio.First;
        While Not cdsRelatorio.Eof Do
        Begin
          stlDocs.CommaText := stlDocs.CommaText + IIF(stlDocs.CommaText = '', '', ',') +
            cdsRelatorio.FieldByName('DOCUMENTOS').AsString;
          cdsRelatorio.Next;
        End;

        For strDoc In stlDocs Do
        Begin
          Documento := strDoc.Split(['-']);
          If Length(Documento) = 3 Then
          Begin
            pAtualizaSeparadorPedido(Documento[0], Documento[1], Documento[2], strSeparador);
            fMarcarPedidoComoImpresso(Documento[0], Documento[1], Documento[2], True, True);
          End;
        End;

        If blnPodeImprimir Then
        Begin

          strQtdPedidos := cdsRelatorio.FieldByName('TOTPED').AsString;

          If blnExibeMsg And (Not fUsaOndaSeparacaoAgrupamento) Then
            pMensagemOk('Impressão de separação realizada com sucesso!' + #13#10 + '(Quantidade de pedidos: ' + strQtdPedidos + ')');

        End;

      Finally
        stlDocs.Free;
      End;
    end;

  finally
    If Assigned(cdsRelatorio) Then
      FreeAndNil(cdsRelatorio);
  end;

end;

procedure TfrmQckSintetizaItensSep.pCalculaSaldoDisponivelItens();
begin
  if (not Assigned(cdsRelatorio)) or (cdsRelatorio.IsEmpty) then
    Exit;

  if (cdsRelatorio.FindField('SALDIS') = nil) then
    Exit;

  cdsRelatorio.First;

  While Not cdsRelatorio.Eof Do
  Begin
    cdsRelatorio.Edit;
    cdsRelatorio.FieldByName('SALDIS').AsFloat := fRetornaSaldoDisponivel(cdsRelatorio.FieldByName('FDO_CODITE').AsString);
    cdsRelatorio.Post;

    cdsRelatorio.Next;
  End;

  cdsRelatorio.First;
end;

function TfrmQckSintetizaItensSep.fLayoutPossuiSaldoDisponivel(frx: TfrxReport): Boolean;
begin
  Result := True;

  If Assigned(frx.FindObject('mmoSaldis')) Then
    Exit;

  Result := False;
End;

end.
