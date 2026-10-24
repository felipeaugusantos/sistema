unit untSelecionaEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, Uni, Grids, DBGrids, MemDS, DBAccess,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, cxCheckBox, Datasnap.DBClient,
  UniClientDataSet, untFuncoesSimples, BitBtnLockedIncrem;

type
  TfrmSelecionaEmpresa = class(TForm)
    dtsEmpresa: TDataSource;
    pnlBotoes: TPanel;
    btnSair: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    dbGrdEmpresa_DBTableView1: TcxGridDBTableView;
    dbGrdEmpresa_Level1: TcxGridLevel;
    dbGrdEmpresa_: TcxGrid;
    dbGrdEmpresa_DBTableView1Empresa: TcxGridDBColumn;
    dbGrdEmpresa_DBTableView1Nome: TcxGridDBColumn;
    dbGrdEmpresa_DBTableView1Selecao: TcxGridDBColumn;
    cdsEmpresa: TUniClientDataSet;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure DbGrdEmpresaDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbGrdEmpresa_DBTableView1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cdsEmpresaAfterPost(DataSet: TDataSet);
    procedure dbGrdEmpresa_DBTableView1SelecaoPropertiesEditValueChanged(
      Sender: TObject);
  private
    FCodEmpresa: String;
    FstrCNPJ: String;
    FRecuperaEmpresaLogada: Boolean;
    FPermitirMultiSelecao: Boolean;
  published
    property strCodEmpresa: String read FCodEmpresa write FCodEmpresa;
    property strCNPJ: String read FstrCNPJ write FstrCNPJ;
  public
    property blnRecuperaEmpresaLogada: Boolean read FRecuperaEmpresaLogada write FRecuperaEmpresaLogada;
    property blnPermitirMultiSelecao: Boolean read FPermitirMultiSelecao write FPermitirMultiSelecao;
  end;

var
  frmSelecionaEmpresa: TfrmSelecionaEmpresa;

implementation

uses untFuncoes;

{$R *.dfm}

procedure TfrmSelecionaEmpresa.btnConfirmaClick(Sender: TObject);
//  Var
//    intContador: Integer;
begin
  FCodEmpresa := '';
  cdsEmpresa.First;
  If strCNPJ <> '' Then
  Begin
    cdsEmpresa.Filtered := False;
    cdsEmpresa.Filter := 'SELECAO = ' + QuotedStr('S');
    cdsEmpresa.Filtered := True;
    If cdsEmpresa.RecordCount > 1 Then
    Begin
      pMensagemOk('Apenas uma empresa deve ser selecionada.');
      cdsEmpresa.Filtered := False;
      Exit;
    End
    Else If cdsEmpresa.IsEmpty Then
    Begin
      pMensagemOk('A empresa deve ser selecionada.');
      cdsEmpresa.Filtered := False;
      Exit;
    End
    Else
    Begin
      FCodEmpresa := cdsEmpresa.FieldByName('EMP_CODEMP').AsString;
      Close;
    End
  End
  Else
  Begin

    cdsEmpresa.First;

    while Not cdsEmpresa.Eof do
    begin
      if cdsEmpresa.FieldByName('SELECAO').AsString = 'S' then
        FCodEmpresa := FCodEmpresa + cdsEmpresa.FieldByName('EMP_CODEMP').AsString + '_';
      cdsEmpresa.Next;
    end;

    Close;
  End;
end;

procedure TfrmSelecionaEmpresa.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSelecionaEmpresa.cdsEmpresaAfterPost(DataSet: TDataSet);
var
  intRecNo: Integer;
  strEmpCd: String;
begin
  intRecNo := cdsEmpresa.RecNo;
  strEmpCd := QuotedStr(cdsEmpresa.FieldByName('EMP_CODEMP').AsString);
  cdsEmpresa.Filter := 'SELECAO = ''S'' AND EMP_CODEMP <> ' + strEmpCd;
  cdsEmpresa.Filtered := True;
  cdsEmpresa.First;
  While Not cdsEmpresa.Eof Do
  Begin
    cdsEmpresa.Edit;
    cdsEmpresa.FieldByName('SELECAO').AsString := 'N';
    cdsEmpresa.Post;
    cdsEmpresa.Next;
  End;

  cdsEmpresa.Filtered := False;
  cdsEmpresa.RecNo := intRecNo;
  cdsEmpresa.IndexFieldNames := 'EMP_CODEMP';
