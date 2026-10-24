unit untManCentroCustoRateio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Uni, DB, UniClientDataSet,
  BitBtnLockedIncrem, Datasnap.DBClient, frxClass, frxExportCSVTestabilidade,
  untCtaDet, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, untTypesSistema,
  untFramePlanoDeContasMaskEdit, untFrameCentroCustoEditFocus,untPesqAux;

type
  TfrmManCentroCustoRateio = class(TfrmPai)
    pnlCabecalho: TPanel;
    dtsCentros: TDataSource;
    cdsCentros: TUniClientDataSet;
    cdsCentrosCODCTA: TStringField;
    cdsCentrosDESCTA: TStringField;
    btnConfirma: TBitBtnLocked;
    grdCentroCustoRateioDBTableView1: TcxGridDBTableView;
    grdCentroCustoRateioLevel1: TcxGridLevel;
    grdCentroCustoRateio: TcxGrid;
    grdCentroCustoRateioDBT_CODCTA: TcxGridDBColumn;
    grdCentroCustoRateioDBT_DESCTA: TcxGridDBColumn;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    pnlEvento: TPanel;
    PnlBtnCabe: TPanel;
    btnCancelar: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    fraCentroCusto: TfraCentroCustoEditFocus;
    chkEventos: TCheckBox;
    grdCentroCustoRateioDBT_EVENTO: TcxGridDBColumn;
    grdCentroCustoRateioDBT_CODEVE: TcxGridDBColumn;
    cdsCentrosEVENTO: TStringField;
    cdsCentrosCODEVE: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbgrdCentrosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure chkEventosClick(Sender: TObject);
    procedure grdCentroCustoRateioDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    arrCentroCusto: TConsultasArray;
    intCorZeb: Integer;
    procedure pDeletaCentro;
    procedure pMostraEventos(AMostrar: Boolean);
    procedure pCarregaEventos;
    function TemEvendoCadastrado: Boolean;
    procedure pDeletar(ACodCta: String);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untManCentroCustoEmpresas,
  untConstantes, untConsultas, untCadCta;

{$R *.dfm}

procedure TfrmManCentroCustoRateio.btnAdicionarClick(Sender: TObject);
Var
  I: Integer;
begin
  inherited;
  If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário informar um Plano de Contas!', ['&O k']);
    pSetFocus(fraPlanoDeContas.MskCodCta);
    Exit;
  End;

  If Not fVerificaCampos Then
  Begin
    pSetFocus(fraPlanoDeContas.MskCodCta);
    Exit;
  End;

  If Length(arrCentroCusto) > 1 Then
  Begin
    For I:=0 To Length(arrCentroCusto)-1 Do
    Begin
      If Not cdsCentros.Locate('CODCTA;CODEVE', VarArrayOf([arrCentroCusto[I].strCodigo,fraCentroCusto.edtCodEve.Text]), []) Then
      Begin
        cdsCentros.Append;
        cdsCentros.FieldByName('CODCTA').AsString := arrCentroCusto[I].strCodigo;
        cdsCentros.FieldByName('DESCTA').AsString := fRetNomeConta(arrCentroCusto[I].strCodigo);
        cdsCentros.FieldByName('CODEVE').AsString := fraCentroCusto.edtCodEve.Text;
        cdsCentros.FieldByName('EVENTO').AsString := IIF(fEmptyStr(fraCentroCusto.edtCodEve.Text),'',fraCentroCusto.edtCodEve.Text + ' - ' + fRetNomEvento(fraCentroCusto.edtCodEve.Text));
        cdsCentros.Post;
      End;
    End;
  End
  Else
  Begin
    If Not cdsCentros.Locate('CODCTA;CODEVE',VarArrayOf([fraPlanoDeContas.mskCodCta.Text,fraCentroCusto.edtCodEve.Text]), []) Then
    Begin
      cdsCentros.Append;
      cdsCentros.FieldByName('CODCTA').AsString := fraPlanoDeContas.MskCodCta.Text;
      cdsCentros.FieldByName('DESCTA').AsString := fraPlanoDeContas.edtDesCta.Text;
      cdsCentros.FieldByName('CODEVE').AsString := fraCentroCusto.edtCodEve.Text;
      cdsCentros.FieldByName('EVENTO').AsString := IIF(fEmptyStr(fraCentroCusto.edtCodEve.Text),'',fraCentroCusto.edtCodEve.Text + ' - ' + fRetNomEvento(fraCentroCusto.edtCodEve.Text));
      cdsCentros.Post;
    End;
  End;
  SetLength(arrCentroCusto, 0);

  btnCancelar.Click;
end;

