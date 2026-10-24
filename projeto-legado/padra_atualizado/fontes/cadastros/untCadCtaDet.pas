unit untCadCtaDet;

interface

uses
  Windows, Classes, Controls, Forms, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, EditFocus, DB, UniClientDataSet, untCtaDet, Uni, Mask, DBCtrls, untPai,
  BitBtnLockedIncrem, Math, Datasnap.DBClient, frxClass, System.Variants,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxLayoutContainer, dxLayoutControl,
  dxLayoutControlAdapters, dxLayoutLookAndFeels, DBEditFocus, MaskEditFocus,
  untFramePlanoDeContasMaskEdit, untFrameCentroCustoEditFocus,untPesqAux,
  untTypesSistema, untFuncoesConsulta;

type
  TfrmCadCtaDet = class(TfrmPai)
    edtPerCen: TEditFocus;
    cdsCtpDet: TUniClientDataSet;
    dtsCtpDet: TDataSource;
    cdsCtpDetEMPDET: TStringField;
    cdsCtpDetNOMEMP: TStringField;
    cdsCtpDetPERCEN: TFloatField;
    cdsCtpDetAGG_TOTPER: TAggregateField;
    btnConfirma: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    dbeTotPer: TDBEdit;
    dbgRateio: TDBGridCitel;
    cdsCtpDetCTADET: TStringField;
    cdsCtpDetNOMCTADET: TStringField;
    pnlFundo: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    pnlCentro: TPanel;
    pnlRodape: TPanel;
    pnlTopo: TPanel;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    pnlEmpresa: TPanel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    Label1: TLabel;
    pnlEvento: TPanel;
    chkEventos: TCheckBox;
    cdsCtpDetEVENTO: TStringField;
    cdsCtpDetCODEVE: TStringField;
    fraCentroCusto: TfraCentroCustoEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure dbgRateioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure chkEventosClick(Sender: TObject);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure dbgRateioDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtCodEmpExit(Sender: TObject);
  private
    { Private declarations }
    objListRateios: TCtaDetList;
    objListApagar: TCtaDetList;
    blnAlterando: Boolean;
    objRateio: TCtaDet;

    intCorZeb : Integer;
    arrEmp    : TConsultasArray;

    procedure pPreencheGrid;
    procedure pRateioAtual;
    procedure pCancelaRateioAtual;
    procedure pAtualizaCabecalho;
    procedure pDeletaRateio;

    function fAssigned: Boolean;
    function fVerificaCamposObrigatorios: Boolean;
    function fVerificaDuplicados: Boolean;
    function fValidaPercentuais: Boolean;

    procedure pCarregaEventos;
    procedure pMostraEventos(AMostrar : Boolean);
    function TemEvendoCadastrado: Boolean;
    procedure AtribuiObjRateio(ACodEmp: String);
    procedure pCriaObjRateio;


  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodCta: String;
  end;

implementation

uses SysUtils, untFuncoesSimples, untConstantes, untConsultas;

{$R *.dfm}

procedure TfrmCadCtaDet.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodEmp);
end;

procedure TfrmCadCtaDet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objListRateios);
  FreeAndnil(objListApagar);
end;

procedure TfrmCadCtaDet.FormCreate(Sender: TObject);
begin
  inherited;
  blnAlterando := False;
  cdsCtpDet.CreateDataSet;
  cdsCtpDet.IndexFieldNames := 'EMPDET;PERCEN;CODEVE';
end;

procedure TfrmCadCtaDet.pCriaObjRateio;
begin
  objRateio := TCtaDet.Create;
  objRateio.strCodCta := strCodCta;
  objRateio.strCodEmp := VS_strCodEmp;
end;

procedure TfrmCadCtaDet.pRateioAtual;
Var
  intIndex: Integer;

  procedure pCriaObjRateio;
  begin
    objRateio := TCtaDet.Create;
    objRateio.strCodCta := strCodCta;
    objRateio.strCodEmp := VS_strCodEmp;
  end;

begin
  If blnAlterando Then
  Begin
    intIndex := objListRateios.IndexOf(strCodCta,
                                       cdsCtpDet.FieldByName('EMPDET').AsString,
                                       cdsCtpDet.FieldByName('CTADET').AsString,
                                       cdsCtpDet.FieldByName('CODEVE').AsString);
    If intIndex >= 0 Then
      objRateio := objListRateios[intIndex]
    Else
      pCriaObjRateio;

  End
  Else
    pCriaObjRateio;
end;

procedure TfrmCadCtaDet.fraCentroCustoedtCodEveKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmCadCtaDet.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto: TConsultasArray;
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadCtaDet.TemEvendoCadastrado: Boolean;
  Var
    LRecNo : Integer;
