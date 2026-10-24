unit untConsultaGiro;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untConsultaComp, EditFocus, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, StrUtils, Windows;

type
  TfrmConsultaGiro = class(TfrmConsultaComp)
    pnlGiro: TPanel;
    pnlItem: TPanel;
    lblSugest: TLabel;
    lblSaldos: TLabel;
    lblMes: TLabel;
    dbeMes: TDBEditFocus;
    dbeSaldos: TDBEditFocus;
    dbeSugest: TDBEditFocus;
    Label3: TLabel;
    lblTitMarBr1: TLabel;
    lblTitPreVe1: TLabel;
    dbePreVe1: TDBEditFocus;
    dbeMarBr1: TDBEditFocus;
    dbePreCus: TDBEditFocus;
    lblTitMarBr2: TLabel;
    lblTitPreVe2: TLabel;
    dbePreVe2: TDBEditFocus;
    dbeMarBr2: TDBEditFocus;
    pnlMeses: TPanel;
    lblVendas: TLabel;
    lblMes01: TLabel;
    lblMes02: TLabel;
    lblMes03: TLabel;
    lblMes04: TLabel;
    lblMes05: TLabel;
    lblMes06: TLabel;
    lblMes07: TLabel;
    lblMes08: TLabel;
    lblMes09: TLabel;
    lblMes10: TLabel;
    lblMes11: TLabel;
    lblMes12: TLabel;
    dbeMes01: TDBEditFocus;
    dbeMes02: TDBEditFocus;
    dbeMes04: TDBEditFocus;
    dbeMes03: TDBEditFocus;
    dbeMes06: TDBEditFocus;
    dbeMes05: TDBEditFocus;
    dbeMes12: TDBEditFocus;
    dbeMes11: TDBEditFocus;
    dbeMes10: TDBEditFocus;
    dbeMes09: TDBEditFocus;
    dbeMes08: TDBEditFocus;
    dbeMes07: TDBEditFocus;
    lblMedia: TLabel;
    edtValMedia: TEditFocus;
    btnMostraEstoque: TBitBtn;
    lblTitMarBr3: TLabel;
    lblTitPreVe3: TLabel;
    dbeMarBr3: TDBEditFocus;
    dbePreVe3: TDBEditFocus;
    grpUltFornecedor: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtDesForUlt: TEditFocus;
    edtDTAULT: TEditFocus;
    edtPREULT: TEditFocus;
    edtFORULT: TEditFocus;
    lblTitMarBr4: TLabel;
    dbePreVe4: TDBEditFocus;
    lblTitPreVe4: TLabel;
    dbeMarBr4: TDBEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure dbgConsultaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgConsultaCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure btnMostraEstoqueClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pMontaValoresGiro;
    procedure pDesabilitaColunas;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pMostraEstoqueLojas;
    procedure pRetDadUltCompra(strCodIte: String);
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
    intQtdMes: Integer;
  end;

var
  frmConsultaGiro: TfrmConsultaGiro;

implementation

uses untFuncoes, untfuncoesSimples, untConsulta, untModuloSPR, untFatMostraEstoqueEmp;

{$R *.dfm}

{ TfrmConsultaGiro }

{*****************************************}
{* MONTA OS EDITS PARA MOSTRAR OS VALORES*}
{* REFERENTES AO GIRO                    *}
{**************************************MV*}
procedure TfrmConsultaGiro.pMontaValoresGiro;
  Var
    lblTemp: TLabel;
    dbeTemp: TDBEditFocus;

    intContador: Integer;
