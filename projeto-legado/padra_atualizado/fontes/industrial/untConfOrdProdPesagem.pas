unit untConfOrdProdPesagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxGrid, Uni, UniClientDataSet, EditFocus, Vcl.Mask, MaskEditFocus,
  cxContainer, cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, untIteBar, untMovCdb,
  System.UITypes, Math, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConfOrdProdPesagem = class(TfrmPai)
    grdOrdDet: TcxGridCitel;
    grdOrdDetDados: TcxGridDBTableViewCitel;
    grdOrdDetLevel1: TcxGridLevel;
    pnlConferencia: TPanel;
    dtsOrdDet: TDataSource;
    grdOrdDetDadosORD_CODITE: TcxGridDBColumn;
    grdOrdDetDadosORD_DESITE: TcxGridDBColumn;
    grdOrdDetDadosORD_REFERE: TcxGridDBColumn;
    grdOrdDetDadosORD_PESOLI: TcxGridDBColumn;
    grdOrdDetDadosORD_QTDECF: TcxGridDBColumn;
    btnConfirmar: TBitBtnLocked;
    lblCodBar: TLabel;
    lblQtdIte: TLabel;
    edtCodIte: TEditFocus;
    edtQtdIte: TCurrencyEditFocus;
    btnLimparPesagem: TBitBtnLocked;
    lblLimparQtde: TLabel;
    pnlLegenda: TPanel;
    lblPesTot: TLabel;
    shpPesTot: TShape;
    lblPesPar: TLabel;
    shpPesPar: TShape;
    shpPesoLimite: TShape;
    lblPesoLimite: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdOrdDetDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnLimparPesagemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    VS_strTipDEx: String;
    strCamBus   : String;
    strCodIteFor: String;
    strCodIte   : String;
    strCodDig   : String;
    strBarBal   : String;
    bln2CodBar  : Boolean;
    blnAutSer   : Boolean;
    objIteBar   : TIteBar;
    objCodBar   : TCodigoBarras;

    cdsOrdDet: TUniClientDataSet;

    procedure pCarregarDados;
    procedure pConferirPesagemItem(blnExpAut: Boolean = False);
    function  fEncontraItem(Var strMensagem: String): Boolean;
    function  fProcuraSemelhante(strCodBar: String; Var strCodSem: String): Boolean;
    procedure pLimparPesagemItem;
    procedure pOnFilter(DataSet: TDataSet; var Accept: Boolean);
    function  fTodosPesados: Boolean;
    function  fConfirmarPesagem(pgbProgresso: TcxProgressBar): Boolean;
    procedure pConfirmarPesagem;
    function fPedeSenhaOperador(strInfo: String): String;
    procedure pConfirmarConferenciaPesagem;
    function  fConfirmarConferenciaPesagem(pgbProgresso: TcxProgressBar): Boolean;
    procedure pBaixarOP(strCodOrd, strDtaCad: String);
  public
    { Public declarations }
    strCodBarOP: String;
    blnConfir: Boolean;
    blnConferencia: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmConfOrdProdPesagem: TfrmConfOrdProdPesagem;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConstantes, untTypesSistema, untGravando,
  untBaixaOrdProdIndustrial;

procedure TfrmConfOrdProdPesagem.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If (Not blnConferencia) Then Begin
    If (Not fTodosPesados()) Then Begin
      blnConfir := (fMensagem('ATENÇÃO', 'Existem produtos que não foram pesados totalmente. Deseja continuar?', ['&Sim', '&Não']) = 1);

      If (blnConfir) Then
        pConfirmarPesagem();
    End Else
      pConfirmarPesagem();
  End Else Begin
    If (Not fTodosPesados()) Then Begin
      fMensagem('ATENÇÃO', 'Existem produtos que não foram pesados totalmente ou estão fora do limite mínimo/máximo permitido. Operação cancelada!', ['&OK']);
      blnConfir := False;
    End Else Begin
      pConfirmarConferenciaPesagem();
    End;
  End;

  If (blnConfir) Then btnSair.Click();
end;

