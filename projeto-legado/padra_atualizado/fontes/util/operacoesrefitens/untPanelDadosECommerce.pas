unit untPanelDadosECommerce;

interface

uses
  Uni, untConstantes,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, clipBrd,
  MemoFocus, QColorLabel, DB, untTypesSistema, frxClass, StrUtils,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit,
  CurrencyEditFocus, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxDBData, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, UniClientDataSet, UniDataSetProvider;

type
      TfrmPanelDadosECommerce = class(TfrmPai)
    pnlDadosItem: TPanel;
    dtsCadIte: TDataSource;
    pnlGeral: TPanel;
    lbl7: TLabel;
    clblbl8: TColorLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    Label1: TLabel;
    dbeExpSit: TDBEditFocus;
    mmoDesSit: TMemoFocus;
    mmoDadTec: TMemoFocus;
    edtNomIte: TEditFocus;
    mmoAplIte: TMemoFocus;
    mmoIteIncluso: TMemoFocus;
    edtExpAlt: TEditFocus;
    edtExpLar: TEditFocus;
    edtExpPro: TEditFocus;
    edtCodCat: TEditFocus;
    pnlMOEXSI7: TPanel;
    Label2: TLabel;
    edtDesSit: TEditFocus;
    lblDestaq: TLabel;
    clbDestaq: TColorLabel;
    edtDestaq: TEditFocus;
    lblPesoIt: TLabel;
    edtPesoIt: TEditFocus;
    ColorLabel1: TColorLabel;
    Label3: TLabel;
    edtAtzPre: TEditFocus;
    lblExpApp: TLabel;
    dbeExpApp: TDBEditFocus;
    clbExpApp: TColorLabel;
    lblCroDoc: TLabel;
    edtCroDoc: TEditFocus;
    clbCroDoc: TColorLabel;
    lblExpB2B: TLabel;
    edtExpB2B: TEditFocus;
    clbExpB2B: TColorLabel;
    edtVlrLiq: TCurrencyEditFocus;
    Label4: TLabel;
    lblTabela: TLabel;
    lblPrecoTab: TLabel;
    lblUrlDescri: TLabel;
    cxgUrl: TcxGrid;
    cxgUrlView: TcxGridDBTableView;
    cxgUrlDescricao: TcxGridDBColumn;
    cxgUrls: TcxGridDBColumn;
    cxgUrlPrincipal: TcxGridDBColumn;
    cxgUrlLevel: TcxGridLevel;
    edtImgSit: TEditFocus;
    edtUrlDesc: TEditFocus;
    btnCanUrl: TBitBtnLocked;
    btnAdiUrl: TBitBtnLocked;
    shpEXPSIT: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPesoItExit(Sender: TObject);
    procedure edtExpAltExit(Sender: TObject);
    procedure edtExpLarExit(Sender: TObject);
    procedure edtExpProExit(Sender: TObject);
    procedure btnAdiUrlClick(Sender: TObject);
    procedure btnCanUrlClick(Sender: TObject);
    procedure cxgUrlViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgUrlPrincipalPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    strExportaB2B: String;
    strTabPreExp: String;
    FVlrLiq: Double;
    qryIteUrl: TUniQuery;
    dtsIteUrl: TDataSource;

    procedure pGravarPesoItCadIte(strCodIte: String; fltPesoIt: Double);
    procedure pGravarExpB2B(strCodIte, strExpB2B: String);
    procedure setVlrLiq (const Value: Double);
    procedure pAdicionaIteUrl;
    procedure pLimpaTelaIteURl;
    procedure DesabilitaShapeDiretoAcesso(Shape: TShape; edit: TDBEditFocus);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    qryCadIte: TUniQuery;
    qryDesSit: TUniQuery;
    dbePesoIt: TDBEditFocus;

    cdsIteUrl: TUniClientDataSet;
    dspIteUrl: TUniDataSetProvider;

    pOnValidouUltimoCampo: TGenericProcedure;

    function fValidarDadosECommerce: Boolean;
    procedure pCarregaUrlImagens(strCodIte : String);

    procedure pGravaIteURL(strCodIte: string);

    procedure pHabilitaEdicao(blnHabilita: Boolean);
    procedure pLimparCampos;
    procedure pCarregaDadosECommerce;
    procedure pGravaDadosECommerce;
    procedure pAtualizarPesoIt(fltPesoIt: Double);
    procedure pCriaClientUrlImagens;
	procedure pLimpaCdsUrl;
    Property  fltVlrLiq: Double Read FVlrLiq Write SetVlrLiq;

  end;

