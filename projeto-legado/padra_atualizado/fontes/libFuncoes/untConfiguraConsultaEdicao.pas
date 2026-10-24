unit untConfiguraConsultaEdicao;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, DB, cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  untConfiguraConsulta, cxContainer, cxDropDownEdit, dxColorEdit,
  cxTextEdit, cxMaskEdit, cxColorComboBox, cxPropertiesStore,
  ComCtrls, Spin, Classes,  untFuncoesGen,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxCore,
  cxImageComboBox, cxGridCitel, System.ImageList, Vcl.ImgList, cxImageList,
  dxGDIPlusClasses, cxImage, Vcl.Grids, Vcl.DBGrids, ComboBoxFocus;

type
  TfrmConfiguraConsultaEdicao = class(TForm)
    pnlBotoes: TPanel;
    btnGravar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    dtsColunas: TDataSource;
    dtsColSel: TDataSource;
    dtsCadEmp: TDataSource;
    pgcPesquisa: TPageControl;
    tbsGerais: TTabSheet;
    tbsEmpresas: TTabSheet;
    tbsFullText: TTabSheet;
    Panel4: TPanel;
    Panel3: TPanel;
    cxgColunas: TcxGrid;
    cxgColunasView: TcxGridDBTableView;
    cxgColunasEXIBIR: TcxGridDBColumn;
    cxgColunasPESQUI: TcxGridDBColumn;
    cxgColunasDESCAM: TcxGridDBColumn;
    cxgColunasNOMCAM: TcxGridDBColumn;
    cxgColunasLevel1: TcxGridLevel;
    Panel5: TPanel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    Panel1: TPanel;
    pnlUpDown: TPanel;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    cxgSelecionadas: TcxGrid;
    cxgSelecionadasView: TcxGridDBTableView;
    cxgSelecionadasORDCAM: TcxGridDBColumn;
    cxgSelecionadasDESCAM: TcxGridDBColumn;
    cxgSelecionadasNOMCAM: TcxGridDBColumn;
    cxgSelecionadasCOMZER: TcxGridDBColumn;
    cxgSelecionadasLevel1: TcxGridLevel;
    pnlKey: TPanel;
    rdgTipPes: TRadioGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    chkZebra: TCheckBox;
    dccZebra: TdxColorEdit;
    rdgAliPes: TRadioGroup;
    spnTanFon: TSpinEdit;
    Panel2: TPanel;
    Panel6: TPanel;
    cxgEmpresas: TcxGrid;
    cxgEmpresasView: TcxGridDBTableView;
    cxgEmpresasSELECI: TcxGridDBColumn;
    cxgEmpresasCODEMP: TcxGridDBColumn;
    cxgEmpresasNOMEMP: TcxGridDBColumn;
    cxgEmpresasLevel1: TcxGridLevel;
    Panel7: TPanel;
    cxgIndicesView: TcxGridDBTableView;
    cxgIndicesLevel1: TcxGridLevel;
    cxgIndices: TcxGrid;
    cxgIndicesViewColumn1: TcxGridDBColumn;
    cxgIndicesViewColumn2: TcxGridDBColumn;
    cxgIndicesViewColumn3: TcxGridDBColumn;
    dtsFulltext: TDataSource;
    cxgIndicesViewColumn4: TcxGridDBColumn;
    chkConsCo: TCheckBox;
    Panel8: TPanel;
    btnMarcaEmp: TBitBtnLocked;
    btnDesmarcaEmp: TBitBtnLocked;
    cxgColunasCONTID: TcxGridDBColumn;
    chkFetch: TCheckBox;
    cxgColunasAUTSEL: TcxGridDBColumn;
    chkExpandida: TCheckBox;
    tbsOperadores: TTabSheet;
    Panel13: TPanel;
    dtsCadOpe: TDataSource;
    cxEstilos: TcxStyleRepository;
    cxStyle1: TcxStyle;
    dtsCadGpo: TDataSource;
    pnlDirOpe: TPanel;
    cxgCadOpe: TcxGridCitel;
    tbvCadOpe: TcxGridDBTableViewCitel;
    OPE_CODOPE: TcxGridDBColumn;
    OPE_NOMOPE: TcxGridDBColumn;
    OPE_MARDES: TcxGridDBColumn;
    cxgCadOpeLevel1: TcxGridLevel;
    Panel9: TPanel;
    btnMarOpe: TBitBtnLocked;
    btnMarOpeTot: TBitBtnLocked;
    btnDesOpeTot: TBitBtnLocked;
    Panel10: TPanel;
    Label2: TLabel;
    pnlDirGpo: TPanel;
    cxgCadGpo: TcxGridCitel;
    tbvCadGpo: TcxGridDBTableViewCitel;
    GPO_CODGPO: TcxGridDBColumn;
    GPO_DESCRI: TcxGridDBColumn;
    GPO_MARDES: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    Panel11: TPanel;
    btnMarGru: TBitBtnLocked;
    btnMarGruTot: TBitBtnLocked;
    btnDesGruTot: TBitBtnLocked;
    Panel12: TPanel;
    Label3: TLabel;
    Panel14: TPanel;
    lblAltGrd: TLabel;
    cxgSelecionadasPERIOD: TcxGridDBColumn;
    chkFilObr: TCheckBox;
    cxgSelecionadasOBRIGA: TcxGridDBColumn;
    chkFilBra: TCheckBox;
    cxgSelecionadasQTDCAR: TcxGridDBColumn;
    cxgSelecionadasGRUOBR: TcxGridDBColumn;
    cxgSelecionadasTIPDAD: TcxGridDBColumn;
    procedure cxgColunasEXIBIRPropertiesChange(Sender: TObject);
    procedure cxgColunasPESQUIPropertiesChange(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgEmpresasSELECIPropertiesChange(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure rdgTipPesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaEmpClick(Sender: TObject);
    procedure btnDesmarcaEmpClick(Sender: TObject);
    procedure chkConsCoClick(Sender: TObject);
    procedure tbvCadOpeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbvCadGpoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarOpeClick(Sender: TObject);
    procedure btnMarOpeTotClick(Sender: TObject);
    procedure btnDesOpeTotClick(Sender: TObject);
    procedure btnMarGruClick(Sender: TObject);
    procedure btnMarGruTotClick(Sender: TObject);
    procedure btnDesGruTotClick(Sender: TObject);
    procedure tbvCadOpeDblClick(Sender: TObject);
    procedure tbvCadGpoDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgSelecionadasPERIODPropertiesChange(Sender: TObject);
    procedure cxgSelecionadasQTDCARCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgSelecionadasCOMZERCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgSelecionadasEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objConfig: TConfiguraConsulta;
  end;

var
  frmConfiguraConsultaEdicao: TfrmConfiguraConsultaEdicao;

implementation

{$R *.dfm}

procedure TfrmConfiguraConsultaEdicao.btnDesGruTotClick(Sender: TObject);
begin
  objConfig.objConfigOperadores.pMarcaDesmarcaTotalGrupo(False);
end;

procedure TfrmConfiguraConsultaEdicao.btnDesmarcaEmpClick(Sender: TObject);
begin
  objConfig.pMarcaEmpresas(False);
end;

procedure TfrmConfiguraConsultaEdicao.btnDesmarcaTodosClick(Sender: TObject);
begin
  objConfig.pMarcaExibirTodos(False);
end;

procedure TfrmConfiguraConsultaEdicao.btnDesOpeTotClick(Sender: TObject);
begin
  objConfig.objConfigOperadores.pMarcaDesmarcaTotalOperador(False);
end;

procedure TfrmConfiguraConsultaEdicao.btnDownClick(Sender: TObject);
begin

  objConfig.pAlteraOrdemColuna(False);
end;

procedure TfrmConfiguraConsultaEdicao.btnGravarClick(Sender: TObject);
begin
  If Not (chkConsCo.Visible And chkConsCo.Enabled) Then
    chkConsCo.Checked := False;
end;

procedure TfrmConfiguraConsultaEdicao.btnMarcaEmpClick(Sender: TObject);
begin
  objConfig.pMarcaEmpresas(True);
end;

procedure TfrmConfiguraConsultaEdicao.btnMarcaTodosClick(Sender: TObject);
begin

  objConfig.pMarcaExibirTodos(True);
end;

procedure TfrmConfiguraConsultaEdicao.btnMarGruClick(Sender: TObject);
begin
  objConfig.objConfigOperadores.pMarcaDesmarcaGrupo(objConfig.objConfigOperadores.getMarcarGpo);
end;

procedure TfrmConfiguraConsultaEdicao.btnMarGruTotClick(Sender: TObject);
begin
  objConfig.objConfigOperadores.pMarcaDesmarcaTotalGrupo(True);
end;

procedure TfrmConfiguraConsultaEdicao.btnMarOpeClick(Sender: TObject);
begin
  objConfig.objConfigOperadores.pMarcaDesmarcaOperador(objConfig.objConfigOperadores.getMarcarOpe);
end;

procedure TfrmConfiguraConsultaEdicao.btnMarOpeTotClick(Sender: TObject);
begin
  objConfig.objConfigOperadores.pMarcaDesmarcaTotalOperador(True);
end;

procedure TfrmConfiguraConsultaEdicao.btnUpClick(Sender: TObject);
begin

  objConfig.pAlteraOrdemColuna(True);
end;

procedure TfrmConfiguraConsultaEdicao.chkConsCoClick(Sender: TObject);
begin
  cxgColunasCONTID.Options.Editing := Not chkConsCo.Checked;
  cxgColunasCONTID.Visible         := Not chkConsCo.Checked;
end;

procedure TfrmConfiguraConsultaEdicao.cxgColunasEXIBIRPropertiesChange(
  Sender: TObject);
begin

 If objConfig.cdsColunas.State = dsEdit then
   objConfig.cdsColunas.Post;

end;

procedure TfrmConfiguraConsultaEdicao.cxgColunasPESQUIPropertiesChange(
  Sender: TObject);
begin

 If objConfig.cdsColunas.State = dsEdit then
 Begin
   objConfig.cdsColunas.Post;

   objConfig.pVerificaLimitePesquisa;
 End;

end;

procedure TfrmConfiguraConsultaEdicao.cxgEmpresasSELECIPropertiesChange(
  Sender: TObject);
begin
  If dtsCadEmp.DataSet.State = dsEdit then
    dtsCadEmp.DataSet.Post;
end;

procedure TfrmConfiguraConsultaEdicao.cxgSelecionadasCOMZERCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If  objConfig.fEhFiltroTravado(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSelecionadasNOMCAM.Index])) Then
    ACanvas.Brush.Color := clGray;
