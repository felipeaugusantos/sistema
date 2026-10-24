{************************************}
{* Importação de arquivos da CIELO  *}
{*********************************AJ*}
unit untCielo;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untCieloPgto, ComCtrls, untTImportacaoCartao, untTCieloPgtoV15;

Type
  TCielo = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TCieloPgto;

    FObjetoPgto015: TCieloPgtoV15;

    FArquivosVersao15: TStringList;

    FListaVersao014: TStringList;

    procedure pCarregaArquivos(AExtensao, APasta: String);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TCielo }

constructor TCielo.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TCieloPgto.Create;
  FObjetoPgto015 := TCieloPgtoV15.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'CIELO';
  strMenCon := '';

  FArquivosVersao15 := TStringList.Create;
  FListaVersao014 := TStringList.Create;
end;

destructor TCielo.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);

  FreeAndNil(FArquivosVersao15);
  FreeAndNil(FListaVersao014);
  inherited;
end;

procedure TCielo.pCarregaArquivos(AExtensao, APasta: String);
  Var
    LSearchArquivo: TSearchRec;

    LArquivo: TextFile;

    LLinhaArquivo: String;
Begin
  if (FindFirst(APasta + IIF(AExtensao <> '', '\*.' + AExtensao, '\*'), faAnyFile, LSearchArquivo) = 0) Then
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
      Reset(LArquivo);
      Readln(LArquivo, LLinhaArquivo);

      If Copy(LLinhaArquivo, 43, 05) = 'CIELO' Then
      Begin
        If Concat(Copy(LLinhaArquivo, 43, 05), Copy(LLinhaArquivo, 71, 03)) <> 'CIELO015' Then
        begin
          stlPgto.Add(APasta + '\' + LSearchArquivo.Name)
        end
        Else
        begin
          If Concat(Copy(LLinhaArquivo, 43, 05), Copy(LLinhaArquivo, 71, 03)) = 'CIELO015' Then
          begin
            if Copy(LLinhaArquivo, 48, 02) <> '03' then
              FArquivosVersao15.Add(APasta + '\' + LSearchArquivo.Name);
          end;
        end;
      End;

      Flush(LArquivo);
      Close(LArquivo);

    Until (FindNext(LSearchArquivo) <> 0);

  End;
  FindClose(LSearchArquivo);
End;

procedure TCielo.pProcessaArquivos(strPath: String);
Var
  LMensagemSucesso : String;
begin
  Try
    pCarregaArquivos('txt', strPath);
    pCarregaArquivos('ret', strPath);
    pCarregaArquivos('', strPath);
    If (stlPgto.Count = 0) Then
    Begin
      If FArquivosVersao15.Count = 0 Then
      Begin
        objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
        Exit;
      End;
    End;

    pAdicionaLinhas;
    pGravarRegistros;

    LMensagemSucesso := 'Dados importados com sucesso';

    If (Not untTCieloPgtoV15.FImportouPagamentos) And (FArquivosVersao15.Count > 0) Then
      LMensagemSucesso := LMensagemSucesso + ', porém não possui registros de pagamentos no período.'
    Else
      LMensagemSucesso := LMensagemSucesso + '!';

    objFunctions.fIMensagem('',LMensagemSucesso,['&OK']);
  Except
    On E: Exception Do
      objFunctions.fIMensagem('','Ocorreu um erro ao importar os dados. Erro gerado: ' + E.Message,['&OK']);
  End;
  frmForm.Close;
end;

procedure TCielo.pAdicionaLinhas;

  procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    Var
      intCont: Integer;
      intLin : Integer;
      stlAux : TStringList;
  begin
    Try
      stlAux := TStringList.Create;

      If itrCartoes Is TCieloPgto Then
      Begin
        For intCont := 0 To stlArqs.Count -1 Do
        Begin
          Application.ProcessMessages;
          stlAux.LoadFromFile(stlArqs[intCont]);
          untCieloPgto.strNomArq := ExtractFileName(stlArqs[intCont]);
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

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

    FreeAndNil(stlAux);

  end;

Begin
  SetLength(FRegCieloPgto , 0);
  SetLength(FRegCieloPgto015 , 0);

  untCieloPgto.FListaVersao014 := FListaVersao014;
  pAdiciona(objPgto, stlPgto);

  untTCieloPgtoV15.FListaVersao014 := FListaVersao014;
  pAdiciona(FObjetoPgto015, FArquivosVersao15);
End;

procedure TCielo.pGravarRegistros;
Var
  intCont: Integer;
  SNomeArquivoSemExtensao : String;
begin
  Try
    objPgto.pGravarRegistros(pgbProg);
    FObjetoPgto015.pGravarRegistros(pgbProg);

    For intCont := 0 to stlPgto.Count - 1 do
    Begin
      SNomeArquivoSemExtensao := AnsiReplaceStr(stlPgto[intCont],
                                                ExtractFileExt(stlPgto[intCont]),
                                                '');

      If FileExists(SNomeArquivoSemExtensao+'.imp') Then
        DeleteFile(SNomeArquivoSemExtensao+'.imp');
      pRenomeiaAquivo(stlPgto[intCont], SNomeArquivoSemExtensao+'.imp');
    end;

    For intCont := 0 To FArquivosVersao15.Count -1 Do
    Begin
      SNomeArquivoSemExtensao := AnsiReplaceStr(FArquivosVersao15[intCont],
                                                ExtractFileExt(FArquivosVersao15[intCont]),
                                                '');

      If FileExists(SNomeArquivoSemExtensao+'.imp') Then
        DeleteFile(SNomeArquivoSemExtensao+'.imp');
      pRenomeiaAquivo(FArquivosVersao15[intCont], SNomeArquivoSemExtensao+'.imp');
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar os registros. Erro gerado: ' + E.Message);
  End;
end;

end.