var
  frmPanelDadosECommerce: TfrmPanelDadosECommerce;

implementation

uses untFuncoesSimples, untPesqAux;

{$R *.dfm}

procedure TfrmPanelDadosECommerce.btnAdiUrlClick(Sender: TObject);
begin
  inherited;
  pAdicionaIteUrl;
end;

procedure TfrmPanelDadosECommerce.pAdicionaIteUrl;
Begin
  If (Not fEmptyStr(edtUrlDesc.Text)) And (Not fEmptyStr(edtImgSit.Text)) Then
  Begin
    If (cdsIteUrl.Locate('URL_ENDERE', edtImgSit.Text, [])) OR (cdsIteUrl.Locate('URL_DESCRI', edtUrlDesc.Text, [])) Then
      fMensagem('ATENÇÃO', 'Já existe URL ou DESCRIÇÃO cadastrada!', ['&Ok'])
    Else
    Begin
      cdsIteUrl.Append;
      If cdsIteUrl.RecordCount = 0 Then
        cdsIteUrl.fieldbyname('URL_PRINCI').AsString := '1'
      Else
        cdsIteUrl.fieldbyname('URL_PRINCI').AsString := '0';

      cdsIteUrl.fieldbyname('URL_CODITE').AsString := qryCadIte.fieldbyname('ITE_CODITE').AsString;
      cdsIteUrl.fieldbyname('URL_DESCRI').AsString := edtUrlDesc.Text;
      cdsIteUrl.fieldbyname('URL_ENDERE').AsString := edtImgSit.Text;
      cdsIteUrl.Post;

      pLimpaTelaIteURl;
    End;
  End;
End;

procedure TfrmPanelDadosECommerce.btnCanUrlClick(Sender: TObject);
begin
  inherited;
  pLimpaTelaIteURl;
end;

procedure TfrmPanelDadosECommerce.cxgUrlPrincipalPropertiesChange(
  Sender: TObject);
  var blnPrinci : Boolean;
      strDescri, strEndere : String;
Begin
  inherited;
  strDescri := cdsIteUrl.FieldByName('URL_DESCRI').AsString;
  strEndere := cdsIteUrl.FieldByName('URL_ENDERE').AsString;
  blnPrinci := cdsIteUrl.FieldByName('URL_PRINCI').AsInteger = 1;

  cdsIteUrl.DisableControls;

  If blnPrinci Then
  Begin
    cdsIteUrl.Filter := '(URL_PRINCI = 1) AND (URL_DESCRI <> ' + QuotedStr(strDescri) + ') AND (URL_ENDERE <> '+QuotedStr(strEndere) + ')';
    cdsIteUrl.Filtered := True;

    If Not cdsIteUrl.IsEmpty Then
    Begin
      cdsIteUrl.Edit;
      cdsIteUrl.FieldByName('URL_PRINCI').AsInteger := 0;
      cdsIteUrl.Post;
    End;

    cdsIteUrl.Filtered := False;
    cdsIteUrl.Locate('URL_DESCRI;URL_ENDERE', VarArrayOf([strDescri,strEndere]), []);
  End;

  cdsIteUrl.EnableControls;
end;

procedure TfrmPanelDadosECommerce.cxgUrlViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_DELETE: Begin
                  If (cdsIteUrl.RecordCount > 0) And ((qryCadIte.State In [dsEdit, dsInsert])) Then
                  Begin
                    cdsIteUrl.Delete;

                    If cdsIteUrl.IsEmpty Then
                       pSetFocus(edtUrlDesc);
                  End;
               End;
    VK_RETURN: Begin
                  If (qryCadIte.State In [dsEdit, dsInsert]) Then
                    pAdicionaIteUrl;
               End;
  End;
end;

procedure TfrmPanelDadosECommerce.DesabilitaShapeDiretoAcesso(Shape: TShape;
  edit: TDBEditFocus);
begin
  Shape.Brush.Color := clred;
  Shape.Pen.Color := clRed;
  Shape.ShowHint := True;
  edit.ReadOnly := True;