procedure TfrmConfOrdProdPesagem.btnLimparPesagemClick(Sender: TObject);
begin
  inherited;

  If (Not btnLimparPesagem.Visible) Then Exit;

  Try
    cdsOrdDet.DisableControls();
    cdsOrdDet.First();

    Try
      While (Not cdsOrdDet.Eof) Do Begin
        cdsOrdDet.Edit();
        cdsOrdDet.FieldByName('ORD_QTDECF').AsFloat := 0;
        cdsOrdDet.Post();

        cdsOrdDet.Next();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProdPesagem.btnLimparPesagemClick]');
    End;
  Finally
    cdsOrdDet.EnableControls();
  End;
end;

function TfrmConfOrdProdPesagem.fConfirmarConferenciaPesagem(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryTemp: TUniQuery;
    strSQL: String;
    strOpeBai: String;
begin
  Result := False;

  strOpeBai := fPedeSenhaOperador('Senha do Operador da Pesagem');

  If fEmptyStr(strOpeBai) Then
    Exit;

  strSQL := 'UPDATE ORDGER SET ORD_OPBXCF = :OPBXCF, ORD_DTBXCF = :DTBXCF, ORD_HRBXCF = :HRBXCF ';
  strSQL := strSQL + ' WHERE ORD_CODBAR = :CODBAR ';

  Try
    qryTemp := fCriaQuery(Self);

    Try
      fStartTransaction();

      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := strSQL;
      qryTemp.ParamByName('OPBXCF').AsString   := strOpeBai; //strLoginUsuarioLogado;
      qryTemp.ParamByName('DTBXCF').AsDateTime := Trunc(fNow());
      qryTemp.ParamByName('HRBXCF').AsDateTime := (fNow() - Trunc(fNow()));
      qryTemp.ParamByName('CODBAR').AsString   := strCodBarOP;
      qryTemp.ExecSQL;

      fCommit();

      Result := True;
    Except
      On E: Exception Do Begin
        fRollBack();
        Result := False;
        pMensagensErro(E.Message, 'TfrmConfOrdProdPesagem.fConfirmarConferenciaPesagem');
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmConfOrdProdPesagem.fConfirmarPesagem(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryTemp: TUniQuery;
    strSQL: String;
    strOpeBai: String;
begin
  Result := False;

  strOpeBai := fPedeSenhaOperador('Senha do Operador da Pesagem');

  If fEmptyStr(strOpeBai) Then
    Exit;

  strSQL := 'UPDATE ORDDET SET ORD_OPBXCF = :OPBXCF, ORD_DTBXCF = :DTBXCF, ORD_HRBXCF = :HRBXCF, ';
  strSQL := strSQL + ' ORD_QTDECF = :QTDECF WHERE AUTOINCREM = :AUTINC ';

  Try
    cdsOrdDet.DisableControls();
    cdsOrdDet.First();

    qryTemp := fCriaQuery(Self);

    Try
      fStartTransaction();

      While (Not cdsOrdDet.Eof) Do Begin
        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := strSQL;
        qryTemp.ParamByName('OPBXCF').AsString   := strOpeBai; //strLoginUsuarioLogado;
        qryTemp.ParamByName('DTBXCF').AsDateTime := Trunc(fNow());
        qryTemp.ParamByName('HRBXCF').AsDateTime := (fNow() - Trunc(fNow()));
        qryTemp.ParamByName('QTDECF').AsFloat    := cdsOrdDet.FieldByName('ORD_QTDECF').AsFloat;
        qryTemp.ParamByName('AUTINC').AsString   := cdsOrdDet.FieldByName('AUTOINCREM').AsString;
        qryTemp.ExecSQL;

        cdsOrdDet.Next();
      End;

      fCommit();

      Result := True;
    Except
      On E: Exception Do Begin
        fRollBack();
        Result := False;
        pMensagensErro(E.Message, 'TfrmConfOrdProdPesagem.fConfirmarPesagem');
      End;
    End;
  Finally
    cdsOrdDet.EnableControls();
    FreeAndNil(qryTemp);
  End;
end;

function TfrmConfOrdProdPesagem.fEncontraItem(var strMensagem: String): Boolean;
  Var
    fltQtdIte,
    fltEmbala: Double;
    blnBusNormalOuExp2CodBarCompleta: Boolean;

  function fRetornaSaldoVerificaoEstoqueBaseImobiliaria(strEmpPrdBase: String; fltSaldoBase: Double; strCodIteBase: String): Double;
      function fRetornaSaldoEstoqueEmpresa(strCodEmpBase: String): Double;
      begin
        Result := fCampoTabela('ITE_SALDOS',
                               'ITEGER',
                               ['ITE_CODITE', 'ITE_CODEMP'],
                               [strCodIteBase, strCodEmpBase]);
      end;
  begin
    Result := fltSaldoBase;

    If strEmpPrdBase <> VS_strCodEmp Then
      Result := fRetornaSaldoEstoqueEmpresa(strEmpPrdBase);
  end;
begin
  cdsOrdDet.First;
  Result    := False;

  blnBusNormalOuExp2CodBarCompleta :=((Not bln2CodBar) Or (strCamBus = 'ORD_CODITE')) Or (bln2CodBar And (Not fEmptyStr(strCodIteFor)));

  If (cdsOrdDet.FindFirst) Then Begin
    Result := True;

    Repeat
      If SameText(strCamBus, 'BAREMB') Then
        fltEmbala := objIteBar.fQuantidadeEmbalagem(cdsOrdDet.FieldByName('ORD_CODITE').AsString, strCodDig)
      Else
        fltEmbala := 1;

      fltQtdIte := cdsOrdDet.FieldByName('ORD_QTDECF').AsFloat + (fltEmbala * fStrToFloat(edtQtdIte.Text));

      //If (cdsOrdDet.FieldByName('ORD_PESOLI').AsFloat >= fltQtdIte) Or
      //   (fltQtdIte <= fltLimMax) Then Begin
      If (cdsOrdDet.FieldByName('ORD_PESOLI').AsFloat >= fltQtdIte) Or (fPesoDentroLimite(fltQtdIte, cdsOrdDet.FieldByName('ORD_PESOLI').AsFloat)) Then Begin
        cdsOrdDet.Edit;
        cdsOrdDet.FieldByName('ORD_QTDECF').AsFloat := cdsOrdDet.FieldByName('ORD_QTDECF').AsFloat +
                                                         (fltEmbala * fStrToFloat(edtQtdIte.Text));
        cdsOrdDet.Post;

        If Assigned(objCodBar) Then
          objCodBar.pAddCodBar(strCodDig, cdsOrdDet.FieldByName('ORD_CODITE').AsString, fltEmbala * fStrToFloat(edtQtdIte.Text));

        If (blnBusNormalOuExp2CodBarCompleta) Then Begin
          edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, 3);
          strMensagem := '';
          Break;
        End;
      End
      Else
      Begin
        If fFormataFloat(cdsOrdDet.FieldByName('ORD_QTDECF').AsFloat, 3) >=
           fFormataFloat(cdsOrdDet.FieldByName('ORD_PESOLI').AsFloat, 3) Then
          strMensagem := 'Produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') já foi totalmente pesado!'
        Else
          strMensagem := 'Quantidade não permitida para o produto (' + edtCodIte.Text + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ').';
      End;

    Until (Not cdsOrdDet.FindNext);

  End;
