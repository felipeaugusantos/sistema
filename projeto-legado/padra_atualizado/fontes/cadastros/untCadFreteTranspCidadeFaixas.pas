unit untCadFreteTranspCidadeFaixas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, UniClientDataSet, System.Types, System.Math;

type
  TfrmCadFreteTranspCidadeFaixas = class(TfrmPaiConfirma)
    cxgFaixasTableView: TcxGridDBTableViewCitel;
    cxgFaixasLevel: TcxGridLevel;
    cxgFaixas: TcxGridCitel;
    dtsFaixas: TDataSource;
    Panel2: TPanel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    cxgFaixasTableViewFATINI: TcxGridDBColumn;
    cxgFaixasTableViewFATFIN: TcxGridDBColumn;
    cxgFaixasTableViewPERDES: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dtsFaixasStateChange(Sender: TObject);
    procedure cdsFaixasBeforePost(DataSet: TDataSet);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgFaixasTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgFaixasTableViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function fValidaFaixas(Out strMensagem: String): Boolean;
    function fValidaItem(Out strMensagem: String): Boolean;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadFreteTranspCidadeFaixas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If Not dtsFaixas.DataSet.IsEmpty Then
  Begin
    dtsFaixas.DataSet.Edit;
    pSetFocus(cxgFaixas);
  End;
end;

procedure TfrmCadFreteTranspCidadeFaixas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dtsFaixas.DataSet.Cancel;
end;

procedure TfrmCadFreteTranspCidadeFaixas.btnConfirmaClick(Sender: TObject);
  Var
    strMensagem: String;
begin
  If dtsFaixas.DataSet.State In [dsInsert, dsEdit] Then
    dtsFaixas.DataSet.Post;

  If Not fValidaFaixas(strMensagem) Then
  Begin
    pMensagemOk(strMensagem);
    Exit;
  End;

  inherited;
end;

procedure TfrmCadFreteTranspCidadeFaixas.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If Not dtsFaixas.DataSet.IsEmpty Then
    dtsFaixas.DataSet.Delete;
end;

procedure TfrmCadFreteTranspCidadeFaixas.btnGravarClick(Sender: TObject);
begin
  inherited;
  dtsFaixas.DataSet.Post;
end;

procedure TfrmCadFreteTranspCidadeFaixas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dtsFaixas.DataSet.Append;
  pSetFocus(cxgFaixas);
  cxgFaixasTableViewFATINI.FocusWithSelection;
end;

procedure TfrmCadFreteTranspCidadeFaixas.cdsFaixasBeforePost(DataSet: TDataSet);
begin
  If DataSet.FieldByName('FAI_FATINI').IsNull Then
    DataSet.FieldByName('FAI_FATINI').AsFloat := 0;

  If DataSet.FieldByName('FAI_FATFIN').IsNull Then
    DataSet.FieldByName('FAI_FATFIN').AsFloat := 0;

  If DataSet.FieldByName('FAI_PERDES').IsNull Then
    DataSet.FieldByName('FAI_PERDES').AsFloat := 0;
end;

procedure TfrmCadFreteTranspCidadeFaixas.cxgFaixasTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cxgFaixasTableViewKeyDown(Sender, Key, Shift);
end;

procedure TfrmCadFreteTranspCidadeFaixas.cxgFaixasTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    If cxgFaixasTableView.Controller.FocusedColumnIndex = cxgFaixasTableView.ColumnCount -1 Then
    Begin
      If cxgFaixasTableView.Controller.FocusedRowIndex = cxgFaixasTableView.ViewData.RowCount -1 Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadFreteTranspCidadeFaixas.dtsFaixasStateChange(Sender: TObject);
