unit untImpMatricial;

interface

uses SysUtils, Uni, DB, WinSpool, Dialogs, StrUtils,UniDataSetProvider,
  Windows, Forms, Classes, UniClientDataSet, frxClass, untFuncFatTypes,
  untFuncoesSimples, untFuncoesGenerica, Math, Graphics, MaskUtils, DateUtils;


Type
  TImpMatricial = class(TObject)
    private
      FDocInfo : TDocInfo1;

      FImpressoraMatricialAberta : Boolean;
      FNomeImpressaoMatricial: String;

      blnOpenPrinter : Boolean;
      intSemaforoImpMat : Integer;
    protected
      FQtdLin: Integer;
      FNomImp: String;

      PrinterHandler: NativeUInt;

    public
      strNroVia: String;

      procedure SetQtdLin(intQtd: Integer);
      procedure SetNomImp(strImp: String);

      procedure Imp(strTexto: String; blnPula: Boolean = True; blnRetCaractEsp: Boolean = True);
      procedure Reseta;
      procedure Eject;

      procedure pInicializarImpressoraMatricial;
      procedure pFinalizarImpressoraMatricial;
      function fOpenPrinter : Boolean;
      procedure pSetaInfoImpressoraMatricial(strNomeImpressao: String; blnOpenPrinter: Boolean = False; blnCondicaoOpenPrinter: Boolean = False);

      Function fLinhasMsgQuebra(strMensagem: String; intTamanho: Integer; strTitulo: String = ''; blnIniQuebraLZero: Boolean = False): Integer;
      procedure pImpMsgQuebra(strMensagem: String; intTamanho: Integer; strTitulo: String = ''; blnIniQuebraLZero: Boolean = False);

      function Cond_10CPI(blnLiga: Boolean): String;
      function Cpi_12(blnLiga: Boolean): String;
      function Expandido(blnLiga: Boolean): String;
      function Negrito(blnLiga: Boolean): String;
      function TamPag(intMaxLin: Integer): String;
      function Um_Oitavo(blnLiga: Boolean): String;

      property intQtdLin: Integer Read FQtdLin Write SetQtdLin;
      property strNomImp: String Read FNomImp Write SetNomImp;

      Constructor Create(strNomImp: String);
      Destructor Destroy; override;
  end;

implementation

uses untFuncoes;

{TImpMatricial}


procedure TImpMatricial.SetQtdLin(intQtd: Integer);
begin
  If (intQtdLin <= 0) Then
    Self.FQtdLin := 1
  Else
    Self.FQtdLin := intQtd;
end;

function TImpMatricial.TamPag(intMaxLin: Integer): String;
begin
  Result := #27 + 'C' + Chr(intMaxLin);
end;

function TImpMatricial.Expandido(blnLiga: Boolean): String;
begin
  If blnLiga Then
     Result := #27 + #87 + '1'
  Else
     Result := #27 + #87 + '0';
end;

function TImpMatricial.Cond_10CPI(blnLiga: Boolean): String;
begin
  If blnLiga Then
     Result := #15
  Else
     Result := #18;
end;

function TImpMatricial.Cpi_12(blnLiga: Boolean): String;
begin
  If blnLiga Then
     Result := #27 + #77
  Else
     Result := #27 + #80;
end;

function TImpMatricial.Negrito(blnLiga: Boolean): String;
begin
  If blnLiga Then
     Result := #27 + 'E'
  Else
     Result := #27 + 'F';
end;

function TImpMatricial.Um_Oitavo(blnLiga: Boolean): String;
begin
  If blnLiga Then
     Result := #27 + '0'
  Else
     Result := #27 + '2';
end;

constructor TImpMatricial.Create(strNomImp: String);
begin
  inherited Create;

  intSemaforoImpMat := -1;
  blnOpenPrinter    := False;
  FImpressoraMatricialAberta := False;

  SetNomImp(strNomImp);
end;

destructor TImpMatricial.Destroy;
begin
  inherited Destroy;
end;

