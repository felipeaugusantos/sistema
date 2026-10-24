unit untPedeDadosInterface;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.DBCtrls, DBComboBoxFocus, Vcl.Mask, DBEditFocus,
  DBMemoFocus, Data.DB,
  untFuncoesSimples, untInterfaceRelatorio, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckBox, cxDBEdit, ComboBoxFocus,
  BCEditor.Editor.Base, BCEditor.Editor, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  TfrmPedeDadosInterface = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    pnlDadosGerais: TPanel;
    dtsCadPar: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblVerVer: TLabel;
    Label13: TLabel;
    lblNroDec: TLabel;
    dbeNomPar: TDBEditFocus;
    dbeDesPar: TDBEditFocus;
    dbePesqui: TDBComboBoxFocus;
    dbeTipFac: TDBComboBoxFocus;
    dbeTipPar: TDBComboBoxFocus;
    cbxVerVer: TComboBoxFocus;
    btnDirAce: TBitBtnLocked;
    dbeSIMPLE: TcxDBCheckBox;
    dbeDESTOD: TDBEditFocus;
    dbeNRODEC: TDBEditFocus;
    Panel2: TPanel;
    pnlCheckBox: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    dbeValChk: TDBEditFocus;
    dbeValNch: TDBEditFocus;
    dbeChkDef: TcxDBCheckBox;
    pnlDadosBasicos: TPanel;
    Label12: TLabel;
    DBEditFocus2: TDBEditFocus;
    pnlComboBox: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    dbeFacTxt: TDBMemoFocus;
    dbeFacVal: TDBMemoFocus;
    dbeValDef: TDBComboBoxFocus;
    gpbTabPre: TGroupBox;
    Label11: TLabel;
    dbeTabAti: TcxDBCheckBox;
    DBEditFocus1: TDBEditFocus;
    pnlVisible: TPanel;
    Panel3: TPanel;
    bceSQLVIS: TBCEditor;
    Panel4: TPanel;
    dbeExpVis: TDBMemoFocus;
    pnlSQLCHK: TPanel;
    Panel5: TPanel;
    bceSQLCHK: TBCEditor;
    pnlLimChk: TPanel;
    Label14: TLabel;
    dbeLimChk: TDBEditFocus;
    Label15: TLabel;
    dbeLimRet: TDBEditFocus;
    pnlFiltrosPesquisa: TPanel;
    Panel6: TPanel;
    cxvFiltros: TcxGridDBTableView;
    cxgFiltrosLevel1: TcxGridLevel;
    cxgFiltros: TcxGrid;
    cxvFiltrosFILTRO: TcxGridDBColumn;
    cxvFiltrosEXPRES: TcxGridDBColumn;
    dbeDEFEMP: TcxDBCheckBox;
    Label16: TLabel;
    dbeDesGat: TDBEditFocus;
    Label17: TLabel;
    dbeEXPIMP: TDBMemoFocus;
    gpbConfigComboBox: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    dbeCODCFG: TDBEditFocus;
    dbeVALCFG: TcxDBCheckBox;
    dbeTIPCFG: TDBComboBoxFocus;
    dbeEMPCFG: TDBEditFocus;
    procedure dbeTipFacChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeFacTxtExit(Sender: TObject);
    procedure cbxVerVerChange(Sender: TObject);
    procedure dbePesquiChange(Sender: TObject);
    procedure btnDirAceClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dbeSIMPLEClick(Sender: TObject);
  private
    { Private declarations }
    Function fEhComboBoxVerdeVermelho: Boolean;

    procedure pHabilitaVerdeVermelho;

  public
    { Public declarations }
    objInterface: TInterfaceRelatorio;

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmPedeDadosInterface: TfrmPedeDadosInterface;

implementation

{$R *.dfm}

Uses
  untConsultasRel, untCadDirVerdeVermelho, untFuncEditorRel, StrUtils;

procedure TfrmPedeDadosInterface.btnDirAceClick(Sender: TObject);
  Var
    frmCadDirVerdeVermelho : TfrmCadDirVerdeVermelho;
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadDirVerdeVermelho, frmCadDirVerdeVermelho);

    frmCadDirVerdeVermelho.strVerVer := cbxVerVer.Text;

    frmCadDirVerdeVermelho.ShowModal;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmPedeDadosInterface.btnDirAceClick');
    End;

  End;

  pFreeAndNil(frmCadDirVerdeVermelho);

  objInterface.pCarregaSistemaVerdeVermelho;

  cbxVerVer.Items.Text := objInterface.stlVeVerDesc.Text;
  cbxVerVer.ItemIndex  := objInterface.stlVeVerHint.IndexOf(dtsCadPar.DataSet.FieldByName('PAR_VERVER').AsString);
end;

procedure TfrmPedeDadosInterface.cbxVerVerChange(Sender: TObject);
begin
  inherited;

  If dtsCadPar.DataSet.State In dsEditModes Then
  Begin
    If cbxVerVer.ItemIndex > - 1 Then
      dtsCadPar.DataSet.FieldByName('PAR_VERVER').AsString := objInterface.stlVeVerHint[cbxVerVer.ItemIndex]
    Else
      dtsCadPar.DataSet.FieldByName('PAR_VERVER').Clear;
  End;
