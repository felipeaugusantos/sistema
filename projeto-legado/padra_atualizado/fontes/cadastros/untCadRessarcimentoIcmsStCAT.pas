unit untCadRessarcimentoIcmsStCAT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask, untGeraExcel,
  DBCtrls, DBEditFocus, Grids, DBGridCitel, DBGrids, EditFocus, ComboBoxFocus, Uni, DB,
  DBClient, BitBtnLockedIncrem, ComCtrls, cxStyles, untExcel, UniClientDataSet,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView, strUtils,
  cxGridDBBandedTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridDBTableView, cxGrid, Gauges, cxCurrencyEdit, untFuncoesSimples, cxProgressBar,
  CheckLst, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, cxButtons,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCadRessarcimentoIcmsStCAT = class(TfrmPai)
    pnlFundo: TPanel;
    pnlHeader: TPanel;
    Label1: TLabel;
    edtCodAbf: TEditFocus;
    edtDescri: TEditFocus;
    btnIncluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    cxStyle: TcxStyleRepository;
    cxsIcms: TcxStyle;
    cxsST: TcxStyle;
    cxsRessarcimento: TcxStyle;
    cxsDesconto: TcxStyle;
    cxgAbrev: TcxGrid;
    cxgAbrevTableView: TcxGridDBBandedTableView;
    cxgAbrevDBColUF: TcxGridDBBandedColumn;
    cxgAbrevDBColCodSit: TcxGridDBBandedColumn;
    cxgAbrevDBColBasIcm: TcxGridDBBandedColumn;
    cxgAbrevDBColAlqIcm: TcxGridDBBandedColumn;
    cxgAbrevDBColBasRet: TcxGridDBBandedColumn;
    cxgAbrevDBColAlqRet: TcxGridDBBandedColumn;
    cxgAbrevDBColIVA_ST: TcxGridDBBandedColumn;
    cxgAbrevDBColResIcm: TcxGridDBBandedColumn;
    cxgAbrevDBColRes_St: TcxGridDBBandedColumn;
    cxgAbrevDBColResTot: TcxGridDBBandedColumn;
    cxgAbrevDBColDescT1: TcxGridDBBandedColumn;
    cxgAbrevDBColDescT2: TcxGridDBBandedColumn;
    cxgAbrevDBColDescT3: TcxGridDBBandedColumn;
    cxgAbrevDBColDescT4: TcxGridDBBandedColumn;
    cxgAbrevDBColDescT5: TcxGridDBBandedColumn;
    cxgAbrevDBColDescT6: TcxGridDBBandedColumn;
    cxgAbrevDBColDescT7: TcxGridDBBandedColumn;
    cxgAbrevLevel: TcxGridLevel;
    lblCopiarDescontos: TLabel;
    btnConsultarProduto: TBitBtnLocked;
    btnIncluirTodasAbreviacoes: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure edtCodAbfKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultarProdutoClick(Sender: TObject);
    procedure btnIncluirTodasAbreviacoesClick(Sender: TObject);
  private
    { Private declarations }
    function fGetSQLTabelaResCat: String;
    function fGetSQLTabelaAbfIcm: String;
    function fCriaCdsRessarcimentoCAT(): TUniClientDataSet;
    function fGravarRessarcimentoCAT(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fIncluiAbreviacoes(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fValidarDescontoComercial(): Boolean;

    procedure pEsconderColunas();
    procedure pFormataCampos();
    procedure pCarregaRessarcimentoCAT();
    procedure pCarregarDadosAbreviacaoFiscal();
    procedure pCalcularRessarcimentoIcmsSt();
    procedure pOnStateChange(intOpcao: Integer);
    procedure pLimpaEdits;
    procedure pCriaDataSet;
    procedure pCopiarDescontos;

    procedure pBeforePost(DataSet: TDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    cdsGrid : TUniClientDataSet;
    dtsGrid : TDataSource;
  end;

var
  frmCadRessarcimentoIcmsStCAT: TfrmCadRessarcimentoIcmsStCAT;

implementation

uses untConstantes, untPesqAux, untFuncoesConsulta, untTypesSistema,
  untConsultas, untGravando, untProdutoRessarcimentoIcmsStCAT;

{$R *.dfm}

function TfrmCadRessarcimentoIcmsStCAT.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodAbf) And edtCodAbf.Enabled Then
    Begin
      edtDescri.Text := fRetDesAbfIcm(edtCodAbf.Text);
      If (fEmptyStr(edtCodAbf.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Abreviação Fiscal deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (fEmptyStr(edtDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Abreviação Fiscal não encontrada com este código!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        pCarregaRessarcimentoCAT();
        pCarregarDadosAbreviacaoFiscal();
        pCalcularRessarcimentoIcmsSt();
        blnMudarFoco := False;
        pSetFocus(cxgAbrev);
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadRessarcimentoIcmsStCAT.fValidarDescontoComercial: Boolean;
Var
  I: Integer;
begin
  Result := True;

  If (fCfgSis('MCAT17') <> 'C') Then
    Exit;

  cdsGrid.First;
  While Not cdsGrid.Eof Do
  Begin
    For I := 1 To Length(VS_strTabPrc) Do
      If (VS_strTabPrc[I] = 'S') Then
        If cdsGrid.FieldByName('CAT_DESCT' + I.ToString()).AsFloat >
           cdsGrid.FieldByName('CAT_RESTOT').AsFloat Then
        Begin
          pMensagemOk('O desconto comercial da tabela de preço ' + I.ToString()
            + ' está maior que o percentual de ressarcimento total. ' + #13#10
            + 'Favor corrigir!');
          pSetFocus(cxgAbrev);
          Exit(False);
        End;
    cdsGrid.Next;
  End;
  cdsGrid.First;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.FormShow(Sender: TObject);
begin
  inherited;
  edtCodAbf.MaxLength := IIf(fCfgSis('USASAN') = 'S', 7, 3);
  pCriaDataSet;
  pFormataCampos;
  pEsconderColunas;
  pOnStateChange(1);
end;

procedure TfrmCadRessarcimentoIcmsStCAT.pOnStateChange(intOpcao: Integer);
begin
  If intOpcao = 0 Then
  Begin
    btnIncluir.Enabled := False;
    btnSair.Enabled    := False;
    btnPesquisa.Enabled:= False;
    btnGravar.Enabled  := True;
    btnCancela.Enabled := True;
    btnExcluir.Enabled := True;
    cxgAbrev.Enabled   := True;
  End
  Else
  Begin
    btnIncluir.Enabled := True;
    btnSair.Enabled    := True;
    btnPesquisa.Enabled:= True;
    btnGravar.Enabled  := False;
    btnCancela.Enabled := False;
    btnExcluir.Enabled := False;
    cxgAbrev.Enabled   := False;
  End;
  btnConsultarProduto.Enabled := not fEmptyStr(edtCodAbf.Text);
end;

procedure TfrmCadRessarcimentoIcmsStCAT.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits;
  pnlHeader.Enabled := True;
  cdsGrid.Open;
  cdsGrid.EmptyDataSet;
  pOnStateChange(0);
  pSetFocus(edtCodAbf);
  btnIncluirTodasAbreviacoes.Enabled := False;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.btnIncluirTodasAbreviacoesClick(Sender: TObject);
var frmImportando: TFrmGravando;
begin
  inherited;
  pCriarFormularios(TFrmGravando, frmImportando);
  Try
    frmImportando.lblGravando.Caption := 'Incluindo Abreviações...';
    frmImportando.fExecutarAcao := fIncluiAbreviacoes;
    frmImportando.ShowModal;
  Finally
    pFreeAndNil(frmImportando);
  End;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.pLimpaEdits;
Begin
  edtCodAbf.Clear;
  edtDescri.Clear;
End;

procedure TfrmCadRessarcimentoIcmsStCAT.pFormataCampos();
begin
  With cdsGrid Do
  Begin
    TStringField(FieldByName('CAT_ESTADO')).Alignment := taCenter;
    TStringField(FieldByName('CAT_CODSIT')).Alignment := taCenter;

    TFloatField(FieldByName('CAT_BASICM')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_ALQICM')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_BASRET')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_ALQRET')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_IVA_ST')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_RESICM')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_RES_ST')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_RESTOT')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_DESCT1')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_DESCT2')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_DESCT3')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_DESCT4')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_DESCT5')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_DESCT6')).Alignment := taCenter;
    TFloatField(FieldByName('CAT_DESCT7')).Alignment := taCenter;

    TFloatField(FieldByName('CAT_BASICM')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_ALQICM')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_BASRET')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('CAT_ALQRET')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_IVA_ST')).DisplayFormat := '#,##0.0000';
    TFloatField(FieldByName('CAT_RESICM')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_RES_ST')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_RESTOT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_DESCT1')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_DESCT2')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_DESCT3')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_DESCT4')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_DESCT5')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_DESCT6')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('CAT_DESCT7')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.pCriaDataSet;
