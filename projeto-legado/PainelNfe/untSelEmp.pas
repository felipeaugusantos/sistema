unit untSelEmp;

interface

uses
  {$IF Defined(UNIDAC)}
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Uni, Data.DB,
  {$ELSE}
    Windows, Messages, SysUtils, Variants,
    Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, Buttons, ExtCtrls, ZDataset, DB,
  {$IFEND}

  {$IFDEF VER300}
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList,
  {$ENDIF}

  DBClient, StrUtils,

  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxEdit, cxNavigator, cxDataStorage,
  cxDBData, cxGridLevel, cxGridDBDataDefinitions, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView,
  cxGrid, dxGDIPlusClasses, cxImage, cxContainer, dxCustomHint, cxHint,
  dxScreenTip;

const
  INFO_PESQUISA = 'Pesquisar (Ctrl+L)';
  cnsStaAberto  = 'ABERTO';
  cnsStaFechado = 'FECHADO';

type
  TfrmSelEmp = class(TForm)
    cdsEmpresas: TClientDataSet;
    dtsEmpresas: TDataSource;
    cxgEmpresas: TcxGrid;
    cxgEmpresasView: TcxGridDBTableView;
    cxgEmpresasLevel: TcxGridLevel;
    pnlHeader: TPanel;
    cdsEmpresasCODEMP: TStringField;
    cdsEmpresasDESEMP: TStringField;
    cdsEmpresasSTATUS: TStringField;
    cdsEmpresasDESPES: TStringField;
    cdsEmpresasCON_ID: TStringField;
    DESEMP: TcxGridDBColumn;
    STATUS: TcxGridDBColumn;
    cxStyleRepository: TcxStyleRepository;
    cxStyleSelecao: TcxStyle;
    Shape1: TShape;
    cxImage1: TcxImage;
    edtPesquisar: TEdit;
    Label1: TLabel;
    btnClose: TSpeedButton;
    cxHint: TcxHintStyleController;
    CODEMP: TcxGridDBColumn;
    CON_ID: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure cxgEmpresasViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgEmpresasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cxgEmpresasViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure edtPesquisarEnter(Sender: TObject);
    procedure edtPesquisarExit(Sender: TObject);
    procedure edtPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisarChange(Sender: TObject);
    procedure cxgEmpresasViewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    intUltRec : Integer;
    procedure pAjustaStatus;
    procedure pCarregarEmpresas;
    procedure pConfirmar;
    procedure pLimparPesquisa;
    { Private declarations }
  public
    { Public declarations }
    strEmpLog: String;
  end;

var
  frmSelEmp: TfrmSelEmp;

implementation

uses
  untUtil, untDicSis, untModulo;

{$R *.dfm}

procedure TfrmSelEmp.pConfirmar;
begin
  inherited;

  pAjustaStatus;

  If (fPodeAbrirPainel(cdsEmpresas.FieldByName('CODEMP').AsString)) Then
  Begin
    strEmpLog := cdsEmpresas.FieldByName('CODEMP').AsString;
    Close;
  End;
end;

procedure TfrmSelEmp.pLimparPesquisa;
begin
  edtPesquisar.Text       := INFO_PESQUISA;
  edtPesquisar.Font.Color := clGray;
end;

procedure TfrmSelEmp.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSelEmp.cxgEmpresasViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pConfirmar;
end;

procedure TfrmSelEmp.cxgEmpresasViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    AColumn: TcxCustomGridTableItem;
    strStatus: String;
begin
  If (Pos(TcxGridItemDBDataBinding(AViewInfo.Item.DataBinding).FieldName, 'STATUS_') > 0) Then
  Begin
    AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('STATUS');
    If AColumn <> Nil Then
    Begin
      strStatus := IfEmptyStr(AViewInfo.GridRecord.DisplayTexts[AColumn.Index], cnsStaFechado);
      ACanvas.Brush.Color := IIF(strStatus = cnsStaAberto, $00EBCF87, $00BBBBFF);
    End;
  End;
end;

procedure TfrmSelEmp.cxgEmpresasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pConfirmar;
    VK_ESCAPE: Self.Close;
  End;
