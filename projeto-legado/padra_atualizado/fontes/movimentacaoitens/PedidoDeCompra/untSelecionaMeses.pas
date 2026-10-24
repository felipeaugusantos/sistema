unit untSelecionaMeses;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  cxCheckBox, untMesesGiro, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmSelecionaMeses = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensAno: TcxGridDBColumn;
    cxgItensMES: TcxGridDBColumn;
    cxgItensSEL: TcxGridDBColumn;
    btnDesmarcaTodos: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxgItensSELPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cdsMeses : TMesesGiro;
  end;

implementation

{$R *.dfm}

procedure TfrmSelecionaMeses.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  cdsMeses.pDesmarcaTodos;
end;

procedure TfrmSelecionaMeses.cxgItensSELPropertiesChange(Sender: TObject);
begin
  inherited;

  cdsMeses.Post;
end;

procedure TfrmSelecionaMeses.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If Not cdsMeses.fValidaMeses(cdsMeses.intQtdMes) Then
    Begin
      Action := caNone;
      pMensagemOk('Selecione ' + IntToStr(cdsMeses.intQtdMes) + ' meses para o giro!');
    End;
  End;
end;

procedure TfrmSelecionaMeses.FormShow(Sender: TObject);
begin
  inherited;

  cxgItensView.DataController.DataSource := cdsMeses.dtsSource;
  cxgItensView.NavigatorButtons.First.Click;
end;

end.
