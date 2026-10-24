unit untConsultaFatItem;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untConsultaComp, DB, 
  Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, EditFocus, BitBtnLockedIncrem, MemDS,
  DBAccess {Qt,};

type
  TfrmConsultaFatItem = class(TfrmConsultaComp)
    pnlDadosItem: TPanel;
    Label3: TLabel;
    dbeSaldos: TDBEditFocus;
    lblSalRes: TLabel;
    dbeIteAti: TDBText;
    lblPreCus: TLabel;
    dbePreCus: TDBEditFocus;
    Label5: TLabel;
    DBEditFocus2: TDBEditFocus;
    edtSalRes: TEditFocus;
    btnPedSalRes: TBitBtnLocked;
    btnSimilares: TBitBtnLocked;
    btnMostraEstoque: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure qryConsultaAfterScroll(DataSet: TDataSet);
    procedure btnPedSalResClick(Sender: TObject);
    procedure btnSimilaresClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMostraEstoqueClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pDesabilitaColunas;

    procedure pMostraBotaoSalRes;
    procedure pMostraBotaoSimilares;

    procedure pMostraEstoqueLojas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaFatItem: TfrmConsultaFatItem;

implementation

uses  untConsulta, untFatMostraProdSimilar,
  untFatMostraPedSalRes, untFatMostraEstoqueEmp, untFuncoesSimples;

{$R *.dfm}

{ TfrmConsultaFatItem }

procedure TfrmConsultaFatItem.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  pMostraBotaoSalRes;
  pMostraBotaoSimilares;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaFatItem.pDesabilitaColunas;
