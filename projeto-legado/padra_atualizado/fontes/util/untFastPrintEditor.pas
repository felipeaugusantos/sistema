unit untFastPrintEditor;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema, StrUtils,
  frxClass, frxDBSet, frxDesgn, frxDMPExport, frxExportPDF, frxExportXLS,
  frxBarcode, frxRich, Uni, DB, untFuncoesSimples, untIFastPrint,
  Vcl.Dialogs;

type
  TFastPrintFileEditor = class(TComponent, IFastPrintFileEditor)
    private
      FFrxReport: TfrxReport;
      FFrxDesign: TfrxDesigner;
      FFrxDotMatrix: TfrxDotMatrixExport;
      FFrxExportPDF: TfrxPDFExport;
      FFrxExportXLS: TfrxXLSExport;
      FFrxBarCode: TfrxBarCodeObject;
      FFrxRichObject: TfrxRichObject;
      FFastFile: IFastPrintFile;
      FLayoutName: String;
      FLayImp: TUniQuery;
      FNomPro, FNomFil, FNomeRede: String;
      FNumVias: Integer;
      function fGetLayoutKey: String;
      procedure pAfterLoadReport;
      function GetFr3Layout: String;
      function ArquivoImportacaoValido(Var AFr3 : TStringList): Boolean;
      function SaveImport(AFr3: String): Boolean;
    public
      procedure pSetFastPrintFile(iFastFile: IFastPrintFile);

      function fLoadReport: Boolean;
      function fSaveReport: Boolean;
      function fChanged: Boolean;

      procedure pEditLayout;
      procedure pPreview;
      procedure pExport;
      procedure pImport;
      procedure pPrint;
      procedure pConfigPrinter;
      procedure pSelectFil(strNomPro, strNomFil, strNomeRede: String);

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

    published
      property FrxReport    : TfrxReport read FFrxReport;
      property strLayoutKey : String read fGetLayoutKey;
      Property strLayoutName: String Read FLayoutName Write FLayoutName;
      property intNumeroVias: Integer read FNumVias   write FNumVias;

  end;

implementation

{ TPrintEditor }

function TFastPrintFileEditor.ArquivoImportacaoValido(Var AFr3: TStringList): Boolean;
  Var
    LFrxReport: TfrxReport;
    LStream: TStringStream;
begin
  Try
    LFrxReport := TfrxReport.Create(Nil);
    Result := False;

    Try

      If Not Trim(AFr3[0]).Equals(Trim(FFastFile.fGetKey)) Then
      Begin
        fMensagem('ATENÇÃO','Arquivo selecionado não é compatível com o layout de '+ AnsiLowerCase(FFastFile.fGetName), ['&Ok']);
        Result := False;
        Exit;
      End;

      If Not Trim(AFr3[1]).Equals(IIF((FFastFile.fGetFastType = ffLaser),'L','M' )) Then
      Begin
        fMensagem('ATENÇÃO','Arquivo selecionado não é compatível com o layout.' +#13#10+
                            'Por favor, selecione um arquivo do tipo '+ IIF((FFastFile.fGetFastType = ffLaser),'Jato!','Matricial!' ), ['&Ok']);
        Result := False;
        Exit;
      End;

      AFr3.Delete(0); // Código do layout
      AFr3.Delete(0); // Tipo de impressão

      LStream := TStringStream.Create(AFr3.Text);
      LFrxReport.DotMatrixReport := (FFastFile.fGetFastType = ffMatrix);
      LFrxReport.LoadFromStream(LStream);
      Result := fEmptyStr(LFrxReport.Errors.text);

      If Not Result Then
      Begin
        fMensagem('ATENÇÃO','Não foi possível realizar a importação do arquivo selecionado!', ['&Ok']);
        Exit;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TFastPrintFileEditor.ArquivoImportacaoValido');
      End;
    End;
  Finally
    FreeAndNil(LFrxReport);
  End;
end;

constructor TFastPrintFileEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLayImp       := fCriaQuery(Self);
  FFrxReport    := TfrxReport.Create(Self);
  FFrxDesign    := TfrxDesigner.Create(Self);
  FFrxExportPDF := TfrxPDFExport.Create(Self);
  FFrxExportXLS := TfrxXLSExport.Create(Self);
  FFrxBarcode   := TfrxBarCodeObject.Create(Self);
  FFrxRichObject:= TfrxRichObject.Create(Self);
  FFrxDotMatrix := TfrxDotMatrixExport.Create(Self);
  FFrxDotMatrix.PageBreaks := True;
  FFrxDesign.Restrictions := [drDontSaveReport, drDontLoadReport, drDontCreateReport];
  FNumVias      := 0;
