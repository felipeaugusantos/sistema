{************************************}
{* Importação de arquivos da GETNET *}
{*********************************AJ*}
unit untGetNet;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untGetNetPgto, ComCtrls, untTImportacaoCartao, untTGetNetPgtoV10_1;

Type
  TGetNet = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TGetNetPgto;

    FObjetoPgto10_1: TGetNetPgtoV10_1;

    FArquivosVersao10_1: TStringList;

    procedure pCarregaArquivos(AExtensao, APasta: String);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TGetNet }

constructor TGetNet.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TGetNetPgto.Create;

  FObjetoPgto10_1 := TGetNetPgtoV10_1.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'GETNET';
  strMenCon := 'Versão do layout para importação: 10, 10.1 ou 10.3';

  FArquivosVersao10_1 := TStringList.Create;
end;

destructor TGetNet.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);

  FreeAndNil(FArquivosVersao10_1);
  inherited;
end;

procedure TGetNet.pCarregaArquivos(AExtensao, APasta: String);
  Var
    LSearchArquivo: TSearchRec;

    LArquivoGetNet: Boolean;

    LArquivo: TextFile;

    LLinhaArquivo: String;
Begin
  Try
    If (FindFirst(APasta + '\*.' + AExtensao, faAnyFile, LSearchArquivo) = 0) Then
    Begin
      Repeat
        Application.ProcessMessages;
        AssignFile(LArquivo, APasta + '\' + LSearchArquivo.Name);
        Reset(LArquivo);
        Readln(LArquivo, LLinhaArquivo);

        LArquivoGetNet := LLinhaArquivo.Contains('GETNET S.A.');
        If LArquivoGetNet Then
        Begin
          If LLinhaArquivo.ToUpperInvariant.Contains('SANT. V.8.0 400 BYTES') Then
            stlPgto.Add(APasta + '\' + LSearchArquivo.Name)
          Else If LLinhaArquivo.ToUpperInvariant.Contains('SANT. V.10 400 BYTES') Then
            stlPgto.Add(APasta + '\' + LSearchArquivo.Name)
          Else If LLinhaArquivo.ToUpperInvariant.Contains('SANT. V.10.1 400 BYTES') Then
            FArquivosVersao10_1.Add(APasta + '\' + LSearchArquivo.Name)
          Else If LLinhaArquivo.ToUpperInvariant.Contains('SANT. V.10.3 400 BYTES') Then
            FArquivosVersao10_1.Add(APasta + '\' + LSearchArquivo.Name)
          Else
          Begin
            objFunctions.fIMensagem('ATENÇÃO','Não foi possível importar o arquivo ' + LSearchArquivo.Name +
                                              ' pois não está nas versões 10, 10.1 ou 10.3.' + #13 +
                                              'Operação cancelada!',['&OK']);
            Flush(LArquivo);
            Close(LArquivo);
            frmForm.Close;
            Exit;
          End;

          Flush(LArquivo);
          Close(LArquivo);
        End;
      Until (FindNext(LSearchArquivo) <> 0);

    End;
  Finally
    FindClose(LSearchArquivo);
  End;
End;

procedure TGetNet.pProcessaArquivos(strPath: String);
begin
  Try
    pCarregaArquivos('txt', strPath);
    pCarregaArquivos('ret', strPath);

    If stlPgto.Count + FArquivosVersao10_1.Count = 0 Then
    Begin
      objFunctions.fIMensagem('AVISO','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros;

    objFunctions.fIMensagem('AVISO','Dados importados com sucesso!',['&OK']);

    frmForm.Close;
  Except
    On E: Exception Do
    Begin
      objFunctions.fIMensagem('ATENÇÃO', E.Message, ['&OK']);

      objPgto := TGetNetPgto.Create;

      FObjetoPgto10_1 := TGetNetPgtoV10_1.Create;

      lstEstabel := TStringList.Create;

      stlPgto.Clear;
    End;
  End;
end;

procedure TGetNet.pAdicionaLinhas;

  procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    Var
      intCont: Integer;
      intLin : Integer;
      stlAux : TStringList;

      LAchouFooter: Boolean;
  begin
    Try
      stlAux := TStringList.Create;

      If itrCartoes Is TGetNetPgto Then
      Begin
        For intCont := 0 To stlArqs.Count -1 Do
        Begin
          Application.ProcessMessages;
          stlAux.LoadFromFile(stlArqs[intCont]);
          untGetNetPgto.strNomArq := ExtractFileName(stlArqs[intCont]);

          LAchouFooter := False;

          For intLin := 0 To stlAux.Count -1 Do
          Begin
            If LeftStr(stlAux[intLin], 1) = '9' Then
              LAchouFooter := True;

            (itrCartoes as TGetNetPgto).pAdicionaLinha(stlAux[intLin]);
          End;

          stlAux.Clear;

          If Not LAchouFooter Then
            Raise Exception.Create('O arquivo ' + untGetNetPgto.strNomArq + ' está incompleto. Operação cancelada.!' + #13 +
                                   'Baixe o arquivo na Getnet e tente realizar a importação novamente.');
        End;
      End;

      If itrCartoes Is TGetNetPgtoV10_1 Then
      Begin
        For intCont := 0 To FArquivosVersao10_1.Count -1 Do
        Begin
          Application.ProcessMessages;
          stlAux.LoadFromFile(FArquivosVersao10_1[intCont]);

          (itrCartoes as TGetNetPgtoV10_1).NomeArquivo := ExtractFileName(FArquivosVersao10_1[intCont]);

          LAchouFooter := False;

          For intLin := 0 To stlAux.Count -1 Do
          Begin
            If LeftStr(stlAux[intLin], 1) = '9' Then
              LAchouFooter := True;

            (itrCartoes as TGetNetPgtoV10_1).pAdicionaLinha(stlAux[intLin]);
          End;

          stlAux.Clear;

          If Not LAchouFooter Then
            Raise Exception.Create('O arquivo ' + (itrCartoes as TGetNetPgtoV10_1).NomeArquivo + ' está incompleto. Operação cancelada.!' + #13 +
                                   'Baixe o arquivo na Getnet e tente realizar a importação novamente.');
        End;
      End;

    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;

    FreeAndNil(stlAux);

  end;

Begin
  Try
    SetLength(FRegGetNetPgto , 0);
    SetLength(FRegGetNetPgto10_1, 0);

    pAdiciona(objPgto, stlPgto);
    pAdiciona(FObjetoPgto10_1, FArquivosVersao10_1);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

procedure TGetNet.pGravarRegistros;
Var
  intCont: Integer;
begin
  objPgto.pGravarRegistros(pgbProg);
  FObjetoPgto10_1.pGravarRegistros(pgbProg);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'))) Then
      DeleteFile(AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'));
    pRenomeiaAquivo(stlPgto[intCont], AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'));
  end;

  For intCont := 0 to FArquivosVersao10_1.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(FArquivosVersao10_1[intCont], RightStr(FArquivosVersao10_1[intCont], 3), 'imp'))) Then
      DeleteFile(AnsiReplaceStr(FArquivosVersao10_1[intCont], RightStr(FArquivosVersao10_1[intCont], 3), 'imp'));
    pRenomeiaAquivo(FArquivosVersao10_1[intCont], AnsiReplaceStr(FArquivosVersao10_1[intCont], RightStr(FArquivosVersao10_1[intCont], 3), 'imp'));
  end;
end;

end.
