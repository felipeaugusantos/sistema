unit untCadFreteTranspCidadeFaixasPeso;

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
  TfrmCadFreteTranspCidadeFaixasPeso = class(TfrmPaiConfirma)
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
    cxgFaixasTableViewPESINI: TcxGridDBColumn;
    cxgFaixasTableViewPESFIN: TcxGridDBColumn;
    cxgFaixasTableViewVALFRE: TcxGridDBColumn;
    lblValorKilo: TLabel;
    dbeValKil: TDBEditFocus;
    Label1: TLabel;
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

procedure TfrmCadFreteTranspCidadeFaixasPeso.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If Not dtsFaixas.DataSet.IsEmpty Then
  Begin
    dtsFaixas.DataSet.Edit;
    pSetFocus(cxgFaixas);
    dbeValKil.Enabled := False;
  End;
end;

procedure TfrmCadFreteTranspCidadeFaixasPeso.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dtsFaixas.DataSet.Cancel;
  dbeValKil.Enabled := True;
end;

procedure TfrmCadFreteTranspCidadeFaixasPeso.btnConfirmaClick(Sender: TObject);
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

procedure TfrmCadFreteTranspCidadeFaixasPeso.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If Not dtsFaixas.DataSet.IsEmpty Then
    dtsFaixas.DataSet.Delete;
end;

procedure TfrmCadFreteTranspCidadeFaixasPeso.btnGravarClick(Sender: TObject);
begin
  inherited;
  dtsFaixas.DataSet.Post;
  dbeValKil.Enabled := True;
end;

procedure TfrmCadFreteTranspCidadeFaixasPeso.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dtsFaixas.DataSet.Append;
  pSetFocus(cxgFaixas);
  cxgFaixasTableViewPESINI.FocusWithSelection;
  dbeValKil.Enabled := False;
end;

procedure TfrmCadFreteTranspCidadeFaixasPeso.cdsFaixasBeforePost(DataSet: TDataSet);
begin
  If DataSet.FieldByName('FAI_PESINI').IsNull Then
    DataSet.FieldByName('FAI_PESINI').AsFloat := 0;

  If DataSet.FieldByName('FAI_PESFIN').IsNull Then
    DataSet.FieldByName('FAI_PESFIN').AsFloat := 0;

  If DataSet.FieldByName('FAI_VALFRE').IsNull Then
    DataSet.FieldByName('FAI_VALFRE').AsFloat := 0;
end;

procedure TfrmCadFreteTranspCidadeFaixasPeso.cxgFaixasTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cxgFaixasTableViewKeyDown(Sender, Key, Shift);
end;

procedure TfrmCadFreteTranspCidadeFaixasPeso.cxgFaixasTableViewKeyDown(
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

procedure TfrmCadFreteTranspCidadeFaixasPeso.dtsFaixasStateChange(Sender: TObject);
begin
  inherited;
  btnIncluir.Enabled := dtsFaixas.State = dsBrowse;
  btnAlterar.Enabled := dtsFaixas.State = dsBrowse;
  btnExcluir.Enabled := dtsFaixas.State = dsBrowse;
  btnGravar.Enabled  := dtsFaixas.State In [dsInsert, dsEdit];
  btnCancela.Enabled := dtsFaixas.State In [dsInsert, dsEdit];
end;

procedure TfrmCadFreteTranspCidadeFaixasPeso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dtsFaixas.DataSet.BeforePost := Nil;
end;

procedure TfrmCadFreteTranspCidadeFaixasPeso.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If ModalResult = mrCancel Then
    CanClose := fPergunta('Deseja realmente cancelar?');
end;

procedure TfrmCadFreteTranspCidadeFaixasPeso.FormShow(Sender: TObject);
begin
  inherited;
  dtsFaixas.DataSet.BeforePost := cdsFaixasBeforePost;

  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_PESINI')).DisplayFormat := ',#0.00';
  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_PESFIN')).DisplayFormat := ',#0.00';
  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_VALFRE')).DisplayFormat := ',#0.0000';

  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_PESINI')).EditFormat := '#0.00';
  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_PESFIN')).EditFormat := '#0.00';
  TFloatField(dtsFaixas.DataSet.FieldByName('FAI_VALFRE')).EditFormat := '#0.0000';

  dtsFaixas.DataSet.First;

  pSetFocus(dbeValKil);
end;

function TfrmCadFreteTranspCidadeFaixasPeso.fValidaFaixas(Out strMensagem: String): Boolean;
  Var
    cdsClone: TUniClientDataSet;
begin
  Result := True;
  cdsClone := TUniClientDataSet.Create(Nil);
  cdsClone.Data := TUniClientDataSet(dtsFaixas.DataSet).Data;
  cdsClone.IndexFieldNames := 'FAI_PESFIN';

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

      cdsClone.SetRange([dtsFaixas.DataSet.FieldByName('FAI_PESINI').AsFloat],[dtsFaixas.DataSet.FieldByName('FAI_PESFIN').AsFloat]);

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

function TfrmCadFreteTranspCidadeFaixasPeso.fValidaItem(Out strMensagem: String): Boolean;
begin
  strMensagem := '';

  If dtsFaixas.DataSet.FieldByName('FAI_PESINI').AsFloat < 0 Then
  Begin
    strMensagem := 'O peso inicial não pode ser menor que zero!';
    Exit(False);
  End;

  If dtsFaixas.DataSet.FieldByName('FAI_PESFIN').AsFloat < 0 Then
  Begin
    strMensagem := 'O peso final não pode ser menor que zero!';
    Exit(False);
  End;

  If CompareValue(dtsFaixas.DataSet.FieldByName('FAI_PESFIN').AsFloat,
                  dtsFaixas.DataSet.FieldByName('FAI_PESINI').AsFloat) = LessThanValue Then
  Begin
    strMensagem := 'O peso final não pode ser menor que o peso inicial!';
    Exit(False);
  End;

  If dtsFaixas.DataSet.FieldByName('FAI_VALFRE').AsFloat < 0 Then
  Begin
    strMensagem := 'O valor do quilo não pode ser menor que zero!';
    Exit(False);
  End;

  Result := True;
end;

end.
