unit untGridDocumentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxCheckBox, cxLookAndFeels, cxLookAndFeelPainters,
  cxNavigator, untTypesSistema, untDocumentos, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmGridDocumentos = class(TfrmPaiEdit)
    cxgLayEtiView: TcxGridDBTableView;
    cxgLayEtiLevel1: TcxGridLevel;
    cxgLayEti: TcxGrid;
    cxgLayEtiCodigo: TcxGridDBColumn;
    cxgLayEtiTIPLAY: TcxGridDBColumn;
    cxgLayEtiDESCRI: TcxGridDBColumn;
    cxgLayEtiPADRAO: TcxGridDBColumn;
    btnIncluir: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgLayEtiTIPIMP: TcxGridDBColumn;
    btnIncluirMatricial: TBitBtnLocked;
    cxgLayEtiGERPDF: TcxGridDBColumn;
    btnImpExp: TBitBtnLocked;
    popImpExp: TPopupMenu;
    mnuDesmarcaTodos: TMenuItem;
    mnuMarDes: TMenuItem;
    mnuExporta: TMenuItem;
    mnuImporta: TMenuItem;
    mnuMarcaTodos: TMenuItem;
    cxgLayEtiAUTOINCREM: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxgLayEtiTIPIMPCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnIncluirMatricialClick(Sender: TObject);
    procedure cxgLayEtiGERPDFPropertiesChange(Sender: TObject);
    procedure cxgLayEtiPADRAOPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuMarcaTodosClick(Sender: TObject);
    procedure mnuDesmarcaTodosClick(Sender: TObject);
    procedure mnuMarDesClick(Sender: TObject);
    procedure cxgLayEtiViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure mnuExportaClick(Sender: TObject);
    procedure mnuImportaClick(Sender: TObject);
    procedure btnImpExpClick(Sender: TObject);
  private
    { Private declarations }
    procedure pSalvaDocumento(tpaTipArq: TTipoArquivo);
  public
    { Public declarations }
    cdsDocumentos: TDocumentos;
  end;

var
  frmGridDocumentos: TfrmGridDocumentos;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmGridDocumentos.btnAlterarClick(Sender: TObject);
  Var
    intRecNo: Integer;
begin
  inherited;

  If Not cdsDocumentos.IsEmpty Then
  Begin
    intRecNo := cdsDocumentos.RecNo;
    cdsDocumentos.pIncluiDocumento(False, cdsDocumentos.FieldByName('LAY_TIPIMP').AsString);
    Try
      If (intRecNo <= cdsDocumentos.RecordCount) And (intRecNo > 0) Then
        cdsDocumentos.RecNo := intRecNo;
    Except;
    End;
  End;
end;

procedure TfrmGridDocumentos.btnExcluirClick(Sender: TObject);
begin
  inherited;

  cdsDocumentos.pExcluiDocumento;
end;

procedure TfrmGridDocumentos.btnImpExpClick(Sender: TObject);
begin
  inherited;

  popImpExp.Popup(Self.Left + btnImpExp.Left, Self.Top + pnlBotoes.Top);
end;

procedure TfrmGridDocumentos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  cdsDocumentos.pIncluiDocumento(True, 'J');
end;

procedure TfrmGridDocumentos.btnIncluirMatricialClick(Sender: TObject);
begin
  inherited;

  cdsDocumentos.pIncluiDocumento(True, 'M');
end;

procedure TfrmGridDocumentos.cxgLayEtiGERPDFPropertiesChange(Sender: TObject);
begin
  inherited;

  pSalvaDocumento(tpaPDF);

end;

procedure TfrmGridDocumentos.cxgLayEtiPADRAOPropertiesChange(Sender: TObject);
begin
  inherited;

  pSalvaDocumento(tpaNormal);

end;

procedure TfrmGridDocumentos.cxgLayEtiTIPIMPCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  ACanvas.Font.Style := [fsBold];
  ACanvas.Font.Size  := 10;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgLayEtiTIPIMP.Index]) = 'J' Then
  Begin
    ACanvas.Font.Color := clBlue;
  End Else
  Begin
    ACanvas.Font.Color := clRed;
  End;

end;

