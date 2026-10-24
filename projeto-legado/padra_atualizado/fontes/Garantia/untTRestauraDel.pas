unit untTRestauraDel;

interface

uses
  untFuncoesSimples, Uni, Classes, sysUtils;
  type
    TRestauraDel = class
    private
      FStrTabela: String;
      FStrAutoincrem: String;
      FNameFieldAutInc: String;
      FCriaApenasCapa: Boolean;
      qryTabEstrutura: TUniQuery;
      qryRegistroDel: TUnIQuery;
      qryCommand: TUniQuery;
      strSQLDelete: String;
      procedure pProcessaRestauracao;
      procedure pCarregaRegistroDel;
      procedure pMontaInsert;
      procedure pInsere;
      procedure pProcessaTabelaExtencoes;

    public
      constructor Create;
      class procedure pRestauraTabela(ATabela: String; AAutInc: String; strNameFieldAutInc: String = 'AUTOINCREM'; ACriaApenasCapa: Boolean = False);
      destructor Destroy; override;
  end;

implementation


{ TRestauraDel }

constructor TRestauraDel.Create;
begin
  qryTabEstrutura := fCriaQuery;
  qryCommand := fCriaQuery;
  qryRegistroDel := fCriaQuery;
end;

destructor TRestauraDel.Destroy;
begin
  FreeAndNil(qryTabEstrutura);
  FreeAndNil(qryCommand);
  FreeAndNil(qryRegistroDel);
  inherited;
end;

class procedure TRestauraDel.pRestauraTabela(ATabela, AAutInc: String; strNameFieldAutInc: String = 'AUTOINCREM'; ACriaApenasCapa: Boolean = False);
var RestauraDel: TRestauraDel;

begin
  RestauraDel := TRestauraDel.Create;
  Try
    RestauraDel.FStrTabela := ATabela;
    RestauraDel.FStrAutoincrem := AAutInc;
    RestauraDel.FNameFieldAutInc := strNameFieldAutInc;
    RestauraDel.FCriaApenasCapa := ACriaApenasCapa;
    RestauraDel.pProcessaRestauracao;
  Finally
    FreeAndNil(RestauraDel);
  End;
END;

procedure TRestauraDel.pCarregaRegistroDel;
begin
  qryRegistroDel.SQL.Clear;
  qryRegistroDel.SQL.Add('SELECT * FROM DEL_'+ FStrTabela + ' WHERE '+ FNameFieldAutInc + ' = "'+FStrAutoincrem+'"');
  strSQLDelete :=  'DELETE FROM  DEL_'+ FStrTabela + ' WHERE '+ FNameFieldAutInc + ' = "'+FStrAutoincrem+'"';
  qryRegistroDel.Open;

end;

procedure TRestauraDel.pProcessaRestauracao;
begin
  qryTabEstrutura.SQL.Clear;
  qryTabEstrutura.sql.Text := 'SELECT * FROM ' + FStrTabela + ' WHERE FALSE ';
  qryTabEstrutura.Open;
  pCarregaRegistroDel;
  pMontaInsert;
  while not qryRegistroDel.Eof Do
  begin
    pInsere;
    qryRegistroDel.Next;
  End;
  if strSQLDelete <> '' then
  Begin
    qryCommand.Sql.Text := strSQLDelete;
    qryCommand.ExecSQL;
  End;

end;

procedure TRestauraDel.pProcessaTabelaExtencoes;
var strTabelaExtencao: String;
    sFieldLigacao: String;
begin
  strTabelaExtencao := '';
  If FstrTabela = 'FATGOR' Then
  begin
    strTabelaExtencao := 'EXTGOR';
    sFieldLigacao     := 'FGO_SEQFGO';
    TRestauraDel.pRestauraTabela(strTabelaExtencao, qryRegistroDel.FieldByName('AUTOINCREM').AsString, sFieldLigacao);

    strTabelaExtencao := 'AUXGOR';
    sFieldLigacao     := 'AUX_SEQGER';
    TRestauraDel.pRestauraTabela(strTabelaExtencao, qryRegistroDel.FieldByName('AUTOINCREM').AsString, sFieldLigacao);
    If Not FCriaApenasCapa Then
    begin
      strTabelaExtencao := 'FATDOR';
      sFieldLigacao     := 'FDO_SEQGER';
      TRestauraDel.pRestauraTabela(strTabelaExtencao, qryRegistroDel.FieldByName('AUTOINCREM').AsString, sFieldLigacao);
    end;
  End
  Else If FstrTabela = 'FATDOR' Then
  Begin
    strTabelaExtencao := 'EXTDOR';
    sFieldLigacao     := 'FDO_SEQFDO';
    TRestauraDel.pRestauraTabela(strTabelaExtencao, qryRegistroDel.FieldByName('AUTOINCREM').AsString, sFieldLigacao);
  End;
end;

procedure TRestauraDel.pInsere;
  var CountFields, i: integer;
begin
  CountFields := qryTabEstrutura.Fields.Count -1;
  For i := 0 To CountFields do
   qryCommand.ParamByName(qryTabEstrutura.Fields[i].FieldName).Value := qryRegistroDel.FieldByName(qryTabEstrutura.Fields[i].FieldName).Value;

  qryCommand.ExecSQL;
  pProcessaTabelaExtencoes;
end;

procedure TRestauraDel.pMontaInsert;
var strFields: String;
    strBinds : String;
    CountFields, i: integer;
begin
  CountFields := qryTabEstrutura.Fields.Count -1;
  For i := 0 To CountFields do
  begin
    strFields := strFields + qryTabEstrutura.Fields[i].FieldName + IIf(i< CountFields,  ',', '');
    strBinds  := strBinds  + ':'+qryTabEstrutura.Fields[i].FieldName +  IIf(i< CountFields,  ',', '');
  end;
  qryCommand.SQL.Clear;
  qryCommand.SQL.Add('INSERT INTO ' +FstrTabela+ '('+ strFields + ') VALUES ('+strBinds+')');
end;

end.