Begin
  cdsGrid := fCriaCdsRessarcimentoCAT();
  dtsGrid := fCriaDataSource(cdsGrid);
  cxgAbrevTableView.DataController.DataSource := dtsGrid;
  cdsGrid.Close;
  cdsGrid.Open;
End;

procedure TfrmCadRessarcimentoIcmsStCAT.pEsconderColunas;
Var
  I: Integer;
begin
  If fCfgSis('MCAT17') <> 'C' Then
  Begin
    cxgAbrevTableView.Bands[4].Visible := False;
    lblCopiarDescontos.Visible := False;
  End;

  For I := 1 To Length(VS_strTabPrc) Do
    If (VS_strTabPrc[I] <> 'S') Or (fCfgSis('MCAT17') <> 'C') Then
      cxgAbrevTableView.GetColumnByFieldName('CAT_DESCT' + I.ToString()).Visible := False;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAbf: TConsultasArray;
begin
  {*****************************}
  {* CONSULTA DE ABREV. FISCAL *}
  {**************************RV*}
  chrKey := '/';
  If fPesqRessarcimentoIcmsStCAT(Self, edtCodAbf, edtDescri, qryTabela, chrKey, arrAbf) Then
  Begin
    pCarregaRessarcimentoCAT();
    pCarregarDadosAbreviacaoFiscal();
    pCalcularRessarcimentoIcmsSt();
    pOnStateChange(0);
    pSetFocus(cxgAbrev);
  End;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.pBeforePost(DataSet: TDataSet);
