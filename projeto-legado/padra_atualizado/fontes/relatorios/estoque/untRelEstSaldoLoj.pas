unit untRelEstSaldoLoj;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  CheckLst, RLReport, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, DB,
  RLTypes, AppEvnts, ComCtrls, BitBtnLockedIncrem, ComboBoxFocus,
  untTypesSistema, frxExportCSVTestabilidade, untIFuncoes;

type
  TfrmRelEstSaldoLoj = class(TfrmPaiRelatorio)
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDescri: TEditFocus;
    lblDescricao: TLabel;
    edtRefere: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtUnidade: TEditFocus;
    Label3: TLabel;
    mskLinhaGrupo2: TMaskEditFocus;
    GroupBox1: TGroupBox;
    edtOpcao: TEditFocus;
    ColorLabel2: TColorLabel;
    lstEmpresas: TCheckListBox;
    Label4: TLabel;
    edtDesGrupo: TEditFocus;
    edtDesGrupo2: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtDesMarca: TEditFocus;
    rdgStatus: TRadioGroup;
    GroupBox3: TGroupBox;
    chkReferencia: TCheckBox;
    chkMarca: TCheckBox;
    pgbProgresso: TProgressBar;
    rdgBocaCaixa: TRadioGroup;
    rdgSaldos: TRadioGroup;
    chkPreVen: TCheckBox;
    cmbPrecos: TComboBoxFocus;
    grbEntregaFutura: TGroupBox;
    chkEntFut: TCheckBox;
    grbMotFut: TGroupBox;
    chkFalta: TCheckBox;
    chkPrevisao: TCheckBox;
    chkAguarda: TCheckBox;
    chkPreCom: TCheckBox;
    chkCodFabrica: TCheckBox;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupo2Exit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupo2KeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoEnter(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure pAtualizaLst;
    procedure FormShow(Sender: TObject);
    procedure lstEmpresasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lstEmpresasClickCheck(Sender: TObject);

    function fContaSelecoes: Integer;
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkMarcaClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkPreVenClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkEntFutClick(Sender: TObject);
    procedure chkReferenciaClick(Sender: TObject);
  private
    { Private declarations }
    intMaxColRetrato: Integer;
    intEmpSel       : Integer;

    qryRelatorio: TUniQuery;

    Function  fRetMaxEmpresas: Integer;
    function fVerificaEntFut: Boolean;
    function fTituloEntFut: String;

    procedure pAjustaColunas;
    procedure pVerificaMaxEmpresas;

    procedure pCriaQryRelatorio;

    procedure pGeraExcel(qryDados: TUniQuery);
    
    Procedure pAcertaLojas(rltBanda: TRLBand; strNomFin: String);

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelEstSaldoLoj: TfrmRelEstSaldoLoj;

implementation

uses untQckEstSaldoLoj, untFuncoesFactory, untGeraExcel, untPaiQck;

{$R *.dfm}

procedure TfrmRelEstSaldoLoj.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);
    If fEmptyStr(edtDesGrupo.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo.Clear;
      pSetFocus(mskLinhaGrupo);
    End;
  End;
end;

procedure TfrmRelEstSaldoLoj.mskLinhaGrupo2Exit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo2.Text) Then
    edtDesGrupo2.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo2.Text := fRetNomeLinhaGrupo(mskLinhaGrupo2.Text);
    If fEmptyStr(edtDesGrupo2.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo2.Clear;
      pSetFocus(mskLinhaGrupo2);
    End;
  End;
end;

procedure TfrmRelEstSaldoLoj.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstSaldoLoj.mskLinhaGrupo2KeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fPesqGrupo(Self, mskLinhaGrupo2, edtDesGrupo2, nil, Key, arrSel) Then  
  Begin
    If fValidaCampos(mskLinhaGrupo2, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstSaldoLoj.edtDestinoExit(Sender: TObject);
begin
  if edtDestino.Text <> 'E' then
  Begin
    pVerificaMaxEmpresas;
    inherited;
  End;

end;

procedure TfrmRelEstSaldoLoj.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtFornecedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtFornecedor.Clear;
    pSetFocus(edtFornecedor);
  End;

end;

procedure TfrmRelEstSaldoLoj.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstSaldoLoj.edtMarcaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := 'TODOS'
  Else
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);


  If fEmptyStr(edtDesMarca.Text) And (Not fEmptyStr(edtMarca.Text))  Then
  Begin
    fMensagem('AVISO','Código da marca não encontrado.', ['&O K']);
    edtMarca.Clear;
    pSetFocus(edtMarca);
  End;

end;

procedure TfrmRelEstSaldoLoj.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmRelEstSaldoLoj.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtOpcao) Then
    Begin
      If (edtOpcao.Text <> 'A') And (edtOpcao.Text <> 'L') Then
      Begin
        fMensagem('','O campo opcao deve ter A ou L!',['&O K'],0);
        Result := False;
      End;
    End
    Else

    If (Sender = mskLinhaGrupo) Then
    Begin
      mskLinhaGrupo2.Enabled := Not fEmptyStr(mskLinhaGrupo.Text);
    End
    Else

    If (Sender = mskLinhaGrupo2) Then
    Begin

      If Not fEmptyStr(mskLinhaGrupo2.Text) Then
      Begin

        If StrToInt(mskLinhaGrupo.Text) > StrToInt(mskLinhaGrupo2.Text) Then
        Begin
          fMensagem('','A Linha/Grupo inicial deve ser menor que a final!',['&O K']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;


function TfrmRelEstSaldoLoj.fVerificaEntFut: Boolean;
begin
  Result := Not (chkEntFut.Checked And ((Not chkAguarda.Checked) And (Not chkPrevisao.Checked) And (Not chkFalta.Checked)));
  If Not Result Then
    pMensagemOk('Informe os motivos da entrega futura que deseja considerar!');
end;

procedure TfrmRelEstSaldoLoj.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
  mskLinhaGrupo2.Clear;
  edtDesGrupo2.Text := '';
end;

procedure TfrmRelEstSaldoLoj.pAtualizaLst;
  Var
    strSQL     : String;
    intContador: Integer;
    qryGenEmp  : TUniQuery;

Begin
  Try

    qryGenEmp := fCriaQuery(Self);

    lstEmpresas.Items.Clear;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_CODEMP, ';
    strSQL := strSQL + '  EMP_NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP <> :CODEMP AND ';
    strSQL := strSQL + '  LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      While Not Eof Do
      Begin
        Application.ProcessMessages;

        lstEmpresas.Items.Add(FieldByName('EMP_CODEMP').AsString + ' - ' +
                              FieldByName('EMP_NOMEMP').AsString);

        Next;
      End;

      Close;
    End;

    For intContador := 0 To lstEmpresas.Items.Count -1 Do
       lstEmpresas.Checked[intContador] := True;

  Finally
    FreeAndNil(qryGenEmp);
  End;

  pVerificaMaxEmpresas;
End;

procedure TfrmRelEstSaldoLoj.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelEstSaldoLoj.pAjustaColunas;
  Var
    intContador: Integer;
    intLeft: Integer;
Begin
  If fCfgSis('CONENT', varBoolean) Then
  Begin
    If chkMarca.Checked Then
      intMaxColRetrato := 0
    Else
      intMaxColRetrato := 3;

  End Else
  Begin
    If chkMarca.Checked Then
      intMaxColRetrato := 2
    Else
      intMaxColRetrato := 5;
  End;

  if chkPreVen.Checked Then
    Dec(intMaxColRetrato);

  {*********************************************}
  {* VERIFICA SE EXIBE A REFERENCIA DO PRODUTO *}
  {******************************************JB*}
  if (not chkReferencia.Checked) and (not chkCodFabrica.Checked) then
  begin
    frmQckEstSaldoLoj.rllReferencia.Visible  := False;
    frmQckEstSaldoLoj.rdbRefereLin.Visible   := False;
    frmQckEstSaldoLoj.rdbRefereLin2.Visible  := False;
    frmQckEstSaldoLoj.rdbRefereAlfa.Visible  := False;
    frmQckEstSaldoLoj.rdbRefereAlfa2.Visible := False;

    frmQckEstSaldoLoj.rdbDescriLin.Width   := frmQckEstSaldoLoj.rdbDescriLin.Width +
                                              frmQckEstSaldoLoj.rdbRefereLin.Width +
                                              IIF(chkPreCom.Checked, 0, 68);
    frmQckEstSaldoLoj.rdbDescriLin2.Width  := frmQckEstSaldoLoj.rdbDescriLin.Width;
    frmQckEstSaldoLoj.rdbDescriAlfa.Width  := frmQckEstSaldoLoj.rdbDescriLin.Width;
    frmQckEstSaldoLoj.rdbDescriAlfa2.Width := frmQckEstSaldoLoj.rdbDescriLin.Width;
  end
  else
  begin
    frmQckEstSaldoLoj.rllReferencia.Caption    := IIF(chkReferencia.Checked, 'REFERENCIA', 'COD.FABRICA');
    frmQckEstSaldoLoj.rdbRefereLin.DataField   := IIF(chkReferencia.Checked, 'REFERE', 'CODFAB');
    frmQckEstSaldoLoj.rdbRefereLin2.DataField  := IIF(chkReferencia.Checked, 'REFERE', 'CODFAB');
    frmQckEstSaldoLoj.rdbRefereAlfa.DataField  := IIF(chkReferencia.Checked, 'REFERE', 'CODFAB');
    frmQckEstSaldoLoj.rdbRefereAlfa2.DataField := IIF(chkReferencia.Checked, 'REFERE', 'CODFAB');

    frmQckEstSaldoLoj.rllReferencia.Left  := frmQckEstSaldoLoj.rllReferencia.Left + IIF(chkPreCom.Checked, 0, 68);
    frmQckEstSaldoLoj.rdbRefereLin.Left   := frmQckEstSaldoLoj.rllReferencia.Left;
    frmQckEstSaldoLoj.rdbRefereLin2.Left  := frmQckEstSaldoLoj.rllReferencia.Left;
    frmQckEstSaldoLoj.rdbRefereAlfa.Left  := frmQckEstSaldoLoj.rllReferencia.Left;
    frmQckEstSaldoLoj.rdbRefereAlfa2.Left := frmQckEstSaldoLoj.rllReferencia.Left;
  end;

  if not chkPreCom.Checked then
  begin
    frmQckEstSaldoLoj.rllPreComTit.Visible   := False;
    frmQckEstSaldoLoj.rdbPreComLin.Visible   := False;
    frmQckEstSaldoLoj.rdbPreComLin2.Visible  := False;
    frmQckEstSaldoLoj.rdbPreComAlfa.Visible  := False;
    frmQckEstSaldoLoj.rdbPreComAlfa2.Visible := False;
  end;

  frmQckEstSaldoLoj.rllUni.Left     := frmQckEstSaldoLoj.rllUni.Left + IIF(chkPreCom.Checked, 0, 68);
  frmQckEstSaldoLoj.rdbUnLin.Left   := frmQckEstSaldoLoj.rllUni.Left;
  frmQckEstSaldoLoj.rdbUnLin2.Left  := frmQckEstSaldoLoj.rllUni.Left;
  frmQckEstSaldoLoj.rdbUnAlfa.Left  := frmQckEstSaldoLoj.rllUni.Left;
  frmQckEstSaldoLoj.rdbUnAlfa2.Left := frmQckEstSaldoLoj.rllUni.Left;

  frmQckEstSaldoLoj.rllMarcaTitulo.Left := frmQckEstSaldoLoj.rllMarcaTitulo.Left + IIF(chkPreCom.Checked, 0, 68);
  frmQckEstSaldoLoj.rdbMarcaLin.Left    := frmQckEstSaldoLoj.rllMarcaTitulo.Left;
  frmQckEstSaldoLoj.rdbMarcaLin2.Left   := frmQckEstSaldoLoj.rllMarcaTitulo.Left;
  frmQckEstSaldoLoj.rdbMarcaAlfa.Left   := frmQckEstSaldoLoj.rllMarcaTitulo.Left;
  frmQckEstSaldoLoj.rdbMarcaAlfa2.Left  := frmQckEstSaldoLoj.rllMarcaTitulo.Left;

  frmQckEstSaldoLoj.rllUltComTit.Left   := frmQckEstSaldoLoj.rllUltComTit.Left + IIF(chkPreCom.Checked, 0, 68);
  frmQckEstSaldoLoj.rdbUltComLin.Left   := frmQckEstSaldoLoj.rllUltComTit.Left;
  frmQckEstSaldoLoj.rdbUltComLin2.Left  := frmQckEstSaldoLoj.rllUltComTit.Left;
  frmQckEstSaldoLoj.rdbUltComAlfa.Left  := frmQckEstSaldoLoj.rllUltComTit.Left;
  frmQckEstSaldoLoj.rdbUltComAlfa2.Left := frmQckEstSaldoLoj.rllUltComTit.Left;

  With frmQckEstSaldoLoj Do
  Begin
    rllMarcaTitulo.Visible := chkMarca.Checked;
    rdbMarcaLin.Visible    := chkMarca.Checked;
    rdbMarcaLin2.Visible   := chkMarca.Checked;
    rdbMarcaAlfa.Visible   := chkMarca.Checked;
    rdbMarcaAlfa2.Visible  := chkMarca.Checked;

    rllUltComTit.Visible   := chkMarca.Checked;
    rdbUltComLin.Visible   := chkMarca.Checked;
    rdbUltComLin2.Visible  := chkMarca.Checked;
    rdbUltComAlfa.Visible  := chkMarca.Checked;
    rdbUltComAlfa2.Visible := chkMarca.Checked;

    rllPreVen.Visible      := chkPreVen.Checked;
    rdbPreVenLin.Visible   := chkPreVen.Checked;
    rdbPreVenLin2.Visible  := chkPreVen.Checked;
    rdbPreVenAlfa.Visible  := chkPreVen.Checked;
    rdbPreVenAlfa2.Visible := chkPreVen.Checked;

  End;

  With frmQckEstSaldoLoj Do
  Begin
    If Not chkMarca.Checked then
    Begin

      if chkPreCom.Checked then
      begin
        rllPreComTit.Left   := rllMarcaTitulo.Left;
        rdbPreComLin.Left   := rllMarcaTitulo.Left;
        rdbPreComLin2.Left  := rllMarcaTitulo.Left;
        rdbPreComAlfa.Left  := rllMarcaTitulo.Left;
        rdbPreComAlfa2.Left := rllMarcaTitulo.Left;
      end;

      rllSaldo.Left      := IIF(chkPreCom.Checked, (rllPreComTit.Left + 60), rllMarcaTitulo.Left);
      rdbSaldoLin.Left   := rllSaldo.Left;
      rdbSaldoLin2.Left  := rllSaldo.Left;
      rdbSaldoAlfa.Left  := rllSaldo.Left;
      rdbSaldoAlfa2.Left := rllSaldo.Left;
    End;

    intLeft := rllSaldo.Left + rllSaldo.Width;

    For intContador := 1 To intEmpSel Do
    Begin
      (fComponentByName(frmQckEstSaldoLoj.rlbTitulo, 'rllLoja' + IntToStr(intContador)) As TRLLabel).Left := intLeft;

      (fComponentByName(rlbDetalhe,       'rdbSaldoLoj' + IntToStr(intContador) + 'Alfa') As TRLDBText).Left  := intLeft;
      (fComponentByName(rlbDetalhe2,      'rdbSaldoLoj' + IntToStr(intContador) + 'Alfa2') As TRLDBText).Left := intLeft;
      (fComponentByName(rlbDetalheGrupo2, 'rdbSaldoLoj' + IntToStr(intContador) + 'Lin') As TRLDBText).Left   := intLeft;
      (fComponentByName(rlbDetalheGrupo3, 'rdbSaldoLoj' + IntToStr(intContador) + 'Lin2') As TRLDBText).Left  := intLeft;

      Inc(intLeft, (fComponentByName(frmQckEstSaldoLoj.rlbTitulo, 'rllLoja' + IntToStr(intContador)) As TRLLabel).Width);
    End;

    If edtOpcao.Text = 'A' Then
    Begin

      If Not fCfgSis('CONENT', varBoolean) Then
      Begin
        rdbTotalAlfa.Left  := intLeft;
        rllTotSaldo.Left   := intLeft;
        Inc(intLeft,rllTotSaldo.Width);

        rllPreVen.Left     := intLeft;
        rdbPreVenAlfa.Left := intLeft;

      End Else
      Begin
        rdbTotalAlfa2.Left := intLeft;
        rllTotSaldo.Left   := intLeft;
        Inc(intLeft,rllTotSaldo.Width);

        rllEstMin.Left     := intLeft;
        rdbEstMinAlfa.Left := intLeft;
        Inc(intLeft,rdbEstMinAlfa.Width);

        rllSujCom.Left     := intLeft;
        rllSujComAlfa.Left := intLeft;
        Inc(intLeft,rllSujCom.Width);

        rllPreVen.Left      := intLeft;
        rdbPreVenAlfa2.Left := intLeft;

      End;

    End
    Else
    Begin

      If Not fCfgSis('CONENT', varBoolean) Then
      Begin
        rdbTotalLin.Left   := intLeft;
        rllTotSaldo.Left   := intLeft;
        Inc(intLeft, rllTotSaldo.Width);

        rllPreVen.Left     := intLeft;
        rdbPreVenLin.Left  := intLeft;

      End Else
      Begin
        rdbTotalLin2.Left  := intLeft;
        rllTotSaldo.Left   := intLeft;
        Inc(intLeft, rllTotSaldo.Width);

        rllEstMin.Left     := intLeft;
        rdbEstMinLin.Left  := intLeft;
        Inc(intLeft, rdbEstMinLin.Width);

        rllSujCom.Left     := intLeft;
        rllSujComLin.Left  := intLeft;
        Inc(intLeft, rllSujCom.Width);

        rllPreVen.Left     := intLeft;
        rdbPreVenLin2.Left  := intLeft;
      End;

    End;

  End;

End;

Procedure TfrmRelEstSaldoLoj.pAcertaLojas(rltBanda: TRLBand; strNomFin: String);
  Var
    intContador: Integer;
    rllEmpresa   : TRLDBText;
    rllTitEmp    : TRLLabel;
Begin
  For intContador := 0 To lstEmpresas.Items.Count -1 Do
  Begin

    If lstEmpresas.Checked[intContador] Then
    Begin
      Inc(intEmpSel);
      rllEmpresa := (fComponentByName(rltBanda, 'rdbSaldoLoj' + IntToStr(intEmpSel) + strNomFin) As TRLDBText);
      rllEmpresa.DataField := 'SAL' + fStrZero(IntToStr(intContador),3);
      rllEmpresa.Visible   := True;

      rllTitEmp := (fComponentByName(frmQckEstSaldoLoj.rlbTitulo, 'rllLoja' + IntToStr(intEmpSel)) As TRLLabel);
      rllTitEmp.Caption := 'LOJA' + LeftStr(lstEmpresas.Items[intContador],3);
      rllTitEmp.Visible := True;
    End;

  End;
End;

procedure TfrmRelEstSaldoLoj.btnImprimirClick(Sender: TObject);
  Var
    strSQL       : String;
    strSQLTOT    : String;
    strSqlSaldos : String;
    strSqlBcaQtd : String;
    strSqlBcaTot : String;
    strTabPre    : String;
    intContador  : Integer;
begin
  If Not fVerificaEntFut Then
     Exit;

  Try
    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;

    strSQLTOT    := '0';
    strSqlBcaTot := '0';
    strSqlSaldos := '';
    strSqlBcaQtd := '';

    inherited;
    If blnImprime Then
    Begin
      intEmpSel := 0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  LEFT(I.ITE_CODGRU,3) AS LINHA, ';
      strSQL := strSQL + '  I.ITE_CODGRU AS GRUPO,  ';

      strSQL := strSQL + '  CONCAT(LEFT(I.ITE_CODGRU,3), "000", " - ", LIN.GRU_DESGRU) AS NOMLIN, ';//NOME DA LINHA
      strSQL := strSQL + '  CONCAT(I.ITE_CODGRU, " - ", GRU.GRU_DESGRU) AS NOMGRU, ';//NOME DO GRUPO

      strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
      strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
      strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
      strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
      strSQL := strSQL + '  ROUND((SELECT G2.ITE_PREULT FROM ITEGER G2 WHERE G2.ITE_CODITE = I.ITE_CODITE AND G2.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + '), 2) AS PRECOM, ';
      strSQL := strSQL + '  I.ITE_CODUNI AS UNIDAD, ';
      strSQL := strSQL + '  U.UNI_SIGUNI AS SIGUNI, ';
      strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
      strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';

      strSQL := strSQL + '  (SELECT DATE_FORMAT(IL.ITE_DTAULT, "%d/%m/%Y") FROM ITEGER IL WHERE IL.ITE_CODITE = I.ITE_CODITE AND IL.ITE_CODEMP = :EMPLOG) AS DTAULT, ';
      strSQL := strSQL + '  SUM(IF(G.ITE_CODEMP = :EMPLOG, G.ITE_ESTMIN, 0))       AS ESTMIN, ';

      {**********************************}
      {* ANALIZA QUANTAS EMPRESAS FORAM *}
      {* SELECIONADAS NO LISTBOX        *}
      {*******************************AF*}
      For intContador := 0 To lstEmpresas.Items.Count -1 Do
      Begin
        {********************************}
        {* MONTA O SELECT DE ACORDO COM *}
        {* O CODIGO DA EMPRESA          *}
        {*****************************AF*}
        If lstEmpresas.Checked[intContador] Then
        Begin
          strSQL := strSQL + '  SUM( IF( G.ITE_CODEMP = ' +
          QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ',G.ITE_SALDOS,0 ) ) ' +
          IfThen(fCfgSis('BEFTRG', VarBoolean)           , ' - SUM(IF(G.ITE_CODEMP = '+ QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ', ' + fGetSQLSomaCamposEntregaFutura() + ', 0)) ', '') +
          IfThen(chkEntFut.Checked And chkAguarda.Checked, ' + SUM(IF(G.ITE_CODEMP = '+ QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ', IFNULL(G.ITE_QTEF_A, 0), 0)) ', '') +
          IfThen(chkEntFut.Checked And chkFalta.Checked  , ' + SUM(IF(G.ITE_CODEMP = '+ QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ', IFNULL(G.ITE_QTEF_F, 0), 0)) ', '') +
          IfThen(chkEntFut.Checked And chkPrevisao.Checked,' + SUM(IF(G.ITE_CODEMP = '+ QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ', IFNULL(G.ITE_QTEF_P, 0), 0)) ', '') +
          ' AS SAL' + fStrZero(IntToStr(intContador),3) + ', ';

          {******************************************************}
          {* MONTA O CAMPO COM O TOTAL DE TODAS AS LOJAS SOMADO *}
          {** 23/04/2008 - 11:15 *****************************ER*}