end;

procedure TfrmConfOrdProdPesagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objIteBar);
  FreeAndNil(objCodBar);
end;

procedure TfrmConfOrdProdPesagem.FormCreate(Sender: TObject);
begin
  inherited;

  strCodBarOP  := '';
  VS_strTipDEx := fCfgSis('TIPDEX');

  blnConfir := False;
  blnConferencia := False;

  objIteBar := TIteBar.Create(opcFuncoes);
  objCodBar := TCodigoBarras.Create();
end;

procedure TfrmConfOrdProdPesagem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then Begin
    If (fMensagem('', 'Deseja sair?', ['&Sim', '&Não']) = 1) Then
      btnSair.Click()
    Else
      Key := 0;
  End;

  If (Key = VK_F10) Then btnConfirmar.Click();
  If (Key = VK_F11) Then btnLimparPesagem.Click();
  If (Key = VK_F5)  Then pLimparPesagemItem();
end;

procedure TfrmConfOrdProdPesagem.FormShow(Sender: TObject);
begin
  inherited;

  pCarregarDados();
  pSetFocus(edtCodIte);

  lblCodBar.Visible := (Not blnConferencia);
  edtCodIte.Visible := (Not blnConferencia);
  lblQtdIte.Visible := (Not blnConferencia);
  edtQtdIte.Visible := (Not blnConferencia);
  lblLimparQtde.Visible := (Not blnConferencia);
  pnlConferencia.Visible := (Not blnConferencia);
  btnLimparPesagem.Visible := (Not blnConferencia);
