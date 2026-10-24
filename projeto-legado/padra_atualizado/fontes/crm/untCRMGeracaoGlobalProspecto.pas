unit untCRMGeracaoGlobalProspecto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, ComboBoxFocus, EditFocus, Vcl.Mask, MaskEditFocus, untGravando,
  untZClient, cxProgressBar, StrUtils, Data.DB, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGridCitel, cxClasses,
  cxGridLevel, cxGrid, System.ImageList, Vcl.ImgList, cxTextEdit, DateUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, untCadMovOcorrencias;

type
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);
  TcxPainterAccess = class(TcxGridTableDataCellPainter);

  TfrmCRMGeracaoGlobalProspecto = class(TfrmPai)
    Notebook: TNotebook;
    pnlFiltros: TPanel;
    pnlDados: TPanel;
    Shape1: TShape;
    Label2: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    Label4: TLabel;
    edtCodAti: TEditFocus;
    edtNomAti: TEditFocus;
    Label12: TLabel;
    edtVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    Label9: TLabel;
    mskDtaIniCli: TMaskEditFocus;
    Label10: TLabel;
    mskDtaFinCli: TMaskEditFocus;
    Label11: TLabel;
    Bevel1: TBevel;
    edtEstado: TEditFocus;
    Label17: TLabel;
    Label18: TLabel;
    cmbStatus: TComboBoxFocus;
    btnConfirma: TBitBtnLocked;
    cxDadosLevel1: TcxGridLevel;
    cxDadosTableView: TcxGridDBTableViewCitel;
    cxDados: TcxGridCitel;
    cxDadosTableViewColumn1: TcxGridDBColumn;
    cxDadosTableViewColumn2: TcxGridDBColumn;
    cxDadosTableViewColumn3: TcxGridDBColumn;
    cxDadosTableViewColumn4: TcxGridDBColumn;
    cxDadosTableViewColumn5: TcxGridDBColumn;
    cxDadosTableViewColumn7: TcxGridDBColumn;
    cxDadosTableViewColumnMARCA: TcxGridDBColumn;
    imgLista: TImageList;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    lblInfEnter: TLabel;
    btnCarregarDados: TBitBtnLocked;
    Label209: TLabel;
    Label248: TLabel;
    Label249: TLabel;
    Label250: TLabel;
    edtCrmFre: TEditFocus;
    edtDesFre: TEditFocus;
    edtCrmPor: TEditFocus;
    edtDesCrmPor: TEditFocus;
    edtCrmFai: TEditFocus;
    edtDesFai: TEditFocus;
    edtCrmFor: TEditFocus;
    edtDesFor: TEditFocus;
    lblCategoria: TLabel;
    edtDesCat: TEditFocus;
    edtCodCat: TEditFocus;
    lblRegiao: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtVendedorExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCarregarDadosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxDadosTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnDesmTodosClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure cxDadosTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCrmFreKeyPress(Sender: TObject; var Key: Char);
    procedure edtCrmFreExit(Sender: TObject);
    procedure edtCrmPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCrmPorExit(Sender: TObject);
    procedure edtCrmFaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCrmFaiExit(Sender: TObject);
    procedure edtCrmForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCrmForExit(Sender: TObject);
    procedure edtCodCatKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCatExit(Sender: TObject);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
  private
    frmCadMovOcorrencias : TfrmCadMovOcorrencias;
    frmGrav : TfrmGravando;
    lstMarca: TStringList;

    arrCrmFre,
    arrCrmPor,
    arrCrmFai,
    arrCrmFor,
    arrCodAti,
    arrCodVen,
    arrCodCid,
    arrCodCat,
    arrCodReg : TConsultasArray;

    strCrmFre,
    strCrmPor,
    strCrmFai,
    strCrmFor,
    strCodAti,
    strCodVen,
    strCodCid,
    strCodCat,
    strCodReg : String;

    cdsDados : TZClient;

    function fGetSQL : String;
    function fAbreDados: Boolean;
    function fAbreDadosProgresso(cxProgress : TcxProgressBar) : Boolean;

    function fMarcarTodosProgress(cxProgress : TcxProgressBar) : Boolean;
    procedure pMarcarTodos;
    procedure pReset;
    function fInsereOcorrencias(cxProgress: TcxProgressBar): Boolean;
  public
  Protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean): Boolean;Override;
  end;

