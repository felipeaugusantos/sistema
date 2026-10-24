unit untAutocolor;

interface

uses SysUtils, Classes, Uni,  Forms;

  function fAutocolorGeraArquivo: Boolean;

implementation

uses untFuncoes, untInkLayoutReader,
     untIConfTinta,
     untFuncTinta,untFuncoesSimples;

function fAutocolorGeraArquivo: Boolean;
  Var
    ilrAutocolor: TAutomotiveInkLayoutReader;
    strArqTxt: String;
    intLinha: Integer;

    qryCadAut: TUniQuery;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('AUT');
  strArqTxt := conf.fGet('PATAUT') + '\FORMULA.TXT'; //fArqIniTinta(0, 'AUTOCOLOR', 'PATAUT', '') + '\FORMULA.TXT';
  If (Not FileExists(strArqTxt)) Then
  Begin
    Result := False;
    fMensagem('', 'O arquivo ' + strArqTxt + ' não existe!', ['&Ok']);
    Exit;
  End;
  Result := True;

  pZapTable('AUT_CADAUT');

  qryCadAut := fCriaQuery(Nil);
  qryCadAut.SQL.Add('SELECT * FROM AUT_CADAUT');
  qryCadAut.Open;

  ilrAutocolor := TAutomotiveInkLayoutReader.Create;
  ilrAutocolor.strNomArq := strArqTxt;

  intLinha := 1;
  While (Not ilrAutocolor.Eof) Do
  Begin

    Try
      qryCadAut.Append;
      qryCadAut.FieldByName('AUT_CODIGO').AsString := ilrAutocolor['CHAVE1'];
      qryCadAut.FieldByName('AUT_DESCRI').AsString := ilrAutocolor['DESCRI'];
      qryCadAut.FieldByName('AUT_REFERE').AsString := ilrAutocolor['REFERE'];
      qryCadAut.FieldByName('AUT_MONTAD').AsString := ilrAutocolor['MONTAD'];
      qryCadAut.FieldByName('AUT_VARIAN').AsString := ilrAutocolor['INFCHA'];
      qryCadAut.FieldByName('AUT_ANOINI').AsString := ilrAutocolor['ANOINI'];
      qryCadAut.FieldByName('AUT_ANOFIN').AsString := ilrAutocolor['ANOFIN'];
      qryCadAut.FieldByName('AUT_PRECUS').AsFloat  := ilrAutocolor['CONCUS'];
      qryCadAut.FieldByName('AUT_PREVEN').AsFloat  := ilrAutocolor['CONVEN'];
      qryCadAut.FieldByName('AUT_CODSEQ').AsString := fStrZero(intLinha, 6);
      qryCadAut.FieldByName('AUT_CODEMP').AsString := VS_strCodEmp;
      qryCadAut.FieldByName('AUTOINCREM').AsString := fFormataAutInc(intLinha, VS_strCodEmp);
      qryCadAut.Post;
    Except
      On E: Exception Do
      Begin
        qryCadAut.Cancel;
        pMensagensErro(E.Message, '[fAutocolorGeraArquivo]');
        Result := False;
        Break;
      End;
    End;

    ilrAutocolor.Next;
    Inc(intLinha);
    Application.ProcessMessages;
  End;

  fMensagem('', 'Geração Concluída!', ['&Ok']);  
end;

end.