begin

  edtValMedia.Text := '0,00';

  For intContador := 1 To intQtdMes Do
  Begin

    lblTemp := (fComponentByName(pnlMeses, 'lblMes' + fStrZero(IntToStr(intContador), 2)) As TLabel);
    dbeTemp := (fComponentByName(pnlMeses, 'dbeMes' + fStrZero(IntToStr(intContador), 2)) As TDBEditFocus);

    lblTemp.Caption   := qryConsulta.FieldbyName('ITE_DESM' + fStrZero(IntToStr(intContador), 2)).AsString;
    lblTemp.Visible   := True;

    dbeTemp.DataField := qryConsulta.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).FieldName;
    dbeTemp.Visible   := True;

    If Not fEmptyStr(dbeTemp.Text) Then
      edtValMedia.Text := FloatToStrF(fStrToFloat(edtValMedia.Text) + fStrToFloat(AnsiReplaceStr( AnsiReplaceStr(dbeTemp.Text,',',''), '.', ',')),ffNumber,12,2);

    qryConsulta.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).Visible := False;
    qryConsulta.FieldByName('ITE_DESM' + fStrZero(IntToStr(intContador), 2)).Visible := False;

  End;

  edtValMedia.Text := FloatToStrF(fStrToFloat(edtValMedia.Text) / 3,ffNumber,12,2);

  qryConsulta.FieldByName('ITE_SUGEST').Visible := False;
  qryConsulta.FieldByName('ITE_SALDOS').Visible := False;
  qryConsulta.FieldByName('ITE_PRECUS').Visible := False;
  qryConsulta.FieldByName('ITE_MARBR1').Visible := False;
  qryConsulta.FieldByName('ITE_PREVE1').Visible := False;
  qryConsulta.FieldByName('ITE_MARBR2').Visible := False;
  qryConsulta.FieldByName('ITE_PREVE2').Visible := False;
  qryConsulta.FieldByName('ITE_MARBR3').Visible := False;
  qryConsulta.FieldByName('ITE_PREVE3').Visible := False;
  qryConsulta.FieldByName('ITE_MARBR4').Visible := False;
  qryConsulta.FieldByName('ITE_PREVE4').Visible := False;
  qryConsulta.FieldByName('ITE_LITROS').Visible := False;

  pRetDadUltCompra(qryConsulta.FieldByName('Código').AsString);

end;

procedure TfrmConsultaGiro.FormShow(Sender: TObject);
Var
  intQtdTab : Integer;
begin
  inherited;
  pMontaValoresGiro;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
  btnMostraEstoque.Visible := VS_blnTemFil;

  intQtdTab := 0;
  If VS_strTabPrc[1] = 'S' Then
  Begin
    dbeMarBr1.Visible    := True;
    dbePreVe1.Visible    := True;
    lblTitMarBr1.Visible := True;
    lblTitPreVe1.Visible := True;
    Inc(intQtdTab);
  End
  Else
  Begin
    dbeMarBr1.Visible    := False;
    dbePreVe1.Visible    := False;
    lblTitMarBr1.Visible := False;
    lblTitPreVe1.Visible := False;
  End;

  If VS_strTabPrc[2] = 'S' Then
  Begin
    dbeMarBr2.Visible    := True;
    dbePreVe2.Visible    := True;
    lblTitMarBr2.Visible := True;
    lblTitPreVe2.Visible := True;

    If intQtdTab = 0 Then
    Begin
      dbeMarBr2.Top    := 19;
      dbePreVe2.Top    := 19;
      dbeMarBr2.Left   := 70;
      dbePreVe2.Left   := 129;
      lblTitMarBr2.Top := 4;
      lblTitPreVe2.Top := 4;
      lblTitMarBr2.Left := 72;
      lblTitPreVe2.Left := 130;
    End;

    Inc(intQtdTab);
  End
  Else
  Begin
    dbeMarBr2.Visible    := False;
    dbePreVe2.Visible    := False;
    lblTitMarBr2.Visible := False;
    lblTitPreVe2.Visible := False;
  End;

  If VS_strTabPrc[3] = 'S' Then
  Begin
    dbeMarBr3.Visible    := True;
    dbePreVe3.Visible    := True;
    lblTitMarBr3.Visible := True;
    lblTitPreVe3.Visible := True;

    If intQtdTab = 0 Then
    Begin
      dbeMarBr3.Top    := 19;
      dbePreVe3.Top    := 19;
      dbeMarBr3.Left   := 70;
      dbePreVe3.Left   := 129;
      lblTitMarBr3.Top := 4;
      lblTitPreVe3.Top := 4;
      lblTitMarBr3.Left := 72;
      lblTitPreVe3.Left := 130;
    End
    Else If intQtdTab = 1 Then
    Begin
      dbeMarBr3.Top    := 19;
      dbePreVe3.Top    := 19;
      dbeMarBr3.Left   := 189;
      dbePreVe3.Left   := 248;
      lblTitMarBr3.Top := 4;
      lblTitPreVe3.Top := 4;
      lblTitMarBr3.Left := 190;
      lblTitPreVe3.Left := 249;
    End;
    Inc(intQtdTab);
  End
  Else
  Begin
    dbeMarBr3.Visible    := False;
    dbePreVe3.Visible    := False;
    lblTitMarBr3.Visible := False;
    lblTitPreVe3.Visible := False;
  End;

  If VS_strTabPrc[4] = 'S' Then
  Begin
    dbeMarBr4.Visible    := True;
    dbePreVe4.Visible    := True;
    lblTitMarBr4.Visible := True;
    lblTitPreVe4.Visible := True;

    If intQtdTab = 0 Then
    Begin
      dbeMarBr4.Top    := 19;
      dbePreVe4.Top    := 19;
      dbeMarBr4.Left   := 70;
      dbePreVe4.Left   := 129;
      lblTitMarBr4.Top := 4;
      lblTitPreVe4.Top := 4;
      lblTitMarBr4.Left := 72;
      lblTitPreVe4.Left := 130;
    End
    Else If intQtdTab = 1 Then
    Begin
      dbeMarBr4.Top    := 19;
      dbePreVe4.Top    := 19;
      dbeMarBr4.Left   := 189;
      dbePreVe4.Left   := 248;
      lblTitMarBr4.Top := 4;
      lblTitPreVe4.Top := 4;
      lblTitMarBr4.Left := 190;
      lblTitPreVe4.Left := 249;
    End
    Else If intQtdTab = 2 Then
    Begin
      dbeMarBr4.Top    := 58;
      dbePreVe4.Top    := 58;
      dbeMarBr4.Left   := 10;
      dbePreVe4.Left   := 69;
      lblTitMarBr4.Top := 43;
      lblTitPreVe4.Top := 43;
      lblTitMarBr4.Left := 11;
      lblTitPreVe4.Left := 70;
    End;
  End
  Else
  Begin
    dbeMarBr4.Visible    := False;
    dbePreVe4.Visible    := False;
    lblTitMarBr4.Visible := False;
    lblTitPreVe4.Visible := False;
  End;

