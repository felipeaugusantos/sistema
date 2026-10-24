unit untFatMostraProdSemSaldo;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, AppEvnts {Qt,},
  BitBtnLockedIncrem, DBCtrls, DBMemoFocus, frxClass, frxExportCSVTestabilidade, strUtils,
  Datasnap.DBClient;

Const
  cnsSalDis = -999999999;

type
  TfrmFatMostraProdSemSaldo = class(TfrmPaiSimples)
    dbgItens: TDBGridCitel;
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    cdsItens: TUniClientDataSet;
    cdsItensITE_CODITE: TStringField;
    cdsItensITE_DESITE: TStringField;
    cdsItensITE_QTDITE: TFloatField;
    cdsItensITE_SALDOS: TFloatField;
    dtsItens: TDataSource;
    cdsItensITE_NUMLOT: TStringField;
    cdsItensITE_DESSIM: TStringField;
    cdsItensDET_INCREM: TStringField;
    pnlMensagemItem: TPanel;
    dbmMensag: TDBMemoFocus;
    splMensagemItem: TSplitter;
    cdsItensITE_MENSAG: TMemoField;
    btnEstLojas: TBitBtnLocked;
    cdsItensITE_CODEMP: TStringField;
    cdsItensITE_SALDIS: TFloatField;
    procedure btnFecharClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure splMensagemItemCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEstLojasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnMostraSaldoFis,
    blnMostraSaldoDis: Boolean;
    procedure pConsultaSaldoOutrasLojas;
  public
    { Public declarations }
    Procedure pAbreClientItens;
    Procedure pFechaClientItens;
    Procedure pIncluiItem(strCodEmp, strCodIte, strDesIte: String;
                          fltSaldos, fltQtdIte: Double;
                          strNumLot,
                          strDetInc,
                          strMensag: String;
                          fltSalDis: Double = cnsSalDis;
                          blnSohPreencheSeNumLotDiferenteADefinir: Boolean = False);
  end;

implementation

uses untFuncoesSimples, untFatMostraEstoqueEmp;

{$R *.dfm}

procedure TfrmFatMostraProdSemSaldo.btnEstLojasClick(Sender: TObject);
begin
  inherited;
  if not btnEstLojas.Visible then
    Exit;

  pConsultaSaldoOutrasLojas;
end;

procedure TfrmFatMostraProdSemSaldo.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraProdSemSaldo.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    btnFechar.Click;
end;

procedure TfrmFatMostraProdSemSaldo.FormCreate(Sender: TObject);
begin
  inherited;
  splMensagemItem.Visible := False;
  pnlMensagemItem.Visible := False;
  blnMostraSaldoFis := fVerificaAcessoSistema('PVISPF');
  blnMostraSaldoDis := False;
  btnEstLojas.Visible := blnMostraSaldoFis;
end;

procedure TfrmFatMostraProdSemSaldo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F6) then
    btnEstLojas.Click;
end;

procedure TfrmFatMostraProdSemSaldo.FormShow(Sender: TObject);
begin
  inherited;

  fFindColumnByName(dbgItens, 'ITE_SALDOS').Visible := False;
  fFindColumnByName(dbgItens, 'ITE_SALDIS').Visible := False;
  If blnMostraSaldoFis Then
  Begin
    fFindColumnByName(dbgItens, 'ITE_SALDOS').Visible := True;
    fFindColumnByName(dbgItens, 'ITE_SALDOS').Title.Caption := 'Saldo';
    If blnMostraSaldoDis Then
    Begin
      fFindColumnByName(dbgItens, 'ITE_SALDIS').Visible := True;
      fFindColumnByName(dbgItens, 'ITE_SALDIS').Title.Caption := 'Saldo Disponível';

      fFindColumnByName(dbgItens, 'ITE_SALDOS').Title.Caption := 'Saldo Físico';
    End;
  End;
end;

Procedure TfrmFatMostraProdSemSaldo.pAbreClientItens;
Begin
  cdsItens.CreateDataSet;
  cdsItens.Open;
  dbgItens.DataSource := dtsItens;
End;

procedure TfrmFatMostraProdSemSaldo.pConsultaSaldoOutrasLojas;
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
    frmFatMostraEstoqueEmp.blnFaturamento := False;
    frmFatMostraEstoqueEmp.strCodIte      := cdsItensITE_CODITE.AsString;
    frmFatMostraEstoqueEmp.strTabPre      := '1';
    frmFatMostraEstoqueEmp.blnPedCorte    := False;
    frmFatMostraEstoqueEmp.edtItem.Text   := cdsItensITE_CODITE.AsString + ' - ' + cdsItensITE_DESITE.AsString;
    frmFatMostraEstoqueEmp.blnEstrutura   := fItemEstrutura(cdsItensITE_CODITE.AsString);
    frmFatMostraEstoqueEmp.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraProdSemSaldo]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);
end;

Procedure TfrmFatMostraProdSemSaldo.pFechaClientItens;
Begin
  cdsItens.Close;
End;

Procedure TfrmFatMostraProdSemSaldo.pIncluiItem(strCodEmp, strCodIte, strDesIte: String;
                                                fltSaldos, fltQtdIte: Double;
                                                strNumLot,
                                                strDetInc,
                                                strMensag: String;
                                                fltSalDis: Double = cnsSalDis;
                                                blnSohPreencheSeNumLotDiferenteADefinir: Boolean = False);
Begin
  Try

    With cdsItens Do
    Begin
      Insert;
      FieldByName('ITE_CODEMP').AsString := strCodEmp;
      FieLdByName('ITE_DESITE').AsString := strDesIte;
      FieLdByName('ITE_CODITE').AsString := strCodIte;
      FieLdByName('ITE_SALDOS').AsFloat  := fltSaldos;
      FieLdByName('ITE_SALDIS').AsFloat  := fltSalDis;
      FieLdByName('ITE_QTDITE').AsFloat  := fltQtdIte;
      FieLdByName('ITE_NUMLOT').AsString := IIF(blnSohPreencheSeNumLotDiferenteADefinir, IIF(strNumLot = 'A DEFINIR', '', strNumLot), strNumLot);
      FieLdByName('DET_INCREM').AsString := strDetInc;
      FieLdByName('ITE_MENSAG').AsString := strMensag;
      Post;

      If (fltSalDis <> cnsSalDis) Then
        blnMostraSaldoDis := True;
    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmFatMostraProdSemSaldo.pIncluiItem]');
    End;

  End;
  
End;

procedure TfrmFatMostraProdSemSaldo.splMensagemItemCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := pnlMensagemItem.Height > 60;
end;

end.