begin
  inherited;
  btnIncluir.Enabled := dtsFaixas.State = dsBrowse;
  btnAlterar.Enabled := dtsFaixas.State = dsBrowse;
  btnExcluir.Enabled := dtsFaixas.State = dsBrowse;
  btnGravar.Enabled  := dtsFaixas.State In [dsInsert, dsEdit];
  btnCancela.Enabled := dtsFaixas.State In [dsInsert, dsEdit];
end;

procedure TfrmCadFreteTranspCidadeFaixas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dtsFaixas.DataSet.BeforePost := Nil;
end;

procedure TfrmCadFreteTranspCidadeFaixas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If ModalResult = mrCancel Then
    CanClose := fPergunta('Deseja realmente cancelar?');
end;

procedure TfrmCadFreteTranspCidadeFaixas.FormShow(Sender: TObject);
begin
  inherited;
  dtsFaixas.DataSet.BeforePost := cdsFaixasBeforePost;

  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_FATINI')).DisplayFormat := ',#0.00';
  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_FATFIN')).DisplayFormat := ',#0.00';
  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_PERDES')).DisplayFormat := ',#0.00%';

  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_FATINI')).EditFormat := '#0.00';
  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_FATFIN')).EditFormat := '#0.00';
  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_PERDES')).EditFormat := '#0.00';

  dtsFaixas.DataSet.First;
end;

function TfrmCadFreteTranspCidadeFaixas.fValidaFaixas(Out strMensagem: String): Boolean;
  Var
    cdsClone: TUniClientDataSet;
begin
  Result := True;
  cdsClone := TUniClientDataSet.Create(Nil);
  cdsClone.Data := TUniClientDataSet(dtsFaixas.DataSet).Data;
  cdsClone.IndexFieldNames := 'FAI_FATFIN';

  dtsFaixas.DataSet.DisableControls;
  Try
    dtsFaixas.DataSet.First;
    While Not dtsFaixas.DataSet.Eof Do
    Begin
      If Not fValidaItem(strMensagem) Then
      Begin
        Result := False;
        Break;
      End;

      cdsClone.SetRange([dtsFaixas.DataSet.FieldByName('FAI_FATINI').AsFloat],[dtsFaixas.DataSet.FieldByName('FAI_FATFIN').AsFloat]);

      If cdsClone.RecordCount > 1 Then
      Begin
        strMensagem := 'O valor informado já está sendo utilizado em outra faixa. Favor verificar!';
        Result := False;
        Break;
      End;

      dtsFaixas.DataSet.Next;
    End;
  Finally
    dtsFaixas.DataSet.EnableControls;
    FreeAndNil(cdsClone);
  End;
end;

function TfrmCadFreteTranspCidadeFaixas.fValidaItem(Out strMensagem: String): Boolean;
begin
  strMensagem := '';

  If dtsFaixas.DataSet.FieldByName('FAI_FATINI').AsFloat < 0 Then
  Begin
    strMensagem := 'O Faturamento inicial não pode ser menor que zero!';
    Exit(False);
  End;

  If dtsFaixas.DataSet.FieldByName('FAI_FATFIN').AsFloat < 0 Then
  Begin
    strMensagem := 'O Faturamento final não pode ser menor que zero!';
    Exit(False);
  End;

  If CompareValue(dtsFaixas.DataSet.FieldByName('FAI_FATFIN').AsFloat,
                  dtsFaixas.DataSet.FieldByName('FAI_FATINI').AsFloat) = LessThanValue Then
  Begin
    strMensagem := 'O Faturamento final não pode ser menor que o Faturamento inicial!';
    Exit(False);
  End;

  If dtsFaixas.DataSet.FieldByName('FAI_PERDES').AsFloat < 0 Then
  Begin
    strMensagem := 'O Desconto não pode ser menor que zero!';
    Exit(False);
  End;

  If dtsFaixas.DataSet.FieldByName('FAI_PERDES').AsFloat > 100 Then
  Begin
    strMensagem := 'O Desconto não pode ser maior que 100!';
    Exit(False);
  End;

  Result := True;
end;

end.