end;

procedure TfrmPedeDadosInterface.dbeFacTxtExit(Sender: TObject);
  Var
    strDefAnt: String;
begin
  inherited;

  strDefAnt := dbeValDef.Text;

  dbeValDef.Items.Text := dbeFacTxt.Text;

  dbeValDef.ItemIndex := dbeValDef.Items.IndexOf(strDefAnt);
end;

procedure TfrmPedeDadosInterface.pHabilitaVerdeVermelho;
begin
  cbxVerVer.Enabled := (TConsultasRel.fNomePesquisaToTipo(dbePesqui.Text) = pesOperador) Or fEhComboBoxVerdeVermelho;
  lblVerVer.Enabled := cbxVerVer.Enabled Or fEhComboBoxVerdeVermelho;
End;

procedure TfrmPedeDadosInterface.dbePesquiChange(Sender: TObject);
begin
  inherited;

  pHabilitaVerdeVermelho;

  If Not cbxVerVer.Enabled Then
    cbxVerVer.ItemIndex := 0;

  dbeSIMPLE.Enabled := Not fEmptyStr(dbePesqui.Text);

  dbeDEFEMP.Visible := (dbePesqui.Text = 'Empresa') and (dbeSIMPLE.Checked);
  dtsCadPar.DataSet.FieldByName('PAR_DEFEMP').AsString := IIf(dbeDEFEMP.Visible, dtsCadPar.DataSet.FieldByName('PAR_DEFEMP').AsString, 'N');

  objInterface.objConsulta.pCarregaFiltros(objInterface.objConsulta.fNomePesquisaToTipo(dbePesqui.Text), dtsCadPar.DataSet.FieldByName('PAR_FILPES').AsString);
end;

procedure TfrmPedeDadosInterface.dbeSIMPLEClick(Sender: TObject);
begin
  inherited;
  dbeDEFEMP.Visible := (dbePesqui.Text = 'Empresa') and (dbeSIMPLE.Checked);
  dtsCadPar.DataSet.FieldByName('PAR_DEFEMP').AsString := IIf(dbeDEFEMP.Visible, dtsCadPar.DataSet.FieldByName('PAR_DEFEMP').AsString, 'N');
end;

Function TfrmPedeDadosInterface.fEhComboBoxVerdeVermelho: Boolean;
Begin
  Result := (dbeTipFac.ItemIndex = Ord(facComboBoxVerdeVermelho));
End;

procedure TfrmPedeDadosInterface.dbeTipFacChange(Sender: TObject);
begin
  inherited;

  If dbeTipFac.ItemIndex < Ord(facCheckBox) Then
  Begin
    dbeTipPar.ItemIndex := dbeTipFac.ItemIndex;
    dbeTipPar.Field.Value := dbeTipPar.Text;
  End;

  dbeTipPar.Enabled := ((dbeTipFac.ItemIndex = Ord(facCheckBox)) Or
                        (dbeTipFac.ItemIndex = Ord(facComboBox)) Or
                        (dbeTipFac.ItemIndex = Ord(facComboBoxVerdeVermelho)) Or
                        (dbeTipFac.ItemIndex = Ord(facRadioGroup))) And
                       (Not fEhComboBoxVerdeVermelho);

  dbePesqui.Enabled := dbeTipFac.ItemIndex = 0;

  If Not dbePesqui.Enabled Then
    dbePesqui.ItemIndex := 0;

  pnlSQLCHK.Visible       := dbeTipFac.ItemIndex = Ord(facCustomCheckList);
  pnlLimChk.Visible       := dbeTipFac.ItemIndex = Ord(facCustomCheckList);

  pnlFiltrosPesquisa.Visible := dbePesqui.Enabled;

  pnlCheckBox.Visible     := dbeTipFac.ItemIndex = Ord(facCheckBox);
  pnlComboBox.Visible     := (dbeTipFac.ItemIndex = Ord(facCheckBox)) Or
                             (dbeTipFac.ItemIndex = Ord(facComboBox)) Or
                             (dbeTipFac.ItemIndex = Ord(facComboBoxVerdeVermelho)) Or
                             (dbeTipFac.ItemIndex = Ord(facRadioGroup));

  pnlDadosBasicos.Visible := (dbeTipFac.ItemIndex = Ord(facString)) Or (dbeTipFac.ItemIndex = Ord(facInteger)) Or
                             (dbeTipFac.ItemIndex = Ord(facFloat));


  lblNroDec.Visible       := dbeTipFac.ItemIndex = Ord(facFloat);
  dbeNroDec.Visible       := dbeTipFac.ItemIndex = Ord(facFloat);

  dbeFacTxt.Enabled       := Not fEhComboBoxVerdeVermelho;
  dbeFacVal.Enabled       := dbeFacTxt.Enabled;
  gpbTabPre.Enabled       := dbeFacTxt.Enabled;

  If fEhComboBoxVerdeVermelho And (dtsCadPar.DataSet.State In dsEditModes) Then
  Begin
    dtsCadPar.DataSet.FieldByName('PAR_FACTXT').AsString := 'SIM<<csq>>NÃO';
    dtsCadPar.DataSet.FieldByName('PAR_FACVAL').AsString := 'S<<csq>>N';
    dtsCadPar.DataSet.FieldByName('PAR_TABATI').AsString := 'N';
    dtsCadPar.DataSet.FieldByName('PAR_TIPPAR').AsString := 'Texto';

    dbeFacTxtExit(Sender);
  End;

  pHabilitaVerdeVermelho;
