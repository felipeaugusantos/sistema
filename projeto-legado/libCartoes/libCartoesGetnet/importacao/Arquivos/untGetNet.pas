{************************************}
{* Importação de arquivos da GETNET *}
{*********************************AJ*}
unit untGetNet;

interface

uses System.Classes, Vcl.Forms, System.SysUtils, System.StrUtils,

      cxProgressBar,  dialogs,

      untTGetNetImportacaoCartao, untGetNetPgto, untTGetNetFuncoes,
      untIGetNetIntegracaoLibCartoes,untTGetNetPgtoV10_1;

Type
  TGetNet = Class(TGetnetImportacaoCartao)

    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas; override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
  Private
    objPgto: ICartoes;

    FObjetoPgto10_1: ICartoes;

    FArquivosVersao10_1,
    FArquivosVersao10: TStringList;

    procedure pCarregaArquivos(AExtensao, APasta: String);
    procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

{ TGetNet }

constructor TGetNet.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TGetNetPgto.Create;

  FObjetoPgto10_1 := TGetNetPgtoV10_1.Create;

  VS_ListaEstabelecimentos := TStringList.Create;

  strNomCon := 'GETNET';
  strMenCon := 'Versão do layout para importação: 10, 10.1 ou 10.3';

  FArquivosVersao10_1 := TStringList.Create;
  FArquivosVersao10   := TStringList.Create;
end;

destructor TGetNet.Destroy;
begin
  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  FreeAndNil(FArquivosVersao10_1);
  FreeAndNil(FArquivosVersao10);

  objPgto := Nil;
  FObjetoPgto10_1 := Nil;

  SetLength(FRegGetNetPgto10_1, 0);
  SetLength(FRegGetNetPgto, 0);
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
        Try
          Reset(LArquivo);
          Readln(LArquivo, LLinhaArquivo);

          LArquivoGetNet := LLinhaArquivo.Contains('GETNET S.A.');
          If LArquivoGetNet Then
          Begin
            If LLinhaArquivo.ToUpperInvariant.Contains('SANT. V.8.0 400 BYTES') Then
              FArquivosVersao10.Add(APasta + '\' + LSearchArquivo.Name)
            Else If LLinhaArquivo.ToUpperInvariant.Contains('SANT. V.10 400 BYTES') Then
              FArquivosVersao10.Add(APasta + '\' + LSearchArquivo.Name)
            Else If LLinhaArquivo.ToUpperInvariant.Contains('SANT. V.10.1 400 BYTES') Then
              FArquivosVersao10_1.Add(APasta + '\' + LSearchArquivo.Name)
            Else If LLinhaArquivo.ToUpperInvariant.Contains('SANT. V.10.3 400 BYTES') Then
              FArquivosVersao10_1.Add(APasta + '\' + LSearchArquivo.Name)
            Else
            Begin
              TGetNetFuncoes.fMensagem('ATENÇÃO','Não foi possível importar o arquivo ' + LSearchArquivo.Name +
                                                ' pois não está nas versões 10, 10.1 ou 10.3.' + #13 +
                                                'Operação cancelada!',['&OK']);
              frmImportacaoCartoes.close;
              Exit;
            End;
          End;
        Finally
          Flush(LArquivo);
          Close(LArquivo);
        End;
      Until (FindNext(LSearchArquivo) <> 0);

    End;
  Finally
    FindClose(LSearchArquivo);
  End;
End;

procedure TGetNet.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
begin
  Try
    pCarregaArquivos('txt', strPath);
    pCarregaArquivos('ret', strPath);

    If FArquivosVersao10.Count + FArquivosVersao10_1.Count = 0 Then
    Begin
      TGetNetFuncoes.fMensagem('AVISO','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    TGetNetFuncoes.fMensagem('AVISO','Dados importados com sucesso!',['&OK']);

    frmImportacaoCartoes.Close;
  Except
    On E: Exception Do
    Begin
      TGetNetFuncoes.fMensagem('ATENÇÃO', E.Message, ['&OK']);

      objPgto := Nil;
      objPgto := TGetNetPgto.Create;

      FObjetoPgto10_1 := Nil;
      FObjetoPgto10_1 := TGetNetPgtoV10_1.Create;

      If Assigned(VS_ListaEstabelecimentos) Then
        FreeAndNil(VS_ListaEstabelecimentos);

      VS_ListaEstabelecimentos := TStringList.Create;

      FArquivosVersao10.Clear;
    End;
  End;
end;

procedure TGetNet.pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
Var
  intCont: Integer;
  intLin : Integer;
  stlAux : TStringList;
  LAchouFooter: Boolean;
begin
  stlAux := Nil;
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
      For intCont := 0 To stlArqs.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(stlArqs[intCont]);

        (itrCartoes as TGetNetPgtoV10_1).NomeArquivo := ExtractFileName(stlArqs[intCont]);

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

  Finally
    If Assigned(stlAux) Then
      FreeAndNil(stlAux);
  End;
end;

procedure TGetNet.pAdicionaLinhas;
Begin
  Try
    SetLength(FRegGetNetPgto , 0);
    SetLength(FRegGetNetPgto10_1, 0);

    TGetNetFuncoes.FreeAndNilDatasets(VS_RegistrosJaImportados);

    pAdiciona(objPgto, FArquivosVersao10);
    pAdiciona(FObjetoPgto10_1, FArquivosVersao10_1);
  Except
    Raise;
  End;
End;

procedure TGetNet.pGravarRegistros;
Var
  intCont: Integer;
begin
  objPgto.pGravarRegistros(prgStatus);
  FObjetoPgto10_1.pGravarRegistros(prgStatus);

  For intCont := 0 to FArquivosVersao10.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(FArquivosVersao10[intCont], RightStr(FArquivosVersao10[intCont], 3), 'imp'))) Then
      DeleteFile(AnsiReplaceStr(FArquivosVersao10[intCont], RightStr(FArquivosVersao10[intCont], 3), 'imp'));
    TGetnetFuncoes.pRenomeiaAquivo(FArquivosVersao10[intCont], AnsiReplaceStr(FArquivosVersao10[intCont], RightStr(FArquivosVersao10[intCont], 3), 'imp'));
  end;

  For intCont := 0 to FArquivosVersao10_1.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(FArquivosVersao10_1[intCont], RightStr(FArquivosVersao10_1[intCont], 3), 'imp'))) Then
      DeleteFile(AnsiReplaceStr(FArquivosVersao10_1[intCont], RightStr(FArquivosVersao10_1[intCont], 3), 'imp'));
    TGetnetFuncoes.pRenomeiaAquivo(FArquivosVersao10_1[intCont], AnsiReplaceStr(FArquivosVersao10_1[intCont], RightStr(FArquivosVersao10_1[intCont], 3), 'imp'));
  end;
end;

end.
