unit untTabelaPrecoProduto;

interface

Uses
  cxProgressBar,
  Classes,
  SysUtils,
  Controls,
  ComCtrls,
  DB,
  DBClient,
  Forms,
  StrUtils,
  Math,
  Variants,
  untFuncoesSimples,
  Uni,
  untZClient,
  untIteBar,
  untParCalculaPrecoCusto;

Type
  TArrTabPre = Array Of Record
                          strTabPre: String;
                          cdsIteFor: TZClient;
                          cdsTabDet: TZClient;
                          stlTabelas: TStringList;
                        End;

  TTabelaPrecoProduto = Class(TComponent)
    Private

      qryIteGer,
      qryCadIte: TUniQuery;

      arrTabPre: TArrTabPre;

      function fSalvaTabelaPrecos: Boolean;

      function fCarregaTabelasIteger: Boolean;

      Procedure pLiberaTabelas;

    Public

      constructor Create(Owner: TComponent; AqryIteGer, AqryCadIte: TUniQuery); Reintroduce;

      Destructor Destroy; override;

      function fAtulizaPrecosFornecedor: Boolean;
  End;

implementation

constructor TTabelaPrecoProduto.Create(Owner: TComponent; AqryIteGer, AqryCadIte: TUniQuery);
Begin
  Inherited Create(Owner);

  qryIteGer := AqryIteGer;
  qryCadIte := AqryCadIte;

  SetLength(arrTabPre, 0);
End;

Destructor TTabelaPrecoProduto.Destroy;
Begin
  Inherited;

End;

function TTabelaPrecoProduto.fSalvaTabelaPrecos: Boolean;
  Var
    intTabPre: Integer;
Begin
  Result := True;

  For intTabPre := Low(arrTabPre) To High(arrTabPre) Do
  Begin
    arrTabPre[intTabPre].cdsTabDet.First;

    While Not arrTabPre[intTabPre].cdsTabDet.Eof Do
    Begin
      arrTabPre[intTabPre].cdsTabDet.Edit;
      arrTabPre[intTabPre].cdsTabDet.FieldByName('ITE_PREVEN').AsFloat :=  qryIteGer.FieldByName('ITE_PREVE' + arrTabPre[intTabPre].stlTabelas[0]).AsFloat;

      arrTabPre[intTabPre].cdsTabDet.FieldByName('ITE_MARBRU').AsFloat := fCalculaPrecoVenda(2,
                                                    arrTabPre[intTabPre].cdsTabDet.FieldByName('ITE_PRECUS').AsFloat,
                                                    arrTabPre[intTabPre].cdsTabDet.FieldByName('ITE_PREVEN').AsFloat,
                                                    arrTabPre[intTabPre].cdsTabDet.FieldByName('ITE_MARBRU').AsFloat,
                                                    arrTabPre[intTabPre].cdsTabDet.FieldByName('ITE_ICMSAI').AsFloat,
                                                    arrTabPre[intTabPre].cdsTabDet.FieldByName('ITE_IMPFED').AsFloat,
                                                    arrTabPre[intTabPre].cdsTabDet.FieldByName('ITE_DESOPE').AsFloat,
                                                    arrTabPre[intTabPre].cdsTabDet.FieldByName('ITE_COMTBL').AsFloat);

      arrTabPre[intTabPre].cdsTabDet.Post;

      arrTabPre[intTabPre].cdsTabDet.Next;
    End;

    Result := arrTabPre[intTabPre].cdsTabDet.fSalva;

    If Not Result Then
      Break;
  End;
End;

Procedure TTabelaPrecoProduto.pLiberaTabelas;
  Var
    intTabPre: Integer;
Begin
  For intTabPre := Low(arrTabPre) To High(arrTabPre) Do
  Begin
    FreeAndNil(arrTabPre[High(arrTabPre)].stlTabelas);
    FreeAndNil(arrTabPre[High(arrTabPre)].cdsTabDet);
  End;

  SetLength(arrTabPre, 0);
End;

function TTabelaPrecoProduto.fCarregaTabelasIteger: Boolean;
  Var
    intTabelas,
    intTabPre: Integer;
    blnAchou: Boolean;
    stlEmpresas: TStringList;
Begin
  Result := True;

  pLiberaTabelas;

  stlEmpresas := TStringList.Create;
  fRetEmpresasUsamPrecoMatriz(stlEmpresas);

  For intTabelas := 1 To 7 Do
    If Not fEmptyStr(qryIteGer.FieldByName('ITE_TABPR' + intTabelas.ToString).AsString) Then
    Begin
      blnAchou := False;

      For intTabPre := Low(arrTabPre) To High(arrTabPre) Do
        If arrTabPre[intTabPre].strTabPre = qryIteGer.FieldByName('ITE_TABPR' + intTabelas.ToString).AsString Then
        Begin
          blnAchou := True;
          arrTabPre[intTabPre].stlTabelas.Add(intTabelas.ToString);
          Break;
        End;

      If Not blnAchou Then
      Begin
        SetLength(arrTabPre, Succ(Length(arrTabPre)));
        arrTabPre[High(arrTabPre)].stlTabelas := TStringList.Create;
        arrTabPre[High(arrTabPre)].stlTabelas.Duplicates := dupIgnore;
        arrTabPre[High(arrTabPre)].stlTabelas.Add(intTabelas.ToString);

        arrTabPre[High(arrTabPre)].strTabPre := qryIteGer.FieldByName('ITE_TABPR' + intTabelas.ToString).AsString;
        arrTabPre[High(arrTabPre)].cdsTabDet := TZClient.Create(Self,
          'SELECT * FROM TABDET WHERE ITE_CODTAB = :CODTAB AND ITE_CODITE = :CODITE AND ITE_CODEMP IN (' + fCommaText(stlEmpresas, True) + ')');

        arrTabPre[High(arrTabPre)].cdsTabDet.qryQuery.ParamByName('CODITE').AsString := qryIteGer.FieldByName('ITE_CODITE').AsString;
        arrTabPre[High(arrTabPre)].cdsTabDet.qryQuery.ParamByName('CODTAB').AsString := qryIteGer.FieldByName('ITE_TABPR' + intTabelas.ToString).AsString;
        Result := arrTabPre[High(arrTabPre)].cdsTabDet.fLeDados('TTabelaPrecoProduto.fCarregaTabelasIteger');

        If Not Result Then
          Break;
      End;

    End;

End;

function TTabelaPrecoProduto.fAtulizaPrecosFornecedor: Boolean;
Begin
  Try

    Result := fCarregaTabelasIteger And fSalvaTabelaPrecos;

    pLiberaTabelas;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TTabelaPrecoProduto.fCarregaTabelasIteger]');
    End;
  End;

End;

end.
