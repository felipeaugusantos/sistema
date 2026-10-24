{***************************************}
{* Importação de arquivos da BOA VISTA *}
{************************************AZ*}
unit untBoaVista;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untBoaVistaPgto, ComCtrls, untTImportacaoCartao;

Type
  TBoaVista = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
    procedure pCarregaArquivos(strExt, strPath: String);
    procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
  Private
    objPgto   : TBoaVistaPgto;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TBoaVista }

constructor TBoaVista.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TBoaVistaPgto.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'BOA VISTA';
  strMenCon := '';
end;

destructor TBoaVista.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

procedure TBoaVista.pProcessaArquivos(strPath: String);
begin
  Try
    pCarregaArquivos('csv', strPath);
    pCarregaArquivos('txt', strPath);
    pCarregaArquivos('ret', strPath);
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

procedure TBoaVista.pAdicionaLinhas;
Begin
  SetLength(FRegBovPgto, 0);

  pAdiciona(objPgto, stlPgto);
End;

procedure TBoaVista.pGravarRegistros;
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

procedure TBoaVista.pCarregaArquivos(strExt, strPath: String);
var
  arqArquivo: TSearchRec;
  txtArquivo: TextFile;
  strLinha  : String;
Begin
  If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
  Begin

    Repeat
      Application.ProcessMessages;
      AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
      Reset(txtArquivo);
      Readln(txtArquivo, strLinha);

      If Pos('Data da venda;Data de credito;NSU;Autorizacao;Plano;', strLinha) > 0 Then
        stlPgto.Add(strPath + '\' + arqArquivo.Name);

      Flush(txtArquivo);
      Close(txtArquivo);

    Until (FindNext(arqArquivo) <> 0);

  End;
  FindClose(arqArquivo);
End;

procedure TBoaVista.pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
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
      untBoaVistaPgto.strNomArq := ExtractFileName(stlArqs[intCont]);

      If Pos('Data da venda;Data de credito;NSU;Autorizacao;Plano;Parcela', stlAux[0]) <= 0 Then
      Begin
        stlAux.Clear;
        Continue;
      End;

      For intLin := 1 To stlAux.Count -1 Do
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

end.