Var
  I: Integer;
begin
  If (fCfgSis('MCAT17') <> 'C') Then
    Exit;

  For I := 1 To Length(VS_strTabPrc) Do
    If (VS_strTabPrc[I] = 'S') Then
      If DataSet.FieldByName('CAT_DESCT' + I.ToString()).AsFloat >
         DataSet.FieldByName('CAT_RESTOT').AsFloat Then
      Begin
        pMensagemOk('O desconto comercial da tabela de preço ' + I.ToString()
          + ' não pode ser maior que o percentual de ressarcimento total!');
        DataSet.FieldByName('CAT_DESCT' + I.ToString()).AsFloat := 0.00;
      End
      Else If DataSet.FieldByName('CAT_DESCT' + I.ToString()).AsFloat < 0 Then
        DataSet.FieldByName('CAT_DESCT' + I.ToString()).AsFloat := 0.00;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.pCalcularRessarcimentoIcmsSt;
Var
  fltValIcm: Double;
  fltValRet: Double;
  I: Integer;
begin
  cdsGrid.BeforePost := nil;
  cdsGrid.First;
  While Not cdsGrid.Eof Do
  Begin
    cdsGrid.Edit;

    fltValIcm := cdsGrid.FieldByName('CAT_BASICM').AsFloat *
                 cdsGrid.FieldByName('CAT_ALQICM').AsFloat / 100;

    fltValRet := cdsGrid.FieldByName('CAT_BASRET').AsFloat *
                 cdsGrid.FieldByName('CAT_ALQRET').AsFloat *
                 cdsGrid.FieldByName('CAT_IVA_ST').AsFloat / 100 - fltValIcm;

    If fltValRet <= 0 Then
      fltValRet := 0.00;

    If (Not CST_SUBSTITUICAO.Contains(cdsGrid.FieldByName('CAT_CODSIT').AsString)) Then
    Begin
      fltValIcm := 0.00;
      fltValRet := 0.00;
    End;

    cdsGrid.FieldByName('CAT_RESICM').AsFloat := fltValIcm;
    cdsGrid.FieldByName('CAT_RES_ST').AsFloat := fltValRet;
    cdsGrid.FieldByName('CAT_RESTOT').AsFloat := fltValIcm + fltValRet;

    For I := 1 To 7 Do
      If cdsGrid.FieldByName('CAT_RESTOT').AsFloat <= 0 Then
        cdsGrid.FieldByName('CAT_DESCT' + I.ToString()).AsFloat := 0;

    cdsGrid.Post;
    cdsGrid.Next;
  End;
  cdsGrid.First;
  cdsGrid.BeforePost := pBeforePost;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.pCarregarDadosAbreviacaoFiscal();