end;

destructor TFastPrintFileEditor.Destroy;
begin
  inherited;
end;

procedure TFastPrintFileEditor.pSelectFil(strNomPro, strNomFil, strNomeRede: String);
Begin
  FNomPro := strNomPro;
  FNomFil := strNomFil;
  FNomeRede := strNomeRede;
End;

procedure TFastPrintFileEditor.pAfterLoadReport;
  var
    intIndex: Integer;
    strKey: String;
begin

  With FFrxReport, FFastFile Do
  Begin
    FFrxReport.DataSets.Clear;
    FFrxReport.Variables.Clear;

    If Assigned(fGetVariables) Then
    Begin
      Variables[' ' + 'Autcom Variables'] := Null;

      //For intIndex := 0 To fGetVariables.Count -1 Do
      For strKey in fGetVariables.Keys Do
        Variables.AddVariable('Autcom Variables',
                              strKey,
                              QuotedStr(fGetVariables[strKey]));
    End;

    For intIndex := 0 To Length(fGetDBDataSets) -1 Do
      DataSets.Add(fGetDBDataSets[intIndex]);

    For intIndex := 0 To Length(fGetUserDataSets) -1 Do
      DataSets.Add(fGetUserDataSets[intIndex]);

    If Assigned(fGetFunctionsList) Then
    Begin
      For intIndex := 0 To fGetFunctionsList.Count -1 Do
        AddFunction(fGetFunctionsList[intIndex], 'Autcom Functions');
    End;

    DotMatrixReport := (fGetFastType = ffMatrix);

    OnUserFunction := fGetUserFunction;
  End;

end;

procedure TFastPrintFileEditor.pConfigPrinter;
begin
  FFastFile.pConfigTypeAndPrinterName;
end;

procedure TFastPrintFileEditor.pEditLayout;
begin
  FFrxReport.DesignReport;
end;

procedure TFastPrintFileEditor.pExport;
  Var
    svdArquivo: TSaveDialog;
    FNomArq: String;
    stlRegistro: TStringList;
begin
  Try
    stlRegistro := TStringList.Create;
    stlRegistro.Add(GetFr3Layout);

    If fEmptyStr(stlRegistro.Text) Then
    Begin
      pMensagemOk('É necessário configurar um layout para realizar a exportação!');
      Exit;
    End;

    svdArquivo := TSaveDialog.Create(Nil);
    svdArquivo.Filter := 'Arquivos de Layout|*.fr3';
    svdArquivo.DefaultExt := 'fr3';
    svdArquivo.FileName := FFastFile.fGetKey +'-'+ IIF((FFastFile.fGetFastType = ffLaser),'Jato','Matricial' ) ;

    If svdArquivo.Execute Then
    Begin
      Try
        FNomArq := svdArquivo.FileName;

        If Not SameText(RightStr(LowerCase(FNomArq), 4), '.fr3') Then
          FNomArq := FNomArq + '.fr3';

        stlRegistro.SaveToFile(FNomArq);

        pMensagemOk('Layout exportado com sucesso!');
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, 'TFastPrintFileEditor.pExportar');
        End;
      End;
    End;

  Finally
    FreeAndNil(svdArquivo);
    FreeAndNil(stlRegistro);
  End
end;

procedure TFastPrintFileEditor.pImport;
  Var
    opdArquivo: TOpenDialog;
    FNomArq: String;
    stlRegistro: TStringList;
begin
  Try
    opdArquivo := TOpenDialog.Create(Nil);
    stlRegistro := TStringList.Create;
    opdArquivo.Filter := 'Arquivos de Layout|*.fr3';
    opdArquivo.DefaultExt := 'fr3';

    If opdArquivo.Execute Then
    Try
      FNomArq := opdArquivo.FileName;

      stlRegistro.LoadFromFile(FNomArq);

      If ArquivoImportacaoValido(stlRegistro) Then
      Begin
        If SaveImport(stlRegistro.Text) Then
        Begin
          pMensagemOk('Layout importado com sucesso!');
        End;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TFastPrintFileEditor.pImportar;');
      End;
    End;
  Finally
    FreeAndNil(stlRegistro);
    FreeAndNil(opdArquivo);
  End;
