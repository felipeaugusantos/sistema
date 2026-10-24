{*******************************************}
{* Importação de arquivos da REDECARD SITE *}
{****************************************AJ*}
unit untRedeSite;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untRedeSitePgto, ComCtrls, untTImportacaoCartao;

Type
  TRedeSite = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TRedeSitePgto;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TRedeSite }

constructor TRedeSite.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TRedeSitePgto.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'REDECARD SITE';
  strMenCon := 'A configuração está marcada para importar arquivos do Site (CSV).';
end;

destructor TRedeSite.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

procedure TRedeSite.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;
    stlCampos : TStrings;

  procedure pCarregaArquivos(strExt: String);
  Begin

    If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        stlCampos := TStringList.Create;
        stlCampos.Delimiter := ';';
        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        stlCampos.DelimitedText := strLinha;

        If (stlCampos[0] = '01') And (stlCampos[5] = '1.0') Then
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

procedure TRedeSite.pAdicionaLinhas;

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
        untRedeSitePgto.strNomArq := ExtractFileName(stlArqs[intCont]);

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
  {$IF Defined(VER270)}
  {$ELSE}
  SetLength(FRegSipagPgto , 0);
  {$ENDIF}

  pAdiciona(objPgto, stlPgto);
End;

procedure TRedeSite.pGravarRegistros;
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

  For intCont := 0 to stlCredito.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(stlCredito[intCont], RightStr(stlCredito[intCont], 3), 'imp'))) Then
      DeleteFile(AnsiReplaceStr(stlCredito[intCont], RightStr(stlCredito[intCont], 3), 'imp'));
    pRenomeiaAquivo(stlCredito[intCont], AnsiReplaceStr(stlCredito[intCont], RightStr(stlCredito[intCont], 3), 'imp'));
  end;
end;

end.
