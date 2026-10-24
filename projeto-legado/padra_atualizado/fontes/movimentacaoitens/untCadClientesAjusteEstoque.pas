unit untCadClientesAjusteEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, EditFocus, untConfiguraClienteAjusteEstoque, Uni, untPai, untZClient, UniClientDataSet;

type
  TGerenciaCliAju = class
    strCliPrincipal : String;
    cdsCliAju : TUniClientDataSet;
    class function fDefiniCliAju(aPrincipalAtual: String): TGerenciaCliAju;
    destructor Destroy;override;
    procedure PersisteBanco;
    class var AGerenciaCliAju : TGerenciaCliAju;

  End;


  TfrmCadClientesAjusteEstoque = class(TfrmPai)
    dtsTabela: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgClientes: TcxGrid;
    cxvClientes: TcxGridDBTableView;
    cxvClientesCAJ_CLIPRI: TcxGridDBColumn;
    cxvClientesCAJ_CODCLI: TcxGridDBColumn;
    cxvClientesCLI_NOMCLI: TcxGridDBColumn;
    cxgClientesLevel1: TcxGridLevel;
    Label1: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxvClientesCLI_NOMCLIGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxvClientesCAJ_CODCLIPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvClientesEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxvClientesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);

  private
    { Private declarations }
    cdsCliAju: TZClient;
    cdsCliAjuB: TZClient;
    procedure pCarregaRegistros;
    procedure cdsCliAjuAfterPost(DataSet: TDataSet);
    procedure cdsCliAjuBeforePost(DataSet: TDataSet);
    procedure pInsert;
    procedure pDelete;
    function fValidaRegistros: Boolean;


  public

    blnConfirma: Boolean;
    { Public declarations }
  protected
  end;

var
  frmCadClientesAjusteEstoque: TfrmCadClientesAjusteEstoque;

implementation

{$R *.dfm}

Uses
  untTypesSistema,
  untFuncoesSimples,
  untConsultas;

procedure TfrmCadClientesAjusteEstoque.pCarregaRegistros;
Begin
  cdsCliAju.qryQuery.SQL.Clear;
  cdsCliAju.qryQuery.SQL.Add('SELECT * FROM CLIAJU WHERE CAJ_CODEMP = :CODEMP ');

  cdsCliAju.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  cdsCliAju.fAbreClient(False, 'TfrmCadClientesAjusteEstoque.pCarregaRegistros');
  cdsCliAjuB.Data := cdsCliAju.Data;
End;

procedure TfrmCadClientesAjusteEstoque.cxvClientesCAJ_CODCLIPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  If DisplayValue <> '' Then
  Begin
    If Length(DisplayValue) < 8 Then
      DisplayValue :=  fPadL(DisplayValue, 8-Length(DisplayValue), '0');
    If fEmptyStr(fRetNomCliente(DisplayValue)) Then
    Begin
      pMensagemOk('Código do Cliente Inválido!');
      DisplayValue :=  '';
    End;

    if cdsCliAjuB.Locate('CAJ_CODCLI', DisplayValue, []) Then
    Begin
      pMensagemOk('Código do Cliente já utilizado!');
      DisplayValue :=  '';
    End;


  End;

end;



procedure TfrmCadClientesAjusteEstoque.cxvClientesCLI_NOMCLIGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  var strCodCli: string;
begin
  inherited;

  {}

  If Assigned(cdsCliAju) Then
  Begin
    strCodCli := VarToStr(cxvClientes.DataController.Values[ARecord.RecordIndex, cxvClientesCAJ_CODCLI.Index]);
    If strCodCli <> '' Then
      AText := fRetNomCliente(strCodCli);
  End;

end;

procedure TfrmCadClientesAjusteEstoque.cxvClientesEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var qryCadCli: TUniQuery;
    arrClientes : TConsultasArray;
begin

  inherited;
  If AItem = cxvClientesCAJ_CODCLI Then
  Begin
    qryCadCli := fCriaQuery;
    Try
      If fPesqCliente(conCliSimples, Self, nil, nil, qryCadCli, Key, arrClientes) Then
        AItem.EditValue := qryCadCli.FieldByName('CLI_CODCLI').AsString;
    Finally
      FreeAndNil(qryCadCli);
    End;
  End;



