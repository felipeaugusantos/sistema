{********************************************}
{* Importação de arquivos do MAGAZINE LUIZA *}
{*****************************************AJ*}
unit untMagazineLuiza;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untMagazineLuizaPgto, ComCtrls, untTImportacaoCartao, untConstantes;


Type
  TMagazineLuiza = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
    procedure ProcessaArquivosSelecionados(AAquivos: TStringList); override;
    procedure pConcatenarComLinhasAbaixo(var ATextoLinha: string; AArquivo: TStringList; var AIndiceLinha: Integer);
    procedure CarregaArquivosSelecionados(AAquivos: TStringList);
  Private
    FMagazineLuizaPgto   : TMagazineLuizaPgto;
    FArquivosLayout2026: TStringList;
    FArquivos: TStringList;
    procedure pAdiciona(itrCartoes: ICartoes; AArquivo: TStringList);
    function ArquivoVersaoAntiga(ALinhaArquivo: String): Boolean;
    function ArquivoVersao2026(ALinhaArquivo: String): Boolean;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TMagazineLuiza }

function TMagazineLuiza.ArquivoVersao2026(ALinhaArquivo: String): Boolean;
begin
  Result := True;

  If Not ALinhaArquivo.Contains('Número do pedido;') Then
    Exit(False);

  If ALinhaArquivo.Contains('ID do pedido Seller;') Then
    Exit(False);

  If Not ALinhaArquivo.Contains('Data do pedido;') Then
    Exit(False);

  If Not ALinhaArquivo.Contains('Data do repasse;') Then
    Exit(False);

  If Not ALinhaArquivo.Contains('ID da transação;') Then
    Raise ExceptionAutCom.Create('O arquivo [NOME_ARQUIVO] pode não ter sido exportado de forma correta.' + #13 +
                                 'Refaça a exportação selecionado:' + #13 +
                                 '-Conjunto de Caracteres: Europa Ocidental (Windows-1252/WinLatin 1); ' + #13 +
                                 '-Delimitador de campo: ; (ponto e vírgula);' + #13 +
                                 '-Delimitador de texto: (vazio).');

  If Not ALinhaArquivo.Contains('Observações') Then
    Raise ExceptionAutCom.Create('O arquivo [NOME_ARQUIVO] pode não ter sido exportado de forma correta.' + #13 +
                                 'Refaça a exportação selecionado:' + #13 +
                                 '-Conjunto de Caracteres: Europa Ocidental (Windows-1252/WinLatin 1); ' + #13 +
                                 '-Delimitador de campo: ; (ponto e vírgula);' + #13 +
                                 '-Delimitador de texto: (vazio).');

end;

function TMagazineLuiza.ArquivoVersaoAntiga(ALinhaArquivo: String): Boolean;
begin
  Result := True;

  If Not ALinhaArquivo.Contains('ID do pedido Magazine Luiza;') Then
    Exit(False);

  If Not ALinhaArquivo.Contains('ID do pedido Seller;') Then
    Exit(False);

  If Not ALinhaArquivo.Contains('Data da transação;') Then
    Exit(False);
end;

procedure TMagazineLuiza.CarregaArquivosSelecionados(AAquivos: TStringList);
Var
  LContador: Integer;
  LLinhaArquivo,
  LNomeArquivo : String;
  LArquivo: TextFile;
begin
  Try
    For LContador := 0 to AAquivos.Count - 1 Do
    Begin
      LNomeArquivo := System.SysUtils.ExtractFileName(AAquivos[LContador]);

      Application.ProcessMessages;
      AssignFile(LArquivo, AAquivos[LContador]);
      Reset(LArquivo);

      Try
        Readln(LArquivo, LLinhaArquivo);
        LLinhaArquivo := fConverteParaAcento(LLinhaArquivo);

        If ArquivoVersaoAntiga(LLinhaArquivo) Then
          FArquivos.Add(AAquivos[LContador])
        Else If ArquivoVersao2026(LLinhaArquivo) Then
          FArquivosLayout2026.Add(AAquivos[LContador]);

        Flush(LArquivo);
      Finally
        Close(LArquivo);
      End;
    End;
  Except
    On E: ExceptionAutCom  Do
      Raise Exception.Create(E.Message.Replace('[NOME_ARQUIVO]', LNomeArquivo));

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao abrir o arquivo ' + LNomeArquivo  +
                             '. Verifique se esse não está aberto em outro programa.');
  End;
