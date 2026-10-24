unit untRedeCard;

interface

uses System.Classes, System.SysUtils, System.StrUtils, Vcl.Forms,

  untTRedeCardImportacaoCartao, untIRedeCardIntegracaoLibCartoes, untRedeDebito,
  untRedeCredito, untTRedeCardFuncoes,

  BitBtnLockedIncrem, cxProgressBar;

Type
  TRedeCard = Class(TRedeCardImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
  Private
    objDebito : ICartoes;
    objCredito: ICartoes;
    blnCredito: Boolean;

    stlPgto,
    stlCredito: TStringList;

    FVersaoMenil: Boolean;

    procedure AdicionaLinhasArquivos(itrCartoes: ICartoes; stlArqs: TStringList; blnCredito: Boolean);
    procedure pCarregaArquivos(strExt: String; strPath: String);
  Public
    strNomEmp : String;

    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;

    property VersaoMenil: Boolean read FVersaoMenil write FVersaoMenil;
  End;

implementation

{ TRedeCard }

constructor TRedeCard.Create(Owner: TComponent);
begin
  inherited;
  objDebito  := TRedeDebito.Create;
  objCredito := TRedeCredito.Create;

  stlPgto := TStringList.Create;
  stlCredito := TStringList.Create;

  VS_ListaEstabelecimentos := TStringList.Create;

  FVersaoMenil := False;

  strNomCon := 'REDECARD';
  strMenCon := '';
end;

destructor TRedeCard.Destroy;
begin
  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);
  If Assigned(stlPgto) Then
    FreeAndNil(stlPgto);
  If Assigned(stlCredito) Then
    FreeAndNil(stlCredito);

  objDebito  := Nil;
  objCredito := Nil;

  SetLength(untRedeDebito.FReg5, 0);
  SetLength(untRedeCredito.FReg6, 0);
  SetLength(untRedeCredito.FReg8, 0);
  SetLength(untRedeCredito.FReg10, 0);
  SetLength(untRedeCredito.FReg12, 0);
  SetLength(untRedeCredito.FReg14, 0);
  SetLength(untRedeCredito.FReg34, 0);
  inherited;
end;

procedure TRedeCard.pCarregaArquivos(strExt: String; strPath: String);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;
Begin
  Try
    if (FindFirst(strPath + TRedeCardFuncoes.IIF(strExt <> '', '\*.' + strExt, '\*'), faAnyFile, arqArquivo) = 0) Then
    Begin
      Repeat
        if (strExt = '') and (ExtractFileExt(arqArquivo.Name) <> '') And (Length(ExtractFileExt(arqArquivo.Name)) <= 4) then
          continue;

        If arqArquivo.Attr = faDirectory Then
          Continue;

        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Try
          Reset(txtArquivo);
          Readln(txtArquivo, strLinha);

          If Copy(strLinha, 1, 3) = '00,' Then
            stlPgto.Add(strPath + '\' + arqArquivo.Name)

          Else If (Copy(strLinha, 1, 3) = '002') Or (Copy(strLinha, 1, 3) = '030') Then
            stlCredito.Add(strPath  + '\' + arqArquivo.Name);
        Finally
          Flush(txtArquivo);
          Close(txtArquivo);
        End;
      Until (FindNext(arqArquivo) <> 0);

    End;
  Finally
    FindClose(arqArquivo);
  End;
End;

procedure TRedeCard.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
  Var
    LSemLancamentos: Boolean;
begin
  Try
    pCarregaArquivos('ret', strPath);
    pCarregaArquivos('txt', strPath);
    pCarregaArquivos('', strPath);
    pCarregaArquivos('cmp', strPath);

    If stlCredito.Count + stlPgto.Count = 0 Then
    Begin
      TRedeCardFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pGravarRegistros(prgStatus);

    LSemLancamentos := (Length(untRedeDebito.FReg5)  = 0) And
                       (Length(untRedeCredito.FReg6)  = 0) And
                       (Length(untRedeCredito.FReg8)  = 0) And
                       (Length(untRedeCredito.FReg10) = 0) And
                       (Length(untRedeCredito.FReg12) = 0) And
                       (Length(untRedeCredito.FReg14) = 0) And
                       (Length(untRedeCredito.FReg34) = 0);

    If LSemLancamentos Then
      TRedeCardFuncoes.fMensagem('','Os arquivos foram processados com sucesso, porém não havia lançamentos para importar.',['&OK'])
    Else
      TRedeCardFuncoes.fMensagem('','Dados importados com sucesso!',['&OK']);

    frmImportacaoCartoes.Close;
  Except
    Raise;
  End;
end;

procedure TRedeCard.AdicionaLinhasArquivos(itrCartoes: ICartoes; stlArqs: TStringList; blnCredito: Boolean);
  Var
    intCont  : Integer;
    intLin   : Integer;
    stlAux   : TStringList;
begin
  stlAux := TStringList.Create;
  Try
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
  Finally
    FreeAndNil(stlAux);
  End;
end;

procedure TRedeCard.pAdicionaLinhas;
Begin
  If Not blnCredito Then
    TRedeDebito(objDebito).LimparImportacoes
  Else
    TRedeCredito(objCredito).LimparImportacoes;

  untRedeCredito.VersaoMenil := FVersaoMenil;
  untRedeDebito.VersaoMenil  := FVersaoMenil;

  If Not blnCredito Then
    AdicionaLinhasArquivos(objDebito, stlPgto, False)
  Else
    AdicionaLinhasArquivos(objCredito, stlCredito, True);
End;

procedure TRedeCard.pGravarRegistros(var prgStatus: TcxProgressBar);
Var
  intCont: Integer;

  LNomeArquivoSemExtensao: String;
begin
  VS_FuncoesExternas.fIStartTransaction;

  Try
    blnCredito := False;
    pAdicionaLinhas;
    objDebito.pGravarRegistros(prgStatus);
    blnCredito := True;
    pAdicionaLinhas;
    TRedeCredito(objCredito).strNomEmp := strNomEmp;
    objCredito.pGravarRegistros(prgStatus);

    VS_FuncoesExternas.fICommit;

    For intCont := 0 to stlPgto.Count - 1 do
    Begin
      LNomeArquivoSemExtensao := stlPgto[intCont];
      If Length(ExtractFileExt(LNomeArquivoSemExtensao)) <= 4 Then
        LNomeArquivoSemExtensao := AnsiReplaceStr(LNomeArquivoSemExtensao,
                                                  ExtractFileExt(LNomeArquivoSemExtensao),
                                                  '');

      If FileExists(LNomeArquivoSemExtensao+'.imp') Then
        DeleteFile(LNomeArquivoSemExtensao+'.imp');

      TRedeCardFuncoes.pRenomeiaAquivo(stlPgto[intCont], LNomeArquivoSemExtensao+'.imp');
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

      TRedeCardFuncoes.pRenomeiaAquivo(stlCredito[intCont], LNomeArquivoSemExtensao+'.imp');
    end;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      TRedeCardFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

end.