end;

function TfrmConfOrdProdPesagem.fPedeSenhaOperador(strInfo: String): String;
  Var
    strSenha: String;
begin
  If ffrmSenha(strSenha, strInfo) Then Begin
    If (Length(strSenha) = 13) Then
      Result := fPesqOpePeloCodBar(strSenha)
    Else
      Result := fRetCodVendedor(strSenha);
  End;
end;

function TfrmConfOrdProdPesagem.fProcuraSemelhante(strCodBar: String;
  var strCodSem: String): Boolean;
  Var
    qryCadSem: TUniQuery;
Begin
  Try
    Result := False;
    qryCadSem := fCriaQuery(Self);

    Try
      With qryCadSem, SQL Do Begin
        Clear;
        Add('SELECT');
        Add('  SEM_CODITE ');
        Add('FROM ');
        Add('  CADSEM ');
        Add('WHERE ');
        Add('  SEM_CODBAR = :CODBAR ');

        ParamByName('CODBAR').AsString := strCodBar;
        Open;

        If IsEmpty Then Begin
          strCodSem := '';
          Result := False;
        End Else Begin
          strCodSem := FieldByName('SEM_CODITE').AsString;
          Result := True;
        End;

      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProdPesagem.fProcuraSemelhante]');
    End;
  Finally
    FreeAndNil(qryCadSem);
  End;
end;

function TfrmConfOrdProdPesagem.fTodosPesados: Boolean;
begin
  Try
    Result := True;

    cdsOrdDet.DisableControls();
    cdsOrdDet.First();

    Try
      While (Not cdsOrdDet.Eof) Do Begin
        //If (cdsOrdDet.FieldByName('ORD_QTDECF').AsFloat < cdsOrdDet.FieldByName('ORD_PESOLI').AsFloat) Then Begin
        If (Not
                fPesoDentroLimite(cdsOrdDet.FieldByName('ORD_QTDECF').AsFloat,
                                  cdsOrdDet.FieldByName('ORD_PESOLI').AsFloat)
           ) Then Begin
          Result := False;
          Break;
        End;

        cdsOrdDet.Next();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProdPesagem.fTodosPesados]');
    End;
  Finally
    cdsOrdDet.EnableControls();
    cdsOrdDet.First();
  End;
end;

function TfrmConfOrdProdPesagem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtQtdIte) Then Begin
    If (fEmptyStr(edtQtdIte.Text)) Then Begin
      pMensagemSonora('A quantidade deve ser preenchida!');
      Result := False;
    End

    Else If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then Begin
      pMensagemSonora('A quantidade deve ser maior que zero!');
      Result := False;
    End

    Else If (Frac(fStrToFloat(edtQtdIte.Text)) <> 0) And Assigned(edtQtdIte.OnKeyPress) Then Begin
      fMensagem('ATENÇÃO!', 'Não é permitido informar valor fracionado para esse item!', ['&O k']);
      Result := False;
    End

    Else Begin
      pSetFocus(edtCodIte);
      blnMudarFoco := False;

      pConferirPesagemItem();
      edtQtdIte.Text := FloatToStrF(1, ffFixed, 12, 3);
      pSetFocus(edtCodIte);
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmConfOrdProdPesagem.grdOrdDetDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
   fltQTDECF,
   fltPESOLI: Double;
begin
  inherited;

  If Assigned(grdOrdDetDados.DataController.DataSource.DataSet) And
    (Not grdOrdDetDados.DataController.DataSource.DataSet.IsEmpty) Then Begin

    fltQTDECF := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdOrdDetDadosORD_QTDECF.Index], 0), varDouble);
    fltPESOLI := VarAsType(IfNull(Sender.ViewData.Records[AViewInfo.GridRecord.Index].Values[grdOrdDetDadosORD_PESOLI.Index], 0), varDouble);

    fltQTDECF := Trunc(fltQTDECF * 1000);
    fltPESOLI := Trunc(fltPESOLI * 1000);

    If (fltQTDECF = fltPESOLI) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clWhite;

      ACanvas.Brush.Color := $0096CFA7;
    End Else If (fltQTDECF > 0) And (fPesoDentroLimite(fltQTDECF, fltPESOLI)) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := clSkyBlue;
    End Else If (fltQTDECF > 0) And (fltQTDECF < fltPESOLI) Then Begin
      If (ACanvas.Brush.Color = clHighlight) Then
        ACanvas.Font.Color := clBlack;

      ACanvas.Brush.Color := $00CCFFFF;
    End;
  End;