end;

Procedure TfrmPanelDadosECommerce.pLimpaTelaIteURl;
Begin
  edtUrlDesc.Clear;
  edtImgSit.Clear;

  pSetFocus(edtUrlDesc);
End;

procedure TfrmPanelDadosECommerce.edtPesoItExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtPesoIt.Text) Then
    edtPesoIt.Text := AnsiReplaceStr(edtPesoIt.Text, '.', '');

  If (Assigned(dbePesoIt)) Then
    If Not fEmptyStr(edtPesoIt.Text) Then
    Begin
      dbePesoIt.Field.Value := edtPesoIt.Text;
      edtPesoIt.Text := FormatFloat(edtPesoIt.EditFormat, dbePesoIt.Field.Value);
    End;
end;

procedure TfrmPanelDadosECommerce.edtExpAltExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtExpAlt.Text) Then
    edtExpAlt.Text := AnsiReplaceStr(edtExpAlt.Text, '.', '');
end;

procedure TfrmPanelDadosECommerce.edtExpLarExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtExpLar.Text) Then
    edtExpLar.Text := AnsiReplaceStr(edtExpLar.Text, '.', '');
end;

procedure TfrmPanelDadosECommerce.edtExpProExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtExpPro.Text) Then
    edtExpPro.Text := AnsiReplaceStr(edtExpPro.Text, '.', '');
end;

procedure TfrmPanelDadosECommerce.FormCreate(Sender: TObject);
begin
  inherited;

  If Not fVerificaAcessoSistema('EXPSIT', strLoginUsuarioLogado) Then
    DesabilitaShapeDiretoAcesso(shpEXPSIT,dbeExpSit);

  strExportaB2B := '';
  blnFecharComEscape := False;
  dbePesoIt := nil;

  pnlMOEXSI7.Visible := fCfgSis('MOEXSI', varInteger) = 7;

  strTabPreExp := fCfgSis('TBPECO', varString);

  if not fCfgSis('UTIPCD', varBoolean) then
  begin
    lblCroDoc.Visible := False;
    edtCroDoc.Visible := False;
    clbCroDoc.Visible := False;
  end;
end;

procedure TfrmPanelDadosECommerce.FormShow(Sender: TObject);
begin
  inherited;
  dtsCadIte.DataSet := qryCadIte;
end;

procedure TfrmPanelDadosECommerce.pGravaIteURL(strCodIte: string);
Var
  strSQL   : String;
  qryGen   : TUniQuery;
  strAutInc: String;
  strlAutInc: TStringList;

procedure pLimpaParametrosIteUrl;
Begin
  qryGen.ParamByName('CODITE').value := null;
  qryGen.ParamByName('DESCRI').value := null;
  qryGen.ParamByName('PRINCI').value := null;
  qryGen.ParamByName('ENDERE').value := null;
  qryGen.ParamByName('AUTINC').value := null;
End;