var
  frmCRMGeracaoGlobalProspecto: TfrmCRMGeracaoGlobalProspecto;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesConsulta, untFuncoesSimples,
  untAtualizaOcorrenciasCRM, untFuncoesCRM;


procedure TfrmCRMGeracaoGlobalProspecto.btnCarregarDadosClick(Sender: TObject);
begin
  inherited;
  if fAbreDados Then
  Begin
    pMarcarTodos;
    Self.WindowState     := wsMaximized;
    Notebook.PageIndex   := 1;
    btnCarregarDados.Visible := False;
    btnConfirma.Visible  := True;
    btnMarcarTodos.Visible := True;
    btnDesmTodos.Visible   := True;
    lblInfEnter.Visible    := True;
  End
  Else
  Begin
    fMensagem('', 'Sem dados para exibir!', ['&OK']);
    SelectFirst;
  End;
end;

procedure TfrmCRMGeracaoGlobalProspecto.btnConfirmaClick(Sender: TObject);
Begin
  inherited;
  Try
    pCriarFormularios(TfrmCadMovOcorrencias,frmCadMovOcorrencias);
    frmCadMovOcorrencias.strCodCli := '00000000';
    frmCadMovOcorrencias.edtDesCodCli.Text := 'Geração global de ocorrência';
    frmCadMovOcorrencias.strCodEmp := VS_strCodEmp;
    frmCadMovOcorrencias.strOperac := 'Coleta';
    frmCadMovOcorrencias.strTip_Fc := 'P';
    If frmCadMovOcorrencias.ShowModal = MrOK Then
    Begin

      pCriarFormularios(TfrmGravando, frmGrav );
      frmGrav.fExecutarAcao := fInsereOcorrencias;
      frmGrav.lblGravando.Caption := 'Gravando ocorrências...';
      frmGrav.ShowModal;
      pFreeAndNil(frmGrav);

      frmCadMovOcorrencias.qryTabelaProp.Cancel;
    End;

  Finally
    FreeAndNil(frmCadMovOcorrencias);
  End;

  pReset;

end;

function TfrmCRMGeracaoGlobalProspecto.fInsereOcorrencias(cxProgress : TcxProgressBar):Boolean;
  Var
    objAtuOcoCrm: TAtuOcoCrm;
    intIndex    : Integer;
