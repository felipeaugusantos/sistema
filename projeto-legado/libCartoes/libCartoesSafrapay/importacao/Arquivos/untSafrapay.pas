unit untSafrapay;

interface

uses System.Classes, Vcl.Forms, System.SysUtils, System.StrUtils,

     cxProgressBar,

     untTSafrapayImportacaoCartao, untSafrapayPgto, untTSafrapayFuncoes,
     untISafrapayIntegracaoLibCartoes;

Type
  TSafrapay = Class(TSafrapayImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
  Private
    objPgto   : ICartoes;

    FArquivosPgto : TStringList;

    procedure AdicionaLinhasArquivos(itrCartoes: ICartoes);
    function ArquivoSafra(ALinha: String): Boolean;
    procedure pCarregaArquivos(strExt: String; strPath: String);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

{ TSafrapay }

constructor TSafrapay.Create(Owner: TComponent);
begin
  inherited;
  FArquivosPgto := TStringList.Create;

  objPgto := TSafrapayPgto.Create;

  VS_ListaEstabelecimentos := TStringList.Create;

  strNomCon := 'SAFRAPAY';
  strMenCon := '';
end;

destructor TSafrapay.Destroy;
begin
  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  FreeAndNil(FArquivosPgto);

  objPgto := Nil;

  SetLength(FSafrapayRegistrosPgto, 0);
  inherited;
end;

procedure TSafrapay.pCarregaArquivos(strExt: String; strPath: String);
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

          If ArquivoSafra(strLinha)  Then
            FArquivosPgto.Add(strPath + '\' + arqArquivo.Name);
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

function TSafrapay.ArquivoSafra(ALinha: String): Boolean;
begin
 Result := False;

  ALinha := AnsiUpperCase(ALinha);

  If(Pos('SAFRA CREDENCIADORA           ', ALinha) > 0) Then
  Begin
    Result := True;
  End;

end;

procedure TSafrapay.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
begin
  Try
    pCarregaArquivos('txt', strPath);
    pCarregaArquivos('ret', strPath);

    If FArquivosPgto.Count  = 0 Then
    Begin
      TSafraPayFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    TSafraPayFuncoes.fMensagem('','Dados importados com sucesso!',['&OK']);

    frmImportacaoCartoes.Close;
  Except
    On E: Exception Do
      TSafraPayFuncoes.fMensagem('ERRO','Ocorreu um erro ao importar os dados.' + #13 +
                                           'Erro gerado: ' + E.Message,['&OK']);
  End;
end;

procedure TSafrapay.AdicionaLinhasArquivos(itrCartoes: ICartoes);
Var
  intCont: Integer;
  intLin : Integer;
  stlAux : TStringList;
begin
  stlAux := Nil;
  Try
    stlAux := TStringList.Create;

    For intCont := 0 To FArquivosPgto.Count -1 Do
    Begin
      Application.ProcessMessages;

      stlAux.LoadFromFile(FArquivosPgto[intCont]);
      untSafrapayPgto.strNomArq := ExtractFileName(FArquivosPgto[intCont]);

      For intLin := 0 To stlAux.Count -1 Do
        itrCartoes.pAdicionaLinha(stlAux[intLin]);

      stlAux.Clear;
    End;

  Finally
    FreeAndNil(stlAux);
  End;
end;

procedure TSafrapay.pAdicionaLinhas;
begin
  Try
    SetLength(untSafrapayPgto.FSafrapayRegistrosPgto , 0);
    AdicionaLinhasArquivos(objPgto);
  Except
    Raise;
  End;
End;

procedure TSafrapay.pGravarRegistros(var prgStatus: TcxProgressBar);
Var
  intCont: Integer;
  SNomeArquivoSemExtensao : String;
begin
  VS_FuncoesExternas.fIStartTransaction;
  try
    objPgto.pGravarRegistros(prgStatus);
    VS_FuncoesExternas.fICommit;

    For intCont := 0 to FArquivosPgto.Count - 1 do
    Begin
      SNomeArquivoSemExtensao := ChangeFileExt(FArquivosPgto[intCont], '');
      if FileExists(SNomeArquivoSemExtensao + '.imp') then
        DeleteFile(SNomeArquivoSemExtensao + '.imp');
      TSafrapayFuncoes.pRenomeiaAquivo(FArquivosPgto[intCont], SNomeArquivoSemExtensao + '.imp');
    end;
  except
    on E: Exception do
    begin
      VS_FuncoesExternas.fIRollback;
      TSafraPayFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    end;
  end;
end;

end.
