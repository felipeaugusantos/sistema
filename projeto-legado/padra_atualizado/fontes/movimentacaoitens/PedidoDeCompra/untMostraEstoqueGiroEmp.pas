unit untMostraEstoqueGiroEmp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Grids, DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem,
  Data.DB, frxClass, frxExportCSVTestabilidade, untCfgGrid, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid;

type
  TfrmMostraEstoqueGiroEmp = class(TfrmPai)
    pnlGiroMeses: TPanel;
    lblQtdM04: TLabel;
    dbeQtdM04: TDBEditFocus;
    lblQtdM05: TLabel;
    dbeQtdM05: TDBEditFocus;
    lblQtdM06: TLabel;
    dbeQtdM06: TDBEditFocus;
    lblQtdM07: TLabel;
    dbeQtdM07: TDBEditFocus;
    lblQtdM08: TLabel;
    dbeQtdM08: TDBEditFocus;
    lblQtdM09: TLabel;
    dbeQtdM09: TDBEditFocus;
    lblQtdM10: TLabel;
    dbeQtdM10: TDBEditFocus;
    lblQtdM11: TLabel;
    dbeQtdM11: TDBEditFocus;
    lblQtdM12: TLabel;
    dbeQtdM12: TDBEditFocus;
    Panel2: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtItem: TEditFocus;
    btnCfgGri: TBitBtnLocked;
    BitBtnLocked2: TBitBtnLocked;
    cxgEstoque: TcxGrid;
    cxvEstoque: TcxGridDBTableView;
    cxgEstoqueLevel1: TcxGridLevel;
    cxvEstoqueCODEMP: TcxGridDBColumn;
    cxvEstoqueNOMEMP: TcxGridDBColumn;
    cxvEstoqueMES001: TcxGridDBColumn;
    cxvEstoqueMES002: TcxGridDBColumn;
    cxvEstoqueMES003: TcxGridDBColumn;
    cxvEstoqueMEDIA: TcxGridDBColumn;
    cxvEstoqueSALDOS: TcxGridDBColumn;
    cxvEstoqueENTFUT: TcxGridDBColumn;
    btnPreparacaoTE: TBitBtnLocked;
    cxvEstoqueMESATU: TcxGridDBColumn;
    cxvEstoqueSALDIS: TcxGridDBColumn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCfgGriClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtnLocked2Click(Sender: TObject);
    procedure btnPreparacaoTEClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    objCfgGri: TCfgGrid;
    { Private declarations }
  public
    { Public declarations }
    var
      strCodIte: String;
  end;

var
  frmMostraEstoqueGiroEmp: TfrmMostraEstoqueGiroEmp;

implementation

uses
  untFuncoesSimples, untPreparaGeracaoTE;

{$R *.dfm}

procedure TfrmMostraEstoqueGiroEmp.BitBtnLocked2Click(Sender: TObject);
begin
  inherited;
  objCfgGri.pAjustarLarguraColunas;
end;

procedure TfrmMostraEstoqueGiroEmp.btnCfgGriClick(Sender: TObject);
begin
  inherited;
  objCfgGri.pConfiguraColunas;
end;

procedure TfrmMostraEstoqueGiroEmp.btnPreparacaoTEClick(Sender: TObject);
var
  objPreparaGer: TPreparaGeracaoTE;
begin
  inherited;
  Try
  	objPreparaGer := TPreparaGeracaoTE.Create;
  	objPreparaGer.pInformaPreparacao(strCodIte);
  Finally
  	FreeAndNil(objPreparaGer);
  End;
end;

procedure TfrmMostraEstoqueGiroEmp.FormCreate(Sender: TObject);
begin
  inherited;
  objCfgGri := TCfgGrid.Create(Self, cxvEstoque, Caption, [], '', False, True);
  objCfgGri.fCarregarConfiguracaoGrid;
end;

procedure TfrmMostraEstoqueGiroEmp.FormDestroy(Sender: TObject);
begin
  inherited;
  objCfgGri.fSalvarConfiguracaoGrid;
  FreeAndNil(objCfgGri);
end;

procedure TfrmMostraEstoqueGiroEmp.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: btnSair.Click;
    VK_F5: If btnPreparacaoTE.Visible Then
              btnPreparacaoTE.Click;
  End;
  If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;
end;


procedure TfrmMostraEstoqueGiroEmp.FormShow(Sender: TObject);
begin
  inherited;
  If Assigned(cxvEstoque.DataController) Then
    If Assigned(cxvEstoque.DataController.DataSource) Then
      If Assigned(cxvEstoque.DataController.DataSource.DataSet) Then
        cxvEstoqueSALDIS.Visible := Assigned(cxvEstoque.DataController.DataSource.DataSet.FindField('SALDIS'));
end;

end.