end;

procedure TfrmConfiguraConsultaEdicao.cxgSelecionadasEnter(Sender: TObject);
begin
  objConfig.cdsColSelec.AfterScroll(objConfig.cdsColSelec);
end;

procedure TfrmConfiguraConsultaEdicao.cxgSelecionadasPERIODPropertiesChange(
  Sender: TObject);
begin
  If objConfig.cdsColSelec.State = dsEdit then
  Begin
    If (Pos(objConfig.cdsColSelec.FieldByName('TIPDAD').AsString, 'ftDate_ftDateTime_ftTime_') <= 0) Then
    Begin
      objConfig.cdsColSelec.FieldByName('PERIOD').AsString := 'N';
      fMensagem('ATENÇÃO', 'A coluna ' + objConfig.cdsColSelec.FieldByName('DESCAM').AsString + ' não é do tipo "Data"!', ['&O k']);
    End;

    objConfig.cdsColSelec.Post;

    objConfig.pVerificaLimitePesquisaSel;
  End;
end;

procedure TfrmConfiguraConsultaEdicao.cxgSelecionadasQTDCARCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  If ((VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSelecionadasTIPDAD.Index])) <> 'ftString') Or
      objConfig.fTemTamanhoMinimo(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSelecionadasNOMCAM.Index])) Then
    ACanvas.Brush.Color := clGray;
