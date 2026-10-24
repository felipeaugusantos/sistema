unit untYapay;

interface

uses  System.Classes, Vcl.Forms, System.SysUtils, System.StrUtils,

      cxProgressBar,  dialogs,

      untTYapayImportacaoCartao, untYapayPgto, untTYapayFuncoes,
      untIYapayIntegracaoLibCartoes;

type
  TYapay = class(TYapayImportacaoCartao)
    procedure pGravarRegistros(var prgStatus: TcxProgressBar); override;
    procedure pAdicionaLinhas; override;
    procedure pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar); override;
  private
    objPgto: ICartoes;

    stlPgto: TStringList;

    function ArquivoYapay(Alinha: string): Boolean;
    procedure pCarregaArquivos(AStrExt: String; const AStrPath: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function fVerificaName(strExt : String = ''; strName: String = '') : Boolean;
  end;

implementation

{ TYapay }

function TYapay.ArquivoYapay(Alinha: string): Boolean;
begin
  Result := False;

  If (Pos('Data do lançamento;Extrato;Transação;Descrição do lançamento;', Alinha) > 0) Then
    Exit(True);
  if (Pos('Id;Transação;Pedido;Status;Descrição;Valor;', Alinha) > 0) then
    Exit(True);
  if (Pos('Data;ID Transa', Alinha) > 0) then
    Exit(True);
end;

constructor TYapay.Create(AOwner: TComponent);
begin
  inherited;
  stlPgto := TStringList.Create;

  objPgto    := TYapayPgto.Create;

  strNomCon := 'YAPAY';
  strMenCon := 'Importe o arquivo CSV puro do site, sem alterações.';
end;

destructor TYapay.Destroy;
begin
  If Assigned(stlPgto) Then
    FreeAndNil(stlPgto);

  If Assigned(VS_ListaEstabelecimentos) Then
    FreeAndNil(VS_ListaEstabelecimentos);

  objPgto := Nil;

  If Assigned(FYapayRegistrosPgto) Then
  Begin
    FYapayRegistrosPgto.Clear;
    FreeAndNil(FYapayRegistrosPgto);
  End;

  inherited;
end;

function TYapay.fVerificaName(strExt, strName: String): Boolean;
begin
  Result := True;
  If strExt <> '' Then
    Result := False
  Else If strName = '' Then
    Result := False;
end;

procedure TYapay.pCarregaArquivos(AStrExt: String; const AStrPath: String);
var
  LArqArquivo: TSearchRec;
  stlAux: TStringList;
  LStrLinha, LArqPath: string;
begin
  stlAux := TStringList.Create;
  Try
    if FindFirst(AStrPath + TYapayFuncoes.IIF(AStrExt <> '', '\*.' + AStrExt, '\*'), faAnyFile, LArqArquivo) = 0 then
    begin
      repeat
        if fVerificaName(AStrExt, ExtractFileExt(LArqArquivo.Name)) then
          Continue;

        if (LArqArquivo.Attr and faDirectory) = faDirectory then
          Continue;

        Application.ProcessMessages;

        LArqPath := IncludeTrailingPathDelimiter(AStrPath) + LArqArquivo.Name;

        stlAux.Clear;
        stlAux.LoadFromFile(LArqPath);
        if stlAux.Count > 0 then
        begin
          LStrLinha := stlAux[0];

          if ArquivoYapay(LStrLinha) then
            stlPgto.Add(LArqPath);
        end;
      until (FindNext(LArqArquivo) <> 0);
    end;
  Finally
    FindClose(LArqArquivo);

    If Assigned(stlAux) Then
      FreeAndNil(stlAux);
  End;
end;

procedure TYapay.pAdicionaLinhas;
Var
  LContador,
  LContadorLinha: Integer;
  LDataArquivo: TDateTimeInfoRec;
  LListaStrings: TStringList;
Begin
  LListaStrings := TStringList.Create;
  try
    For LContador := 0 To stlPgto.Count -1 Do
    Begin
      Application.ProcessMessages;
      LListaStrings.LoadFromFile(stlPgto[LContador]);

      untYapayPgto.NomeArquivo := ExtractFileName(stlPgto[LContador]);

      FileGetDateTimeInfo(stlPgto[LContador], LDataArquivo);
      untYapayPgto.DataArquivo := FormatDateTime('yyyy/mm/dd', LDataArquivo.CreationTime);

      For LContadorLinha := 0 To LListaStrings.Count -1 Do
      begin
        objPgto.pAdicionaLinha(LListaStrings[LContadorLinha]);
      end;

      LListaStrings.Clear;
    End;
  finally
    FreeAndNil(LListaStrings);
  end;
End;

procedure TYapay.pGravarRegistros(var prgStatus: TcxProgressBar);
var
  LContador: Integer;
  LNomeArquivoSemExtensao: string;
begin
  VS_FuncoesExternas.fIStartTransaction;
  try
    objPgto.pGravarRegistros(prgStatus);

    VS_FuncoesExternas.fICommit;
    for LContador := 0 to stlPgto.Count - 1 do
    begin
      LNomeArquivoSemExtensao := ChangeFileExt(stlPgto[LContador], '');
      if FileExists(LNomeArquivoSemExtensao + '.imp') then
        DeleteFile(LNomeArquivoSemExtensao + '.imp');
      TYapayFuncoes.pRenomeiaAquivo(stlPgto[LContador], LNomeArquivoSemExtensao + '.imp');
    end;
  except
    on E: Exception do
    begin
      VS_FuncoesExternas.fIRollback;
      TYapayFuncoes.fMensagem('ERRO', E.Message, ['&Ok']);
    end;
  end;
end;

procedure TYapay.pProcessaArquivos(strPath: String; var prgStatus: TcxProgressBar);
var
  LMensagemSucesso : String;
begin
  try
    pCarregaArquivos('csv', strPath);
    pCarregaArquivos('txt', strPath);
    pCarregaArquivos('ret', strPath);
    pCarregaArquivos('', strPath);

    if stlPgto.Count = 0 then
    begin
      TYapayFuncoes.fMensagem('Aviso', 'Nenhum arquivo Yapay encontrado.', ['&OK']);
      Exit;
    end;

    pAdicionaLinhas;
    pGravarRegistros(prgStatus);
    LMensagemSucesso := 'Dados importados com sucesso';

    if not untYapayPgto.FImportouPagamentos then
      LMensagemSucesso := LMensagemSucesso + ', porém não possui registros de pagamentos no período.';

    TYapayFuncoes.fMensagem('',LMensagemSucesso,['&OK']);

    frmImportacaoCartoes.Close;
  Except
    On E: Exception Do
      TYapayFuncoes.fMensagem('ERRO','Ocorreu um erro ao importar os dados.' + #13 +
                                           'Erro gerado: ' + E.Message,['&OK']);
  End;
end;

end.
