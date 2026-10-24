{***************************************}
{* Importação de arquivos da BanesCard *}
{************************************MT*}
unit untBanesCard;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untBanesCardPgto, ComCtrls, untTImportacaoCartao;

Type
  TBanesCard = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TBanesCardPgto;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TBanesCard }

constructor TBanesCard.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TBanesCardPgto.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'BanesCard';
  strMenCon := 'Versão do layout para importação: 1.6d';
end;

destructor TBanesCard.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

procedure TBanesCard.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    txtArquivo: TextFile;
    strLinha  : String;

  function fCarregaArquivos(strExt: String): Boolean;
  Begin
    Result := True;
    If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin

      Repeat
        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);

        If (Pos('BANESTES', strLinha) > 0) And (Pos('001.6d', strLinha) > 0) Then
          stlPgto.Add(strPath + '\' + arqArquivo.Name)
        Else If (Pos('BANESTES', strLinha) > 0) And (Pos('001.6d', strLinha) <= 0) Then
        Begin
          objFunctions.fIMensagem('ATENÇÃO','Não foi possível importar o arquivo ' + arqArquivo.Name +
                                            ' pois não está na versão 001.6d' + #13 +
                                            'Operação cancelada!',['&OK']);
          Flush(txtArquivo);
          Close(txtArquivo);
          frmForm.Close;
          Result := False;
          Exit;
        End;


        Flush(txtArquivo);
        Close(txtArquivo);

      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);
  End;
begin
  Try
    If Not fCarregaArquivos('txt') Then
      Exit;
    If Not fCarregaArquivos('ret') Then
      Exit;
    If Not fCarregaArquivos('PGCECSETXT') Then
      Exit;

    If (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('AVISO','Nenhum arquivo na pasta para importar!',['&OK']);
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

      objPgto := TBanesCardPgto.Create;

      lstEstabel := TStringList.Create;

      stlPgto.Clear;
    End;
  End;
end;

procedure TBanesCard.pAdicionaLinhas;

  procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    Var
      intCont: Integer;
      intLin : Integer;
      stlAux : TStringList;

      LAchouFooter: Boolean;
  begin
    Try
      stlAux := TStringList.Create;

      For intCont := 0 To stlArqs.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(stlArqs[intCont]);
        untBanesCardPgto.strNomArq := ExtractFileName(stlArqs[intCont]);

        LAchouFooter := False;

        For intLin := 0 To stlAux.Count -1 Do
        Begin
          If LeftStr(stlAux[intLin], 2) = 'A9' Then
            LAchouFooter := True;

          itrCartoes.pAdicionaLinha(stlAux[intLin]);
        End;

        stlAux.Clear;

        If Not LAchouFooter Then
          Raise Exception.Create('O arquivo ' + untBanesCardPgto.strNomArq + ' está incompleto. Operação cancelada.!' + #13 +
                                 'Baixe o arquivo na BanesCard e tente realizar a importação novamente.');
      End;

    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;

    FreeAndNil(stlAux);

  end;

Begin
  Try
    SetLength(FRegBanesCardPgto , 0);

    pAdiciona(objPgto, stlPgto);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

procedure TBanesCard.pGravarRegistros;
Var
  intCont: Integer;
begin

  objPgto.pGravarRegistros(pgbProg);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(stlPgto[intCont], ExtractFileExt(stlPgto[intCont]), '.imp'))) Then
      DeleteFile(AnsiReplaceStr(stlPgto[intCont], ExtractFileExt(stlPgto[intCont]), '.imp'));
    pRenomeiaAquivo(stlPgto[intCont], AnsiReplaceStr(stlPgto[intCont], ExtractFileExt(stlPgto[intCont]), '.imp'));
  end;
end;

end.
