{*****************************************}
{* CLASSE DE Writer(Word) PARA BR-OFFICE *}
{*17/02/2012***************************AF*}
unit untWordBRO;

interface

uses Classes, Dialogs, ComObj, Variants, untWord, SysUtils;

type
  TWordBRO = Class(TWord)
  Private
    Desktop: Variant;
    Principal:Variant;
    FNomArq: String;
    qtdTabelas: Integer;
    intIdxTabAtual: Integer;
    function fFormataDir(strArquivo: String): String;
    function fAtribuiProperty(Nome: String; Valor: Variant): Variant;
    procedure fExecuta(strComando: String; varParams: Variant);
    procedure pCelulaPosiciona(intLinha, intColuna, intIdxTab: Integer);
    procedure DefinirFonte;
  public
    procedure pGoToPageHeader; Override;
    procedure pGoToMainDocument; Override;
    procedure pGoToPageFooter; Override;
    procedure pInsereImagem(strPath: String); overload; Override;
    procedure pInsereImagem(strPath: String; strSearcStringImagem: String); overload; Override;
    procedure pReplace(strOri, strDes: String); Override;
    procedure pCriaTabela(strChave: String; intQtdLin, intQtdCol: Integer); Override;
    procedure pCelulaNegrito(intLinha, intColuna: Integer); Override;
    procedure pOtimizaTamanho(intLinha, intColuna, intTamanho : Integer); Override;
    procedure pCelulaEscreve(intLinha, intColuna: Integer; strTexto: String); Override;
    procedure pCelulaAlignRight(intLinha, intColuna: Integer); Override;
    procedure pSalvar; Override;
    procedure pSalvarSemPerguntarFormato; Override;
    procedure pSetarImpressora(strPrinter: String); Override;
    procedure pPrint; Override;
    procedure pFechar; Override;
    procedure pSaveAsHtml;Override;
    function AbrirArquivo(Nome_Arquivo: String): Boolean; Override;
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;
    procedure SaveAsPDF(const ATargetFileURL: string);Override;
    procedure pCelulaAlignCenter(intLinha, intColuna: Integer); Override;

  end;

implementation

{ TWordBRO }

function TWordBRO.AbrirArquivo(Nome_Arquivo: String): Boolean;
  Var
    parametro: Variant;
begin
  Result := False;
  If FileExists(Nome_Arquivo) Then
  Begin
    parametro    := VarArrayCreate([0, 0], varVariant);
    parametro[0] := fAtribuiProperty('Hidden', True);

    Documento := Desktop.LoadComponentFromURL(fFormataDir(Nome_Arquivo), '_blank', 0, parametro);
    Documento.getCurrentController.getFrame.getContainerWindow.setVisible(False);

    Texto := Documento.getText;

    FNomArq := Nome_Arquivo;
    Result  := True;
  End;
end;