end;

procedure TfrmCadClientesAjusteEstoque.cxvClientesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_INSERT Then
    pInsert;
  If Key = VK_DELETE Then
    pDelete;
end;

procedure TfrmCadClientesAjusteEstoque.pDelete;
Begin
  If fPergunta('Deseja Remover o Cliente [' + cdsCliAju.FieldByName('CAJ_CODCLI').AsString + ']') Then
  Begin
    cdsCliAju.Delete;
    cdsCliAjuB.Data := cdsCliAju.Data;
  End;
End;

procedure TfrmCadClientesAjusteEstoque.pInsert;
var strPrincipal: String;
Begin
  strPrincipal := IIf(cdsCliAju.IsEmpty, 'S', 'N');

  If cdsCliAju.State in [dsInsert] then
    Exit;
  cdsCliAju.Append;
  cdsCliAju.FieldByName('AUTOINCREM').ASString := fRetAutoincrem('CLIAJU', VS_StrCodEmp);
  cdsCliAju.FieldByName('CAJ_CLIPRI').AsString := strPrincipal;
  cdsCliAju.FieldByName('CAJ_CODEMP').AsString := VS_StrCodemp;
End;


procedure TfrmCadClientesAjusteEstoque.FormCreate(Sender: TObject);
begin
  inherited;

  cdsCliAju  := TZClient.Create(nil);
  cdsCliAjuB  := TZClient.Create(nil);
  blnConfirma := False;
  dtsTabela.DataSet     := cdsCliAju;

  cdsCliAju.AfterPost := cdsCliAjuAfterPost;
  cdsCliAju.BeforePost := cdsCliAjuBeforePost;

  pCarregaRegistros;

  cxvClientes.DataController.DataSource := dtsTabela
end;

procedure TfrmCadClientesAjusteEstoque.FormDestroy(Sender: TObject);
begin
  freeAndNil(cdsCliAju);
  freeAndNil(cdsCliAjuB);
  inherited;

end;

procedure TfrmCadClientesAjusteEstoque.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnConfirma.Click;
end;

procedure TfrmCadClientesAjusteEstoque.FormShow(Sender: TObject);
begin
  pSetFocus(cxgClientes);
end;

function TfrmCadClientesAjusteEstoque.fValidaRegistros: Boolean;
var blnTemPri: Boolean;
begin
  Result := True;
  cdsCliAju.First;
  blnTemPri := False;
  while not cdsCliAju.Eof do
  Begin
    If fEmptyStr(cdsCliAju.FieldByName('CAJ_CODCLI').AsString) Then
    Begin
      pMensagemOk('Todos os clientes precisa estar definidos!');
      Exit(False);
    End;
    If cdsCliAju.FieldByName('CAJ_CLIPRI').AsString = 'S' Then
      blnTemPri := True;

    cdsCliAju.Next;
  End;

  If Not blnTemPri then
  Begin
    pMensagemOk('Ao menos um registro deve estar definido como principal!');
    Exit(False);
  End;

end;

procedure TfrmCadClientesAjusteEstoque.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fValidaRegistros Then
    If fPergunta('Confirma as alterações?') Then
    Begin
      blnConfirma := True;
      Close;
    End;
end;

procedure TfrmCadClientesAjusteEstoque.cdsCliAjuAfterPost(DataSet: TDataSet);
var recNo: integer;
begin
  recNo := cdsCliAju.RecNo;
  If cxvClientes.DataController.DataSet.FieldByName('CAJ_CLIPRI').AsString  = 'S' then
  Begin
    Try
      cxvClientes.DataController.DataSet.First;
      cdsCliAju.AfterPost := nil;
      cdsCliAju.BeforePost := nil;
      while not cxvClientes.DataController.DataSet.Eof do
      Begin
        If cxvClientes.DataController.DataSet.Recno = recNo Then
          cxvClientes.DataController.DataSet.Next
        Else
        Begin
          cxvClientes.DataController.DataSet.Edit;
          cxvClientes.DataController.DataSet.FieldByName('CAJ_CLIPRI').AsString := 'N';
          cxvClientes.DataController.DataSet.Post;
          cxvClientes.DataController.DataSet.Next
        End;
      End;
    Finally
      cdsCliAju.AfterPost := cdsCliAjuAfterPost;
      cdsCliAju.BeforePost := cdsCliAjuBeforePost;
    End;
  End;
  cdsCliAju.RecNo :=  recNo;
  cdsCliAjuB.Data := cdsCliAju.Data;
