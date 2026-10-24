{*********************************}
{* Importação de arquivos do B2W *}
{******************************AJ*}
unit untB2W;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, ComCtrls,
  untB2WPgto, untTImportacaoCartao, untIIntegracaoCartoes;

Type
  TB2W = Class(TImportacaoCartao)

    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;

  private
    objPgto: TB2WPgto;
  public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  end;

implementation
uses untFuncoes, untIDataSet;

{ TB2W }

constructor TB2W.Create(Owner: TComponent);
begin
  inherited;
  objPgto   := TB2WPgto.Create;
  strNomCon := 'B2W';
  strMenCon := '';
end;

destructor TB2W.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  inherited;
end;

procedure TB2W.pAdicionaLinhas;
  procedure pAdiciona(itrCartoes: ICartoes; stlArqs: TStringList);
    Var
      intCont  : Integer;
      intLin   : Integer;
      stlAux   : TStringList;
      dtaDtaArq: TDateTimeInfoRec;
      LModeloImportacao : Integer;
  begin
    Try
      stlAux := TStringList.Create;

      For intCont := 0 To stlArqs.Count -1 Do
      Begin
        Application.ProcessMessages;
        stlAux.LoadFromFile(stlArqs[intCont]);
        untB2WPgto.strNomArq := ExtractFileName(stlArqs[intCont]);
        FileGetDateTimeInfo(stlArqs[intCont], dtaDtaArq);
        untB2WPgto.strDtaArq := FormatDateTime('dd/mm/yyyy', dtaDtaArq.CreationTime);

        LModeloImportacao := TB2WPgto(itrCartoes).fRetornaTipoModeloImportacao(stlAux[0]);
        TB2WPgto(itrCartoes).pDefineModeloImportacao(LModeloImportacao);
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
  inherited;
  SetLength(FRegB2WPgto , 0);

  pAdiciona(objPgto, stlPgto);
end;

procedure TB2W.pGravarRegistros;
  Var
    intCont: Integer;
begin
  inherited;
  objPgto.pGravarRegistros(pgbProg);

  For intCont := 0 to stlPgto.Count - 1 do
  Begin
    If (FileExists(AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'))) Then
      DeleteFile(AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'));
    pRenomeiaAquivo(stlPgto[intCont], AnsiReplaceStr(stlPgto[intCont], RightStr(stlPgto[intCont], 3), 'imp'));
  end;
end;

procedure TB2W.pProcessaArquivos(strPath: String);
  Var
    arqArquivo: TSearchRec;
    strLinha,
    LMensagem : String;
    txtArquivo: TextFile;

  procedure pCarregaArquivos(strExt: String);
  Begin

    If (FindFirst(strPath + '\*.' + strExt, faAnyFile, arqArquivo) = 0) Then
    Begin
      Repeat
        Try
          Application.ProcessMessages;
          AssignFile(txtArquivo, strPath + '\' + arqArquivo.Name);
          Reset(txtArquivo);
          Readln(txtArquivo, strLinha);
          strLinha := fConverteParaAcento(strLinha);

          If (Pos('"Marca";"Nome Fantasia";"Data pedido";"Data Pagamento";"Data Estorno";', strLinha) > 0) Then
            stlPgto.Add(strPath + '\' + arqArquivo.Name);

          If (Pos('Marketplace;Seller;Data de Criação do Lançamento;Pedido;Pedido Site;Status do Pedido;', strLinha) > 0) Then
            stlPgto.Add(strPath + '\' + arqArquivo.Name);

          Flush(txtArquivo);
          Close(txtArquivo);
        Except
          On E: Exception Do
          Begin
            If Pos('I/O', E.Message) > 0 Then
              objFunctions.fIMensagem('ATENÇÃO', 'O arquivo ' + arqArquivo.Name + ' está aberto em outro aplicativo.' + #13 +
                                                 'Operação cancelada!', ['&OK'])
            Else
              objFunctions.fIMensagem('ATENÇÃO', 'Ocorreu um erro: ' + E.Message, ['&OK']);

            frmForm.Close;
            Exit;
          End;
        End;
      Until (FindNext(arqArquivo) <> 0);

    End;
    FindClose(arqArquivo);
  End;
begin
  inherited;
  Try
    pCarregaArquivos('csv');
    If (stlPgto.Count = 0) Then
    Begin
      objFunctions.fIMensagem('ATENÇÃO','Nenhum arquivo na pasta para importar!' + #13 +
                                        'Verifique se o(s) arquivo(s) foi(ram) aberto(s) e alterado(s) em outro programa.' ,['&OK']);
      Exit;
    End;

    pAdicionaLinhas;
    pGravarRegistros;

    LMensagem := 'Dados importados com sucesso!';

    If Not objPgto.PagamentosImportados Then
      LMensagem := 'Dados importados com sucesso, porém não possui registros de pagamentos no período!';

    objFunctions.fIMensagem('AVISO',LMensagem,['&OK']);

    frmForm.Close;
  Except
    On E: Exception Do
    Begin
      objFunctions.fIMensagem('ERRO', 'Ocorreu um erro ao importar o arquivo.' + #13 +
                                      'Erro gerado: ' + E.Message, ['&OK']);
      frmFOrm.Close;
    End;
  End;
end;

end.