function TWordBRO.fFormataDir(strArquivo: String): String;
begin
  Result:= '';

  If AnsiLowerCase(Copy(strArquivo,1,8)) <> 'file:///' Then
    Result := 'file:///';

  Result := Result + StringReplace(strArquivo, '\', '/', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TWordBRO.pCelulaAlignCenter(intLinha, intColuna: Integer);
  Var
    parametro: Variant;
    intIdxTab: Integer;
begin
  inherited;
  For intIdxTab := 1 to qtdTabelas Do
  Begin
    If intIdxTab =  intIdxTabAtual Then
    Begin
      pCelulaPosiciona(intLinha, intColuna, intIdxTab);

      parametro    := VarArrayCreate([0, 0], varVariant);
      parametro[0] := fAtribuiProperty('CenterPara', True);
      fExecuta('.uno:CenterPara',parametro);
    End;
  End;

end;

procedure TWordBRO.pCelulaAlignRight(intLinha, intColuna: Integer);
  Var
    parametro: Variant;
    intIdxTab: Integer;
begin
  inherited;
  For intIdxTab := 1 to qtdTabelas Do
  Begin
    If intIdxTab =  intIdxTabAtual Then
    Begin
      pCelulaPosiciona(intLinha, intColuna, intIdxTab);

      parametro    := VarArrayCreate([0, 0], varVariant);
      parametro[0] := fAtribuiProperty('RightPara', True);
      fExecuta('.uno:RightPara',parametro);
    End;
  End;
end;

procedure TWordBRO.pCelulaEscreve(intLinha, intColuna: Integer; strTexto: String);
  Var
    Table,
    Point: Variant;
    intIdxTab: Integer;
begin
  inherited;
  For intIdxTab := 1 to qtdTabelas Do
  Begin
    If intIdxTab = intIdxTabAtual Then
    Begin
    Table := Documento.getTextTables.getByName('TABELA_' + IntToStr(intIdxTab));
      Point := Table.getCellByPosition(intColuna-1, intLinha-1);

      Documento.currentcontroller.getViewCursor.gotoRange(Point.getStart,False);
      DefinirFonte;
      Point.setString(strTexto);
    End;
  End;
end;

procedure TWordBRO.pCelulaNegrito(intLinha, intColuna: Integer);
  Var
    parametro: Variant;
    intIdxTab: Integer;
begin
  inherited;
  For intIdxTab := 1 to qtdTabelas Do
  Begin
    If intIdxTabAtual = intIdxTab Then
    Begin
      pCelulaPosiciona(intLinha, intColuna, intIdxTab);

      parametro    := VarArrayCreate([0, 0], varVariant);
      parametro[0] := fAtribuiProperty('Bold', True);
      fExecuta('.uno:Bold',parametro);
    End;
  End;
end;

procedure TWordBRO.pOtimizaTamanho(intLinha, intColuna, intTamanho : Integer);
  Var
    parametro : Variant;
    intIdxTab : Integer;
begin
  //*********************************************************************//
  // O parâmetro intTamanho não é usado aqui, somente no Word(Microsoft).//
  // Aqui usa o comando para ajustar a coluna através do conteúdo        //
  // da linha e coluna enviados.                                         //
  //*********************************************************************//
  inherited;
  For intIdxTab := 1 to qtdTabelas Do
  Begin
    If intIdxTabAtual = intIdxTab Then
    Begin
      pCelulaPosiciona(intLinha, intColuna, intIdxTab);

      parametro    := VarArrayCreate([0, 0], varVariant);
      fExecuta('.uno:SetOptimalColumnWidth', parametro);
    End;
  End;
end;

procedure TWordBRO.pCelulaPosiciona(intLinha, intColuna, intIdxTab: Integer);
  Var
    Table,
    Point: Variant;
begin
  Table := Documento.getTextTables.getByName('TABELA_' + IntToStr(intIdxTab));
  Point := Table.getCellByPosition(intColuna-1, intLinha-1);
  Documento.currentcontroller.getViewCursor.gotoRange(Point.getStart,False);
end;

procedure TWordBRO.pCriaTabela(strChave: String; intQtdLin, intQtdCol: Integer);
  Var
    Busca,
    Found,
    parametro: Variant;
    intIdxTab: Integer;
begin
  inherited;

  intIdxTab := qtdTabelas;
  blnTabelaCriada := False;

  If Not (Trim(strChave) = '') Then
  Begin
    pGoToPageHeader;

    Busca := Documento.createSearchDescriptor;
    Busca.SearchString := strChave;
    Busca.SearchSimilarity := False;
    Busca.SearchSimilarityAdd := 2;
    Busca.SearchSimilarityExchange := 2;
    Busca.SearchSimilarityRemove := 2;
    Busca.SearchSimilarityRelax := False;

    Found := Documento.FindFirst(Busca);
    While Not (VarType(Found) = varUnknown) Do
    Begin

      Inc(intIdxTab);

      intIdxTabAtual :=  intIdxTab;

      Documento.currentcontroller.getViewCursor.gotoRange(Found.getStart,False);
      Documento.currentcontroller.getViewCursor.gotoRange(Found.getEnd,True);

      parametro    := VarArrayCreate([0, 2], varVariant);
      parametro[0] := fAtribuiProperty('TableName', 'TABELA_' + IntToStr(intIdxTab));
      parametro[1] := fAtribuiProperty('Columns', intQtdCol);
      parametro[2] := fAtribuiProperty('Rows', intQtdLin+1);
      fExecuta('.uno:InsertTable',parametro);

      blnTabelaCriada := True;

      Found := Documento.findNext(Found.End, Busca);

    End;

    qtdTabelas := qtdTabelas +1;
  End;

end;

procedure TWordBRO.pFechar;
begin
  inherited;
  Documento.Close(True);
  Documento := Unassigned;
  Texto     := Unassigned;

  if Desktop.Frames.Count = 0 then
  begin
    Desktop.Terminate;
    Desktop:=Unassigned;
  end;
end;

procedure TWordBRO.pGoToMainDocument;
begin
  inherited;

end;

procedure TWordBRO.pGoToPageFooter;
begin
  inherited;
  fExecuta('.uno:GoToEndOfDoc', Unassigned);
end;

procedure TWordBRO.pGoToPageHeader;
begin
  inherited;
  fExecuta('.uno:GoToStartOfDoc', Unassigned);
end;

procedure TWordBRO.pInsereImagem(strPath: String);
  Var
    Url,
    Quadro,
    Size,
    DPage,
    Busca,
    Found: Variant;

    function fCarregarGrafico(strArq, strNomeInterno: String): Variant;
      Var
        Bitmaps, oProvider, oProps: Variant;
    Begin
      Bitmaps := Documento.createInstance('com.sun.star.drawing.BitmapTable');
      Bitmaps.insertByName(strNomeInterno, strArq);
      Result  := Bitmaps.getByName(strNomeInterno);

      If (VarType(Result) <> varOleStr) Then
      Begin
        oProvider := FWord.createInstance('com.sun.star.graphic.GraphicProvider');
        oProps    := VarArrayCreate([0, 0], varVariant);
        oProps[0] := fAtribuiProperty('URL', strArq);

        Result := oProvider.queryGraphic(oProps);
      End;
    End;

    function fCriarShape(varTam: Variant): Variant;
      Var
        Shape: Variant;
    Begin
      Shape := Documento.createInstance('com.sun.star.drawing.GraphicObjectShape');
      Shape.Size := varTam;
      Shape.Transparency := 0;
      Result := Shape;
    End;
begin
  inherited;

  If FileExists(strPath) Then
  Begin
    Busca := Documento.createSearchDescriptor;
    Busca.SearchString := '{{IMAGEM}}';
    Busca.SearchSimilarity := False;
    Busca.SearchSimilarityAdd := 2;
    Busca.SearchSimilarityExchange := 2;
    Busca.SearchSimilarityRemove := 2;
    Busca.SearchSimilarityRelax := False;

    Found := Documento.FindFirst(Busca);

    If Not (VarType(Found) = varUnknown) Then
    Begin
      DPage := Documento.getDrawPage;
      Url   := fCarregarGrafico(fFormataDir(strPath), 'Sign');

      Size := FWord.Bridge_GetStruct('com.sun.star.awt.Size');
      Size.Width := 136.05 * 37.8;
      Size.Height := 70.85 * 37.8;
      Quadro := fCriarShape(Size);
      DPage.Add(Quadro);

      If (VarType(Url) = varOleStr) Then
        Quadro.GraphicURL := Url
      Else
        Quadro.Graphic    := Url;

      pReplace('{{IMAGEM}}', '');
    End;
  End;

end;

procedure TWordBRO.pInsereImagem(strPath: String; strSearcStringImagem: String);
  Var
    Busca,
    Found,
    Text,
    TextCursor,
    Graphic : Variant;

    function fGraphicObject(strAUrl: String): Variant;
      var
        Graphic : Variant;
    begin
      Graphic := Documento.createInstance('com.sun.star.text.GraphicObject');
      Graphic.GraphicURL := strAUrl;
      Graphic.AnchorType := 1; //com.sun.star.text.TextContentAnchorType.AS_CHARACTER;
      Graphic.Width := 136.05 * 37.8;
      Graphic.Height := 70.85 * 37.8;
      Result := Graphic;
    End;
begin
  inherited;

  If FileExists(strPath) Then
  Begin
    Busca := Documento.createSearchDescriptor;
    Busca.SearchString := strSearcStringImagem;
    Busca.SearchSimilarity := False;
    Busca.SearchSimilarityAdd := 2;
    Busca.SearchSimilarityExchange := 2;
    Busca.SearchSimilarityRemove := 2;
    Busca.SearchSimilarityRelax := False;

    Found := Documento.FindFirst(Busca);

    If Not (VarType(Found) = varUnknown) Then
    Begin
      Graphic := fGraphicObject(fFormataDir(strPath));

      Text := Documento.getText;
      TextCursor := Text.createTextCursor;
      TextCursor.gotoRange(Found, False);
      Text.insertTextContent(TextCursor, Graphic, False);

      pReplace(strSearcStringImagem, '');
    End;
  End;
end;

procedure TWordBRO.pPrint;
  Var
    parametro: Variant;
begin
  inherited;
  parametro    := VarArrayCreate([0, 1], varVariant);
  parametro[0] := fAtribuiProperty('Copies', 1);
  parametro[1] := fAtribuiProperty('Collate', True);
  fExecuta('.uno:Print',parametro);
end;

procedure TWordBRO.pReplace(strOri, strDes: String);
  Var
    Busca: Variant;
begin
  inherited;
  pGoToPageHeader;

  Busca := Documento.createReplaceDescriptor;
  Busca.SearchWords := True;
  Busca.setSearchString (strOri);
  Busca.setReplaceString(strDes);
  Documento.replaceAll(Busca);
end;

procedure TWordBRO.pSalvar;
begin
  inherited;
  fExecuta('.uno:Save',Unassigned);
end;

procedure TWordBRO.pSalvarSemPerguntarFormato;
begin
  // Pela API, e não pelo comando .uno:Save do pSalvar: o comando faz o LibreOffice abrir a pergunta "Confirme o
  // formato do arquivo" ao salvar .DOC, numa janela que o operador nem sempre vê, e a chamada só volta quando alguém
  // responde (o Autcom fica parado em "Gerando relatório"). O store grava no formato em que o arquivo foi aberto, sem
  // perguntar.
  Documento.store;
end;

procedure TWordBRO.pSaveAsHtml;
begin
  inherited;

end;

procedure TWordBRO.pSetarImpressora(strPrinter: String);
  Var
    parametro: Variant;
begin
  inherited;
  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('Printer', strPrinter);
  fExecuta('.uno:Printer',parametro);
end;

procedure TWordBRO.fExecuta(strComando: String; varParams: Variant);
  Var
    Dispatcher, Frame: Variant;
begin

  If (VarIsEmpty(varParams) Or VarIsNull(varParams)) Then
    varParams:= VarArrayCreate([0, -1], varVariant);

  Frame      := Documento.getCurrentController.getFrame;
  Dispatcher := FWord.createInstance('com.sun.star.frame.DispatchHelper');
  Dispatcher.executeDispatch(Frame, strComando, '', 0, varParams);

end;

function TWordBRO.fAtribuiProperty(Nome: String; Valor : Variant): Variant;
  var
    Reflec : Variant;
begin
  Reflec := FWord.createInstance('com.sun.star.reflection.CoreReflection');
  Reflec.forName('com.sun.star.beans.PropertyValue').createObject(result);
  result.Name := Nome;
  result.Value:= Valor;
end;

constructor TWordBRO.Create(AOwner: TComponent);
var
  parametro: Variant;
begin
  inherited;
  FWord   := CreateOleObject('com.sun.star.ServiceManager');
  Desktop := FWord.CreateInstance('com.sun.star.frame.Desktop');
  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('Hidden', False);
  Principal    := Desktop.LoadComponentFromURL('private:factory/swriter', '_blank', 0, parametro);
  Principal.getCurrentController.getFrame.getContainerWindow.setVisible(False);
  intIdxTabAtual := 0;
end;

procedure TWordBRO.DefinirFonte;
  Var
    parametro: Variant;
begin
  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('CharFontName.FamilyName', 'Arial');
  fExecuta('.uno:CharFontName', parametro);

  parametro    := VarArrayCreate([0, 0], varVariant);
  parametro[0] := fAtribuiProperty('FontHeight.Height', 8);
  fExecuta('.uno:FontHeight', parametro);
end;

destructor TWordBRO.Destroy;
begin
  Principal.Close(True);
  Principal := Unassigned;
  inherited;
end;

procedure TWordBRO.SaveAsPDF(const ATargetFileURL: string);
var
  FilterParams: Variant;
  ExportParams: Variant;
  ExportObject: Variant;

  function CreateProperty(const AName: AnsiString; AValue: Variant): Variant;
  begin
    Result := FWord.Bridge_GetStruct('com.sun.star.beans.PropertyValue');
    Result.Name := AName;
    Result.Value := AValue;
  end;


begin
  ExportParams := VarArrayCreate([0, 2], varVariant);
  ExportParams[0] := CreateProperty('Magnification', 2);
  ExportParams[1] := CreateProperty('EncryptFile', True);
  ExportParams[2] := CreateProperty('HideViewerWindowControls', True);

  ExportObject := FWord.Bridge_GetValueObject;
  ExportObject.Set('[]com.sun.star.beans.PropertyValue', ExportParams);

  FilterParams := VarArrayCreate([0, 1], varVariant);
  FilterParams[0] := CreateProperty('FilterName', AnsiString('writer_pdf_Export'));
  FilterParams[1] := CreateProperty('FilterData', ExportObject);

  Documento.StoreToURL(fFormataDir(ATargetFileURL), FilterParams);
end;


end.
