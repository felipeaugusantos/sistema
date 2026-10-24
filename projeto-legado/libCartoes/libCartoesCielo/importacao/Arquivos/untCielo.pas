unit untCielo;

interface

uses System.Classes, Vcl.Forms, WinApi.Windows, Vcl.Graphics, System.StrUtils,
     System.SysUtils,

     cxProgressBar, Uni,

     untTCieloImportacaoCartao, untTCieloFuncoes, untTCieloPgtoV15, untCieloPgto,
     untICieloIntegracaoLibCartoes;

Type
  TCielo = Class(TCieloImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
  Private
    objPgto   : ICartoes;

    FObjetoPgto015: ICartoes;

    FArquivosVersao14,
    FArquivosVersao15: TStringList;

    FListaVersao014: TStringList;

    procedure pCarregaArquivos(AExtensao, APasta: String);
    procedure AdicionaLinhasArquivos(itrCartoes: ICartoes);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

{ TCielo }

procedure TCielo.AdicionaLinhasArquivos(itrCartoes: ICartoes);
  Var
    intCont: Integer;
    intLin : Integer;
    stlAux : TStringList;
begin
  stlAux := TStringList.Create;
  Try
    If itrCartoes Is TCieloPgto Then
    Begin
      For intCont := 0 To FArquivosVersao14.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(FArquivosVersao14[intCont]);
        untCieloPgto.strNomArq := ExtractFileName(FArquivosVersao14[intCont]);
        untCieloPgto.ContadorAjustes := 1;
        untCieloPgto.ContadorGravame := 1;

        For intLin := 0 To stlAux.Count -1 Do
          (itrCartoes As TCieloPgto).pAdicionaLinha(stlAux[intLin]);

        stlAux.Clear;
      End;
    End;

    If itrCartoes Is TCieloPgtoV15 Then
    Begin
      For intCont := 0 To FArquivosVersao15.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(FArquivosVersao15[intCont]);

        (itrCartoes As TCieloPgtoV15).NomeArquivo := ExtractFileName(FArquivosVersao15[intCont]);

        if stlAux.Count > 2 then
          For intLin := 0 To stlAux.Count -1 Do
            (itrCartoes As TCieloPgtoV15).pAdicionaLinha(stlAux[intLin]);

        stlAux.Clear;
      End;
    End;

  Finally
    FreeAndNil(stlAux);
  End;
end;

constructor TCielo.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TCieloPgto.Create;
  FObjetoPgto015 := TCieloPgtoV15.Create;

  if not Assigned(VS_ListaEstabelecimentos) then
    VS_ListaEstabelecimentos := TStringList.Create;

  strNomCon := 'CIELO';
  strMenCon := '';

  FArquivosVersao15 := TStringList.Create;
  FArquivosVersao14 := TStringList.Create;
  FListaVersao014 := TStringList.Create;
end;

destructor TCielo.Destroy;
begin
  FreeAndNil(FArquivosVersao15);
  FreeAndNil(FArquivosVersao14);
  FreeAndNil(FListaVersao014);

  objPgto := Nil;
  FObjetoPgto015 := Nil;

  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  inherited;
end;

procedure TCielo.pCarregaArquivos(AExtensao, APasta: String);
  Var
    LSearchArquivo: TSearchRec;

    LArquivo: TextFile;

    LLinhaArquivo: String;
Begin
  Try
    if (FindFirst(APasta + TCieloFuncoes.IIF(AExtensao <> '', '\*.' + AExtensao, '\*'), faAnyFile, LSearchArquivo) = 0) Then
    Begin

      Repeat
        if (AExtensao = '') Then
        Begin
          If (ExtractFileExt(LSearchArquivo.Name) <> '') then
            continue;
        End;

        If LSearchArquivo.Attr = faDirectory Then
          Continue;

        Application.ProcessMessages;
        AssignFile(LArquivo, APasta + '\' + LSearchArquivo.Name);
        Try
          Reset(LArquivo);
          Readln(LArquivo, LLinhaArquivo);

          If Copy(LLinhaArquivo, 43, 05) = 'CIELO' Then
          Begin
            If Concat(Copy(LLinhaArquivo, 43, 05), Copy(LLinhaArquivo, 71, 03)) <> 'CIELO015' Then
              FArquivosVersao14.Add(APasta + '\' + LSearchArquivo.Name)
            Else
              FArquivosVersao15.Add(APasta + '\' + LSearchArquivo.Name);
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

procedure TCielo.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
Var
  LMensagemSucesso : String;
begin
  Try
    pCarregaArquivos('txt', strPath);
    pCarregaArquivos('ret', strPath);
    pCarregaArquivos('', strPath);
    If FArquivosVersao14.Count + FArquivosVersao15.Count = 0 Then
    Begin
      TCieloFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    LMensagemSucesso := 'Dados importados com sucesso';

    If (Not untTCieloPgtoV15.FImportouPagamentos) And (FArquivosVersao15.Count > 0) Then
      LMensagemSucesso := LMensagemSucesso + ', porém não possui registros de pagamentos no período.'
    Else
      LMensagemSucesso := LMensagemSucesso + '!';

    TCieloFuncoes.fMensagem('',LMensagemSucesso,['&OK']);
  Except
    On E: Exception Do
      TCieloFuncoes.fMensagem('','Ocorreu um erro ao importar os dados. Erro gerado: ' + E.Message,['&OK']);
  End;
  frmImportacaoCartoes.Close;
end;

procedure TCielo.pAdicionaLinhas;
Begin
  SetLength(FRegCieloPgto , 0);
  SetLength(FRegCieloPgto015 , 0);

  untCieloPgto.FListaVersao014 := FListaVersao014;
  AdicionaLinhasArquivos(objPgto);

  untTCieloPgtoV15.FListaVersao014 := FListaVersao014;
  AdicionaLinhasArquivos(FObjetoPgto015);
End;

procedure TCielo.pGravarRegistros(var prgStatus: TcxProgressBar);
Var
  LContador: Integer;

  LNomeArquivoSemExtensao: String;
begin
  VS_FuncoesExternas.fIStartTransaction;
  Try
    objPgto.pGravarRegistros(prgStatus);
    FObjetoPgto015.pGravarRegistros(prgStatus);
    VS_FuncoesExternas.fICommit;

    For LContador := 0 to FArquivosVersao14.Count - 1 do
    Begin
      LNomeArquivoSemExtensao := AnsiReplaceStr(FArquivosVersao14[LContador],
                                                ExtractFileExt(FArquivosVersao14[LContador]),
                                                '');

      If FileExists(LNomeArquivoSemExtensao+'.imp') Then
        DeleteFile(LNomeArquivoSemExtensao+'.imp');
      TCieloFuncoes.pRenomeiaAquivo(FArquivosVersao14[LContador], LNomeArquivoSemExtensao+'.imp');
    end;

    For LContador := 0 To FArquivosVersao15.Count -1 Do
    Begin
      LNomeArquivoSemExtensao := AnsiReplaceStr(FArquivosVersao15[LContador],
                                                ExtractFileExt(FArquivosVersao15[LContador]),
                                                '');

      If FileExists(LNomeArquivoSemExtensao+'.imp') Then
        DeleteFile(LNomeArquivoSemExtensao+'.imp');
      TCieloFuncoes.pRenomeiaAquivo(FArquivosVersao15[LContador], LNomeArquivoSemExtensao+'.imp');
    End;
  Except
     On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      TCieloFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

end.
