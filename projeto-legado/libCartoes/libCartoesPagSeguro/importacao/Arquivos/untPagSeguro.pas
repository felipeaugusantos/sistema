{***************************************}
{* Importação de arquivos do PAGSEGURO *}
{************************************AJ*}
unit untPagSeguro;

interface

uses System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Controls,
     WinApi.Windows, Vcl.Graphics, Vcl.Buttons, System.StrUtils,
     System.SysUtils, Vcl.ComCtrls,

     BitBtnLockedIncrem, cxProgressBar,

     untPagSeguroPgto, untTPagSeguroImportacaoCartao, untTPagSeguroFuncoes,
     untIPagSeguroIntegracaoLibCartoes;

Type
  TPagSeguro = Class(TPagSeguroImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
  Private
    stlPgto   : TStringList;

    objPgto: ICartoes;

    procedure AdicionaLinhasArquivos(itrCartoes: ICartoes; stlArqs: TStringList);
    procedure pCarregaArquivos(strExt: String; strPath: String; var AVersaoIncorreta: Boolean);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

{ TPagSeguro }

procedure TPagSeguro.AdicionaLinhasArquivos(itrCartoes: ICartoes;
  stlArqs: TStringList);
  Var
    intCont: Integer;
    intLin : Integer;
    stlAux : TStringList;
begin
  stlAux := Nil;
  Try
    stlAux := TStringList.Create;

    For intCont := 0 To stlArqs.Count -1 Do
    Begin
      Application.ProcessMessages;
      stlAux.LoadFromFile(stlArqs[intCont]);
      untPagSeguroPgto.strNomArq := ExtractFileName(stlArqs[intCont]);

      //Apenas extrato financeiro
      If (Not MatchStr(Copy(stlAux[0], 48, 2), ['02', '03'])) Then
        Continue;

      untPagSeguroPgto.strTipArq := Copy(stlAux[0], 48, 2);

      For intLin := 0 To stlAux.Count -1 Do
        itrCartoes.pAdicionaLinha(stlAux[intLin]);

      stlAux.Clear;
    End;
  Finally
    If Assigned(stlAux) Then
      FreeAndNil(stlAux);
  End;
end;

constructor TPagSeguro.Create(Owner: TComponent);
begin
  inherited;
  stlPgto := TStringList.Create;

  objPgto:= TPagSeguroPgto.Create;

  VS_ListaEstabelecimentos := TStringList.Create;

  strNomCon := 'PAGSEGURO';
  strMenCon := 'Versão do layout para importação: 2.01';
end;

destructor TPagSeguro.Destroy;
begin
  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  If Assigned(stlPgto) Then
    FreeAndNil(stlPgto);

  objPgto := Nil;

  SetLength(FRegPagSeguroPgto, 0);
  inherited;
end;

procedure TPagSeguro.pProcessaArquivos(strPath: String;
  var prgStatus: TcxProgressBar);
  Var
    LVersaoIncorreta: Boolean;
begin
  Try
    LVersaoIncorreta := False;

    pCarregaArquivos('txt', strPath, LVersaoIncorreta);
    pCarregaArquivos('ret', strPath, LVersaoIncorreta);

    If LVersaoIncorreta Then
      TPagSeguroFuncoes.fMensagem('ATENÇÃO','Existem arquivos de versões diferentes na pasta que não serão importados.' + #13 +
                                            'Entre em contato com o PagSeguro pelo e-mail edi@pagseguro.com.br e ' +
                                            'solicite a versão 2.01 desses arquivos!',['&OK']);

    If (stlPgto.Count = 0) Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    If untPagSeguroPgto.ImportouPG Then
      TPagSeguroFuncoes.fMensagem('AVISO','Dados importados com sucesso!',['&OK'])
    Else
      TPagSeguroFuncoes.fMensagem('AVISO','Os arquivos foram importados, porém não possuem registros de pagamento!',['&OK']);

    frmImportacaoCartoes.Close;
  Except
    On E: Exception Do
      TPagSeguroFuncoes.fMensagem('ERRO','Ocorreu um erro importar os registros.' + #13 +
                                           'Erro gerado: ' + E.Message,['&OK']);
  End;
end;

procedure TPagSeguro.pAdicionaLinhas;
Begin
  Try
    SetLength(FRegPagSeguroPgto , 0);

    AdicionaLinhasArquivos(objPgto, stlPgto);
  Except
    Raise;
  End;
End;

procedure TPagSeguro.pCarregaArquivos(strExt, strPath: String;
  var AVersaoIncorreta: Boolean);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;
begin
  Try
    If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Try
          Reset(txtArquivo);
          Readln(txtArquivo, strLinha);

          If (Pos('PAGSG', strLinha) > 0) And (LeftStr(strLinha, 1) = '0') Then
          Begin
            If Not MatchStr(Trim(Copy(strLinha, 71, 6)), ['002.01'])  Then
            Begin
              AVersaoIncorreta := True;

              Flush(txtArquivo);
              Close(txtArquivo);

              Continue;
            End;

            stlPgto.Add(strPath + '\' + arqArquivo.Name);
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

procedure TPagSeguro.pGravarRegistros(var prgStatus: TcxProgressBar);
Var
  intCont: Integer;
begin
  VS_FuncoesExternas.fIStartTransaction;

  Try
    objPgto.pGravarRegistros(prgStatus);
    VS_FuncoesExternas.fICommit;

    For intCont := 0 to stlPgto.Count - 1 do
    Begin
      If (FileExists(AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'))) Then
        DeleteFile(AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'));
      TPagSeguroFuncoes.pRenomeiaAquivo(stlPgto[intCont], AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'));
    end;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      TPagSeguroFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    End;
  End;
end;

end.
