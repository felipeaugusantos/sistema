unit untExpDigVolumesCompostos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet;

type
  TfrmExpDigVolumesCompostos = class(TfrmPaiConfirma)
    pnlPrincipal: TPanel;
    lblSigla: TLabel;
    lblQtdVol: TLabel;
    edtSigla: TEditFocus;
    edtQtdVol: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    cxgVolumeDBTableView: TcxGridDBTableView;
    cxgVolumeLevel: TcxGridLevel;
    cxgVolume: TcxGrid;
    cxgVolumeTIPVOL: TcxGridDBColumn;
    cxgVolumeSIGVOL: TcxGridDBColumn;
    cxgVolumeQTDVOL: TcxGridDBColumn;
    dtsVolume: TDataSource;
    cdsVolume: TUniClientDataSet;
    cdsVolumeTIPVOL: TStringField;
    cdsVolumeSIGVOL: TStringField;
    cdsVolumeQTDVOL: TIntegerField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cxgProdutosDBTableView: TcxGridDBTableView;
    cxgProdutosLevel: TcxGridLevel;
    cxgProdutos: TcxGrid;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosDESITE: TStringField;
    cdsProdutosUNIDAD: TStringField;
    cdsProdutosQTDITE: TFloatField;
    dtsProdutos: TDataSource;
    cxgProdutosDESITE: TcxGridDBColumn;
    cxgProdutosUNIDAD: TcxGridDBColumn;
    cxgProdutosQTDITE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgVolumeDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSiglaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure pExcluiVolumeComposto;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    procedure pAddProduto(strDesIte: String;
                          strUnidad: String;
                          fltQtdIte: Double);

    procedure pAddEtiquetaVolume(strDescri: String;
                                 strSigla_: String;
                                 intVolume: Integer);
  end;


implementation

uses
  untFuncoesSimples, untConstantes, untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmExpDigVolumesCompostos.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  if fVerificaCampos then
  begin
    cdsVolume.Append;
    cdsVolumeTIPVOL.AsString := fCampoTabela('EED_DESCRI', 'CADEED', ['EED_SIGLA_'], [edtSigla.Text], False);
    cdsVolumeSIGVOL.AsString := edtSigla.Text;
    cdsVolumeQTDVOL.AsInteger := StrToInt(edtQtdVol.Text);
    cdsVolume.Post;
    pSetFocus(edtSigla);
    edtSigla.Clear;
    edtQtdVol.Clear;
  end;
end;

procedure TfrmExpDigVolumesCompostos.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  edtSigla.Clear;
  edtQtdVol.Clear;
end;

procedure TfrmExpDigVolumesCompostos.cxgVolumeDBTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  case key of
    VK_DELETE: pExcluiVolumeComposto;
  end;
end;

procedure TfrmExpDigVolumesCompostos.edtSiglaKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEtiq: TConsultasArray;
begin
  inherited;
  If fPesqEtiVolDocDespacho(Self, edtSigla, Nil, qryTabela, Key, arrEtiq) Then
  Begin
    If fValidaCampos(edtSigla, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmExpDigVolumesCompostos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  blnVerificaCampos := False;

  inherited;

  if (ModalResult = mrOk) and (cdsVolume.RecordCount <= 0) then
  begin
    fMensagem('ATENÇÃO!', 'Nenhuma etiqueta informada!', ['&Ok']);
    Action := caNone;
  end;

end;

procedure TfrmExpDigVolumesCompostos.FormCreate(Sender: TObject);
begin
  inherited;
  cdsVolume.CreateDataSet;
  cdsProdutos.CreateDataSet;
end;

procedure TfrmExpDigVolumesCompostos.FormShow(Sender: TObject);
begin
  inherited;
  cdsVolume.Open;
  cdsProdutos.Open;
  pSetFocus(edtSigla);
end;

function TfrmExpDigVolumesCompostos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtSigla) Then
  Begin
    If fEmptyStr(edtSigla.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar a sigla do volume!', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(fCampoTabela('EED_DESCRI', 'CADEED', ['EED_SIGLA_'], [edtSigla.Text], False)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Sigla não cadastrada no sistema!', ['&Ok']);
      Result := False;
    End
    Else If cdsVolume.Locate('SIGVOL', edtSigla.Text, [loCaseInsensitive]) Then
    Begin
      fMensagem('ATENÇÃO!', 'Volume já adicionado!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtQtdVol) Then
  Begin
    If fEmptyStr(edtQtdVol.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar a quantidade de volumes!', ['&Ok']);
      Result := False;
    End
    Else If (StrToIntDef(edtQtdVol.Text, 0) <=0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de volume deve ser maior que zero!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmExpDigVolumesCompostos.pAddEtiquetaVolume(strDescri: String;
                                                        strSigla_: String;
                                                        intVolume: Integer);
begin
  cdsVolume.Append;
  cdsVolumeTIPVOL.AsString  := strDescri;
  cdsVolumeSIGVOL.AsString  := strSigla_;
  cdsVolumeQTDVOL.AsInteger := intVolume;
  cdsVolume.Post;
end;

procedure TfrmExpDigVolumesCompostos.pAddProduto(strDesIte: String;
                                                 strUnidad: String;
                                                 fltQtdIte: Double);
begin
  cdsProdutos.Append;
  cdsProdutosDESITE.AsString := strDesIte;
  cdsProdutosUNIDAD.AsString := strUnidad;
  cdsProdutosQTDITE.AsFloat  := fltQtdIte;
  cdsProdutos.Post;
end;

procedure TfrmExpDigVolumesCompostos.pExcluiVolumeComposto;
begin
  if not Assigned(cdsVolume) then
    Exit;

  if not cdsVolume.Active then
    Exit;

  if cdsVolume.RecordCount <= 0 then
    Exit;

  if cdsVolume.RecNo <= 0 then
    Exit;

  If fMensagem('ATENÇÃO', 'Deseja remover o volume composto?', ['&Sim', '&Não']) = 2 Then
    Exit;

  cdsVolume.Delete;
end;

end.