//          strSQLTOT := strSQLTOT + ' + SUM(IF( G.ITE_CODEMP = ' + QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ',G.ITE_SALDOS,0 ) ) ';
          strSQLTOT := strSQLTOT + ' + SUM(IF( G.ITE_CODEMP = ' + QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ',G.ITE_SALDOS,0 )) ' +
                                   IfThen(fCfgSis('BEFTRG', VarBoolean)           , ' - SUM(IF(G.ITE_CODEMP = ' + QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ', ' + fGetSQLSomaCamposEntregaFutura() + ', 0)) ', '') +
                                   IfThen(chkEntFut.Checked And chkAguarda.Checked, ' + SUM(IF(G.ITE_CODEMP = ' + QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ', IFNULL(G.ITE_QTEF_A, 0), 0)) ', '') +
                                   IfThen(chkEntFut.Checked And chkFalta.Checked  , ' + SUM(IF(G.ITE_CODEMP = ' + QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ', IFNULL(G.ITE_QTEF_F, 0), 0)) ', '') +
                                   IfThen(chkEntFut.Checked And chkPrevisao.Checked,' + SUM(IF(G.ITE_CODEMP = ' + QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ', IFNULL(G.ITE_QTEF_P, 0), 0)) ', '');

          strSqlBcaTot := strSqlBcaTot + ' + (SELECT COUNT(*) QTDE FROM CADBCA WHERE BCA_CODITE = I.ITE_CODITE AND BCA_CODEMP = ' + QuotedStr(LeftStr(lstEmpresas.Items[intContador],3)) + ') ';

        End;

      End;

      strSqlSaldos := 'SUM( IF( G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ,G.ITE_SALDOS,0 ) )';
      strSqlSaldos := 'SUM( IF( G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ,G.ITE_SALDOS,0 ) ) ' +
                     IfThen(fCfgSis('BEFTRG', VarBoolean)           , ' - SUM(IF(G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ', ' + fGetSQLSomaCamposEntregaFutura() + ', 0))', '') +
                     IfThen(chkEntFut.Checked And chkAguarda.Checked, ' + SUM(IF(G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ', IFNULL(G.ITE_QTEF_A, 0), 0))', '') +
                     IfThen(chkEntFut.Checked And chkFalta.Checked  , ' + SUM(IF(G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ', IFNULL(G.ITE_QTEF_F, 0), 0))', '') +
                     IfThen(chkEntFut.Checked And chkPrevisao.Checked,' + SUM(IF(G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ', IFNULL(G.ITE_QTEF_P, 0), 0))', '');

      strSqlBcaQtd := ' (SELECT COUNT(*) QTDE FROM CADBCA WHERE BCA_CODITE = I.ITE_CODITE AND BCA_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') ';

      strSQL := strSQL + '(' + strSQLTOT + ' + ' + strSqlSaldos + ') AS SALTOT, ';
      strSQL := strSQL + '  ' + strSqlSaldos + ' AS SALDOS, ';
      strSQL := strSQL + '(' + strSqlBcaTot + ' + ' + strSqlBcaQtd + ') AS BCAQTD, ';

      strTabPre := Copy(cmbPrecos.Text, 8, 1);
      If fEmptyStr(strTabPre) Then
        strTabPre := '1';

      strSQL := strSQL + '  ROUND(SUM(IF(G.ITE_CODEMP = :EMPLOG, G.ITE_PREVE' + strTabPre + ', 0)), 2) AS PREVEN ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE I ';
      strSQL := strSQL + '  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
      strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';

      strSQL := strSQL + '  LEFT JOIN CADUNI U   ON   U.UNI_CODUNI = I.ITE_CODUNI ';//UNIDADE
      strSQL := strSQL + '  LEFT JOIN CADGRU LIN ON LIN.GRU_CODGRU = CONCAT(LEFT(I.ITE_CODGRU,3), "000") ';//LINHA
      strSQL := strSQL + '  LEFT JOIN CADGRU GRU ON GRU.GRU_CODGRU = I.ITE_CODGRU ';//GRUPO

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'TRUE  ';

      {*******************************************}
      {* VERIFICA MSKLINHAGRUPO E MSKLINHAGRUPO2 *}
      {* SE DIGITAR UMA LINHA ELE VAI MONTAR UM  *}
      {* SELECT PARA PEGAR TODOS OS GRUPOS DESTA *}
      {* LINHA TANTO NO MSKLINHAGRUPO QUANTO     *}
      {* MSKLINHAGRUPO2                          *}
      {****************************************AF*}
      If Not fEmptyStr(mskLinhaGrupo.Text) Then
      Begin
        {***********************************************}
        {* VERIFICA SE O QUE FOI DIGITADO EH UMA LINHA *}
        {********************************************AF*}
        If RightStr(mskLinhaGrupo.Text,3) = '000' Then
        Begin

          If Not fEmptyStr(mskLinhaGrupo2.Text) Then
          Begin

            If RightStr(mskLinhaGrupo2.Text,3) = '000' Then
              strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU,3) BETWEEN LEFT(:CODGRU,3) AND LEFT(:CODGRU2,3) '
            Else
              strSQL := strSQL + '  AND I.ITE_CODGRU BETWEEN CONCAT(LEFT(:CODGRU,3),"000") AND :CODGRU2 ';

          End
          Else
          Begin
            strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:CODGRU,3) ';
          End;

        End
        Else
        Begin

          If Not fEmptyStr(mskLinhaGrupo2.Text) Then
          Begin

            If RightStr(mskLinhaGrupo2.Text,3) = '000' Then
              strSQL := strSQL + '  AND I.ITE_CODGRU BETWEEN :CODGRU AND CONCAT(LEFT(:CODGRU2,3),"099") '
            Else
              strSQL := strSQL + '  AND I.ITE_CODGRU BETWEEN :CODGRU AND :CODGRU2 ';

          End
          Else
          Begin
            strSQL := strSQL + '  AND I.ITE_CODGRU = :CODGRU ';
          End;

        End;

      End;

      If Not fEmptyStr(edtFornecedor.Text) Then
      Begin
        strSQL := strSQL + '  AND I.ITE_CODFOR = :CODFOR ';
      End;

      If Not fEmptyStr(edtMarca.Text) Then
      Begin
        strSQL := strSQL + '  AND I.ITE_CODMAR = :CODMAR ';
      End;

      If Not fEmptyStr(edtDescri.Text) Then
      Begin
        //strSQL := strSQL + '  AND (LOCATE(:DESITE, I.ITE_DESITE) >0 ) ';
        strSQL := strSQL + '  AND  I.ITE_DESITE LIKE :DESITE  ';
      End;

      If Not fEmptyStr(edtRefere.Text) Then
      Begin
        strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';
      End;

      If Not fEmptyStr(edtUnidade.Text) Then
      Begin
        strSQL := strSQL + '  AND I.ITE_CODUNI = :CODUNI ';
      End;

      {***************************************}
      {STATUS: ATIVO, INATIVO E TODOS         }
      {************************************RL*}
      If rdgStatus.ItemIndex = 0 Then
        strSQL := strSQL + '  AND I.ITE_ITEATI = "S" '
      Else If rdgStatus.ItemIndex = 1 Then
        strSQL := strSQL + '  AND I.ITE_ITEATI = "N" ';

      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  CODITE ';

      {***************************************************}
      {* FILTRO PARA MOSTRAR ESTOQUE POSITIVO, NEGATIVO, *}
      {* TODOS OU ZERO                                   *}
      {** 23/04/2008 - 11:18 **************************ER*}
      Case rdgSaldos.ItemIndex Of
        0: strSQL := strSQL + ' HAVING SALTOT > 0 ';
        1: strSQL := strSQL + ' HAVING SALTOT < 0 ';
        2: strSQL := strSQL + ' HAVING SALTOT = 0 ';
      End;

      {********************************************************}
      {* FILTRO CONSIDERA SE O PRODUTO ESTA´ EM BOCA DE CAIXA *}
      {** 18/04/2012 ***************************************CI*}
      If rdgBocaCaixa.ItemIndex = 0 Then
      Begin
        If Pos('HAVING', strSQL) <= 0 Then
          strSQL := strSQL + '  HAVING '
        Else
          strSQL := strSQL + '  AND ';

        strSQL := strSQL + ' BCAQTD > 0 '
      End
      Else If rdgBocaCaixa.ItemIndex = 1 Then
      Begin

        If Pos('HAVING', strSQL) <= 0 Then
          strSQL := strSQL + '  HAVING '
        Else
          strSQL := strSQL + '  AND ';

        strSQL := strSQL + ' BCAQTD = 0 ';

      End;

      strSQL := strSQL + 'ORDER BY ';

      If edtOpcao.Text = 'L' Then
      Begin
        strSQL := strSQL + '  I.ITE_CODGRU, ';
      End;

      strSQL := strSQL + '  I.ITE_DESITE ';

      With  qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('EMPLOG').AsString := VS_strCodEmp;
        
        If Not fEmptyStr(mskLinhaGrupo.Text) Then
        Begin
          ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;
        End;

        If Not fEmptyStr(mskLinhaGrupo2.Text) Then
        Begin
          ParamByName('CODGRU2').AsString := mskLinhaGrupo2.Text;
        End;

        If Not fEmptyStr(edtFornecedor.Text) Then
        Begin
          ParamByName('CODFOR').AsString := edtFornecedor.Text;
        End;

        If Not fEmptyStr(edtMarca.Text) Then
        Begin
          ParamByName('CODMAR').AsString := edtMarca.Text;
        End;

        If Not fEmptyStr(edtDescri.Text) Then
        Begin
          ParamByName('DESITE').AsString := edtDescri.Text + '%';
        End;

        If Not fEmptyStr(edtRefere.Text) Then
        Begin
          ParamByName('REFERE').AsString := edtRefere.Text + '%';
        End;

        If Not fEmptyStr(edtUnidade.Text) Then
        Begin
          ParamByName('CODUNI').AsString := edtUnidade.Text;
        End;

        Open;

        TFloatField(FieldByName('PREVEN')).DisplayFormat := fMskDigitos( fCfgSis('DECUNI',VarInteger) );
        TFloatField(FieldByName('PRECOM')).DisplayFormat := fMskDigitos( fCfgSis('DECUNI',VarInteger) );
      End;

      If Not  qryRelatorio.IsEmpty Then
      Begin

        If edtDestino.Text = 'E' then
          pGeraExcel( qryRelatorio)
        Else
        Begin 

          Try
            pCriarFormularios(TfrmQckEstSaldoLoj,frmQckEstSaldoLoj);

            frmQckEstSaldoLoj.dtsRelatorio.DataSet := qryRelatorio;

            If strTipImp = 'M' Then
              frmQckEstSaldoLoj.qckPagina.DefaultFilter := rldFiltro
            Else
              frmQckEstSaldoLoj.qckPagina.DefaultFilter := Nil;

            {*********************}
            {* HEADER FORNECEDOR *}
            {******************AF*}
            If Not fEmptyStr(edtFornecedor.Text) Then
              frmQckEstSaldoLoj.strOrdem := 'FORNECEDOR: ' + edtFornecedor.Text + ' - ' + edtDesFornecedor.Text
            Else
              frmQckEstSaldoLoj.strOrdem := 'FORNECEDOR: TODOS';
            {******************}
            {* HEADER GRUPO 1 *}
            {***************AF*}
            If Not fEmptyStr(mskLinhaGrupo2.Text) Then
              frmQckEstSaldoLoj.rllGrupo.Caption := 'LINHA/GRUPO INICIAL: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text
            Else
              frmQckEstSaldoLoj.rllGrupo.Caption := 'LINHA/GRUPO INICIAL: TODOS';
            {******************}
            {* HEADER GRUPO 2 *}
            {***************AF*}
            If Not fEmptyStr(mskLinhaGrupo2.Text) Then
              frmQckEstSaldoLoj.rllGrupoFin.Caption := 'LINHA/GRUPO FINAL: ' + mskLinhaGrupo2.Text + ' - ' + edtDesGrupo2.Text
            Else
              frmQckEstSaldoLoj.rllGrupoFin.Caption := 'LINHA/GRUPO FINAL: TODOS';
            {******************}
            {* HEADER UNIDADE *}
            {***************AF*}
            If Not fEmptyStr(edtUnidade.Text) Then
              frmQckEstSaldoLoj.rllUnidade.Caption := 'UNIDADE: ' + edtUnidade.Text
            Else
              frmQckEstSaldoLoj.rllUnidade.Caption := 'UNIDADE: TODAS';
            {****************}
            {* HEADER MARCA *}
            {*************AF*}
            If Not fEmptyStr(edtMarca.Text) Then
              frmQckEstSaldoLoj.rllMarcaOrd.Caption := 'MARCA: ' + edtMarca.Text + ' - ' + edtDesMarca.Text
            Else
              frmQckEstSaldoLoj.rllMarcaOrd.Caption := 'MARCA: TODAS';
            {*****************}
            {* HEADER DESCRI *}
            {**************AF*}
            If Not fEmptyStr(edtDescri.Text) Then
              frmQckEstSaldoLoj.rllDescri.Caption := 'DESCRICAO: ' + edtDescri.Text
            Else
              frmQckEstSaldoLoj.rllDescri.Caption := 'DESCRICAO: TODAS';
            {*********************}
            {* HEADER REFERENCIA *}
            {******************AF*}
            If Not fEmptyStr(edtRefere.Text) Then
              frmQckEstSaldoLoj.rllRef.Caption := 'REFERENCIA: ' + edtRefere.Text
            Else
              frmQckEstSaldoLoj.rllRef.Caption := 'REFERENCIA: TODAS';

            {***************************************}
            {HEADER STATUS: ATIVO, INATIVO E TODOS  }
            {************************************RL*}
            frmQckEstSaldoLoj.rllStatus.Caption := 'STATUS: TODOS';
            If rdgStatus.ItemIndex = 0 Then
              frmQckEstSaldoLoj.rllStatus.Caption := 'STATUS: ATIVO'
            Else If rdgStatus.ItemIndex = 1 Then
              frmQckEstSaldoLoj.rllStatus.Caption := 'STATUS: INATIVO';

            {*************************************}
            {HEADER BOCA CAIXA: SIM, NÃO E TODOS  }
            {**********************************CI*}
            frmQckEstSaldoLoj.rllBcaCxa.Caption := 'BOCA CAIXA: TODOS';
            If rdgBocaCaixa.ItemIndex = 0 Then
              frmQckEstSaldoLoj.rllBcaCxa.Caption := 'BOCA CAIXA: SIM'
            Else If rdgBocaCaixa.ItemIndex = 1 Then
              frmQckEstSaldoLoj.rllBcaCxa.Caption := 'BOCA CAIXA: NÃO';

            {*********************************}
            {* HEADER EMPRESAS DEPENDENDO DA *}
            {* SELEÇÃO NO LISTBOX            *}
            {******************************CI*}

            frmQckEstSaldoLoj.rllEmpresa.Caption := 'EMPRESA: ' + VS_strCodEmp;
            For intContador := 0 To lstEmpresas.Items.Count -1 Do
            Begin
              If lstEmpresas.Checked[intContador] Then
              Begin
                frmQckEstSaldoLoj.rllEmpresa.Caption := frmQckEstSaldoLoj.rllEmpresa.Caption +  ' / ' +
                                                        LeftStr(lstEmpresas.Items[intContador],3);
              End;
            End;

            if chkPreVen.Checked Then
              frmQckEstSaldoLoj.rllPre.Caption := 'PREÇO DE VENDA: ' + UpperCase(cmbPrecos.Text)
            Else
              frmQckEstSaldoLoj.rllPre.Caption := 'PREÇO DE VENDA: NÃO EXIBIR';
            frmQckEstSaldoLoj.rllEntregaFutura.Caption := fTituloEntFut;
            If edtOpcao.Text = 'A' Then
            Begin

              If Not fCfgSis('CONENT', varBoolean) Then
              Begin
                frmQckEstSaldoLoj.rlbDetalhe.Visible := True;
                pAcertaLojas(frmQckEstSaldoLoj.rlbDetalhe, 'Alfa');
              End

              Else
              Begin
                frmQckEstSaldoLoj.rlbDetalhe2.Visible := True;
                pAcertaLojas(frmQckEstSaldoLoj.rlbDetalhe2, 'Alfa2');

                frmQckEstSaldoLoj.rllEstMin.Visible     := True;
                frmQckEstSaldoLoj.rllSujCom.Visible     := True;

                frmQckEstSaldoLoj.rdbEstMinAlfa.Visible := True;
                frmQckEstSaldoLoj.rllSujComAlfa.Visible := True;
              End;

            End
            Else
            Begin

              If Not fCfgSis('CONENT', varBoolean) Then
              Begin
                frmQckEstSaldoLoj.rlbGrupo.Visible := True;
                pAcertaLojas(frmQckEstSaldoLoj.rlbDetalheGrupo2, 'Lin');
              End

              Else
              Begin
                frmQckEstSaldoLoj.rlbGrupo3.Visible := True;
                pAcertaLojas(frmQckEstSaldoLoj.rlbDetalheGrupo3, 'Lin2');

                frmQckEstSaldoLoj.rllEstMin.Visible     := True;
                frmQckEstSaldoLoj.rllSujCom.Visible     := True;

                frmQckEstSaldoLoj.rdbEstMinLin.Visible := True;
                frmQckEstSaldoLoj.rllSujComLin.Visible := True;
              End;

            End;

            frmQckEstSaldoLoj.rllTotSaldo.Visible := True;
            frmQckEstSaldoLoj.rdbTotalLin.Visible := True;
            frmQckEstSaldoLoj.rdbTotalLin2.Visible := True;
            frmQckEstSaldoLoj.rdbTotalAlfa.Visible := True;
            frmQckEstSaldoLoj.rdbTotalAlfa2.Visible := True;

            frmQckEstSaldoLoj.intQtdEmp := intEmpSel;

            pAjustaColunas;

            If intEmpSel > intMaxColRetrato Then
            Begin
              frmQckEstSaldoLoj.qckPagina.PageSetup.Orientation := poLandScape;
            End
            Else Begin
              frmQckEstSaldoLoj.qckPagina.PageSetup.Orientation := poPortrait;
            End;

            {***************************************************}
            {* STRINGLIST QUE CONTERÁ AS POSIÇÕES DAS EMPRESAS *}
            {* QUE ESTÃO MARCADAS NO CHECKLISTBOX              *}
            {** 23/04/2008 - 13:40 **************************ER*}
            frmQckEstSaldoLoj.lstEmpCheck := TStringList.Create;
            For intContador := 0 to lstEmpresas.Items.Count -1 Do
            Begin
              If lstEmpresas.Checked[intContador] Then
                frmQckEstSaldoLoj.lstEmpCheck.Add(IntToStr(intContador));
            End;

            If edtDestino.Text = 'V' Then
              pPreviewReport(Self.Name, Self.Caption, frmQckEstSaldoLoj.qckPagina, frmQckEstSaldoLoj.rpsSetup)
            Else
              pPrintReport(Self.Name, Self.Caption, strNomImp, frmQckEstSaldoLoj.qckPagina);

            FreeAndNil(frmQckEstSaldoLoj.lstEmpCheck);
          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
            End;
          End;
          pFreeAndNil(frmQckEstSaldoLoj);

        End;
      End
      Else
        pTabelaVazia;

    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[]');
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
  pSetFocus(mskLinhaGrupo);

