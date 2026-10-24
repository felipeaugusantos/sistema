unit untCadComFaiFatDepVenPro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, EditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  untConsultas, untTypesSistema, untComissaoFaixaFatDeptoVendProdEntity,
  untComissaoFaixaFatDeptoVendProdController, untFuncoesSimples, cxContainer,
  cxProgressBar, untGravando;

type
  TfrmCadComFaiFatDepVenPro = class(TfrmPai)
    pnlFaixaComissao: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtCodFFD: TEditFocus;
    edtDesFFD: TEditFocus;
    edtMarIni: TEditFocus;
    edtFatIni: TEditFocus;
    edtMarFin: TEditFocus;
    edtFatFin: TEditFocus;
    pnlDeptos: TPanel;
    pnlAddDepto: TPanel;
    Label7: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    edtDepVen: TEditFocus;
    edtDesVen: TEditFocus;
    edtDepPro: TEditFocus;
    edtDesPro: TEditFocus;
    edtPerCom: TEditFocus;
    edtPerBon: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    grdDeptos: TcxGrid;
    grdDeptosDBTableView1: TcxGridDBTableView;
    grdDeptosLevel1: TcxGridLevel;
    cdsDeptos: TUniClientDataSet;
    cdsDeptosAUTOINCREM: TStringField;
    cdsDeptosDEPVEN: TStringField;
    cdsDeptosDEPPRO: TStringField;
    cdsDeptosPERCOM: TFloatField;
    cdsDeptosPERBON: TFloatField;
    cdsDeptosDVENDS: TStringField;
    cdsDeptosDPRODS: TStringField;
    dsDeptos: TDataSource;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    grdDeptosDBTableView1PERCOM: TcxGridDBColumn;
    grdDeptosDBTableView1PERBON: TcxGridDBColumn;
    grdDeptosDBTableView1DVENDS: TcxGridDBColumn;
    grdDeptosDBTableView1DPRODS: TcxGridDBColumn;
    grdDeptosDBTableView1DEPVEN: TcxGridDBColumn;
    grdDeptosDBTableView1DEPPRO: TcxGridDBColumn;
    procedure cdsDeptosCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure edtDepVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtDepProKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure grdDeptosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdDeptosDBTableView1DblClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtDepVenExit(Sender: TObject);
    procedure edtDepProExit(Sender: TObject);
    procedure edtCodFFDExit(Sender: TObject);
  private
    objComissaoCtrl : TComissaoFaixaFatDeptoVendProdController;
    objComissao     : TComissaoFaixaFatDeptoVendProdEntity;

    arrDepVen: TConsultasArray;
    arrDepPro: TConsultasArray;
    arrComFai: TConsultasArray;

    strMskDigitos : String;
    blnIncluindoOuAlterando : Boolean;

    stlDeptos : TStringList;

    procedure pIniciarInclusao();
    procedure pLiberarTela(blnLiberar : Boolean);
    procedure pLimpaDepto();
    function fAdicionaItem(strDepVen, strDepPro : String; fltPerCom, fltPerBon : Double):Boolean;
    procedure pEditaItem();
    procedure pRemoveItem();
    procedure pGravar();
    procedure pCarregarDados();
    function fValidarCampos():Boolean;
    procedure pAdicionaDeptos();
    function fValidaItem(strDepVen, strDepPro : String; fltPerCom : Double):Boolean;
    function fAdicionaTodosDeptos(strDepVen, strDepPro : String; fltPerCom, fltPerBon : Double):Boolean;

  public
    class procedure pCadastrarFaixaComissao(); static;
  end;

implementation

{$R *.dfm}

{ TfrmCadComFaiFatDepVenPro }

procedure TfrmCadComFaiFatDepVenPro.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(Trim(edtDepVen.Text))) Or (fEmptyStr(Trim(edtDepPro.Text))) Then
  Begin
    fExecutarModal(pAdicionaDeptos, 'Inserindo todos os departamentos. Por favor aguarde...', '');
  End
  Else
  Begin
    If (fValidaItem(Trim(edtDepVen.Text), Trim(edtDepPro.Text), StrToFloatDef(edtPerCom.Text, 0))) Then
    Begin
      If fAdicionaItem(Trim(edtDepVen.Text), Trim(edtDepPro.Text), StrToFloatDef(edtPerCom.Text, 0), StrToFloatDef(edtPerBon.Text, 0)) Then
      Begin
        pLimpaDepto();
        pSetFocus(edtDepVen);
      End;
    End;
  End;
