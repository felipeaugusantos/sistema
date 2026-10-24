unit untRelacaoEmbalagens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridCitel,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, UniClientDataSet, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRelacaoEmbalagens = class(TfrmPaiConfirma)
    cxProdutos: TcxGridCitel;
    cxProdutosDBTableView1: TcxGridDBTableViewCitel;
    cxProdutosCODBAR: TcxGridDBColumn;
    cxProdutosQTDITE: TcxGridDBColumn;
    cxProdutosPREVEN: TcxGridDBColumn;
    cxProdutosDESEMB: TcxGridDBColumn;
    cxProdutosLevel1: TcxGridLevel;
    pnlTopo: TPanel;
    lblProduto: TLabel;
    Label1: TLabel;
    dsProdutos: TDataSource;
    cxProdutosTABPRE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxProdutosDBTableView1DblClick(Sender: TObject);
    procedure cxProdutosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pCriaClient;
  public
    { Public declarations }
    strCodIte: String;
    cdsProdutos: TUniClientDataSet;

    procedure pCarregaProdutos;
  end;

var
  frmRelacaoEmbalagens: TfrmRelacaoEmbalagens;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmRelacaoEmbalagens.cxProdutosDBTableView1DblClick(Sender: TObject);
begin
  inherited;

  ModalResult := mrOk;
end;

procedure TfrmRelacaoEmbalagens.cxProdutosDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_RETURN Then
    ModalResult := mrOk;
end;

procedure TfrmRelacaoEmbalagens.FormCreate(Sender: TObject);
begin
  inherited;

  pCriaClient;

  cxProdutosPREVEN.Visible := fCfgSis('PRVEMB', VarBoolean);
  cxProdutosDESEMB.Visible := fCfgSis('PRVEMB', VarBoolean);

  If cxProdutosPREVEN.Visible Then
  Begin
    cxProdutosPREVEN.Visible := fCfgSis('PREEMB', VarString) = '1';
    cxProdutosTABPRE.Visible := fCfgSis('PREEMB', VarString) = '2';
  End;
end;

procedure TfrmRelacaoEmbalagens.FormShow(Sender: TObject);
begin
  inherited;

  lblProduto.Caption := 'Embalagens do Produto - ' + strCodIte + '-' + fRetNomProduto(strCodIte);
  cdsProdutos.First;
end;

procedure TfrmRelacaoEmbalagens.pCarregaProdutos;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   *    ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ITEBAR ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   BAR_CODITE = :CODITE ';

  If fCfgSis('PRVEMB', VarBoolean) And  (fCfgSis('PREEMB', VarString) = '1') Then
    strSQL := strSQL + ' AND COALESCE(BAR_PREVEN, 0) > 0 '
  Else If fCfgSis('PRVEMB', VarBoolean) And  (fCfgSis('PREEMB', VarString) = '2') Then
    strSQL := strSQL + ' AND COALESCE(BAR_TABPRE, "") <> "" ';

  strSQL := strSQL + ' AND BAR_EXBFAT = "S"                ';

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    If Not IsEmpty Then
    Begin
      First;

      While Not Eof Do
      Begin
        cdsProdutos.Append;
        cdsProdutos.FieldByName('CODITE').AsString := strCodIte;
        cdsProdutos.FieldByName('CODBAR').AsString := FieldByName('BAR_CODBAR').AsString;
        cdsProdutos.FieldByName('QTDITE').AsFloat  := FieldByName('BAR_EMBALA').AsFloat;
        cdsProdutos.FieldByName('PREVEN').AsFloat  := FieldByName('BAR_PREVEN').AsFloat;
        cdsProdutos.FieldByName('DESEMB').AsString := FieldByName('BAR_DESCRI').AsString;
        cdsProdutos.FieldByName('TABPRE').AsString := FieldByName('BAR_TABPRE').AsString;
        cdsProdutos.Post;

        Next;
      End;
    End;

    FreeAndNil(qryTmp);

    TFloatField(cdsProdutos.FieldByName('QTDITE')).DisplayFormat := '#,##0.00';
    TFloatField(cdsProdutos.FieldByName('PREVEN')).DisplayFormat := '#,##0.00';

    dsProdutos.DataSet := cdsProdutos;
  End;
end;

procedure TfrmRelacaoEmbalagens.pCriaClient;
begin
  cdsProdutos := TUniClientDataSet.Create(nil);

  With cdsProdutos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODITE';
    DataType := ftString;
    Size     := fTamCodIte;
  End;

  With cdsProdutos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TABPRE';
    DataType := ftString;
    Size     := 1;
  End;

  With cdsProdutos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODBAR';
    DataType := ftString;
    Size     := 13;

    If fCfgSis('TIPBAR', varString) = '2' Then
      Size:= 43;
  End;

  With cdsProdutos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'QTDITE';
    DataType := ftFloat;
  End;

  With cdsProdutos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PREVEN';
    DataType := ftFloat;
  End;

  With cdsProdutos.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESEMB';
    DataType := ftString;
    Size     := 70;
  End;

  cdsProdutos.CreateDataSet;
  cdsProdutos.EmptyDataSet;
end;

end.
