unit untAmazon;

interface

uses System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Controls,
     WinApi.Windows, Vcl.Graphics, Vcl.Buttons, System.StrUtils, System.SysUtils,

     Uni, cxProgressBar,

     untIAmazonIntegracaoLibCartoes, untTAmazonImportacaoCartao,
     untAmazonPgto, untTAmazonFuncoes,
     untLibCartoesInterfacesTipos;

Type
  TAmazon = Class(TAmazonImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas(var prgStatus: TcxProgressBar);  override;
    procedure ProcessaArquivosSelecionados(AArquivos: TStringList; var prgStatus: TcxProgressBar); override;
    procedure CarregaArquivosSelecionados(AArquivos: TStringList);
    procedure pAdiciona(itrCartoes: ICartoesAmazon; stlArqs: TStringList; var prgStatus: TcxProgressBar);
    function  ValidaArquivoFlatFileV2(ALinhaArquivo: String): Boolean;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor  Destroy; Override;
  End;

implementation

Var
    FAmazonPgto: ICartoesAmazon;


function TAmazon.ValidaArquivoFlatFileV2(ALinhaArquivo: String): Boolean;
begin
  Result := True;

  If Not (Pos('settlement-id', ALinhaArquivo) > 0) Then
    Exit(False);

  If Not (Pos('transaction-type', ALinhaArquivo) > 0) Then
    Exit(False);

  If Not (Pos('amount-type', ALinhaArquivo) > 0) Then
    Exit(False);

  If Not (Pos('amount-description', ALinhaArquivo) > 0) Then
    Exit(False);

  If Not (Pos('order-id', ALinhaArquivo) > 0) Then
    Exit(False);
end;

procedure TAmazon.CarregaArquivosSelecionados(AArquivos: TStringList);
  Var
    LContador    : Integer;
    LLinhaArquivo,
    LNomeArquivo : String;
    LArquivo     : TextFile;
Begin
  Try
    For LContador := 0 to AArquivos.Count - 1 Do
    Begin
      LNomeArquivo := System.SysUtils.ExtractFileName(AArquivos[LContador]);

      Application.ProcessMessages;
      AssignFile(LArquivo, AArquivos[LContador]);
      Reset(LArquivo);
      Try
        Readln(LArquivo, LLinhaArquivo);

        LLinhaArquivo := TAmazonFuncoes.fConverteParaAcento(LLinhaArquivo);

        If  LowerCase(ExtractFileExt(AArquivos[LContador])).Equals('.txt') Then
        Begin
          If ValidaArquivoFlatFileV2(LLinhaArquivo) Then
            FArquivos.Add(AArquivos[LContador])
          Else
            TAmazonFuncoes.fMensagem('ATENÇÃO',
                                   'O arquivo ' + LNomeArquivo + ' não é um arquivo de recebíveis da Amazon (Flat File V2) válido.' + #13 +
                                   'Verifique se o arquivo foi exportado corretamente pela Seller Central.',
                                   ['&OK']);
        End;
      Finally
        Flush(LArquivo);
        Close(LArquivo);
      End;
    End;
  Except
    FArquivos.Clear;
    Raise Exception.Create('Ocorreu um erro ao abrir o arquivo ' + LNomeArquivo  +
                           '. Verifique se esse não está aberto em outro programa.');
  End;
end;

constructor TAmazon.Create(Owner: TComponent);
begin
  inherited;
  FAmazonPgto := TAmazonPgto.Create;
  strNomCon   := 'AMAZON';
  strMenCon   := 'Selecione o arquivo Settlement Report (Flat File V2) exportado pela Seller Central.';
end;

destructor TAmazon.Destroy;
begin
  TAmazonFuncoes.FreeAndNilDatasets(VS_RegistrosJaImportados);

  If Assigned(VS_DatasPagamento) Then
    FreeAndNil(VS_DatasPagamento);

  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  FAmazonPgto := Nil;

  SetLength(FRegAmazonPgto, 0);

  inherited;
end;

procedure TAmazon.ProcessaArquivosSelecionados(AArquivos: TStringList;
  var prgStatus: TcxProgressBar);
begin
  Try
    FAmazonPgto := TAmazonPgto.Create;
    SetLength(FRegAmazonPgto, 0);

    CarregaArquivosSelecionados(AArquivos);

    If FArquivos.Count = 0 Then
    Begin
      TAmazonFuncoes.fMensagem('', 'Nenhum arquivo válido na pasta para importar!', ['&OK']);
      Exit;
    End;

    VS_CodigoEmpresa := edtCodigoEmpresa.Text;

    pAdicionaLinhas(prgStatus);
    pGravarRegistros(prgStatus);

    TAmazonFuncoes.fMensagem('', 'Dados importados com sucesso!', ['&OK']);
  Except
    On E: Exception Do
      TAmazonFuncoes.fMensagem('ATENÇÃO', E.Message, ['&OK']);
  End;

  frmImportacaoCartoes.Close;
end;

procedure TAmazon.pAdiciona(itrCartoes: ICartoesAmazon; stlArqs: TStringList;
  var prgStatus: TcxProgressBar);
Var
  intCont: Integer;
  intLin : Integer;
  stlAux : TStringList;
  LDataArquivo: TDateTimeInfoRec;
begin
  stlAux := TStringList.Create;
  Try
    For intCont := 0 To stlArqs.Count - 1 Do
    Begin
      Application.ProcessMessages;

      stlAux.LoadFromFile(stlArqs[intCont], TEncoding.UTF8);
      untAmazonPgto.strNomArq := ExtractFileName(stlArqs[intCont]);

      FileGetDateTimeInfo(stlArqs[intCont], LDataArquivo);
      untAmazonPgto.strDtaArq := FormatDateTime('yyyy/mm/dd', LDataArquivo.CreationTime);

      prgStatus.Position := 0;
      prgStatus.Properties.Max := stlAux.Count - 1;

      For intLin := 0 To stlAux.Count - 1 Do
      Begin
        FAmazonPgto.pAdicionaLinha(stlAux[intLin]);
        TAmazonFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Lendo arquivos.');
      End;

      stlAux.Clear;
    End;

    prgStatus.Position := 0;
  Finally
    FreeAndNil(stlAux);
  End;
end;

procedure TAmazon.pAdicionaLinhas(var prgStatus: TcxProgressBar);
Begin
  Try
    SetLength(FRegAmazonPgto, 0);
    pAdiciona(FAmazonPgto, FArquivos, prgStatus);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

procedure TAmazon.pGravarRegistros(var prgStatus: TcxProgressBar);
  Var
    intCont: Integer;
begin
  TAmazonFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Gravando registros.', False);

  VS_FuncoesExternas.fIStartTransaction;

  Try
    FAmazonPgto.pGravarRegistros(prgStatus);

    VS_FuncoesExternas.fICommit;

    For intCont := 0 to FArquivos.Count - 1 do
    Begin
      If FileExists(AnsiReplaceStr(FArquivos[intCont], ExtractFileExt(FArquivos[intCont]), '.imp')) Then
        DeleteFile(AnsiReplaceStr(FArquivos[intCont], ExtractFileExt(FArquivos[intCont]), '.imp'));

      TAmazonFuncoes.pRenomeiaAquivo(FArquivos[intCont],
                                     AnsiReplaceStr(FArquivos[intCont], ExtractFileExt(FArquivos[intCont]), '.imp'));
    End;

  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollback;
      Raise Exception.Create(E.Message);
    End;
  End;
end;

end.