procedure TImpMatricial.Reseta;
begin
  Imp(#27 + '@', False);
  Imp(#18 + #27 + #80, False);
end;

procedure TImpMatricial.Eject;
begin
  Imp(#12);
  Reseta;
end;

procedure TImpMatricial.Imp(strTexto: String; blnPula: Boolean; blnRetCaractEsp: Boolean);
  Var
    escritos: Cardinal;
    stlArq: TStringList;
    strTesteFile: String;
begin

  If FNomImp = 'TESTE_TXT' Then
  Begin
    strTesteFile := ExtractFilePath(Application.ExeName) + 'IMPRESSAO_TESTE.TXT';

    stlArq := TStringList.Create;
    Try
      If FileExists(strTesteFile) Then
        stlArq.LoadFromFile(strTesteFile);

      stlArq.Text := stlArq.Text + strTexto + IIF(blnPula, #13#10, '');

      stlArq.SaveToFile(strTesteFile);
    Finally
      stlArq.Free;
    End;

    Exit;
  End;

  If (blnRetCaractEsp) Then
    strTexto := fTiraCaracEspeciais(strTexto, False);

  WritePrinter(PrinterHandler, PAnsiChar(AnsiString(strTexto)), Length(strTexto), escritos);
  If (blnPula) Then
  Begin
    strTexto := #13#10;
    WritePrinter(PrinterHandler, PAnsiChar(AnsiString(strTexto)), 2, escritos);
  End;
end;


procedure TImpMatricial.pFinalizarImpressoraMatricial;
begin
  FImpressoraMatricialAberta := False;
  blnOpenPrinter := False;
  ClosePrinter(PrinterHandler);
end;

procedure TImpMatricial.pInicializarImpressoraMatricial;
begin
  If InterlockedIncrement(intSemaforoImpMat) = 0 Then
  Begin
    Try
      If (FImpressoraMatricialAberta) Then
        Exit;

      FImpressoraMatricialAberta := True;

      If (blnOpenPrinter) Then
        OpenPrinter(PChar(FNomImp), PrinterHandler, Nil);

      With FDocInfo Do
      Begin
        pDatatype := 'RAW';
        pDocName := PChar( FNomeImpressaoMatricial );
        pOutputFile := Nil;
      End;

      StartDocPrinter(PrinterHandler, 1, @FDocInfo);
      StartPagePrinter(PrinterHandler);
    Finally
      InterlockedDecrement(intSemaforoImpMat);
    End;
  End
  Else
    InterlockedDecrement(intSemaforoImpMat);
end;

procedure TImpMatricial.pSetaInfoImpressoraMatricial(strNomeImpressao: String;
  blnOpenPrinter: Boolean = False; blnCondicaoOpenPrinter: Boolean = False);
begin
  FNomeImpressaoMatricial := strNomeImpressao;
  Self.blnOpenPrinter := blnOpenPrinter;
  If (Self.blnOpenPrinter) And (blnCondicaoOpenPrinter) Then
    Self.blnOpenPrinter := fOpenPrinter;
end;

procedure TImpMatricial.pImpMsgQuebra(strMensagem: String; intTamanho: Integer; strTitulo: String = ''; blnIniQuebraLZero: Boolean = False);
  Var
    stlMsg : TStringList;
    intCont: Integer;
begin

  stlMsg := TStringList.Create;
  stlMsg.Text := WrapText(strMensagem, #13#10, [' '], intTamanho - Length(strTitulo));

  For IntCont := 0 To stlMsg.Count -1 Do
  Begin
    If intCont = 0 Then
      Imp(fPadR(AnsiReplaceStr(strTitulo + stlMsg[IntCont], #13#10, ''), intTamanho))
    Else
      Imp(fPadR(AnsiReplaceStr(fPadL('', Length(IIF(Not blnIniQuebraLZero, strTitulo, EmptyStr))) + stlMsg[IntCont], #13#10, ''), intTamanho));
  End;

  FreeAndNil(stlMsg);

end;

Function TImpMatricial.fLinhasMsgQuebra(strMensagem: String; intTamanho: Integer; strTitulo: String = ''; blnIniQuebraLZero: Boolean = False): Integer;
  Var
    stlMsg : TStringList;
begin
  stlMsg := TStringList.Create;
  stlMsg.Text := WrapText(strMensagem, #13#10, [' '], intTamanho - Length(strTitulo));
  Result := stlMsg.Count;
  FreeAndNil(stlMsg);
end;

function TImpMatricial.fOpenPrinter: Boolean;
begin
  Result := True;
end;

procedure TImpMatricial.SetNomImp(strImp: String);
begin
  If (fEmptyStr(strImp)) Then
    Raise Exception.Create('O nome da impressora deve ser informado!');

  FNomImp := strImp;
end;



end.