end;

procedure TfrmConfOrdProdPesagem.pBaixarOP(strCodOrd, strDtaCad: String);
begin
  Try
    pCriarFormularios(TfrmBaixaOrdProdIndustrial, frmBaixaOrdProdIndustrial);

    Try
      frmBaixaOrdProdIndustrial.edtNumOrd.Text := strCodOrd;
      frmBaixaOrdProdIndustrial.mskDtaCad.Text := strDtaCad;
      frmBaixaOrdProdIndustrial.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProdPesagem.pBaixarOP]');
    End;
  Finally
    pFreeAndNil(frmBaixaOrdProdIndustrial);
  End;
end;

procedure TfrmConfOrdProdPesagem.pCarregarDados;
  Var
    strSQLOrdDet: String;
    qryOrdDet: TUniQuery;
begin
  strSQLOrdDet := 'SELECT ';
  strSQLOrdDet := strSQLOrdDet + '  D.AUTOINCREM, ';
  strSQLOrdDet := strSQLOrdDet + '  G.ORD_CODBAR, ';
  strSQLOrdDet := strSQLOrdDet + '  G.ORD_CODORD, ';
  strSQLOrdDet := strSQLOrdDet + '  G.ORD_DTACAD, ';
  strSQLOrdDet := strSQLOrdDet + '  D.ORD_CODITE, ';
  strSQLOrdDet := strSQLOrdDet + '  ID.ITE_DESITE AS ORD_DESITE, ';
  strSQLOrdDet := strSQLOrdDet + '  ID.ITE_REFERE AS ORD_REFERE, ';
  strSQLOrdDet := strSQLOrdDet + '  ROUND(SUM( ';
  strSQLOrdDet := strSQLOrdDet + '    IF( ';
  strSQLOrdDet := strSQLOrdDet + '      U.UNI_KILLIT = "K", ';
  strSQLOrdDet := strSQLOrdDet + '      D.ORD_QTDPRO * U.UNI_PESLIT, ';
  strSQLOrdDet := strSQLOrdDet + '      D.ORD_QTDPRO * U.UNI_PESLIT * GM.GMT_PESREA ';
  strSQLOrdDet := strSQLOrdDet + '    ) ';
  strSQLOrdDet := strSQLOrdDet + '  ), 3) AS ORD_PESOLI, ';
  strSQLOrdDet := strSQLOrdDet + '  CONCAT(DATE_FORMAT(G.ORD_DTACAD,"%d%m%y"), "-", G.ORD_CODORD) AS ORD_NUMLOT, ';
  strSQLOrdDet := strSQLOrdDet + '  D.ORD_QTDECF, ';
  strSQLOrdDet := strSQLOrdDet + '  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM ';
  strSQLOrdDet := strSQLOrdDet + '    ITEBAR WHERE D.ORD_CODITE = BAR_CODITE) AS BAREMB, ';
  strSQLOrdDet := strSQLOrdDet + '  ID.ITE_CODBAR AS CODBAR, ';
  strSQLOrdDet := strSQLOrdDet + '  "" AS CODBAT  ';
  strSQLOrdDet := strSQLOrdDet + 'FROM ';
  strSQLOrdDet := strSQLOrdDet + '  ORDGER G ';
  strSQLOrdDet := strSQLOrdDet + '  INNER JOIN ORDDET D ';
  strSQLOrdDet := strSQLOrdDet + '    ON G.AUTOINCREM = D.ORD_SEQGER ';
  strSQLOrdDet := strSQLOrdDet + '  INNER JOIN CADITE IG ';
  strSQLOrdDet := strSQLOrdDet + '    ON G.ORD_CODITE = IG.ITE_CODITE ';
  strSQLOrdDet := strSQLOrdDet + '  LEFT JOIN CADCOR C ';
  strSQLOrdDet := strSQLOrdDet + '    ON G.ORD_CODCOR = C.COR_CODCOR ';
  strSQLOrdDet := strSQLOrdDet + '  LEFT JOIN CADITE ID ';
  strSQLOrdDet := strSQLOrdDet + '    ON ID.ITE_CODITE = D.ORD_CODITE ';
  strSQLOrdDet := strSQLOrdDet + '  LEFT JOIN CADUNI U ';
  strSQLOrdDet := strSQLOrdDet + '    ON ID.ITE_CODUNI = U.UNI_CODUNI ';
  strSQLOrdDet := strSQLOrdDet + '  LEFT JOIN GEIMAT GM ';
  strSQLOrdDet := strSQLOrdDet + '    ON GMT_STATUS = "A" ';
  strSQLOrdDet := strSQLOrdDet + '    AND GMT_CODITE = G.ORD_CODITE ';
  strSQLOrdDet := strSQLOrdDet + '    AND GMT_CODCOR = G.ORD_CODCOR ';
  strSQLOrdDet := strSQLOrdDet + '  LEFT JOIN EXTGOR EX ';
  strSQLOrdDet := strSQLOrdDet + '    ON EX.FGO_ORDIND = G.AUTOINCREM ';
  strSQLOrdDet := strSQLOrdDet + '  LEFT JOIN FATGOR FG ';
  strSQLOrdDet := strSQLOrdDet + '    ON FG.AUTOINCREM = EX.FGO_SEQFGO ';
  strSQLOrdDet := strSQLOrdDet + 'WHERE G.ORD_CODBAR = :CODBAR ';
  strSQLOrdDet := strSQLOrdDet + '  AND G.ORD_DTABAI IS NULL ';
  strSQLOrdDet := strSQLOrdDet + '  AND D.ORD_QTDPRO > 0 ';
  strSQLOrdDet := strSQLOrdDet + 'GROUP BY D.AUTOINCREM ';
  strSQLOrdDet := strSQLOrdDet + 'ORDER BY ORD_DESITE ';

  Try
    qryOrdDet := fCriaQuery(nil);

    Try
      qryOrdDet.Close();
      qryOrdDet.SQL.Clear();
      qryOrdDet.SQL.Text := strSQLOrdDet;
      qryOrdDet.ParamByName('CODBAR').AsString := strCodBarOP;
      qryOrdDet.Open();

      If (qryOrdDet.IsEmpty) Then Begin
        fMensagem('ATENÇÃO!', 'Ordem de Produção não possui produtos a produzir informados. Verifique!', ['&OK']);
        btnSair.Click();
      End;

      If (Assigned(cdsOrdDet)) Then
        cdsOrdDet.EmptyDataSet();

      cdsOrdDet := fCriaClientDatset(qryOrdDet);
      dtsOrdDet.DataSet := cdsOrdDet;

      cdsOrdDet.OnFilterRecord := pOnFilter;

      TFloatField(cdsOrdDet.FieldByName('ORD_PESOLI')).DisplayFormat := '#,###0.000';
      TFloatField(cdsOrdDet.FieldByName('ORD_QTDECF')).DisplayFormat := '#,###0.000';

      grdOrdDetDados.ApplyBestFit();
    Except
      On E: Exception Do Begin
        pMensagensErro(E.Message, 'TfrmConfOrdProdPesagem.pCarregarDados');
      End;
    End;
  Finally
    FreeAndNil(qryOrdDet);
  End;