end;

procedure TfrmRelEstSaldoLoj.FormShow(Sender: TObject);
  Var
    intIndex : Integer;
begin
  inherited;

  pCriaQryRelatorio;
  pAtualizaLst;

  cmbPrecos.Items.Clear;
  For intIndex := 1 to Length(VS_strTabPrc) Do
  Begin
    if VS_strTabPrc[intIndex] = 'S' Then
      cmbPrecos.Items.Add('Tabela ' + intToStr(intIndex) );

  End;

End;

procedure TfrmRelEstSaldoLoj.lstEmpresasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) Then
  Begin
    SelectNext(ActiveControl,True,True);
  End;

end;

Function TfrmRelEstSaldoLoj.fRetMaxEmpresas: Integer;
Begin
  If chkMarca.Checked then
  Begin
    If fCfgSis('CONENT', varBoolean) then
      Result := 6
    Else
      Result := 8
  End Else
  Begin
    If fCfgSis('CONENT', varBoolean) then
      Result := 8
    Else
      Result := 10;
  End;

  if chkPreVen.Checked Then
    Dec(Result);

End;

procedure TfrmRelEstSaldoLoj.pVerificaMaxEmpresas;
  Var
    intContador: Integer;
    intMarcados: Integer;
Begin
  intMarcados := 0;
  For intContador := 0 To lstEmpresas.Count - 1 Do
  Begin
    If lstEmpresas.Checked[intContador] Then
      Inc(intMarcados);
      
    If intMarcados > fRetMaxEmpresas Then
      lstEmpresas.Checked[intContador] := False;
  End;
