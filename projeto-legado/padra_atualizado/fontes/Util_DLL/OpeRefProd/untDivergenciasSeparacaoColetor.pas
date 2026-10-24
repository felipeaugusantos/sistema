unit untDivergenciasSeparacaoColetor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Uni, UniClientDataSet, untTypesSistema, untCadLote, cxCalc, cxTextEdit,
  Vcl.ComCtrls, cxProgressBar, untDllOpeProd, cxContainer, untAuditoriaGravacaoSaldo,
  frxExportPDF, frxDBSet, System.Types;

type
  TCampo = Record
    Title,
    FieldName: String;
    DisplayFormat: string;
  End;

  TArrCampos = Array Of TCampo;

  TStatusSeparacao = (tssConcluido, tssRealizado);

  TfrmDivergenciasSeparacaoColetor = class(TfrmPai)
    pnlHeader: TPanel;
    Label12: TLabel;
    mskDtaMov: TMaskEditFocus;
    Label11: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    lblCodIte: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    lblLocFis: TLabel;
    edtLocFis: TEditFocus;
    btnPesquisar: TBitBtnLocked;
    cxgItens: TcxGridCitel;
    cxgItensView: TcxGridDBBandedTableViewCitel;
    cxgItensDTACAD: TcxGridDBBandedColumn;
    cxgItensOPESEP: TcxGridDBBandedColumn;
    cxgItensCODITE: TcxGridDBBandedColumn;
    cxgItensLOCFIS: TcxGridDBBandedColumn;
    cxgItensNUMLOT: TcxGridDBBandedColumn;
    cxgItensQTDSEP: TcxGridDBBandedColumn;
    cxgItensSALINF: TcxGridDBBandedColumn;
    cxgItensAJUSTE: TcxGridDBBandedColumn;
    cxgItensLevel1: TcxGridLevel;
    cxgItensSALSIS: TcxGridDBBandedColumn;
    cxgItensDIVERG: TcxGridDBBandedColumn;
    btnConfirma: TBitBtnLocked;
    btnMovimentacao: TBitBtnLocked;
    btnExcel: TBitBtnLocked;
    dtsDivergencias: TDataSource;
    btnLimpar: TBitBtnLocked;
    pgbItens: TcxProgressBar;
    cxgItensSELECT: TcxGridDBBandedColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    Label1: TLabel;
    mskHorMov: TMaskEditFocus;
    SaveDialog: TSaveDialog;
    mnuExportar: TPopupMenu;
    mnuExpExcel: TMenuItem;
    mnuExpPDF: TMenuItem;
    mnuExpCSV: TMenuItem;
    frxRelPDF: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    frxExpPDF: TfrxPDFExport;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnMovimentacaoClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure cxgItensViewDblClick(Sender: TObject);
    procedure cxgItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure mnuExpExcelClick(Sender: TObject);
    procedure mnuPontosdeEntradaClick(Sender: TObject);
    procedure mnuExpPDFClick(Sender: TObject);
    procedure mnuExpCSVClick(Sender: TObject);
    procedure edtNumLotExit(Sender: TObject);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    //objAuditoriaSaldo: IAuditoriaGravacaoSaldo;
    arrProduto: TConsultasArray;
    cdsDivergencias: TUniClientDataSet;
    objCadLot: TCadLot;
    strMOVFUL: String;
    strFileName: String;
    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;
    FblnSinNumLot: Boolean;
    function fGetSQLDivergencias: String;
    procedure pBuscaDivergencias;
    procedure pSetaParametrosDivergencias(qryDivergencias: TUniQuery);
    function fCarregaItem(ACodIte: String): Boolean;
    procedure pLimpaCampos;
    function pAjustarEstoque(pgbProgresso: TcxProgressBar): Boolean;
    function fCalcTotais: Double;
    function fGravar(pgbProgresso: TcxProgressBar): Boolean;
    function fItensParaGerarAjuste: Integer;
    //function fTrataCampoSalExt(AField: String): string;
    function fGeraArquivoCSVAux(pgbProgresso: TcxProgressBar): Boolean;
    procedure pExportaParaCSV;
    function fRemoveQuebra(strInput: String): String;
    procedure pSelecionaItem(pTag: Integer; blnTodos: Boolean = False);
    procedure pGravaStatusSeparacao(AAutIncSep: String; AStatusSeparacao: TStatusSeparacao);
    function fItensSelecionados: Integer;
    function fGeraExcel(cxProgress: TcxProgressBar): Boolean;
    function fExisteNumLot(ANumLot: String): Boolean;
    function fGravaLogAjusteSparacao(ADtaAju: TDateTime;
      ACodIte, ALocFis, ANumLot: string; AQtdSep: Double; AOpeSep,
      ACodOpe: string; ADtaCad: TDateTime; ASalInf, ASalSis, AAjuste: Double;
      ASeqDet, ASeqSep: string): Boolean;
  public
     objDllOpeProd : TparamOpeProd;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

Var
  frmDivergenciasSeparacaoColetor: TfrmDivergenciasSeparacaoColetor;

implementation

uses
  untFuncoesConsulta, untConsultas, untFuncoesSimples, untGravando, untCadIte,
  untDivergenciasSeparacaoColetorUltMov, untGeraExcel, XLSWriter,
  XLSColors;

{$R *.dfm}

procedure TfrmDivergenciasSeparacaoColetor.pLimpaCampos;
begin
  mskDtaMov.Clear;
  mskHorMov.Clear;
  edtCodOpe.Clear;
  edtCodIte.Clear;
  edtLocFis.Clear;
  edtNumLot.Clear;
  edtDesIte.Clear;
  edtNomOpe.Clear;
  If cdsDivergencias.Active Then
    cdsDivergencias.Close;

end;

procedure TfrmDivergenciasSeparacaoColetor.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (cdsDivergencias.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'Sem divergencias para serem ajustadas!', ['&O k']);
    Exit;
  End;

  If fItensSelecionados = 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum item selecionado!', ['&O k']);
    Exit;
  End;

  If (cdsDivergencias.State in [dsEdit]) Then
    cdsDivergencias.Post;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravar;
    frmGravando.ShowModal;
    //if frmGravando.blnConfirma Then
      //fMensagem('','Gravação de Ajustes concluída !',['&O K']);
  Finally
    FreeAndNil(frmGravando);
    pLimpaCampos;
  End;
end;

procedure TfrmDivergenciasSeparacaoColetor.btnDesmarcarTodosClick(
  Sender: TObject);
begin
  If (cdsDivergencias.Active) And (Not cdsDivergencias.IsEmpty) Then
    pSelecionaItem(0, True);
end;

procedure TfrmDivergenciasSeparacaoColetor.btnExcelClick(Sender: TObject);
Var
  Pt: TPoint;
begin
  Pt := btnExcel.ClientToScreen(Point(0,0));
  mnuExportar.Popup(Pt.X, Pt.Y - mnuExportar.Items.Count * 25);
end;

procedure TfrmDivergenciasSeparacaoColetor.btnLimparClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

procedure TfrmDivergenciasSeparacaoColetor.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  If (cdsDivergencias.Active) And (Not cdsDivergencias.IsEmpty) Then
  pSelecionaItem(1, True);
end;

procedure TfrmDivergenciasSeparacaoColetor.btnMovimentacaoClick(
  Sender: TObject);
begin
  inherited;
  If (cdsDivergencias.IsEmpty) Then
  Begin
    pMensagemOk('Sem dados para serem exibidos!');
    Exit;
  End;

  TfrmDivergenciasSeparacaoColetorUltMov.pExibeUltimasMovimentacoes(
                          cdsDivergencias.FieldByName('SIN_CODITE').AsString,
                          cdsDivergencias.FieldByName('SIN_LOCFIS').AsString);

end;

procedure TfrmDivergenciasSeparacaoColetor.btnPesquisarClick(Sender: TObject);
begin
  inherited;
  pBuscaDivergencias;
end;

procedure TfrmDivergenciasSeparacaoColetor.cxgItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If Not cdsDivergencias.Active Then
    Exit;

  If IfNull(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensSELECT.Index],'N') = 'S' Then
    ACanvas.Font.Color := clGreen;
end;

procedure TfrmDivergenciasSeparacaoColetor.cxgItensViewDblClick(
  Sender: TObject);
begin
  inherited;
  If Not (cdsDivergencias.IsEmpty) Then
  Begin
    pSelecionaItem(0, False);
  End;
end;

