unit untTGerenciaModeloPermitidos;

interface

uses untFuncoesSimples, untZClient, Uni, Data.DB, Classes, SysUtils;

Type
  TGerenciaModeloPermitidos = class
    private
      cdsDados: TZClient;
      procedure pMarcaDesmarca(blnMarca: Boolean);
    protected
      FCfop: String;
    public
      property Cfop: String read FCfop write FCfop;
      class function fCarregaModelosPermitidoParaCFop(strCFOP: string; DataSource: TDataSource): TGerenciaModeloPermitidos;
      class function fModeloPermitidoParaCFOP(strCfop: String; strModelo: String): Boolean;
      procedure pMarcaTodos;
      procedure pDesmarcaTodos;
      procedure pInverte;
      destructor Destroy; override;
      procedure pSalva;
  end;


implementation

{ TGerenciaModeloPermitidos }

destructor TGerenciaModeloPermitidos.Destroy;
begin
  freeAndNil(cdsDados);
  inherited;
end;

class function TGerenciaModeloPermitidos.fCarregaModelosPermitidoParaCFop(
  strCFOP: string; DataSource: TDataSource): TGerenciaModeloPermitidos;
var qry: TUniQuery;
begin
  Result := TGerenciaModeloPermitidos.Create;
  qry := fCriaQuery;
  Try
    qry.SQL.Add('SELECT  * FROM MODCFO WHERE  MODCFO.CFO_CFOP_ = "'+ strCFOP + '"');
    qry.Open;
    If qry.IsEmpty Then
      Result.cdsDados := TZClient.Create(nil, 'SELECT FIS_CODMOD AS CFO_MODELO, "S" AS SELECIONADO FROM MODFIS')
    Else
      Result.cdsDados := TZClient.Create(nil, 'SELECT FIS_CODMOD AS CFO_MODELO, IF(CFO_CFOP_ IS NULL, "N", "S") AS SELECIONADO FROM MODFIS LEFT JOIN MODCFO ON  FIS_CODMOD = CFO_MODELO AND CFO_CFOP_ = "' + strCFOP + '"');
    Result.cdsDados.fAbreClient(False, '[TGerenciaModeloPermitidos.fCarregaModelosPermitidoParaCFop]');
    Result.FCfop := strCFOP;
    DataSource.DataSet := Result.cdsDados;
  Finally
    FreeAndNil(qry)
  End;

end;

class function TGerenciaModeloPermitidos.fModeloPermitidoParaCFOP(strCfop, strModelo: String): Boolean;
  var
    qry: TUniQuery;
begin
  qry := fCriaQuery;
  If strCfop = '' Then
    Exit(True);
  If strModelo = '' Then
    Exit(True);
  Try
    qry.SQL.Add('SELECT  * FROM MODCFO WHERE  MODCFO.CFO_CFOP_ = "'+ strCFOP + '"');
    qry.Open;
    If qry.IsEmpty Then
      Exit(True);
    qry.SQL.Clear;
    qry.SQL.Add('SELECT  * FROM MODCFO WHERE  MODCFO.CFO_CFOP_ = "'+ strCFOP + '" AND CFO_MODELO = "' + strModelo + '"');
    qry.Open;

    result := Not qry.IsEmpty;
  Finally
    FreeAndNil(qry);
  End;
end;

procedure TGerenciaModeloPermitidos.pDesmarcaTodos;
begin
  cdsDados.First;
  While not cdsDados.Eof Do
  Begin
    pMarcaDesmarca(False);
    cdsDados.Next;
  End;
end;

procedure TGerenciaModeloPermitidos.pMarcaDesmarca(blnMarca: Boolean);
begin
  cdsDados.Edit;
  cdsDados.FieldByName('SELECIONADO').AsString := IIf(blnMarca, 'S', 'N');
  cdsDados.Post;
end;

procedure TGerenciaModeloPermitidos.pMarcaTodos;
begin
  cdsDados.First;
  While not cdsDados.Eof Do
  Begin
    pMarcaDesmarca(True);
    cdsDados.Next;
  End;
end;

procedure TGerenciaModeloPermitidos.pSalva;
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    cdsDados.First;
    while not cdsDados.Eof do
    Begin
      If cdsDados.FieldByName('SELECIONADO').AsString = 'N' Then
        qryComand.SQL.Add('DELETE FROM MODCFO WHERE CFO_CFOP_ = "'+FCfop+'" AND CFO_MODELO = "'+cdsDados.FieldByName('CFO_MODELO').AsString+'";')
      Else
        qryComand.SQL.Add('REPLACE INTO MODCFO(CFO_CFOP_, CFO_MODELO) VALUES ("'+FCfop+'", "'+cdsDados.FieldByName('CFO_MODELO').AsString+'");');
      cdsDados.Next;
    End;

    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;
end;

procedure TGerenciaModeloPermitidos.pInverte;
begin
  cdsDados.First;
  While not cdsDados.Eof Do
  Begin
    pMarcaDesmarca(cdsDados.FieldByName('SELECIONADO').AsString = 'N');
    cdsDados.Next;
  End;
end;

end.
