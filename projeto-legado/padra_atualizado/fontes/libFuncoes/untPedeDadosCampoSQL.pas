unit untPedeDadosCampoSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.DBCtrls, DBMemoFocus, Data.DB, Vcl.Mask, DBEditFocus,
  untZClient, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView,
  cxGridDBBandedTableView, ComboBoxFocus, EditFocus, Vcl.ComCtrls,
  untConfiguraSQLConsulta, cxColorComboBox, cxContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit;

type
  TfrmPedeDadosCampoSQL = class(TfrmPaiConfirma)
    dtsCampos: TDataSource;
    dtsCopiaCampos: TDataSource;
    pgcCampos: TPageControl;
    tbsGeral: TTabSheet;
    tbsEstilos: TTabSheet;
    Panel1: TPanel;
    lblCalMsk: TLabel;
    dbeCALMSK: TDBLookupComboBox;
    Panel2: TPanel;
    Label5: TLabel;
    dbeLisVal: TDBMemoFocus;
    pnlStyles: TPanel;
    pnlTopStyle: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    cmbOperador: TComboBoxFocus;
    edtValor: TEditFocus;
    cxgStyles: TcxGrid;
    cxvStyles: TcxGridDBBandedTableView;
    cxvStylesColumn1: TcxGridDBBandedColumn;
    cxvStylesColumn2: TcxGridDBBandedColumn;
    cxgStylesLevel1: TcxGridLevel;
    Panel3: TPanel;
    Label4: TLabel;
    dbeALIAS_: TDBEditFocus;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    Label2: TLabel;
    grbEstiloTexto: TGroupBox;
    chkNegrito: TCheckBox;
    chkItalico: TCheckBox;
    chkSublinhado: TCheckBox;
    cxvStylesColumn3: TcxGridDBBandedColumn;
    btnIncluir: TBitBtnLocked;
    Panel4: TPanel;
    btnDelEstilo: TBitBtnLocked;
    dbTITULO: TDBEditFocus;
    cxcCor: TcxColorComboBox;
    rdgConfig: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnDelEstiloClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    cdsCamCopia: TZClient;

    procedure pCarregaDados;
    procedure pLimpaDados;
    Function fVerificaTamanhoTela: Boolean;

  public
    { Public declarations }

    objConsulta: TConfiguraSQLConsulta;
  end;

var
  frmPedeDadosCampoSQL: TfrmPedeDadosCampoSQL;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmPedeDadosCampoSQL.btnDelEstiloClick(Sender: TObject);
begin
  inherited;

  objConsulta.cdsEstilos.fExcluiEstilo;

  pLimpaDados;
end;

procedure TfrmPedeDadosCampoSQL.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If objConsulta.cdsEstilos.fIncluiEstilo(cmbOperador.Text,
                                          edtValor.Text,
                                          cxcCor.ColorValue,
                                          chkNegrito.Checked,
                                          chkItalico.Checked,
                                          chkSublinhado.Checked) Then
    pLimpaDados;
end;

procedure TfrmPedeDadosCampoSQL.pLimpaDados;
Begin
  cmbOperador.ItemIndex := -1;
  edtValor.Clear;
  cxcCor.ItemIndex := -1;
  chkNegrito.Checked := False;
  chkItalico.Checked := False;
  chkSublinhado.Checked := False;
End;

procedure TfrmPedeDadosCampoSQL.pCarregaDados;
Begin
  If objConsulta.cdsEstilos.IsEmpty Then
   Exit;

  cmbOperador.ItemIndex := cmbOperador.Items.IndexOf(objConsulta.cdsEstilos.FieldByName('OPERADOR').AsString);
  edtValor.Text         := objConsulta.cdsEstilos.FieldByName('VALOR').AsString;
  cxcCor.ColorValue     := objConsulta.cdsEstilos.FieldByName('COR').AsInteger;
  chkNegrito.Checked    := Pos('N', objConsulta.cdsEstilos.FieldByName('FONTE').AsString) > 0;
  chkItalico.Checked    := Pos('I', objConsulta.cdsEstilos.FieldByName('FONTE').AsString) > 0;
  chkSublinhado.Checked := Pos('S', objConsulta.cdsEstilos.FieldByName('FONTE').AsString) > 0;
End;

procedure TfrmPedeDadosCampoSQL.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If objConsulta.cdsCampos.State <> dsEdit Then
      objConsulta.cdsCampos.Edit;

    objConsulta.cdsCampos.FieldByName('CAM_ESTILO').AsString := objConsulta.cdsEstilos.fGetEstilos;
    objConsulta.cdsCampos.FieldByName('CAM_CONFIG').AsInteger := rdgConfig.ItemIndex;

    objConsulta.cdsCampos.Post;
  End

  Else If objConsulta.cdsCampos.State = dsEdit Then
         dtsCampos.DataSet.Cancel;

end;

procedure TfrmPedeDadosCampoSQL.FormCreate(Sender: TObject);
begin
  inherited;
  If fVerificaTamanhoTela Then
    Self.Position := poScreenCenter;

  cdsCamCopia := TZClient.Create(Self);
end;

procedure TfrmPedeDadosCampoSQL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If fCheckParent(ActiveControl, cxgStyles) Then
                 pCarregaDados;
  End;

end;

procedure TfrmPedeDadosCampoSQL.FormShow(Sender: TObject);
begin
  inherited;

  pgcCampos.ActivePageIndex := 0;

  pLimpaDados;

  objConsulta.cdsEstilos.fCarregaEstilos(objConsulta.cdsCampos.FieldByName('CAM_ESTILO').AsString);

  cxvStyles.DataController.DataSource := objConsulta.cdsEstilos.dtsSource;

  If dtsCampos.DataSet.State = dsEdit Then
    dtsCampos.DataSet.Post;

  dtsCampos.DataSet.Edit;

  lblCalMsk.Visible := SameText(dtsCampos.DataSet.FieldByName('CAM_MASCAR').AsString, ArrDesMascara[masCNPJCPF]);
  dbeCALMSK.Visible := lblCalMsk.Visible;

  If dbeCALMSK.Visible Then
  Begin
    cdsCamCopia.Data     := TZClient(dtsCampos.DataSet).Data;
    cdsCamCopia.Filter   := 'CAM_ALIAS_ <> ' + QuotedStr(dtsCampos.DataSet.FieldByName('CAM_ALIAS_').AsString);
    cdsCamCopia.Filtered := True;

    dtsCopiaCampos.DataSet := cdsCamCopia;
  End;

  rdgConfig.ItemIndex := objConsulta.cdsCampos.FieldByName('CAM_CONFIG').AsInteger
end;

function TfrmPedeDadosCampoSQL.fVerificaTamanhoTela: Boolean;
begin
  Result := False;
  If ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
  Begin
    Result := True;
    Exit;
  End;

  If (Screen.Width <= 1366) Then
    Result := True
end;

end.
