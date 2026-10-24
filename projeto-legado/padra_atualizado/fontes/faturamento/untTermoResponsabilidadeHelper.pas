unit untTermoResponsabilidadeHelper;

interface

uses  SysUtils, Uni, untWord, Classes, Forms, Windows,
      StrUtils;

type
  TTermoResposabilidade = Class
  private
    class procedure pPreencheCabecalho(Word: TWord; strCodEmp: String);
  public
    class function fExisteArqModTermoResponsabilidade: Boolean;
    class function fGeraTermoResponsabilidade(strNumOs, strCodEmp: string; dtaDtaOs: TDateTime;
      strNomImp: String; intQtdImp: Integer; Owner: TComponent): Boolean;
  end;

CONST
  strNomDir = 'TERMO DE RESPONSABILIDADE';
  strNomArqMod = '\TERMO_RESPONSABILIDADE.doc';

implementation

uses untFuncoesGenerica, untFuncoesSimples, Data.DB, untCfgRel;

{ TTermoResposabilidade }

class function TTermoResposabilidade.fExisteArqModTermoResponsabilidade: Boolean;
begin
  Result := FileExists(pChar(ExtractFilePath(Application.ExeName) + strNomArqMod));
end;

class function TTermoResposabilidade.fGeraTermoResponsabilidade(
  strNumOs, strCodEmp: string; dtaDtaOs: TDateTime;
  strNomImp: String; intQtdImp: Integer; Owner: TComponent): Boolean;
  Var
    Word: TWord;
    strArqOri,
    strArqDes: String;
    intContador: Integer;
begin
  Result := False;
  
  Try
    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + strNomDir) Then
      CreateDir(ExtractFilePath(Application.ExeName) + strNomDir);

    strArqOri := ExtractFilePath(Application.ExeName) + strNomArqMod;

    strArqDes := ExtractFilePath(Application.ExeName) + strNomDir + '\TERMO_RESPONSABILIDADE_' +
                 FormatDateTime('yyyymmdd', dtaDtaOs) + '-' + strNumOs + '.DOC';

    If FileExists(pChar(strArqDes)) Then
      DeleteFile(pChar(strArqDes));

    CopyFile(pChar(strArqOri), pChar(strArqDes), False);

    Word := TWord.fCriarWord(Owner);

    If Word = Nil Then
      Exit;

    If Not Word.AbrirArquivo(strArqDes) Then
    Begin
      fMensagem('','Não foi possível abrir o arquivo!',['&OK']);
      Exit;
    End;

    Word.pGoToPageHeader;
    Word.pGoToMainDocument;

    pPreencheCabecalho(Word, strCodEmp);
    
    Word.pReplace('{{NRO_OS}}' , AnsiUpperCase(strNumOs));
    Word.pReplace('{{DTA_OS}}' , FormatDateTime('dd/mm/yyyy', dtaDtaOs));

    Word.pSalvar;

    If Not fEmptyStr(strNomImp) Then
      For intContador := 1 To intQtdImp Do
        TCfgRel.pPrintReport('TTermoResposabilidade', ExtractFileName(strArqDes), strNomImp, Word);

    Word.pSalvar;
    Word.pFechar;
    FreeAndNil(Word);

    Application.ProcessMessages;

    If fEmptyStr(strNomImp) Then
      pExecArquivo(strArqDes, 0);

    Result := True;
  Except
    fMensagem('', 'Erro ao gerar o arquivo Word!', ['&Ok']);
  End;
end;

class procedure TTermoResposabilidade.pPreencheCabecalho(Word: TWord; strCodEmp: String);
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM, "")) AS EMP_ENDERE, ';
    strSQL := strSQL + '   EMP_BAIRRO, ';
    strSQL := strSQL + '   CONCAT(CID_NOMCID, "/", CID_ESTADO) AS EMP_CIDEMP, ';
    strSQL := strSQL + '   EMP_C_E_P_, ';
    strSQL := strSQL + '   EMP_FONE01 ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADEMP ';
    strSQL := strSQL + '   JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   EMP_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        Word.pReplace('{{NOMEMP}}', AnsiUpperCase(Copy(fRetNomeEmpresa(strCodEmp) + fReplicatorStr(' ', 57), 1, 57)));
        Word.pReplace('{{ENDEMP}}', AnsiUpperCase(FieldByName('EMP_ENDERE').AsString));
        Word.pReplace('{{BAIEMP}}', AnsiUpperCase(FieldByName('EMP_BAIRRO').AsString));
        Word.pReplace('{{CIDEMP}}', AnsiUpperCase(FieldByName('EMP_CIDEMP').AsString));
        Word.pReplace('{{CEPEMP}}', AnsiUpperCase(fFormataCEP(FieldByName('EMP_C_E_P_').AsString)));
        Word.pReplace('{{FONEMP}}', AnsiUpperCase(fFormataFone(Fieldbyname('EMP_FONE01').AsString)));
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

end.
