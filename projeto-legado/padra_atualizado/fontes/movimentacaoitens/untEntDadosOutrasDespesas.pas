unit untEntDadosOutrasDespesas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, untFuncoesSimples, untTypesSistema,
  BitBtnLockedIncrem, UniClientDataSet, DB, Grids, DBGridCitel, DBGrids, Contnrs, frxClass,
  frxExportCSVTestabilidade, untPortadorFornecedor, untFrameCentroCustoEditFocus,
  untFramePlanoDeContasMaskEdit, QColorLabel, Vcl.DBCtrls, DBEditFocus,
  ComboBoxFocus, Contabilidade.Funcoes, Contabilidade.Consultas,
  untCadClientes, untCadTransportadoras, Uni, untCadPag;

type
  TfrmEntDadosOutrasDespesas = class(TfrmPaiConfirma)
    pnlOutras: TPanel;
    lblCliFor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    Label7: TLabel;
    mskCndPag: TMaskEditFocus;
    pnlValOut: TPanel;
    Label16: TLabel;
    edtValOut: TEditFocus;
    mmoAjuda: TMemo;
    ds1: TDataSource;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    lblTotal: TLabel;
    Label1: TLabel;
    dbgDados: TDBGridCitel;
    Label31: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    Label2: TLabel;
    MemObsCta: TMemo;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    Label62: TLabel;
    ColorLabel3: TColorLabel;
    ColorLabel1: TColorLabel;
    edtVeioNF: TEditFocus;
    Label3: TLabel;
    ColorLabel2: TColorLabel;
    edtVeioBO: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    ColorLabel5: TColorLabel;
    lblConta: TLabel;
    edtDeposi: TEditFocus;
    cbxBcoFor: TComboBoxFocus;
    chkGraFin: TCheckBox;
    chkRpaDespFrete: TCheckBox;
    Panel1: TPanel;
    rdgTipoRateio: TRadioGroup;
    Label6: TLabel;
    chkDesAdi: TCheckBox;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure dbgDadosKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure cbxBcoForChange(Sender: TObject);
    procedure cbxBcoForDropDown(Sender: TObject);
    procedure cbxBcoForEnter(Sender: TObject);
    procedure cbxBcoForExit(Sender: TObject);
    procedure cbxBcoForKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDeposiExit(Sender: TObject);
    procedure cdsDadosRPAFREGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure chkRpaDespFreteClick(Sender: TObject);
    procedure chkDesAdiClick(Sender: TObject);

  private
    objPortadorFornecedor : TPortadorFornecedor;
    blnInsert : Boolean;
    FCondPagAnt: String;
    blnPermiteDefinirTipoRateio: Boolean;
    blnADIOUT: Boolean;
    procedure pAjustaPanel;
    procedure pCarregaDados;
    procedure pLimpaEdit;

    procedure pBeforeScroll(Dataset : TDataSet);
    procedure pAtualizaTotal;
    procedure pCarregaDadosBancariosFornecedor(strCodFor: String);
    procedure pSetaBcoFor;
    procedure pAplicarTipRatFreRpa(Value: TTipoRateioFrete);
    procedure pHabilitarrdgTipRateio;
  public
    ArrDuplicataOutras: TArrDigDuplicArray;
    arrDuplicata: TarrDuplicataPointer;

    dtaDtaEnt : TDate;
    blnDigAposEntrada: Boolean;

    lstBcoFor: TStringList;
    intIdxBcoForAnt: Integer;

    cdsDados : TUniClientDataSet;
    dtsDados : TDataSource;
    blnEntMer: Boolean;

    strPlCta : String;
    tipRatFreRpa: TTipoRateioFrete;
    procedure pAtribuirGetTextRPAFRE;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmEntDadosOutrasDespesas: TfrmEntDadosOutrasDespesas;

implementation
{$R+}

uses  untConstantes, untConsultas,untCadCta, untCadFornecedores,
      untPcmger, untFuncoes, untDuplicatas;

{$R *.dfm}

procedure TfrmEntDadosOutrasDespesas.btnAdicionarClick(Sender: TObject);
  Var
    intIndex  : Integer;
    strDuplic : String;
    blnAlterouCondPagamento: Boolean;

begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  blnAlterouCondPagamento := (FCondPagAnt <> fTiraCaracEspeciais(mskCndPag.Text));

  if pnlOutras.Enabled and blnAlterouCondPagamento  then
  begin
    if Not fValidaCampos(mskCndPag) then
      Exit;
  end;

  With cdsDados Do
  Begin
    If blnInsert Then
      Insert
    Else
      Edit;

    FieldByName('CODFOR').AsString := edtCodFor.Text;
    FieldByName('NOMFOR').AsString := edtNomFor.Text;
    FieldByName('CODCTA').AsString := fraPlanoDeContas.MskCodCta.Text;
    FieldByName('DESCTA').AsString := fraPlanoDeContas.edtDesCta.Text;
    FieldByName('VEIOBO').AsString := IIF(edtVeioBo.Text='S','SIM','NÃO');
    FieldByName('DEPOSI').AsString := IIF(edtDeposi.Text='S','SIM','NÃO');
    FieldByName('GERFIN').AsString := IIF(chkGraFin.Checked,'SIM','NÃO');
    FieldByName('RPAFRE').AsString := IIF(chkRpaDespFrete.Checked,'S','N');

    pSetaBcoFor;

    FieldByName('CODPOR').AsString := edtCodPor.Text;
    FieldByName('NOMPOR').AsString := edtNomPor.Text;

    If edtVeioNF.Text = 'S' Then
      FieldByName('VEIONF').AsString := 'SIM'
    Else
      FieldByName('VEIONF').AsString := 'NÃO';

    If edtVeioBO.Text = 'S' Then
      FieldByName('VEIOBO').AsString := 'SIM'
    Else
      FieldByName('VEIOBO').AsString := 'NÃO';

    FieldByName('CODEVE').AsString := fraCentroCusto.edtCodEve.Text;

    FieldByName('CNDPAG').AsString := mskCndPag.Text;

    If blnADIOUT And chkDesAdi.Checked Then
      FieldByName('VALOUT').AsFloat  := fStrToFloat(fCfgSis('OPEADI') + edtValOut.Text)
    Else
      FieldByName('VALOUT').AsFloat  := fStrToFloat(edtValOut.Text);

    FieldByName('HISTOR').AsString := MemObsCta.Text;
    If blnDigAposEntrada Then
      FieldByName('ORIGEM').AsString := 'Após Entrada';
    FieldByName('FORNEC').AsString :=  edtCodFor.Text + '-' + edtNomFor.Text;
    FieldByName('EFETIV').AsString := 'Pendente';
    FieldByName('OUT_EFETIV').AsString  := 'N';

    if chkRpaDespFrete.Checked then
    begin
      case rdgTipoRateio.ItemIndex of
        0: tipRatFreRpa := TTipoRateioFrete.trfPropValorItem;
        1: tipRatFreRpa := TTipoRateioFrete.trfPropPesoItem;
        2: tipRatFreRpa := TTipoRateioFrete.trfPropQtdItem;
        3: tipRatFreRpa := TTipoRateioFrete.trfInformarPercentuais;
      end;
    end;

    if blnInsert or blnAlterouCondPagamento then
    begin
      strDuplic := '';
      For intIndex := 0 to Length(ArrDuplicataOutras) -1 Do
      Begin
        if not fEmptyStr(ArrDuplicataOutras[intIndex].dtaDtaVen) Then
          strDuplic := strDuplic + fPadR(ArrDuplicataOutras[intIndex].strSequen,05) +
                                   fPadR(ArrDuplicataOutras[intIndex].dtaDtaVen,10) +
                                   FloatToStr(ArrDuplicataOutras[intIndex].curValor) + #13#10;
      End;
      cdsDados.FieldByName('DUPLIC').AsString := strDuplic;
    end;

    Post;

    blnInsert := True;
    pAtualizaTotal;
    pLimpaEdit;

    btnConfirma.Enabled := True;

    pSetFocus(edtValOut);

    dbgDados.Enabled := True;
  End;
end;

