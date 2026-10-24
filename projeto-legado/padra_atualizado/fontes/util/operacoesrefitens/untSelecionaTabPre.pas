unit untSelecionaTabPre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid,
  untZClient, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, frxClass,
  frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmSelecionaTabPre = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    Panel1: TPanel;
    Label11: TLabel;
    edtTabPre: TEditFocus;
    edtNomTab: TEditFocus;
    Label1: TLabel;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensViewColumn5: TcxGridDBColumn;
    cxgItensViewColumn6: TcxGridDBColumn;
    Panel2: TPanel;
    Label2: TLabel;
    Shape1: TShape;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarca: TBitBtnLocked;
    cxgItensMARCADO: TcxGridDBColumn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtTabPreKeyPress(Sender: TObject; var Key: Char);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
  private
    { Private declarations }
    arrTabPre: TConsultasArray;

    function fSQLTabelas: String;

    procedure pMarcaRegistro(blnMarcar: Boolean);
    procedure pMarcaTodos(blnMarcar: Boolean);

  public
    { Public declarations }
    cdsTabela: TZClient;
    
    procedure pAbreConsulta;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmSelecionaTabPre: TfrmSelecionaTabPre;

implementation
uses
  untFuncoesSimples,
  untConsultas;

{$R *.dfm}

procedure TfrmSelecionaTabPre.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos(False);
end;

procedure TfrmSelecionaTabPre.btnMarcaClick(Sender: TObject);
begin
  inherited;

  With cdsTabela Do
  Begin
    If IsEmpty Then
      Exit;
    pMarcaRegistro(FieldByName('MARCADO').AsString = 'N');
  End;  
end;

procedure TfrmSelecionaTabPre.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  pMarcaTodos(True);
end;

procedure TfrmSelecionaTabPre.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensMARCADO.Index]) = 'S' Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := clGreen
    Else
      ACanvas.Brush.Color := clMoneyGreen;
  End;

end;

procedure TfrmSelecionaTabPre.edtTabPreKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqTabelaPreco(Self, edtTabPre, edtNomTab, nil, Key, arrTabPre) Then
  Begin
    If fValidaCampos(edtTabPre, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSelecionaTabPre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10   : Begin
                 Key := 0;
                 btnConfirma.Click;
               End;  
    VK_F6    : btnMarcaTodos.Click;
    VK_F7    : btnDesmarcaTodos.Click;
    VK_RETURN: If fCheckParent(ActiveControl, cxgItens) Then
                 btnMarca.Click;
  End;

end;

procedure TfrmSelecionaTabPre.FormShow(Sender: TObject);
begin
  inherited;

  cxgItensView.DataController.DataSource := cdsTabela.dtsSource;
  cdsTabela.Filtered := False;

  If cdsTabela.IsEmpty Then
    pSetFocus(edtTabPre)
  Else
    pSetFocus(cxgItens);
end;


function TfrmSelecionaTabPre.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtTabPre) Then
    Begin

      edtNomTab.Enabled := fEmptyStr(edtTabPre.Text);

      If Not fEmptyStr(edtTabPre.Text) Then
      Begin
        edtNomTab.Text := fRetNomeTabelaPreco(edtTabPre.Text);

        If fEmptyStr(edtNomTab.Text) Then
        Begin
          pMensagemOk('Tabela não econtrada!');
          Result := False;
        End Else
        Begin

          pAbreConsulta;

        End;

      End;

    End

    Else If (Sender = edtNomTab) Then
    Begin

      If edtNomTab.Enabled Then
      Begin

        If fEmptyStr(edtNomTab.Text) Then
        Begin
          pMensagemOk('Informe ao menos parte da descrição da Tabela');
          Result := False;
        End

        Else pAbreConsulta;

      End;

    End


  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmSelecionaTabPre.fSQLTabelas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   "N" AS MARCADO, ';
  strSQL := strSQL + '   TAB_CODTAB, ';
  strSQL := strSQL + '   TAB_NOMTAB, ';
  strSQL := strSQL + '   TAB_CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR, ';
  strSQL := strSQL + '   TAB_DESTAB, ';
  strSQL := strSQL + '   TAB_ATICMP  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   TABPRE ';
  strSQL := strSQL + ' INNER JOIN CADFOR ON FOR_CODFOR = TAB_CODFOR ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   TRUE ';

  If Not fEmptyStr(edtTabPre.Text) Then
    strSQL := strSQL + ' AND TAB_CODTAB = :CODTAB ';

  If Not fEmptyStr(edtNomTab.Text) Then
    strSQL := strSQL + ' AND TAB_NOMTAB LIKE :NOMTAB ';

  Result := strSQL;
End;


procedure TfrmSelecionaTabPre.pAbreConsulta;
Begin
  With cdsTabela, qryQuery Do
  Begin
    SQL.Text := fSQLTabelas;

    If Not fEmptyStr(edtTabPre.Text) Then
      ParamByName('CODTAB').AsString := edtTabPre.Text;

    If Not fEmptyStr(edtNomTab.Text) Then
      ParamByName('NOMTAB').AsString := '%' + edtNomTab.Text + '%';

    fAbreClient(True, 'TfrmSelecionaTabPre.pAbreConsulta');

    pAlinhaCampoCentro('TAB_CODTAB');
    pAlinhaCampoCentro('TAB_CODFOR');
    pAlinhaCampoCentro('TAB_ATICMP');
  End;
End;

procedure TfrmSelecionaTabPre.pMarcaRegistro(blnMarcar: Boolean);
Begin
  With cdsTabela Do
  Begin
    If IsEmpty Then
      Exit;

    Edit;
    FieldByName('MARCADO').AsString := IIF(blnMarcar, 'S', 'N');
    Post;
  End;

End;

procedure TfrmSelecionaTabPre.pMarcaTodos(blnMarcar: Boolean);
Begin
  With cdsTabela Do
  Begin
    DisableControls;
    FirSt;
    While Not Eof Do
    Begin
      pMarcaRegistro(blnMarcar);
      Next;
    End;

    EnableControls;
  End;
End;

end.