Begin
  Result := True;
  fStartTransaction;
  Try
    Try
      cxProgress.Properties.Max := lstMarca.Count;

      objAtuOcoCrm := TAtuOcoCrm.Create(Self);

      For intIndex := 0 To lstMarca.Count - 1 Do
      Begin
        If Not Result Then
          Break;

        objAtuOcoCrm.strCodCli := lstMarca[intIndex];
        With frmCadMovOcorrencias Do
        Begin
          objAtuOcoCrm.strNomFrm := Self.Name;
          objAtuOcoCrm.strTip_Fc := 'P';
          objAtuOcoCrm.strCodOco := qryTabelaProp.FieldByName('OCO_CODOCO').AsString;
          objAtuOcoCrm.strDtaInc := qryTabelaProp.FieldByName('OCO_DTAINC').AsDateTime;
          objAtuOcoCrm.strHorInc := qryTabelaProp.FieldByName('OCO_HORINC').AsDateTime;
          objAtuOcoCrm.strDtaAge := qryTabelaProp.FieldByName('OCO_DTAAGE').AsDateTime;
          objAtuOcoCrm.strHorAge := qryTabelaProp.FieldByName('OCO_HORAGE').AsDateTime;
          objAtuOcoCrm.strDtaCon := qryTabelaProp.FieldByName('OCO_DTACON').AsDateTime;
          objAtuOcoCrm.strHorCon := qryTabelaProp.FieldByName('OCO_HORCON').AsDateTime;
          objAtuOcoCrm.strOpeHis := qryTabelaProp.FieldByName('OCO_OPEOCO').AsString;
          objAtuOcoCrm.strCodOpe := qryTabelaProp.FieldByName('OCO_CODOPE').AsString;
          objAtuOcoCrm.strCodSit := qryTabelaProp.FieldByName('OCO_CODSIT').AsString;
          if not blnOpeCadCli Then
          Begin
            objAtuOcoCrm.strDescri := qryTabelaProp.FieldByName('OCO_DESCRI').AsString + '<<csq>><<csq>>' +
                                      'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                                      DateToStr(qryTabelaProp.FieldByName('OCO_DTAINC').AsDateTime) + ' ' +
                                      TimeToStr(qryTabelaProp.FieldByName('OCO_HORINC').AsDateTime)  + ' - ' +
                                      qryTabelaProp.FieldByName('OCO_CODOPE').AsString + ' - ' +
                                      fRetNomeOperador(qryTabelaProp.FieldByName('OCO_CODOPE').AsString);
          End
          Else
          Begin
            objAtuOcoCrm.strCodOpe := fCampoTabela('PRO_CODPRO', 'PROSPE', ['PRO_CODPRO'], [objAtuOcoCrm.strCodCli] );
            objAtuOcoCrm.strDescri := fGeraTextoHistorico(qryTabelaProp.FieldByName('OCO_DTAINC').AsDateTime,
                                                                                qryTabelaProp.FieldByName('OCO_HORINC').AsDateTime,
                                                                                fRetNomeOperador(objAtuOcoCrm.strCodOpe),
                                                                                qryTabelaProp.FieldByName('OCO_DESCRI').AsString);
          End;

          objAtuOcoCrm.strCodEmp := qryTabelaProp.FieldByName('OCO_CODEMP').AsString;
          objAtuOcoCrm.strCodCoc := qryTabelaProp.FieldByName('OCO_CODCOC').AsString;
          objAtuOcoCrm.strCodToc := qryTabelaProp.FieldByName('OCO_CODTOC').AsString;
          objAtuOcoCrm.strCodEmp := VS_strCodEmp;
          objAtuOcoCrm.pInsereNovaOcorrencia;
          objAtuOcoCrm.pInsereHistoricoOcorrencia;
        End;

        cxProgress.Position := cxProgress.Position + 1;

        Application.ProcessMessages;

      End;

    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(e.message, 'TfrmCRMGeracaoGlobalProspecto.fInsereOcorrencias');
      End;
    End;
  Finally
    If Assigned(objAtuOcoCrm) Then
      FreeAndNil(objAtuOcoCrm);

    If Result Then
      fCommit
    Else
     fRollback;

  End;
End;

procedure TfrmCRMGeracaoGlobalProspecto.btnDesmTodosClick(Sender: TObject);
begin
  inherited;
  If not btnDesmTodos.Visible Then Exit;

  lstMarca.Clear;
  cxDadosTableView.Site.Repaint;
end;

procedure TfrmCRMGeracaoGlobalProspecto.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  If not btnMarcarTodos.Visible Then Exit;

  pMarcarTodos;
end;

procedure TfrmCRMGeracaoGlobalProspecto.cxDadosTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strCodCli : String;
    APainter: TcxPainterAccess;
begin
  If not (AViewInfo.EditViewInfo is TcxCustomTextEditViewInfo) Then
      Exit;

  If AViewInfo.Item.Index <> cxDadosTableViewColumnMARCA.Index Then
    Exit;

  If AViewInfo.GridRecord.Index < 0 Then
    Exit;

  strCodCli := VarAsType( IIF(cxDadosTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[ cxDadosTableViewColumnMARCA.Index] = null,0,cxDadosTableView.ViewData.Records[AViewInfo.GridRecord.Index].Values[ cxDadosTableViewColumnMARCA.Index]), varString );

  APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
  With APainter do
  Begin
    Try
      DrawBorders;
      With AViewInfo.ClientBounds Do
      Begin

        If lstMarca.IndexOf(strCodCli) >= 0 Then
          imgLista.Draw(ACanvas.Canvas, Left + 1, Top + 1, 1)
        Else
          imgLista.Draw(ACanvas.Canvas, Left + 1, Top + 1, 0);

      End
    Finally
      Free;
    End;
  End;
  ADone := True;

end;

procedure TfrmCRMGeracaoGlobalProspecto.cxDadosTableViewKeyPress(Sender: TObject;
  var Key: Char);
  Var
    intIndex : Integer;