procedure TfrmGridDocumentos.cxgLayEtiViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If cdsDocumentos.fInList(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgLayEtiAUTOINCREM.Index])) Then
  Begin
    ACanvas.Brush.Color := clYellow;

    If AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
  End;

end;

procedure TfrmGridDocumentos.pSalvaDocumento(tpaTipArq: TTipoArquivo);
  Var
    strNumDoc: String;
begin

  With cdsDocumentos Do
  Begin
    Try
      Begin
        DisableControls;

        pAtualizaDocumento(FieldByName('LAY_CODLAY').AsString,
                           FieldByName('LAY_TIPLAY').AsInteger,
                           FieldByName('LAY_PADRAO').AsString,
                           FieldByName('LAY_GERPDF').AsString);

        strNumDoc := FieldByName('LAY_CODLAY').AsString;

        If ((tpaTipArq = tpaNormal) And (cdsDocumentos.FieldByName('LAY_TIPLAY').AsString <> '214') And
            (FieldByName('LAY_PADRAO').AsString = 'S')) OR
           ((tpaTipArq = tpaPDF) And (cdsDocumentos.FieldByName('LAY_TIPLAY').AsString <> '214') And
            (FieldByName('LAY_GERPDF').AsString = 'S')) Then
        Begin
          pAtualizaNaoPadrao(FieldByName('LAY_CODLAY').AsString,
                             FieldByName('LAY_TIPLAY').AsInteger,
                             tpaTipArq);

          CancelUpdates;
          pRefresh(strNumDoc);
        End;

      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(e.Message, 'TfrmGridDocumentos.pSalvaDocumento');
      End;
    End;

    EnableControls;
  End;

end;

procedure TfrmGridDocumentos.FormCreate(Sender: TObject);
begin
  inherited;
                      //Edmilson
  cdsDocumentos := TDocumentos.Create(Self);
  cxgLayEtiView.DataController.DataSource := cdsDocumentos.dtsSource;
end;


procedure TfrmGridDocumentos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: btnAlterar.Click;
    VK_INSERT: btnIncluir.Click;
    VK_F5    : btnIncluirMatricial.Click;
    VK_F6    : mnuMarDes.Click;
    VK_F8    : mnuMarcaTodos.Click;
    VK_F9    : mnuDesmarcaTodos.Click;
    VK_F10   : mnuExporta.Click;
    VK_F11   : mnuImporta.Click;
    VK_DELETE: If Not (cxgLayEtiView.Controller.FocusedRow Is TcxGridFilterRow) Then
                 btnExcluir.Click;
  End;
end;

procedure TfrmGridDocumentos.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(cxgLayEti);

  cxgLayEtiView.NavigatorButtons.First.Click;
end;

procedure TfrmGridDocumentos.mnuDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  cxgLayEtiGERPDF.Width := cxgLayEtiGERPDF.Width + 1;
  cdsDocumentos.pMarcaTodos(False);
  cxgLayEtiGERPDF.Width := cxgLayEtiGERPDF.Width - 1;

end;

procedure TfrmGridDocumentos.mnuExportaClick(Sender: TObject);
begin
  inherited;

  If cdsDocumentos.fExportaDocumentos Then
    mnuDesmarcaTodos.Click;
end;

procedure TfrmGridDocumentos.mnuImportaClick(Sender: TObject);
begin
  inherited;

  cdsDocumentos.fImportaDocumentos;

end;

procedure TfrmGridDocumentos.mnuMarcaTodosClick(Sender: TObject);
begin
  inherited;

  cxgLayEtiGERPDF.Width := cxgLayEtiGERPDF.Width + 1;
  cdsDocumentos.pMarcaTodos(True);
  cxgLayEtiGERPDF.Width := cxgLayEtiGERPDF.Width - 1;
end;

procedure TfrmGridDocumentos.mnuMarDesClick(Sender: TObject);
begin
  inherited;

  cxgLayEtiGERPDF.Width := cxgLayEtiGERPDF.Width + 1;
  cdsDocumentos.pMarcaDesmarca;
  cxgLayEtiGERPDF.Width := cxgLayEtiGERPDF.Width - 1;
end;

end.