end;

procedure TfrmSelecionaEmpresa.DbGrdEmpresaDblClick(Sender: TObject);
begin
  btnConfirmaClick(Sender);
end;

procedure TfrmSelecionaEmpresa.dbGrdEmpresa_DBTableView1KeyPress(
  Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
    btnConfirmaClick(Sender);
  If (Key = #27) Then
    btnSairClick(Sender);
end;

procedure TfrmSelecionaEmpresa.dbGrdEmpresa_DBTableView1SelecaoPropertiesEditValueChanged(
  Sender: TObject);
begin
  If Not blnPermitirMultiSelecao Then
    cdsEmpresaAfterPost(cdsEmpresa);
end;

procedure TfrmSelecionaEmpresa.FormCreate(Sender: TObject);
begin
  blnPermitirMultiSelecao := True;
end;

procedure TfrmSelecionaEmpresa.FormShow(Sender: TObject);
var
  qryEmpresa: TUniQuery;
  fldNovoFiled: TFieldDef;
begin
  qryEmpresa := fCriaQuery(Nil);
  dtsEmpresa.DataSet := cdsEmpresa;
  dbGrdEmpresa_DBTableView1.DataController.DataSource := dtsEmpresa;

  qryEmpresa.Close;
  If strCNPJ <> '' Then
  Begin
    qryEmpresa.SQL.Clear;
    qryEmpresa.SQL.Add('SELECT ');
    qryEmpresa.SQL.Add('  CADEMP.*, "F" AS SELECAO');
    qryEmpresa.SQL.Add('FROM');
    qryEmpresa.SQL.Add('  CADEMP');
    qryEmpresa.SQL.Add('  WHERE CADEMP.EMP_C_G_C_ = "'+strCNPJ+'"');
    qryEmpresa.SQL.Add('ORDER BY EMP_CODEMP');
    qryEmpresa.Open;
  End
  Else
  Begin
    qryEmpresa.SQL.Text := ' SELECT CADEMP.*, "F" AS SELECAO '
                         + '   FROM CADEMP '
                         + IIF(FRecuperaEmpresaLogada, ' WHERE EMP_CODEMP <> ' + QuotedStr(VS_strCodEmp), '')
                         + ' ORDER BY EMP_CODEMP ';
    qryEmpresa.Open;
  End;

  fldNovoFiled := cdsEmpresa.FieldDefs.AddFieldDef;
  fldNovoFiled.DataType := ftString;
  fldNovoFiled.Name := 'EMP_CODEMP';
  fldNovoFiled.Size := 3;

  fldNovoFiled := cdsEmpresa.FieldDefs.AddFieldDef;
  fldNovoFiled.DataType := ftString;
  fldNovoFiled.Name := 'EMP_NOMEMP';
  fldNovoFiled.Size := 60;

  fldNovoFiled := cdsEmpresa.FieldDefs.AddFieldDef;
  fldNovoFiled.DataType := ftString;
  fldNovoFiled.Name := 'SELECAO';
  fldNovoFiled.Size := 1;

  cdsEmpresa.CreateDataSet;

  cdsEmpresa.Open;

  qryEmpresa.First;
  while not qryEmpresa.Eof do
  begin
    cdsEmpresa.Append;
    cdsEmpresa.FieldByName('EMP_CODEMP').AsString := qryEmpresa.FieldByName('EMP_CODEMP').AsString;
    cdsEmpresa.FieldByName('EMP_NOMEMP').AsString := qryEmpresa.FieldByName('EMP_NOMEMP').AsString;

    if Pos(qryEmpresa.FieldByName('EMP_CODEMP').AsString, FCodEmpresa) > 0 then
      cdsEmpresa.FieldByName('SELECAO').AsString := 'S'
    else
      cdsEmpresa.FieldByName('SELECAO').AsString := 'N';

    cdsEmpresa.Post;
    qryEmpresa.Next;
  end;

  FreeAndNil(qryEmpresa);

end;

end.
