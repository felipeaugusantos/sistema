unit untCadEstruturasIndustrialSubsComp;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, EditFocus, Uni, untFuncoesSimples, BitBtnLockedIncrem, Mask,
  MaskEditFocus, untTypesSistema, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEstruturasIndustrialSubsComp = class(TfrmPai)
    pnlGeral: TPanel;
    grbSubProdAtual: TGroupBox;
    grbSubProdSubst: TGroupBox;
    grbEstruturas: TGroupBox;
    Label2: TLabel;
    edtProAtu: TEditFocus;
    edtDesProAtu: TEditFocus;
    Label3: TLabel;
    edtRefProAtu: TEditFocus;
    edtUniProAtu: TEditFocus;
    Label4: TLabel;
    Label1: TLabel;
    edtProSub: TEditFocus;
    edtDesProSub: TEditFocus;
    Label5: TLabel;
    edtRefProSub: TEditFocus;
    edtUniProSub: TEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    edtProEst: TEditFocus;
    edtDesProEst: TEditFocus;
    Label8: TLabel;
    edtCorEst: TEditFocus;
    edtDesCorEst: TEditFocus;
    Label9: TLabel;
    edtCodFor: TEditFocus;
    btnConfirma: TBitBtnLocked;
    lblLinhaGrupo: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    lblMarca: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    rdgIteAti: TRadioGroup;
    Label20: TLabel;
    edtPerTol: TEditFocus;
    Label21: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtProAtuKeyPress(Sender: TObject; var Key: Char);
    procedure edtProSubKeyPress(Sender: TObject; var Key: Char);
    procedure edtProEstKeyPress(Sender: TObject; var Key: Char);
    procedure edtCorEstKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConIte: TUniQuery;
    qryConCor: TUniQuery;

    arrLinGru : TConsultasArray;
    arrMarca  : TConsultasArray;

    procedure pCarregaProdutoAtual(qryConsulta: TUniQuery);
    procedure pCarregaProdutoSubst(qryConsulta: TUniQuery);
    procedure pCarregaProdutoEstru(qryConsulta: TUniQuery);
    procedure pCarregaCor(qryConsulta: TUniQuery);
    procedure pIniciaProcessoDeSubstituicao;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, untConsultas, untPesqAux, untEstruturasIndustrialSubsComp,
   untGravando, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmCadEstruturasIndustrialSubsComp.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
    pIniciaProcessoDeSubstituicao;
end;

procedure TfrmCadEstruturasIndustrialSubsComp.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar,edtDesMar,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmCadEstruturasIndustrialSubsComp.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadEstruturasIndustrialSubsComp.edtCorEstKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCor : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqCores(Self, edtCorEst, edtDesCorEst, qryConCor, Key, arrCor) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEstruturasIndustrialSubsComp.edtProAtuKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Try

      if fPesqItem(conIteSimples, Self, edtProAtu, edtDesProAtu, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1',
                  '',0,False,False,0,cdrCodIte,'',False,'','',True,False,False,'',True) then
      Begin
        pCarregaProdutoAtual(qryConIte);
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadEstruturasIndustrialSubsComp.edtProAtuKeyPress]');
      End;
    End;

  End;
end;

procedure TfrmCadEstruturasIndustrialSubsComp.edtProEstKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtProEst, edtDesProEst, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1',
                 '', 0, False, False, 0, cdrCodIte, '', False, '', '', True, False, False, '', False, False, False, True) then
    Begin
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadEstruturasIndustrialSubsComp.edtProSubKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Try

      if fPesqItem(conIteSimples, Self, edtProSub, edtDesProSub, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1',
                  '',0,False,False,0,cdrCodIte,'',False,'','',True,False,False,'',True) then
      Begin
        pCarregaProdutoSubst(qryConIte);
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadEstruturasIndustrialSubsComp.edtProAtuKeyPress]');
      End;
    End;

  End;
end;

procedure TfrmCadEstruturasIndustrialSubsComp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConIte);
  FreeAndNil(qryConCor);
end;

procedure TfrmCadEstruturasIndustrialSubsComp.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10:btnConfirma.Click;
  End;
end;

procedure TfrmCadEstruturasIndustrialSubsComp.FormShow(Sender: TObject);
begin
  inherited;
  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  qryConCor := fCriarQuery('SELECT * FROM CADCOR WHERE FALSE', Self);

  pSetaCodIte( edtProAtu );
  pSetaCodIte( edtProSub );
  pSetaCodIte( edtProEst );

end;

