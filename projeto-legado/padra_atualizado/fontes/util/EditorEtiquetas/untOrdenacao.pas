unit untOrdenacao;

interface

uses Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, untZClient,
  StrUtils, Math, frxClass, untIOrdenacao;

Type
  TOrdenacao = Class(TZClient, IOrdenacao)
  Private
    FintCodEti: Integer;

    function fSQLOrdenacao: String;

    procedure pIncluiCampos(strCampos: String; intCodEti: Integer);
  Public

    constructor Create(Owner: TComponent; strCampos: String; intCodEtiP: Integer); Reintroduce;

    function fRetTextOrdenacao: String;
    function fInclui(strCodCam, strDesCam, strDireca: String): Boolean;

    procedure pExclui;

    procedure pUp;
    procedure pDown;

    procedure pOrdena(cdsDados: TUniClientDataset);

    function GetFintCodEti: Integer;
    procedure SetFintCodEti(Value: Integer);

    property intCodEti: Integer Read GetFintCodEti Write SetFintCodEti;
  End;

implementation

uses untFuncoesSimples, untFuncoesEditorFast, untConstantes;

function TOrdenacao.fSQLOrdenacao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAM_CODCAM    AS CODCAM,  ';
  strSQL := strSQL + '   CAM_DESCAM    AS DESCAM,  ';
  strSQL := strSQL + '   "DECRESCENTE" AS DIRECA,  ';
  strSQL := strSQL + '   0             AS NUMORD   ';
  strSQL := strSQL + ' FROM   ';
  strSQL := strSQL + '   CAMETI  ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   FALSE ';

  Result := strSQL;
End;

function TOrdenacao.GetFintCodEti: Integer;
begin
  Result := FintCodEti;
end;

constructor TOrdenacao.Create(Owner: TComponent; strCampos: String; intCodEtiP: Integer);
Begin
  Inherited Create(Owner, fSQLOrdenacao);

  fAbreClient(True, 'TOrdenacao.Create');

  IndexFieldNames := 'NUMORD';

  intCodEti := intCodEtiP;

  pIncluiCampos(strCampos, intCodEti);
End;

procedure TOrdenacao.pIncluiCampos(strCampos: String; intCodEti: Integer);
  Var
    sltLista: TStringList;
    intIndex: Integer;
    strDireca: String;
Begin
  sltLista := TStringList.Create;
  sltLista.Text := Trim(strCampos);

  For intIndex := 0 To sltLista.Count - 1 Do
  Begin

    Self.Insert;
    Self.FieldByName('CODCAM').AsString := LeftStr(sltLista[intIndex], 6);
    Self.FieldByName('DESCAM').AsString := fRetNomCampoLayout(Self.FieldByName('CODCAM').AsString,
                                                              intCodEti);
    Self.FieldByName('NUMORD').AsInteger:= intIndex;

    strDireca := sltLista[intIndex];
    System.Delete(strDireca, 1, 7);

    Self.FieldByName('DIRECA').AsString := strDireca;

    Self.Post;
  End;

  FreeAndNil(sltLista);
End;

function TOrdenacao.fRetTextOrdenacao: String;
  Var
    sltLista: TStringList;
Begin
  sltLista := TStringList.Create;

  First;
  While Not Eof Do
  Begin
    sltLista.Add(Self.FieldByName('CODCAM').AsString + '-' + Self.FieldByName('DIRECA').AsString);
    Next;
  End;

  Result := sltLista.Text;
  FreeAndNil(sltLista);
End;

procedure TOrdenacao.pOrdena(cdsDados: TUniClientDataset);
  Var
    sltLista: TStringList;
    sltDescFields: TStringList;
    strListaCamposASerAddComCast: String;

    function fRetCampoOrdem(strNome: String): String;
    begin
      Result := strNome;
      If (cdsDados.FieldByName(strNome).DataType In [ftBlob, ftMemo]) Then
      Begin
        If (cdsDados.FindField(strNome+SULFIXOPARABLOBTOCAST) <> Nil) Then
          Result := strNome+SULFIXOPARABLOBTOCAST
        Else
          pIncrementaListaStr(strNome, strListaCamposASerAddComCast);
      End;
    end;