begin
  Result := False;

  If Not Assigned(cdsCtpDet) Then Exit;
  If cdsCtpDet.IsEmpty Then Exit;

  cdsCtpDet.DisableControls;
  LRecNo := cdsCtpDet.RecNo;
  cdsCtpDet.First;

  While Not cdsCtpDet.Eof Do
  Begin
    If Not fEmptyStr(cdsCtpDet.FieldByName('CODEVE').AsString) Then
    Begin
      Result := True;
      Break;
    End;
    cdsCtpDet.Next;
  End;

  cdsCtpDet.RecNo := LRecNo ;
  cdsCtpDet.EnableControls;
end;

procedure TfrmCadCtaDet.AtribuiObjRateio(ACodEmp: String);
begin
  If (fAssigned) Then
  Begin
    If (fEmptyStr(edtCodEmp.Text)) Then
      objRateio.strEmpDet := NullAsStringValue
    Else
      objRateio.strEmpDet := ACodEmp;

    objRateio.strCodEve  := fraCentroCusto.edtCodEve.Text;

    If (fEmptyStr(fraPlanoDeContas.MskCodCta.Text)) Then
      objRateio.strCtaDet := NullAsStringValue
    Else
      objRateio.strCtaDet := fraPlanoDeContas.MskCodCta.Text;

    objRateio.fltPerCen := fStrToFloat(edtPerCen.Text);
  End;
end;

function TfrmCadCtaDet.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try
    If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := NullAsStringValue;
        SetLength(arrEmp, 1);
        arrEmp[0].strCodigo := NullAsStringValue;
        Result := True;
      End
      Else
      Begin
        If (fAssigned) Then
        Begin
          If (Length(arrEmp) = 1) Then
            objRateio.strEmpDet := edtCodEmp.Text;
        End;
      End;
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

      If Result And fAssigned Then
        objRateio.strCodEve  := fraCentroCusto.edtCodEve.Text;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    begin
      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fraPlanoDeContas.edtDesCta.Text := NullAsStringValue;
        objRateio.strCtaDet := NullAsStringValue;
        Result := True;
      End
      Else
      Begin
        If fAssigned Then
        begin
          objRateio.strCtaDet := fraPlanoDeContas.MskCodCta.Text;
          If fEmptyStr(objRateio.strNomCtaDet) Then
            Raise ExceptionAutCom.Create('Esse plano de conta não existe');
          fraPlanoDeContas.edtDesCta.Text := objRateio.strNomCtaDet;

          If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
            Result := False;
        end;
      end;
    end
    Else If (Sender = edtPerCen) Then
    Begin
      If fAssigned Then
        objRateio.fltPerCen := fStrToFloat(edtPerCen.Text);
      If Not InRange(fStrToFloat(edtPerCen.Text), 0.00, 100.00) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual deve ser um valor maior que 0 (zero) e menor ou igual a 100 (cem)', ['&OK']);
        Result := False;
      End;
    End;
  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('',E.Message,['&OK']);
      Result := False;
    End;
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadCtaDet.fValidaCampos]');
      Result := False;
    End;
  End;
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadCtaDet.pCancelaRateioAtual;
begin
  If (Not blnAlterando) And (objListRateios.IndexOf(objRateio) < 0) Then
    FreeAndNil(objRateio)
  Else
    objRateio := Nil;
end;

procedure TfrmCadCtaDet.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCadCtaDet.pPreencheGrid;
Var
  intContador: Integer;
begin
  cdsCtpDet.DisableControls;
  For intContador := 0 To objListRateios.Count -1 Do
  Begin
    cdsCtpDet.Append;
    cdsCtpDet.FieldByName('EMPDET').AsString := objListRateios[intContador].strEmpDet;
    cdsCtpDet.FieldByName('NOMEMP').AsString := fRetNomeEmpresa(objListRateios[intContador].strEmpDet);
    cdsCtpDet.FieldByName('CTADET').AsString := objListRateios[intContador].strCtaDet;
    cdsCtpDet.FieldByName('NOMCTADET').AsString := objListRateios[intContador].strNomCtaDet;
    cdsCtpDet.FieldByName('PERCEN').AsFloat  := objListRateios[intContador].fltPerCen;
    cdsCtpDet.FieldByName('CODEVE').AsString := objListRateios[intContador].strCodEve;
    cdsCtpDet.FieldByName('EVENTO').AsString := IIF(fEmptyStr(objListRateios[intContador].strCodEve),'',objListRateios[intContador].strCodEve + ' - ' + fRetNomEvento(objListRateios[intContador].strCodEve));
    cdsCtpDet.Post;
  End;
  If Not cdsCtpDet.IsEmpty Then
    cdsCtpDet.First;
  cdsCtpDet.EnableControls;
end;