begin

  (qryConsulta.FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,###0.000';
  //(qryConsulta.FieldByName('ITE_SALRES') As TFloatField).DisplayFormat := '#,###0.000';
  (qryConsulta.FieldByName('ITE_PRECUS') As TFloatField).DisplayFormat := '#,###0.000';
    
  (qryConsulta.FieldByName('Preço de Venda') As TFloatField).DisplayFormat := '#,##0.00';

  qryConsulta.FieldByName('ITE_ITEATI').Visible := False;
  qryConsulta.FieldByName('ITE_CODSIM').Visible := False;
  qryConsulta.FieldByName('ITE_SALDOS').Visible := False;
  //qryConsulta.FieldByName('ITE_SALRES').Visible := False;
  qryConsulta.FieldByName('ITE_PRECUS').Visible := False;

  qryConsulta.FieldByName('ULTVEN').Visible     := False;
end;

procedure TfrmConsultaFatItem.FormShow(Sender: TObject);
begin
  inherited;

  btnMostraEstoque.Visible := VS_blnTemFil;

  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;

end;

procedure TfrmConsultaFatItem.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaFatItem.qryConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If qryConsulta.Active then
    edtSalRes.Text := FormatFloat('#,##0.000', fRetornaSalRes(VS_strCodEmp, False, '', qryConsulta.FieldByName('CODIGO').AsString,
                                                              VS_strCodEmp));
   pMostraBotaoSalRes;
  pMostraBotaoSimilares;

  If dbeIteAti.Field.AsString = 'ATIVO' Then
    dbeIteAti.Font.Color := clGreen
  Else
    dbeIteAti.Font.Color := clRed;
end;

procedure TfrmConsultaFatItem.pMostraBotaoSalRes;
begin

  If fCfgSis('USAPDV', varBoolean) Then
  Begin

    If (fEmptyStr({dbeSalRes}edtSalRes.Text)) Or (fStrToFloat({dbeSalRes}edtSalRes.Text) <= 0) Then
    Begin
      btnPedSalRes.Visible := False;
    End
    Else
    Begin
      btnPedSalRes.Visible := True;
    End;

  End;

end;

procedure TfrmConsultaFatItem.btnPedSalResClick(Sender: TObject);
  Var
    strSQL: String;
    qrySalRes: TUniQuery;
begin
  inherited;
  If btnPedSalRes.Visible Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FDO_NUMDOC, ';
    strSQL := strSQL + '  FDO_CODEMP, ';
    strSQL := strSQL + '  FDO_DTAENT, ';
    strSQL := strSQL + '  CLI_NOMCLI, ';
    strSQL := strSQL + '  SUM(FDO_QTDITE) AS FDO_QTDITE ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  FATDOR, ';
    strSQL := strSQL + '  CADCLI  ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  CLI_CODCLI = FDO_CODCLI AND ';
    strSQL := strSQL + '  FDO_JAFATU = FALSE AND      ';
    strSQL := strSQL + '  FDO_ESPDOC = "PD" AND       ';
    strSQL := strSQL + '  FDO_CODEMP = :CODEMP AND    ';
    strSQL := strSQL + '  FDO_CODITE = :CODITE        ';
    strSQL := strSQL + 'GROUP BY     ';
    strSQL := strSQL + '  FDO_NUMDOC ';

    qrySalRes := fCriaQuery(Self);
    With qrySalRes Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODITE').AsString := qryConsulta.FieldByName('Codigo').AsString;
      Open;
      If (Not IsEmpty) Then
      Begin
        Try
          Application.CreateForm(TfrmFatMostraPedSalRes, frmFatMostraPedSalRes);

          frmFatMostraPedSalRes.dtsSalRes.DataSet := qrySalRes;
          frmFatMostraPedSalRes.edtItem.Text := qryConsulta.FieldByName('Codigo').AsString + ' - ' +
                                                qryConsulta.FieldByName('Descrição').AsString;
          frmFatMostraPedSalRes.showModal;
        Finally
          FreeAndNil(frmFatMostraPedSalRes);
        End;
      End
      Else
      Begin
        fMensagem('', 'Não há pedidos reservando esse item!', ['&O k']);
      End;
      Close;
      FreeAndNil(qrySalRes);
    End;
  End;
end;

procedure TfrmConsultaFatItem.pMostraBotaoSimilares;
begin
  If (Not qryConsulta.FieldByName('ITE_CODSIM').IsNull) Then
  Begin
    btnSimilares.Visible := True;
  End
  Else
  Begin
    btnSimilares.Visible := False;
  End;
end;

procedure TfrmConsultaFatItem.btnSimilaresClick(Sender: TObject);
  Var
    strSQL: String;
    qryProSim: TUniQuery;
begin
  inherited;
  If btnSimilares.Visible Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_REFERE, ';
    strSQL := strSQL + '  I.ITE_CODUNI, ';
    strSQL := strSQL + '  G.ITE_PREVE1 AS ITE_PREVEN ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  I.ITE_CODSIM = :CODSIM AND ';
    strSQL := strSQL + '  I.ITE_CODITE <> :CODITE ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  I.ITE_DESITE ';

    qryProSim := fCriaQuery(Self);
    With qryProSim Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODSIM').AsString := qryConsulta.FieldByName('ITE_CODSIM').AsString;
      ParamByName('CODITE').AsString := qryConsulta.FieldByName('Codigo').AsString;
      Open;
      (FieldByName('ITE_PREVEN') As TFloatField).DisplayFormat := '#,##0.00';
      If Not IsEmpty Then
      Begin
        Try
          Application.CreateForm(TfrmFatMostraProdSimilar, frmFatMostraProdSimilar);

          frmFatMostraProdSimilar.dtsProSim.DataSet := qryProSim;
          frmFatMostraProdSimilar.edtItem.Text := qryConsulta.FieldByName('Codigo').AsString + ' - ' +
                                                  qryConsulta.FieldByName('Descrição').AsString;
          frmFatMostraProdSimilar.ShowModal;
        Finally
          FreeAndNil(frmFatMostraProdSimilar);
        End;
      End
      Else
      Begin
        fMensagem('', 'Não há itens similares!', ['&O k']);
      End;
      Close;
      FreeAndNil(qryProSim);
    End;
  End;
  pSetFocus(ActiveControl);
end;

procedure TfrmConsultaFatItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F6 Then
  Begin
    btnMostraEstoque.Click;
  End
  Else If Key = VK_F7 Then
  Begin
    btnPedSalRes.Click;
  End
  Else If Key = VK_F8 Then
  Begin
    btnSimilares.Click;
  End;
end;

procedure TfrmConsultaFatItem.btnMostraEstoqueClick(Sender: TObject);
begin
  inherited;

  If btnMostraEstoque.Visible Then
  Begin
    pMostraEstoqueLojas;
    pSetFocus(ActiveControl);
  End;

end;

procedure TfrmConsultaFatItem.pMostraEstoqueLojas;
  Var
    strSQL: String;
    qryEstLoj: TUniQuery;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMP_CODEMP, ';
  strSQL := strSQL + '  ITE_SALDOS, ';

  strSQL := strSQL + ' (SELECT ';
  strSQL := strSQL + '    SUM(FDO_QTDITE) ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    FATDOR ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    FDO_CODITE = :CODITE AND ';
  strSQL := strSQL + '    FDO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '    FDO_ESPDOC = "PD" AND ';
  strSQL := strSQL + '    FDO_JAFATU = 0) ITE_SALRES, ';

  strSQL := strSQL + '  EMP_NOMEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER, ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODEMP = EMP_CODEMP AND ';
  strSQL := strSQL + '  EMP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE ';

  strSQL := strSQL + 'UNION ';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMP_CODEMP, ';
  strSQL := strSQL + '  ITE_SALDOS, ';

  strSQL := strSQL + ' (SELECT ';
  strSQL := strSQL + '    SUM(FDO_QTDITE) ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    FATDOR ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    FDO_CODITE = :CODITE AND ';
  strSQL := strSQL + '    FDO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '    FDO_ESPDOC = "PD" AND ';
  strSQL := strSQL + '    FDO_JAFATU = 0) ITE_SALRES, ';

  strSQL := strSQL + '  EMP_NOMEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER, ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODEMP = EMP_CODEMP AND ';
  strSQL := strSQL + '  ITE_CODEMP <> :CODEMP AND ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE ';

  qryEstLoj:= fCriaQuery(Self);
  With qryEstLoj Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODITE').AsString := qryConsulta.FieldByName('Codigo').AsString;
    Open;
    (FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_SALRES') As TFloatField).DisplayFormat := '#,##0.00';

    Try
      Application.CreateForm(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);

      frmFatMostraEstoqueEmp.dtsEstLoj.DataSet := qryEstLoj;
      frmFatMostraEstoqueEmp.edtItem.Text := qryConsulta.FieldByName('Codigo').AsString + ' - ' +
                                                qryConsulta.FieldByName('Descrição').AsString;
      frmFatMostraEstoqueEmp.showModal;
    Finally
      FreeAndNil(frmFatMostraEstoqueEmp);
    End;
    Close;
    FreeAndNil(qryEstLoj);
  End;
end;

procedure TfrmConsultaFatItem.FormCreate(Sender: TObject);
begin
  inherited;
  If (Not fCfgSis('USAPDV', varBoolean)) Then
  Begin
    lblSalRes.Visible := False;
    edtSalRes.Visible := False;
    //dbeSalRes.Visible := False;
  End;
end;

procedure TfrmConsultaFatItem.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.