Begin
  If IsEmpty Then
    Exit;

  cdsDados.IndexDefs.Clear;

  sltLista      := TStringList.Create;
  sltDescFields := TStringList.Create;

  First;
  While Not Eof Do
  Begin
    sltLista.Add(fRetCampoOrdem(Self.FieldByName('CODCAM').AsString));

    If SameText(Self.FieldByName('DIRECA').AsString, 'Decrescente') Then
      sltDescFields.Add(fRetCampoOrdem(Self.FieldByName('CODCAM').AsString));

    Next;
  End;

  cdsDados.IndexDefs.Add('IDX_ORDEM', AnsiReplaceStr(sltLista.CommaText, ',', ';'), [ixCaseInsensitive]);
  cdsDados.IndexDefs[0].DescFields := AnsiReplaceStr(sltDescFields.CommaText, ',', ';');

  Try
    cdsDados.IndexName := 'IDX_ORDEM';
  Except
    On E: Exception Do
    Begin
      If Pos('Invalid',E.Message) > 0 Then
        fMensagem('ATENÇÃO!', 'Entre em contato com a Citel e solicite para que os seguintes campos "Texto" possam adequados para serem usados como ordenação: '+strListaCamposASerAddComCast, ['&O k'])
      Else
        pMensagensErro(E.Message, '[pOrdena]');
    End;
  End;

  FreeAndNil(sltLista);
  FreeAndNil(sltDescFields);
End;

function TOrdenacao.fInclui(strCodCam, strDesCam, strDireca: String): Boolean;
  Var
    intContador: Integer;
Begin
  intContador := RecordCount;

  If Locate('CODCAM', strCodCam, []) Then
  Begin
    Edit;
  End Else
  Begin
    Insert;
    FieldByName('NUMORD').AsInteger := Succ(intContador);
  End;

  FieldByName('CODCAM').AsString := strCodCam;
  FieldByName('DESCAM').AsString := strDesCam;
  FieldByName('DIRECA').AsString := strDireca;

  Post;

  Result := True;
End;

procedure TOrdenacao.pExclui;
Begin
  If IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão do item?') Then
    Delete;
End;

procedure TOrdenacao.pUp;
  Var
    strCodCam: String;
    intNumOrd: Integer;
    intOrdAnt: Integer;
Begin
  strCodCam := FieldByName('CODCAM').AsString;
  intNumOrd := FieldByName('NUMORD').AsInteger;

  Prior;

  If FieldByName('CODCAM').AsString = strCodCam Then
    Exit;

  intOrdAnt := FieldByName('NUMORD').AsInteger;
  Edit;
  FieldByName('NUMORD').AsInteger := intNumOrd;
  Post;

  If Locate('CODCAM', strCodCam, []) Then
  Begin
    Edit;
    FieldByName('NUMORD').AsInteger := intOrdAnt;
    Post;
  End;
End;

procedure TOrdenacao.SetFintCodEti(Value: Integer);
begin
  FintCodEti := Value;
end;

procedure TOrdenacao.pDown;
  Var
    strCodCam: String;
    intNumOrd: Integer;
    intOrdPos: Integer;
Begin
  strCodCam := FieldByName('CODCAM').AsString;
  intNumOrd := FieldByName('NUMORD').AsInteger;

  Next;

  If FieldByName('CODCAM').AsString = strCodCam Then
    Exit;

  intOrdPos := FieldByName('NUMORD').AsInteger;
  Edit;
  FieldByName('NUMORD').AsInteger := intNumOrd;
  Post;

  If Locate('CODCAM', strCodCam, []) Then
  Begin
    Edit;
    FieldByName('NUMORD').AsInteger := intOrdPos;
    Post;
  End;
End;

end.