Var
  qryGen: TUniQuery;
  intField: Integer;
Begin

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLTabelaAbfIcm);
      ParamByName('CODABF').AsString := edtCodAbf.Text;
      Open;
    End;

    qryGen.First;

    cdsGrid.BeforePost := nil;
    cdsGrid.DisableControls;

    While Not qryGen.Eof Do
    Begin
      Application.ProcessMessages;

      If cdsGrid.Locate('CAT_ESTADO', qryGen.FieldByName('CAT_ESTADO').AsString, []) Then
        cdsGrid.Edit
      Else
        cdsGrid.Append;

      For intField := 0 To cdsGrid.FieldCount - 1 Do
      Begin
        If qryGen.FindField(cdsGrid.Fields[intField].FieldName) <> Nil Then
          cdsGrid.Fields[intField].Value := qryGen.FindField(cdsGrid.Fields[intField].FieldName).Value;

        If cdsGrid.Fields[intField].DataType = ftFloat Then
          If cdsGrid.Fields[intField].IsNull Then
            cdsGrid.Fields[intField].Value := 0.00;
      End;

      cdsGrid.Post;

      qryGen.Next;
    End;

    cdsGrid.EnableControls;
    cdsGrid.BeforePost := pBeforePost;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.pCarregaRessarcimentoCAT();
Var
  qryGen: TUniQuery;
  intField: Integer;
Begin

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLTabelaResCat);
      ParamByName('CODABF').AsString := edtCodAbf.Text;
      Open;
    End;

    qryGen.First;

    cdsGrid.EmptyDataSet;
    cdsGrid.DisableControls;
    cdsGrid.BeforePost := nil;

    While Not qryGen.Eof Do
    Begin
      Application.ProcessMessages;

      cdsGrid.Append;

      For intField := 0 To cdsGrid.FieldCount - 1 Do
      Begin
        If qryGen.FindField(cdsGrid.Fields[intField].FieldName) <> Nil Then
          cdsGrid.Fields[intField].Value := qryGen.FindField(cdsGrid.Fields[intField].FieldName).Value;

        If cdsGrid.Fields[intField].DataType = ftFloat Then
          If cdsGrid.Fields[intField].IsNull Then
            cdsGrid.Fields[intField].Value := 0.00;
      End;

      cdsGrid.Post;

      qryGen.Next;
    End;

    cdsGrid.EnableControls;
    cdsGrid.BeforePost := pBeforePost;
  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmCadRessarcimentoIcmsStCAT.pCopiarDescontos;
Var
  arrDescontos: Array[1..7] Of Double;
  I: Integer;
begin
  If cdsGrid.State = dsEdit Then
    cdsGrid.Post;

  If Not fPergunta('Confirma copiar os descontos do registro '+
    'posicionado para todos os outros estados?') Then
    Exit;

  For I := 1 To 7 Do
    arrDescontos[I] := cdsGrid.FieldByName('CAT_DESCT' + I.ToString()).AsFloat;

  cdsGrid.First;
  While Not cdsGrid.Eof Do
  Begin
    cdsGrid.Edit;

    For I := 1 To 7 Do
      If cdsGrid.FieldByName('CAT_RESTOT').AsFloat <= 0 Then
        cdsGrid.FieldByName('CAT_DESCT' + I.ToString()).AsFloat := 0
      Else
        cdsGrid.FieldByName('CAT_DESCT' + I.ToString()).AsFloat := arrDescontos[I];

    cdsGrid.Post;
    cdsGrid.Next;
  End;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pnlHeader.Enabled := False;
  pLimpaEdits;
  cdsGrid.EmptyDataSet;
  pOnStateChange(1);
  btnIncluirTodasAbreviacoes.Enabled := True;

end;

procedure TfrmCadRessarcimentoIcmsStCAT.btnGravarClick(Sender: TObject);
begin
  inherited;
  btnIncluirTodasAbreviacoes.Enabled := True;

  If cdsGrid.IsEmpty Then
    Exit;

  If Not fValidarDescontoComercial() Then
    Exit;

  If Not fValidapanel(pnlHeader) Then
    Exit;

  If (fMensagem('', 'Confirma gravação?', ['&Sim', '&Não']) = 2) Then
    Exit;

  If Not fChamaTelaGravando(fGravarRessarcimentoCAT) Then
    Exit;

  pMensagemOk('Gravação realizada com sucesso!');
  btnIncluirTodasAbreviacoes.Enabled := True;


  btnCancela.Click;
