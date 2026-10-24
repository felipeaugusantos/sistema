unit untTIntegridadeTransferenciaCodigo;

interface

Uses Uni, SysUtils, Classes, Vcl.ComCtrls;

Type
  TIntegridadeTransferenciaCodigo = Class
  private
    FQryTCOARR: TUniQuery;
    FQryDelete, FQryUniKey: TUniQuery;
    FCodOrigem: String;
    FCodDestino: String;
    FColumnsName: TStringList;
    procedure pExecutaSQL;
    procedure  pDelete(AQryDuplicados: TUniQuery);
  Public
    Constructor Create(ATabela: String; ACodOrigem, ACodDestino: String);

    Destructor  Destroy; override;

    procedure pAjustaRegistrosDuplicados(AProgress: TProgressBar);
  End;

implementation

uses
  untFuncoesSimples, Forms;

{ TIntegridadeTransferenci
aCodigo }

constructor TIntegridadeTransferenciaCodigo.Create(ATabela: String; ACodOrigem, ACodDestino: String);
begin
  FQryTCOARR := fCriaQuery;
  FQryUniKey := fCriaQuery;
  FQryDelete := fCriaQuery;
  FColumnsName := TStringList.Create;

  FCodOrigem  := ACodOrigem;
  FCodDestino := ACodDestino;

  FQryTCOARR.SQL.Add('SELECT TCA_ARQUIV, TCA_ARQREL, TCA_CAMREL, TCA_DESCRI FROM TCOARR');
  FQryTCOARR.SQL.Add(' WHERE TCA_ARQUIV = ' + QuotedStr(ATabela));
  FQryTCOARR.SQL.Add('   AND TCA_DELDUP = 1 ');

  FQryTCOARR.Open;
end;

procedure TIntegridadeTransferenciaCodigo.pDelete(AQryDuplicados: TUniQuery);
  var
    i: integer;
Begin
  FQryDelete.SQL.Clear;
  FQryDelete.SQL.Add(' DELETE FROM ' + FQryTCOARR.FieldByName('TCA_ARQREL').AsString);
  FQryDelete.SQL.Add(' WHERE TRUE ');
  For i := 0 To FColumnsName.Count -1 do
    FQryDelete.SQL.Add('        AND ' + FColumnsName[i] + ' = ' + QuotedStr(AQryDuplicados.Fields[i].AsString));
  FQryDelete.ExecSQL
End;

procedure TIntegridadeTransferenciaCodigo.pExecutaSQL;
  Var
    FQueryDuplicados: TUniQuery;
    i: Integer;
begin
  FQueryDuplicados := fCriaQuery;
  Try
    FQueryDuplicados.SQL.Clear;
    FQueryDuplicados.SQL.Add('SELECT ');
    For i := 0 To FColumnsName.Count -1 do
    Begin
      If i = 0 Then
        FQueryDuplicados.SQL.Add(FColumnsName[i])
      Else
        FQueryDuplicados.SQL.Add(', ' + FColumnsName[i]);
    End;
    FQueryDuplicados.SQL.Add('  FROM ' + FQryTCOARR.FieldByName('TCA_ARQREL').AsString + ' AS ORI ');
    FQueryDuplicados.SQL.Add(' WHERE ' + FQryTCOARR.FieldByName('TCA_CAMREL').AsString+ ' = ' + QuotedStr(FCodOrigem));
    FQueryDuplicados.SQL.Add('  AND  ( SELECT  COUNT(1) FROM ' + FQryTCOARR.FieldByName('TCA_ARQREL').AsString + ' AS DES ');
    FQueryDuplicados.SQL.Add('        WHERE DES.' + FQryTCOARR.FieldByName('TCA_CAMREL').AsString + ' = ' + QuotedStr(FCodDestino));
    For i := 0 To FColumnsName.Count -1 do
    begin
      If FColumnsName[i] <> FQryTCOARR.FieldByName('TCA_CAMREL').AsString Then
         FQueryDuplicados.SQL.Add('        AND DES.' + FColumnsName[i] + ' =  ORI. ' + FColumnsName[i]);
    End;
    FQueryDuplicados.SQL.Add('        ) > 0 ');

    FQueryDuplicados.Open;

    While Not FQueryDuplicados.Eof do
    Begin
      pDelete(FQueryDuplicados);
      FQueryDuplicados.Next;
    End;
  Finally
    FreeAndNil(FQueryDuplicados);
  End;
End;

destructor TIntegridadeTransferenciaCodigo.Destroy;
begin
  FreeAndNil(FQryTCOARR);
  FreeAndNil(FQryUniKey);
  FreeAndNil(FQryDelete);
  FreeAndNil(FColumnsName);
end;

procedure TIntegridadeTransferenciaCodigo.pAjustaRegistrosDuplicados(AProgress: TProgressBar);
var oldKeyName: String;
begin
  Try
    While Not FQryTCOARR.Eof Do
    Begin
      If Assigned(AProgress) Then
        AProgress.Max := FQryTCOARR.RecordCount;

      FQryUniKey.SQL.Clear;
      FQryUniKey.SQL.Add('SHOW INDEX FROM ' + FQryTCOARR.FieldByName('TCA_ARQREL').AsString);
      FQryUniKey.SQL.Add(' WHERE Non_unique = 0 ');
      FQryUniKey.SQL.Add('    AND Key_name <> '+ QuotedStr('PRIMARY'));
      FQryUniKey.Open;
      oldKeyName := FQryUniKey.FieldByName('Key_name').AsString;
      FColumnsName.Clear;
      While Not FQryUniKey.Eof Do
      Begin
        If oldKeyName = FQryUniKey.FieldByName('Key_name').AsString Then
        Begin
          FColumnsName.Add(FQryUniKey.FieldByName('Column_name').AsString);
          FQryUniKey.Next;
        end;

        If (oldKeyName <> FQryUniKey.FieldByName('Key_name').AsString) Or (FQryUniKey.Eof) Then
        Begin
          oldKeyName := FQryUniKey.FieldByName('Key_name').AsString;
          If FColumnsName.Count > 0 Then
            pExecutaSQL;
          FColumnsName.Clear;
        End;
      End;

      FQryTCOARR.Next;
      If Assigned(AProgress) Then
      Begin
        AProgress.Position := AProgress.Position + 1;
        Application.ProcessMessages;
      End;
    End;
    FColumnsName.Clear;
  Except
    //Silencia o erro intencional
    // caso ocorrer de der erro de chave na transferencia então deve ser verificado o motivo do erro aqui.
    // Não foi inserido tratamento, dado que este recurso é apenas para reduzir o numero de chamados referente aos
    // erros de transferencia de código. ou seja se não der erro na transferencia de código já basta.

  End;
end;

end.