procedure TfrmEntDadosOutrasDespesas.pCarregaDados;
Begin
  If cdsDados.FieldByName('OUT_EFETIV').AsString = 'S' Then
  Begin
    pMensagemOk('Este registro já foi lançado e efetivado, não pode ser alterado.');
    Exit;
  End;

  With cdsDados Do
  Begin
    edtCodFor.Text := FieldByName('CODFOR').AsString;
    edtNomFor.Text := FieldByName('NOMFOR').AsString;
    fraPlanoDeContas.MskCodCta.Text := FieldByName('CODCTA').AsString;
    fraPlanoDeContas.edtDesCta.Text := FieldByName('DESCTA').AsString;
    edtCodPor.Text := FieldByName('CODPOR').AsString;
    edtNomPor.Text := FieldByName('NOMPOR').AsString;

    edtVeioNF.Text := Copy(FieldByName('VEIONF').AsString,0,1);
    edtVeioBO.Text := Copy(FieldByName('VEIOBO').AsString,0,1);
    edtDeposi.Text := Copy(FieldByName('DEPOSI').AsString,0,1);
    cbxBcoFor.ItemIndex := lstBcoFor.IndexOf(FieldByName('BCOFOR').AsString);
    cbxBcoFor.Enabled := True;

    fraCentroCusto.edtCodEve.Text := FieldByName('CODEVE').AsString;
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve.Text);

    mskCndPag.Text := FieldByName('CNDPAG').AsString;
    FCondPagAnt := FieldByName('CNDPAG').AsString;
    edtValOut.Text := FormatFloat('#,##0.00', Abs(FieldByName('VALOUT').AsFloat));

    MemObsCta.Text := FieldByName('HISTOR').AsString;

    StrPlCta :=  FieldByName('CODCTA').AsString;
    chkRpaDespFrete.Checked := FieldByName('RPAFRE').AsString = 'S';

    if chkRpaDespFrete.Checked then
    begin
      pAplicarTipRatFreRpa(tipRatFreRpa);
    end;
  End;
  pSetFocus(edtValOut);


End;

procedure TfrmEntDadosOutrasDespesas.pSetaBcoFor;
begin
  inherited;

  If cbxBcoFor.ItemIndex > -1 Then
    cdsDados.FieldByName('BCOFOR').AsString := lstBcoFor[cbxBcoFor.ItemIndex]
  Else
    cdsDados.FieldByName('BCOFOR').Value := Null;
end;

procedure TfrmEntDadosOutrasDespesas.pLimpaEdit;
Begin
  edtCodFor.Clear;
  edtNomFor.Clear;
  fraPlanoDeContas.MskCodCta.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  edtCodPor.Clear;
  edtNomPor.Clear;
  MemObsCta.Lines.Clear;

  edtVeioBo.Clear;
  edtDeposi.Clear;
  cbxBcoFor.ItemIndex := -1;
  cbxBcoFor.Enabled := False;

  edtVeioNF.Text := 'S';
  edtVeioBO.Text := 'N';

  fraCentroCusto.edtCodEve.Clear;
  fraCentroCusto.edtDesEve.Clear;

  mskCndPag.Clear;
  edtValOut.Clear;

  StrPlCta := '';
  chkRpaDespFrete.Checked := False;
  FCondPagAnt := EmptyStr;
  SetLength(ArrDuplicataOutras,0);
End;

procedure TfrmEntDadosOutrasDespesas.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaEdit;
  blnInsert := True;
  pSetFocus(edtVAlOut);
end;

procedure TfrmEntDadosOutrasDespesas.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  If rdgTipoRateio.ItemIndex = 1 Then
    If not fVerificaPesoDosItensEntrada(True) Then
      Exit;

  if not blnInsert Then
  Begin
    pMensagemOK('Grave ou Cancele o Registro que esta sendo Alterado!');
    Abort;
  End
  Else
    ModalResult := mrOK;
end;

procedure TfrmEntDadosOutrasDespesas.cbxBcoForChange(Sender: TObject);
begin
  inherited;
  intIdxBcoForAnt := cbxBcoFor.ItemIndex;
end;

procedure TfrmEntDadosOutrasDespesas.cbxBcoForDropDown(Sender: TObject);
begin
  inherited;
  SendMessage(cbxBcoFor.Handle, CB_SETDROPPEDWIDTH, 315, 0)
end;

procedure TfrmEntDadosOutrasDespesas.cbxBcoForEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para incluir/alterar dados bancários do fornecedor';
end;

