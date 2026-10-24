unit untFatDigDescontoPorMarca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  UniClientDataSet, Uni, untFuncoesSimples, System.UITypes, DBGridCitel;

type
  TfrmFatDigDescontoPorMarca = class(TfrmPai)
    btnDesmarcar: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnOk: TBitBtnLocked;
    lblEnter: TLabel;
    dtsMarcas: TDataSource;
    dbgMarcas: TDBGridCitel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgMarcasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgMarcasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
  private
    iIndex: Integer;
    cdsMarcas: TUniClientDataSet;
    function fCriaTemporaria(Owner: TComponent): TUniClientDataSet;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pMarcar;
    procedure pDesmarcar;
    procedure pAlternarMarcacao;
    procedure pMarcarTodos;
    procedure pDesmarcarTodos;
  public
    strMarcasAltera: String;
    procedure pAdicionaItens(cdsItens: TDataSet);
    function fRetornaDescontoMarca(strMarca: String): String;
  end;

var
  frmFatDigDescontoPorMarca: TfrmFatDigDescontoPorMarca;

implementation

{$R *.dfm}

{ TfrmFatDigDescontoPorMarca }

procedure TfrmFatDigDescontoPorMarca.btnDesmarcarClick(Sender: TObject);
begin
  inherited;

  pDesmarcarTodos;
end;

procedure TfrmFatDigDescontoPorMarca.btnMarcarClick(Sender: TObject);
begin
  inherited;

  pMarcarTodos;
end;

procedure TfrmFatDigDescontoPorMarca.btnOkClick(Sender: TObject);
  Var
    strFilter: String;
    blnFilter: Boolean;
    blnEmpty: Boolean;
begin
  inherited;

  strFilter := cdsMarcas.Filter;
  blnFilter := cdsMarcas.Filtered;
  blnEmpty  := False;
  strMarcasAltera := '';
  cdsMarcas.DisableControls;
  Try
    cdsMarcas.Filter   := 'SELECAO = ' + QuotedStr('S') + ' AND DESCON IS NOT NULL';
    cdsMarcas.Filtered := True;
    Self.ModalResult   := mrNone;

    blnEmpty := cdsMarcas.IsEmpty;

    If Not blnEmpty Then
    Begin
      cdsMarcas.First;
      While Not cdsMarcas.Eof Do
      Begin
        If fEmptyStr(strMarcasAltera) Then
          strMarcasAltera := cdsMarcas.FieldByName('CODMAR').AsString.QuotedString
        Else
          strMarcasAltera := strMarcasAltera + ', ' + cdsMarcas.FieldByName('CODMAR').AsString.QuotedString;

        cdsMarcas.Next;
      End;
      Self.modalResult := mrOk;
    End;
  Finally
    cdsMarcas.Filter   := strFilter;
    cdsMarcas.Filtered := blnFilter;

    cdsMarcas.EnableControls;
    If blnEmpty Then
      pMensagemOk('Nenhuma marca selecionada ou marca sem valor de desconto selecionada!');
  End;
end;

procedure TfrmFatDigDescontoPorMarca.dbgMarcasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  If (Assigned(cdsMarcas)) And (Not cdsMarcas.IsEmpty) Then
  Begin
    If cdsMarcas.FieldByName('SELECAO').AsString = 'S' Then
      dbgMarcas.Canvas.Brush.Color := clAqua;

    dbgMarcas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TfrmFatDigDescontoPorMarca.dbgMarcasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_SPACE) Or (Key = VK_RETURN) Then
    pAlternarMarcacao;
end;

function TfrmFatDigDescontoPorMarca.fCriaTemporaria(Owner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Owner);

  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODMAR';  DataType := ftString; Size := 20;  Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESMAR';  DataType := ftString; Size := 20;  Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESCON';  DataType := ftFloat;               Required := False; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'SELECAO'; DataType := ftString; Size := 001; Required := False; End;

  Result.CreateDataSet;
  Result.LogChanges := False;
end;

procedure TfrmFatDigDescontoPorMarca.FormCreate(Sender: TObject);
begin
  inherited;

  iIndex := 1;
  cdsMarcas := fCriaTemporaria(Self);
end;

procedure TfrmFatDigDescontoPorMarca.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F5:
      btnMarcar.Click;
    VK_F6:
      btnDesmarcar.CLick;
    VK_F10:
      btnOK.Click;
    VK_ESCAPE:
      btnSair.Click;
  End;
end;

procedure TfrmFatDigDescontoPorMarca.FormShow(Sender: TObject);
begin
  inherited;

  iIndex := 1;

  dtsMarcas.DataSet := cdsMarcas;
  dtsMarcas.DataSet.AfterScroll := pAfterScroll;
  dtsMarcas.DataSet.BeforePost  := pBeforePost;
  pSetFocus(dbgMarcas);
  cdsMarcas.First;
end;