end;

procedure TfrmCadClientesAjusteEstoque.cdsCliAjuBeforePost(DataSet: TDataSet);
begin
end;

{ TGerenciaCliAju }

destructor TGerenciaCliAju.Destroy;
begin
  FreeAndNil(cdsCliAju);
end;

class function TGerenciaCliAju.fDefiniCliAju(aPrincipalAtual: String): TGerenciaCliAju;
var blnRestore: Boolean;
begin
  blnRestore := False;
  If Assigned(AGerenciaCliAju) Then
    blnRestore := True
  Else
  Begin
    AGerenciaCliAju := TGerenciaCliAju.Create;
    AGerenciaCliAju.cdsCliAju := TUniClientDataSet.Create(nil);
  End;

  pCriarFormularios(TfrmCadClientesAjusteEstoque, frmCadClientesAjusteEstoque);
  Try

    If AGerenciaCliAju.cdsCliAju.IsEmpty Then
      AGerenciaCliAju.cdsCliAju.Data := frmCadClientesAjusteEstoque.cdsCliAju.Data;
    AGerenciaCliAju.strCliPrincipal := aPrincipalAtual;
    If blnRestore Then
      frmCadClientesAjusteEstoque.cdsCliAju.Data := AGerenciaCliAju.cdsCliAju.Data;
    frmCadClientesAjusteEstoque.ShowModal;
    If frmCadClientesAjusteEstoque.blnConfirma Then
    Begin
      AGerenciaCliAju.cdsCliAju.Data := frmCadClientesAjusteEstoque.cdsCliAju.Data;
      frmCadClientesAjusteEstoque.cdsCliAju.First;
      If frmCadClientesAjusteEstoque.cdsCliAju.Locate('CAJ_CLIPRI', 'S', []) Then
        AGerenciaCliAju.strCliPrincipal := frmCadClientesAjusteEstoque.cdsCliAju.FieldByname('CAJ_CODCLI').AsString;
    End;
  Finally
    FreeAndNil(frmCadClientesAjusteEstoque);
  End;

  Result := AGerenciaCliAju;
end;

procedure TGerenciaCliAju.PersisteBanco;
var qryComand : TuniQuery;
begin
  cdsCliAju.First;
  qryComand := fCriaQuery(nil);
  Try
    qryComand.SQl.add('DELETE FROM CLIAJU WHERE CAJ_CODEMP = "' + VS_StrCodEmp + '"');
    qryComand.ExecSQL;
    qryComand.SQl.Clear;

    qryComand.SQL.Add('INSERT INTO CLIAJU (AUTOINCREM, CAJ_CODEMP, CAJ_CODCLI, CAJ_CLIPRI) VALUES (:AUTOINCREM, :CAJ_CODEMP, :CAJ_CODCLI, :CAJ_CLIPRI)');
    while not cdsCliAju.Eof do
    Begin
      qryComand.ParamByName('AUTOINCREM').AsString := cdsCliAju.FieldByName('AUTOINCREM').AsString;
      qryComand.ParamByName('CAJ_CODEMP').AsString := cdsCliAju.FieldByName('CAJ_CODEMP').AsString;
      qryComand.ParamByName('CAJ_CODCLI').AsString := cdsCliAju.FieldByName('CAJ_CODCLI').AsString;
      qryComand.ParamByName('CAJ_CLIPRI').AsString := cdsCliAju.FieldByName('CAJ_CLIPRI').AsString;
      qryComand.ParamByName('CAJ_CLIPRI').AsString := cdsCliAju.FieldByName('CAJ_CLIPRI').AsString;
      qryComand.ExecSQL;
      cdsCliAju.Next;
    End;
  Finally
    FreeAndNil(qryComand);
  End;
End;

end.
