unit untMagazineLuiza;

interface

uses System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Controls,
     WinApi.Windows, Vcl.Graphics, Vcl.Buttons, System.StrUtils, System.SysUtils,

     Uni, cxProgressBar,

     untIMagazineLuizaIntegracaoLibCartoes, untTMagazineLuizaImportacaoCartao,
     untMagazineLuizaPgto, untTMagazineLuizaFuncoes,
     untLibCartoesInterfacesTipos;

Type
  TMagazineLuiza = Class(TMagazineLuizaImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas; override;
    procedure ProcessaArquivosSelecionados(AArquivos: TStringList; var prgStatus: TcxProgressBar); override;
    procedure CarregaArquivosSelecionados(AAquivos: TStringList);
    procedure pConcatenarComLinhasAbaixo(var ATextoLinha: string; AArquivo: TStringList; var AIndiceLinha: Integer);
  Private
    FMagazineLuizaPgto: ICartoesMagazineLuiza;

    function ArquivoVersaoAntiga(ALinhaArquivo: String): Boolean;
    function ArquivoVersao2026(ALinhaArquivo: String): Boolean;

    procedure pAdiciona(itrCartoes: ICartoesMagazineLuiza; stlArqs: TStringList);
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

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
    Raise ExceptionAutcom.Create('O arquivo [NOME_ARQUIVO] pode não ter sido exportado de forma correta.' + #13 +
                                 'Refaça a exportação selecionado:' + #13 +
                                 '-Conjunto de Caracteres: Europa Ocidental (Windows-1252/WinLatin 1); ' + #13 +
                                 '-Delimitador de campo: ; (ponto e vírgula);' + #13 +
                                 '-Delimitador de texto: (vazio).');

  If Not ALinhaArquivo.Contains('Observações') Then
    Raise ExceptionAutcom.Create('O arquivo [NOME_ARQUIVO] pode não ter sido exportado de forma correta.' + #13 +
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
Begin
  Try
    For LContador := 0 to AAquivos.Count - 1 Do
    Begin
      LNomeArquivo := System.SysUtils.ExtractFileName(AAquivos[LContador]);

      Application.ProcessMessages;
      AssignFile(LArquivo, AAquivos[LContador]);
      Try
        Reset(LArquivo);
        Readln(LArquivo, LLinhaArquivo);
        LLinhaArquivo := TMagazineLuizaFuncoes.fConverteParaAcento(LLinhaArquivo);

        If ArquivoVersaoAntiga(LLinhaArquivo) Then
          FArquivos.Add(AAquivos[LContador])
        Else If ArquivoVersao2026(LLinhaArquivo) Then
          FArquivosLayout2026.Add(AAquivos[LContador]);
      Finally
        Flush(LArquivo);
        Close(LArquivo);
      End;
    End;

  Except
    On E: ExceptionAutCom Do
      Raise Exception.Create(E.Message.Replace('[NOME_ARQUIVO]', LNomeArquivo));

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao abrir o arquivo ' + LNomeArquivo  +
                             '. Verifique se esse não está aberto em outro programa.');
  End;
end;

constructor TMagazineLuiza.Create(Owner: TComponent);
begin
  inherited;
  FMagazineLuizaPgto := TMagazineLuizaPgto.Create;
  strNomCon := 'MAGAZINE LUIZA';
  strMenCon := 'Converta o arquivo XLSX puro (sem alterações) para CSV, separado por ";"';
end;

destructor TMagazineLuiza.Destroy;
begin
  If Assigned(VS_IndicesCampos) Then
    FreeAndNil(VS_IndicesCampos);

  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  If Assigned(lstChave) Then
    FreeAndNil(lstChave);

  If Assigned(VS_DatasPagamento) Then
    FreeAndNil(VS_DatasPagamento);

  FMagazineLuizaPgto := Nil;

  TMagazineLuizaFuncoes.FreeAndNilDatasets(VS_RegistrosJaImportados);

  SetLength(FRegMagazineLuizaPgto, 0);
  inherited;
end;

procedure TMagazineLuiza.ProcessaArquivosSelecionados(AArquivos: TStringList;
  var prgStatus: TcxProgressBar);
begin
  Try
    If Assigned(FMagazineLuizaPgto) Then
      FMagazineLuizaPgto := Nil;

    FMagazineLuizaPgto := TMagazineLuizaPgto.Create;
    SetLength(FRegMagazineLuizaPgto, 0);

    CarregaArquivosSelecionados(AArquivos);
    If (FArquivos.Count + FArquivosLayout2026.Count = 0) Then
    Begin
      TMagazineLuizaFuncoes.fMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    VS_CodigoEmpresa := edtCodigoEmpresa.Text;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);

    TMagazineLuizaFuncoes.fMensagem('', 'Dados importados com sucesso!', ['&OK']);
  Except
    On E: Exception Do
      TMagazineLuizaFuncoes.fMensagem('ATENÇÃO', E.Message, ['&OK']);
  End;

  frmImportacaoCartoes.Close;
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

