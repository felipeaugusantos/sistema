{**********************************}
{* Importação de arquivos da AMEX *}
{*******************************AJ*}
unit untAmex;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untAmexPgto, ComCtrls, untTImportacaoCartao;

Type
  TAmex = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TAmexPgto;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TAmex }

constructor TAmex.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TAmexPgto.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'AMEX';
  strMenCon := '';
end;

destructor TAmex.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

procedure TAmex.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;

  procedure pCarregaArquivos(strExt: String);
  Begin

    If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        If Pos('EXTRATO ELETR AMEX', strLinha) > 0 Then
          stlPgto.Add(strPath + '\' + arqArquivo.Name);

        Flush(txtArquivo);
        Close(txtArquivo);

      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);
  End;
begin
  Try
    pCarregaArquivos('txt');
    pCarregaArquivos('ret');
    If (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros;

    objFunctions.fIMensagem('','Dados importados com sucesso!',['&OK']);

    frmForm.Close;
  Except
    Raise;
  End;
end;

procedure TAmex.pAdicionaLinhas;

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
        untAmexPgto.strNomArq := ExtractFileName(stlArqs[intCont]);

        For intLin := 0 To stlAux.Count -1 Do
          itrCartoes.pAdicionaLinha(stlAux[intLin]);

        stlAux.Clear;
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
  SetLength(FRegAmexPgto , 0);

  pAdiciona(objPgto, stlPgto);
End;

procedure TAmex.pGravarRegistros;
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
