unit untTCamposExportaEstoqueEmExcesso;

interface

  uses System.SysUtils,untFuncoesSimples, uni, untZClient, uniClientDataSet;


  Type
    TCamposExportaEstoqueEmExcesso = class
    private
      FCodOpe: String;
      FOpcRel: integer;
      FCdsDados: TZClient;
      FConsulta: TUniQuery;
      function fGetSQL: String;
      function fFieldExiste(strFieldName: String):Boolean;
      procedure pSalva;
    public
      constructor Create(strCodOpe: String; intOpcRel: integer);reintroduce;
      destructor Destroy; override;
      procedure pAddField(strFieldName, strField: string);
      procedure pSelecionaCampos;
      function CampoMarcado(StrField: String): Boolean;
  end;

implementation

uses untSelCamposExportaEstoqueEmExcesso;

{ TCamposExportaEstoqueEmExcesso }

function TCamposExportaEstoqueEmExcesso.CampoMarcado(StrField: String): Boolean;
begin
  FCdsdados.First;
  Result := True;
  If FCdsdados.Locate('ANA_FIELD_', StrField, []) Then
    Result := FCdsdados.FieldByName('ANA_EXPORT').AsInteger = 1;
end;

constructor TCamposExportaEstoqueEmExcesso.Create(strCodOpe: String; intOpcRel: integer);
begin
  If strCodOpe = '' Then
    raise Exception.Create('Codigo do Operador não foi definido!')
  Else
    inherited Create;
  FCodOpe := strCodOpe;
  FOpcRel := intOpcRel;
  FCdsDados := TZClient.Create(nil, fGetSQL);
  FConsulta := fCriaQuery;
  FCdsDados.fAbreClient(True, '[TCamposExportaEstoqueEmExcesso.Create]');
end;

destructor TCamposExportaEstoqueEmExcesso.Destroy;
begin
  FreeAndNil(FCdsDados);
  FreeAndNil(FConsulta);
  inherited;
end;

function TCamposExportaEstoqueEmExcesso.fFieldExiste(strFieldName: String): Boolean;
begin
  FConsulta.SQL.Clear;
  FConsulta.SQL.Add('SELECT * FROM ANAEXC WHERE ANA_CODOPE = "'+FCodOpe+'" AND ANA_FIELD_ = "'+strFieldName+'" AND ANA_OPCREL  = ' + FOpcRel.ToString );
  FConsulta.Open;

  Result :=  Not FConsulta.IsEmpty;

end;

function TCamposExportaEstoqueEmExcesso.fGetSQL: String;
begin
  Result := 'SELECT * FROM ANAEXC WHERE FALSE';
end;

procedure TCamposExportaEstoqueEmExcesso.pAddField(strFieldName,
  strField: string);
  var i: integer;
begin
  If fFieldExiste(strFieldName) Then
  Begin
    FCdsDados.Append;
    For i := 0 To FConsulta.Fields.Count -1 do
      FCdsDados.FieldByName(FConsulta.Fields[i].FieldName).Value := FConsulta.Fields[i].Value;
    FCdsDados.Post;
  End
  Else
  Begin
    FCdsDados.Insert;
    FCdsDados.FieldByName('ANA_FIELD_').AsString := strFieldName;
    FCdsDados.FieldByName('ANA_FIEDES').AsString := strField;
    FCdsDados.FieldByName('ANA_CODOPE').AsString := FCodOpe;
    FCdsDados.FieldByName('ANA_EXPORT').AsInteger := 1;
    FCdsDados.Post;
  End;
end;

procedure TCamposExportaEstoqueEmExcesso.pSalva;
begin
  FCdsDados.First;
  FConsulta.SQL.Clear;
  while not FCdsDados.Eof Do
  Begin
    FConsulta.SQL.Add('REPLACE INTO ANAEXC(');
    If FCdsDados.FieldByName('ID').AsString <> '' Then
      FConsulta.SQL.Add('ID,');
    FConsulta.SQL.Add('ANA_OPCREL,');
    FConsulta.SQL.Add('ANA_CODOPE,');
    FConsulta.SQL.Add('ANA_FIELD_,');
    FConsulta.SQL.Add('ANA_EXPORT,');
    FConsulta.SQL.Add('ANA_FIEDES)VALUES(');
    If FCdsDados.FieldByName('ID').AsString <> '' Then
      FConsulta.SQL.Add(FCdsDados.FieldByName('ID').AsString + ',');
    FConsulta.SQL.Add(FOpcRel.ToString + ',');
    FConsulta.SQL.Add('"' + FCdsDados.FieldByName('ANA_CODOPE').AsString+ '",');
    FConsulta.SQL.Add('"' + FCdsDados.FieldByName('ANA_FIELD_').AsString+ '",');
    FConsulta.SQL.Add('"' + FCdsDados.FieldByName('ANA_EXPORT').AsString+ '",');
    FConsulta.SQL.Add('"' + StringReplace(FCdsDados.FieldByName('ANA_FIEDES').AsString, '"', '', [rfReplaceAll])+ '");');
    FCdsDados.Next;
  End;

  FConsulta.ExecSQL;

end;

procedure TCamposExportaEstoqueEmExcesso.pSelecionaCampos;
var frmSelCamposExportaEstoqueEmExcesso: TfrmSelCamposExportaEstoqueEmExcesso;
    FCdsDadosbackup: TUniClientDataSet;
begin
  pCriarFormularios(TfrmSelCamposExportaEstoqueEmExcesso, frmSelCamposExportaEstoqueEmExcesso);
  Try
    FCdsDadosbackup := TUniClientDataSet.Create(nil);
    FCdsDadosbackup.Data := FCdsDados.Data;
    frmSelCamposExportaEstoqueEmExcesso.dtsDados.DataSet := FCdsDados;
    frmSelCamposExportaEstoqueEmExcesso.ShowModal;
    If frmSelCamposExportaEstoqueEmExcesso.blnConfirma Then
      pSalva
    Else
      FCdsDados.Data := FCdsDadosbackup.Data;

  Finally
    FreeAndNil(frmSelCamposExportaEstoqueEmExcesso);
    FreeAndNil(FCdsDadosbackup);
  End;
end;

end.