function TfrmCadEstruturasIndustrialSubsComp.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtProAtu) Then
    Begin

      If fEmptyStr(edtProAtu.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o Código do Sub-Produto Atual!',['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaProdutoAtual(qryConIte);
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO','Código do Sub-Produto Atual não encontrado!',['&O K']);
          Result := False;
        End;
      End;
    End
    Else

    If (Sender = edtProSub) Then
    Begin

      If fEmptyStr(edtProSub.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o Código do Sub-Produto para Substituição!',['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaProdutoSubst(qryConIte);
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO','Código do Sub-Produto para Substituição não encontrado!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else
    If (Sender = edtPerTol) Then
    Begin

      If fEmptyStr(edtPerTol.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o % de Tolerância do produto!',['&O K']);
        Result := False;
      End
      Else
      If fStrToFloat(edtPerTol.Text) < 0.00 Then
      Begin
        fMensagem('ATENÇÃO','O % de Tolerância deve ser maior ou igual a Zero !',['&O K']);
        Result := False;
      End;

    End

    Else
    If (Sender = edtProEst) Then
    Begin
      If Not fEmptyStr(edtProEst.Text) Then
      Begin
        pCarregaProdutoEstru(qryConIte);
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO','Código do Produto Estrutura não encontrado!',['&O K']);
          Result := False;
        End;
      End;
    End
    Else

    If (Sender = edtCorEst) Then
    Begin
      If Not fEmptyStr(edtCorEst.Text) Then
      Begin
        pCarregaCor(qryConCor);
        If qryConCor.FieldByName('COR_CODCOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO','Código da Cor da Estrutura não encontrado!',['&O K']);
          Result := False;
        End;
      End;
    End
    Else

    If (Sender = mskLinGru) Then
    Begin
      pDesmarcaLista(mskLinGru,arrLinGru,'', 6);
    End
    Else

    If (Sender = edtCodMar) Then
    Begin
      pDesmarcaLista(edtCodMar,arrMarca);
    End


  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEstruturasIndustrialSubsComp.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGrupo, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmCadEstruturasIndustrialSubsComp.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGrupo, Nil, Key , arrLinGru) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadEstruturasIndustrialSubsComp.pCarregaCor(qryConsulta: TUniQuery);
begin
  pPesquisaCadCor(qryConsulta, qryConsulta, edtCorEst.Text);
  With qryConsulta Do
  Begin
    edtDesCorEst.Text := qryConsulta.FieldByName('COR_DESCOR').AsString;
  End
end;

procedure TfrmCadEstruturasIndustrialSubsComp.pCarregaProdutoAtual(
  qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtProAtu.Text, '', False, False, True, False, False, False, False, True);
  With qryConsulta Do
  Begin
    edtDesProAtu.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtRefProAtu.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtUniProAtu.Text := qryConsulta.FieldByName('ITE_CODUNI').AsString;
  End;
end;

procedure TfrmCadEstruturasIndustrialSubsComp.pCarregaProdutoEstru(
  qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtProEst.Text, '', False, False, True, False, False, False, True);
  With qryConsulta Do
  Begin
    edtDesProEst.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
  End
end;

procedure TfrmCadEstruturasIndustrialSubsComp.pCarregaProdutoSubst(
  qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtProSub.Text, '', False, False, True, False, False, False, False, True);
  With qryConsulta Do
  Begin
    edtDesProSub.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtRefProSub.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtUniProSub.Text := qryConsulta.FieldByName('ITE_CODUNI').AsString;
  End;
end;

procedure TfrmCadEstruturasIndustrialSubsComp.pIniciaProcessoDeSubstituicao;
  var
    SubsComp: TEstruturasIndustrialSubsComp;
    opcEstIndSubComp : TopcEstIndSubComp;
begin
  Try
    opcEstIndSubComp := IIF(fGetMenu('Substituir os Componentes', ['Criando uma nova formula','Na mesma formula'], 1) = 1, opcCriarNovaFormula, opcManterFormula);
    SubsComp := TEstruturasIndustrialSubsComp.Create(Nil, opcEstIndSubComp);
    Try

      SubsComp.strProAtu    := edtProAtu.Text;
      SubsComp.strProSub    := edtProSub.Text;
      SubsComp.fltPerTol    := fStrToFloat(edtPerTol.Text);
      SubsComp.strRefProSub := edtRefProSub.Text;
      SubsComp.strProEst    := edtProEst.Text;
      SubsComp.strCodCor    := edtCorEst.Text;
      SubsComp.strCodLinGru := mskLinGru.Text;
      SubsComp.strCodMarca  := edtCodMar.Text;

      Case rdgIteAti.ItemIndex Of
        0 : SubsComp.strStatus := 'A';
        1 : SubsComp.strStatus := 'I';
        2 : SubsComp.strStatus := 'T';
      End;

      if opcEstIndSubComp = opcCriarNovaFormula then
      begin
        SubsComp.blnImpAna := fMensagem('','Deseja importar as Análises das Fórmulas?', ['','']) = 1;
        if SubsComp.blnImpAna and (fMensagem('','As análises serão importadas da Fórmula ativa, deseja continuar?', ['','']) = 2) then
          exit;
      end;

      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.fExecutarAcao := SubsComp.fSubstituicaoComponentes;
        frmGravando.ShowModal;
      Finally
        FreeAndNil(frmGravando);
      End;

    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[TfrmCadEstruturasIndustrialSubsComp.pIniciaProcessoDeSubstituicao]');
      end;
    End;
  Finally
    FreeAndNil(SubsComp);
  End;
end;

end.