begin

  Try
    Try
      strlAutInc := TStringList.Create;
      qryGen := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' INSERT INTO ITEURL (';
      strSQL := strSQL + '   URL_CODITE, ';
      strSQL := strSQL + '   URL_DESCRI, ';
      strSQL := strSQL + '   URL_PRINCI, ';
      strSQL := strSQL + '   URL_ENDERE, ';
      strSQL := strSQL + '   AUTOINCREM) ';
      strSQL := strSQL + ' VALUES( ';
      strSQL := strSQL + '   :CODITE, ';
      strSQL := strSQL + '   :DESCRI, ';
      strSQL := strSQL + '   :PRINCI, ';
      strSQL := strSQL + '   :ENDERE, ';
      strSQL := strSQL + '   :AUTINC) ';

      cdsIteUrl.First;

      While Not cdsIteUrl.Eof Do
      Begin
        if not fEmptyStr(cdsIteUrl.FieldByName('AUTOINCREM').AsString) then
        begin
          if fEmptyStr(cdsIteUrl.FieldByName('URL_SEQIMG').AsString) or
            (not fEmptyStr(fCampoTabela('ITE_CODITE', 'ITEIMG', ['AUTOINCREM'], [cdsIteUrl.FieldByName('URL_SEQIMG').AsString], True))) then
          begin
            strlAutInc.Add(cdsIteUrl.FieldByName('AUTOINCREM').AsString);
          end;

          cdsIteUrl.Next;

          Continue;
        end;

        strAutInc := fRetAutoIncrem('ITEURL',VS_strCodEmp);

        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(strSQL);

        pLimpaParametrosIteUrl;

        qryGen.ParamByName('CODITE').AsString  := strCodIte;
        qryGen.ParamByName('DESCRI').AsString  := cdsIteUrl.FieldByName('URL_DESCRI').AsString;
        qryGen.ParamByName('PRINCI').AsInteger := cdsIteUrl.FieldByName('URL_PRINCI').AsInteger;
        qryGen.ParamByName('ENDERE').AsString  := cdsIteUrl.FieldByName('URL_ENDERE').AsString;
        qryGen.ParamByName('AUTINC').AsString  := strAutInc;
        qryGen.ExecSQL;

        strlAutInc.Add(strAutInc);

        cdsIteUrl.Next;
      End;

      If not cdsIteUrl.Locate('URL_PRINCI', 1, []) Then
      Begin
        strSQL := '';
        strSQL := strSQL + ' UPDATE ITEURL SET URL_PRINCI = 1 WHERE URL_CODITE = :CODITE ';
        strSQL := strSQL + ' LIMIT 1 ';

        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(strSQL);
        qryGen.ParamByName('CODITE').AsString := strCodIte;
        qryGen.ExecSQL;
      End;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ITEURL WHERE URL_CODITE = :CODITE';

      if strlAutInc.Count > 0 then
        strSQL := strSQL + ' AND AUTOINCREM NOT IN (' + fCommaText(strlAutInc, True) + ') ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.ExecSQL;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmPanelDadosECommerce.fGravaIteURL]');
      End;
    End;

  Finally
    FreeAndNil(qryGen);
    FreeAndNil(strlAutInc);
  End;
End;

