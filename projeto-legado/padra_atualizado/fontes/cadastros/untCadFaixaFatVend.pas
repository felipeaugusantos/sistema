unit untCadFaixaFatVend;

interface

uses
  Windows, Classes, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls, Buttons,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Uni,
  untComFatVend, BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess,
  StdCtrls, Controls, cxDataControllerConditionalFormattingRulesManagerDialog,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFaixaFatVend = class(TfrmPaiSimples)
    pnl1: TPanel;
    gridCadOpeDBTableView1: TcxGridDBTableView;
    gridCadOpeLevel1: TcxGridLevel;
    gridCadOpe: TcxGrid;
    gridDadosDBTableOPE_CODOPE: TcxGridDBColumn;
    gridDadosDBTableOPE_NOMOPE: TcxGridDBColumn;
    gridDadosDBTableOPE_SALFIX: TcxGridDBColumn;
    gridDadosDBTableOPE_CODFAV: TcxGridDBColumn;
    gridDadosDBTableOPE_PERADI: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    qryCadOpe: TUniQuery;
    dtsCadOpe: TDataSource;
    gridCadOpeDBTableOPE_INTEXT: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure gridCadOpeDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridCadOpeDBTableView1KeyPress(Sender: TObject; var Key: Char);
    procedure gridCadOpeDBTableView1EditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure gridCadOpeDBTableView1EditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
  private
    { Private declarations }
    objComFat: TComFatVend;
    procedure pAfterOpen(DataSet: TDataSet);
    function fExisteCodFaixa(strCodTab: String): String;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

function TfrmCadFaixaFatVend.fExisteCodFaixa(strCodTab: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  COM_CODTAB ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  COMFAV ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  COM_CODTAB = :CODTAB ';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODTAB').AsString := fStrZero(strCodTab, 6);
      Open;
      Result := Fields[0].AsString;
      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadFaixaFatVend.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objComFat);
end;

procedure TfrmCadFaixaFatVend.FormCreate(Sender: TObject);
begin
  objComFat := TComFatVend.Create(Self);
  inherited;
end;

procedure TfrmCadFaixaFatVend.FormShow(Sender: TObject);
begin
  inherited;
  With qryCadOpe Do
  Begin
    AfterOpen := pAfterOpen;
    Close;
    SQL.Text  := objComFat.fRetSQLCadOpe;
    Open;
  End;

  pSetFocus(gridCadOpe);
end;

procedure TfrmCadFaixaFatVend.gridCadOpeDBTableView1EditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
  Var
    strCodTab: String;
begin
  inherited;
  Case Key Of

    VK_RETURN:
    Begin
      If gridDadosDBTableOPE_SALFIX.Focused Then
      Begin
        If (qryCadOpe.State in [dsInsert, dsEdit]) Then
          qryCadOpe.Post;
        If (qryCadOpe.FieldByName('OPE_SALFIX').AsFloat < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Salário Fixo deve ser maior ou igual a zero!', ['&Ok']);
          qryCadOpe.Edit;
          qryCadOpe.FieldByName('OPE_SALFIX').AsFloat := 0;
          qryCadOpe.Post;
        End;
      End
      Else If gridDadosDBTableOPE_CODFAV.Focused Then
      Begin
        If (qryCadOpe.State in [dsInsert, dsEdit]) Then
          qryCadOpe.Post;

        if fEmptyStr(qryCadOpe.FieldByName('OPE_CODFAV').AsString) then
          Exit;

        strCodTab := fExisteCodFaixa(qryCadOpe.FieldByName('OPE_CODFAV').AsString);
        If (strCodTab = '') Then
        Begin
          fMensagem('ATENÇÃO!', 'Não existe uma Faixa de Faturamento com este Código!', ['&Ok']);
          qryCadOpe.Edit;
          qryCadOpe.FieldByName('OPE_CODFAV').AsString := '';
          qryCadOpe.Post;
        End
        Else
        Begin
          qryCadOpe.Edit;
          qryCadOpe.FieldByName('OPE_CODFAV').AsString := strCodTab;
          qryCadOpe.Post;
        End;
      End
      Else If gridDadosDBTableOPE_PERADI.Focused Then
      Begin
        If (qryCadOpe.State in [dsInsert, dsEdit]) Then
          qryCadOpe.Post;
        If (qryCadOpe.FieldByName('OPE_PERADI').AsFloat < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O % Adicional deve ser maior ou igual a zero!', ['&Ok']);
          qryCadOpe.Edit;
          qryCadOpe.FieldByName('OPE_PERADI').AsFloat := 0;
          qryCadOpe.Post;
        End;
      End;
    End;

  End;
end;

procedure TfrmCadFaixaFatVend.gridCadOpeDBTableView1EditKeyPress(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If gridDadosDBTableOPE_CODFAV.Focused Then
  Begin
    If (Key = '/') Then
    Begin
      qryTabela := fCriaQuery(Nil);
      If fPesqComissaoFatVend(conSimples,
                              Self,
                              nil,
                              nil,
                              qryTabela,
                              Key,
                              arrsel) Then
      Begin
        qryCadOpe.Edit;
        qryCadOpe.FieldByName('OPE_CODFAV').AsString := qryTabela.FieldByName('COM_CODTAB').AsString;
        qryCadOpe.Post;
        Key := #0;
      End;
      FreeAndNil(qryTabela);
    End;
  End;
end;

procedure TfrmCadFaixaFatVend.gridCadOpeDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of

    VK_Escape: btnSair.Click;

  End;
end;

procedure TfrmCadFaixaFatVend.gridCadOpeDBTableView1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If gridDadosDBTableOPE_CODFAV.Focused Then
  Begin
    If (Key = '/') Then
    Begin
      qryTabela := fCriaQuery(Nil);
      If fPesqComissaoFatVend(conSimples,
                              Self,
                              nil,
                              nil,
                              qryTabela,
                              Key,
                              arrsel) Then
      Begin
        qryCadOpe.Edit;
        qryCadOpe.FieldByName('OPE_CODFAV').AsString := qryTabela.FieldByName('COM_CODTAB').AsString;
        qryCadOpe.Post;
        Key := #0;
      End;
      FreeAndNil(qryTabela);
    End;
  End;
end;

procedure TfrmCadFaixaFatVend.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TFloatField(FieldByName('OPE_SALFIX')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('OPE_PERADI')).DisplayFormat := '#,##0.00';
  End;
end;

end.