end;

procedure TfrmCadComFaiFatDepVenPro.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pLiberarTela(True);

  pSetFocus(edtDesFFD);
end;

procedure TfrmCadComFaiFatDepVenPro.btnCancelaClick(Sender: TObject);
begin
  inherited;

  If blnIncluindoOuAlterando Then
    If fMensagem('Atenção!', 'Cancelar edição do registro atual?', ['&Sim', '&Não']) = 1 Then
      fExecutarModal(pCarregarDados, 'Carregando registros. Por favor aguarde...', '');
end;

procedure TfrmCadComFaiFatDepVenPro.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If fMensagem('Atenção!', 'Deseja realmente excluir?', ['&Sim', '&Não']) = 1 Then
  Begin
    objComissaoCtrl.pExcluir(objComissao.strAutInc);
    pIniciarInclusao;
    fExecutarModal(pCarregarDados, 'Carregando registros. Por favor aguarde...', '');
  End;

end;

procedure TfrmCadComFaiFatDepVenPro.btnGravarClick(Sender: TObject);
begin
  inherited;

  fExecutarModal(pGravar, 'Gravando registros. Por favor aguarde...', '');
end;

procedure TfrmCadComFaiFatDepVenPro.pCarregarDados();
Var
  intIndex : Integer;
begin
  edtCodFFD.Text := objComissao.strCodFFD;
  edtDesFFD.Text := objComissao.strDesFFD;

  edtMarIni.Text := FormatFloat(strMskDigitos, objComissao.fltMarIni);
  edtMarFin.Text := FormatFloat(strMskDigitos, objComissao.fltMarFin);

  edtFatIni.Text := FormatFloat(strMskDigitos, objComissao.fltFatIni);
  edtFatFin.Text := FormatFloat(strMskDigitos, objComissao.fltFatFin);

  Try
    cdsDeptos.DisableControls;
    cdsDeptos.EmptyDataSet;

    For intIndex := 0 To Pred(objComissao.lstItens.Count) Do
    Begin
      cdsDeptos.Append;
      cdsDeptos.FieldByName('AUTOINCREM').AsString := objComissao.lstItens[intIndex].strAutInc;
      cdsDeptos.FieldByName('DEPVEN').AsString     := objComissao.lstItens[intIndex].strDepVen;
      cdsDeptos.FieldByName('DEPPRO').AsString     := objComissao.lstItens[intIndex].strDepPro;
      cdsDeptos.FieldByName('PERCOM').AsFloat      := objComissao.lstItens[intIndex].fltPerCom;
      cdsDeptos.FieldByName('PERBON').AsFloat      := objComissao.lstItens[intIndex].fltPerBon;
      cdsDeptos.Post;

      Application.ProcessMessages;
    End;
  Finally
    cdsDeptos.First;
    cdsDeptos.EnableControls;
  End;

  pLiberarTela(False);
end;

procedure TfrmCadComFaiFatDepVenPro.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pIniciarInclusao;
  fExecutarModal(pCarregarDados, 'Carregando registros. Por favor aguarde...', '');
  pLiberarTela(True);

  pSetFocus(edtCodFFD);
end;

procedure TfrmCadComFaiFatDepVenPro.btnPesquisaClick(Sender: TObject);
Var
  Key : Char;
  objCommisaoBusca : TComissaoFaixaFatDeptoVendProdEntity;
begin
  inherited;

  Key := '?';

  If fPesqComissaoFaixaFatDepVenPro(Self, Nil, Nil, Nil, Key, arrComFai, True) Then
  Begin
    objCommisaoBusca := objComissaoCtrl.fCarregar(objComissaoCtrl.fRetornaAutInc(arrComFai[0].strCodigo));

    If Assigned(objCommisaoBusca) Then
    Begin
      FreeAndNil(objComissao);
      objComissao := objCommisaoBusca;

      fExecutarModal(pCarregarDados, 'Carregando registros. Por favor aguarde...', '');
    End;
  End;
end;