end;

procedure TfrmConsultaGiro.pDesabilitaColunas;
  Var
    intContador: Integer;
begin
  For intContador := 1 To intQtdMes Do
  Begin

    qryConsulta.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).Visible := False;
    qryConsulta.FieldByName('ITE_DESM' + fStrZero(IntToStr(intContador), 2)).Visible := False;

  End;

  qryConsulta.FieldByName('ITE_SUGEST').Visible := False;
  qryConsulta.FieldByName('ITE_SALDOS').Visible := False;
  qryConsulta.FieldByName('ITE_PRECUS').Visible := False;
  qryConsulta.FieldByName('ITE_MARBR1').Visible := False;
  qryConsulta.FieldByName('ITE_PREVE1').Visible := False;
  qryConsulta.FieldByName('ITE_MARBR2').Visible := False;
  qryConsulta.FieldByName('ITE_PREVE2').Visible := False;
  qryConsulta.FieldByName('ITE_MARBR3').Visible := False;
  qryConsulta.FieldByName('ITE_PREVE3').Visible := False;
  qryConsulta.FieldByName('ITE_MARBR4').Visible := False;
  qryConsulta.FieldByName('ITE_PREVE4').Visible := False;
  qryConsulta.FieldByName('ITE_VENMES').Visible := False;
  qryConsulta.FieldByName('ITE_LITROS').Visible := False;

  pRetDadUltCompra(qryConsulta.FieldByName('Código').AsString);

end;

procedure TfrmConsultaGiro.pAtuIndice(intIndice: Integer);
begin
  Try
    inherited;
    pDesabilitaColunas;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[ frmConsultaGiro -> pAtuIndice ]');
    End;
  End;
  
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaGiro.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaGiro.dbgConsultaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    intContador: Integer;
    dbeTemp    : TDBEditFocus;
begin
  inherited;

  If edtValMedia.Visible Then
  Begin
    edtValMedia.Text := '0,00';
    For intContador     := 1 To intMesGir Do
    Begin

      dbeTemp := (fComponentByName(pnlMeses, 'dbeMes' + fStrZero(IntToStr(intContador), 2)) As TDBEditFocus);

      If Not fEmptyStr(dbeTemp.Text) Then
        edtValMedia.Text := FloatToStrF(fStrToFloat(edtValMedia.Text) + fStrToFloat(AnsiReplaceStr( AnsiReplaceStr(dbeTemp.Text,',',''), '.', ',')),ffNumber, 12, 2);

    End;

    edtValMedia.Text := FloatToStrF(fStrToFloat(edtValMedia.Text) / 3,ffNumber,12,2);
  End;

  pRetDadUltCompra(qryConsulta.FieldByName('Código').AsString);

end;

procedure TfrmConsultaGiro.dbgConsultaCellClick(Column: TColumn);
  Var
    intContador: Integer;
    dbeTemp    : TDBEditFocus;