procedure TfrmEntDadosOutrasDespesas.cbxBcoForExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmEntDadosOutrasDespesas.cbxBcoForKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Insert) And (fValidaCampos(edtCodFor, True)) Then
  Begin

    pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);

    try
      frmCadFornecedores.strCodFornecedorIniciarCadastro := edtCodFor.Text;
      frmCadFornecedores.fMskCon := fMskCon;
      frmCadFornecedores.fSemMascaraPlaNco := fSemMascaraPlaNco;
      frmCadFornecedores.fPesqPlanoContabil := Contabilidade.Consultas.fPesqPlanoContabil;
      frmCadFornecedores.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
      frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa;
      frmCadFornecedores.pGravarPlanoContasAutomatico := pGravarPlanoContasAutomatico;
      frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := pGravarPlanoContasAutomaticoParaCadaEmpresa;
      frmCadFornecedores.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
      frmCadFornecedores.fCadastroRapidoTransportadora := TfrmCadTransportadoras.fCadastroRapidoTransportadora;
      frmCadFornecedores.fCriaEstruturaCdsNCO := fCriaEstruturaCdsNCO ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := pCarregaPlanoDeContasPorEmpresa ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := pSalvaPlanoDeContasPorEmpresa;
      frmCadFornecedores.ShowModal;
    finally
      frmCadFornecedores.fMskCon := Nil;
      frmCadFornecedores.fSemMascaraPlaNco := Nil;
      frmCadFornecedores.fPesqPlanoContabil := Nil;
      frmCadFornecedores.fCadastroRapidoCliente := Nil;
      frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
      frmCadFornecedores.fCriaEstruturaCdsNCO := Nil ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := Nil ;
      pCarregaDadosBancariosFornecedor(edtCodFor.Text);
      pFreeAndNil(frmCadFornecedores);
    End;

  End;
end;

procedure TfrmEntDadosOutrasDespesas.cdsDadosRPAFREGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.AsString = 'S' then
    Text := 'Sim'
  else
    Text := 'Não';
end;

procedure TfrmEntDadosOutrasDespesas.chkDesAdiClick(Sender: TObject);
begin
  If chkDesAdi.Checked Then
    chkRpaDespFrete.Checked := False;
end;

procedure TfrmEntDadosOutrasDespesas.chkRpaDespFreteClick(Sender: TObject);
begin
  inherited;

  If chkRpaDespFrete.Checked Then
    chkDesAdi.Checked := False;

  pHabilitarrdgTipRateio;
end;

procedure TfrmEntDadosOutrasDespesas.pCarregaDadosBancariosFornecedor(strCodFor: String);
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    cbxBcoFor.Clear;
    lstBcoFor.Clear;
    With qryGen, SQL Do
    Begin
      Clear;
      Add(getSQLDadosBancariosFornecedor);
      ParamByName('CODFOR').AsString := strCodFor;
      Open;

      While Not Eof Do
      Begin
        cbxBcoFor.Items.Add(Trim(FieldByName('DESC_CONTA').AsString));
        lstBcoFor.Add(FieldByName('AUTOINCREM').AsString);
        Next;
      End;

      Close;
    End;
  Finally
    If Pred(cbxBcoFor.Items.Count) >= intIdxBcoForAnt Then
      cbxBcoFor.ItemIndex := intIdxBcoForAnt;
    FreeAndNil(qryGen);
  End;

end;

procedure TfrmEntDadosOutrasDespesas.pHabilitarrdgTipRateio;
begin
  rdgTipoRateio.Enabled := (Not chkRpaDespFrete.Checked) or (chkRpaDespFrete.Checked and blnPermiteDefinirTipoRateio);
  IF chkRpaDespFrete.Checked Then
    pAplicarTipRatFreRpa(tipRatFreRpa);
end;

procedure TfrmEntDadosOutrasDespesas.dbgDadosDblClick(Sender: TObject);
begin
  inherited;
  If cdsDados.FieldByName('OUT_EFETIV').AsString = 'S' Then
  Begin
    pMensagemOk('Este registro já foi lançado e efetivado, não pode ser alterado.');
    Exit;
  End;

  pCarregaDados;
  If Assigned(cdsDados) And (Not cdsDados.IsEmpty) Then
    blnInsert := False;
end;