procedure TfrmCadComFaiFatDepVenPro.btnSairClick(Sender: TObject);
begin
  inherited;

  If blnIncluindoOuAlterando Then
  Begin
    If fMensagem('Atenção!', 'Cancelar edição do registro atual?', ['&Sim', '&Não']) = 1 Then
      fExecutarModal(pCarregarDados, 'Carregando registros. Por favor aguarde...', '');
  End;
end;

procedure TfrmCadComFaiFatDepVenPro.cdsDeptosCalcFields(DataSet: TDataSet);
begin
  inherited;

  cdsDeptos.FieldByName('DVENDS').AsString := objComissaoCtrl.fRetornaDescricaoDepto(cdsDeptos.FieldByName('DEPVEN').AsString);
  cdsDeptos.FieldByName('DPRODS').AsString := objComissaoCtrl.fRetornaDescricaoDepto(cdsDeptos.FieldByName('DEPPRO').AsString);
end;

procedure TfrmCadComFaiFatDepVenPro.edtCodFFDExit(Sender: TObject);
Var
  objCommisaoBusca : TComissaoFaixaFatDeptoVendProdEntity;
begin
  inherited;

  If (Not fEmptyStr(edtCodFFD.Text)) Then
  Begin
    If (Not objComissao.fFoiCarregado) And (objComissaoCtrl.fCodFFDExiste(edtCodFFD.Text)) Then
    Begin
      objCommisaoBusca := objComissaoCtrl.fCarregar(objComissaoCtrl.fRetornaAutInc(edtCodFFD.Text));

      If Assigned(objCommisaoBusca) Then
      Begin
        FreeAndNil(objComissao);
        objComissao := objCommisaoBusca;

        fExecutarModal(pCarregarDados, 'Carregando registros. Por favor aguarde...', '');
        pLiberarTela(True);
        pSetFocus(edtDesFFD);
      End;
    End;
  End;
end;

procedure TfrmCadComFaiFatDepVenPro.edtDepProExit(Sender: TObject);
begin
  inherited;
  edtDesPro.Text := objComissaoCtrl.fRetornaDescricaoDepto(edtDepPro.Text);
end;

procedure TfrmCadComFaiFatDepVenPro.edtDepProKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fEntraCons(Key) Then
    fPesqDepartamento(Self, edtDepPro, edtDesPro, Nil, Key, arrDepPro, True);
end;

procedure TfrmCadComFaiFatDepVenPro.edtDepVenExit(Sender: TObject);
begin
  inherited;
  edtDesVen.Text := objComissaoCtrl.fRetornaDescricaoDepto(edtDepVen.Text);
end;

procedure TfrmCadComFaiFatDepVenPro.edtDepVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fEntraCons(Key) Then
    fPesqDepartamento(Self, edtDepVen, edtDesVen, Nil, Key, arrDepVen, True);
end;

procedure TfrmCadComFaiFatDepVenPro.pAdicionaDeptos();
begin
  If fAdicionaTodosDeptos(Trim(edtDepVen.Text), Trim(edtDepPro.Text), StrToFloatDef(edtPerCom.Text, 0), StrToFloatDef(edtPerBon.Text, 0)) Then
  Begin
    pLimpaDepto();
    pSetFocus(edtDepVen);
  End;
end;

procedure TfrmCadComFaiFatDepVenPro.FormCreate(Sender: TObject);
begin
  inherited;

  objComissaoCtrl := TComissaoFaixaFatDeptoVendProdController.Create;
  objComissao     := TComissaoFaixaFatDeptoVendProdEntity.Create;

  pLiberarTela(False);

  cdsDeptos.CreateDataSet;

  strMskDigitos := fMskDigitos(3, False);

  stlDeptos := objComissaoCtrl.fRetornaTodosDeptos();
end;

procedure TfrmCadComFaiFatDepVenPro.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objComissaoCtrl);
  FreeAndNil(objComissao);
  FreeAndNil(stlDeptos);
end;