end;

function TfrmCadRessarcimentoIcmsStCAT.fCriaCdsRessarcimentoCAT: TUniClientDataSet;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);
  Try
    qryGen := fCriarQuery(fGetSQLTabelaResCat());
    qryGen.Open;
    Result := fCriaClientDatset(qryGen, True, Self);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadRessarcimentoIcmsStCAT.fGetSQLTabelaAbfIcm: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   ABF_CODABF AS CAT_CODABF, ';
  Result := Result + '   ABF_ESTADO AS CAT_ESTADO, ';
  Result := Result + '   ABF_CODSIT_ENT_PEJ AS CAT_CODSIT, ';
  Result := Result + '   ABF_BASICM_ENT_PEJ AS CAT_BASICM, ';
  Result := Result + '   ABF_ALQICM_ENT_PEJ AS CAT_ALQICM, ';
  Result := Result + '   ABF_BASRET_ENT_PEJ AS CAT_BASRET, ';
  Result := Result + '   ABF_ALQRET_ENT_PEJ AS CAT_ALQRET, ';
  Result := Result + '   ABF_IVA_ST_ENT_PEJ AS CAT_IVA_ST  ';
  Result := Result + ' FROM ';
  Result := Result + '   ABFICM ';
  Result := Result + ' WHERE ABF_CODABF = :CODABF ';
  Result := Result + ' ORDER BY ABF_ESTADO ';
end;

function TfrmCadRessarcimentoIcmsStCAT.fGetSQLTabelaResCat: String;
begin
  Result := ' SELECT * FROM RESCAT WHERE CAT_CODABF = :CODABF ORDER BY CAT_ESTADO ';
end;