procedure TfrmEntDadosOutrasDespesas.dbgDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_DELETE) and cdsDados.Active And (cdsDados.RecordCount > 0) Then
  Begin
    If cdsDados.FieldByName('OUT_EFETIV').AsString = 'S' Then
    Begin
      pMensagemOk('Este registro já foi lançado e efetivado, não pode ser excluído.');
      Exit;
    End;

    If cdsDados.FieldByName('NOMFOR').ASString = 'DESPESAS IMPORTACAO' Then
    Begin
      pMensagemOk('Registro referente as despesas da nota de importação, não pode ser excluído.');
      Exit;
    End;

    if (fMensagem('ATENÇÃO', 'Deseja Excluir o Item ?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      pLimpaEdit;
      blnInsert := True;
      cdsDados.Delete;
      pAtualizaTotal;
    End;

  End;

end;

procedure TfrmEntDadosOutrasDespesas.dbgDadosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 Then
  Begin
    If cdsDados.FieldByName('OUT_EFETIV').AsString = 'S' Then
    Begin
      pMensagemOk('Este registro já foi lançado e efetivado, não pode ser alterado.');
      Exit;
    End;

    If cdsDados.FieldByName('NOMFOR').ASString = 'DESPESAS IMPORTACAO' Then
    Begin
      pMensagemOk('Registro referente as despesas da nota de importação, não pode ser editado.');
      Exit;
    End;

    pCarregaDados;
    If Assigned(cdsDados) And ( Not cdsDados.IsEmpty) Then
      blnInsert := False;
  End;

end;

procedure TfrmEntDadosOutrasDespesas.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntDadosOutrasDespesas.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) And
     fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, Nil, Key, arrSel) then
     if fValidaCampos(edtCodPor) then
       Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmEntDadosOutrasDespesas.edtDeposiExit(Sender: TObject);
begin
  inherited;
  cbxBcoFor.Enabled := edtDeposi.Text = 'S';
  If cbxBcoFor.Enabled Then
    pSetFocus(cbxBcoFor);
end;

procedure TfrmEntDadosOutrasDespesas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;

end;

procedure TfrmEntDadosOutrasDespesas.FormCreate(Sender: TObject);
begin
  inherited;
  blnEntMer := False;
  blnDigAposEntrada := False;
  cdsDados := TUniClientDataSet.Create(Self);
  cdsDados.BeforeScroll := pBeforeScroll;
  dtsDados := TDataSource.Create(Self);
  dtsDados.DataSet    := cdsDados;
  dbgDados.DataSource := dtsDados;
  pAtribuirGetTextRPAFRE;
  lstBcoFor := TStringList.Create;
  intIdxBcoForAnt := -1;

  strPlCta := '';

  btnConfirma.Enabled := Not cdsDados.IsEmpty;
  FCondPagAnt := EmptyStr;

  case fCfgSis('RATFRE', varInteger) Of
    3,5: blnPermiteDefinirTipoRateio := True;
    else
      blnPermiteDefinirTipoRateio := False;
  End;

  dbgDados.Enabled := False;
end;

procedure TfrmEntDadosOutrasDespesas.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(objPortadorFornecedor) then
    FreeAndNil(objPortadorFornecedor);
  FreeAndNil(cdsDados);
  FreeAndNil(dtsDados);
  lstBcoFor.Free;
end;

procedure TfrmEntDadosOutrasDespesas.FormShow(Sender: TObject);
begin
  inherited;
  objPortadorFornecedor := TPortadorFornecedor.Create(blnEntMer);

  blnInsert := True;
  pAjustaPanel;

  pSetFocus(edtValOut);

  With cdsDados Do
  Begin
    FieldByName('CNDPAG').EditMask := '99.999.999.999.999.999.999.999.999.999.999.999.999;0;_';
    FieldByName('CODCTA').EditMask := '99.99.999;0;_';
    TFloatField(FieldByName('VALOUT')).DisplayFormat := '#,##0.00';
  End;  

  blnADIOUT := (fCfgSis('ADIOUT') = 'S');
  chkDesAdi.Visible := blnADIOUT;
  chkDesAdi.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';

  pAtualizaTotal;

  If blnDigAposEntrada Then
    chkRpaDespFrete.Visible := False;

  If Assigned(cdsDados) And ( Not cdsDados.IsEmpty) Then
   dbgDados.Enabled := True;