end;

procedure TfrmConfOrdProdPesagem.pConferirPesagemItem(blnExpAut: Boolean);
  Var
    strMensagem  : String;
    blnAchou,
    blnBarExp    : Boolean;
    strCodSem    : String;
    strCodIteUni : String;
    strCodGruUni : String;
    fltQtdIteUni : Double;
    strTxtCap    : String;

    strCodIteAux : String;
    strCodDigAux : String;
    strCamBusAux : String;

    fltQtdBal : Double;
    intQtdBal : Integer;

  procedure SetaCampoProcurar(const strCaption: string); begin
    If Not bln2CodBar Then
      lblCodBar.Caption := strCaption;

    If bln2CodBar And (strCaption = CAP_CODBAR_EMB) Then
      strCamBus := 'CODBAR'
    Else
    If bln2CodBar And (strCaption = CAP_CODBAR_FOR) Then
      strCamBus := 'CODBAT'
    Else
      strCamBus := 'CODBAR';
  end;

  procedure pInverteBusca; begin
    If (strCamBus='BAREMB') Then Begin
      strCamBus:='CODBAT';
      strTxtCap:=CAP_CODBAR_FOR;
      lblCodBar.Caption:=CAP_CODBAR_EMB;
    End Else Begin
      strCamBus:='BAREMB';
      strTxtCap:=CAP_CODBAR_EMB;
      lblCodBar.Caption:=CAP_CODBAR_FOR;
    End;
  end;

  function fBuscaSegundoCodBar:Boolean; begin
    pInverteBusca;

    strCodIteFor := Trim(InputBox('AutCom', strTxtCap,''));

    strCodIte    := strCodIteFor;
    strCodDig    := strCodIteFor;

    Result := fEncontraItem(strMensagem);
  end;

  procedure pArmazenaCondicaoBusca(chrAcao:char); begin
    Case chrAcao Of
    'A':Begin
          strCodIteAux := strCodIte;
          strCodDigAux := strCodDig;
          strCamBusAux := strCamBus;
        End;

    'V':Begin
          strCodIte := strCodIteAux;
          strCodDig := strCodDigAux;
          strCamBus := strCamBusAux;
        End;
    End;
  end;