function TfrmCadRessarcimentoIcmsStCAT.fGravarRessarcimentoCAT(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryGen   : TUniQuery;
    strSQL   : String;
    intField : Integer;
    prcScroll: TPrcScroll;
begin
  Result := False;

  Try
    If Not fStartTransaction Then
      Exit;

    pDisableControls(cdsGrid, prcScroll);

    qryGen := fCriaQuery;

    If Assigned(pgbStatus) Then
      pgbStatus.properties.Max := cdsGrid.RecordCount;

    fExecutaSQL('DELETE FROM RESCAT WHERE CAT_CODABF = "' + edtCodAbf.Text + '"');

    cdsGrid.First;
    While Not cdsGrid.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + ' INSERT INTO RESCAT ( ';

      For intField := 0 To cdsGrid.FieldCount - 1 Do
      Begin
        strSQL := strSQL + cdsGrid.Fields[intField].FieldName;
        If intField < (cdsGrid.FieldCount - 1) Then
          strSQL := strSQL + ', ';
      End;

      strSQL := strSQL + ' ) ';
      strSQL := strSQL + ' VALUES ( ';

      For intField := 0 To cdsGrid.FieldCount - 1 Do
      Begin
        If cdsGrid.Fields[intField].FieldName = 'AUTOINCREM' Then
          strSQL := strSQL + ':AUTINC '
        Else
          strSQL := strSQL + AnsiReplaceStr(cdsGrid.Fields[intField].FieldName, 'CAT_', ':');

        If intField < (cdsGrid.FieldCount - 1) Then
          strSQL := strSQL + ', ';
      End;

      strSQL := strSQL + ' ) ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        If fEmptyStr(cdsGrid.Fieldbyname('AUTOINCREM').AsString) Then
          ParamByName('AUTINC').AsString := fRetAutoIncrem('RESCAT', VS_strCodEmp)
        Else
          ParamByName('AUTINC').AsString := cdsGrid.Fieldbyname('AUTOINCREM').AsString;

        For intField := 0 To Params.Count - 1 Do
          If cdsGrid.FindField('CAT_' + Params[intField].Name) <> Nil Then
            Params[intField].Value := cdsGrid.FindField('CAT_' + Params[intField].Name).Value;

        ParamByName('CODABF').AsString := edtCodAbf.Text;

        If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
          TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := 'Aguarde, gravando registros ...';

        If Assigned(pgbStatus) Then
          pgbStatus.Position := cdsGrid.RecNo;

        Application.ProcessMessages;

        ExecSQL;
      End;

      cdsGrid.Next;

    End;

    Result := fCommit;
  Finally
    If Not Result Then
      fRollBack;

    FreeAndNil(qryGen);

    pEnableControls(cdsGrid, prcScroll);
  End;

end;

function TfrmCadRessarcimentoIcmsStCAT.fIncluiAbreviacoes(
  pgbStatus: TcxProgressBar): Boolean;
  var qryAbf: TUniQuery;
begin
  Result := True;
  qryAbf := fCriaQuery;
  Try
     qryAbf.SQL.Add('SELECT ABF_CODABF FROM  ABFICM');
     qryAbf.SQL.Add('  LEFT JOIN RESCAT ON CAT_CODABF = ABFICM.ABF_CODABF');
     qryAbf.SQL.Add(' WHERE RESCAT.AUTOINCREM IS NULL');
     qryAbf.SQL.Add(' GROUP BY ABF_CODABF');
     qryAbf.Open;

     If qryAbf.IsEmpty Then
     begin
       pMensagemOk('Sem abreviações para serem importadas!');
       Exit;
     end;
     cdsGrid.DisableControls;
     pgbStatus.Properties.max := qryAbf.RecordCount -1;
     while not qryAbf.Eof Do
     Begin
       edtCodAbf.Text := qryAbf.FieldByName('ABF_CODABF').AsString;
       pCarregaRessarcimentoCAT();
       pCarregarDadosAbreviacaoFiscal();
       pCalcularRessarcimentoIcmsSt();
       fValidaCampos(edtCodAbf, True);
       fGravarRessarcimentoCAT;
       qryAbf.Next;
       pgbStatus.Position := qryAbf.RecNo;
       Application.ProcessMessages;
     End;
  Finally
     pMensagemOk('Importação concluida!');
     edtCodAbf.Text := '';
     cdsGrid.EnableControls;
     FreeAndNil(qryAbf);
     btnCancela.Click;
  End;

  {}
end;

procedure TfrmCadRessarcimentoIcmsStCAT.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape: If cdsGrid.IsEmpty Then
                 Close
               Else
                 btnCancela.Click;

    VK_F3: If lblCopiarDescontos.Visible And Not cdsGrid.IsEmpty Then
             fExecutarModal(pCopiarDescontos,
              'Aguarde, copiando descontos ...', '');
  End;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.FormPaint(Sender: TObject);
begin
  inherited;
  btnSair.Left := (pnlBotoes.Width-(btnSair.Width+10));
end;

procedure TfrmCadRessarcimentoIcmsStCAT.btnConsultarProdutoClick(
  Sender: TObject);
var
  frmProdutoRessarcimentoIcmsStCAT: TfrmProdutoRessarcimentoIcmsStCAT;
begin
  inherited;
  pCriarFormularios(TfrmProdutoRessarcimentoIcmsStCAT, frmProdutoRessarcimentoIcmsStCAT);
  try
    frmProdutoRessarcimentoIcmsStCAT.CodAbreviacao := edtCodAbf.Text;
    frmProdutoRessarcimentoIcmsStCAT.SetData(cdsGrid);
    frmProdutoRessarcimentoIcmsStCAT.ShowModal;
  finally
    pFreeAndNil(frmProdutoRessarcimentoIcmsStCAT)
  end;
end;

procedure TfrmCadRessarcimentoIcmsStCAT.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If cdsGrid.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!',['&Ok']);
    Exit;
  End;

  If Not fPergunta('Deseja realmente excluir esse registro?') Then
    Exit;

  fExecutaSQL('DELETE FROM RESCAT WHERE CAT_CODABF = "' + edtCodAbf.Text + '"');

  btnCancela.Click;

  pSetFocus(btnIncluir);
  btnIncluirTodasAbreviacoes.Enabled := True;

end;

procedure TfrmCadRessarcimentoIcmsStCAT.edtCodAbfKeyPress(Sender: TObject; var Key: Char);
Var
  arrAbf: TConsultasArray;
begin
  inherited;
  If fPesqAbrevFiscal(Self, edtCodAbf, edtDescri, qryTabela, Key, arrAbf) Then
  Begin
    pCarregaRessarcimentoCAT();
    pCarregarDadosAbreviacaoFiscal();
    pCalcularRessarcimentoIcmsSt();
    pOnStateChange(0);
    pSetFocus(cxgAbrev);
  End;
end;

end.