end;

procedure TfrmConfiguraConsultaEdicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If ModalResult = mrOk Then
  Begin

     If Not objConfig.fValidaConsulta Then
     Begin
       Action := caNone;
     End Else
     Begin
       objConfig.cdsColSelec.AfterScroll := Nil;
     End

  End;

end;

procedure TfrmConfiguraConsultaEdicao.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmConfiguraConsultaEdicao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  If pgcPesquisa.ActivePage = tbsOPeradores Then
  Begin
    If (Key = VK_F11) Then
    Begin
      If (cxgCadOpe.IsFocused) Then
        pSetFocus(cxgCadGpo)
      Else
        pSetFocus(cxgCadOpe);
    End;
  End;

  Case Key of
    VK_ESCAPE: Close;

    VK_RETURN: SelectNext(ActiveControl, True, True);

    VK_F6: If pgcPesquisa.ActivePage = tbsEmpresas Then
             btnMarcaEmp.Click;
    VK_F7: If pgcPesquisa.ActivePage = tbsEmpresas Then
             btnDesmarcaEmp.Click;
  End;

end;

procedure TfrmConfiguraConsultaEdicao.FormShow(Sender: TObject);
  Var
    intPage: Integer;
    intVisible: Integer;
begin
  Self.Caption := 'Configuração da Consulta (' + objConfig.strChaveConsulta + ')';

  pSetFocus(TWinControl(rdgTipPes.Controls[rdgTipPes.ItemIndex]));

  frmConfiguraConsultaEdicao.dtsColunas.DataSet := objConfig.cdsColunas;
  frmConfiguraConsultaEdicao.dtsColSel.DataSet  := objConfig.cdsColSelec;

  pgcPesquisa.ActivePageIndex := 0;

  rdgTipPesClick(rdgTipPes);

  cxgColunasCONTID.Options.Editing := Not chkConsCo.Checked;
  cxgColunasCONTID.Visible         := Not chkConsCo.Checked;

  If Not fCfgSis('CONSCO', VarBoolean) Then
    cxgColunasCONTID.Visible := False;

  dtsCadOpe.DataSet := objConfig.objConfigOperadores.getCdsOpe;
  dtsCadGpo.DataSet := objConfig.objConfigOperadores.getCdsGpo;

  tbsOperadores.TabVisible := fCfgSis('CONOPE', VarBoolean) And
    fVerificaAcessoSistema('frmConsultaCxGridNovaConfigOperador');

  tbsEmpresas.TabVisible   := Not fCfgSis('CONOPE', VarBoolean);

  intVisible := 0;
  For intPage := 0 To pgcPesquisa.PageCount -1 Do
    If pgcPesquisa.Pages[intPage].TabVisible Then
    Begin
      Inc(intVisible);
      pgcPesquisa.Pages[intPage].Caption := '&' +
        intVisible.ToString + ' - ' + pgcPesquisa.Pages[intPage].Caption;
    End;

  objConfig.cdsColSelec.AfterScroll := objConfig.pAfterScrollColSelec;
end;

procedure TfrmConfiguraConsultaEdicao.rdgTipPesClick(Sender: TObject);
begin
  cxgSelecionadasCOMZER.Visible := rdgTipPes.ItemIndex = 1;
  chkConsCo.Enabled := rdgTipPes.ItemIndex = 1;
  If Not (chkConsCo.Visible And chkConsCo.Enabled) Then
    chkConsCo.Checked := False;
end;

procedure TfrmConfiguraConsultaEdicao.tbvCadGpoDblClick(Sender: TObject);
begin
  btnMarGru.Click;
end;

procedure TfrmConfiguraConsultaEdicao.tbvCadGpoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_RETURN) Then
    objConfig.objConfigOperadores.pMarcaDesmarcaGrupo(objConfig.objConfigOperadores.getMarcarGpo);
end;

procedure TfrmConfiguraConsultaEdicao.tbvCadOpeDblClick(Sender: TObject);
begin
  btnMarOpe.Click;
end;

procedure TfrmConfiguraConsultaEdicao.tbvCadOpeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_RETURN) Then
    objConfig.objConfigOperadores.pMarcaDesmarcaOperador(objConfig.objConfigOperadores.getMarcarOpe);
end;

end.
