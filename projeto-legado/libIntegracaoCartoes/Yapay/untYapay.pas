unit untYapay;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  ComCtrls, untTImportacaoCartao, untYapayPgto;

Type
  TYapay = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto : TYapayPgto;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TYapay }

constructor TYapay.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TYapayPgto.Create;

  strNomCon := 'YAPAY';
  strMenCon := 'Importe o arquivo CSV puro do site, sem alterações.';
end;

destructor TYapay.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  inherited;
end;

procedure TYapay.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;
begin
  Try
    If (FindFirst(strPath + '\*.*', faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        if RightStr(arqArquivo.Name, 4).ToUpper = '.IMP' Then
          Continue;

        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);

        if ArquivoValidoParaImportacao(arqArquivo) then
        begin
          Reset(txtArquivo);
          Readln(txtArquivo, strLinha);

          If (Pos('Data do lançamento;Extrato;Transação;Descrição do lançamento;', strLinha) > 0) Then
            stlPgto.Add(strPath + '\' + arqArquivo.Name)
          Else If (Pos('Id;Transação;Pedido;Status;Descrição;Valor;', strLinha) > 0) Then
            stlPgto.Add(strPath + '\' + arqArquivo.Name)
          Else If (Pos('Data;ID Transa', strLinha) > 0) Then
             stlPgto.Add(strPath + '\' + arqArquivo.Name);

          Flush(txtArquivo);
          Close(txtArquivo);
        end;
      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);

    If (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('ATENÇÃO','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;

    pGravarRegistros;

    objFunctions.fIMensagem('AVISO','Dados importados com sucesso!',['&OK']);

    frmForm.Close;
  Except
    On E: Exception Do
    Begin

      If (UpperCase(E.Message) = 'I/O ERROR 32') Then
       objFunctions.fIMensagem('ATENÇÃO', 'O arquivo '+arqArquivo.Name+' está em uso por outro processo!',['&OK'])
      Else
       objFunctions.fIMensagem('ATENÇÃO', E.Message, ['&OK']);

      objPgto := TYapayPgto.Create;

      lstEstabel := TStringList.Create;

      stlPgto.Clear;
    End;
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
    Try
      For LContador := 0 To stlPgto.Count -1 Do
      Begin
        Application.ProcessMessages;
        LListaStrings.LoadFromFile(stlPgto[LContador]);
        untYapayPgto.NomeArquivo := ExtractFileName(stlPgto[LContador]);
        FileGetDateTimeInfo(stlPgto[LContador], LDataArquivo);
        untYapayPgto.DataArquivo := FormatDateTime('yyyy/mm/dd', LDataArquivo.CreationTime);

        For LContadorLinha := 0 To LListaStrings.Count -1 Do
          objPgto.pAdicionaLinha(LListaStrings[LContadorLinha]);

        LListaStrings.Clear;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  finally
    FreeAndNil(LListaStrings);
  end;
End;

procedure TYapay.pGravarRegistros;
  Var
    LContador: Integer;
begin
  objPgto.pGravarRegistros(pgbProg);

  For LContador := 0 to stlPgto.Count - 1 do
  Begin
    If (FileExists(stlPgto[LContador]+'.imp')) Then
      DeleteFile(stlPgto[LContador]+'.imp');

    pRenomeiaAquivo(stlPgto[LContador], stlPgto[LContador]+'.imp');
  end;
end;

end.