procedure TfrmManCentroCustoRateio.btnCancelarClick(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.MskCodCta.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  pSetFocus(fraPlanoDeContas.MskCodCta);
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmManCentroCustoRateio.btnConfirmaClick(Sender: TObject);
var
  prcScroll: TprcScroll;
  objListRateios: TCtaDetList;
  intIndex: Integer;
  LCdsAux : TUniClientDataSet;
  LCount  : Integer;
  LCodCta  : String;

  procedure pExcluirRateiosExistentes;
  var
    nCont: Integer;
  begin
    for nCont := objListRateios.Count - 1 downto 0 do
    begin
      if not fEmptyStr(objListRateios[nCont].strCtaDet) then
      begin
        objListRateios[nCont].pDeletar;
        objListRateios.Delete(nCont);
      end;
    end;
  end;

begin
  inherited;
  If Not cdsCentros.Active Or cdsCentros.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um Plano de Contas!', ['&O k']);
    Exit;
  End;
  Try
    pCriarFormularios(TfrmManCentroCustoEmpresas, frmManCentroCustoEmpresas);
    frmManCentroCustoEmpresas.ShowModal;
    If (frmManCentroCustoEmpresas.ModalResult = mrOk) Then
    Begin
      Try
        pDisableControls(cdsCentros, prcScroll);
        fStartTransaction;

        LCdsAux :=  TUniClientDataSet.Create(Nil);
        LCdsAux.Data := cdsCentros.Data;

        cdsCentros.DisableControls;
        cdsCentros.IndexFieldNames := 'CODCTA';
        cdsCentros.First;

        While Not cdsCentros.Eof Do
        Begin

          If Not cdsCentros.FieldByName('CODCTA').AsString.Equals(LCodCta) Then
          Begin
            pDeletar(cdsCentros.FieldByName('CODCTA').AsString);
            LCodCta := cdsCentros.FieldByName('CODCTA').AsString;
          End;

          objListRateios := TCtaDet.fRetornaRateios(cdsCentros.FieldByName('CODCTA').AsString);
          try
            pExcluirRateiosExistentes;
            frmManCentroCustoEmpresas.cdsEmpresas.First;
            While Not frmManCentroCustoEmpresas.cdsEmpresas.Eof Do
            Begin
              intIndex := objListRateios.IndexOf(cdsCentros.FieldByName('CODCTA').AsString,
                                                 frmManCentroCustoEmpresas.cdsEmpresas.FieldByName('CODEMP').AsString,
                                                 NullAsStringValue,
                                                 cdsCentros.FieldByName('CODEVE').AsString);
              If intIndex < 0 Then
              begin
                objListRateios.Add(TCtaDet.Create);
                intIndex := objListRateios.Count - 1;
              end;

              objListRateios[intIndex].strCodCta := cdsCentros.FieldByName('CODCTA').AsString;
              objListRateios[intIndex].strEmpDet := frmManCentroCustoEmpresas.cdsEmpresas.FieldByName('CODEMP').AsString;
              objListRateios[intIndex].strCtaDet := NullAsStringValue;
              objListRateios[intIndex].strCodEmp := VS_strCodEmp;
              objListRateios[intIndex].strCodEve := cdsCentros.FieldByName('CODEVE').AsString;

              if frmManCentroCustoEmpresas.cdsEmpresas.FieldByName('PEREMP').AsFloat = 0 then
                objListRateios[intIndex].pDeletar
              else
              begin
                LCdsAux.Filtered := False;
                LCdsAux.Filter   := 'CODCTA = '+ QuotedStr(cdsCentros.FieldByName('CODCTA').AsString);
                LCdsAux.Filtered := True;

                LCount := LCdsAux.RecordCount;

                objListRateios[intIndex].fltPerCen := fFormataFloat((frmManCentroCustoEmpresas.cdsEmpresas.FieldByName('PEREMP').AsFloat/LCount),4);
                objListRateios[intIndex].pSalvar;
              end;
              frmManCentroCustoEmpresas.cdsEmpresas.Next;
            End;
          finally
            objListRateios.Free;
          end;
          cdsCentros.Next;
        End;
        fCommit;
        fMensagem('ATENÇÃO!', 'Rateios gravados com sucesso!', ['&O k']);
        pEnableControls(cdsCentros, prcScroll);
        cdsCentros.EnableControls;
        cdsCentros.EmptyDataSet;
        btnCancelar.Click;
      Except
        On E: ExceptionAutCom Do
        Begin
          fRollBack;
          pEnableControls(cdsCentros, prcScroll);
          pMensagensErro(E.Message,'');
        End;

        On E: Exception Do
        Begin
          fRollBack;
          pEnableControls(cdsCentros, prcScroll);
          pMensagensErro(E.Message, '');
        End;
      End;
    End;
    pFreeAndNil(frmManCentroCustoEmpresas);
  Except
    On E: Exception Do
    Begin
      pEnableControls(cdsCentros, prcScroll);
      pMensagensErro(E.Message, '');
      Exit;
    End;
  End;
end;

procedure TfrmManCentroCustoRateio.chkEventosClick(Sender: TObject);
begin
  inherited;
  pMostraEventos(chkEventos.Checked);
end;

procedure TfrmManCentroCustoRateio.dbgrdCentrosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    pDeletaCentro;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnCancelar.Click;
  End;
end;

procedure TfrmManCentroCustoRateio.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCentros.CreateDataSet;
end;

procedure TfrmManCentroCustoRateio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnConfirma.Click;
end;

procedure TfrmManCentroCustoRateio.FormShow(Sender: TObject);
begin
  inherited;
  chkEventos.Checked := fCfgSis('CTPOBE', varBoolean);
  chkEventos.Enabled := Not chkEventos.Checked;
  pMostraEventos(chkEventos.Checked);
  intCorZeb := fCfgSis('CORZEB', varInteger);
end;

procedure TfrmManCentroCustoRateio.fraCentroCustoedtCodEveKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, Nil, Key, arrEvento) Then
  Begin
    If fValidaCampos(fraCentroCusto.edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;


procedure TfrmManCentroCustoRateio.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************RV*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, False) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmManCentroCustoRateio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) And (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano de Contas não permitido!', ['&O k']);
        Result := False;
      End
      Else If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        If (fraPlanoDeContas.edtDesCta.Text<>'+1') Then
        Begin
          fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fraPlanoDeContas.MskCodCta.Text);
          If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
            Result := False;
        End;
      End
      Else
        btnCancelar.Click;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If (Sender = fraCentroCusto.edtCodEve) And (pnlEvento.Visible) And fraCentroCusto.edtCodEve.Enabled Then
    Begin

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        pCarregaEventos;
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&O k']);
          fraCentroCusto.edtDesEve.Clear;
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custo pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End
        Else If fVerificaEventoCfgContabil(fraCentroCusto.edtCodEve.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse centro de custo não pode ser aplicado no rateio, ' +#13+#10+
                               'pois está configurado na lista de eventos que não serão exportados para a contabilidade!',['&OK']);
          Result := False;
        End;
      End
      Else
        fraCentroCusto.edtDesEve.Clear;

      {If Not Result Then
        btnCancelar.Click;}

    End;

  End;
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmManCentroCustoRateio.grdCentroCustoRateioDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (not AViewInfo.Selected) Then
  Begin
    If Odd(AViewInfo.GridRecord.Index) Then
      ACanvas.Brush.Color := intCorZeb
    Else
      ACanvas.Brush.Color := clWindow;
  End;
