unit untRelEtiqQtdRestante;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, BitBtnLockedIncrem, Buttons,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxCheckBox, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, UniDataSetProvider, UniClientDataSet, Uni,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxExportCSVTestabilidade, untIFuncoes,
  DbEditFocus, untClassPanelCx, untFuncoesRelatorios,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRelEtiqQtdRestante = class(TfrmPaiRelatorio)
    Label2: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    lblQuantidade: TLabel;
    edtQtdIte: TEditFocus;
    Label1: TLabel;
    edtQtdEti: TEditFocus;
    edtCodCon: TEditFocus;
    edtNomCon: TEditFocus;
    Label3: TLabel;
    cxgEmbala: TcxGrid;
    cxgEmbalaView: TcxGridDBTableView;
    cxgEmbalaCodBar: TcxGridDBColumn;
    cxgEmbalaEmbala: TcxGridDBColumn;
    cxgEmbalaPrinci: TcxGridDBColumn;
    cxgEmbalaCompra: TcxGridDBColumn;
    cxgEmbalaExbFat: TcxGridDBColumn;
    cxgEmbalaLevel1: TcxGridLevel;
    edtNomCli: TEditFocus;
    lbl1: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblCodEmp: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    lbl2: TLabel;
    lbl3: TLabel;
    edtCodCli: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodConKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    qryEmbala: TUniQuery;
    dtsEmbala: TDataSource;
    procedure pImprimeEtiqueta(strCodIte, strCodCon: String; fltQtdIte: Double; intQtdEti: Integer);
    procedure pCarregaEmbalagem;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses untFuncoesSimples, untConstantes, untTypesSistema, untIIteBar, untConsultas,
     untIteBar, untFuncoesEtiqItens;
{$R *.dfm}

procedure TfrmRelEtiqQtdRestante.btnImprimirClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    pImprimeEtiqueta(edtCodIte.Text,
                     edtCodCon.Text,
                     fStrToFloat(edtQtdIte.Text),
                     StrToIntDef(edtQtdEti.Text, 1));
    pCarregaEmbalagem;
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmRelEtiqQtdRestante.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);

  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEtiqQtdRestante.edtCodConKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtCodCon, edtNomCon, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodCon, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEtiqQtdRestante.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEtiqQtdRestante.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEtiqQtdRestante.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
end;

procedure TfrmRelEtiqQtdRestante.FormCreate(Sender: TObject);
begin
  inherited;
  strFilRel := ETIQUETA_UNIDADES_RESTANTE;
  pSetaCodIte(edtCodIte);
  qryEmbala := fCriaQuery;
  With qryEmbala.SQL Do
  Begin
    Add('SELECT');
    Add('  *');
    Add('FROM');
    Add('  ITEBAR');
    Add('WHERE');
    Add('  BAR_CODITE = :CODITE');
    Add('ORDER BY');
    Add('  BAR_CODBAR');
  End;
  
  dtsEmbala := TDataSource.Create(Nil);
  dtsEmbala.Dataset := qryEmbala;

  cxgEmbalaView.DataController.DataSource := dtsEmbala;

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

procedure TfrmRelEtiqQtdRestante.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryEmbala);
  FreeAndNil(dtsEmbala);
end;

function TfrmRelEtiqQtdRestante.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        pMensagemOk('Informe o código do produto!');
        Result := False;
      End Else
      Begin
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

        If fEmptyStr(edtDesIte.Text) Then
        Begin
          pMensagemOk('Produto não econtrado!');
          Result := False;
        End
        Else
          pCarregaEmbalagem;
      End;

    End

    Else If (Sender = edtCodCon) Then
    Begin

      If fEmptyStr(edtCodCon.Text) Then
      Begin
        pMensagemOk('Informe o código do Conferente!');
        Result := False;
      End Else
      Begin
        edtNomCon.Text := fRetNomeOperador(edtCodCon.Text);

        If fEmptyStr(edtNomCon.Text) Then
        Begin
          pMensagemOk('Conferente não encontrado!');
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtQtdIte) Then
    Begin

      If fStrToFloat(edtQtdIte.Text) <= 0 Then
      Begin
        pMensagemOk('A quantidade do produto deve ser maior que zero!');
        Result := False;
      End;

    End

    Else If (Sender = edtQtdEti) Then
    Begin

      If StrToIntDef(edtQtdEti.Text, 0) < 1 Then
      Begin
        pMensagemOk('A quantidade de etiquetas deve ser maior ou igual a 1!');
        Result := False;
      End;

    End

    {********************}
    {* VALIDA A CLIENTE *}
    {*****************MA*}

    Else If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('','Cliente não cadastrado!', ['&Ok']);
          Result := False;
        End
      End
      Else edtNomCli.Text := '';
    End

    {********************}
    {* VALIDA A EMPRESA *}
    {*****************MA*}
    Else If (Sender = edtCodEmp) Then
    Begin
      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Essa Empresa não está cadastrada!',['&O k']);
          Result := False;
        End;
      End
      Else
        edtNomEmp.Text := '';
    End;

  End;



  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelEtiqQtdRestante.pCarregaEmbalagem;
begin
  With qryEmbala, SQL Do
  Begin
    Close;
    ParamByName('CODITE').AsString := edtCodIte.Text;
    Open;
  End;
end;

procedure TfrmRelEtiqQtdRestante.pImprimeEtiqueta(strCodIte, strCodCon: String;
  fltQtdIte: Double; intQtdEti: Integer);
  Var
    objIteBar: IIteBar;
    arrIteEti: TArrItensEtiqUnRestante;
Begin
  SetLength(arrIteEti, 1);
  arrIteEti[0].strCodItem := strCodIte;
  arrIteEti[0].fltQtdItem := fltQtdIte;

  objIteBar := TIteBar.Create;//fGetTIteBar;
  objIteBar.pImprimeEtiquetaUnidadesRestante(arrIteEti,
                                             opcAvulsa,
                                             edtNumDoc.Text,
                                             edtEspDoc.Text,
                                             edtCodEmp.Text,
                                             strCodCon,
                                             intQtdEti,
                                             edtDestino.Text = 'I',
                                             True,
                                             edtCodCli.Text);
End;

end.
