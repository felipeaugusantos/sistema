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
  untConfiguraConsulta, untFuncoes, cxContainer, cxDropDownEdit, dxColorEdit,
  cxTextEdit, cxMaskEdit, cxColorComboBox, cxPropertiesStore, 
  ComCtrls, Spin, Classes;

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

procedure TfrmConfiguraConsultaEdicao.btnDesmarcaEmpClick(Sender: TObject);
begin
  objConfig.pMarcaEmpresas(False);
end;

procedure TfrmConfiguraConsultaEdicao.btnDesmarcaTodosClick(Sender: TObject);
begin
  objConfig.pMarcaExibirTodos(False);
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

procedure TfrmConfiguraConsultaEdicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If ModalResult = mrOk Then
  Begin

     If Not objConfig.fValidaConsulta Then
       Action := caNone;

  End;

end;

procedure TfrmConfiguraConsultaEdicao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key of
    VK_F6: If pgcPesquisa.ActivePage = tbsEmpresas Then
             btnMarcaEmp.Click;
    VK_F7: If pgcPesquisa.ActivePage = tbsEmpresas Then
             btnDesmarcaEmp.Click;
  End;
end;

procedure TfrmConfiguraConsultaEdicao.FormShow(Sender: TObject);
begin
  pSetFocus(TWinControl(rdgTipPes.Controls[rdgTipPes.ItemIndex]));

  frmConfiguraConsultaEdicao.dtsColunas.DataSet := objConfig.cdsColunas;
  frmConfiguraConsultaEdicao.dtsColSel.DataSet  := objConfig.cdsColSelec;

  pgcPesquisa.ActivePageIndex := 0;

  rdgTipPesClick(rdgTipPes);

  cxgColunasCONTID.Options.Editing := Not chkConsCo.Checked;
  cxgColunasCONTID.Visible         := Not chkConsCo.Checked;
end;

procedure TfrmConfiguraConsultaEdicao.rdgTipPesClick(Sender: TObject);
begin
  cxgSelecionadasCOMZER.Visible := rdgTipPes.ItemIndex = 1;
  chkConsCo.Enabled := rdgTipPes.ItemIndex = 1;
  If Not (chkConsCo.Visible And chkConsCo.Enabled) Then
    chkConsCo.Checked := False;
end;

end.
