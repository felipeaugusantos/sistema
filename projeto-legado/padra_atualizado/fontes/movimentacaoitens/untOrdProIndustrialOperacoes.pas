unit untOrdProIndustrialOperacoes;

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
  untOrdProIndustrial, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmOrdProIndustrialOperacoes = class(TfrmPaiEdit)
    cxgOperacoesLevel1: TcxGridLevel;
    cxgOperacoes: TcxGrid;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtDesIte: TEditFocus;
    edtNumOpe: TEditFocus;
    edtDesEti: TEditFocus;
    edtVolume: TEditFocus;
    edtNumLot: TEditFocus;
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

    objOrdPro: TOrdProIndustrial;
  end;

var
  frmOrdProIndustrialOperacoes: TfrmOrdProIndustrialOperacoes;

implementation

{$R *.dfm}

procedure TfrmOrdProIndustrialOperacoes.btnCanOpeClick(Sender: TObject);
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

      If FieldByName('MON_DTAFIN').IsNull Then
      Begin
        If Not fPergunta('Deseja cancelar o início do processo da Fase ' + FieldByName('FAS_DESFAS').AsString + ' / ' +
                     FieldByName('EQP_DESCRI').AsString + '?') Then
          Exit;
      End Else
      Begin
        If Not fPergunta('Deseja cancelar o final da processo da Fase ' + FieldByName('FAS_DESFAS').AsString + ' / ' +
                     FieldByName('EQP_DESCRI').AsString + '?') Then
          Exit;
      End;

      If fCancelaOperacao(FieldByName('AUTOINCREM').AsString,
                          FieldByName('MON_SEQOPI').AsString,
                          FieldByName('MON_CODFAS').AsString,
                          FieldByName('MON_DTAFIN').AsDateTime) Then
      Begin
        objOrdPro.objMonitor.cdsOperacoes.Refresh;
        pMensagemOk('Operação realizada com sucesso!');
      End;
    End;
  End;
end;

procedure TfrmOrdProIndustrialOperacoes.cxgOperacoesViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: btnCanOPe.Click;
  End;

end;

procedure TfrmOrdProIndustrialOperacoes.pCarreDadosOP;
Begin
  With objOrdPro Do
  Begin
    edtDesIte.Text := cdsCabIpr.FieldByName('DESITE').AsString;
    edtNumOpe.Text := cdsCabIpr.FieldByName('NUMOPE').AsString;
    edtDesEti.Text := cdsCabIpr.FieldByName('DESETI').AsString;
    edtNumLot.Text := cdsCabIpr.FieldByName('NUMLOT').AsString;

    edtVolume.Text := FormatFloat('#,##0.000', fRetSoma('VOLUME'));
  End;
End;

procedure TfrmOrdProIndustrialOperacoes.FormCreate(Sender: TObject);
begin
  inherited;

  blnMonitoramento := True;
end;

procedure TfrmOrdProIndustrialOperacoes.FormShow(Sender: TObject);
begin
  inherited;

  btnCanOPe.Visible := blnMonitoramento;
  mmoAviso.Visible  := Not blnMonitoramento;

  pCarreDadosOP;

  pSetFocus(cxgOperacoes);
end;

end.
