unit untConsultaRelatMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, untFuncoesSimples, cxCheckBox, untRelatorio, cxTextEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConsultaRelatMenu = class(TfrmPaiEdit)
    cxvItens: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxvItensColumn1: TcxGridDBColumn;
    cxvItensColumn2: TcxGridDBColumn;
    cxvItensColumn3: TcxGridDBColumn;
    cxvItensColumn4: TcxGridDBColumn;
    btnExcluir: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objRelatorio: TRelatorio;
  end;


implementation

{$R *.dfm}

procedure TfrmConsultaRelatMenu.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Confirma a remoção dos relatórios marcados do menu?') Then
    If objRelatorio.fExcluiRelatoriosMenu Then
      pMensagemOk('Relatórios removidos com sucesso!');
end;

end.