end;

procedure TfrmManCentroCustoRateio.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmManCentroCustoRateio.pDeletaCentro;
begin
  If cdsCentros.Active And (Not cdsCentros.IsEmpty) Then
    cdsCentros.Delete;
end;

procedure TfrmManCentroCustoRateio.pDeletar(ACodCta: String);
  Var
    qryIns: TUniQuery;
begin
  qryIns := fCriaQuery(Self);
  qryIns.SQL.Add('DELETE FROM ');
  qryIns.SQL.Add('  CTADET ');
  qryIns.SQL.Add('WHERE ');
  qryIns.SQL.Add('  CTA_CODCTA = :CODCTA  ');
  qryIns.ParamByName('CODCTA').AsString := ACodCta;
  qryIns.ExecSQL;
  FreeAndNil(qryIns);
end;


procedure TfrmManCentroCustoRateio.pMostraEventos(AMostrar: Boolean);
begin
  pnlEvento.Visible := AMostrar;
  pnlEvento.Top := IIF((pnlEvento.Top > PnlBtnCabe.Top),PnlBtnCabe.Top, pnlEvento.Top);
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  grdCentroCustoRateioDBT_EVENTO.Visible :=  AMostrar Or (Not AMostrar And TemEvendoCadastrado);
end;

function TfrmManCentroCustoRateio.TemEvendoCadastrado: Boolean;
  Var
    LRecNo : Integer;
begin
  Result := False;

  If Not Assigned(cdsCentros) Then Exit;
  If cdsCentros.IsEmpty Then Exit;

  cdsCentros.DisableControls;
  LRecNo := cdsCentros.RecNo;
  cdsCentros.First;

  While Not cdsCentros.Eof Do
  Begin
    If Not fEmptyStr(cdsCentros.FieldByName('CODEVE').AsString) Then
    Begin
      Result := True;
      Break;
    End;
    cdsCentros.Next;
  End;

  cdsCentros.RecNo := LRecNo ;
  cdsCentros.EnableControls;
end;


end.