End;

procedure TfrmRelEstSaldoLoj.lstEmpresasClickCheck(Sender: TObject);
  Var
    intContador2: Integer;
begin
  inherited;
  {***********************************}
  {* CONTA QUANTAS EMPRESAS JÁ ESTÃO *}
  {* SELECIONADAS                    *}
  {********************************AF*}
  intContador2 := fContaSelecoes;

  If (edtDestino.Text <> 'E') Then
  Begin
    if intContador2 > fRetMaxEmpresas Then
    Begin
      lstEmpresas.Checked[lstEmpresas.ItemIndex] := False;
      fMensagem('ATENÇÃO!', 'Para selecionar todas as lojas, use a opção Excel.', ['&O k']);
    End;
    
{    If fCfgSis('CONENT', varBoolean) Then
    Begin
      If (intContador2 > 8) Then
      Begin
        lstEmpresas.Checked[lstEmpresas.ItemIndex] := False;
        fMensagem('ATENÇÃO!', 'Para selecionar todas as lojas, use a opção Excel.', ['&O k']);
      End;

      If (intContador2 > 6) Then
       chkMarca.Checked := False;
    End
    Else
    Begin
      If (intContador2 > 10) Then
      Begin
        lstEmpresas.Checked[lstEmpresas.ItemIndex] := False;
        fMensagem('ATENÇÃO!', 'Para selecionar todas as lojas, use a opção Excel.', ['&O k']);
      End;

      If (intContador2 > 8) Then
       chkMarca.Checked := False;
    End;}

  End;
