unit untMostraRequisicoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid;

type
  TOperacao = (opCancela, opDesvincula, opNega);

  TfrmMostraRequisicoes = class(TfrmPaiEdit)
    cxgReq: TcxGrid;
    cxgReqView: TcxGridDBTableView;
    cxgReqViewNEGADA: TcxGridDBColumn;
    cxgReqViewMARANT: TcxGridDBColumn;
    cxgReqViewAUTOINCREM: TcxGridDBColumn;
    cxgReqViewCODREQ: TcxGridDBColumn;
    cxgReqViewCODEMP: TcxGridDBColumn;
    cxgReqViewDTACAD: TcxGridDBColumn;
    cxgReqViewNOMOPE: TcxGridDBColumn;
    cxgReqViewNOMCLI: TcxGridDBColumn;
    cxgReqViewPRODUT: TcxGridDBColumn;
    cxgReqViewCODITE: TcxGridDBColumn;
    cxgReqViewDESITE: TcxGridDBColumn;
    cxgReqViewREFERE: TcxGridDBColumn;
    cxgReqViewSIGUNI: TcxGridDBColumn;
    cxgReqViewCODFAB: TcxGridDBColumn;
    cxgReqViewQTDORI: TcxGridDBColumn;
    cxgReqViewQTDITE: TcxGridDBColumn;
    cxgReqViewMARDES: TcxGridDBColumn;
    cxgReqViewDEPITE: TcxGridDBColumn;
    cxgReqViewDOCPDV: TcxGridDBColumn;
    cxgReqViewESPPDV: TcxGridDBColumn;
    cxgReqViewEMPPDV: TcxGridDBColumn;
    cxgReqViewCODFOR: TcxGridDBColumn;
    cxgReqViewNOMFOR: TcxGridDBColumn;
    cxgReqViewDESMAR: TcxGridDBColumn;
    cxgReqViewAUTDET: TcxGridDBColumn;
    cxgReqViewSALDIS: TcxGridDBColumn;
    cxgReqViewQTDPEN: TcxGridDBColumn;
    cxgReqViewREQPCD: TcxGridDBColumn;
    cxgReqViewQTDPEN_TODAS: TcxGridDBColumn;
    cxgReqViewQTDDIS_TODAS: TcxGridDBColumn;
    cxgReqViewOPERES: TcxGridDBColumn;
    cxgReqViewNOMRES: TcxGridDBColumn;
    cxgReqViewNOMLIN: TcxGridDBColumn;
    cxgReqViewNOMGRU: TcxGridDBColumn;
    cxgReqViewNOTAS: TcxGridDBColumn;
    cxgCliCnd: TcxGridLevel;
    btnSoDesmarca: TBitBtnLocked;
    Panel1: TPanel;
    btnNegar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSoDesmarcaClick(Sender: TObject);
    procedure btnNegarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    opOperacao: TOperacao;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

procedure TfrmMostraRequisicoes.btnNegarClick(Sender: TObject);
begin
  inherited;

  If fPergunta('Confirma negar todas as requisições acima?') Then
  Begin
    opOperacao := opNega;
    Close;
  End

  Else opOperacao := opCancela;
end;

procedure TfrmMostraRequisicoes.btnSoDesmarcaClick(Sender: TObject);
begin
  inherited;

  opOperacao := opDesvincula;
  Close;
end;

procedure TfrmMostraRequisicoes.FormCreate(Sender: TObject);
begin
  inherited;

  opOperacao := opCancela;
end;

procedure TfrmMostraRequisicoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F8 : btnNegar.Click;
    VK_F10: btnSoDesmarca.Click;
  End;
end;

end.