procedure TfrmDivergenciasSeparacaoColetor.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key in [vk_return, vk_Space] then
  begin
    Key := 0;
    If Not (cdsDivergencias.IsEmpty) Then
    Begin
      pSelecionaItem(0, False);
    End
  end;
  inherited;
end;

procedure TfrmDivergenciasSeparacaoColetor.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte, edtDesIte, arrProduto, nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmDivergenciasSeparacaoColetor.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProduto, False) Then
  Begin
    fValidaCampos(edtCodIte, False);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDivergenciasSeparacaoColetor.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
Begin
  Try
    if fPesqOperador(Self, edtCodOpe, edtNomOpe, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodOpe, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      fMensagem('', 'Erro na busca rápida: ' + E.Message, ['&O k']);
    End;
  End;
end;

procedure TfrmDivergenciasSeparacaoColetor.edtLocFisKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
  // objfrmPnl: TPanelCxLocalizacoesLote;
begin
  inherited;

  Try
    If fPesqLotLoc(Self, Nil, edtLocFis, Nil, Key, arrSel, True, edtCodIte.Text, edtNumLot.Text) Then
    Begin
      If fValidaCampos(edtLocFis, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  Finally
    // pFreeAndNil(objFrmPnl);
  End;
end;

procedure TfrmDivergenciasSeparacaoColetor.edtNumLotExit(Sender: TObject);
begin
  inherited;
    fValidaCampos(edtNumLot, False);
end;

procedure TfrmDivergenciasSeparacaoColetor.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If objCadLot.fedtNumLotKeyPress(edtCodIte.Text, Sender, Key, edtNumLot, Self,
    False, True, Nil, nil, 'Lote', False, False) Then
  Begin
    If fValidaCampos(edtNumLot, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDivergenciasSeparacaoColetor.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDivergencias := TUniClientDataSet.Create(Self);
  dtsDivergencias.DataSet := cdsDivergencias;
  objCadLot := TCadLot.Create(Self);
  strMOVFUL := fCfgSis('MOVFUL');
  btnConfirma.Enabled := fVerificaAcessoSistema('GAJESTDSEP', strLoginUsuarioLogado); //GRAVAR AJUSTE ESTOQUE - DIVERGENCIA SEPARAÇÃO
  cxgItensAJUSTE.Options.Editing := btnConfirma.Enabled;
  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
  FblnSinNumLot := fCampoExiste('SEPINV', 'SIN_NUMLOT', True);
end;

function TfrmDivergenciasSeparacaoColetor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try
    If (inherited fValidaCampos(Sender)) Then
    Begin
      If (Sender = mskHorMov) Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciais(mskDtaMov.Text))) And
           (Not fEmptyStr(fTiraCaracEspeciais(mskHorMov.Text, True, False, True, True))) Then
        Begin
          fMensagem('ATENÇÃO!', 'Para informar a Hora é necessário informar também a Data!', ['&O k']);
          Result := False;
        End;
      End
      Else If (Sender = edtCodOpe) Then
      Begin
        If not fEmptyStr(edtCodOpe.Text) Then
        Begin
          edtNomOpe.Text := fRetNomeOperador(edtCodOpe.Text);
          If fEmptyStr(edtNomOpe.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse operador não foi encontrado!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else If (Sender = edtCodIte) Then
      Begin
        If Not fEmptyStr(edtCodIte.Text) Then
        Begin
          If Not fCarregaItem(edtCodIte.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else If (Sender = edtNumLot) Then
      Begin
        If Not fEmptyStr(edtNumLot.Text) Then
        Begin
          If Not fEmptyStr(edtCodIte.Text) Then
          Begin
            If Not objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp,
              edtNumLot.Text, True, False, False) Then
            Begin
              fMensagem('ATENÇÃO!', objCadLot.strTitLab + ' não encontrado!', ['&Ok']);
              Result := False;
            End;
          End
          Else
            If Not fExisteNumLot(edtNumLot.Text) Then
            Begin
              fMensagem('ATENÇÃO!', objCadLot.strTitLab + ' não encontrado!', ['&Ok']);
              Result := False;
            End;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,
        '[TfrmDivergenciasSeparacaoColetor.fValidaCampos]');
      Result := False;
    End;
  End;
end;

procedure TfrmDivergenciasSeparacaoColetor.mnuExpCSVClick(Sender: TObject);
begin
  If (cdsDivergencias.IsEmpty) Then
  Begin
    pMensagemOk('Sem dados para serem exportados!');
    Exit;
  End;

  pExportaParaCSV;
end;

procedure TfrmDivergenciasSeparacaoColetor.mnuExpExcelClick(Sender: TObject);
begin
  If (cdsDivergencias.IsEmpty) Then
  Begin
    pMensagemOk('Sem dados para serem exportados!');
    Exit;
  End;

  strFileName := '';
    SaveDialog.Filter := 'Arquivos Excel|*.xls';
  SaveDialog.FileName := 'DivergenciasSeparacaoColetor.xls';
  If SaveDialog.Execute(Self.Handle) then
    strFileName := SaveDialog.FileName
  Else
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGeraExcel;
    frmGravando.pgbStatus.Visible := True;
    frmGravando.lblGravando.Caption := 'Gerando arquivo Excel...';
    frmGravando.ShowModal;
  Finally
    If Assigned(frmGravando) Then
      FreeAndNil(frmGravando);
  End;
end;

procedure TfrmDivergenciasSeparacaoColetor.mnuExpPDFClick(Sender: TObject);
begin
  inherited;

  If (cdsDivergencias.IsEmpty) Then
  Begin
    pMensagemOk('Sem dados para serem exportados!');
    Exit;
  End;

  strFileName := '';
  SaveDialog.Filter := 'Arquivos PDF|*.pdf';
  SaveDialog.FileName := 'DivergenciasSeparacaoColetor.pdf';
  If SaveDialog.Execute(Self.Handle) then
    strFileName := SaveDialog.FileName
  Else
    Exit;

  frxRelatorio.DataSource := dtsDivergencias;
  frxRelPDF.Variables['NOMEMP'] := QuotedStr(VS_strCodEmp + ' - ' + fRetNomeEmpresa);
  frxRelPDF.PrepareReport;

  frxExpPDF.FileName := strFileName;
  frxExpPDF.ShowDialog := False;
  frxExpPDF.DefaultPath := '';

  If frxRelPDF.Export(frxExpPDF) Then
    pMensagemOk('Arquivo salvo com sucesso! ' + strFileName);
end;

procedure TfrmDivergenciasSeparacaoColetor.mnuPontosdeEntradaClick(
  Sender: TObject);
begin
  inherited;

end;

{function TfrmDivergenciasSeparacaoColetor.fTrataCampoSalExt(AField: String): string;
begin
  Result := AField;
  If strMOVFUL = '2' then
    Result := '0'
end; }

function TfrmDivergenciasSeparacaoColetor.fGetSQLDivergencias: String;
Var
  strTabPrecoImp : String;
begin
  strTabPrecoImp := fTabPrecoImp(fCfgSis('IMPAJU', varString), fCfgSis('PREAJU', varString));
  Result := '';
  Result := Result + ' SELECT DISTINCT ';
  Result := Result + '        S.AUTOINCREM, ';
  Result := Result + '        SIN_SEQFDO, ';
  Result := Result + '        SIN_CODITE, ';
  Result := Result + '        SIN_LOCFIS, ';
  Result := Result + '        SIN_QTDSEP, ';
  Result := Result + '        SIN_OPESEP, ';
  Result := Result + '        SIN_DTACAD, ';
  Result := Result + '        SIN_SALINF, ';
  Result := Result + '        SIN_SALSIS, ';
  Result := Result + '        SIN_STAAJU, ';
  Result := Result + '        O.OPE_NOMOPE, ';
  Result := Result + '        LOT_NUMLOT, ';
  Result := Result + '        ITE_CODMAR, ';
  Result := Result + '        ITE_DESITE, ';
  Result := Result + '        ITE_REFERE, ';
  Result := Result + '        ITE_CODUNI, ';
  Result := Result + '        ITE_CODFOR, ';
  Result := Result + '        ITE_PRECUS, ';
  Result := Result + '        ITE_PREMED, ';
  Result := Result + '        ITE_INCPIS, ';
  Result := Result + '        ITE_IMPULT, ';
  Result := Result + '        ITE_PREULT,  ';
  Result := Result + '        "N" AS ITE_SELECT,  ';
  Result := Result + '        IFNULL(SIN_SALINF,0) - IFNULL(SIN_SALSIS,0) AS SIN_AJUSTE, ';
  Result := Result + '        IFNULL(SIN_SALINF,0) - IFNULL(SIN_SALSIS,0) AS SIN_DIVERG, ';
  Result := Result + '        G.ITE_' + strTabPrecoImp + ' AS ITE_VALUNI, ';
  Result := Result + '        CONCAT(I.ITE_CODITE, " - " , I.ITE_DESITE) AS ITE_CODDES ';

  Result := Result + ' FROM SEPINV S ';
  Result := Result + ' INNER JOIN CADOPE O ON S.SIN_OPESEP = O.OPE_CODOPE ';
  Result := Result + ' INNER JOIN CADITE I ON S.SIN_CODITE = I.ITE_CODITE ';

  Result := Result + ' INNER JOIN ITEGER G  ON G.ITE_CODITE  = I.ITE_CODITE   ';
  Result := Result + ' 	               AND G.ITE_CODEMP  = ' + QuotedStr(VS_strCodEmp);
  Result := Result + ' 	 LEFT JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI  ';
  Result := Result + ' 	 INNER JOIN CADLOT   ON LOT_CODITE = G.ITE_CODITE ';
  Result := Result + ' 	                   AND LOT_CODEMP = G.ITE_CODEMP ';
  Result := Result + ' 	                   AND LOT_LOCFIS = S.SIN_LOCFIS ';

  {O CAMPO SERÁ CRIADO POR OUTRO REQUISITO, A FIM DE EVITAR ERRO DE DEPENDÊNCIA DE DEPLOY NÃO SATISFEITA.}
  If FblnSinNumLot Then
    Result := Result + ' 	                   AND IF(S.SIN_NUMLOT IS NULL, TRUE, LOT_NUMLOT = S.SIN_NUMLOT) ';

  Result := Result + ' WHERE S.SIN_DTACAD = (SELECT MAX(S2.SIN_DTACAD) ';
  Result := Result + '   FROM SEPINV S2 ';
  Result := Result + '      WHERE S2.SIN_CODITE = S.SIN_CODITE ';
  Result := Result + '       AND S2.SIN_LOCFIS = S.SIN_LOCFIS) ';

  Result := Result + ' AND IFNULL(SIN_STAAJU, "") NOT IN ("C", "R") ';

  // FILTROS
  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaMov.Text))) Then
    Result := Result + ' AND SIN_DTACAD BETWEEN :DTAINI AND :DTAFIM';

  If (Not fEmptyStr(edtCodOpe.Text)) Then
    Result := Result + ' AND S.SIN_OPESEP = :CODOPE ';

  If (Not fEmptyStr(edtCodIte.Text)) Then
    Result := Result + ' AND S.SIN_CODITE = :CODITE ';

  If (Not fEmptyStr(edtLocFis.Text)) Then
    Result := Result + ' AND S.SIN_LOCFIS = :LOCFIS ';

  If (Not fEmptyStr(edtNumLot.Text)) Then
    Result := Result + ' AND LOT_NUMLOT = :NUMLOT ';

  Result := Result + ' ORDER BY SIN_CODITE ';
