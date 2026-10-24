{************************************}
{* Importação de arquivos da CONCIL *}
{*********************************AJ*}
unit untConcil;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untConcilPgto, ComCtrls, untTImportacaoCartao;

Type
  TConcil = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TConcilPgto;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TConcil }

constructor TConcil.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TConcilPgto.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'CONCIL';
  strMenCon := '';
end;

destructor TConcil.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

procedure TConcil.pProcessaArquivos(strPath: String);
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

        If Pos('C01;COD_ERP;LOJA_FILIAL;ESTABELECIMENTO', strLinha) > 0 Then
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
    If (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;

    pGravarRegistros;

    If objPgto.GravouRegistros Then
      objFunctions.fIMensagem('AVISO','Dados importados com sucesso!',['&OK'])
    Else
      objFunctions.fIMensagem('ATENÇÃO','Não foi importado nenhum registro pois, os arquivos que estão na pasta, ' +
                                        'possuem apenas registros com a coluna STATUS igual a "0" (PENDENTE).',['&OK']);

    frmForm.Close;
  Except
    Raise;
  End;
end;

procedure TConcil.pAdicionaLinhas;

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
        untConcilPgto.strNomArq := ExtractFileName(stlArqs[intCont]);

        For intLin := 0 To stlAux.Count -1 Do
        Begin
          If Trim(stlAux[intLin]) <> '' Then
            itrCartoes.pAdicionaLinha(stlAux[intLin]);
        End;

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
  SetLength(FRegConcPgto, 0);

  pAdiciona(objPgto, stlPgto);
End;

procedure TConcil.pGravarRegistros;
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