end;

{***********************************}
{* CONTA QUANTAS EMPRESAS JÁ ESTÃO *}
{* SELECIONADAS                    *}
{********************************AF*}
function TfrmRelEstSaldoLoj.fContaSelecoes: Integer;
  Var
    intContador: Integer;
begin
  Result := 0;

  For intContador := 0 To lstEmpresas.Items.Count -1 Do
  Begin

    If lstEmpresas.Checked[intContador] Then
      Inc(Result);

  End;

end;

procedure TfrmRelEstSaldoLoj.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, arrSel) Then  
  Begin
    fvalidaCampos(edtUnidade,False);
    self.SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmRelEstSaldoLoj.edtUnidadeExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(fRetNomUnidade(edtUnidade.Text)) And (Not fEmptyStr(edtUnidade.Text))  Then
  Begin
    fMensagem('AVISO','Código da Unidade não encontrado.', ['&O K']);
    edtUnidade.Clear;
    pSetFocus(edtUnidade);
  End;

end;

procedure TfrmRelEstSaldoLoj.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskLinhaGrupo);
end;

procedure TfrmRelEstSaldoLoj.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstSaldoLoj.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) Then
    If (ActiveControl.Parent = rdgStatus) Or
       (ActiveControl.Parent = rdgBocaCaixa) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelEstSaldoLoj.chkEntFutClick(Sender: TObject);
