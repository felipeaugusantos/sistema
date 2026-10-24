unit untFatUnificarCartoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, MaskEditFocus, Menus, AppEvnts, Uni, untFormaPagtoNegociada,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxClasses, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridCustomView, cxGrid,
  cxCheckBox, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatUnificarCartoes = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    btnConfirma: TBitBtnLocked;
    cxgFormasNegociadas: TcxGrid;
    cxgFormasNegociadasView: TcxGridDBBandedTableView;
    cxgFormasNegociadasViewDESCAR: TcxGridDBBandedColumn;
    cxgFormasNegociadasViewVALCAR: TcxGridDBBandedColumn;
    cxgFormasNegociadasLevel: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    Panel1: TPanel;
    lblInfo: TLabel;
    dtsCartoes: TDataSource;
    cxgFormasNegociadasViewMARCAD: TcxGridDBBandedColumn;
    cxgFormasNegociadasViewVALREC: TcxGridDBBandedColumn;
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgFormasNegociadasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    objUnificarCartoes: TUnificarCartoesNegociados;
  end;

var
  frmFatUnificarCartoes: TfrmFatUnificarCartoes;

implementation

uses untFuncoesSimples, untPesqAux, untPai, untTypesSistema,
     untConsultas;

{$R *.dfm}

procedure TfrmFatUnificarCartoes.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatUnificarCartoes.cxgFormasNegociadasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: btnSair.Click;
  End;
end;

procedure TfrmFatUnificarCartoes.FormShow(Sender: TObject);
begin
  inherited;
  dtsCartoes.DataSet := objUnificarCartoes.cdsCartoes;
end;

procedure TfrmFatUnificarCartoes.btnConfirmaClick(Sender: TObject);
begin                             
  inherited;
  If objUnificarCartoes.fUnificarCartoesNegociados Then
    Close;
end;

end.


