unit untCadFasesOrdem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Uni,
  untZClient, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadFasesOrdem = class(TfrmPaiEdit)
    btnGravar: TBitBtnLocked;
    cxgCadFasView: TcxGridDBTableView;
    cxgCadFasLevel1: TcxGridLevel;
    cxgCadFas: TcxGrid;
    cxgCadFasCODFAS: TcxGridDBColumn;
    cxgCadFasDESFAS: TcxGridDBColumn;
    cxgCadFasSEQFAS: TcxGridDBColumn;
    spbUp: TSpeedButton;
    spbDown: TSpeedButton;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure spbUpClick(Sender: TObject);
    procedure spbDownClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cdsCadFas: TZClient;

    procedure pSobeRegistro;
    procedure pDesceRegistro;

  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

Uses
  untOrdProIndMonitoramento;

procedure TfrmCadFasesOrdem.btnGravarClick(Sender: TObject);
begin
  inherited;

  If cdsCadFas.fSalva Then
  Begin
    pMensagemOk('Atualizações salvas com sucesso!');
    Close;
  End;
end;

procedure TfrmCadFasesOrdem.btnSairClick(Sender: TObject);
begin
  inherited;

  cdsCadFas.pCancela;
end;

procedure TfrmCadFasesOrdem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F10 : btnGravar.Click;
  End;

end;

procedure TfrmCadFasesOrdem.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  Case Key of
    'C': spbUp.Click;
    'B': spbDown.Click;
  End;

end;

procedure TfrmCadFasesOrdem.FormShow(Sender: TObject);
begin
  inherited;

  cdsCadFas := TZClient.Create(Self, 'SELECT * FROM CADFAS ORDER BY FAS_SEQFAS');
  cdsCadFas.fAbreClient(True, 'TfrmCadFasesOrdem.FormShow');
  cdsCadFas.IndexFieldNames := 'FAS_SEQFAS';

  cxgCadFasView.DataController.DataSource := cdsCadFas.dtsSource;


  If TOrdProIndMonitoramento.fTemOperacaoIniciadaDeOPAberta Then
  Begin
    btnGravar.Enabled := False;
    spbUp.Enabled     := False;
    spbDown.Enabled   := False;

    pMensagemOk('Há Ordens de Produção abertas que possuem monitoramentos.' + #13#10 +
                'A Ordem das Fases não poderá ser alterada!' );
  End;
end;

procedure TfrmCadFasesOrdem.spbDownClick(Sender: TObject);
begin
  inherited;

  pDesceRegistro;
end;

procedure TfrmCadFasesOrdem.spbUpClick(Sender: TObject);
begin
  inherited;

  pSobeRegistro;
end;

procedure TfrmCadFasesOrdem.pSobeRegistro;
  Var
    strCodAnt,
    strCodAtu: String;
Begin
  With cdsCadFas Do
  Begin
    If FieldByName('FAS_SEQFAS').AsInteger > 1 Then
    Begin
      DisableControls;
      strCodAtu := FieldByName('FAS_CODFAS').AsString;
      Prior;

      strCodAnt := FieldByName('FAS_CODFAS').AsString;

      If strCodAnt <> strCodAtu Then
      Begin
        Edit;
        FieldByName('FAS_SEQFAS').AsInteger := FieldByName('FAS_SEQFAS').AsInteger + 1;
        Post;

        If Locate('FAS_CODFAS', strCodAtu, []) Then
        Begin
          Edit;
          FieldByName('FAS_SEQFAS').AsInteger := FieldByName('FAS_SEQFAS').AsInteger - 1;
          Post;
        End;
      End;

      EnableControls;
    End;
  End;

End;

procedure TfrmCadFasesOrdem.pDesceRegistro;
  Var
    strCodAtu,
    strCodPos: String;
Begin
  With cdsCadFas Do
  Begin
    DisableControls;
    strCodAtu := FieldByName('FAS_CODFAS').AsString;
    Next;

    strCodPos := FieldByName('FAS_CODFAS').AsString;

    If strCodPos <> strCodAtu Then
    Begin
      Edit;
      FieldByName('FAS_SEQFAS').AsInteger := FieldByName('FAS_SEQFAS').AsInteger - 1;
      Post;

      If Locate('FAS_CODFAS', strCodAtu, []) Then
      Begin
        Edit;
        FieldByName('FAS_SEQFAS').AsInteger := FieldByName('FAS_SEQFAS').AsInteger + 1;
        Post;
      End;
    End;

    EnableControls;
  End;

End;

end.