begin
  inherited;
  grbMotFut.Enabled := chkEntFut.Checked;
  If Not chkEntFut.Checked Then
  Begin
    chkFalta.Checked := False;
    chkPrevisao.Checked := False;
    chkAguarda.Checked := False;
  End;
end;

procedure TfrmRelEstSaldoLoj.chkMarcaClick(Sender: TObject);
begin
  inherited;
  pVerificaMaxEmpresas;
end;

procedure TfrmRelEstSaldoLoj.chkPreVenClick(Sender: TObject);
begin
  inherited;
  cmbPrecos.Enabled := chkPreVen.Checked;

  if (cmbPrecos.Enabled) and (cmbPrecos.ItemIndex < 0) then
    cmbPrecos.ItemIndex := 0;

  pVerificaMaxEmpresas;
end;

procedure TfrmRelEstSaldoLoj.chkReferenciaClick(Sender: TObject);
begin
  inherited;

  if TCheckBox(Sender).Checked then
  begin
    chkCodFabrica.Checked := IIF(Sender = chkReferencia, False, True);
    chkReferencia.Checked := IIF(Sender = chkCodFabrica, False, True);
  end;
end;

procedure TfrmRelEstSaldoLoj.pGeraExcel(qryDados: TUniQuery);
  Var
    objGeraExcel: TGeraExcel;
    intContador: Integer;
    strEmpresa: String;