end;

procedure TfrmEntDadosOutrasDespesas.pAjustaPanel;
Begin
  pnlOutras.Enabled := fStrToFloat(edtValOut.Text) > 0;

  If Not pnlOutras.Enabled Then
  Begin
    mskCndPag.Clear;
    edtCodFor.Clear;
    edtNomFor.Clear;
    fraPlanoDeContas.edtDesCta.Clear;
    fraPlanoDeContas.MskCodCta.Clear;
    edtCodPor.Clear;
    edtNomPor.Clear;
    edtDeposi.Text := 'N';
    lblConta.Visible := False;
    cbxBcoFor.Enabled := False;
    fraCentroCusto.edtCodEve.Clear;
    fraCentroCusto.edtDesEve.Clear;
  End;
End;

procedure TfrmEntDadosOutrasDespesas.pAplicarTipRatFreRpa(
  Value: TTipoRateioFrete);
begin
  case Value of
    trfPropValorItem: rdgTipoRateio.ItemIndex := 0;
    trfPropQtdItem: rdgTipoRateio.ItemIndex := 2;
    trfInformarPercentuais:  rdgTipoRateio.ItemIndex := 3;
    else
      rdgTipoRateio.ItemIndex := 1;
  end;
end;

procedure TfrmEntDadosOutrasDespesas.pAtribuirGetTextRPAFRE;
begin

  if Assigned(cdsDados.FindField('RPAFRE')) then
    cdsDados.FieldByName('RPAFRE').OnGetText := cdsDadosRPAFREGetText;
end;

procedure TfrmEntDadosOutrasDespesas.pAtualizaTotal;
  Var
    intRecNo : Integer;
    fltTotal : Double;
    fldValOut: TField;
begin
  with cdsDados Do
  Begin
    intRecNo := RecNo;
    fldValOut := FieldByName('VALOUT');
    Try
      fltTotal := 0.00;
      DisableControls;

      First;

      While Not Eof Do
      Begin
        fltTotal := fltTotal + fldValOut.AsFloat;
        Next;
      End;

      lblTotal.Caption := 'Total ' + FormatFloat('#,##0.00', fltTotal);

    Finally
      RecNo := intRecNo;
      EnableControls;
    End;

  End;

end;

procedure TfrmEntDadosOutrasDespesas.pBeforeScroll(Dataset: TDataSet);
begin
  if not blnInsert Then
    Abort;
end;

