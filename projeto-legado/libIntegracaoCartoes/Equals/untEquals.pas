{************************************}
{* Importação de arquivos da EQUALS *}
{*********************************AJ*}
unit untEquals;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untEqualsPagto, ComCtrls, untTImportacaoCartao;

Type
  TEquals = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TEqualsPagto;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TEquals }

constructor TEquals.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TEqualsPagto.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'EQUALS';
  strMenCon := '';
end;

destructor TEquals.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

procedure TEquals.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;

    {$IF Defined(VER180)}
    {$ELSE}
    LLinhaOriginal: RawByteString;
    {$IFEND}

  procedure pCarregaArquivos(strExt: String);
  Var TesteDta: TDate;
  Begin

    If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        {$IF Defined(VER180)}
        {$ELSE}
        LLinhaOriginal := RawByteString(strLinha);
        {$IFEND}

        If (Copy(strLinha, 1 ,2) = '00') Then
        Begin
          Try
            TesteDta := StrtoDate(Copy(strLinha, 25, 2) + '/' + Copy(strLinha, 23, 2) + '/' + Copy(strLinha, 19, 4));
            If TesteDta <> 0 Then
              stlPgto.Add(strPath + '\' + arqArquivo.Name);
          Except

          End;
        End
        Else
        Begin
          If Pos('NÚMERO SEQUENCIAL;FILIAÇÃO DO ESTABELECIMENTO;NOME ESTABELECIMENTO EQUALS', strLinha) > 0 Then
            stlPgto.Add(strPath + '\' + arqArquivo.Name)
          Else
          Begin
            {$IF Defined(VER180)}
            {$ELSE}
            strLinha := UTF8ToString(LLinhaOriginal);
            {$IFEND}

            If Pos('NÚMERO SEQUENCIAL;FILIAÇÃO DO ESTABELECIMENTO;NOME ESTABELECIMENTO EQUALS', strLinha) > 0 Then
              stlPgto.Add(strPath + '\' + arqArquivo.Name);
          End;
        End;

        Flush(txtArquivo);
        Close(txtArquivo);

      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);
  End;
begin
  Try
    pCarregaArquivos('txt');
    pCarregaArquivos('ret');
    pCarregaArquivos('csv');
    If (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;

    pGravarRegistros;

    If untEqualsPagto.blnPagamentoImportado Then
      objFunctions.fIMensagem('','Dados importados com sucesso!',['&OK'])
    Else
      objFunctions.fIMensagem('','Nenhum registro de pagamento importado nos arquivos!',['&OK']);

    frmForm.Close;
  Except
    On E: Exception Do
    Begin
      objFunctions.fIMensagem('ERRO', 'Ocorreu um erro na importação da EQUALS.' + #13 +
                                      'Erro gerado: ' + E.Message + #13 +
                                      'Verifique se algum arquivo está aberto em outro programa.', ['&OK']);
    End;
  End;
end;

procedure TEquals.pAdicionaLinhas;

  procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    Var
      intCont: Integer;
      intLin : Integer;
      stlAux : TStringList;

      {$IF Defined(VER180)}
      {$ELSE}
      LLerUTF8: Boolean;

      LLinhaUTF8: RawByteString;

      LConverteUTF8: String;
      {$IFEND}
  begin
    Try
      stlAux := TStringList.Create;

      For intCont := 0 To stlArqs.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(stlArqs[intCont]);
        untEqualsPagto.strNomArq := ExtractFileName(stlArqs[intCont]);

        untEqualsPagto.blnArquivoCSV := Pos('NÚMERO SEQUENCIAL;FILIAÇÃO DO ESTABELECIMENTO;NOME ESTABELECIMENTO EQUALS', stlAux[0]) > 0;

        {$IF Defined(VER180)}
        {$ELSE}
        LLerUTF8 := False;

        LLinhaUTF8 := RawByteString(stlAux[0]);
        If Not untEqualsPagto.blnArquivoCSV Then
        Begin
          LConverteUTF8 := UTF8ToString(LLinhaUTF8);

          untEqualsPagto.blnArquivoCSV := Pos('NÚMERO SEQUENCIAL;FILIAÇÃO DO ESTABELECIMENTO;NOME ESTABELECIMENTO EQUALS', LConverteUTF8) > 0;
          LLerUTF8 := untEqualsPagto.blnArquivoCSV;
        End;
        {$IFEND}

        For intLin := 0 To stlAux.Count -1 Do
        Begin
          {$IF Defined(VER180)}
            itrCartoes.pAdicionaLinha(stlAux[intLin]);
          {$ELSE}
            LLinhaUTF8 := RawByteString(stlAux[intLin]);

            If Not LLerUTF8 Then
              itrCartoes.pAdicionaLinha(stlAux[intLin])
            Else
              itrCartoes.pAdicionaLinha(UTF8ToString(LLinhaUTF8));
          {$IFEND}
        End;

        stlAux.Clear;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

    FreeAndNil(stlAux);

  end;

Begin
  SetLength(FRegEquPgto, 0);
  SetLength(FRegEquAjus, 0);

  pAdiciona(objPgto, stlPgto);
End;

procedure TEquals.pGravarRegistros;
Var
  intCont: Integer;
begin

  objPgto.pGravarRegistros(pgbProg);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'))) Then
      DeleteFile(AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'));
    pRenomeiaAquivo(stlPgto[intCont], AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'));
  end;
end;

end.
