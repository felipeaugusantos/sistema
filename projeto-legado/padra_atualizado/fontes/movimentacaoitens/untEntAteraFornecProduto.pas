unit untEntAteraFornecProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox,
  untAlteraFornecedorEntrada, cxCurrencyEdit, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmEntAteraFornecProduto = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensSELECI: TcxGridDBColumn;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensSIGUNI: TcxGridDBColumn;
    cxgItensCODFOR: TcxGridDBColumn;
    cxgItensNOMFOR: TcxGridDBColumn;
    cxgItensDTAULT: TcxGridDBColumn;
    cxgItensPREULT: TcxGridDBColumn;
    cxgItensIMPULT: TcxGridDBColumn;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgItensSELECIPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirma: Boolean;
    objAltFor: TAlteraFornecedorEntrada;
  end;


implementation

uses  untFuncoesSimples;

{$R *.dfm}

procedure TfrmEntAteraFornecProduto.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  blnConfirma := objAltFor.fComfirmaAlteracao;

  If blnConfirma Then
    Close;

end;

procedure TfrmEntAteraFornecProduto.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  objAltFor.pMarcaTodos(False);

end;

procedure TfrmEntAteraFornecProduto.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  objAltFor.pMarcaTodos(True);
end;

procedure TfrmEntAteraFornecProduto.cxgItensSELECIPropertiesChange(
  Sender: TObject);
begin
  inherited;

  If objAltFor.State = dsEdit Then
    objAltFor.Post;
end;

procedure TfrmEntAteraFornecProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (Not blnConfirma) And (Not fPergunta('Deseja sair sem alterar o fornecedor dos itens?')) Then
    Action := caNone;
end;

procedure TfrmEntAteraFornecProduto.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma := False;
  pSetFocus(btnConfirma);
end;

procedure TfrmEntAteraFornecProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6:  btnMarcaTodos.Click;
    VK_F7:  btnDesmarcaTodos.Click;
    VK_F10: btnConfirma.Click;
  End;
    
end;

end.


