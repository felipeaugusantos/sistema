unit untLegendasGridRelat;

interface

Uses
  Classes, cxStyles, cxGrid, cxGridDBBandedTableView, Graphics, untZClient;

 Type
  TLegendasGridRelat = Class(TZClient)
    Private

      function fSQLLegendas: String;

    Public

      constructor Create(Owner: TComponent); Reintroduce;

      Destructor Destroy; override;

      function fCarregaLegendas(strLegendas: String): Boolean;
      function fRetornaLegendas: String;

      function fAdicionaLegenda(strLegenda: String; intCor: Integer): Boolean;

      Procedure pExcluiLegenda;
  End;

implementation

Uses
  System.SysUtils,
  StrUtils,
  untFuncoesSimples;

constructor TLegendasGridRelat.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLLegendas);

End;

Destructor TLegendasGridRelat.Destroy;
Begin
  Inherited;

End;

function TLegendasGridRelat.fSQLLegendas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + ' CAST(NULL AS CHAR(200)) AS legenda, ';
  strSQL := strSQL + ' CAST(NULL AS UNSIGNED) AS cor ';
  Result := strSQL;
End;

function TLegendasGridRelat.fCarregaLegendas(strLegendas: String): Boolean;
  Var
    stlLegendas: TStringList;
    intContador: Integer;
Begin
  Try
    Result := fLeDados('TLegendasGridRelat.fCarregaLegendas');
    Self.EmptyDataSet;

    stlLegendas := TStringList.Create;
    stlLegendas.Text := AnsiReplaceStr(strLegendas, '<<csq>>', #13#10);

    intContador := 0;
    While intContador < stlLegendas.Count - 1 Do
    Begin
      Append;
      FieldByName('legenda').AsString := stlLegendas[intContador];
      FieldByName('cor').AsString   := stlLegendas[Succ(intContador)];
      Post;

      Inc(intContador, 2);
    End;

    FreeAndNil(stlLegendas);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '[TInterfaceRelatorio.fCarregaLegendas]');
    End;
  End;
End;

function TLegendasGridRelat.fRetornaLegendas: String;
  Var
    stlLegendas: TStringList;
Begin
  stlLegendas := TStringList.Create;

  Self.First;
  While Not Self.Eof Do
  Begin
    stlLegendas.Add(FieldByName('legenda').AsString);
    stlLegendas.Add(FieldByName('cor').AsString);
    Self.Next;
  End;

  Result := AnsiReplaceStr(stlLegendas.Text, #13#10, '<<csq>>');
  FreeAndNil(stlLegendas);
End;

function TLegendasGridRelat.fAdicionaLegenda(strLegenda: String; intCor: Integer): Boolean;
Begin
  Result := False;
  If strLegenda.IsEmpty Then
    Exit;

  If Self.Locate('legenda', strLegenda, []) Then
  Begin
    Self.Edit;
  End Else
  Begin
    Self.Append;
    Self.FieldByName('legenda').AsString := strLegenda;
  End;

  Self.FieldByName('cor').AsInteger := intCor;
  Self.Post;

  Result := True;
End;

Procedure TLegendasGridRelat.pExcluiLegenda;
Begin
  If Self.IsEmpty Then
    Exit;

  If Not fPergunta('Confirma a exclusão da legenda?') Then
    Exit;

  Self.Delete;
End;


end.