end;

procedure TfrmPedeDadosInterface.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  intRecNo: Integer;
  strExpVis,
  strExpImp,
  strSqlVis,
  strSqlChk: String;
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    Try
      dtsCadPar.DataSet.DisableControls;
      Try
        intRecNo := dtsCadPar.DataSet.RecNo;

        strExpVis := dbeExpVis.Text;
        strExpImp := dbeExpImp.Text;
        strSqlVis := bceSQLVIS.Text;
        strSqlChk := bceSQLCHK.Text;

        If fVerificaCampos And
           objInterface.fCompilaExpressao(strExpVis, 'Expressão que torna o parâmetro visível', True) And
           objInterface.fCompilaExpressao(strExpImp, 'Expressão que torna a impressão do filtro visível', True) And
           objInterface.fValidaSQL(bceSQLCHK.Text, True, False, False, 2,
             'As colunas do SELECT dever ser' + #13#10 +
             ' Coluna 1) Descrição do combo;' + #13#10 +
             ' Coluna 2) Chave para a pesquisa;' + #13#10 +
             ' Coluna 3) Descrição da coluna do relatório (Opcional);' + #13#10 +
             ' Coluna 4) Se a opção vem habilitada - True / False (Opcional)') Then
        Begin

          With dtsCadPar.DataSet Do
          If State In dsEditModes Then
          Begin
            RecNo := intRecNo;
            Edit;
            FieldByName('PAR_EXPVIS').AsString := strExpVis;
            FieldByName('PAR_EXPIMP').AsString := strExpImp;
            FieldByName('PAR_SQLVIS').AsString := AnsiReplaceStr(strSqlVis, #13#10, '<<csq>>');
            FieldByName('PAR_SQLCHK').AsString := AnsiReplaceStr(strSqlChk, #13#10, '<<csq>>');
            FieldByName('PAR_FILPES').AsString := objInterface.objConsulta.fRetornaFiltros;
          End;

        End Else
        Begin

          Action := caNone;

        End;
      Finally
        dtsCadPar.DataSet.EnableControls;
      End;
    Except
      dtsCadPar.DataSet.EnableControls;
    End;
  End;

end;

procedure TfrmPedeDadosInterface.FormCreate(Sender: TObject);
begin
  inherited;

  TInterfaceRelatorio.pAjustaEditorSQL(bceSQLVIS);
  TInterfaceRelatorio.pAjustaEditorSQL(bceSQLCHK);
end;

procedure TfrmPedeDadosInterface.FormShow(Sender: TObject);
begin
  inherited;

  If Not (dtsCadPar.DataSet.State In dsEditModes) Then
    dtsCadPar.DataSet.Edit;

  cbxVerVer.Items.Text := objInterface.stlVeVerDesc.Text;
  cbxVerVer.ItemIndex  := objInterface.stlVeVerHint.IndexOf(dtsCadPar.DataSet.FieldByName('PAR_VERVER').AsString);

  dbeTipFacChange(Nil);

  dbeValDef.Items.Text := dbeFacTxt.Text;
  dbeValdef.ItemIndex  := dbeValdef.Items.IndexOf(dtsCadPar.DataSet.FieldByName('PAR_VALDEF').AsString);

  dbePesquiChange(Nil);

  pSetFocus(dbeDesPar);

  dbeSIMPLE.Enabled := Not fEmptyStr(dbePesqui.Text);

  dbeDesGat.Enabled := SameText(dtsCadPar.DataSet.FieldByName('PAR_GATPER').AsString, 'S');

  bceSQLVIS.Text    := AnsiReplaceStr(dtsCadPar.DataSet.FieldByName('PAR_SQLVIS').AsString, '<<csq>>', #13#10);
  bceSQLCHK.Text    := AnsiReplaceStr(dtsCadPar.DataSet.FieldByName('PAR_SQLCHK').AsString, '<<csq>>', #13#10);

//  objInterface.objConsulta.pCarregaFiltros(objInterface.objConsulta.fNomePesquisaToTipo(dbePesqui.Text), dtsCadPar.DataSet.FieldByName('PAR_FILPES').AsString);

  cxvFiltros.DataController.DataSource := objInterface.objConsulta.cdsFiltrosPesquisa.dtsSource;
end;

function TfrmPedeDadosInterface.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = cbxVerVer) Then
    Begin

      {
      If cbxVerVer.Enabled And (cbxVerVer.ItemIndex < 1) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Direito de Acesso para o sistema Verde Vermelho!', ['&Ok']);
        Result := False;
      End;
      }

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