begin

  objGeraExcel := TGeraExcel.Create(qryDados, pgbProgresso);

  objGeraExcel.AddCampo( 'CODITE', 'CODIGO');
  objGeraExcel.AddCampo( 'DESITE', 'DESCRICAO');

  if chkReferencia.Checked then
    objGeraExcel.AddCampo( 'REFERE', 'REFERENCIA');

  if chkCodFabrica.Checked then
    objGeraExcel.AddCampo( 'CODFAB', 'COD.FABRICA');

  objGeraExcel.AddCampo( 'SIGUNI', 'UN');

  If chkMarca.Checked Then
  Begin
    objGeraExcel.AddCampo( 'DESMAR', 'MARCA');
    objGeraExcel.AddCampo( 'DTAULT', 'ULT.COMPRA');
  End;

  if chkPreCom.Checked then
    objGeraExcel.AddCampo( 'PRECOM', 'PRE.COMPRA');

  objGeraExcel.AddCampo( 'SALDOS', 'SALDOS');

  For intContador := 0 To lstEmpresas.Items.Count -1 Do
    If lstEmpresas.Checked[intContador] Then
      objGeraExcel.AddCampo( 'SAL' + fStrZero(IntToStr(intContador),3), 'LOJA ' + LeftStr(lstEmpresas.Items[intContador],3));

  objGeraExcel.AddCampo( 'SALTOT', 'SALDO TOTAL');

  if chkPreVen.Checked Then
    objGeraExcel.AddCampo( 'PREVEN', 'PREÇO DE VENDA', fCfgSis('DECUNI', varInteger));


  If edtOpcao.Text = 'L' Then
  Begin
    objGeraExcel.AddQuebra('NOMLIN', 'LINHA: ');
    objGeraExcel.AddQuebra('NOMGRU', 'GRUPO: ');
  End;

  objGeraExcel.AddFiltro('FORNECEDOR: '          + ifthen(fEmptyStr(edtFornecedor.Text), 'TODOS', edtFornecedor.Text + '-' + edtDesFornecedor.Text));
  objGeraExcel.AddFiltro('LINHA/GRUPO INICIAL: ' + ifthen(fEmptyStr(mskLinhaGrupo.Text), 'TODAS', mskLinhaGrupo.Text + '-' + edtDesGrupo.Text));
  objGeraExcel.AddFiltro('LINHA/GRUPO FINAL: '   + ifthen(fEmptyStr(mskLinhaGrupo2.Text),'TODAS', mskLinhaGrupo2.Text + '-' + edtDesGrupo2.Text));
  objGeraExcel.AddFiltro('UNIDADE: '             + ifthen(fEmptyStr(edtUnidade.Text),    'TODAS', edtUnidade.Text));
  objGeraExcel.AddFiltro('MARCA: '               + ifthen(fEmptyStr(edtMarca.Text),      'TODAS', edtMarca.Text + '-' + edtDesMarca.Text));
  objGeraExcel.AddFiltro('DESCRICAO: '           + ifthen(fEmptyStr(edtDescri.Text),     'TODAS', edtDescri.Text));
  objGeraExcel.AddFiltro('REFERENCIA: '          + ifthen(fEmptyStr(edtRefere.Text),     'TODAS', edtRefere.Text));
  objGeraExcel.AddFiltro('STATUS: '              + ifthen(rdgStatus.ItemIndex = 0, 'ATIVO', ifthen(rdgStatus.ItemIndex = 1, 'INATIVO', 'TODOS')));
  objGeraExcel.AddFiltro('BOCA CAIXA: '          + ifthen(rdgBocaCaixa.ItemIndex = 0, 'SIM', ifthen(rdgBocaCaixa.ItemIndex = 1, 'NÃO', 'TODOS')));

  {**********************************************}
  {* EMPRESAS DEPENDENDO DA SELEÇÃO NO LISTBOX  *}
  {*******************************************CI*}
  strEmpresa := 'EMPRESA: ' + VS_strCodEmp;
  For intContador := 0 To lstEmpresas.Items.Count -1 Do
  Begin
    If lstEmpresas.Checked[intContador] Then
      strEmpresa := strEmpresa +  ' / ' + LeftStr(lstEmpresas.Items[intContador],3);
  End;
  objGeraExcel.AddFiltro(strEmpresa);

  if chkPreVen.Checked Then
    objGeraExcel.AddFiltro('PREÇO DE VENDA: ' + UpperCase(cmbPrecos.Text))
  Else
    objGeraExcel.AddFiltro('PREÇO DE VENDA: NÃO EXIBIR');
  objGeraExcel.AddFiltro(fTituloEntFut);

  objGeraExcel.strNomRel := 'RELATORIO DE SALDOS DE ESTOQUES DAS LOJAS';

  If objGeraExcel.fGerarRelatorio Then
    fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

  FreeAndNil(objGeraExcel);

end;

Function TfrmRelEstSaldoLoj.fTituloEntFut: String;
Begin
  If chkEntFut.Checked Then
  Begin
    Result := 'CONSIDERAR ENTREGA FUTURA PENDENTE NO SALDO DO PRODUTO PARA: ';

    If chkAguarda.Checked Then
      Result := Result + ' AGUANDANDO CLIENTE - ';

    If chkPrevisao.Checked Then
      Result := Result + 'PREVISÃO DE ENTREGA - ';

    If chkFalta.Checked Then
      Result := Result + 'FALTA PRODUTO';

  End Else
  Begin
    Result := 'CONSIDERAR ENTREGA FUTURA PENDENTE NO SALDO DO PRODUTO: NAO';
  End;
End;



end.
