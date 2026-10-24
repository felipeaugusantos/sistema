{**************************************}
{* Importação de arquivos da BANRISUL *}
{***********************************AJ*}
unit untBanrisul;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untBanrisulPgto, ComCtrls, untTImportacaoCartao;

Type
  TBanrisul = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto : TBanrisulPgto;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TBanrisul }

constructor TBanrisul.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TBanrisulPgto.Create;

  strNomCon := 'BANRISUL';
  strMenCon := '';
end;

destructor TBanrisul.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  inherited;
end;

procedure TBanrisul.pProcessaArquivos(strPath: String);
Var arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;
begin
  Try
    If (FindFirst(strPath + '\*.*', faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);

        if (arqArquivo.Name <> '.') And
           (arqArquivo.Name <> '..') and
           (arqArquivo.Attr <> faDirectory) And
           (ExtractFileExt(arqArquivo.Name) <> '.imp') then
        begin
          Reset(txtArquivo);
          Readln(txtArquivo, strLinha);

          If (Pos('BJRVCA1', strLinha) > 0) or
             (Pos('BJRVCM8', strLinha) > 0) or
             (Pos('BJRVCC1', strLinha) > 0) or
             (Pos('BJRVCMB', strLinha) > 0) or
             (Pos('BJRVCB1', strLinha) > 0) or
             (Pos('BKNFIN1', strLinha) > 0) or
             (Pos('BJRVCA8', strLinha) > 0) Then
            stlPgto.Add(strPath + '\' + arqArquivo.Name);

          Flush(txtArquivo);
          Close(txtArquivo);
        end;

      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);

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

procedure TBanrisul.pAdicionaLinhas;
Var
  intCont : Integer;
  intLin  : Integer;
  stlAux  : TStringList;
Begin
  stlAux := TStringList.Create;
  try
    Try
      For intCont := 0 To stlPgto.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(stlPgto[intCont]);
        untBanrisulPgto.strNomArq := ExtractFileName(stlPgto[intCont]);

        For intLin := 0 To stlAux.Count -1 Do
          objPgto.pAdicionaLinha(stlAux[intLin]);

        stlAux.Clear;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  finally
    FreeAndNil(stlAux);
  end;
End;

procedure TBanrisul.pGravarRegistros;
Var
  intCont: Integer;
begin
  objPgto.pGravarRegistros(pgbProg);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    If (FileExists(stlPgto[intCont]+'.imp')) Then
      DeleteFile(stlPgto[intCont]+'.imp');
    pRenomeiaAquivo(stlPgto[intCont], stlPgto[intCont]+'.imp');
  end;
end;

end.
