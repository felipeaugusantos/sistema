{******************************************}
{* Importação de arquivos da FISERV - BIN *}
{***************************************TA*}
unit untFiservBin;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untFiservBinPgto, ComCtrls, untTImportacaoCartao,Json;

Type
  TFiservBin = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TFiservBinPgto;

    function ValidaMovimentacaoFinanceira(ALinha:String):Boolean;
    function ValidarJsonMovimentacaoFinanceira(const ACaminhoArquivo: string): Boolean;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
    function fVerificaName(strExt : String = ''; strName: String = '') : Boolean;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TFiservBin }

constructor TFiservBin.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TFiservBinPgto.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'FISERVBIN';
  strMenCon := 'Movimento Financeiro - 7.3/7.4';
end;

destructor TFiservBin.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

function TFiservBin.fVerificaName(strExt, strName: String): Boolean;
begin
  Result := True;
  If strExt <> '' Then
    Result := False
  Else If strName = '' Then
    Result := False;
end;

function TFiservBin.ValidarJsonMovimentacaoFinanceira(const ACaminhoArquivo: string): Boolean;
var
  LConteudo: TStringList;
  LJsonObj: TJSONObject;
  LFileHeader: TJSONObject;
  LAcquiringName, LFileTypeDesc: string;
begin
  Result := False;
  LConteudo := TStringList.Create;
  try
    try
      LConteudo.LoadFromFile(ACaminhoArquivo);

      if LConteudo.Text.Trim = '' then
        Exit;

      LJsonObj := TJSONObject.ParseJSONValue(LConteudo.Text) as TJSONObject;
      if not Assigned(LJsonObj) then
        Exit;

      try
        if not LJsonObj.TryGetValue('fileHeader', LFileHeader) then
          Exit;

        if Assigned(LFileHeader.Get('acquiringName')) then
          LAcquiringName := LFileHeader.GetValue<string>('acquiringName')
        else
          Exit;

        if LAcquiringName <> 'Bin' then
          Exit;

        if Assigned(LFileHeader.Get('fileTypeDescription')) then
          LFileTypeDesc := LFileHeader.GetValue<string>('fileTypeDescription')
        else
          Exit;

        Result := LFileTypeDesc = 'Movimento Financeiro';

      finally
        LJsonObj.Free;
      end;

    except
      on E: Exception do
        Result := False;
    end;
  finally
    LConteudo.Free;
  end;
end;

procedure TFiservBin.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;
    LMensagemSucesso : String;

  procedure pCarregaArquivos(strExt: String);
  Begin

    If (FindFirst(strPath + IIF(strExt <> '', '\*.' + strExt, '\*'), faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        If fVerificaName(strExt,ExtractFileExt(arqArquivo.Name)) Then
          continue;

        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        If ValidaMovimentacaoFinanceira(strLinha) Then
          stlPgto.Add(strPath + '\' + arqArquivo.Name)
        Else If ValidarJsonMovimentacaoFinanceira(strPath + '\' + arqArquivo.Name) Then
          stlPgto.Add(strPath + '\' + arqArquivo.Name);

        Flush(txtArquivo);
        Close(txtArquivo);

      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);
  End;
begin
  Try
    pCarregaArquivos('csv');
    pCarregaArquivos('txt');
    pCarregaArquivos('ret');
    pCarregaArquivos('');
    pCarregaArquivos('json');

	If (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros;

    LMensagemSucesso := 'Dados importados com sucesso';

    If Not untFiservBinPgto.FImportouPagamentos Then
       LMensagemSucesso := LMensagemSucesso + ', porém não possui registros de pagamentos no período.'
    Else
       LMensagemSucesso := LMensagemSucesso + '!';

    objFunctions.fIMensagem('',LMensagemSucesso,['&OK']);

    frmForm.Close;
  Except
    On E: Exception Do
      objFunctions.fIMensagem('ERRO','Ocorreu um erro ao importar os dados.' + #13 +
                                     'Erro gerado: ' + E.Message,['&OK']);
  End;
end;

function TFiservBin.ValidaMovimentacaoFinanceira(ALinha: String): Boolean;
begin
  Result := False;

  If Pos(',Movimento Financeiro', ALinha) > 0 Then
    Result := True;
end;

procedure TFiservBin.pAdicionaLinhas;

  procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    Var
      intCont: Integer;
      intLin : Integer;
      stlAux : TStringList;
  begin
    Try
      stlAux := TStringList.Create;

      If itrCartoes Is TFiservBinPgto Then
      Begin

        For intCont := 0 To stlArqs.Count -1 Do
        Begin
          Application.ProcessMessages;
          stlAux.LoadFromFile(stlArqs[intCont]);
          untFiservBinPgto.strNomArq := ExtractFileName(stlArqs[intCont]);

          If ValidarJsonMovimentacaoFinanceira(stlArqs[intCont]) Then
            itrCartoes.pAdicionaLinha(stlAux.Text)
          Else
          Begin
            For intLin := 0 To stlAux.Count -1 Do
              itrCartoes.pAdicionaLinha(stlAux[intLin]);
          End;

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
  pAdiciona(objPgto, stlPgto);
End;

procedure TFiservBin.pGravarRegistros;
Var
  intCont: Integer;
  SNomeArquivoSemExtensao : String;
begin

  objPgto.pGravarRegistros(pgbProg);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    SNomeArquivoSemExtensao := AnsiReplaceStr(stlPgto[intCont],
                                              ExtractFileExt(stlPgto[intCont]),
                                              '');

    If FileExists(SNomeArquivoSemExtensao+'.imp') Then
       DeleteFile(SNomeArquivoSemExtensao+'.imp');
    pRenomeiaAquivo(stlPgto[intCont], SNomeArquivoSemExtensao+'.imp');
  end;

end;

end.