begin
  inherited;
  If Key = #13 Then
  Begin
    intIndex := lstMarca.IndexOf(cdsDados.FieldByName('PRO_CODPRO').AsString);

    If intIndex < 0 Then
      lstMarca.Add( cdsDados.FieldByName('PRO_CODPRO').AsString )
    Else
      lstMarca.Delete(intIndex);

    cxDadosTableView.Site.Repaint;
  End;
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCodCatExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCat, edtDesCat, arrCodCat, Nil, fRetDesCrmCat, 'da Categoria');
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCodCatKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqCategoriaCRM(Self, edtCodCat, edtDesCat, nil, Key, arrCodCat, False) then
  Begin
    If fValidaCampos(edtCodCat, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtNomAti, arrCodAti, Nil, fRetNomAtividade, 'da atividade');
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtNomAti, Nil, Key, arrCodAti, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCodCid, fRetNomCidadeSemOpc, Nil, 'da cidade');
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCodCid, False) Then
	Begin
		fValidaCampos(edtCodCid, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCodRegExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodReg, edtDesReg, arrCodReg, Nil, fRetNomRegiao, 'da Região');
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrCodReg, False) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCrmFaiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCrmFai, edtDesFai, arrCrmFai, fRetDesCrmFai, Nil, 'da Faixa de Faturamento Estimado');
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCrmFaiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFaixaFaturamentoCRM(Self, edtCrmFai, edtDesFai, Nil, Key, arrCrmFai, False) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCrmForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCrmFor, edtDesFor, arrCrmFor, fRetDesCrmFor, Nil, 'do Fornecedor Atual');
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCrmForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqFornecedorAtualCRM(Self, edtCrmFor, edtDesFor, nil, Key, arrCrmFor, False) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCrmFreExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCrmFre, edtDesFre, arrCrmFre, fRetDesCrmFre, Nil, 'da Frequência');
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCrmFreKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqFrequenciaCRM(Self, edtCrmFre, edtDesFre, nil, Key, arrCrmFre, False) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCrmPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCrmPor, edtDesCrmPor, arrCrmPor, fRetDesCrmPor, Nil, 'do Porte');
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtCrmPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqPorteCRM(Self, edtCrmPor, edtDesCrmPor, nil, Key, arrCrmPor, False) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCRMGeracaoGlobalProspecto.edtVendedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtVendedor, edtDesVendedor, arrCodVen, fRetNomVendRep, Nil, 'do vendedor');
end;

procedure TfrmCRMGeracaoGlobalProspecto.edtVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqOperador(Self, edtVendedor, edtDesVendedor, nil, Key, arrCodVen, False) then
  Begin
    If fValidaCampos(edtVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCRMGeracaoGlobalProspecto.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT CONCAT(C.PRO_CODPRO," - ", PRO_NOMCLI) AS PRO_NOMPRO,   ';
  Result := Result + '        CONCAT(CID_NOMCID," - ", CID_ESTADO) AS PRO_CIDADE,     ';
  Result := Result + '        PRO_STATUS,                                             ';
  Result := Result + '        CONCAT(  ATI_CODATI," - ", ATI_DESATI)   AS ATI_DESATI, ';
  Result := Result + '        CONCAT(V.OPE_CODOPE," - ", V.OPE_NOMOPE) AS NOMVEN,     ';
  Result := Result + '        DATE_FORMAT(PRO_NASCIM, "%d/%m") AS PRO_NASCIM,         ';
  Result := Result + '        C.PRO_CODPRO,                                           ';
  Result := Result + '        CONCAT(C.PRO_CODREG," - ", R.REG_DESREG) AS REG_DESREG  ';
  Result := Result + ' FROM PROSPE C                                                  ';
  Result := Result + '   LEFT JOIN CADCID   ON CID_CODCID = PRO_CODCID                ';
  Result := Result + '   LEFT JOIN CADATI   ON ATI_CODATI = PRO_CODATI                ';
  Result := Result + '   LEFT JOIN CADOPE V ON V.OPE_CODOPE = PRO_CODVEN              ';
  Result := Result + '   LEFT JOIN CADREG R ON C.PRO_CODREG = R.REG_CODREG            ';
  Result := Result + ' WHERE PRO_CODCLI IS NULL                                       ';

  Result := Result + fStrLocate(edtCodCid  , arrCodCid, 'PRO_CODCID', 'CODCID');
  Result := Result + fStrLocate(edtCodAti  , arrCodAti, 'PRO_CODATI', 'CODATI');
  Result := Result + fStrLocate(edtVendedor, arrCodVen, 'PRO_CODVEN', 'CODVEN');
  Result := Result + fStrLocate(edtCrmFre  , arrCrmFre, 'PRO_CRMFRE', 'CRMFRE');
  Result := Result + fStrLocate(edtCrmPor  , arrCrmPor, 'PRO_CRMPOR', 'CRMPOR');
  Result := Result + fStrLocate(edtCrmFai  , arrCrmFai, 'PRO_CRMFAI', 'CRMFAI');

  Case cmbStatus.ItemIndex Of
    0: Result := Result + ' AND PRO_STATUS = "A" ';
    1: Result := Result + ' AND PRO_STATUS = "I" ';
  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCli.Text))) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinCli.Text))) Then
    Result := Result + ' AND (DATE_FORMAT(PRO_NASCIM, "%m/%d") BETWEEN :ANICLIINI AND :ANICLIFIN) ';

  If not fEmptyStr(edtCrmFor.Text) Then
  Begin
    Result := Result + ' AND ( SELECT COUNT(0) FROM PROFOR WHERE PRF_CODPRO = C.PRO_CODPRO';
    Result := Result + fStrLocate(edtCrmFor, arrCrmFor, 'PRF_CRMFOR', 'CRMFOR');
    Result := Result + ' ) > 0 ';
  End;

  Result := Result + fStrLocate(edtCodCat, arrCodCat, 'PRO_CRMCAT', 'CRMCAT');
  Result := Result + fStrLocate(edtCodReg, arrCodReg, 'PRO_CODREG', 'CODREG');

  Result := Result + ' ORDER BY C.PRO_NOMCLI ';