procedure TfrmCadCtaDet.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pCancelaRateioAtual;
  edtCodEmp.Enabled := True;
  fraPlanoDeContas.MskCodCta.Enabled := True;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  fraCentroCusto.edtCodEve.Enabled := True;
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  fraPlanoDeContas.MskCodCta.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  edtPerCen.Text := '0,00';
  pSetFocus(edtCodEmp);
  blnAlterando := False;
  pRateioAtual;
  pMostraEventos(chkEventos.Checked);
end;

procedure TfrmCadCtaDet.FormShow(Sender: TObject);
begin
  inherited;
  objListRateios := TCtaDet.fRetornaRateios(strCodCta);
  objListApagar := TCtaDetList.Create;
  pPreencheGrid;
  pRateioAtual;

  chkEventos.Checked := fCfgSis('CTPOBE', varBoolean);
  chkEventos.Enabled := Not chkEventos.Checked;
  pMostraEventos(chkEventos.Checked);
  intCorZeb := fCfgSis('CORZEB', varInteger);
end;

function TfrmCadCtaDet.fAssigned: Boolean;
begin
  Result := Assigned(objRateio);
end;

function TfrmCadCtaDet.fVerificaCamposObrigatorios: Boolean;
begin
  result := True;
  If fEmptyStr(objRateio.strNomCtaDet) and fEmptyStr(objRateio.strNomEmp) Then
  begin
    result := False;
    fMensagem('ATENÇÃO!', 'O rateio deve ser vinculado a uma Empresa e/ou a um Plano de Contas!', ['&OK']);
    pSetFocus(edtCodEmp);
  end;
end;

function TfrmCadCtaDet.fVerificaDuplicados: Boolean;
begin
  if blnAlterando then
    exit(True);

  Result := objListRateios.IndexOf(strCodCta, objRateio.strEmpDet, objRateio.strCtaDet,objRateio.strCodEve) < 0;
  If not Result Then
  begin
    fMensagem('ATENÇÃO!', 'O rateio já foi vinculado com a Empresa e/ou o Plano de Contas selecionado e/ou o Centro de Custo!', ['&OK']);
    pSetFocus(edtCodEmp);
  end;
end;

procedure TfrmCadCtaDet.btnAdicionarClick(Sender: TObject);
  Var
    LRecNo  : Integer;
    LCntEmp : Integer;
begin
  inherited;
  LRecNo := 0;

  If Assigned(cdsCtpDet) And Not cdsCtpDet.IsEmpty Then
    LRecNo := cdsCtpDet.RecNo;

  If Not fVerificaCampos Then
    Exit;

  If not fVerificaCamposObrigatorios Then
    Exit;

  If not fVerificaDuplicados Then
    Exit;

  For LCntEmp := 0 To Length(arrEmp) - 1 Do
  Begin
    If (Not blnAlterando) Then
      pCriaObjRateio;

    AtribuiObjRateio(arrEmp[LCntEmp].strCodigo);

    If (blnAlterando) Then
      cdsCtpDet.Edit
    Else
      cdsCtpDet.Append;

    cdsCtpDet.FieldByName('EMPDET').AsString := arrEmp[LCntEmp].strCodigo;
    cdsCtpDet.FieldByName('NOMEMP').AsString := fRetNomeEmpresa(arrEmp[LCntEmp].strCodigo);

    cdsCtpDet.FieldByName('CODEVE').AsString := objRateio.strCodEve;
    cdsCtpDet.FieldByName('EVENTO').AsString := IIF(fEmptyStr(objRateio.strCodEve),'',objRateio.strCodEve + ' - ' + fRetNomEvento(objRateio.strCodEve));

    cdsCtpDet.FieldByName('PERCEN').AsFloat  := objRateio.fltPerCen;

    cdsCtpDet.FieldByName('CTADET').AsString := objRateio.strCtaDet;
    cdsCtpDet.FieldByName('NOMCTADET').AsString := objRateio.strNomCtaDet;

    cdsCtpDet.Post;

    If (Not blnAlterando) Then
      objListRateios.Add(objRateio);
  End;

  btnCancelaItem.Click;
  pRateioAtual;

  If LRecNo > 0 Then
    cdsCtpDet.RecNo := LRecNo;

end;

procedure TfrmCadCtaDet.dbgRateioDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If (Not TDBGridCitel(Sender).DataSource.DataSet.Active) Then
    Exit;

  If (TDBGridCitel(Sender).DataSource.DataSet.RecordCount <= 0) Then
    Exit;

  if Odd(TDBGridCitel(Sender).DataSource.DataSet.RecNo) Then
    TDBGridCitel(Sender).Canvas.Brush.Color := intCorZeb;

  TDBGridCitel(Sender).Canvas.FillRect(Rect);
  TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmCadCtaDet.dbgRateioKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    blnAlterando := True;
    pRateioAtual;
    pAtualizaCabecalho;
    edtCodEmp.Enabled := False;
    fraPlanoDeContas.MskCodCta.Enabled := False;
    fraCentroCusto.edtCodEve.Enabled := False;
    pSetFocus(edtPerCen);
  End
  Else If Key = VK_DELETE Then
  Begin
    pDeletaRateio;
  End
  Else If Key = VK_ESCAPE Then
  Begin
    btnCancelaItem.Click;
  End;