function TfrmPanelDadosECommerce.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  {*************************************************}
  {* VALIDA OS CAMPOS QUE SÃO EXPORTADOS PARA SITE *}
  {**********************************************JU*}

  If Sender = edtExpAlt Then
  Begin
    If (dbeExpSit.Field.AsString = 'S') Or (dbeExpApp.Text = 'S') Then
    Begin
      If fEmptyStr(edtExpAlt.Text) Then
        edtExpAlt.Text := '0';

      If (fStrToFloat(AnsiReplaceStr(edtExpAlt.Text, '.', '')) < 0) Then
      Begin
        fMensagem('', 'O campo Altura deve ser maior ou igual a Zero quando o campo Exportação para Site ou Exportação APP Venda Assistida estiver Sim!', ['&Ok']);
        Result := False;
      End;
    End;
    If Result then
      SelectNext(edtExpLar, True, True);
  End

  Else If Sender = edtExpLar Then
  Begin
    If (dbeExpSit.Field.AsString = 'S') Or (dbeExpApp.Text = 'S') Then
    Begin
      If fEmptyStr(edtExpLar.Text) Then
        edtExpLar.Text := '0';

      If (fStrToFloat(AnsiReplaceStr(edtExpLar.Text, '.', '')) < 0) Then
      Begin
        fMensagem('', 'O campo Largura deve ser maior ou igual a Zero quando o campo Exportação para Site ou Exportação APP Venda Assistida estiver Sim!', ['&Ok']);
        Result := False;
      End;
    End;
    If Result then
      SelectNext(edtExpPro, True, True);
  End

  Else If Sender = edtExpPro Then
  Begin
    If (dbeExpSit.Field.AsString = 'S') Or (dbeExpApp.Text = 'S') Then
    Begin
      If fEmptyStr(edtExpPro.Text) Then
        edtExpPro.Text := '0';

      If (fStrToFloat(AnsiReplaceStr(edtExpPro.Text, '.', '')) < 0) Then
      Begin
        fMensagem('', 'O campo Profundidade deve ser maior ou igual a Zero quando o campo Exportação para Site ou Exportação APP Venda Assistida estiver Sim!', ['&Ok']);
        Result := False;
      End;
    End;
    If Result then
      SelectNext(edtPesoIt, True, True);
  End

  Else If (Sender = edtPesoIt) Then
  Begin
    If Not fEmptyStr(edtPesoIt.Text) Then
    Begin
      If Not fValidaEscala(AnsiReplaceStr(edtPesoIt.Text, '.', ''), 0, -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Peso do Item deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End;
    If Result then
      SelectNext(edtCodCat, True, True);
  End

  Else If (Sender = edtCodCat) Then
  Begin

  End

  Else If Sender = edtDestaq Then
  Begin
    If (dbeExpSit.Field.AsString = 'S') Or (dbeExpApp.Text = 'S') Then
    Begin
      If fEmptyStr(edtDestaq.Text) Then
      Begin
        fMensagem('', 'O campo Destaque deve ser preenchido quando o campo Exportação para Site ou Exportação APP Venda Assistida estiver Sim!', ['&Ok']);
        Result := False;
      End

      Else If Pos(edtDestaq.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Destaque deve ser S ou N!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If Sender = edtAtzPre Then
  Begin
    If (dbeExpSit.Field.AsString = 'S') Or (dbeExpApp.Text = 'S') Then
    Begin
      If fEmptyStr(edtAtzPre.Text) Then
      Begin
        fMensagem('', 'O campo "Atualiza preços no site" deve ser preenchido quando o campo Exportação para Site ou Exportação APP Venda Assistida estiver Sim!', ['&Ok']);
        Result := False;
      End

      Else If Pos(edtAtzPre.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Atualiza preços no site" ser S ou N!', ['&Ok']);
        Result := False;
      End;
    End;

    If Result And blnBuscaPorChave And Assigned(pOnValidouUltimoCampo) And (Not pnlMOEXSI7.Visible) Then
    Begin
      blnMudarFoco := False;
      pOnValidouUltimoCampo;
    End;

  End

  Else If Sender = edtExpB2B Then
  Begin
    If Pos(edtExpB2B.Text, 'SN') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Exporta para B2B deve ser S ou N!', ['&Ok']);
      Result := False;
    End;
  End

  {*****************************************}
  {* VALIDA dbeExpSit                      *}
  {**************************************MV*}
  Else If (Sender = dbeExpSit) Then
  Begin
    If Pos(dbeExpSit.Text, 'SN') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo exportação para o site deve ser S ou N!', ['&Ok']);
      Result := False;
    End
  End

  Else If ((Sender = edtCroDoc) and (edtCroDoc.Visible)) Then
  Begin
    If Pos(edtCroDoc.Text, 'SN') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo '+lblCroDoc.Caption+' deve ser S ou N!', ['&Ok']);
      pSetFocus(edtCroDoc);
      Result := False;
    End;

    If Result And blnBuscaPorChave And Assigned(pOnValidouUltimoCampo) And (Not pnlMOEXSI7.Visible) Then
    Begin
      blnMudarFoco := False;
      pOnValidouUltimoCampo;
    End;
  End

  {*****************************************}
  {* VALIDA dbeExpApp                      *}
  {**************************************MV*}
  Else If (Sender = dbeExpApp) Then
  Begin
    If Pos(dbeExpApp.Text, 'SN') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo exportação para App de Venda Assistida deve ser S ou N!', ['&Ok']);
      Result := False;
    End

    Else If (dbeExpSit.Text = 'N') And (dbeExpApp.Text = 'N') Then
    Begin
      If blnBuscaPorChave And Assigned(pOnValidouUltimoCampo) Then
      Begin
        blnMudarFoco := False;
        pOnValidouUltimoCampo;
      End;
    End;

  End

  Else If (Sender = edtDesSit) Then
  Begin

    If (pnlMOEXSI7.Visible) Then
    Begin

      If StrToFloatDef(edtDesSit.Text, 0) < 0 Then
      Begin
        pMensagemOk('O Desconto para Site deve ser maior ou igual a zero!');
        Result := False;
      End;

      If Result Then
        edtVlrLiq.Value := FVlrLiq - StrToFloatDef(edtDesSit.Text, 0);

      If Result And blnBuscaPorChave And Assigned(pOnValidouUltimoCampo) Then
      Begin
        blnMudarFoco := False;
        pOnValidouUltimoCampo;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

  If Result And blnMudarFoco Then
  Begin
    blnMudarFoco := False;
    SelectNext(Sender, True, True);
  End;

end;

function TfrmPanelDadosECommerce.fValidarDadosECommerce: Boolean;
begin
  Result := Self.fVerificaCampos;
end;

procedure TfrmPanelDadosECommerce.pLimparCampos;
begin
  edtExpAlt.Text := '0';
  edtExpLar.Text := '0';
  edtExpPro.Text := '0';
  edtDesSit.Text := '0';
  edtPesoIt.Text := '0';

  edtDestaq.Text  := 'N';
  edtExpB2B.Text  := 'S';
  edtCroDoc.Text:= 'N';

  edtImgSit.Clear;
  edtNomIte.Clear;
  edtCodCat.Clear;
  mmoAplIte.Clear;
  mmoDesSit.Lines.Clear;
  mmoDadTec.Lines.Clear;
  mmoIteIncluso.Lines.Clear;
  strExportaB2B := '';
end;

procedure TfrmPanelDadosECommerce.SetVlrLiq(const Value: Double);
begin
  FVlrLiq := Value;
end;

procedure TfrmPanelDadosECommerce.pAtualizarPesoIt(fltPesoIt: Double);
begin
  edtPesoIt.Text := FloatToStr(fltPesoIt);
end;

procedure TfrmPanelDadosECommerce.pCarregaDadosECommerce;
begin
  pPesquisaDesSit(qryDesSit, qryDesSit, qryCadIte.FieldbyName('ITE_CODITE').AsString);
  With qryDesSit Do
  Begin
    mmoDesSit.Texto      := FieldByName('ITE_DESITE').AsString;
    mmoDadTec.Texto      := FieldByName('ITE_DADTEC').AsString;
    edtNomIte.Text       := FieldByName('ITE_NOMITE').AsString;
    mmoAplIte.Texto      := FieldByName('ITE_APLITE').AsString;
    mmoIteIncluso.Texto  := FieldByName('ITE_INCLUS').AsString;
    edtExpAlt.Text       := FieldByName('ITE_EXPALT').AsString;
    edtExpLar.Text       := FieldByName('ITE_EXPLAR').AsString;
    edtExpPro.Text       := FieldByName('ITE_EXPPRO').AsString;
    edtDesSit.Text       := FieldByName('ITE_DESSIT').AsString;
    edtCodCat.Text       := FieldByName('ITE_CODCAT').AsString;
    edtDestaq.Text       := FieldByName('ITE_DESTAQ').AsString;
    edtAtzPre.Text       := FieldByName('ITE_ATZPRE').AsString;
    edtCroDoc.Text       := FieldByName('ITE_CRODOC').AsString;
    edtPesoIt.Text       := FormatFloat(fMskDigitos(4), qryCadIte.FieldbyName('ITE_PESOIT').AsFloat);
    edtVlrLiq.Value      := FVlrLiq - StrToFloatDef(edtDesSit.Text, 0);
    lblTabela.Caption    := strTabPreExp;

    TEditFocus(edtExpAlt).Alignment := TAlignment.taRightJustify;
    TEditFocus(edtExpLar).Alignment := TAlignment.taRightJustify;
    TEditFocus(edtExpPro).Alignment := TAlignment.taRightJustify;
    TEditFocus(edtPesoIt).Alignment := TAlignment.taRightJustify;

    If fEmptyStr(strExportaB2B) Then
      edtExpB2B.Text     := qryCadIte.FieldByName('ITE_EXPB2B').AsString
    Else
      edtExpB2B.Text     := strExportaB2B;

    If fEmptyStr(edtExpB2B.Text) Then
      edtExpB2B.Text := 'S';
  End;

  if fEmptyStr(edtAtzPre.Text) then
    edtAtzPre.Text := 'S';

  If not (qryCadIte.State In [dsEdit, dsInsert]) Then
    pCarregaUrlImagens(qryCadIte.FieldbyName('ITE_CODITE').AsString);

  pHabilitaEdicao(qryCadIte.State In [dsEdit, dsInsert]);
end;

procedure TfrmPanelDadosECommerce.pCarregaUrlImagens(strCodIte: String);
begin

  If not Assigned(cdsIteUrl) Then
    pCriaClientUrlImagens;

  qryIteUrl := fCriaQuery();

  Try
    qryIteUrl.Close;

    qryIteUrl.SQL.Clear;
    qryIteUrl.SQL.Add('SELECT * FROM ITEURL ');
    qryIteUrl.SQL.Add('WHERE URL_CODITE = :CODITE ');
    qryIteUrl.SQL.Add('ORDER BY AUTOINCREM ');

    qryIteUrl.ParamByName('CODITE').AsString := strCodIte;

    qryIteUrl.Open;

    pLimpaCdsUrl;

    If Not qryIteUrl.IsEmpty Then
    Begin

      qryIteUrl.First;

      While Not qryIteUrl.Eof Do
      Begin

        cdsIteUrl.Insert;
        cdsIteUrl.FieldByName('URL_CODITE').AsString  := qryIteUrl.fieldbyname('URL_CODITE').AsString;
        cdsIteUrl.FieldByName('URL_DESCRI').AsString  := qryIteUrl.fieldbyname('URL_DESCRI').AsString;
        cdsIteUrl.FieldByName('URL_PRINCI').AsInteger := qryIteUrl.fieldbyname('URL_PRINCI').AsInteger;
        cdsIteUrl.FieldByName('URL_ENDERE').AsString  := qryIteUrl.fieldbyname('URL_ENDERE').AsString;
        cdsIteUrl.FieldByName('AUTOINCREM').AsString  := qryIteUrl.fieldbyname('AUTOINCREM').AsString;
        cdsIteUrl.FieldByName('URL_SEQIMG').AsString  := qryIteUrl.fieldbyname('URL_SEQIMG').AsString;
        cdsIteUrl.Post;

        qryIteUrl.Next;
      End;

    End;

  Finally
    FreeAndNil(qryIteUrl);
  End;
End;

procedure TfrmPanelDadosECommerce.pLimpaCdsUrl;
Begin
  If Assigned(cdsIteUrl) Then
  Begin
    cdsIteUrl.First;

    While Not cdsIteUrl.Eof Do
      cdsIteUrl.Delete;
  End;
End;

procedure TfrmPanelDadosECommerce.pCriaClientUrlImagens;
begin
  If Assigned(cdsIteUrl) Then
    exit;

  cdsIteUrl := TUniClientDataSet.Create(Self);

  With cdsIteUrl.FieldDefs.AddFieldDef Do
  Begin
    Name := 'URL_CODITE';
    DataType := ftString;
    Size := 5;
  End;

  With cdsIteUrl.FieldDefs.AddFieldDef Do
  Begin
    Name := 'URL_DESCRI';
    DataType := ftString;
    Size := 100;
  End;

  With cdsIteUrl.FieldDefs.AddFieldDef Do
  Begin
    Name := 'URL_PRINCI';
    DataType := ftInteger;
  End;

  With cdsIteUrl.FieldDefs.AddFieldDef Do
  Begin
    Name := 'URL_ENDERE';
    DataType := ftString;
    Size := 255;
  End;

  With cdsIteUrl.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTOINCREM';
    DataType := ftString;
    Size := 255;
  End;

  With cdsIteUrl.FieldDefs.AddFieldDef Do
  Begin
    Name := 'URL_SEQIMG';
    DataType := ftString;
    Size := 255;
  End;

  cdsIteUrl.CreateDataSet;
  cdsIteUrl.IndexFieldNames := 'URL_DESCRI';
  dtsIteUrl := fCriaDataSource(cdsIteUrl);
  cxgUrlView.DataController.DataSource := dtsIteUrl;
end;

procedure TfrmPanelDadosECommerce.pHabilitaEdicao(blnHabilita: Boolean);
begin
  pnlDadosItem.Enabled := blnHabilita;
end;

procedure TfrmPanelDadosECommerce.pGravaDadosECommerce;
  Var
    strSQL: String;
    qryExp, qryIteURL: TUniQuery;
begin
  Try
    qryExp := fCriaQuery;
    qryIteURL := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM DESSIT WHERE ITE_CODITE = :CODITE ';
    With qryExp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := qryCadIte.fieldbyname('ITE_CODITE').AsString;
      Open;
      If IsEmpty Then
        Insert
      Else
        Edit;

      FieldByName('ITE_CODITE').AsString := qryCadIte.fieldbyname('ITE_CODITE').AsString;
      FieldByName('ITE_DESITE').AsString := mmoDesSit.Texto;
      FieldByName('ITE_NOMITE').AsString := edtNomIte.Text;
      FieldByName('ITE_APLITE').AsString := mmoAplIte.Texto;
      FieldByName('ITE_DADTEC').AsString := mmoDadTec.Texto;
      FieldByName('ITE_INCLUS').AsString := mmoIteIncluso.Texto;
      FieldByName('ITE_EXPALT').AsString := AnsiReplaceStr(edtExpAlt.Text, '.', '');
      FieldByName('ITE_EXPLAR').AsString := AnsiReplaceStr(edtExpLar.Text, '.', '');
      FieldByName('ITE_EXPPRO').AsString := AnsiReplaceStr(edtExpPro.Text, '.', '');
      FieldByName('ITE_DESSIT').AsString := edtDesSit.Text;

      If cdsIteUrl.Locate('URL_PRINCI', 1, []) Then
      Begin
        FieldByName('ITE_URLIMG').AsString := cdsIteUrl.FieldByName('URL_ENDERE').AsString;
        {FieldByName('ITE_DESITE').AsString := cdsIteUrl.FieldByName('URL_DESCRI').AsString;}
      End
      Else
      Begin
        qryIteURL.Close;
        qryIteURL.SQL.Add('SELECT URL_ENDERE, URL_DESCRI FROM ITEURL ');
        qryIteURL.SQL.Add('WHERE URL_CODITE = :CODITE AND URL_PRINCI = 1 ');
        qryIteURL.ParamByName('CODITE').AsString := qryCadIte.fieldbyname('ITE_CODITE').AsString;
        qryIteURL.Open;

        FieldByName('ITE_URLIMG').AsString := qryIteURL.FieldByName('URL_ENDERE').AsString;
        {FieldByName('ITE_DESITE').AsString := qryIteURL.FieldByName('URL_DESCRI').AsString;}
      End;

      FieldByName('ITE_CODCAT').AsString := edtCodCat.Text;

      If Not fEmptyStr(edtDestaq.Text) Then
        FieldByName('ITE_DESTAQ').AsString := edtDestaq.Text;

      if not fEmptyStr(edtAtzPre.Text) then
        FieldByName('ITE_ATZPRE').AsString := edtAtzPre.Text;

      FieldByName('ITE_CRODOC').AsString := edtCroDoc.Text;

      Post;

      If (Not Assigned(dbePesoIt)) And (StrToFloat(edtPesoIt.Text) <> qryCadIte.fieldbyname('ITE_PESOIT').AsFloat) Then
        pGravarPesoItCadIte(qryCadIte.fieldbyname('ITE_CODITE').AsString, StrToFloat(edtPesoIt.Text));

      If edtExpB2B.Text <> qryCadIte.fieldbyname('ITE_EXPB2B').AsString Then
        pGravarExpB2B(qryCadIte.fieldbyname('ITE_CODITE').AsString, edtExpB2B.Text);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadProdutos.pGravaExpSit]');
    End;
  End;

  FreeAndNil(qryExp);
   FreeAndNil(qryIteURL);
end;

procedure TfrmPanelDadosECommerce.pGravarPesoItCadIte(strCodIte: String; fltPesoIt: Double);
  Var
    strSQL: String;
    qryExp: TUniQuery;
begin
  Try
    qryExp := fCriaQuery();

    Try
      strSQL := 'UPDATE CADITE SET ITE_PESOIT = :PESOIT WHERE ITE_CODITE = :CODITE';

      With qryExp Do
      Begin
        Close();
        SQL.Clear();
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('PESOIT').AsFloat  := fltPesoIt;
        ExecSQL();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmPanelDadosECommerce.pGravarPesoItCadIte]');
    End;
  Finally
    FreeAndNil(qryExp);
  End;
end;

procedure TfrmPanelDadosECommerce.pGravarExpB2B(strCodIte, strExpB2B: String);
Var
  strSQL: String;
  qryExp: TUniQuery;
begin
  Try
    qryExp := fCriaQuery();

    Try
      strSQL := 'UPDATE CADITE SET ITE_EXPB2B = :EXPB2B WHERE ITE_CODITE = :CODITE';

      With qryExp Do
      Begin
        Close();
        SQL.Clear();
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('EXPB2B').AsString := strExpB2B;
        ExecSQL();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmPanelDadosECommerce.pGravarExpB2B]');
    End;
  Finally
    FreeAndNil(qryExp);
    strExportaB2B := strExpB2B;
  End;
end;

end.