end;

procedure TfrmSelEmp.cxgEmpresasViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  Var
    Site: TcxGridSite;
    HitTest: TcxCustomGridHitTest;
begin
  inherited;
  Site := Sender as TcxGridSite;
  HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);

  if HitTest is TcxGridRecordCellHitTest then
  begin
    If (STATUS.Index = TcxGridRecordCellHitTest(HitTest).Item.Index) And
       (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex >= 0) And
       (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex <> intUltRec) And
       (TcxGridRecordCellHitTest(HitTest).GridRecord.DisplayTexts[STATUS.Index] = cnsStaAberto) Then
    Begin
      intUltRec := TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex;
      cxHint.ShowHint(Mouse.CursorPos.X + 3, Mouse.CursorPos.Y + 3, 'ONDE O PAINEL ESTÁ ABERTO:',
                      fRetornaInformacoesLogAce(TcxGridRecordCellHitTest(HitTest).GridRecord.DisplayTexts[CON_ID.Index],
                                                TcxGridRecordCellHitTest(HitTest).GridRecord.DisplayTexts[CODEMP.Index],
                                                ExtractFileName(ParamStr(0))));
    End;

    If (STATUS.Index <> TcxGridRecordCellHitTest(HitTest).Item.Index) Or
       (TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex <> intUltRec) Then
    Begin
      cxHint.HideHint;
      intUltRec := -1;
    End;
  end
  Else
  Begin
    cxHint.HideHint;
    intUltRec := -1;
  End;
end;

procedure TfrmSelEmp.edtPesquisarChange(Sender: TObject);
  Var
    strFilter: String;
    strPalavra: String;
    stlPalavras: TStringList;
begin
  inherited;

  stlPalavras := fGetPalavrasBusca(edtPesquisar);
  Try
    strFilter := '';
    For strPalavra In stlPalavras Do
    Begin
      If Not fEmptyStr(strFilter) Then
        strFilter := strFilter + ' AND ';

      strFilter := strFilter + 'UPPER(DESPES) LIKE UPPER(' +
        QuotedStr('%' + fRemoveAcento(strPalavra) + '%') + ')';
    End;

    If (fEmptyStr(strFilter)) Or (edtPesquisar.Text = INFO_PESQUISA) Then
    Begin
      cdsEmpresas.Filtered := False;
    End
    Else
    Begin
      cdsEmpresas.Filtered := False;
      cdsEmpresas.Filter   := strFilter;
      cdsEmpresas.Filtered := True;
    End;
  Finally
    FreeAndNil(stlPalavras);
  End;
end;

procedure TfrmSelEmp.edtPesquisarEnter(Sender: TObject);
begin
  If (edtPesquisar.Text = INFO_PESQUISA) Then
  Begin
    edtPesquisar.Clear;
    edtPesquisar.Font.Color := clWindowText;
  End;
end;

procedure TfrmSelEmp.edtPesquisarExit(Sender: TObject);
begin
  If fEmptyStr(edtPesquisar.Text) Then
    pLimparPesquisa;
end;

procedure TfrmSelEmp.edtPesquisarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  edtPesquisarEnter(nil);
  If (cdsEmpresas.Active And Not cdsEmpresas.IsEmpty) And
     (Key In [VK_DOWN, VK_RETURN]) Then
  Begin
    Case Key Of
      VK_DOWN, VK_RETURN: cxgEmpresas.SetFocus;
    End;
  End;
end;

procedure TfrmSelEmp.edtPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  edtPesquisarEnter(nil);
end;

procedure TfrmSelEmp.pAjustaStatus;
  Var
    blnEditar: Boolean;
begin
  If (cdsEmpresas.FieldByName('CODEMP').AsString <> '') Then
  Begin
    blnEditar := (cdsEmpresas.State In [dsBrowse]);

    If blnEditar Then
      cdsEmpresas.Edit;
    Try
      cdsEmpresas.FieldByName('STATUS').AsString := IIF(fPainelEstaAberto(cdsEmpresas.FieldByName('CODEMP').AsString), cnsStaAberto, cnsStaFechado);
      cdsEmpresas.FieldByName('CON_ID').Clear;
      If (cdsEmpresas.FieldByName('STATUS').AsString = cnsStaAberto) Then
        cdsEmpresas.FieldByName('CON_ID').AsString := fGetConIDPainelAberto(cdsEmpresas.FieldByName('CODEMP').AsString);
    Finally
      If blnEditar Then
        cdsEmpresas.Post;
    End;
  End;