end;

function TFastPrintFileEditor.fChanged: Boolean;
  Var
    qryAux: TUniQuery;
    strLay: String;
    mmsReport: TMemoryStream;
Begin
  If FLayImp.IsEmpty Then
  Begin
    Result := True;
    Exit;
  End;

  qryAux := fCriaQuery(Self);
  With qryAux Do
  Begin
    SQL.Text := 'SELECT * FROM LAYIMP WHERE FALSE';
    Open;
    Insert;

    mmsReport := TMemoryStream.Create;
    FFrxReport.SaveToStream(mmsReport);

    TBlobField(FieldByName('LAY_RELFR3')).LoadFromStream(mmsReport);
    strLay := FieldByName('LAY_RELFR3').AsString;
    Cancel;

    Result := strLay <> FLayImp.FieldByName('LAY_RELFR3').AsString;

    FreeAndNil(mmsReport);
    FreeAndNil(qryAux);
  End;
end;

function TFastPrintFileEditor.fGetLayoutKey: String;
begin
  If Assigned(FFastFile) Then
    Result := FFastFile.fGetKey;
end;

function TFastPrintFileEditor.fLoadReport: Boolean;
 Var
   mmsLoad: TStream;
Begin
  Result := False;
  
  Try
    With FLayImp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM ');
      Add('  LAYIMP');
      Add('WHERE');
      Add('  LAY_TIPLAY = :TIPLAY AND ');
      Add('  LAY_CODEMP = :CODEMP AND ');
      Add('  LAY_CODLAY = :CODLAY     ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLAY').AsString := FFastFile.fGetKey;

      Case FFastFile.fGetFastType Of
        ffLaser  : ParamByName('TIPLAY').AsString := 'L';
        ffMatrix : ParamByName('TIPLAY').AsString := 'M';
      End;

      Add('ORDER BY');
      Add('  LAY_DTAALT DESC,');
      Add('  LAY_HORALT DESC ');
      Add('LIMIT 1');

      Open;

      If Not IsEmpty Then
      Begin
        Result := True;
        FLayoutName := FieldByName('LAY_DESCRI').AsString;
        mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);
        FFrxReport.LoadFromStream(mmsLoad);
        FreeAndNil(mmsLoad);
      End;

    End;

    pAfterLoadReport;    

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;

End;

Function TFastPrintFileEditor.fSaveReport: Boolean;
  Var
    mmsReport: TMemoryStream;
Begin
  Try

    mmsReport := TMemoryStream.Create;
    FFrxReport.SaveToStream(mmsReport);

    fStartTransaction;

    With FLayImp Do
    Begin
      Close;
      Sql.Text := 'SELECT * FROM LAYIMP WHERE FALSE';
      Open;

      Append;
      FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LAYIMP', VS_strCodEmp);
      FieldByName('LAY_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('LAY_CODLAY').AsString   := FFastFile.fGetKey;
      FieldByName('LAY_NOMLAY').AsString   := FFastFile.fGetName;
      FieldByName('LAY_DTAALT').AsDateTime := VS_Date;
      FieldByName('LAY_HORALT').AsDateTime := fTime();
      FieldByName('LAY_DESCRI').AsString   := FLayoutName;

      TBlobField(FieldByName('LAY_RELFR3')).LoadFromStream(mmsReport);      

      Case FFastFile.fGetFastType Of
        ffLaser  : FieldByName('LAY_TIPLAY').AsString := 'L';
        ffMatrix : FieldByName('LAY_TIPLAY').AsString := 'M';
      End;

      Post;
    End;

    fCommit;
    FreeAndNil(mmsReport);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '');
    End;
  End;

End;

function TFastPrintFileEditor.GetFr3Layout: String;
 Var
   LLayImp: TUniQuery;