end;

procedure TfrmDivergenciasSeparacaoColetor.pSetaParametrosDivergencias
  (qryDivergencias: TUniQuery);
begin
  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaMov.Text))) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskHorMov.Text, True, False, True, True))) Then
    Begin
      qryDivergencias.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaMov.Text + ' ' + mskHorMov.Text + ':00');
      qryDivergencias.ParamByName('DTAFIM').AsDateTime := StrToDateTime(mskDtaMov.Text + ' ' + mskHorMov.Text + ':59');
    End
    Else
    Begin
      qryDivergencias.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaMov.Text + ' 00:00:00');
      qryDivergencias.ParamByName('DTAFIM').AsDateTime := StrToDateTime(mskDtaMov.Text + ' 23:59:59');
    End;
  End;

  If (Not fEmptyStr(edtCodOpe.Text)) Then
    qryDivergencias.ParamByName('CODOPE').AsString := edtCodOpe.Text;

  If (Not fEmptyStr(edtCodIte.Text)) Then
    qryDivergencias.ParamByName('CODITE').AsString := edtCodIte.Text;

  If (Not fEmptyStr(edtLocFis.Text)) Then
    qryDivergencias.ParamByName('LOCFIS').AsString := edtLocFis.Text;

  If (Not fEmptyStr(edtNumLot.Text)) Then
    qryDivergencias.ParamByName('NUMLOT').AsString := edtNumLot.Text;
end;

procedure TfrmDivergenciasSeparacaoColetor.pBuscaDivergencias;
Var
  qryDivergencias: TUniQuery;
begin
  cdsDivergencias.Close;
  qryDivergencias := fCriaQuery();

  Try
    qryDivergencias.Close;
    qryDivergencias.SQL.Clear;
    qryDivergencias.SQL.Add(fGetSQLDivergencias);

    Try
      pSetaParametrosDivergencias(qryDivergencias);
      qryDivergencias.Open;
      cdsDivergencias := CriarClientDataSet(qryDivergencias, Self);
      cdsDivergencias.Open;
      dtsDivergencias.DataSet := cdsDivergencias;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmDivergenciasSeparacaoColetor.pBuscaDivergencias]');
      End;
    End;
  Finally
    FreeAndNil(qryDivergencias);
  End;
end;

function TfrmDivergenciasSeparacaoColetor.fCarregaItem(ACodIte: String): Boolean;
begin
  edtDesIte.Text := fRetNomProduto(ACodIte);
  Result := Not fEmptyStr(edtDesIte.Text);
end;


function TfrmDivergenciasSeparacaoColetor.fItensParaGerarAjuste: Integer;
begin
  cdsDivergencias.First;

  cdsDivergencias.Filtered := False;
  cdsDivergencias.Filter := 'ITE_SELECT = ' + QuotedStr('S') + ' AND SIN_AJUSTE <> 0';
  cdsDivergencias.Filtered := True;
  Result :=  cdsDivergencias.RecordCount;
  cdsDivergencias.First;
end;

function TfrmDivergenciasSeparacaoColetor.fItensSelecionados: Integer;
begin
  cdsDivergencias.DisableControls;
  cdsDivergencias.First;

  cdsDivergencias.Filtered := False;
  cdsDivergencias.Filter := 'ITE_SELECT = ' + QuotedStr('S');
  cdsDivergencias.Filtered := True;
  Result :=  cdsDivergencias.RecordCount;
  cdsDivergencias.Filtered := False;
  cdsDivergencias.Filter := '';
  cdsDivergencias.First;
end;

function TfrmDivergenciasSeparacaoColetor.pAjustarEstoque(pgbProgresso: TcxProgressBar): Boolean;
Var
  LQtdAlt: Integer;
  LCodIte: String;
  LLocFis: String;
  LNumLot: String;
  LDocsGerados: String;
  LNumDocAJ: String;
  LAutIncMovGer: String;
  LCodErrosAuditoria: String;
  recServicos: TDadosServicos;
  LCnv_Ml: Double;
  LCodCli: String;
  LEntSai: String;
  LClaFis: String;
  LAutTmp: String;
  LQtdIte: Double;
  LTotIte: Double;
  LTotAju: Double;
  LarrDuplic: TarrDuplicata;
  LUsaMaisDeUmaLocalizacaoFisicaPorLote: Boolean;