procedure TfrmEntDadosOutrasDespesas.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCtaFor : TConsultasArray;
begin
  inherited;
  If (Not fCfgSis('USACTF', varBoolean)) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCtaFor) Then
    Begin
      If fValidaCampos(fraPlanoDeContas.MskCodCta, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, nil, Key, arrCtaFor, True, True, edtCodFor.Text) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function  TfrmEntDadosOutrasDespesas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intContador : Integer;
    ArrDuplicataTemp: TArrDigDuplicArray;
    arrVectos : TDateArray;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtValOut) Then
    Begin

      If fStrToFloat(edtValOut.Text) < 0 Then
      Begin
        pMensagemOk('O Valor de Outras Despesas deve ser maior ou igual a zero!');
        Result := False;
      End;

      edtValOut.Text := FormatFloat('#0.00', fStrToFloat(edtValOut.Text));

      pAjustaPanel;
    End

    Else If Sender = edtVeioNF Then
    Begin
      If Not fValidoSimNao(edtVeioNF.Text) Then
        Begin
          fMensagem('','O campo veio NF? deve ser (S)im ou (N)ão ', ['&OK']);
          Result := False;
        End
    End

    Else If Sender = edtVeioBO Then
    Begin
      If Not fValidoSimNao(edtVeioBO.Text) Then
        Begin
          fMensagem('','O campo veio boleto? deve ser (S)im ou (N)ão ', ['&OK']);
          Result := False;
        End
     End

    Else If (Sender = edtDeposi) Then
    Begin
      If (edtVeioBO.Text = 'S') And (edtDeposi.Text = 'S') Then
      Begin
        Result := False;
        fMensagem('','Para informar deposito como (S)im, o campo "veio boleto" deve ser igual à (N)ão!', ['&Ok']);
      End
      Else If (edtDeposi.Text = 'S') Then
      Begin
        pCarregaDadosBancariosFornecedor(edtCodFor.Text);
      End;
    End

    Else If Sender = edtCodFor Then
    Begin

      If pnlOutras.Enabled Then
      Begin
        If fEmptyStr(edtCodFor.Text) Then
        Begin
          pMensagemOk('Informe o código do Fornecedor!');
          Result := False;
        End Else
        Begin
          edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

          If fEmptyStr(edtNomFor.Text) Then
          Begin
            pMensagemOk('Fornecedor não encontrado!');
            Result := False;
          End

          Else If Not fFornecedorGravaCtp(edtCodFor.Text) Then
          Begin
            pMensagemOk('Esse Fornecedor está configurado para não gravar contas a pagar!');
            Result := False;
          End

          else
          begin
            objPortadorFornecedor.strCodFor := edtCodFor.Text;

            if objPortadorFornecedor.fTravaPortador then
            begin
              edtCodPor.Enabled := False;
              edtCodPor.Text := objPortadorFornecedor.strCodPor;
              edtNomPor.Text := objPortadorFornecedor.strNomPor;
            end
            else begin
              edtCodPor.Enabled := True;
              if fEmptyStr(edtCodPor.Text) then
              begin
                edtCodPor.Text := objPortadorFornecedor.strCodPor;
                edtNomPor.Text := objPortadorFornecedor.strNomPor;
              end;
            end;

          end;
        End;
      End;

    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If pnlOutras.Enabled And (Not fraPlanoDeContas.MskCodCta.ReadOnly) Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(fraPlanoDeContas.MskCodCta.Text);

          If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            if (blnInsert) or (StrPlCta <> fraPlanoDeContas.MskCodCta.Text) then
              Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
          End;

        End;
      End;

    End

    Else If (Sender = edtCodPor) Then
    Begin

      If not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
        If fEmptyStr(edtNomPor.Text) Then
        Begin
          pMensagemOk('Portador não econtrado!');
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If Sender = fraCentroCusto.edtCodEve Then
    Begin

      If fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        If (fCfgSis('CTPOBE', varBoolean)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
          Result := False;
        End;
        fraCentroCusto.edtDesEve.Clear;
      End Else
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          pMensagemOk('Centro de Custos não encontrado!');
          Result := False;
        End;
      End;

    End

    Else If (Sender = mskCndPag) Then
    Begin

      If pnlOutras.Enabled Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
        Begin
          fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaCndPag(mskCndPag.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
          Result := False;
        End;

        If (blnBuscaPorChave) Or
           (Length(ArrDuplicataOutras) <= 0 )Then
        Begin
          intContador := 0;
          While (intContador < 24) Do
          Begin

            SetLength(ArrDuplicataTemp, intContador+1);
            ArrDuplicataTemp[intContador] := ArrDuplicata[intContador];
            Inc(intContador);

          End;

          SetLength(ArrDuplicataOutras, 0);
          Result := fDigDuplic(arrDuplicata^,
                        mskCndPag.Text,
                        0,
                        fStrToFloat(edtValOut.Text),
                        (fStatusCndPag(mskCndPag.Text) = A_PRAZO),
                        True,
                        False,
                        dtaDtaEnt,
                        True,
                        0,
                        'N',
                        False);
          If Result Then
          Begin
            intContador := 0;
            While (intContador <= 23)                         And
                  (ArrDuplicata[intContador].dtaDtaVen <> '') Do
            Begin

              SetLength(ArrDuplicataOutras, intContador+1);
              ArrDuplicataOutras[intContador] := ArrDuplicata[intContador];

              SetLength(arrVectos, intContador+1);
              arrVectos[intContador] := StrToDate(ArrDuplicata[intContador].dtaDtaVen);

              Inc(intContador);

            End;
            mskCndPag.Text := fRetornaCndPag(arrVectos, dtaDtaEnt);
            SetLength(arrVectos, 0);
            Result := fValidaCndPag(mskCndPag.Text);

            if Result and blnInsert then
              FCondPagAnt := fTiraCaracEspeciais(mskCndPag.Text);

          End;

          intContador := 0;
          While (intContador < 24) Do
          Begin

            ArrDuplicata[intContador] := ArrDuplicataTemp[intContador];
            Inc(intContador);

          End;

        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

