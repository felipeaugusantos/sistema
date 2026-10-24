unit untReferenciarDocumentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, EditFocus, Datasnap.DBClient,
  UniClientDataSet;

type
  TfrmReferenciarDocumentos = class(TfrmPaiConfirma)
    pnlDocumento: TPanel;
    pnlLegenda: TPanel;
    grdDocumentoDBTableView: TcxGridDBTableView;
    grdDocumentoLevel: TcxGridLevel;
    grdDocumento: TcxGrid;
    lblChaveAcesso: TLabel;
    lblLegendaDeletar: TLabel;
    edtChave: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    cdsChave: TUniClientDataSet;
    cdsChaveCHAVE: TStringField;
    dtsChave: TDataSource;
    grdDocumentoCHAVE: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure edtChaveKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function fValidaChaveAcesso(strChave: String): Boolean;
    procedure pDeletaChaveAcesso;
  public
    blnSemChave: Boolean;
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmReferenciarDocumentos.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  if fValidaChaveAcesso(edtChave.Text) then
  begin
    cdsChave.Append;
    cdsChaveCHAVE.AsString := edtChave.Text;
    cdsChave.Post;
  end;

  edtChave.Clear;
  pSetFocus(edtChave);
end;

procedure TfrmReferenciarDocumentos.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnSemChave := False;
  if cdsChave.RecordCount <= 0 then
  begin
    fMensagem('ATENÇÃO','Nenhuma chave foi referenciada!',['&OK']);
    blnSemChave := True;
    Exit;
  end;

  Close;
  ModalResult := mrOk;
end;

procedure TfrmReferenciarDocumentos.edtChaveKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  if fPesqLivroFiscal(Self, qryTabela, Key, arrSel, True) then
  begin
    edtChave.Text := qryTabela.FieldByName('FIS_ACESSO').AsString;
    SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmReferenciarDocumentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if assigned(qryTabela) then
    freeandnil(qryTabela);

  inherited;

end;

procedure TfrmReferenciarDocumentos.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := fCriarQuery('SELECT * FROM CADFIS WHERE FALSE', Self);
  cdsChave.CreateDataSet;
end;

procedure TfrmReferenciarDocumentos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryTabela);
end;

procedure TfrmReferenciarDocumentos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_DELETE: pDeletaChaveAcesso;
  end;
end;

procedure TfrmReferenciarDocumentos.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtChave);
end;

function TfrmReferenciarDocumentos.fValidaChaveAcesso(
  strChave: String): Boolean;
begin
  Result := True;

  if fEmptyStr(strChave) then
  begin
    fMensagem('ATENÇÃO','Chave de acesso não informada!',['&OK']);
    Exit(False);
  end;

  if (Length(strChave) <> 44) then
  begin
    fMensagem('ATENÇÃO','Chave de acesso informada inválida!',['&OK']);
    Exit(False);
  end;

  if cdsChave.Locate('CHAVE', strChave,[]) Then
  begin
    fMensagem('ATENÇÃO','Chave de acesso já foi incluída!',['&OK']);
    Exit(False);
  end;

end;

procedure TfrmReferenciarDocumentos.pDeletaChaveAcesso;
begin
  if (not Assigned(cdsChave)) then
    Exit;

  if (not cdsChave.Active) then
    Exit;

  if (cdsChave.RecordCount <= 0) then
    Exit;

  if (cdsChave.RecNo <= 0) then
    Exit;

  If fMensagem('', 'Deseja remover a chave de acesso?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  cdsChave.Delete;
end;

end.