//  LCodErrosAuditoria: String;
begin
  Result := True;
  LUsaMaisDeUmaLocalizacaoFisicaPorLote := fCfgSis('UM1LFL', varBoolean);
  LQtdAlt := fItensParaGerarAjuste;
  LCodCli := fCfgSis('CLIAJU');
  objAuditoriaSaldo.Limpar;

  cdsDivergencias.DisableControls;
  Try
    fStartTransaction;
    Try
      cdsDivergencias.First;
      pgbProgresso.Properties.Max := LQtdAlt;
      pgbProgresso.Position := 0;
      LDocsGerados := '';
      LAutTmp := fRetAutoIncrem('MOVDET', VS_strCodEmp, LQtdAlt);

      LTotAju := fCalcTotais;

      If (LQtdAlt > 0) Then
      Begin
        LNumDocAJ := fRetSequencial('PRO_AJ', VS_strCodEmp, fTamDocCadRec);
        LDocsGerados := LDocsGerados + LNumDocAJ + ' - AJ - ' + VS_strCodEmp + #$A#$D;
        LAutIncMovGer := fStrEspaco(' ', 20);
        {$region 'fGravaMovGer Result := fGravaMovGer(strAutInc,'}
        Result := objDllOpeProd.varParam.fGMovGer(LAutIncMovGer,                         // Auto Incremento (Retorno)
                             LNumDocAJ,                               // Numero Documento
                             'AJ',                               // Espécie
                             VS_strCodEmp,                            // Empresa
                             '',                                      // Transportadora
                             strLoginUsuarioLogado,                   // Vendedor
                             '',                                      // Fornecedor
                             fCfgSis('CLIAJU'),                         // Cliente
                             'C',                                       // Tipo ((C)liente / (F)ornecedor)
                             VS_Date,                                   // Data da Entrada
                             fTime(),                                   // Hora da Entrada
                             VS_Date,                                   // Data do Documento
                             '01000',                                   // Condição de Pagamento
                             '',                                        // Estado do Cliente / Fornecedor
                             '',                                        // Nome do Consumidor
                             '',                                        // Endereço do Consumidor
                             '',                                        // Bairro do Consumidor
                             '',                                        // Cep do Consumidor
                             '',                                        // Cidade do Consumidor
                             '',                                        // Estado do Consumidor
                             '',                                        // Telefone do Consumidor
                             0,
                             '',                                        // CNPJ / CGC
                             '',                                        // CNPJ / CGC do consumidor
                             '',                                        // Inscrição estadual do Consumidor
                             '',                                        // RG do consumidor
                             0.0,                                       // Base Simples Paulista
                             0.0,                                       // Base de IPI
                             0.0,                                       // Aliquota de IPI
                             0.0,                                       // Total de IPI
                             0.0,                                       // Base de ICMS
                             0.0,                                       // Aliquota de ICMS
                             0.0,                                       // Total de ICMS
                             0.0,                                       // Valor de Substituição
                             0.0,                                       // Aliquota de Substituição
                             0.0,                                       // Base de Substituição
                             0.0,                                       // Base de Substituição Simulada
                             0.0,                                       // Desconto Especial
                             LTotAju,                                   // Valor Contábil
                             LTotAju,                                   // Total dos Itens
                             0.0,                                       // Total de Custo
                             0.0,                                       // Total Médio
                             '',                                        // Tipo de Frete
                             0.0,                                       // Valor do Frete
                             0.0,                                       // Peso Bruto
                             0.0,                                       // Peso Liquido
                             0.0,                                       // Volume
                             '',                                        // Especie
                             '',                                        // Marca
                             'REF.: DIVERGENCIA DE SEPARAÇÃO DO COLETOR', // Mensagem 1
                             '',                                        // Mensagem 2
                             '',                                        // Mensagem 3
                             '',                                        // Mensagem 4
                             '',                                        // Mensagem 5
                             False,                                     // Indica se Faturado ou nao
                             'AJ',                                      // Tipo de Faturamento
                             LNumDocAJ,                                 // Numero de Faturamento
                             '',                // Empresa dd Faturamento
                             0,                // Data de Faturamento
                             strLoginUsuarioLogado,                     // Vendedor do Faturamento
                             '',                // Condição de Pagamento do Faturamento
                             False,                                     // Devolução Especial
                             0.0,            // Valor do Faturamento
                             0.0,                                       // Valor Parcela 01
                             0.0,                                       // Valor Parcela 02
                             0.0,                                       // Valor Parcela 03
                             0.0,                                       // Valor Parcela 04
                             0.0,                                       // Valor Parcela 05
                             0.0,                                       // Valor Parcela 06
                             0.0,                                       // Valor Parcela 07
                             0.0,                                       // Valor Parcela 08
                             0.0,                                       // Valor Parcela 09
                             0.0,                                       // Valor Parcela 10
                             0.0,                                       // Valor Parcela 11
                             0.0,                                       // Valor Parcela 12
                             LarrDuplic,                                 // Array Duplicatas 24 Parcelas
                             '',                                        // Série
                             'N',                                       // Nota Especial
                             '9999',                                    // Classificação Fiscal 1
                             '',                                        // Classificação Fiscal 2
                             '',                                        // Classificação Fiscal 3
                             '',                                        // Natureza da Operação
                             0.0,                                       // Percentual de Desconto
                             strLoginUsuarioLogado,                     // Codigo do Digitador
                             '',                                        // Codigo da Condição
                             '',                                        // Forma de Pagamento
                             0.0,                                       // Fator para meia nota
                             recServicos,
                             0.0,                                       // Despesa acessoria
                             '',                                        // Origem do Documento (V)enda (D)evolução
                             'N',                                       // Usa controle de entrega
                             '',                                        // Representante
                             0.0,                                       // Aliquota do IRPF (SERVIÇO)
                             0.0,                                       // Valor do IRPF (SERVIÇO + PRODUTO)
                             0.0,                                       // Aliquota do Pis (SERVIÇO)
                             0.0,                                       // Valor do Pis (SERVIÇO + PRODUTO)
                             0.0,                                       // Aliquota do Cofins (SERVIÇO)
                             0.0,                                       // Valor do Cofins (SERVIÇO + PRODUTO)
                             0.0,                                       // Aliquota do CSLL (SERVIÇO)
                             0.0,                                       // Valor do CSLL (SERVIÇO + PRODUTO)
                             0.0,                                       // Valor de IRPF que foi retido
                             0.0,                                       // Valor de PIS que foi retido
                             0.0,                                       // Valor de COFINS que foi retido
                             0.0,                                       // Valor de CSLL que foi retido
                             '',                                        // Notas de Documentos Acumulados
                             0.0,                                       // Aliquota do IRPF (PRODUTOS)
                             0.0,                                       // Aliquota do PIS (PRODUTOS)
                             0.0,                                       // Aliquota do COFINS (PRODUTOS)
                             0.0,                                       // Aliquota do CSLL (PRODUTOS)
                             0.0,                                       // Valor de SERVIÇO que foi retido
                             '',                                        // Notas de documentos acumulados (SERVIÇO)
                             0.0,                                       // Percentual da Seguridade Social
                             0.0,                                       // Valor da Seguridade Social
                             0.0,                                       // Valor do IRPF Retido (Produto)
                             0.0,                                       // Valor do IRPF Devido (Produto)
                             0.0,                                       // Valor do IRPF Retido (Serviço)
                             0.0,                                       // Valor do IRPF Devido (Serviço)
                             0.0,                                       // Valor do PIS Retido (Produto)
                             0.0,                                       // Valor do PIS Devido (Produto)
                             0.0,                                       // Valor do PIS Retido (Serviço)
                             0.0,                                       // Valor do PIS Devido (Serviço)
                             0.0,                                       // Valor do COFINS Retido (Produto)
                             0.0,                                       // Valor do COFINS Devido (Produto)
                             0.0,                                       // Valor do COFINS Retido (Serviço)
                             0.0,                                       // Valor do COFINS Devido (Serviço)
                             0.0,                                       // Valor do CSLL Retido (Produto)
                             0.0,                                       // Valor do CSLL Devido (Produto)
                             0.0,                                       // Valor do CSLL Retido (Serviço)
                             0.0,                                       // Valor do CSLL Devido (Serviço)
                             '',                                        // Ordem de Produção
                             0.0,                                       // Base Orgão Público
                             0.0,                                       // ICMS Orgão Público
                             0,                                         // Número do Conhecimento de Frete
                             '',                                        // Consumidor final
                             'N',                                       // Entrega no Faturamento
                             '',                                        // Cliente de Faturamento
                             '',                                        // Operador da Expedição
                             '',                                        // strSepExp
                             '',                                        // Tabela de Preços utilizada
                             '',                                        // strNum_Pr
                             'N',                                       // Entrega Futura
                             False,                                     // Baixa de Entrega Futura
                             0,                                         // Margem de Lucro
                             0.0,                                       // Base do retido (caso tivesse) com ipi e frete de entrada
                             0.0,                                       // Valor do retido considerando a base acima.
                             'N',                                       // Gerar produção fora da loja
                             '',                                        // strNumReg
                             0,                                         // dtaDtaEntr
                             '',                                        // strClaFi4
                             'N',                                       // AUTO-SERVIÇO
                             '',                                        //Evento
                             '',                                        // AUTINC ENDEREÇO DE ENTREGA
                             '',                                        // Conteúdo do CNFNFE
                             '',                                        // Motivo da Devolução
                             '',
                             True,                                       //Imprimir duplicatas na NFe
                              0,                                         //fltValCre: Double
                              0,                                         //dtadtlBex: TDateTime
                              '',                                        //strEmlCon: String
                              0,                                         //dtaDtESNf: TDateTime
                              0,                                         //tmrHrESNf: TDateTime
                              Nil,                                       //objFinanc: Pointer
                              '',                                        //strDocCon: String         // Conhecimento de Frete
                              '',                                        //strCodObr: String
                              '',                                        //strCodArt: String
                              'N',                                       //strPermut: String         // Permuta para isenção de pagamento de comissão
                              '',                                        //strRetIss: String
                              '',                                        //strOpcDoc: String
                              0,                                         //fltFreSug: Double
                              '',                                        //strNumAde: String
                              0,                                         //fltBasAnt: Double         //BASE DE ICMS ANTECIPADO
                              0,                                         //fltValAnt: Double         //VALOR DE ICMS ANTECIPADO
                              '',                                        //strNaoAtu: String
                              '',                                        //strEntUrg: String
                              '',                                        //strMenExp: String
                              '',                                        //strMenEx2: String
                              '',                                        //strMenEx3: String
                              '',                                        //strMenEx4: String
                              0,                                         //fltDupRec: Double
                              0,                                         //fltValAdt: Double
                              0,                                         //fltDeDVCf: Double
                              '',                                        //strPlaVei: String
                              '',                                        //strKm_Vei: String
                              '',                                        //strCliOri: String
                              '',                                        //strCodMot: String
                              '',                                        //strBetone: String
                              '',                                        //strLacre_: String
                              '',                                        //strTipMps: String
                              '',                                        //strAbatim: String
                              '',                                        //strBrita_: String
                              '',                                        //strConBom: String
                              0,                                         //intFckDia: Integer
                              0,                                         //fltImpPag: Double
                              0,                                         //intPrzMed: integer
                              False,                                     //blnImpPdv: Boolean
                              False,                                     //blnDTEXREP: Boolean
                              '',                                        //strChvNfeDev: String
                              '',                                        //strOpeSol: String
                              False,                                     //blnEst_Dv: Boolean
                              '',                                        //strNumCOODev: String
                              '',                                        //strNumSerDev: String
                              '',                                        //strNumUSUDev: String
                              '',                                        //strTipDocDev: String
                              0,                                         //fltTotDif: Double
                              nil,                                       //objFazenda: Pointer
                              0,                                         //fltFedImp : Double
                              0,                                         //fltEstImp : Double
                              0,                                         //fltMunImp : Double
                              0,                                         //fltTroco_: Double
                              '',                                        //strObsNfeFis: String
                              'N',                                       //strVenPre: String
                              '',                                        //strSeqDocOri: String
                              False,                                     //blnConEqu: Boolean
                              False,                                     //blnDescIncond: Boolean
                              True,                                      //blnGraCTP: Boolean
                              '',                                        //strNumera: String
                             'N',                                        //strEdiPes: String
                               0,                                        //fltTaxEnt: Double
                               0,                                        //fltVrdIcm: Double
                               0,                                        //fltBasVrd: Double
                               0,                                        //intNroBox: Integer
                              '',                                        //strCodEmbarcacao:String
                               0,                                        //fltTotBri
                              '',                                        //strTraRdp
                              '',                                        //strCliCtt
                              '',                                        //strCodMod
                              '',                                        //strNumGui
                              '',                                        //strHisCom
                              '',                                        //strCodPrj
                              '',                                        //strNatCfo
                              '',                                        //strTpOper
                              '',                                        //strCupDes
                             'S',                                        //strNotPau
                               0,                                        //fltCotMoe
                               0,                                        //fltFreMkp
                               0,                                        //fltComMkp
                              '',                                        //strPlaFat
                             False,                                      //blnDevWms
                             False,                                      //blnFullFilmentModoRobo
                               0,                                        //fltFreCot
                               0,                                        //fltFreRat
                             'N',                                        //strEntSim
                              '',                                        //strSeqDmp
                              '',                                        //strEntFutOpc
                               0,                                        //fltTotIpiEntFut
                               0,                                        //fltTotRetEntFut
                               0,                                        //fltTotFcpSTEntFut
                               0,                                        //fltICMDes
                               0,                                        //fltDesPis
                               '',                                       //strOpFaEx
                               '',                                       //strDocAba
                               '',                                       //strEspAba
                               '',                                       //strEmpAba
                               '',                                       //strCliAba
                              False,                                     //blnColeta
                              '',                                        //strNumeroRandomico
                              '',                                        //strNumeroDrawback
                              fCfgSis('FINAJU', varString)
                              );

        {$endregion 'fGravaMovGer'}

        If Result Then
           objAuditoriaSaldo.Adicionar(LAutIncMovGer, 'MOVGER');

        If Result Then
        Begin
          cdsDivergencias.First;
          While Not cdsDivergencias.Eof Do
          Begin
            If (cdsDivergencias.FieldByName('ITE_SELECT').AsString = 'S') Then
            Begin
              If (cdsDivergencias.FieldByName('SIN_AJUSTE').AsFloat <> 0) Then
              Begin
                FillChar(LarrDuplic, SizeOf(LarrDuplic) , #0);
                LCodIte := cdsDivergencias.FieldByName('SIN_CODITE').AsString;
                LLocFis := cdsDivergencias.FieldByName('SIN_LOCFIS').AsString;
                LNumLot := cdsDivergencias.FieldByName('LOT_NUMLOT').AsString;

                LQtdIte := Abs(cdsDivergencias.FieldByName('SIN_AJUSTE').AsFloat);
                LTotIte := Abs(cdsDivergencias.FieldByName('ITE_VALUNI').AsFloat) * LQtdIte;

                LEntSai := IIF(cdsDivergencias.FieldByName('SIN_AJUSTE').AsFloat > 0, 'E', 'S');
                IF LEntSai = 'E' Then
                  LClaFis := '1999'
                Else
                  LClaFis := '5999';

                LCnv_Ml := 1;

                {$region 'Gravação MOVDET'}
                Result := Result And objDllOpeProd.varParam.fGMovDet(LAutTmp,                                                  // Retorna Auto-Incremento por Referencia
                                       LAutIncMovGer,                                                  // Sequencial do Arquivo Geral
                                       LNumDocAJ,                   // Numero Documento
                                       'AJ',                                                  // Espécie
                                       VS_strCodEmp,                                               // Empresa
                                       LCodIte                           ,                         // Cód. Item
                                       strLoginUsuarioLogado,                                      // Vendedor
                                       '',                                                         // Código Diversos
                                       cdsDivergencias.FieldByName('ITE_CODMAR').AsString,                         // Código da Marca
                                       '',                                                         // Fornecedor
                                       LCodCli,                                          // Cliente
                                       VS_Date,                                                    // Data da Entrada
                                       fTime(),                                                    // Hora da Entrada
                                       VS_Date,                                                    // Data do Documento
                                       '01000',                                                    // Condição de Pagamento
                                       'C',                                                        // Tipo: (C)liente / (F) Fornecedor
                                       '',                                                         // Estado do Fornecedor
                                       cdsDivergencias.FieldByName('ITE_DESITE').AsString,                         // Descrição do Item
                                       cdsDivergencias.FieldByName('ITE_REFERE').AsString,                         // Referência do Item
                                       cdsDivergencias.FieldByName('ITE_CODUNI').AsString,                         // Cód. Unidade
                                       cdsDivergencias.FieldByName('ITE_CODFOR').AsString,                         // Fornecedor Item
                                       LQtdIte,                                                  // Quantidade do Item
                                       cdsDivergencias.FieldByName('ITE_VALUNI').AsFloat,   // Valor Unitario
                                       cdsDivergencias.FieldByName('ITE_VALUNI').AsFloat,    // Valor Unitário Original
                                       cdsDivergencias.FieldByName('ITE_VALUNI').AsFloat,   // Valor Unitário Original sem juros
                                       LTotIte,                                                  // Total do Item
                                       LTotIte,                                                  // Valor Contábil do Item
                                       (cdsDivergencias.FieldByName('ITE_PRECUS').AsFloat / LCnv_Ml) * LQtdIte,    // Valor Total de Custo
                                       (cdsDivergencias.FieldByName('ITE_PREMED').AsFloat / LCnv_Ml) * LQtdIte,    // Valor Total Medio
                                       0.0,                                                        // % Desconto do Item
                                       0.0,                                                        // Valor do Frete
                                       0.0,                                                        // Valor do Desconto Especial
                                       '',                                                         // Código do Representante
                                       '',                                                         // Código do Vendedor 2
                                       0.0,                                                        // Percentual de Comissão do Vendedor
                                       0.0,                                                        // Total de Comissão do Vendedor
                                       0.0,                                                        // Total de Comissão do Vendedor 2
                                       LClaFis,                                                  // Classificação Fiscal
                                       '',                                                         // Código Fiscal
                                       0.0,                                                        // Valor IPI
                                       0.0,                                                        // Aliquota IPI
                                       0.0,                                                        // Base IPI
                                       0.0,                                                        // Valor de ICMS
                                       0.0,                                                        // Aliquota de ICMS
                                       0.0,                                                        // Base de ICMS
                                       0.0,                                                        // Valor de Substituição
                                       0.0,                                                        // Aliquota de Substituição
                                       0.0,                                                        // Base de Substituição
                                       0.0,                                                        // Total de Peso
                                       0.0,                                                        // Percentual de Base de ICMS
                                       0.0,                                                        // Percentual de Redução de Base
                                       False,                                                      // Indica se ja esta Faturado
                                       '',           // Tipo de Faturamento
                                       '',         // Numero de Faturamento
                                       '',              // Empresa dd Faturamento
                                       0,               // Data de Faturamento
                                       strLoginUsuarioLogado,                                      // Vendedor do Faturamento
                                       '',                          // Condição de Pagamento do Faturamento
                                       0.0,                             // Valor do Faturamento
                                       'NOR',                                                      // Identificação Produto ( Normal / Outros )
                                       cdsDivergencias.FieldByName('ITE_INCPIS').AsString,                         // Indice se incide Pis
                                       '',                                                         // Série
                                       0.0,                                                        // Valor de Despesa Acessória
                                       'N',                                                        // Nota Especial
                                       '',                                                         // Documento da Devolução
                                       '',                                                         // Espécie da Devolução
                                       '',                                                         // Empresa da Devolução
                                       '',                                                         // Item de Chamada (TINTA DE MAQUINA)
                                       '',                                                         // Item da Tinta (TINTA DE MAQUINA)
                                       '',                                                         // Descrição da Cor (TINTA DE MAQUINA)
                                       '',                                                         // Tipo de Embalagem (TINTA DE MAQUINA)
                                       0.0,                                                        // Quantidade de Embalagem (TINTA DE MAQUINA)
                                       0.0,                                                        // Preço da Embalagem (TINTA DE MAQUINA)
                                       '',                                                         // Tipo de Preço (TINTA DE MAQUINA)
                                       0.0,                                                        // Preço de Venda da Tinta (TINTA DE MAQUINA)
                                       0.0,                                                        // Preço de Compra da Tinta (TINTA DE MAQUINA)
                                       0.0,                                                        // Fator da Tinta (TINTA DE MAQUINA)
                                       '',                                                         // Produto Embalagem (TINTA DE MAQUINA)
                                       strLoginUsuarioLogado,                                      // Código do Digitador
                                       '',                                                         // Codigo da Condição
                                       '',                                                         // Forma de Pagamento
                                       '',                                                         // Item da Embalagem
                                       '',                                                         // Grupo do Item da Embalagem
                                       0,                                                          // Quarto da Lazzumiz
                                       'N',                                                        // É item em promoção?
                                       '',                                                         // Tipo de Tinta
                                       0.0,                                                        // Quantidade de Pulsos
                                       '',                                                         // Número do pedido de compras
                                       '',                                                         // Origem do documento
                                       '',                                                         // Pedido de Venda - Número
                                       '',                                                         // Pedido de Venda - Espécie
                                       '',                                                         // Pedido de Venda - Empresa
                                       0,                                                          // Pedido de Venda - Sequencial
                                       '',                                                         // Ordem de Produção
                                       '',                                                         // Descrição para Nota Fiscal Especial
                                       '',
                                       0,
                                       0,
                                       0.0,                                                        // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                                       '',
                                       '',
                                       False,
                                       False,
                                       '',                                                           //  Especie da Entrega Fututa
                                       '',                                                           //  Documento da Entrega Fututa
                                       '',
                                       '',                                                           //  Empresa da Entrega Fututa
                                       '',
                                       '',
                                       '',
                                       '',
                                       0.0,
                                       '',
                                       0.0,
                                       0.0,
                                       0,
                                       'N',
                                       '',
                                       0,
                                       (cdsDivergencias.FieldByName('ITE_PRECUS').AsFloat / LCnv_Ml) * LQtdIte, //fltTotCu2
                                       0,
                                       0,
                                       '',
                                       LNumLot,
                                       '',
                                       0,
                                       0,
                                       0,
                                       (cdsDivergencias.FieldByName('ITE_PREULT').AsFloat / LCnv_Ml) * LQtdIte, //fltTotUlt
                                       (cdsDivergencias.FieldByName('ITE_IMPULT').AsFloat / LCnv_Ml) * LQtdIte, //fltImpUlt
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       0,
                                       '',
                                       0,
                                       0,
                                       0,
                                       '',
                                       '',
                                       '',
                                       0,
                                       0,
                                       0,
                                       0);
                {$endregion 'Gravação MOVDET'}

                If Result Then
                  Result := fGravaLogAjusteSparacao(
                                          VS_Date + fTime(),
                                          LCodIte,
                                          LLocFis,
                                          LNumLot,
                                          cdsDivergencias.FieldByName('SIN_QTDSEP').AsFloat,
                                          cdsDivergencias.FieldByName('SIN_OPESEP').AsString,
                                          strLoginUsuarioLogado,
                                          cdsDivergencias.FieldByName('SIN_DTACAD').AsDateTime,
                                          cdsDivergencias.FieldByName('SIN_SALINF').AsFloat,
                                          cdsDivergencias.FieldByName('SIN_SALSIS').AsFloat,
                                          cdsDivergencias.FieldByName('SIN_AJUSTE').AsFloat,
                                          LAutTmp,
                                          cdsDivergencias.FieldByName('AUTOINCREM').AsString);

                If Not Result Then
                  Break;

                If LUsaMaisDeUmaLocalizacaoFisicaPorLote And (Not fEmptyStr(LLocFis)) Then
                   objDllOpeProd.varParam.fGDetLoc(LAutTmp,
                                        LCodIte,
                                        VS_strCodEmp,
                                        LNumLot,
                                        LLocFis,
                                        '',
                                        LQtdIte);

                Result := fAtualizaEstoqueCadIte(LCodIte,
                                                 LEntSai,
                                                 LQtdIte,
                                                 0.0,
                                                 LNumLot, False);

                If LUsaMaisDeUmaLocalizacaoFisicaPorLote And (Not fEmptyStr(LLocFis)) Then
                Begin
                   objDllOpeProd.varParam.pAtuEstoqueLoc(LEntSai,
                                                      LCodIte,
                                                      VS_strCodEmp,
                                                      LNumLot,
                                                      LLocFis,
                                                      LQtdIte);
                End;
              End;

              If (cdsDivergencias.FieldByName('SIN_AJUSTE').AsFloat <> 0) Then
                pGravaStatusSeparacao(cdsDivergencias.FieldByName('AUTOINCREM').AsString, tssRealizado);

              pgbProgresso.Position := pgbProgresso.Position + 1;
            End;

            LAutTmp := fNextAutoIncrem(LAutTmp);

            cdsDivergencias.Next;
          End;
        End;
      End;

      If Result Then
      Begin
        If (LQtdAlt > 0) And (Not objAuditoriaSaldo.fValidouTodas(LCodErrosAuditoria)) Then
        Begin
          Result := False;
          fRollBack;
          pMostraErrosAuditoria(LCodErrosAuditoria);
        End;

        cdsDivergencias.Filtered := False;
        cdsDivergencias.Filter := 'ITE_SELECT = ' + QuotedStr('S') + ' AND SIN_AJUSTE = 0';
        cdsDivergencias.Filtered := True;
        pgbProgresso.Properties.Max := cdsDivergencias.RecordCount -1;
        pgbProgresso.Position := 0;
        frmGravando.lblGravando.Caption := 'Concluíndo registros sem ajustes';
        cdsDivergencias.First;
        While Not cdsDivergencias.Eof Do
        Begin
          pGravaStatusSeparacao(cdsDivergencias.FieldByName('AUTOINCREM').AsString, tssConcluido);
          cdsDivergencias.Next;
          pgbProgresso.Position := cdsDivergencias.RecNo;
          Application.ProcessMessages;
        End;
      End;

      If Result Then
        fCommit
      Else
        fRollBack;

      If Result And (LDocsGerados <> '') Then
        pMensagemOk('Documento(s) de Ajuste Gerado(s)'  + #$A#$D + LDocsGerados)
      Else
        If Result And (fEmptyStr(LDocsGerados)) Then
          pMensagemOk('Documento(s) concluídos(s) sem ajustes'  + #$A#$D + LDocsGerados);

    Except
      On e: Exception Do
      Begin
        fRollback;
        pMensagensErro(e.message, '[TfrmDivergenciasSeparacaoColetor.pAjustarEstoque]');
      End;
    End;
  Finally
    cdsDivergencias.Filtered := False;
    cdsDivergencias.Filter := '';
    cdsDivergencias.EnableControls;
  End;
end;

procedure TfrmDivergenciasSeparacaoColetor.pGravaStatusSeparacao(AAutIncSep: String; AStatusSeparacao: TStatusSeparacao);
Var
  LStatus: String;
  LqryUpd: TUniQuery;
begin

  Case AStatusSeparacao Of
    tssConcluido: LStatus := 'C';
    tssRealizado: LStatus := 'R';
  End;

  LqryUpd := fCriaQuery();
  Try
    LqryUpd.SQL.Clear;
    LqryUpd.SQL.Add(' UPDATE SEPINV SET ');
    LqryUpd.SQL.Add('    SIN_STAAJU = ' + QuotedStr(LStatus));
    LqryUpd.SQL.Add(' WHERE AUTOINCREM = ' + QuotedStr(AAutIncSep));
    Try
      LqryUpd.ExecSql;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmDivergenciasSeparacaoColetor.pGravaStatusSeparacao]');
    End;
  Finally
    FreeAndNil(LqryUpd);
  End;


end;

function TfrmDivergenciasSeparacaoColetor.fGravar(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Try
    Result := pAjustarEstoque(pgbProgresso);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmDivergenciasSeparacaoColetor.fGravar]');
    End;
  End;
End;

function TfrmDivergenciasSeparacaoColetor.fCalcTotais: Double;
begin
  Result := 0;

  cdsDivergencias.DisableControls;
  cdsDivergencias.First;
  While (Not cdsDivergencias.Eof) Do
  Begin
    If (cdsDivergencias.FieldByName('ITE_SELECT').AsString = 'S') Then
      Result := Result + cdsDivergencias.FieldByName('SIN_AJUSTE').AsFloat * cdsDivergencias.FieldByName('ITE_VALUNI').AsFloat;
    cdsDivergencias.Next;
  End;
  cdsDivergencias.EnableControls;

  If Result <> 0 Then
   Result := - Result;
end;

function TfrmDivergenciasSeparacaoColetor.fGeraExcel(cxProgress: TcxProgressBar): Boolean;
Var
  XLSWorkbook: TXLSWorkbook;
  XLSWorksheet: TXLSWorksheet;
  XLSRow: TXLSRow;
  ArrColunaExcel: TArrCampos;
  col: integer;
  XLSTitleStyle: TXLSCellStyle;

  Procedure pAddColuna(AcxGridDBColumn: TcxGridDBBandedColumn);
  Begin
    SetLength(ArrColunaExcel, succ(high(ArrColunaExcel))+ 1);
    ArrColunaExcel[high(ArrColunaExcel)].Title := AcxGridDBColumn.Caption;
    ArrColunaExcel[high(ArrColunaExcel)].FieldName := AcxGridDBColumn.DataBinding.FieldName;
    ArrColunaExcel[high(ArrColunaExcel)].DisplayFormat := '';
  End;

  Procedure pPopulaArrColunaExcel;
  Var
    i: integer;
  Begin
     For i := 0 To cxgItensView.ColumnCount -1 Do
     Begin
       If TcxGridDBBandedColumn(cxgItensView.Columns[i]).Visible Then
         pAddColuna(cxgItensView.Columns[i]);
     End;
  End;
begin
  Result := True;
  cdsDivergencias.DisableControls;
  Try
    cdsDivergencias.First;
    XLSWorkbook := tXLSWorkbook.Create;
    XLSWorksheet := XLSWorkbook.AddWorksheet('DivergenciasSeparacao');
    cxProgress.Properties.Max := cdsDivergencias.RecordCount;

    Try
      pPopulaArrColunaExcel;
      XLSTitleStyle := XLSWorkbook.CreateStyle.SetFontBold(True)
                                              .SetFontColor(clBlack)
                                              .SetBgColor(clGray);

      XLSRow := XLSWorksheet.AddRow;
      XLSRow.AddCell('Divergências Separação - Coletor', ctString).SetStyle(XLSTitleStyle).SetMergeAcross(High(ArrColunaExcel));

      XLSRow := XLSWorksheet.AddRow;
      For col := 0 To High(ArrColunaExcel) Do
        XLSRow.AddCell(ArrColunaExcel[col].Title, ctString).SetStyle(XLSTitleStyle);

      XLSWorksheet.SetColumnWidth(0, 110); //Data
      XLSWorksheet.SetColumnWidth(1, 60);  //Operador
      XLSWorksheet.SetColumnWidth(2, 300); //Item
      XLSWorksheet.SetColumnWidth(3, 120); //Localização
      XLSWorksheet.SetColumnWidth(4, 120); //Lote
      XLSWorksheet.SetColumnWidth(5, 90);  //Qtd. Separação

      While Not cdsDivergencias.EoF Do
      Begin
        XLSRow := XLSWorksheet.AddRow;
        For col := 0 To High(ArrColunaExcel) Do
        Begin
          XLSRow.AddCell(StringReplace(cdsDivergencias.FieldByName(ArrColunaExcel[col].FieldName).AsString, ';', '', [rfReplaceAll]));
        end;

        cdsDivergencias.Next;
        cxProgress.Position := cdsDivergencias.RecNo;
        Application.ProcessMessages;
      end;

      frmGravando.lblGravando.Caption := 'Salvando Arquivo';
      Application.ProcessMessages;
      XLSWorkbook.SaveToFile(strFileName, True);
      pMensagemOk('Arquivo salvo com sucesso! ' + strFileName);
    finally
      FreeAndNIl(XLSWorkbook);
    End;
  Finally
    cdsDivergencias.EnableControls;
  End;
end;

procedure TfrmDivergenciasSeparacaoColetor.pExportaParaCSV;
Var
  frmGerandoExcel: TfrmGravando;
  Result: Boolean;
Begin
  Try
    Try
      Result := False;

      Application.ProcessMessages;

      cdsDivergencias.DisableControls;

      strFileName := '';
        SaveDialog.Filter := 'Arquivos CSV|*.csv';
      SaveDialog.FileName := 'DivergenciasSeparacaoColetor.csv';

      If SaveDialog.Execute Then
      Begin
        If fEmptyStr(SaveDialog.FileName) Then
          Exit;

        strFileName := SaveDialog.FileName;
        pCriarFormularios(TfrmGravando, frmGerandoExcel);
        Try

          With frmGerandoExcel Do
          Begin
            fExecutarAcao := fGeraArquivoCSVAux;
            lblGravando.Caption := 'Aguarde, Gerando aquivo...';
            ShowModal;
            Result := blnConfirma;
          End;
        Finally
          FreeAndNil(frmGerandoExcel);
        End;
      End;

      If Result Then
        pMensagemOk('Arquivo salvo com sucesso! ' + strFileName);

      cdsDivergencias.First;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmDivergenciasSeparacaoColetor.pExportaParaExcel]');
        If Assigned(frmGerandoExcel) Then
        Begin
          frmGerandoExcel.Close;
          FreeAndNil(frmGerandoExcel);
        End;
      End;
    End;
  Finally
    cdsDivergencias.EnableControls;
  End;

End;

function TfrmDivergenciasSeparacaoColetor.fGeraArquivoCSVAux(pgbProgresso
  : TcxProgressBar): Boolean;
var
  aFile: TStringList;
  campo: TCampo;
  strLinha: String;
  arrCampos: TArrCampos;
  i: Integer;
begin

  For i := 0 To cxgItensView.ColumnCount -1 Do
  Begin
    If TcxGridDBBandedColumn(cxgItensView.Columns[i]).Visible Then
    Begin
      SetLength(arrCampos, succ(high(arrCampos))+ 1);
      arrCampos[high(arrCampos)].Title := TcxGridDBBandedColumn(cxgItensView.Columns[i]).Caption;
      arrCampos[high(arrCampos)].FieldName := TcxGridDBBandedColumn(cxgItensView.Columns[i]).DataBinding.FieldName;
    End;
  End;

  aFile := TStringList.Create;
  Result := True;
  Try
    strFileName := ChangeFileExt(strFileName, '.csv');
    DeleteFile(strFileName);
    dtsDivergencias.DataSet.First;
    strLinha := '';
    for campo in arrCampos do
        strLinha := strLinha + campo.Title + ';';

    aFile.Add(strLinha);
    pgbProgresso.Properties.Max := dtsDivergencias.DataSet.RecordCount - 1;
    while not dtsDivergencias.DataSet.Eof do
    Begin
      strLinha := '';
      for campo in arrCampos do
        strLinha := strLinha + fRemoveQuebra
          (dtsDivergencias.DataSet.FieldByName(campo.FieldName).AsString) + ';';
      aFile.Add(strLinha);
      Application.ProcessMessages;
      pgbProgresso.Position := dtsDivergencias.DataSet.recNo;

      dtsDivergencias.DataSet.Next;
    End;
    aFile.SaveToFile(strFileName);
  Finally
    FreeAndNil(aFile);
  End;

end;

function TfrmDivergenciasSeparacaoColetor.fRemoveQuebra(strInput: String): String;
Begin
  strInput := StringReplace(strInput, #$D#$A, ' ', [rfReplaceAll]);
  strInput := StringReplace(strInput, #$D#$A, ' ', [rfReplaceAll]);
  strInput := StringReplace(strInput, #$A, ' ', [rfReplaceAll]);
  strInput := StringReplace(strInput, #13#10, ' ', [rfReplaceAll]);
  strInput := StringReplace(strInput, #13, ' ', [rfReplaceAll]);
  Result := strInput
End;

procedure TfrmDivergenciasSeparacaoColetor.pSelecionaItem(pTag: Integer; blnTodos: Boolean = False);
  Var
    BookMark: TBookMark;
begin
  BookMark := cdsDivergencias.GetBookmark;
  cdsDivergencias.DisableControls;
  Try
    With cdsDivergencias Do
    Begin
      If Not blnTodos Then
      Begin
        cdsDivergencias.Edit;
        If cdsDivergencias.FieldByName('ITE_SELECT').AsString = 'S' Then
          cdsDivergencias.FieldByName('ITE_SELECT').AsString := 'N'
        Else
          cdsDivergencias.FieldByName('ITE_SELECT').AsString := 'S';
        cdsDivergencias.Post;
      End
      Else
      Begin
        cdsDivergencias.First;
        While Not cdsDivergencias.Eof Do
        Begin
          cdsDivergencias.Edit;
          If pTag = 1 Then
            cdsDivergencias.FieldByName('ITE_SELECT').AsString := 'S'
          Else If pTag = 0 Then
            cdsDivergencias.FieldByName('ITE_SELECT').AsString := 'N';
          cdsDivergencias.Post;

          cdsDivergencias.Next;
        End;
      End;
    End;
  Finally
    if Assigned(BookMark) then
    begin
      if cdsDivergencias.BookmarkValid(BookMark) then
        cdsDivergencias.GotoBookmark(BookMark);
      cdsDivergencias.FreeBookmark(BookMark);
    end;
    cdsDivergencias.EnableControls;
  End;
end;

function TfrmDivergenciasSeparacaoColetor.fExisteNumLot(ANumLot: String): Boolean;
Var
  qryCadLot: TUniQuery;
begin
  Result := True;
  qryCadLot := fCriaQuery();
  Try
    qryCadLot.Close;
    qryCadLot.SQL.Clear;
    qryCadLot.SQL.Add('SELECT COUNT(1) AS QTDE FROM CADLOT ');
    qryCadLot.SQL.Add('WHERE LOT_NUMLOT = :NUMLOT ');
    qryCadLot.ParamByName('NUMLOT').AsString := ANumLot;

    Try
      qryCadLot.Open;
      Result := qryCadLot.FieldByName('QTDE').AsInteger > 0;
      qryCadLot.Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmDivergenciasSeparacaoColetor.fExisteNumLot]');
      End;
    End;
  Finally
    FreeAndNil(qryCadLot);
  End;
end;

function TfrmDivergenciasSeparacaoColetor.fGravaLogAjusteSparacao(
  ADtaAju: TDateTime;
  ACodIte: string;
  ALocFis: string;
  ANumLot: string;
  AQtdSep: Double;
  AOpeSep: string;
  ACodOpe: string;
  ADtaCad: TDateTime;
  ASalInf: Double;
  ASalSis: Double;
  AAjuste: Double;
  ASeqDet: string;
  ASeqSep: string): Boolean;
Var
  LAutIncLog: String;
  qrySepLog: TUniQuery;
begin
  Result := True;
  qrySepLog := fCriaQuery();
  Try
    qrySepLog.Close;
    qrySepLog.SQL.Clear;
    qrySepLog.SQL.Add(' INSERT INTO SEPLOG ( ');
    qrySepLog.SQL.Add('     AUTOINCREM, ');
    qrySepLog.SQL.Add('     SIL_DTAAJU, ');
    qrySepLog.SQL.Add('     SIL_CODITE, ');
    qrySepLog.SQL.Add('     SIL_LOCFIS, ');
    qrySepLog.SQL.Add('     SIL_NUMLOT, ');
    qrySepLog.SQL.Add('     SIL_QTDSEP, ');
    qrySepLog.SQL.Add('     SIL_OPESEP, ');
    qrySepLog.SQL.Add('     SIL_CODOPE, ');
    qrySepLog.SQL.Add('     SIL_DTACAD, ');
    qrySepLog.SQL.Add('     SIL_SALINF, ');
    qrySepLog.SQL.Add('     SIL_SALSIS, ');
    qrySepLog.SQL.Add('     SIL_AJUSTE, ');
    qrySepLog.SQL.Add('     SIL_SEQDET, ');
    qrySepLog.SQL.Add('     SIL_SEQSEP) ');
    qrySepLog.SQL.Add(' VALUES (     ');
    qrySepLog.SQL.Add('     :AUTINC, ');
    qrySepLog.SQL.Add('     :DTAAJU, ');
    qrySepLog.SQL.Add('     :CODITE, ');
    qrySepLog.SQL.Add('     :LOCFIS, ');
    qrySepLog.SQL.Add('     :NUMLOT, ');
    qrySepLog.SQL.Add('     :QTDSEP, ');
    qrySepLog.SQL.Add('     :OPESEP, ');
    qrySepLog.SQL.Add('     :CODOPE, ');
    qrySepLog.SQL.Add('     :DTACAD, ');
    qrySepLog.SQL.Add('     :SALINF, ');
    qrySepLog.SQL.Add('     :SALSIS, ');
    qrySepLog.SQL.Add('     :AJUSTE, ');
    qrySepLog.SQL.Add('     :SEQDET, ');
    qrySepLog.SQL.Add('     :SEQSEP) ');

    LAutIncLog := fRetAutoIncrem('SEPLOG',VS_strCodEmp);

    qrySepLog.ParamByName('AUTINC').AsString   := LAutIncLog;
    qrySepLog.ParamByName('DTAAJU').AsDateTime := ADtaAju;
    qrySepLog.ParamByName('CODITE').AsString   := ACodIte;
    qrySepLog.ParamByName('LOCFIS').AsString   := ALocFis;
    qrySepLog.ParamByName('NUMLOT').AsString   := ANumLot;
    qrySepLog.ParamByName('QTDSEP').AsFloat    := AQtdSep;
    qrySepLog.ParamByName('OPESEP').AsString   := AOpeSep;
    qrySepLog.ParamByName('CODOPE').AsString   := ACodOpe;
    qrySepLog.ParamByName('DTACAD').AsDateTime := ADtaCad;
    qrySepLog.ParamByName('SALINF').AsFloat    := ASalInf;
    qrySepLog.ParamByName('SALSIS').AsFloat    := ASalSis;
    qrySepLog.ParamByName('AJUSTE').AsFloat    := AAjuste;
    qrySepLog.ParamByName('SEQDET').AsString   := ASeqDet;
    qrySepLog.ParamByName('SEQSEP').AsString   := ASeqSep;

    Try
      qrySepLog.ExecSQL;
      Result := True
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmDivergenciasSeparacaoColetor.fGravaLogAjusteSparacao]');
      End;
    End;
  Finally
    FreeAndNil(qrySepLog);
  End;
end;

end.
