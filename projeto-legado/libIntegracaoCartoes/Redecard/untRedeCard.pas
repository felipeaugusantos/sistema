unit untRedeCard;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untRedeDebito, untRedeCredito, ComCtrls, untTImportacaoCartao;

Type
  TRedeCard = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objDebito : TRedeDebito;
    objCredito: TRedeCredito;
    blnCredito: Boolean;

    FVersaoMenil: Boolean;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;

    property VersaoMenil: Boolean read FVersaoMenil write FVersaoMenil;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TRedeCard }

constructor TRedeCard.Create(Owner: TComponent);
begin
  inherited;
  objDebito  := TRedeDebito.Create;
  objCredito := TRedeCredito.Create;

  lstEstabel := TStringList.Create;

  FVersaoMenil := False;

  strNomCon := 'REDECARD';
  strMenCon := '';
end;

destructor TRedeCard.Destroy;
begin
  If Assigned(objDebito) Then
    FreeAndNil(objDebito);
  If Assigned(objCredito) Then
    FreeAndNil(objCredito);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

procedure TRedeCard.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;

  procedure pCarregaArquivos(strExt: String);
  Begin

    if (FindFirst(strPath + IIF(strExt <> '', '\*.' + strExt, '\*'), faAnyFile, arqArquivo) = 0) Then
    Begin
      Repeat
        if (strExt = '') and (ExtractFileExt(arqArquivo.Name) <> '') And (Length(ExtractFileExt(arqArquivo.Name)) <= 4) then
          continue;

        If arqArquivo.Attr = faDirectory Then
          Continue;

        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        If Copy(strLinha, 1, 3) = '00,' Then
          stlPgto.Add(strPath + '\' + arqArquivo.Name)

        Else If (Copy(strLinha, 1, 3) = '002') Or (Copy(strLinha, 1, 3) = '030') Then
          stlCredito.Add(strPath  + '\' + arqArquivo.Name);

        Flush(txtArquivo);
        Close(txtArquivo);

      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);
  End;
begin
  Try
    pCarregaArquivos('ret');
    pCarregaArquivos('txt');
    pCarregaArquivos('');
    pCarregaArquivos('cmp');

    If (stlCredito.Count = 0) And (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pGravarRegistros;

    objFunctions.fIMensagem('','Dados importados com sucesso!',['&OK']);

    frmForm.Close;
  Except
    Raise;
  End;
end;

procedure TRedeCard.pAdicionaLinhas;

  procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList; blnCredito: Boolean);
    Var
      intCont  : Integer;
      intLin   : Integer;
      stlAux   : TStringList;
  begin
    Try
      stlAux := TStringList.Create;

      For intCont := 0 To stlArqs.Count -1 Do
      Begin
        stlAux.LoadFromFile(stlArqs[intCont]);
        If blnCredito Then
        Begin
          untRedeCredito.strNomArq := ExtractFileName(stlArqs[intCont]);
          untRedeCredito.strDtaArq := Copy(stlAux[0], 4, 8);
        End
        Else
        Begin
          untRedeDebito.strNomArq := ExtractFileName(stlArqs[intCont]);
          untRedeDebito.strDtaArq := Copy(stlAux[0], 14, 8);
        End;

        For intLin := 0 To stlAux.Count -1 Do
          itrCartoes.pAdicionaLinha(stlAux[intLin]);

        stlAux.Clear;
      End;

    Except
      On E: Exception Do
      Begin
        objFunctions.fIMensagem('','Ocorreu um erro interno: ' + E.Message,['&OK']);
        Abort;
      End;
    End;

    FreeAndNil(stlAux);

  end;

Begin
  If Not blnCredito Then
    SetLength(FReg5 , 0)
  Else
  Begin
    SetLength(FReg6 , 0);
    SetLength(FReg8 , 0);
    SetLength(FReg10, 0);
    SetLength(FReg12, 0);
    SetLength(FReg34, 0);
  End;

  untRedeCredito.VersaoMenil := FVersaoMenil;
  untRedeDebito.VersaoMenil  := FVersaoMenil;

  If Not blnCredito Then
    pAdiciona(objDebito, stlPgto, False)
  Else
    pAdiciona(objCredito, stlCredito, True);
End;

procedure TRedeCard.pGravarRegistros;
Var
  intCont: Integer;

  LNomeArquivoSemExtensao: String;
begin
  blnCredito := False;
  pAdicionaLinhas;
  objDebito.pGravarRegistros(pgbProg);
  blnCredito := True;
  pAdicionaLinhas;
  objCredito.strNomEmp := strNomEmp;
  objCredito.pGravarRegistros(pgbProg);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    LNomeArquivoSemExtensao := stlPgto[intCont];
    If Length(ExtractFileExt(LNomeArquivoSemExtensao)) <= 4 Then
      LNomeArquivoSemExtensao := AnsiReplaceStr(LNomeArquivoSemExtensao,
                                                ExtractFileExt(LNomeArquivoSemExtensao),
                                                '');

    If FileExists(LNomeArquivoSemExtensao+'.imp') Then
      DeleteFile(LNomeArquivoSemExtensao+'.imp');

    pRenomeiaAquivo(stlPgto[intCont], LNomeArquivoSemExtensao+'.imp');
  end;

  For intCont := 0 to stlCredito.Count - 1 do
  Begin
    LNomeArquivoSemExtensao := stlCredito[intCont];
    If Length(ExtractFileExt(LNomeArquivoSemExtensao)) <= 4 Then
      LNomeArquivoSemExtensao := AnsiReplaceStr(LNomeArquivoSemExtensao,
                                                ExtractFileExt(LNomeArquivoSemExtensao),
                                                '');

    If FileExists(LNomeArquivoSemExtensao+'.imp') Then
      DeleteFile(LNomeArquivoSemExtensao+'.imp');

    pRenomeiaAquivo(stlCredito[intCont], LNomeArquivoSemExtensao+'.imp');
  end;
end;

end.