end;

function TfrmCRMGeracaoGlobalProspecto.fAbreDados : Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGrav );

    frmGrav.fExecutarAcao := fAbreDadosProgresso;
    frmGrav.lblGravando.Caption := 'Carregando informações...';
    frmGrav.pgbStatus.Visible := False;
    frmGrav.ShowModal;

    Result := frmGrav.blnConfirma;

  Finally
    pFreeAndNil(frmGrav);
  End;

End;

function TfrmCRMGeracaoGlobalProspecto.fAbreDadosProgresso(cxProgress : TcxProgressBar) : Boolean;
Begin
  Try
    With cdsDados.qryQuery, SQL Do
    Begin
      Close;
      Clear;
      Add( fGetSQL );

      pSetaParam(edtCodCid.Text       , arrCodCid, strCodCid, 'CODCID', cdsDados.qryQuery);
      pSetaParam(edtCodAti.Text       , arrCodAti, strCodAti, 'CODATI', cdsDados.qryQuery);
      pSetaParam(edtVendedor.Text     , arrCodVen, strCodVen, 'CODVEN', cdsDados.qryQuery);
      pSetaParam(edtCrmFre.Text       , arrCrmFre, strCrmFre, 'CRMFRE', cdsDados.qryQuery);
      pSetaParam(edtCrmPor.Text       , arrCrmPor, strCrmPor, 'CRMPOR', cdsDados.qryQuery);
      pSetaParam(edtCrmFai.Text       , arrCrmFai, strCrmFai, 'CRMFAI', cdsDados.qryQuery);
      pSetaParam(edtCrmFor.Text       , arrCrmFor, strCrmFor, 'CRMFOR', cdsDados.qryQuery);
      pSetaParam(edtCodCat.Text       , arrCodCat, strCodCat, 'CRMCAT', cdsDados.qryQuery);
      pSetaParam(edtCodReg.Text       , arrCodReg, strCodReg, 'CODREG', cdsDados.qryQuery);

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCli.Text))) And
         (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinCli.Text))) Then
      Begin
        ParamByName('ANICLIINI').AsString := RightStr(mskDtaIniCli.Text, 2) + '/' + LeftStr(mskDtaIniCli.Text, 2);
        ParamByName('ANICLIFIN').AsString := RightStr(mskDtaFinCli.Text, 2) + '/' + LeftStr(mskDtaFinCli.Text, 2);
      End;

      cdsDados.fAbreClient(True, 'TfrmCRMGeracaoGlobalProspecto.fAbreDados');

      Result := not cdsDados.IsEmpty;

      lstMarca.Clear;

      If Result Then
      Begin
        cxDadosTableView.ApplyBestFit();
        cxDadosTableViewColumnMARCA.Width := 24;
      End;

    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, 'TfrmCRMGeracaoGlobalProspecto.fAbreDadosProgresso');
    End;
  End;