procedure TMagazineLuiza.pAdiciona(itrCartoes: ICartoesMagazineLuiza;
  stlArqs: TStringList);
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
    stlAux := TStringList.Create;

    For intCont := 0 To stlArqs.Count -1 Do
    Begin
      Application.ProcessMessages;
      stlAux.LoadFromFile(stlArqs[intCont]);
      untMagazineLuizaPgto.strNomArq := ExtractFileName(stlArqs[intCont]);
      FileGetDateTimeInfo(stlArqs[intCont], LDataArquivo);
      untMagazineLuizaPgto.strDtaArq := FormatDateTime('yyyy/mm/dd', LDataArquivo.CreationTime);

      If stlAux.Count > 0 Then
        LQtdeDelimitadoresHeader := stlAux[0].CountChar(';');

      intLin := 0;

      While intLin < stlAux.Count Do
      Begin
        LTextoLinha := stlAux[intLin];
        LQtdeDelimitadoresLinha := LTextoLinha.CountChar(';');

        // Tratamento para caso algum registro possua quebra de linha na observação
        If LQtdeDelimitadoresHeader > LQtdeDelimitadoresLinha Then
          pConcatenarComLinhasAbaixo(LTextoLinha, stlAux, intLin);

        FMagazineLuizaPgto.pAdicionaLinha(LTextoLinha);

        Inc(intLin);
      End;

      stlAux.Clear;
    End;
  Finally
    If Assigned(stlAux) Then
      FreeAndNil(stlAux);
  End;

  //Layout 2026
  LQtdeDelimitadoresHeader := 0;
  LAuxiliar := Nil;
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
        LTextoLinha := StringReplace(LTextoLinha, '"', '', [rfReplaceAll]);

        LQtdeDelimitadoresLinha := LTextoLinha.CountChar(';');

        // Tratamento para caso algum registro possua quebra de linha na observação
        If LQtdeDelimitadoresHeader > LQtdeDelimitadoresLinha Then
          pConcatenarComLinhasAbaixo(LTextoLinha, LAuxiliar, LLinha);

        FMagazineLuizaPgto.pAdicionaLinhaLayout2026(LTextoLinha);

        Inc(LLinha);
      End;

      LAuxiliar.Clear;
    End;
  Finally
    If Assigned(LAuxiliar) Then
      FreeAndNil(LAuxiliar);
  End;
end;

procedure TMagazineLuiza.pAdicionaLinhas;
Begin
  SetLength(FRegMagazineLuizaPgto, 0);

  pAdiciona(FMagazineLuizaPgto, FArquivos);

  If Assigned(lstChave) Then
    FreeAndNil(lstChave);
End;

procedure TMagazineLuiza.pGravarRegistros;
  Var
    intCont: Integer;
begin
  VS_FuncoesExternas.fIStartTransaction;

  Try
    FMagazineLuizaPgto.pGravarRegistros(prgStatus);

    VS_FuncoesExternas.fICommit;

    For intCont := 0 to FArquivos.Count - 1 do
    Begin
      If (FileExists(AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'))) Then
        DeleteFile(AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'));
      TMagazineLuizaFuncoes.pRenomeiaAquivo(FArquivos[intCont], AnsiReplaceStr(FArquivos[intCont], RightStr(FArquivos[intCont], 3), 'imp'));
    end;

    For intCont := 0 to FArquivosLayout2026.Count - 1 do
    Begin
      If (FileExists(AnsiReplaceStr(FArquivosLayout2026[intCont], RightStr(FArquivosLayout2026[intCont], 3), 'imp'))) Then
        DeleteFile(AnsiReplaceStr(FArquivosLayout2026[intCont], RightStr(FArquivosLayout2026[intCont], 3), 'imp'));
      TMagazineLuizaFuncoes.pRenomeiaAquivo(FArquivosLayout2026[intCont], AnsiReplaceStr(FArquivosLayout2026[intCont], RightStr(FArquivosLayout2026[intCont], 3), 'imp'));
    end;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;

      Raise Exception.Create(E.Message);
    End;
  End;
end;

end.
