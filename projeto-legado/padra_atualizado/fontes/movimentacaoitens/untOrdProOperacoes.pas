unit untOrdProOperacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  cxGridBandedTableView, cxGridDBBandedTableView, untFuncoesSimples,
  untOrdPro, cxDataControllerConditionalFormattingRulesManagerDialog,
  UniClientDataSet;

type
  TfrmOrdProOperacoes = class(TfrmPaiEdit)
    cxgOperacoesLevel1: TcxGridLevel;
    cxgOperacoes: TcxGrid;
    cxgOperacoesView: TcxGridDBBandedTableView;
    cxgOperacoesViewColumn1: TcxGridDBBandedColumn;
    cxgOperacoesViewColumn2: TcxGridDBBandedColumn;
    cxgOperacoesViewColumn3: TcxGridDBBandedColumn;
    cxgOperacoesViewColumn4: TcxGridDBBandedColumn;
    cxgOperacoesViewColumn5: TcxGridDBBandedColumn;
    cxgOperacoesViewColumn6: TcxGridDBBandedColumn;
    cxgOperacoesViewColumn7: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnCanOpe: TBitBtnLocked;
    cxgOperacoesViewColumn8: TcxGridDBBandedColumn;
    dtsOperacoes: TDataSource;
    mmoAviso: TMemo;
    pnlInfoPrdAca: TPanel;
    Label2: TLabel;
    Label7: TLabel;
    lblUnidade: TLabel;
    lblCodFab: TLabel;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    edtReferencia: TEditFocus;
    edtSigUni: TEditFocus;
    edtCodFabrica: TEditFocus;
    procedure cxgOperacoesViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnCanOpeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure pCarreDadosOP;
  public
    { Public declarations }
    blnMonitoramento: Boolean;
    cdsSubProdutos: TUniClientDataSet;
    objOrdPro: TOrdPro;
  end;

var
  frmOrdProOperacoes: TfrmOrdProOperacoes;

implementation

{$R *.dfm}

procedure TfrmOrdProOperacoes.btnCanOpeClick(Sender: TObject);
begin
  inherited;

  If Not btnCanOPe.Visible Then
    Exit;

  With objOrdPro.objMonitor do
  Begin
    With cdsOperacoes do
    Begin
      If IsEmpty Then
        Exit;

      If FieldByName('MNT_DTAFIN').IsNull Then
      Begin
        If Not fPergunta('Deseja cancelar o início do processo da Fase ' + FieldByName('FAS_DESFAS').AsString + '?') Then
          Exit;
      End Else
      Begin
        If Not fPergunta('Deseja cancelar o final da processo da Fase ' + FieldByName('FAS_DESFAS').AsString + '?') Then
          Exit;
      End;

      If fCancelaOperacao(FieldByName('AUTOINCREM').AsString,
                          FieldByName('PRO_CODPRO').AsString,
                          FieldByName('FAS_CODIGO').AsString,
                          FieldByName('MNT_DTAFIN').AsDateTime) Then
      Begin
        Refresh;
        pMensagemOk('Operação realizada com sucesso!');
      End;
    End;
  End;
end;

procedure TfrmOrdProOperacoes.cxgOperacoesViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: btnCanOPe.Click;
  End;

end;

procedure TfrmOrdProOperacoes.pCarreDadosOP;
Begin
  With objOrdPro Do
  Begin
    edtCodIte.Text := strCodIte;
    edtDesIte.Text := strDesIte;
    edtReferencia.Text := fRetReferenciaProd(strCodIte);
    edtSigUni.Text := fRetUnidadeItem(strCodIte);
    edtCodFabrica.Text := fRetCodFabrica(strCodIte);
  End;
End;

procedure TfrmOrdProOperacoes.FormCreate(Sender: TObject);
begin
  inherited;

  blnMonitoramento := True;
end;

procedure TfrmOrdProOperacoes.FormShow(Sender: TObject);
begin
  inherited;

  btnCanOPe.Visible := blnMonitoramento;
  mmoAviso.Visible  := Not blnMonitoramento;

  pCarreDadosOP;
  objOrdPro.objMonitor.cdsSubProd := cdsSubProdutos;
  pSetFocus(cxgOperacoes);
end;

end.