end;

procedure TfrmSelEmp.pCarregarEmpresas;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strEmpLoc: String;
    blnConsiderarEmpresasNesteServidor: Boolean;
Begin
  cdsEmpresas.CreateDataSet;
  cdsEmpresas.LogChanges := False;
  cxgEmpresasView.ApplyBestFit;

  blnConsiderarEmpresasNesteServidor := False;
  If (fCampoExiste('EMPRESAS_NESTE_SERVIDOR', 'SRV_CODEMP', frmModulo.Database)) Then
    blnConsiderarEmpresasNesteServidor := (fCampoTabela('COUNT(*)', 'EMPRESAS_NESTE_SERVIDOR', [], [], frmModulo.Database)) >= 1;

  qryGen := fCriaQuery;
  cdsEmpresas.DisableControls;
  Try
    qryGen.Close;
    qryGen.SQL.Text := ' SELECT EMP_CODEMP,   '+
                       '        EMP_NOMEMP    '+
                       '   FROM CADEMP        '+
                       '  WHERE TRUE          '+
                       '    AND (SELECT COUNT(*) FROM CFGSIS WHERE CFGSIS.SIS_CODCFG = "CFG_PNLNFE" AND CFGSIS.SIS_VALCFG = "S" AND CFGSIS.SIS_CODEMP = CADEMP.EMP_CODEMP) > 0 '+
                       IIF(blnConsiderarEmpresasNesteServidor, ' AND EMP_CODEMP IN (SELECT SRV_CODEMP FROM EMPRESAS_NESTE_SERVIDOR) ', '') +
                       '  ORDER BY EMP_CODEMP ';
    qryGen.Open;

    qryGen.First;
    If Not qryGen.IsEmpty Then
    Begin
      While Not qryGen.Eof Do
      Begin
        cdsEmpresas.Append;

        cdsEmpresas.FieldByName('CODEMP').AsString := qryGen.FieldByName('EMP_CODEMP').AsString;
        cdsEmpresas.FieldByName('DESEMP').AsString := qryGen.FieldByName('EMP_CODEMP').AsString + ' - ' +
                                                      qryGen.FieldByName('EMP_NOMEMP').AsString;
        cdsEmpresas.FieldByName('DESPES').AsString := fRemoveAcento(cdsEmpresas.FieldByName('DESEMP').AsString);
        pAjustaStatus;

        cdsEmpresas.Post;

        qryGen.Next;
      End;
    End;
  Finally
    cdsEmpresas.First;
    cdsEmpresas.EnableControls;
    strEmpLoc := fArqIni(0, 'GERAL', 'ULTPNL', '', 'opcoespainel.ini');
    If (strEmpLoc = '') Then
      strEmpLoc := fArqIni(0, 'GERAL', 'EMPPNL', '', 'opcoespainel.ini');
    If (strEmpLoc <> '') Then
      cdsEmpresas.Locate('CODEMP', strEmpLoc, []);
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmSelEmp.FormCreate(Sender: TObject);
begin
  inherited;

  {$IFDEF VER300}
  cxgEmpresas.LookAndFeel.ScrollbarMode := sbmClassic;
  {$ENDIF};

  strEmpLog := '';
  intUltRec := -1;

  pCarregarEmpresas;
end;

procedure TfrmSelEmp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Shift = ([ssCtrl])) And (Key = Ord('L')) And (edtPesquisar.Enabled) Then
    edtPesquisar.SetFocus;
end;

procedure TfrmSelEmp.FormShow(Sender: TObject);
begin
  inherited;
  edtPesquisar.Enabled := cdsEmpresas.RecordCount > 1;

  pLimparPesquisa;

  If cxgEmpresas.CanFocus Then
    cxgEmpresas.SetFocus;
end;

end.