end;

procedure TfrmCadCtaDet.pAtualizaCabecalho;
begin
  If fAssigned Then
  Begin
    edtCodEmp.Text := objRateio.strEmpDet;
    SetLength(arrEmp, 1);
    arrEmp[0].strCodigo := objRateio.strEmpDet;
    edtNomEmp.Text := objRateio.strNomEmp;
    fraPlanoDeContas.MskCodCta.Text := objRateio.strCtaDet;
    fraPlanoDeContas.edtDesCta.Text := objRateio.strNomCtaDet;
    pMostraEventos(Not fEmptyStr(objRateio.strCodEve));
    fraCentroCusto.edtCodEve.Text := objRateio.strCodEve;
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(objRateio.strCodEve);
    edtPerCen.Text := FloatToStr(objRateio.fltPerCen);
  End;
end;

procedure TfrmCadCtaDet.btnConfirmaClick(Sender: TObject);
Var
  objRat: TCtaDet;
begin
  inherited;
  If Not fValidaPercentuais Then
    fMensagem('ATENÇÃO!', 'Os percentuais devem somar 100 (cem).', ['&Ok'])
  Else
  Begin
    Try
      fStartTransaction;
      for objRat in objListApagar do
        objRat.pDeletar;

      for objRat in objListRateios do
        objRat.pSalvar;

      fCommit;
      Close;
    Except
      On E: ExceptionAutCom Do
      Begin
        fRollBack;
				pMensagensErro(E.Message,'[TfrmCadCtaDet.btnConfirmaClick]');
      End;

      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadCtaDet.btnConfirmaClick]');
      End;
    End;
  End;
end;

procedure TfrmCadCtaDet.chkEventosClick(Sender: TObject);
begin
  inherited;
  pMostraEventos(chkEventos.Checked);
end;

function TfrmCadCtaDet.fValidaPercentuais: Boolean;
Var
  fltTotal: Double;

  function fLiberaTravaQuandoTodosExcluidos: Boolean;
  begin
    result := (cdsCtpDet.IsEmpty) and (fltTotal = 0.0);
  end;

  procedure pSomatotal;
  var
    intContador: Integer;
  begin
    fltTotal := 0.0;
    For intContador := 0 To objListRateios.Count -1 Do
      fltTotal := fltTotal + objListRateios[intContador].fltPerCen;
    fltTotal := fFormataFloat(fltTotal, 2);
  end;

begin
  pSomatotal;
  Result := (fltTotal = fFormataFloat(100.0, 2));
  If fLiberaTravaQuandoTodosExcluidos Then
    Result := True;
end;

procedure TfrmCadCtaDet.edtCodEmpExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa');
end;

procedure TfrmCadCtaDet.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCtaDet.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnConfirma.Click;
end;

procedure TfrmCadCtaDet.pDeletaRateio;
Var
  intIndex: Integer;
begin
  If objListRateios.Count > 0 Then
  Begin
    intIndex := objListRateios.IndexOf(strCodCta,
                                       cdsCtpDet.FieldByName('EMPDET').AsString,
                                       cdsCtpDet.FieldByName('CTADET').AsString,
                                       cdsCtpDet.FieldByName('CODEVE').AsString);
    If intIndex >= 0 Then
    Begin
      objListApagar.Add(TCtaDet.Create);
      objListApagar[objListApagar.Count - 1].strCodCta := objListRateios[intIndex].strCodCta;
      objListApagar[objListApagar.Count - 1].strEmpDet := objListRateios[intIndex].strEmpDet;
      objListApagar[objListApagar.Count - 1].strCtaDet := objListRateios[intIndex].strCtaDet;
      objListApagar[objListApagar.Count - 1].strCodEve := objListRateios[intIndex].strCodEve;

      objListRateios.Delete(intIndex);
      cdsCtpDet.Delete;
    End;
  End;
end;

procedure TfrmCadCtaDet.pMostraEventos(AMostrar: Boolean);
begin
  pnlEvento.Visible := AMostrar;
  pnlEvento.Top := IIF((pnlEvento.Top > pnlTopo.Top),pnlTopo.Top, pnlEvento.Top);
  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;
  dbgRateio.Columns[2].Visible := AMostrar Or (Not AMostrar And TemEvendoCadastrado);
end;


end.