begin
  inherited;

  If edtValMedia.Visible Then
  Begin
    edtValMedia.Text := '0,00';
    For intContador     := 1 To intMesGir Do
    Begin

      dbeTemp := (fComponentByName(pnlMeses, 'dbeMes' + fStrZero(IntToStr(intContador), 2)) As TDBEditFocus);

      If Not fEmptyStr(dbeTemp.Text) Then
        edtValMedia.Text := FloatToStrF(fStrToFloat(edtValMedia.Text) + fStrToFloat(AnsiReplaceStr( AnsiReplaceStr(dbeTemp.Text,',',''), '.', ',')),ffNumber,12,2);

    End;

    edtValMedia.Text := FloatToStrF(fStrToFloat(edtValMedia.Text) / 3,ffNumber,12,2);
  End;

  pRetDadUltCompra(qryConsulta.FieldByName('Código').AsString);

end;

procedure TfrmConsultaGiro.pAtualizaDados(DataSet: TDataSet);
begin
  dbgConsultaCellClick(Nil);
end;

procedure TfrmConsultaGiro.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta.AfterScroll := pAtualizaDados;
end;

procedure TfrmConsultaGiro.btnMostraEstoqueClick(Sender: TObject);
begin
  inherited;

  If btnMostraEstoque.Visible Then
  Begin
    pMostraEstoqueLojas;
    ActiveControl.SetFocus;
  End;

end;

procedure TfrmConsultaGiro.pMostraEstoqueLojas;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  strSQL := strSQL + ' (SELECT ';
  strSQL := strSQL + '    SUM(FDO_QTDITE - FDO_QTDBAI) ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    FATDOR ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    FDO_CODITE = :CODITE AND ';
  strSQL := strSQL + '    FDO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '    FDO_ESPDOC = "PD" AND ';
  strSQL := strSQL + '    FDO_JAFATU = 0) ITE_SALRES, ';

  strSQL := strSQL + '  EMP_CODEMP, ';
  strSQL := strSQL + '  ITE_SALDOS, ';
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

  strSQL := strSQL + ' (SELECT ';
  strSQL := strSQL + '    SUM(FDO_QTDITE - FDO_QTDBAI) ';
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    FATDOR ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    FDO_CODITE = :CODITE AND ';
  strSQL := strSQL + '    FDO_CODEMP = EMP_CODEMP AND ';
  strSQL := strSQL + '    FDO_ESPDOC = "PD" AND ';
  strSQL := strSQL + '    FDO_JAFATU = 0) ITE_SALRES, ';

  strSQL := strSQL + '  EMP_CODEMP, ';
  strSQL := strSQL + '  ITE_SALDOS, ';
  strSQL := strSQL + '  EMP_NOMEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER, ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODEMP = EMP_CODEMP AND ';
  strSQL := strSQL + '  ITE_CODEMP <> :CODEMP AND ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE ';

  With frmModuloSPR.qryTemporaria2 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODITE').AsString := qryConsulta.FieldByName('Código').AsString;
    Open;
    (FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_SALRES') As TFloatField).DisplayFormat := '#,##0.00';

    Try
      Application.CreateForm(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
      frmFatMostraEstoqueEmp.strCodIte    := qryConsulta.FieldByName('Código').AsString;
      frmFatMostraEstoqueEmp.edtItem.Text := qryConsulta.FieldByName('Código').AsString + ' - ' +
                                                qryConsulta.FieldByName('Descrição').AsString;
      frmFatMostraEstoqueEmp.showModal;
    Finally
      pFreeAndNil(frmFatMostraEstoqueEmp);
    End;

    Close;
  End;
end;

procedure TfrmConsultaGiro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_F6 Then
    btnMostraEstoque.Click;

end;


procedure TfrmConsultaGiro.pRetDadUltCompra(strCodIte: String);
  Var
    qryConTmp : TUniQuery;
    strSQL    : String;

begin

  qryConTmp := fCriaQuery;

  edtDTAULT.Clear;
  edtPREULT.Clear;
  edtFORULT.Clear;
  edtDesForUlt.Clear;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_DTAULT, ';
  strSQL := strSQL + '  ITE_PREULT, ';
  strSQL := strSQL + '  ITE_FORULT, ';
  strSQL := strSQL + '  FOR_NOMFOR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER, ';
  strSQL := strSQL + '  CADFOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FOR_CODFOR = ITE_FORULT AND ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

  With qryConTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    If Not( IsEmpty ) Then
    Begin
      edtDTAULT.Text    := FormatDateTime('dd/mm/yyyy', qryConTmp.FieldByName('ITE_DTAULT').AsDateTime);
      edtPREULT.Text    := FormatFloat('#,##0.00', qryConTmp.FieldByName('ITE_PREULT').AsFloat);
      edtFORULT.Text    := qryConTmp.FieldByName('ITE_FORULT').AsString;
      edtDesForUlt.Text := qryConTmp.FieldByName('FOR_NOMFOR').AsString;
    End;

    Close;
  End;

end;


end.