Begin
  Result := '';

  LLayImp := fCriaQuery(Nil);
  try
    Try
      LLayImp.Close;
      LLayImp.Sql.Clear;
      LLayImp.Sql.Add('SELECT * FROM ');
      LLayImp.Sql.Add('  LAYIMP');
      LLayImp.Sql.Add('WHERE');
      LLayImp.Sql.Add('  LAY_TIPLAY = :TIPLAY AND ');
      LLayImp.Sql.Add('  LAY_CODEMP = :CODEMP AND ');
      LLayImp.Sql.Add('  LAY_CODLAY = :CODLAY     ');

      LLayImp.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LLayImp.ParamByName('CODLAY').AsString := FFastFile.fGetKey;

      Case FFastFile.fGetFastType Of
        ffLaser  : LLayImp.ParamByName('TIPLAY').AsString := 'L';
        ffMatrix : LLayImp.ParamByName('TIPLAY').AsString := 'M';
      End;

      LLayImp.Sql.Add('ORDER BY');
      LLayImp.Sql.Add('  LAY_DTAALT DESC,');
      LLayImp.Sql.Add('  LAY_HORALT DESC ');
      LLayImp.Sql.Add('LIMIT 1');

      LLayImp.Open;

      If Not LLayImp.IsEmpty Then
      Begin
        Result := LLayImp.FieldByName('LAY_CODLAY').AsString +#13#10+
                  LLayImp.FieldByName('LAY_TIPLAY').AsString +#13#10+
                  LLayImp.FieldByName('LAY_RELFR3').AsString;
      End;

    Except
      On E: Exception Do
      Begin
        Result := '';
        pMensagensErro(E.Message, '[TFastPrintFileEditor.GetFr3Layout]');
      End;
    End;
  finally
    FreeAndNil(LLayImp);
  end;
End;

procedure TFastPrintFileEditor.pPreview;
begin
  if FNumVias <> 0 then
    FFrxReport.PrintOptions.Copies := FNumVias;

  If FFrxReport.PrepareReport Then
    pPreviewReport(FNomPro, FFastFile.fGetName, FFrxReport);
end;

procedure TFastPrintFileEditor.pPrint;
begin
  If (FNomFil <> '') Then
  Begin
    FFrxReport.PrintOptions.ShowDialog := False;
    FFrxReport.PrintOptions.Printer := AnsiReplaceStr(FNomFil,'\\' + FNomeRede + '\','');
  End
  Else
  Begin
    FFrxReport.PrintOptions.Printer := FFastFile.fGetPrinterName;
    FFrxReport.PrintOptions.ShowDialog := (FFastFile.fGetPrinterName = EmptyStr);
  End;

  if FNumVias <> 0 then
    FFrxReport.PrintOptions.Copies := FNumVias;

  If FFrxReport.PrepareReport Then
    pPrintReport(FNomPro, FFastFile.fGetName, FNomFil, FFrxReport);
end;

procedure TFastPrintFileEditor.pSetFastPrintFile(iFastFile: IFastPrintFile);
begin
  FFastFile := iFastFile;
  FFastFile.fPrepareDataSetsAndVariables;
end;

function TFastPrintFileEditor.SaveImport(AFr3: String): Boolean;
  Var
    LLayImp : TUniQuery;
Begin
  Try
    LLayImp := fCriaQuery(Nil);

    fStartTransaction;

    LLayImp.Close;
    LLayImp.Sql.Text := 'SELECT * FROM LAYIMP WHERE FALSE';
    LLayImp.Open;

    Try
      LLayImp.Append;
      LLayImp.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LAYIMP', VS_strCodEmp);
      LLayImp.FieldByName('LAY_CODEMP').AsString   := VS_strCodEmp;
      LLayImp.FieldByName('LAY_CODLAY').AsString   := FFastFile.fGetKey;
      LLayImp.FieldByName('LAY_NOMLAY').AsString   := FFastFile.fGetName;
      LLayImp.FieldByName('LAY_DTAALT').AsDateTime := VS_Date;
      LLayImp.FieldByName('LAY_HORALT').AsDateTime := fTime();
      LLayImp.FieldByName('LAY_DESCRI').AsString   := FLayoutName;
      LLayImp.FieldByName('LAY_RELFR3').AsString   := AFr3;

      Case FFastFile.fGetFastType Of
        ffLaser  : LLayImp.FieldByName('LAY_TIPLAY').AsString := 'L';
        ffMatrix : LLayImp.FieldByName('LAY_TIPLAY').AsString := 'M';
      End;

      LLayImp.Post;
      fCommit;
      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    FreeAndNil(LLayImp);
  End;
End;

end.