function TfrmCadComFaiFatDepVenPro.fValidaItem(strDepVen, strDepPro: String; fltPerCom: Double): Boolean;
begin
  Result := True;

  If fEmptyStr(strDepVen) Then
  Begin
    fMensagem('Atenção!', 'Informe o departamento do vendedor!', ['&OK']);
    pSetFocus(edtDepVen);
    Exit(False);
  End;

  If fEmptyStr(strDepPro) Then
  Begin
    fMensagem('Atenção!', 'Informe o departamento do produto!', ['&OK']);
    pSetFocus(edtDepPro);
    Exit(False);
  End;

  If (fltPerCom = 0) Then
  Begin
    fMensagem('Atenção!', 'Informe o percentual de comissão!', ['&OK']);
    pSetFocus(edtPerCom);
    Exit(False);
  End;

  If (Not objComissaoCtrl.fDeptoExiste(strDepVen)) Then
  Begin
    fMensagem('Atenção!', 'Departamento do vendedor "' + strDepVen + '" não existe.', ['&OK']);
    pSetFocus(edtDepVen);
    Exit(False);
  End;

  If (Not objComissaoCtrl.fDeptoExiste(strDepPro)) Then
  Begin
    fMensagem('Atenção!', 'Departamento do produto "' + strDepPro + '" não existe.', ['&OK']);
    pSetFocus(edtDepPro);
    Exit(False);
  End;
end;

function TfrmCadComFaiFatDepVenPro.fValidarCampos: Boolean;
begin
  Result := True;

  If (fEmptyStr(edtCodFFD.Text)) Then
  Begin
    fMensagem('Atenção!', 'Informe um código válido.', ['&OK']);
    Exit(False);
  End;

  If (fEmptyStr(edtDesFFD.Text)) Then
  Begin
    fMensagem('Atenção!', 'Informe uma descrição válida.', ['&OK']);
    Exit(False);
  End;

  If (cdsDeptos.IsEmpty) Then
  Begin
    fMensagem('Atenção!', 'Informe pelo menos conjunto de departamentos.', ['&OK']);
    Exit(False);
  End;

  If (StrToFloatDef(edtMarFin.Text, 0) = 0) Then
  Begin
    fMensagem('Atenção!', 'Informe a margem final maior que zero.', ['&OK']);
    Exit(False);
  End;

  If (StrToFloatDef(edtMarFin.Text, 0) < StrToFloatDef(edtMarIni.Text, 0)) Then
  Begin
    fMensagem('Atenção!', 'Informe a margem final maior que a margem inicial.', ['&OK']);
    Exit(False);
  End;

  If (StrToFloatDef(edtFatFin.Text, 0) = 0) Then
  Begin
    fMensagem('Atenção!', 'Informe o faturamento final maior que zero.', ['&OK']);
    Exit(False);
  End;

  If (StrToFloatDef(edtFatFin.Text, 0) < StrToFloatDef(edtFatIni.Text, 0)) Then
  Begin
    fMensagem('Atenção!', 'Informe o faturamento final maior que o faturamento inicial.', ['&OK']);
    Exit(False);
  End;

  Try
    cdsDeptos.DisableControls;
    cdsDeptos.First;
    While (Not cdsDeptos.Eof) Do
    Begin
      If (Not objComissaoCtrl.fValidarFaixaMargemEFaturamento(objComissao.strAutInc,
                                                              StrToFloatDef(edtMarIni.Text, 0),
                                                              StrToFloatDef(edtMarFin.Text, 0),
                                                              StrToFloatDef(edtFatIni.Text, 0),
                                                              StrToFloatDef(edtFatFin.Text, 0),
                                                              cdsDeptos.FieldByName('AUTOINCREM').AsString,
                                                              cdsDeptos.FieldByName('DEPVEN').AsString,
                                                              cdsDeptos.FieldByName('DEPPRO').AsString)) Then
      Begin
        fMensagem('Atenção!',
                  'A Faixa de Margem e Faixa de Faturamento informadas são conflitantes com outra já cadastrada.' +#10+#13+
                  'Dep. Vendedor: ' + cdsDeptos.FieldByName('DEPVEN').AsString + ' - ' + cdsDeptos.FieldByName('DVENDS').AsString +#10+#13+
                  'Dep. Produto: ' + cdsDeptos.FieldByName('DEPPRO').AsString + ' - ' + cdsDeptos.FieldByName('DPRODS').AsString,
                  ['&OK']);
        Exit(False);
      End;

      cdsDeptos.Next;
    End;
  Finally
    cdsDeptos.EnableControls;
  End;
end;

procedure TfrmCadComFaiFatDepVenPro.grdDeptosDBTableView1DblClick(Sender: TObject);
begin
  inherited;

  pEditaItem();
end;

procedure TfrmCadComFaiFatDepVenPro.grdDeptosDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Delete) Then
    pRemoveItem();
