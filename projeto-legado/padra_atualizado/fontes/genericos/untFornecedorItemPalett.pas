unit untFornecedorItemPalett;

interface

  uses untZClient, Types, Classes, EditFocus, data.DB;



Type

  TFornecedorItemPalettRecord = Record
    strCodite: string;
    strCodFor: String;
    strDesFor: String;
    fltQtdite: Double;
    fltValPal: Double;
    strAutoincrem: String;
    procedure pIniciaVariaveis;
  End;

  TFornecedorItemPalett = class(TZClient)
  private
    function fValidaGravacao(AFornecedorItemPalettRecord: TFornecedorItemPalettRecord): Boolean;
  public
    constructor create(Owner: TComponent; strCodIte: String); reintroduce;
    function fSalvar(strCodIte: String): Boolean;
    function fInciaEdicao: TFornecedorItemPalettRecord;
    function fInserir(AFornecedorItemPalettRecord: TFornecedorItemPalettRecord): Boolean;
  End;

  const semRegistros = '-1';


implementation

uses
  untFuncoesSimples, untConstantes;

{ TFornecedorItemPalett }

constructor TFornecedorItemPalett.create(Owner: TComponent; strCodIte: String);
var strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ITEPAL.AUTOINCREM,';
  strSQL := strSQL + '       PAL_CODITE,';
  strSQL := strSQL + '       ITE_DESITE,';
  strSQL := strSQL + '       PAL_CODFOR,';
  strSQL := strSQL + '       FOR_NOMFOR,';
  strSQL := strSQL + '       PAL_QTDITE,';
  strSQL := strSQL + '       PAL_VALPAL';
  strSQL := strSQL + '  FROM ITEPAL';
  strSQL := strSQL + ' INNER JOIN CADITE ON CADITE.ITE_CODITE = ITEPAL.PAL_CODITE';
  strSQL := strSQL + ' INNER JOIN CADFOR ON CADFOR.FOR_CODFOR = ITEPAL.PAL_CODFOR';
  strSQL := strSQL + ' WHERE CADITE.ITE_CODITE = "'+strCodIte+'"';
  Inherited Create(Owner, '');
  Self.qryQuery.SQL.Add(strSQL);
  Self.fAbreClient(True, '[TFornecedorItemPalett.create]');

end;

function TFornecedorItemPalett.fInciaEdicao: TFornecedorItemPalettRecord;
begin
  Result.pIniciaVariaveis;
  If Self.IsEmpty Then
  Begin
    Result.strAutoincrem := semRegistros;
    Exit(Result);
  End;
  Result.strCodite := Self.FieldByName('PAL_CODITE').AsString;
  Result.strCodFor := Self.FieldByName('PAL_CODFOR').AsString;
  Result.strDesFor := Self.FieldByName('FOR_NOMFOR').AsString;
  Result.fltQtdite := Self.FieldByName('PAL_QTDITE').AsFloat;
  Result.fltValPal := Self.FieldByName('PAL_VALPAL').AsFloat;
  Result.strAutoincrem := Self.FieldByName('AUTOINCREM').AsString;
end;

function TFornecedorItemPalett.fInserir(AFornecedorItemPalettRecord: TFornecedorItemPalettRecord): Boolean;
begin
  Result := True;
  if AFornecedorItemPalettRecord.strAutoincrem = semRegistros Then
    Exit(False);

  If not fValidaGravacao(AFornecedorItemPalettRecord) Then
    Exit(False);

  If (AFornecedorItemPalettRecord.strAutoincrem <> '') Then
  Begin
    Self.Locate('AUTOINCREM', AFornecedorItemPalettRecord.strAutoincrem, []);
    Self.Edit;
  End
  Else
  Begin
    Self.Insert;
    Self.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITEPAL', VS_StrCodEmp);
  End;

  Self.FieldByName('PAL_CODITE').AsString := AFornecedorItemPalettRecord.strCodIte;
  Self.FieldByName('PAL_CODFOR').AsString := AFornecedorItemPalettRecord.strCodFor;
  Self.FieldByName('FOR_NOMFOR').AsString := AFornecedorItemPalettRecord.strDesFor;
  Self.FieldByName('PAL_QTDITE').AsFloat  := AFornecedorItemPalettRecord.fltQtdite;
  Self.FieldByName('PAL_VALPAL').AsFloat  := AFornecedorItemPalettRecord.fltValPal;

  Self.Post;

end;

function TFornecedorItemPalett.fSalvar(strCodIte: String): Boolean;
begin
  Self.First;
  try
    Self.First;
    while not Self.Eof Do
    Begin
      If  Self.FieldByName('PAL_CODITE').AsString = '' Then
      begin
        Self.Edit;
        Self.FieldByName('PAL_CODITE').AsString := strCodIte;
        Self.Post;
      End;

      Self.Next;
    End;

    Result := fSalva;

  finally
    Self.EnableControls;
  end;
end;

function TFornecedorItemPalett.fValidaGravacao(AFornecedorItemPalettRecord: TFornecedorItemPalettRecord): Boolean;
var intRecno: integer;
begin
  Result := True;
  if AFornecedorItemPalettRecord.strAutoincrem = semRegistros Then
    Exit(True);

  Self.DisableControls;
  intRecno := Self.RecNo;
  try
    Self.First;
    while not Self.Eof Do
    Begin
      If  Self.FieldByName('PAL_CODFOR').AsString = AFornecedorItemPalettRecord. strCodFor Then
        If Self.FieldByName('AUTOINCREM').AsString <> AFornecedorItemPalettRecord. strAutoincrem Then
        Begin
          pMensagemOk('Código do Fornecedor já utiizado.');
          Exit(False);

        End;
      Self.Next;
    End;

  finally
    Self.RecNo := intRecno;
    Self.EnableControls;
  end;


end;

{ TFornecedorItemPalettRecord }

procedure TFornecedorItemPalettRecord.pIniciaVariaveis;
begin
  Self.strCodite := '';
  Self.strCodFor := '';
  Self.strDesFor := '';
  Self.fltQtdite := 0;
  Self.fltValPal := 0;
  Self.strAutoincrem := '';
end;

end.