End;

procedure TfrmCRMGeracaoGlobalProspecto.pMarcarTodos;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGrav );

    frmGrav.fExecutarAcao := fMarcarTodosProgress;
    frmGrav.lblGravando.Caption := 'Atualizando informações...';
    frmGrav.pgbStatus.Visible := False;
    frmGrav.ShowModal;

    cxDadosTableView.Site.Repaint;
  Finally
    pFreeAndNil(frmGrav);
  End;
End;

function TfrmCRMGeracaoGlobalProspecto.fMarcarTodosProgress(cxProgress : TcxProgressBar) : Boolean;
Begin
  Result := True;
  frmGrav.lblGravando.Caption := 'Atualizando informações...';
  frmGrav.pgbStatus.Properties.Max := cdsDados.RecordCount;
  frmGrav.pgbStatus.Position := 0;
  frmGrav.pgbStatus.Visible := True;
  Try
    cdsDados.First;
    cdsDados.DisableControls;

    While Not cdsDados.Eof Do
    Begin

      If lstMarca.IndexOf(cdsDados.FieldByName('PRO_CODPRO').AsString) < 0 Then
        lstMarca.Add( cdsDados.FieldByName('PRO_CODPRO').AsString );

      cdsDados.Next;

      frmGrav.pgbStatus.Position := frmGrav.pgbStatus.Position + 1;

      If (cdsDados.RecNo Mod 50) = 0 Then
        Application.ProcessMessages;
    End;

  Finally
    cdsDados.First;
    cdsDados.EnableControls;
  End;
End;

procedure TfrmCRMGeracaoGlobalProspecto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If NoteBook.PageIndex = 1 Then
  Begin
    Action := caNone;

    If fMensagem('', 'Deseja cancelar?', ['&Sim', '&Não'],2) = 1 Then
       pReset;

  End;

end;

procedure TfrmCRMGeracaoGlobalProspecto.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TZClient.Create(Self);
  cxDadosTableView.DataController.DataSource := cdsDados.dtsSource;
  lstMarca := TStringList.Create;
  pReset;
end;

procedure TfrmCRMGeracaoGlobalProspecto.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsDados);
  FreeAndNil(lstMarca);
end;

procedure TfrmCRMGeracaoGlobalProspecto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F7 Then
    btnMarcarTodos.Click
  Else
  If Key = VK_F8 Then
    btnDesmTodos.Click;

end;

function TfrmCRMGeracaoGlobalProspecto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodCid) Then
    Begin
      pDesmarcaLista(edtCodCid, arrCodCid);
    End

    Else
    If (Sender = edtCodAti) Then
    Begin
      pDesmarcaLista(edtCodAti, ArrCodAti);
    End

    Else
    If (Sender = edtVendedor) Then
    Begin
      pDesmarcaLista(edtVendedor, arrCodVen);
    End

    Else
    If (Sender = mskDtaIniCli) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCli.Text))) Then
      Begin
        Result := StrToDateDef(mskDtaIniCli.Text + '/' + IntToStr(YearOf(VS_Date)) ,0) > 0;
      End;

      mskDtaFinCli.Enabled := (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniCli.Text))) And
                              Result;
      If not mskDtaFinCli.Enabled Then
        mskDtaFinCli.Clear;
    End

    Else
    If (Sender = mskDtaFinCli) And (mskDtaFinCli.Enabled) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinCli.Text))) Then
      Begin
        Result := StrToDateDef(mskDtaFinCli.Text + '/' + IntToStr(YearOf(VS_Date)) ,0) > 0;
      End;
    End

    Else If (Sender = edtCodReg) Then
    Begin
      pDesmarcaLista(edtCodReg, arrCodReg);
    End

  End;

  if not Result Then
    pSetFocus(sender);
end;

procedure TfrmCRMGeracaoGlobalProspecto.pReset;
begin
  Self.WindowState    := wsNormal;
  Self.Position       := poScreenCenter;
  Notebook.PageIndex  := 0;
  btnCarregarDados.Visible := True;
  btnConfirma.Visible := False;
  btnMarcarTodos.Visible := False;
  btnDesmTodos.Visible   := False;
  lblInfEnter.Visible    := False;
end;

end.
