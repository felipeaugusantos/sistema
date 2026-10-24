{************************************}
{* Importação de arquivos da EQUALS *}
{*********************************AJ*}
unit untEquals;

interface

uses System.Classes, Vcl.Forms, System.SysUtils, System.StrUtils,

     cxProgressBar,

     untTEqualsImportacaoCartao, untEqualsPagto, untTEqualsFuncoes,
     untIEqualsIntegracaoLibCartoes;

Type
  TEquals = Class(TEqualsImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
    procedure pAdiciona(itrCartoes: ICartoes);
    procedure pCarregaArquivos(strExt: String; APath: String);
  Private
    objPgto: ICartoes;

    FArquivosPgto: TStringList;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

{ TEquals }

constructor TEquals.Create(Owner: TComponent);
begin
  inherited;
  objPgto := TEqualsPagto.Create;

  FArquivosPgto := TStringList.Create;

  VS_ListaEstabelecimentos := TStringList.Create;

  strNomCon := 'EQUALS';
  strMenCon := '';
end;

destructor TEquals.Destroy;
begin
  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  If Assigned(FArquivosPgto) Then
    FreeAndNil(FArquivosPgto);

  objPgto := Nil;

  SetLength(FRegEquPgto, 0);
  SetLength(FRegEquAjus, 0);
  inherited;
end;

procedure TEquals.pCarregaArquivos(strExt, APath: String);
Var
  TesteDta: TDate;
  arqArquivo: TSearchRec;
  txtArquivo: TextFile;
  strLinha  : String;

 LLinhaOriginal: RawByteString;
begin
  Try
    If (FindFirst(APath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        Application.ProcessMessages;
        AssignFile(txtArquivo, APath + '\' + arqArquivo.Name);
        Try
          Reset(txtArquivo);
          Readln(txtArquivo, strLinha);

          LLinhaOriginal := RawByteString(strLinha);

          If (Copy(strLinha, 1 ,2) = '00') Then
          Begin
            Try
              TesteDta := StrtoDate(Copy(strLinha, 25, 2) + '/' + Copy(strLinha, 23, 2) + '/' + Copy(strLinha, 19, 4));
              If TesteDta <> 0 Then
                FArquivosPgto.Add(APath + '\' + arqArquivo.Name);
            Except

            End;
          End
          Else
          Begin
            If Pos('NÚMERO SEQUENCIAL;FILIAÇÃO DO ESTABELECIMENTO;NOME ESTABELECIMENTO EQUALS', strLinha) > 0 Then
              FArquivosPgto.Add(APath + '\' + arqArquivo.Name)
            Else
            Begin
              strLinha := UTF8ToString(LLinhaOriginal);

              If Pos('NÚMERO SEQUENCIAL;FILIAÇÃO DO ESTABELECIMENTO;NOME ESTABELECIMENTO EQUALS', strLinha) > 0 Then
                FArquivosPgto.Add(APath + '\' + arqArquivo.Name);
            End;
          End;
        Finally
          Flush(txtArquivo);
          Close(txtArquivo);
        End;

      Until (FindNext(arqArquivo) <> 0);

    End;
  Finally
    FindClose(arqArquivo);
  End;
end;

procedure TEquals.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
begin
  Try
    pCarregaArquivos('txt', strPath);
    pCarregaArquivos('ret', strPath);
    pCarregaArquivos('csv', strPath);
    If (FArquivosPgto.Count = 0) Then
    Begin
      TEqualsFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;

    pGravarRegistros(prgStatus);

    If untEqualsPagto.blnPagamentoImportado Then
      TEqualsFuncoes.fMensagem('','Dados importados com sucesso!',['&OK'])
    Else
      TEqualsFuncoes.fMensagem('','Nenhum registro de pagamento importado nos arquivos!',['&OK']);

    frmImportacaoCartoes.Close;
  Except
    On E: Exception Do
    Begin
      TEqualsFuncoes.fMensagem('ERRO', 'Ocorreu um erro na importação da EQUALS.' + #13 +
                                      'Erro gerado: ' + E.Message + #13 +
                                      'Verifique se algum arquivo está aberto em outro programa.', ['&OK']);
    End;
  End;
end;

procedure TEquals.pAdiciona(itrCartoes: ICartoes);
Var
  intCont: Integer;
  intLin : Integer;
  stlAux : TStringList;

  LLerUTF8: Boolean;

  LLinhaUTF8: RawByteString;

  LConverteUTF8: String;
begin
  stlAux := Nil;
  Try
    stlAux := TStringList.Create;

    For intCont := 0 To FArquivosPgto.Count -1 Do
    Begin
      Application.ProcessMessages;
      stlAux.LoadFromFile(FArquivosPgto[intCont]);
      untEqualsPagto.strNomArq := ExtractFileName(FArquivosPgto[intCont]);

      untEqualsPagto.blnArquivoCSV := Pos('NÚMERO SEQUENCIAL;FILIAÇÃO DO ESTABELECIMENTO;NOME ESTABELECIMENTO EQUALS', stlAux[0]) > 0;

      LLerUTF8 := False;

      LLinhaUTF8 := RawByteString(stlAux[0]);
      If Not untEqualsPagto.blnArquivoCSV Then
      Begin
        LConverteUTF8 := UTF8ToString(LLinhaUTF8);

        untEqualsPagto.blnArquivoCSV := Pos('NÚMERO SEQUENCIAL;FILIAÇÃO DO ESTABELECIMENTO;NOME ESTABELECIMENTO EQUALS', LConverteUTF8) > 0;
        LLerUTF8 := untEqualsPagto.blnArquivoCSV;
      End;

      For intLin := 0 To stlAux.Count -1 Do
      Begin
        LLinhaUTF8 := RawByteString(stlAux[intLin]);

        If Not LLerUTF8 Then
          itrCartoes.pAdicionaLinha(stlAux[intLin])
        Else
          itrCartoes.pAdicionaLinha(UTF8ToString(LLinhaUTF8));
      End;

      stlAux.Clear;
    End;
  Finally
    If Assigned(stlAux) Then
      FreeAndNil(stlAux);
  End;
end;

procedure TEquals.pAdicionaLinhas;
Begin
  Try
    SetLength(FRegEquPgto, 0);
    SetLength(FRegEquAjus, 0);

    pAdiciona(objPgto);
  Except
    Raise;
  End;
End;

procedure TEquals.pGravarRegistros;
Var
  intCont: Integer;
begin
  VS_FuncoesExternas.fIStartTransaction;

  Try
    objPgto.pGravarRegistros(prgStatus);
    VS_FuncoesExternas.fICommit;

    For intCont := 0 to FArquivosPgto.Count - 1 do
    Begin
      If (FileExists(AnsiReplaceStr(FArquivosPgto[intCont], RightStr(FArquivosPgto[intCont], 3), 'imp'))) Then
        DeleteFile(AnsiReplaceStr(FArquivosPgto[intCont], RightStr(FArquivosPgto[intCont], 3), 'imp'));
      TEqualsFuncoes.pRenomeiaAquivo(FArquivosPgto[intCont], AnsiReplaceStr(FArquivosPgto[intCont], RightStr(FArquivosPgto[intCont], 3), 'imp'));
    end;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      TEqualsFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

end.
