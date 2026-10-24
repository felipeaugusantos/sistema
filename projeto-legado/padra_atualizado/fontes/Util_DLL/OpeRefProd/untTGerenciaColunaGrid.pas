unit untTGerenciaColunaGrid;

interface
  uses SysUtils, Dialogs, classes, cxGridDBTableView, cxGridTableView, cxGridDBBandedTableView, Uni, cxGridCustomTableView, Math, untFuncoesSimples;
  Type
    TCampoGerenciaColuna = record
      strColumnName: string;
      width: Integer;
      blnVisible: Boolean;
      blnFalha : Boolean;
      Position: Integer;
    End;

    TArrColunasGridGerencia =  array of TCampoGerenciaColuna;

    TGerenciaColunaGrid = class
    private
      qry: TUniQuery;
      FCodOpe: String;
      FChave: string;
      FControlaVisibilidade: Boolean;
      FDBTableView: TcxGridDBTableView;
      ArrColunasGridGerencia: TArrColunasGridGerencia;
    function GetValor(Index: String): TCampoGerenciaColuna;
    public
      procedure pCarregaColunas;
      procedure pSalvaColuna(AColumn: TcxGridColumn; ApenasUmCampo: Boolean; WidthBand: Integer);
      constructor Create(ACodOpe: String; AChave: String; ADBTableView: TcxGridDBTableView; blnControlaVisibilidade: Boolean = True); Reintroduce; OverLoad;
      destructor Destroy; override;
      procedure pRecuperaColunas;
      property Campo[Index: String]: TCampoGerenciaColuna Read GetValor;
    End;



implementation

{ TGerenciaColunaGrid }

constructor TGerenciaColunaGrid.Create(ACodOpe, AChave: String; ADBTableView: TcxGridDBTableView; blnControlaVisibilidade: Boolean = True);
begin
  FCodOpe := ACodOpe;
  FControlaVisibilidade := blnControlaVisibilidade;
  FChave := AChave;
  FDBTableView := ADBTableView;
  qry := fCriaQuery;
  pCarregaColunas;
end;


destructor TGerenciaColunaGrid.Destroy;
begin
  FreeAndNil(qry);
  inherited;
end;

function TGerenciaColunaGrid.GetValor(Index: String): TCampoGerenciaColuna;
var ColunasGridGerencia: TCampoGerenciaColuna;
begin
  Result.blnFalha := True;
  For ColunasGridGerencia in  ArrColunasGridGerencia do
  Begin
    If ColunasGridGerencia.strColumnName = index Then
    Begin
      Result.blnFalha := False;
      Result := ColunasGridGerencia;
      Exit;
    End;
  End;
end;

procedure TGerenciaColunaGrid.pCarregaColunas;
begin
  qry.SQl.Clear;
  qry.SQL.Add('SELECT * FROM COLGER WHERE GER_CODOPE = "'+FCodOpe+'" AND GER_CHAVE_ = "'+FChave+'"');
  qry.Open;
  SetLength(ArrColunasGridGerencia, 0);
  SetLength(ArrColunasGridGerencia, qry.RecordCount);
  while not qry.Eof Do
  Begin
    ArrColunasGridGerencia[qry.RecNo -1].strColumnName := qry.FieldByName('GER_COLNAM').AsString;
    ArrColunasGridGerencia[qry.RecNo -1].width := qry.FieldByName('GER_WIDTH_').AsInteger;
    ArrColunasGridGerencia[qry.RecNo -1].blnVisible := qry.FieldByName('GER_VISIBL').AsInteger  = 1;
    ArrColunasGridGerencia[qry.RecNo -1].Position := qry.RecNo -1;
    qry.Next;
  End
end;

procedure TGerenciaColunaGrid.pRecuperaColunas;
var cxItem: TcxGridDBColumn;
    i: integer;
    CampoGerenciaColuna: TCampoGerenciaColuna;
begin
  For i := 0 To FDBTableView.ColumnCount -1 do
  begin
    cxItem := FDBTableView.Columns[i];
    CampoGerenciaColuna := Self.Campo[cxItem.Name];
    If Not CampoGerenciaColuna.blnFalha  Then
    Begin
      cxItem.Width := CampoGerenciaColuna.width;
      If FControlaVisibilidade Then
        cxItem.Visible := CampoGerenciaColuna.blnVisible;
    End;
  End;
end;


procedure TGerenciaColunaGrid.pSalvaColuna(AColumn: TcxGridColumn; ApenasUmCampo: Boolean; WidthBand: Integer);
begin
  qry.SQL.Clear;
  qry.SQL.Add('REPLACE INTO COLGER (GER_CODOPE, GER_CHAVE_, GER_COLNAM, GER_WIDTH_, GER_VISIBL) VALUES (:GER_CODOPE, :GER_CHAVE_, :GER_COLNAM, IFNULL(:GER_WIDTH_, GER_WIDTH_), :GER_VISIBL)');


  qry.ParamByName('GER_CODOPE').AsString := FCodOpe;
  qry.ParamByName('GER_CHAVE_').AsString := FChave;

  qry.ParamByName('GER_COLNAM').AsString := AColumn.Name;
  qry.ParamByName('GER_VISIBL').AsInteger:= IfThen(AColumn.Visible, 1, 0);
  If AColumn.Visible Then
  Begin
    If ApenasUmCampo Then
      qry.ParamByName('GER_WIDTH_').AsInteger:= WidthBand
    Else
      qry.ParamByName('GER_WIDTH_').AsInteger:= AColumn.Width;
  End
  Else
    qry.ParamByName('GER_WIDTH_').Clear;
  qry.ExecSQL;
end;


end.
