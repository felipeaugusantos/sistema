unit untRelFatVendasPorLinha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView, UniClientDataSet,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRelFatVendasPorLinha = class(TfrmPai)
    dtsDados: TDataSource;
    pnlTopo: TPanel;
    lblVendedor: TLabel;
    cxDadosView: TcxGridDBTableView;
    cxDadosNivel: TcxGridLevel;
    cxDados: TcxGrid;
    cxDadosViewCODLIN: TcxGridDBColumn;
    cxDadosViewQTDITE: TcxGridDBColumn;
    cxDadosViewTOTITE: TcxGridDBColumn;
    cxDadosViewQTDVEN: TcxGridDBColumn;
    cxDadosViewTOTVEN: TcxGridDBColumn;
    cxDadosViewTOTGER: TcxGridDBColumn;
    pnlDados: TPanel;
    lblTitMetas: TLabel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleFooter: TcxStyle;
    cxStyleHeader: TcxStyle;
    cxDadosViewDESLIN: TcxGridDBColumn;
    lblMetas: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pAgrupaVendendo;
  public
    { Public declarations }
    oleVendas: OleVariant;
    cdsDados : TUniClientDataSet;
  end;


implementation

uses
 untIFuncoes, untTypesSistema, untFuncoesSimples;

{$R *.dfm}

procedure TfrmRelFatVendasPorLinha.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRelFatVendasPorLinha.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsDados);
end;

procedure TfrmRelFatVendasPorLinha.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TUniClientDataSet.Create(Self);
end;

procedure TfrmRelFatVendasPorLinha.FormShow(Sender: TObject);
begin
  inherited;
  dtsDados.DataSet := cdsDados;
  pAgrupaVendendo;
  With cdsDados Do
  Begin
    (FieldByName('QTDITE') As TFloatField).DisplayFormat := '0.00';
    (FieldByName('TOTITE') As TFloatField).DisplayFormat := ',#0.00';
    (FieldByName('QTDVEN') As TFloatField).DisplayFormat := '0.00';
    (FieldByName('TOTVEN') As TFloatField).DisplayFormat := ',#0.00';
    (FieldByName('TOTGER') As TFloatField).DisplayFormat := ',#0.00';
  End;
end;

procedure TfrmRelFatVendasPorLinha.pAgrupaVendendo;
  Var
    cdsVendas: TUniClientDataSet;
    prcScroll: TprcScroll;
begin
  cdsVendas := TUniClientDataSet.Create(Self);
  cdsVendas.Data := oleVendas;
  Try
    pDisableControls(cdsDados, prcScroll);

    cdsVendas.First;
    While Not cdsVendas.Eof Do
    Begin
      cdsDados.Filtered := False;
      cdsDados.Filter   := 'CODLIN = ' + QuotedStr(Copy(cdsVendas.FieldByName('ITE_CODGRU').AsString, 1, 3) + '.000');
      cdsDados.Filtered := True;
      If (cdsDados.RecordCount > 0) Then
      Begin
        cdsDados.Edit;
        cdsDados.FieldByName('QTDVEN').AsFloat := cdsDados.FieldByName('QTDVEN').AsFloat + cdsVendas.FieldByName('ITE_QTDITE').AsFloat;
        cdsDados.FieldByName('TOTVEN').AsFloat := cdsDados.FieldByName('TOTVEN').AsFloat + cdsVendas.FieldByName('ITE_TOTITE').AsFloat;
        cdsDados.FieldByName('TOTGER').AsFloat := cdsDados.FieldByName('TOTVEN').AsFloat + cdsDados.FieldByName('TOTITE').AsFloat;
        cdsDados.Post;
      End;
      cdsVendas.Next;
    End;
    cdsDados.Filtered        := False;
    cdsDados.IndexFieldNames := 'CODLIN';

  Finally
    pEnableControls(cdsDados, prcScroll);
  End;
end;

end.
