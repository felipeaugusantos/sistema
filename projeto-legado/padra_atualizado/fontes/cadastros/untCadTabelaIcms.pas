unit untCadTabelaIcms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient, UniClientDataSet,
  Datasnap.Provider, UniDataSetProvider, cxCurrencyEdit, Uni;

type
  TfrmCadTabelaIcms = class(TfrmPaiEdit)
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cdsTabela: TUniClientDataSet;
    dtsTabela: TDataSource;
    cdsTabelaUFS_ESTADO: TStringField;
    cdsTabelaUFS_ALQICM: TFloatField;
    cxGridDBTableViewUFS_ESTADO: TcxGridDBColumn;
    cxGridDBTableViewUFS_ALQICM: TcxGridDBColumn;
    btnAlterar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure cdsTabelaBeforePost(DataSet: TDataSet);
  private
    procedure pAlteraCadastro(blnHabilita: Boolean);
    procedure pCarregaTabelaIcms;
    procedure pCadastraTabelaIcms;
    procedure pDeletaTabelaIcms;
    function fGravaTabelaIcms: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadTabelaIcms: TfrmCadTabelaIcms;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadTabelaIcms.FormCreate(Sender: TObject);
begin
  inherited;

  pAlteraCadastro(False);

  cdsTabela.CreateDataSet;

  dtsTabela.DataSet := cdsTabela;

  cxGridDBTableView.DataController.DataSource := dtsTabela;
end;

procedure TfrmCadTabelaIcms.cdsTabelaBeforePost(DataSet: TDataSet);
begin
  inherited;

  If (cdsTabela.state = dsEdit) Then
  Begin
    If (cdsTabela.FieldByName('UFS_ALQICM').AsFloat < 0) Or  (cdsTabela.FieldByName('UFS_ALQICM').AsFloat > 100) Then
    Begin
      fMensagem('', 'Alíquota inválida, verifique!', ['&Ok']);
      cdsTabela.Cancel;
      Abort;
    End;
  End;

end;

procedure TfrmCadTabelaIcms.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaTabelaIcms;
end;

procedure TfrmCadTabelaIcms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If not btnAlterar.Enabled Then
  Begin
    If fMensagem('', 'Deseja cancelar a edição desse registro?', ['&Sim', '&Não']) = 2 Then
    Begin
      Action := caNone;
      Exit;
    End;
  End;

  inherited;

  If Assigned(cdsTabela) Then
    FreeAndNil(cdsTabela);
end;

procedure TfrmCadTabelaIcms.pCarregaTabelaIcms;
var
  qryTabelaIcms: TUniQuery;
begin

  cdsTabela.EmptyDataSet;

  qryTabelaIcms := fCriaQuery;

  Try
    qryTabelaIcms.Close;
    qryTabelaIcms.SQL.Clear;
    qryTabelaIcms.SQL.Add('SELECT * FROM CADUFS ORDER BY UFS_ESTADO ');
    qryTabelaIcms.Open;

    If qryTabelaIcms.RecordCount > 0 Then
    Begin
      cdsTabela.DisableControls;

      try
        While not qryTabelaIcms.Eof Do
        begin
          cdsTabela.Append;
          cdsTabela.FieldByName('UFS_ESTADO').AsString := qryTabelaIcms.FieldByName('UFS_ESTADO').AsString;
          cdsTabela.FieldByName('UFS_ALQICM').AsString := qryTabelaIcms.FieldByName('UFS_ALQICM').AsString;
          cdsTabela.Post;

          qryTabelaIcms.Next;
        end;

      finally
        cdsTabela.First;
        cdsTabela.EnableControls;
      end;

    End;
  Finally
    FreeAndNil(qryTabelaIcms);
  End;
end;

procedure TfrmCadTabelaIcms.pDeletaTabelaIcms;
var
  qryDelete: TUniQuery;
begin
  qryDelete := fCriaQuery(Nil);

  Try
    qryDelete.Close;
    qryDelete.SQL.Clear;
    qryDelete.SQL.Add(' DELETE FROM CADUFS ');
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
end;

procedure TfrmCadTabelaIcms.pCadastraTabelaIcms;
var
  qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery(Nil);

  If cdsTabela.State = dsEdit Then
    cdsTabela.Post;

  cdsTabela.DisableControls;
  cdsTabela.First;

  Try
    qryInsert.Sql.Text := 'SELECT * FROM CADUFS WHERE FALSE ';
    qryInsert.Open;

    While not cdsTabela.eof Do
    Begin
      qryInsert.Insert;
      qryInsert.FieldByName('UFS_ESTADO').AsString := cdsTabela.FieldByName('UFS_ESTADO').AsString;
      qryInsert.FieldByName('UFS_ALQICM').AsString := cdsTabela.FieldByName('UFS_ALQICM').AsString;
      qryInsert.Post;

      cdsTabela.Next;
    End;

  Finally
    FreeAndNil(qryInsert);
    cdsTabela.First;
    cdsTabela.EnableControls;
  End;
end;

function TfrmCadTabelaIcms.fGravaTabelaIcms: Boolean;
begin
  Result := True;

  fStartTransaction;

  Try
    pDeletaTabelaIcms;
    pCadastraTabelaIcms;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadTabelaIcms.fGravaTabelaIcms]');
    End;
  End;
end;

procedure TfrmCadTabelaIcms.pAlteraCadastro(blnHabilita: Boolean);
begin
  cxGrid.Enabled     := blnHabilita;
  btnGravar.Enabled  := blnHabilita;
  btnCancela.Enabled := blnHabilita;
  btnAlterar.Enabled := not blnHabilita;
end;

procedure TfrmCadTabelaIcms.btnAlterarClick(Sender: TObject);
begin
  inherited;
  cdsTabela.Edit;
  pAlteraCadastro(True);
  pSetFocus(cxGrid);
end;

procedure TfrmCadTabelaIcms.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pAlteraCadastro(False);
  pCarregaTabelaIcms;
end;

procedure TfrmCadTabelaIcms.btnGravarClick(Sender: TObject);
begin
  inherited;

  pAlteraCadastro(False);

  If fGravaTabelaIcms Then
    btnCancela.Click
  Else
    fMensagem('', 'Ocorreu um erro na gravação dos registros.', ['&Ok']);

end;

end.