end;

function TfrmCadComFaiFatDepVenPro.fAdicionaItem(strDepVen, strDepPro : String; fltPerCom, fltPerBon : Double):Boolean;
begin
  Result := True;

  If (cdsDeptos.Locate('DEPVEN;DEPPRO', VarArrayOf([strDepVen, strDepPro]), [])) Then
  Begin
    cdsDeptos.Edit;
    cdsDeptos.FieldByName('PERCOM').AsFloat := fltPerCom;
    cdsDeptos.FieldByName('PERBON').AsFloat := fltPerBon;
    cdsDeptos.Post;
  End
  Else
  Begin
    cdsDeptos.Append;
    cdsDeptos.FieldByName('DEPVEN').AsString := fPreencheEspaco(Trim(strDepVen), 3, False, '0');
    cdsDeptos.FieldByName('DEPPRO').AsString := fPreencheEspaco(Trim(strDepPro), 3, False, '0');
    cdsDeptos.FieldByName('PERCOM').AsFloat  := fltPerCom;
    cdsDeptos.FieldByName('PERBON').AsFloat  := fltPerBon;
    cdsDeptos.Post;
  End;
end;

function TfrmCadComFaiFatDepVenPro.fAdicionaTodosDeptos(strDepVen, strDepPro: String; fltPerCom, fltPerBon: Double): Boolean;
Var
  intIndex : Integer;
  intIndex2 : Integer;
begin
  Result := True;
  Try
    cdsDeptos.DisableControls;

    If fEmptyStr(strDepVen) And fEmptyStr(strDepPro) Then
    Begin
      For intIndex := 0 To Pred(stlDeptos.Count) Do
      Begin
        For intIndex2 := 0 To Pred(stlDeptos.Count) Do
        Begin
          If (Not fValidaItem(stlDeptos[intIndex], stlDeptos[intIndex2], fltPerCom)) Then
          Begin
            fMensagem('Atenção!', 'Não foi possível validar o conjunto: ' +#10+#13
                                + 'Departamento Vendedor: ' + stlDeptos[intIndex] +#10+#13
                                + 'Departamento Produto:  ' + stlDeptos[intIndex2], ['&OK']);

            Exit(False);
          End;

          fAdicionaItem(stlDeptos[intIndex], stlDeptos[intIndex2], fltPerCom, fltPerBon);
        End;

        Application.ProcessMessages;
      End;
    End
    Else If fEmptyStr(strDepVen) Then
    Begin
      For intIndex := 0 To Pred(stlDeptos.Count) Do
      Begin
        If (Not fValidaItem(stlDeptos[intIndex], strDepPro, fltPerCom)) Then
        Begin
          fMensagem('Atenção!', 'Não foi possível validar o conjunto: ' +#10+#13
                              + 'Departamento Vendedor: ' + stlDeptos[intIndex] +#10+#13
                              + 'Departamento Produto:  ' + strDepPro, ['&OK']);

          Exit(False);
        End;

        fAdicionaItem(stlDeptos[intIndex], strDepPro, fltPerCom, fltPerBon);

        Application.ProcessMessages;
      End;
    End
    Else If fEmptyStr(strDepPro) Then
    Begin
      For intIndex := 0 To Pred(stlDeptos.Count) Do
      Begin
        If (Not fValidaItem(strDepVen, stlDeptos[intIndex], fltPerCom)) Then
        Begin
          fMensagem('Atenção!', 'Não foi possível validar o conjunto: ' +#10+#13
                              + 'Departamento Vendedor: ' + strDepVen +#10+#13
                              + 'Departamento Produto:  ' + stlDeptos[intIndex], ['&OK']);

          Exit(False);
        End;

        fAdicionaItem(strDepVen, stlDeptos[intIndex], fltPerCom, fltPerBon);

        Application.ProcessMessages;
      End;
    End;
  Finally
    cdsDeptos.First;
    cdsDeptos.EnableControls;
  End;
end;

class procedure TfrmCadComFaiFatDepVenPro.pCadastrarFaixaComissao();
Var
  frmCadComFaiFatDepVenPro : TfrmCadComFaiFatDepVenPro;
begin
  pCriarFormularios(TfrmCadComFaiFatDepVenPro, frmCadComFaiFatDepVenPro);

  Try
    frmCadComFaiFatDepVenPro.ShowModal;
  Finally
    pFreeAndNil(frmCadComFaiFatDepVenPro);
  End;