begin
  bln2CodBar   := (fCfgSis('EXPTIN') = '2');// And (cdsOrdDet.FieldByName('IDEPRO').AsString <> 'NOR');
  strCodIteFor := '';

  If ((Length(edtCodIte.Text) > 5) Or (blnAutSer)) And (Not fBarrasBalanca(edtCodIte.Text, strBarBal)) Then
    strCamBus := 'BAREMB'
  Else Begin
    strCamBus := 'ORD_CODITE';

    If fBarrasBalanca(edtCodIte.Text, strBarBal) Then Begin
      intQtdBal := StrToIntDef(Copy(edtCodIte.Text, 8, 5),0);
      edtQtdIte.Text := FormatFloat('#.###0,000', intQtdBal);
      edtCodIte.Text := Copy(edtCodIte.Text, 3, 5);

      If fCfgSis('DVQBAL') = 'S' Then Begin
        fltQtdBal := intQtdBal / 1000;
        edtQtdIte.Text := FormatFloat('#.###0,000', fltQtdBal);
      End;
    End Else
      edtCodIte.Text := fStrZero(edtCodIte.Text, 5);

    blnBarExp := (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]) = 'S');

    If (blnBarExp) And (Not blnExpAut) Then Begin
      edtCodIte.Clear;
      pMensagemSonora('Para expedir o produto '+cdsOrdDet.FieldByName('ORD_CODITE').AsString+' é necessário informar o código de barras. Esta informação é obrigatória para este item. '+
                      'Verifique o cadastro de produtos - Aba "Dados de Saída" - Campo "Obrig. Cód. Barras Expedição"');
      Exit;
    End;
  End;

  strMensagem := '';

  strCodIte := edtCodIte.Text;
  strCodDig := edtCodIte.Text;
  cdsOrdDet.IndexFieldNames := 'AUTOINCREM';
  cdsOrdDet.DisableControls;

  pArmazenaCondicaoBusca('A');

  If (Not bln2CodBar) Or (strCamBus = 'ORD_CODITE') Then Begin
    blnAchou := fEncontraItem(strMensagem);
  End Else Begin
    blnAchou := fEncontraItem(strMensagem);

    If (Not blnAchou) Then Begin
      pInverteBusca;
      blnAchou := fEncontraItem(strMensagem);
    End;

    If blnAchou Then Begin
      blnAchou := fBuscaSegundoCodBar;
    End;
  End;

  pArmazenaCondicaoBusca('V');

  If (Not blnAchou) And fCfgSis('ETIDIF', varBoolean) And (strCamBus = 'BAREMB') Then Begin
    If objIteBar.fLerCodigoBarrasUnidades(edtCodIte.Text, strCodIteUni, strCodGruUni, fltQtdIteUni) Then Begin
      strCamBus := 'ORD_CODITE';
      strCodIte := strCodIteUni;
      edtCodIte.Text := strCodIteUni;
      edtQtdIte.Text := FloatToStrF(fltQtdIteUni, ffFixed, 12, 3);
      blnAchou := fEncontraItem(strMensagem);
    End;
  End;

  If (Not bln2CodBar) And (Not blnAchou) And (Length(edtCodIte.Text) > 5) Then Begin
    SetaCampoProcurar(CAP_CODBAR_EMB);
    blnAchou := fEncontraItem(strMensagem);

    If (Not blnAchou) Then Begin
      SetaCampoProcurar(CAP_CODBAR_FOR);
      blnAchou := fEncontraItem(strMensagem);

      If (Not blnAchou) And fProcuraSemelhante(edtCodIte.Text, strCodSem) Then Begin
        strCamBus := 'ORD_CODITE';
        edtCodIte.Text := strCodSem;
        strCodIte      := strCodSem;
        blnAchou := fEncontraItem(strMensagem);
      End;
    End;
  End;

  cdsOrdDet.EnableControls;

  If (Not blnAchou) Then Begin
    strMensagem := 'Produto (' + edtCodIte.Text
           + iif(fEmptyStr(strCodIteFor),'',' - '+strCodIteFor) + ') não encontrado!';
  End;

  If (Not fEmptyStr(strMensagem)) Then Begin
    pMensagemSonora(strMensagem);
  End;

  edtCodIte.Clear;
  lblCodBar.Caption:=CAP_CODBAR_EMB;
