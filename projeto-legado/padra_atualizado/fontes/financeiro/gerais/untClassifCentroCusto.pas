unit untClassifCentroCusto;

interface

uses
  Windows, Classes, untPaiSimples, AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  untClasseBalanceteFinanceiro,   Uni,
  cxDBExtLookupComboBox, cxDBLookupComboBox, UniClientDataSet, UniDataSetProvider,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider,
  StdCtrls, Controls, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;


type
  TfrmClassifCentroCusto = class(TfrmPaiSimples)
    pnl1: TPanel;
    gridDadosDBTable: TcxGridDBTableView;
    gridDadosLevel: TcxGridLevel;
    gridDados: TcxGrid;
    gridDadosDBTableCODCTA: TcxGridDBColumn;
    gridDadosDBTableDESCTA: TcxGridDBColumn;
    dtsCadCta: TDataSource;
    gridDadosDBTableCODCCC: TcxGridDBColumn;
    dtsCadCCu: TDataSource;
    cdsCadCta: TUniClientDataSet;
    dspCadCta: TUniDataSetProvider;
    qryCadCta: TUniQuery;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnGravar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gridDadosDBTableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
     objClaCCu: TCadClaCCu;
     qryCadCCu: TUniQuery;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

procedure TfrmClassifCentroCusto.btnGravarClick(Sender: TObject);
begin
  If (fMensagem('','Deseja salvar as alterações?',['','']) = 1) Then
  Begin
    Try
      fStartTransaction;

      If cdsCadCta.State = dsEdit Then
        cdsCadCta.Post;

      If(cdsCadCta.ApplyUpdates(0) = 0) Then
      Begin
        fCommit;
        fMensagem('','As alterações foram salvas com sucesso',['&Ok']);
      End
      Else
        fRollBack;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '');
      End;
    End;
  End
  Else
    Exit;
  Close;
end;

procedure TfrmClassifCentroCusto.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(gridDados);
end;

procedure TfrmClassifCentroCusto.FormCreate(Sender: TObject);
begin
  objClaCCu := TCadClaCCu.Create(Self);
  inherited;
end;

procedure TfrmClassifCentroCusto.FormShow(Sender: TObject);
begin
  inherited;
  With qryCadCta Do
  Begin
    Close;
    SQL.Text := objClaCCu.fRetSQLCadCta;
    Open;
  End;

  pSetaClient(qryCadCta);

  cdsCadCta.Close;
  cdsCadCta.SetProvider(dspCadCta);
  cdsCadCta.Open;

  qryCadCCu := fCriaQuery(Self);
  dtsCadCCu.DataSet := qryCadCCu;

  With qryCadCCu Do
  Begin
    Close;
    SQL.Text := objClaCCu.fRetSQLCadCCC;
    Open;
  End;
end;

procedure TfrmClassifCentroCusto.gridDadosDBTableKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of

    VK_F10   : btnGravar.Click;
    VK_Escape: btnSair.Click;

  End;
end;

end.
