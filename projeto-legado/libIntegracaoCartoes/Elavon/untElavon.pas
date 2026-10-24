{************************************}
{* Importação de arquivos da ELAVON *}
{*********************************AJ*}
unit untElavon;

interface

uses Classes, Forms, BitBtnLockedIncrem, StdCtrls, ExtCtrls, Dialogs,
  Controls, Windows, Graphics, Buttons, StrUtils, SysUtils, untIIntegracaoCartoes,
  untElavonCredito, untElavonPagto, ComCtrls, untTImportacaoCartao;

Type
  TElavon = Class(TImportacaoCartao)
    procedure pGravarRegistros; override;
    procedure pAdicionaLinhas;  override;
    procedure pProcessaArquivos(strPath: String); override;
  Private
    objPgto   : TElavonPagto;
    objCredito: TElavonCredito;

    strEstab  : string;

    function fVerificaEstab: Boolean;
  Public
    Constructor Create(Owner: TComponent); Override;
    Destructor Destroy; Override;
  End;

implementation

uses untFuncoes, untIDataSet;

{ TElavon }

constructor TElavon.Create(Owner: TComponent);
begin
  inherited;
  objPgto    := TElavonPagto.Create;
  objCredito := TElavonCredito.Create;

  lstEstabel := TStringList.Create;

  strNomCon := 'ELAVON';
  strMenCon := '';
end;

destructor TElavon.Destroy;
begin
  If Assigned(objPgto) Then
    FreeAndNil(objPgto);
  If Assigned(objCredito) Then
    FreeAndNil(objCredito);
  If Assigned(lstEstabel) Then
    FreeAndNil(lstEstabel);
  inherited;
end;

function TElavon.fVerificaEstab: Boolean;
Var
  intCont  : Integer;
  strSQL   : string;
  qryDados : IDataSet;
begin
  Result := True;
  strSQL := 'SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG="CFG_ELAEST"';
  strSQL := strSQL + ' AND COALESCE(SIS_VALCFG, "") <> ""               ';
  strSQL := strSQL + ' GROUP BY SIS_VALCFG                              ';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;
  qryDados.Open;

  strEstab := '';
  for intCont := 0 to lstEstabel.Count - 1 do
  begin
    if not qryDados.Locate('SIS_VALCFG', lstEstabel[intCont], []) then
      If Pos(lstEstabel[intCont], strEstab) = 0 Then
        strEstab := strEstab + lstEstabel[intCont] + ', ';
  end;
  If strEstab <> '' Then
  begin
    strEstab := Copy(strEstab, 1, Length(strEstab) - 2);
    Result := False;
  end;
end;

procedure TElavon.pProcessaArquivos(strPath: String);
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

        If Pos('|ELAVON|EXTRATO ELETRONICO DE RECEBIMENTOS|', strLinha) > 0 Then
          stlPgto.Add(strPath + '\' + arqArquivo.Name)
        Else If (Pos('|ELAVON|EXTRATO ELETRONICO DE VENDAS|', strLinha) > 0) Then
          stlCredito.Add(strPath  + '\' + arqArquivo.Name);

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
    If (stlPgto.Count = 0) And (stlCredito.Count = 0) Then
    Begin
      objFunctions.fIMensagem('','Nenhum arquivo na pasta para importar!',['&OK']);
      Exit;
    End;

    pAdicionaLinhas;

    if Not fVerificaEstab then
    Begin
      objFunctions.fIMensagem('','Importação cancelada. O(s) estabelecimento(s) ' +
                              strEstab + ' não está(ão) configurado(s) em nenhuma empresa!',['&OK']);
      frmForm.Close;
      Exit;
    end;

    pGravarRegistros;

    objFunctions.fIMensagem('','Dados importados com sucesso!',['&OK']);

    frmForm.Close;
  Except
    Raise;
  End;
end;

procedure TElavon.pAdicionaLinhas;

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
        untElavonPagto.strNomArq := ExtractFileName(stlArqs[intCont]);

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
  SetLength(FRegElaCred , 0);

  pAdiciona(objPgto, stlPgto);
  pAdiciona(objCredito, stlCredito);
End;

procedure TElavon.pGravarRegistros;
Var
  intCont: Integer;
begin

  objPgto.pGravarRegistros(pgbProg);
  objCredito.pGravarRegistros(pgbProg);

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
