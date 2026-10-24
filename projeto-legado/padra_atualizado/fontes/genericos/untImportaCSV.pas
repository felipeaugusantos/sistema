unit untImportaCSV;

interface

Uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, Uni,
  untZClient, StrUtils, Math, Variants;

Type
   TImportaCSV = Class
   Private
      FNroLinha: Integer;

      FArqCsv,
      FLinha: TStringList;

      FLinhaInicialZero: Boolean;

   Public

     Constructor Create(strNomArq: String; blnLinhaInicialZero: Boolean = False);

     Destructor Destroi;


     Function fGetDado(intLinha: Integer; strColuna: String; ftpTipo: TFieldType = ftString; blnDevolveZeroParaFloat: Boolean = True): String; overload;
     Function fGetDado(intLinha, intColuna: Integer; ftpTipo: TFieldType = ftString): String; Overload;

     Property stlArqCsv: TStringList Read FArqCsv;

     Procedure pSetLinha;

     Class Function fPedeArquivo(Var strNomArq: String): Boolean;

   End;

implementation

Uses
  Dialogs,
  untFuncoesSimples;

Constructor TImportaCSV.Create(strNomArq: String; blnLinhaInicialZero: Boolean = False);
Begin
  FLinhaInicialZero := blnLinhaInicialZero;

  FLinha  := TStringList.Create;
  FLinha.StrictDelimiter := True;

  If blnLinhaInicialZero Then
    FNroLinha := -1
  Else
    FNroLinha := 0;

  FArqCsv := TStringList.Create;
  FArqCsv.LoadFromFile(strNomArq);
End;

Destructor TImportaCSV.Destroi;
Begin
 FreeAndNil(FLinha);
End;

Procedure TImportaCSV.pSetLinha;
  Var
    strConverte: String;
Begin
  FLinha.Clear;

  If FNroLinha <= FArqCsv.Count - IIF(FLinhaInicialZero, 1, 0) Then
  Begin
    strConverte := FArqCsv[FNroLinha - IIF(FLinhaInicialZero, 0, 1)];
    strConverte := AnsiReplaceStr(strConverte, ',', '[^]');
    strConverte := AnsiReplaceStr(strConverte, ';', ',');
    FLinha.CommaText := strConverte;
    FLinha.Text := AnsiReplaceStr(FLinha.Text, '[^]', ',');
  End;
End;

Function TImportaCSV.fGetDado(intLinha: Integer; strColuna: String; ftpTipo: TFieldType = ftString; blnDevolveZeroParaFloat: Boolean = True): String;
  Var
    intPos: Integer;
Begin
  Result := '';

  If intLinha <> FNroLinha Then
  Begin
    FNroLinha := intLinha;
    pSetLinha;
  End;

  intPos := Ord(strColuna[1]) - 65;

  If IntPos < FLinha.Count Then
    Result := FLinha[intPos];

  If fEmptyStr(Result) And (ftpTipo = ftFloat) And blnDevolveZeroParaFloat Then
    Result := '0';
End;

Function TImportaCSV.fGetDado(intLinha, intColuna: Integer; ftpTipo: TFieldType = ftString): String;
Begin
  Result := '';

  If intLinha <> FNroLinha Then
  Begin
    FNroLinha := intLinha;
    pSetLinha;
  End;

  If IntColuna < FLinha.Count Then
    Result := FLinha[intColuna];

  If fEmptyStr(Result) And (ftpTipo = ftFloat) Then
    Result := '0';
End;


Class Function TImportaCSV.fPedeArquivo(Var strNomArq: String): Boolean;
  Var
    opdOpenFile : TOpenDialog;
begin
  strNomArq := '';

  Try
    opdOpenFile := TOpenDialog.Create(Nil);
    opdOpenFile.Filter := 'Arquivos Suportados|*.csv';

    Result := opdOpenFile.Execute;

    If Result Then
      strNomArq := opdOpenFile.FileName;

  Finally
    FreeAndNil(opdOpenFile);
  End;

End;

end.