end;

procedure TfrmConfOrdProdPesagem.pConfirmarConferenciaPesagem;
  Var
    blnBaixarOP: Boolean;
begin
  blnConfir   := False;
  
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    Try
      frmGravando.pgbStatus.Visible   := False;
      frmGravando.lblGravando.Caption := 'Aguarde, confirmando conferência da pesagem...';
      frmGravando.fExecutarAcao := fConfirmarConferenciaPesagem;
      frmGravando.ShowModal;

      blnConfir := frmGravando.blnConfirma;

      If (blnConfir) And (fCfgSis('UTIIND', varBoolean)) Then Begin
        blnBaixarOP := (fMensagem('ATENÇÃO', 'Deseja baixar a Ordem de Produção?', ['&Sim', '&Não']) = 1);

        If (blnBaixarOP) Then Begin
          pBaixarOP(cdsOrdDet.FieldByName('ORD_CODORD').AsString, FormatDateTime('dd/mm/yyyy', cdsOrdDet.FieldByName('ORD_DTACAD').AsDateTime));
        End;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProdPesagem.pConfirmarConferenciaPesagem]');
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmConfOrdProdPesagem.pConfirmarPesagem;
begin
  blnConfir := False;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    Try
      frmGravando.pgbStatus.Visible   := False;
      frmGravando.lblGravando.Caption := 'Aguarde, aplicando pesagem dos itens...';
      frmGravando.fExecutarAcao := fConfirmarPesagem;
      frmGravando.ShowModal;

      blnConfir := frmGravando.blnConfirma;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProdPesagem.pConfirmarPesagem]');
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmConfOrdProdPesagem.pLimparPesagemItem;
begin
  If (Not lblLimparQtde.Visible) Then Exit;

  If (fEmptyStr(cdsOrdDet.FieldByName('AUTOINCREM').AsString)) Then Begin
    fMensagem('ATENÇÃO!', 'Selecione um produto para realizar esta operação!', ['&OK']);
    Exit;
  End;

  If (fMensagem('', 'Deseja limpar a pesagem do produto ' + cdsOrdDet.FieldByName('ORD_CODITE').AsString + '?', ['&Sim', '&Não']) <> 1) Then Begin
    Exit;
  End;

  Try
    cdsOrdDet.DisableControls();
    cdsOrdDet.First();

    Try
      While (Not cdsOrdDet.Eof) Do Begin
        cdsOrdDet.Edit();
        cdsOrdDet.FieldByName('ORD_QTDECF').AsFloat := 0;
        cdsOrdDet.Post();

        cdsOrdDet.Next();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmConfOrdProdPesagem.pLimparPesagemItem]');
    End;
  Finally
    cdsOrdDet.EnableControls();
  End;
end;

procedure TfrmConfOrdProdPesagem.pOnFilter(DataSet: TDataSet; var Accept: Boolean);
begin
  If SameText(strCamBus, 'BAREMB') Then
    Accept := Pos('-' + strCodIte + '-', DataSet.FieldByName(strCamBus).AsString) > 0
  Else
    Accept := (DataSet.FieldByName(strCamBus).AsString = strCodIte)
end;

end.
