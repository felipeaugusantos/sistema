{*************************************}
{* Importação de arquivos do WALMART *}
{**********************************AJ*}
unit untWalmart;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untWalmartPgto, ComCtrls, untTImportacaoCartao;

Type
  TWalmart = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TWalmartPgto;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TWalmart }

constructor TWalmart.Create(Owner: TComponent);
begin
  inherited;
  objPgto   := TWalmartPgto.Create;
  strNomCon := 'WALMART';
  strMenCon := '';
end;

destructor TWalmart.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  inherited;
end;

procedure TWalmart.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    strLinha  : String;
    txtArquivo: TextFile;

  procedure pCarregaArquivos(strExt: String);
  Begin

    If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin
      Repeat
        Application.ProcessMessages;
        AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
        Reset(txtArquivo);
        Readln(txtArquivo, strLinha);
        strLinha := fConverteParaAcento(strLinha);

        If (Pos('Pedido,PedidoEntrega,Movimento,Status,Data do Status', strLinha) > 0) And
           (Pos(',Data da Compra,Data de Pagamento,Produto,Valor Item,Frete,Valor Bruto', strLinha) > 0) Then
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

    objFunctions.fIMensagem('','Dados importados com sucesso!',['&OK']);

    frmForm.Close;
  Except
    Raise;
  End;
end;

procedure TWalmart.pAdicionaLinhas;

  procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    Var
      intCont  : Integer;
      intLin   : Integer;
      stlAux   : TStringList;
      dtaDtaArq: TDateTimeInfoRec;
  begin
    Try
      stlAux := TStringList.Create;

      For intCont := 0 To stlArqs.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(stlArqs[intCont]);
        untWalmartPgto.strNomArq := ExtractFileName(stlArqs[intCont]);
        FileGetDateTimeInfo(stlArqs[intCont], dtaDtaArq);
        untWalmartPgto.strDtaArq := FormatDateTime('dd/mm/yyyy', dtaDtaArq.CreationTime);

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
  SetLength(FRegWalmartPgto , 0);

  pAdiciona(objPgto, stlPgto);
End;

procedure TWalmart.pGravarRegistros;
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
