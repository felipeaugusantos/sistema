unit ImportacaoDados.View.ModeloArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGridCitel,
  ImportacaoDados.Model.ModeloFactory, ImportacaoDados.Interfaces,
  ImportacaoDados.View.EditorCamposModeloArquivo, Uni, untZClient;

type
  TfrmSelecionarModeloArquivo = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxModelos: TcxGridCitel;
    cxModeloTableView: TcxGridDBTableViewCitel;
    cxModeloslvl: TcxGridLevel;
    dtsModelos: TDataSource;
    Panel2: TPanel;
    btnDelete: TBitBtnLocked;
    btnEdit: TBitBtnLocked;
    btnNovo: TBitBtnLocked;
    cxModeloCodigo: TcxGridDBColumn;
    cxModeloDescricao: TcxGridDBColumn;
    BitBtnLocked1: TBitBtnLocked;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pAbrirEditorDeLayout(Const aEstado: TTipoEstadoTela);
    procedure cxModeloTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxModeloTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FQrySQL: TUniQuery;
    cdsModelos: TZClient;

    procedure pCarregaModelos;
    procedure pSelecionaModelo;
    procedure pExcluirModelo;

  public
    ObjImportaPlanilha: IImportaPlanilha;
    ObjModeloArquivo: IModeloArquivoImportacao;
    TipoImportacaoArquivo: TTipoImportacaoArquivo;

    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmSelecionarModeloArquivo.BitBtnLocked1Click(
  Sender: TObject);
begin
  inherited;

  pAbrirEditorDeLayout(tpVisualizacao);
end;

procedure TfrmSelecionarModeloArquivo.btnConfirmaClick(Sender: TObject);
begin
  If fEmptyStr(ObjModeloArquivo.AutoIncrem) Then
  Begin
    pMensagemOk('Selecione um modelo para prosseguir!');
    ModalResult := mrNone;
    Exit;
  End;

  inherited;
end;

procedure TfrmSelecionarModeloArquivo.btnDeleteClick(Sender: TObject);
begin
  inherited;

  pExcluirModelo;
end;

procedure TfrmSelecionarModeloArquivo.btnEditClick(Sender: TObject);
begin
  inherited;

  pAbrirEditorDeLayout(tpEdicao);
end;

procedure TfrmSelecionarModeloArquivo.btnNovoClick(
  Sender: TObject);
begin

  inherited;

  pAbrirEditorDeLayout(tpInsercao);
end;

procedure TfrmSelecionarModeloArquivo.cxModeloTableViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pSelecionaModelo;
end;

procedure TfrmSelecionarModeloArquivo.cxModeloTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_UP,
    VK_DOWN : pSelecionaModelo;
  end;

end;

procedure TfrmSelecionarModeloArquivo.FormCreate(Sender: TObject);
begin
  inherited;

  FQrySQL := fCriaQuery;
  cdsModelos := TZClient.Create(Nil);
  cxModeloTableView.DataController.DataSource := cdsModelos.dtsSource;
  cdsModelos.qryQuery.SQL.Add('SELECT * FROM MDLARQ WHERE MDL_TIPARQ = :MDL_TIPARQ');
  cdsModelos.qryQuery.Prepare;
end;

procedure TfrmSelecionarModeloArquivo.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(cdsModelos);
  FreeAndNil(FQrySQL);
end;

procedure TfrmSelecionarModeloArquivo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F1 : pAbrirEditorDeLayout(tpInsercao);
    VK_F2 : pAbrirEditorDeLayout(tpEdicao);
    VK_F3 : pAbrirEditorDeLayout(tpVisualizacao);
    VK_F10: btnConfirma.Click;
    VK_DELETE: pExcluirModelo;
  End;
end;

procedure TfrmSelecionarModeloArquivo.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaModelos;

  If Not ObjImportaPlanilha.Modelo.Editavel Then
  Begin
    btnNovo.Enabled := False;
    btnEdit.Enabled := False;
    btnDelete.Enabled := False;
  End;

end;

procedure TfrmSelecionarModeloArquivo.pAbrirEditorDeLayout(Const aEstado: TTipoEstadoTela);
var
  frmEditorCamposModeloArquivo : TfrmEditorCamposModeloArquivo;
Begin
  pCriarFormularios(TfrmEditorCamposModeloArquivo, frmEditorCamposModeloArquivo);
  Try
    ObjImportaPlanilha.EstadoTela := aEstado;
    ObjModeloArquivo.Tipo := TipoImportacaoArquivo;
    If aEstado = tpInsercao Then
    Begin
      ObjModeloArquivo.fCarregarCamposPadrao;
    End
    Else
    Begin
      If fEmptyStr(ObjModeloArquivo.AutoIncrem) Then
      Begin
        pMensagemOk('Selecione um modelo para prosseguir!');
        Exit;
      End;
    End;

    frmEditorCamposModeloArquivo.ObjModeloArquivo              := ObjModeloArquivo;
    frmEditorCamposModeloArquivo.ObjModeloArquivo.EstadoTela   := aEstado;
    frmEditorCamposModeloArquivo.ObjImportaPlanilha            := ObjImportaPlanilha;
    If frmEditorCamposModeloArquivo.Showmodal = mrOk Then
    Begin
      Case aEstado Of
        tpInsercao     : ObjModeloArquivo.fInserir ;
        tpEdicao       : ObjModeloArquivo.fAlterar;
      End;
      pCarregaModelos;
    End;

  Finally
    pFreeAndNil(frmEditorCamposModeloArquivo);
  End;

End;

procedure TfrmSelecionarModeloArquivo.pCarregaModelos;
begin
  cdsModelos.qryQuery.Close;
  cdsModelos.qryQuery.ParamByName('MDL_TIPARQ').AsString := strTipoImportacaoArquivo[TipoImportacaoArquivo];
  cdsModelos.fAbreClient(True);
end;

procedure TfrmSelecionarModeloArquivo.pExcluirModelo;
begin
  ObjModeloArquivo.fExcluir;
  pCarregaModelos;
end;

procedure TfrmSelecionarModeloArquivo.pSelecionaModelo;
begin
  ObjModeloArquivo.AutoIncrem := cdsModelos.FieldByName('AUTOINCREM').AsString;
  ObjModeloArquivo.Codigo     := cdsModelos.FieldByName('MDL_CODARQ').AsString;
  ObjModeloArquivo.Descricao  := cdsModelos.FieldByName('MDL_DESARQ').AsString;
end;

end.