end;

procedure TfrmCadComFaiFatDepVenPro.pEditaItem;
begin
  If (Not cdsDeptos.IsEmpty) Then
  Begin
    edtDepVen.Text := cdsDeptos.FieldByName('DEPVEN').AsString;
    edtDesVen.Text := cdsDeptos.FieldByName('DVENDS').AsString;

    edtDepPro.Text := cdsDeptos.FieldByName('DEPPRO').AsString;
    edtDesPro.Text := cdsDeptos.FieldByName('DPRODS').AsString;

    edtPerCom.Text := FloatToStr(cdsDeptos.FieldByName('PERCOM').AsFloat);
    edtPerBon.Text := FloatToStr(cdsDeptos.FieldByName('PERBON').AsFloat);
  End;
end;

procedure TfrmCadComFaiFatDepVenPro.pGravar;
Var
  objItem : TComissaoFaixaFatDeptoVendProdItemEntity;
begin
  If (Not fValidarCampos()) Then
    Exit;

  objComissao.strCodFFD := edtCodFFD.Text;
  objComissao.strDesFFD := edtDesFFD.Text;
  objComissao.fltMarIni := StrToFloatDef(edtMarIni.Text, 0);
  objComissao.fltMarFin := StrToFloatDef(edtMarFin.Text, 0);
  objComissao.fltFatIni := StrToFloatDef(edtFatIni.Text, 0);
  objComissao.fltFatFin := StrToFloatDef(edtFatFin.Text, 0);

  objComissao.lstItens.Clear;

  Try
    cdsDeptos.DisableControls;
    cdsDeptos.First;
    While (Not cdsDeptos.Eof) Do
    Begin
      objItem := objComissao.lstItens.fNew();
      objItem.strAutInc := cdsDeptos.FieldByName('AUTOINCREM').AsString;
      objItem.strDepVen := cdsDeptos.FieldByName('DEPVEN').AsString;
      objItem.strDepPro := cdsDeptos.FieldByName('DEPPRO').AsString;
      objItem.fltPerCom := cdsDeptos.FieldByName('PERCOM').AsFloat;
      objItem.fltPerBon := cdsDeptos.FieldByName('PERBON').AsFloat;

      cdsDeptos.Next;
    End;
  Finally
    cdsDeptos.First;
    cdsDeptos.EnableControls;
  End;

  If objComissaoCtrl.fSalvar(objComissao) Then
  Begin
    pIniciarInclusao();
    pLiberarTela(False);
  End;
end;

procedure TfrmCadComFaiFatDepVenPro.pIniciarInclusao;
begin
  edtCodFFD.Clear;
  edtDesFFD.Clear;

  edtMarIni.Clear;
  edtMarFin.Clear;
  edtFatIni.Clear;
  edtFatFin.Clear;

  pLimpaDepto();

  cdsDeptos.EmptyDataSet;

  objComissao.pClear;
end;

procedure TfrmCadComFaiFatDepVenPro.pLiberarTela(blnLiberar: Boolean);
begin
  pnlDeptos.Enabled        := blnLiberar;
  pnlFaixaComissao.Enabled := blnLiberar;

  btnGravar.Enabled        := blnLiberar;
  btnCancela.Enabled       := blnLiberar;

  btnIncluir.Enabled       := (Not blnLiberar);
  btnAlterar.Enabled       := (objComissao.fFoiCarregado() And (Not blnLiberar));

  edtCodFFD.ReadOnly       := objComissao.fFoiCarregado();
  btnExcluir.Enabled       := objComissao.fFoiCarregado();

  blnIncluindoOuAlterando  := blnLiberar;
end;

procedure TfrmCadComFaiFatDepVenPro.pLimpaDepto;
begin
  edtDepVen.Clear;
  edtDesVen.Clear;

  edtDepPro.Clear;
  edtDesPro.Clear;

  edtPerCom.Clear;
  edtPerBon.Clear;
end;

procedure TfrmCadComFaiFatDepVenPro.pRemoveItem;
begin
  If (Not cdsDeptos.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!', 'Deseja remover o item selecionado?', ['&Sim', '&Não']) = 1) Then
      cdsDeptos.Delete;
  End;

end;

end.
