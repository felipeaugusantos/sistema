{***************************************}
{* Importação de arquivos do PAGSEGURO *}
{************************************AJ*}
unit untPagSeguro;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untPagSeguroPgto, ComCtrls, untTImportacaoCartao;

Type
  TPagSeguro = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TPagSeguroPgto;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TPagSeguro }

constructor TPagSeguro.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TPagSeguroPgto.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'PAGSEGURO';
  strMenCon := 'Versão do layout para importação: 2.01';
end;

destructor TPagSeguro.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

procedure TPagSeguro.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;

    LVersaoIncorreta: Boolean;

  function fCarregaArquivos(strExt: String): Boolean;
  Begin
    Result := False;
    If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        If (Pos('PAGSG', strLinha) > 0) And (LeftStr(strLinha, 1) = '0') Then
        Begin
          If Not MatchStr(Trim(Copy(strLinha, 71, 6)), ['002.01'])  Then
          Begin
            LVersaoIncorreta := True;

            Flush(txtArquivo);
            Close(txtArquivo);

            Continue;
          End;

          stlPgto.Add(strPath + '\' + arqArquivo.Name);
          Result := True;
        End;

        Flush(txtArquivo);
        Close(txtArquivo);

      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);
  End;
begin
  Try
    LVersaoIncorreta := False;

    fCarregaArquivos('txt');
    fCarregaArquivos('ret');

    If LVersaoIncorreta Then
        objFunctions.fIMensagem('ATENÇÃO','Existem arquivos de versões diferentes na pasta que não serão importados.' + #13 +
                                          'Entre em contato com o PagSeguro pelo e-mail edi@pagseguro.com.br e ' +
                                          'solicite a versão 2.01 desses arquivos!',['&OK']);

    If (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('ATENÇÃO','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros;

    If untPagSeguroPgto.ImportouPG Then
      objFunctions.fIMensagem('AVISO','Dados importados com sucesso!',['&OK'])
    Else
      objFunctions.fIMensagem('AVISO','Os arquivos foram importados, porém não possuem registros de pagamento!',['&OK']);

    frmForm.Close;
  Except
    On E: Exception Do
      objFunctions.fIMensagem('ERRO','Ocorreu um erro importar os registros.' + #13 +
                                     'Erro gerado: ' + E.Message,['&OK']);
  End;
end;

procedure TPagSeguro.pAdicionaLinhas;

  procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    Var
      intCont: Integer;
      intLin : Integer;
      stlAux : TStringList;
  begin
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

    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);

    End;

    FreeAndNil(stlAux);

  end;

Begin
  SetLength(FRegPagSeguroPgto , 0);

  pAdiciona(objPgto, stlPgto);
End;

procedure TPagSeguro.pGravarRegistros;
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