end;

constructor TMagazineLuiza.Create(Owner: TComponent);
begin
  inherited;
  FMagazineLuizaPgto   := TMagazineLuizaPgto.Create;
  FArquivosLayout2026 := TStringList.Create;
  FArquivos     := TStringList.Create;
  strNomCon := 'MAGAZINE LUIZA';
  strMenCon := 'Converta o arquivo XLSX puro (sem alterações) para CSV, separado por ";"';
end;

destructor TMagazineLuiza.Destroy;
begin
  If Assigned(FMagazineLuizaPgto) Then
    FreeAndNil(FMagazineLuizaPgto);

  If Assigned(FArquivosLayout2026) Then
    FreeAndNil(FArquivosLayout2026);

  If Assigned(FArquivos) Then
    FreeAndNil(FArquivos);
  inherited;
end;

procedure TMagazineLuiza.ProcessaArquivosSelecionados(AAquivos: TStringList);
begin
  Try
    CarregaArquivosSelecionados(AAquivos);

    If (FArquivos.Count + FArquivosLayout2026.Count = 0) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
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
      frmForm.Close;
    End;
  End;
end;

procedure TMagazineLuiza.pConcatenarComLinhasAbaixo(
  var ATextoLinha: string;
  AArquivo: TStringList;
  var AIndiceLinha: Integer);
Var
  LTextoLinhaAtual: String;
  LIndiceAtual: Integer;
  LQtdeDelimitadoresHeader,
  LQtdeDelimitadoresLinhaAtual: Integer;
begin
  LQtdeDelimitadoresHeader := AArquivo[0].CountChar(';');
  LQtdeDelimitadoresLinhaAtual := AArquivo[AIndiceLinha].CountChar(';');
  LIndiceAtual := AIndiceLinha + 1;

  While LQtdeDelimitadoresLinhaAtual < LQtdeDelimitadoresHeader Do
  Begin
    LTextoLinhaAtual := AArquivo[LIndiceAtual];

    If Not LTextoLinhaAtual.Trim.IsEmpty Then
    Begin
      ATextoLinha := ATextoLinha + LTextoLinhaAtual;
      AArquivo.Delete(LIndiceAtual);
    End
    Else
    Begin
      Inc(LIndiceAtual);
    End;

    LQtdeDelimitadoresLinhaAtual := ATextoLinha.CountChar(';');
  End;

  AIndiceLinha := LIndiceAtual;
end;

procedure TMagazineLuiza.pAdiciona(itrCartoes: ICartoes; AArquivo: TStringList);
Var
    intCont  : Integer;
    intLin   : Integer;
    stlAux   : TStringList;
    LDataArquivo: TDateTimeInfoRec;
    LQtdeDelimitadoresHeader,
    LContador,
    LLinha,
    LQtdeDelimitadoresLinha: Integer;
    LTextoLinha: String;
    LAuxiliar: TStringList;