function TfrmFatDigDescontoPorMarca.fRetornaDescontoMarca(strMarca: String): String;
begin
  cdsMarcas.Filtered := False;
  cdsMarcas.Filter   := 'CODMAR = ' + strMarca;
  cdsMarcas.Filtered := True;

  Result := FloatToStrF(cdsMarcas.FieldByName('DESCON').AsFloat, ffNumber, 12, fRetPrecisaoDescontoItem);

  cdsMarcas.Filtered := False;
end;

procedure TfrmFatDigDescontoPorMarca.pAdicionaItens(cdsItens: TDataSet);
  Var
    strProdutos: String;
    qryMarcas: TUniQuery;
begin
  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    If fEmptyStr(strProdutos) Then
      strProdutos := cdsItens.FieldByName('ITE_CODMAR').AsString
    Else
      strProdutos := strProdutos + ', ' + cdsItens.FieldByName('ITE_CODMAR').AsString;

    cdsItens.Next;
  End;

  qryMarcas := fCriaQuery;
  Try
    qryMarcas.Close;
    qryMarcas.SQL.Clear;
    qryMarcas.SQL.Add('SELECT MAR_CODMAR, MAR_DESMAR FROM CADMAR INNER JOIN CADITE ON MAR_CODMAR = ITE_CODMAR WHERE MAR_CODMAR IN (' + strProdutos + ') GROUP BY MAR_CODMAR');
    qryMarcas.Open;

    qryMarcas.First;
    While Not qryMarcas.Eof Do
    Begin
      cdsMarcas.Append;
      cdsMarcas.FieldByName('CODMAR').AsString  := qryMarcas.FieldByName('MAR_CODMAR').AsString;
      cdsMarcas.FieldByName('DESMAR').AsString  := qryMarcas.FieldByName('MAR_DESMAR').AsString;
      cdsMarcas.FieldByName('SELECAO').AsString := 'N';
      cdsMarcas.Post;

      qryMarcas.Next;
    End;
  Finally
    FreeAndNil(qryMarcas);
  End;
end;

procedure TfrmFatDigDescontoPorMarca.pAfterScroll(DataSet: TDataSet);
begin
  iIndex := cdsMarcas.recNo;
end;

procedure TfrmFatDigDescontoPorMarca.pAlternarMarcacao;
begin
  If Not Assigned(cdsMarcas) Then
    Exit;

  If cdsMarcas.IsEmpty Then
    Exit;

  If (cdsMarcas.FieldByName('SELECAO').AsString.Equals('N')) Then
    pMarcar
  Else
    pDesmarcar;
end;

procedure TfrmFatDigDescontoPorMarca.pBeforePost(DataSet: TDataSet);
begin
  If fEmptyStr(cdsMarcas.FieldByName('CODMAR').AsString) Then
  Begin
    cdsMarcas.Cancel;
    Abort;
  End;

  If (cdsMarcas.FieldByName('DESCON').AsFloat > 100) Or (cdsMarcas.FieldByName('DESCON').AsFloat < 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Valor desconto incorreto!', ['&O k']);
    cdsMarcas.Cancel;
    Abort;
  End
end;

procedure TfrmFatDigDescontoPorMarca.pDesmarcar;
begin
  If Not Assigned(cdsMarcas) Then
    Exit;

  If cdsMarcas.IsEmpty Then
    Exit;

  cdsMarcas.Edit;
  cdsMarcas.FieldByName('SELECAO').AsString := 'N';
  cdsMarcas.Post;
end;

procedure TfrmFatDigDescontoPorMarca.pDesmarcarTodos;
  Var
    LPosicao: TBookmark;
begin
  If cdsMarcas.isEmpty Then
    Exit;

  cdsMarcas.DisableControls;
  LPosicao := cdsMarcas.GetBookmark;
  Try
    cdsMarcas.First;
    While Not cdsMarcas.eof Do
    Begin
      pDesmarcar;

      cdsMarcas.Next;
    End;

  Finally
    If cdsMarcas.BookmarkValid(LPosicao) Then
      cdsMarcas.GotoBookmark(LPosicao);

    cdsMarcas.EnableControls;
  End;
end;

procedure TfrmFatDigDescontoPorMarca.pMarcar;
begin
  If Not Assigned(cdsMarcas) Then
    Exit;

  If cdsMarcas.IsEmpty Then
    Exit;

  cdsMarcas.Edit;
  cdsMarcas.FieldByName('SELECAO').AsString := 'S';
  cdsMarcas.Post;
end;

procedure TfrmFatDigDescontoPorMarca.pMarcarTodos;
  Var
    LPosicao: TBookmark;
begin
  If cdsMarcas.IsEmpty Then
    Exit;

  cdsMarcas.DisableControls;
  LPosicao := cdsMarcas.GetBookmark;
  Try
    pDesmarcarTodos;
    cdsMarcas.First;
    While Not cdsMarcas.eof Do
    Begin
      pMarcar;

      cdsMarcas.Next;
    End;
  Finally
    If cdsMarcas.BookmarkValid(LPosicao) Then
      cdsMarcas.GotoBookmark(LPosicao);

    cdsMarcas.EnableControls;
  End;
end;

end.