begin
  LQtdeDelimitadoresHeader := 0;
  stlAux := Nil;
  Try
    Try
      stlAux := TStringList.Create;

      For intCont := 0 To AArquivo.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(AArquivo[intCont]);
        untMagazineLuizaPgto.strNomArq := ExtractFileName(AArquivo[intCont]);
        FileGetDateTimeInfo(AArquivo[intCont], LDataArquivo);
        untMagazineLuizaPgto.strDtaArq := FormatDateTime('yyyy/mm/dd', LDataArquivo.CreationTime);

        If stlAux.Count > 0 Then
          LQtdeDelimitadoresHeader := stlAux[0].CountChar(';');

        intLin := 0;

        While intLin < stlAux.Count Do
        Begin
          LTextoLinha := stlAux[intLin];
          LTextoLinha := StringReplace(LTextoLinha, '"', '', [rfReplaceAll]);

          LQtdeDelimitadoresLinha := LTextoLinha.CountChar(';');

          // Tratamento para caso algum registro possua quebra de linha na observação
          If LQtdeDelimitadoresHeader > LQtdeDelimitadoresLinha Then
            pConcatenarComLinhasAbaixo(LTextoLinha, stlAux, intLin);

          FMagazineLuizaPgto.pAdicionaLinha(LTextoLinha);

          Inc(intLin);
        End;

        stlAux.Clear;
      End;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(stlAux);
  End;

  //Layout 2026
  LQtdeDelimitadoresHeader := 0;
  LAuxiliar := Nil;
  Try
    Try
      LAuxiliar := TStringList.Create;

      For LContador := 0 To FArquivosLayout2026.Count -1 Do
      Begin
        Application.ProcessMessages;
        LAuxiliar.LoadFromFile(FArquivosLayout2026[LContador]);
        untMagazineLuizaPgto.strNomArq := ExtractFileName(FArquivosLayout2026[LContador]);
        FileGetDateTimeInfo(FArquivosLayout2026[LContador], LDataArquivo);
        untMagazineLuizaPgto.strDtaArq := FormatDateTime('yyyy/mm/dd', LDataArquivo.CreationTime);

        If LAuxiliar.Count > 0 Then
          LQtdeDelimitadoresHeader := LAuxiliar[0].CountChar(';');

        LLinha := 0;
        While LLinha < LAuxiliar.Count Do
        Begin
          If LeftStr(LAuxiliar[LLinha], 11).Equals('Nrº Pedido:') Then
          Begin
            LAuxiliar[LLinha-1] := LAuxiliar[LLinha-1]+','+LAuxiliar[LLinha];
            LAuxiliar.Delete(LLinha);

            Continue;
          End;

          Inc(LLinha);
        End;

        LLinha := 0;
        While LLinha < LAuxiliar.Count Do
        Begin
          LTextoLinha := LAuxiliar[LLinha];
          LQtdeDelimitadoresLinha := LTextoLinha.CountChar(';');

          // Tratamento para caso algum registro possua quebra de linha na observação
          If LQtdeDelimitadoresHeader > LQtdeDelimitadoresLinha Then
            pConcatenarComLinhasAbaixo(LTextoLinha, LAuxiliar, LLinha);

          FMagazineLuizaPgto.pAdicionaLinhaLayout2026(LTextoLinha);

          Inc(LLinha);
        End;

        LAuxiliar.Clear;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LAuxiliar);
  End;
end;

procedure TMagazineLuiza.pAdicionaLinhas;
Begin
  SetLength(FRegMagazineLuizaPgto, 0);
  pAdiciona(FMagazineLuizaPgto, FArquivos);
End;

procedure TMagazineLuiza.pGravarRegistros;
Var
  intCont: Integer;
begin
  FMagazineLuizaPgto.pGravarRegistros(pgbProg);

  For intCont := 0 to FArquivos.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'))) Then
      DeleteFile(AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'));
    pRenomeiaAquivo(FArquivos[intCont], AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'));
  end;

  For intCont := 0 to FArquivosLayout2026.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(FArquivosLayout2026[intCont], RightStr(FArquivosLayout2026[intCont], 3), 'imp'))) Then
      DeleteFile(AnsiReplaceStr(FArquivosLayout2026[intCont], RightStr(FArquivosLayout2026[intCont], 3), 'imp'));
    pRenomeiaAquivo(FArquivosLayout2026[intCont], AnsiReplaceStr(FArquivosLayout2026[intCont], RightStr(FArquivosLayout2026[intCont], 3), 'imp'));
  end;
end;

procedure TMagazineLuiza.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    strLinha  : String;
    txtArquivo: TextFile;

  procedure pCarregaArquivos(strExt: String);
  Begin
    Try
      If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
      Begin
        Try
          Repeat
            Application.ProcessMessages;
            AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
            Reset(txtArquivo);

            Try
              Readln(txtArquivo, strLinha);
              strLinha := fConverteParaAcento(strLinha);

              If ArquivoVersaoAntiga(strLinha) Then
                FArquivos.Add(strPath + '\' + arqArquivo.Name)
              Else If ArquivoVersao2026(strLinha) Then
                FArquivosLayout2026.Add(strPath + '\' + arqArquivo.Name);
            Finally
              Close(txtArquivo);
            End;

          Until (FindNext(arqArquivo) <> 0);
        Finally
          FindClose(arqArquivo);
        End;
      End;
    Except
      On E: ExceptionAutCom Do
        Raise Exception.Create(E.Message.Replace('[NOME_ARQUIVO]', arqArquivo.Name));

      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao abrir o arquivo ' + arqArquivo.Name +
                               '. Verifique se esse não está aberto em outro programa.');
    End;
  End;
begin
  Try
    pCarregaArquivos('csv');
    If (FArquivos.Count + FArquivosLayout2026.Count = 0) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
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
      frmForm.Close;
    End;
  End;
end;

end.
