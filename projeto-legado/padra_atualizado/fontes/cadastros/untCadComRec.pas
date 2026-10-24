{*********************************************************}
{* CADASTRO DE FAIXAS DE COMISSÃO POR RECEBIMENTO        *}
{*                                                       *}
{* DATA......: 06/09/2010                                *}
{* AUTOR.....: IVAN RICARDO SOUZA ARRUE                  *}
{*                                                       *}
{******************************************************IV*}
unit untCadComRec;

interface

uses
  Windows, Classes, Controls, Forms, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  Uni, ExtCtrls, DB, Grids, DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, EditFocus, Graphics,
  untComRec, untPaiCad, BitBtnLockedIncrem, ComboBoxFocus, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, UniClientDataSet, untFuncoesConsulta;

type
  TfrmCadComRec = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dtsComRec: TDataSource;
    pnlGrid: TPanel;
    Label12: TLabel;
    dtsDados: TDataSource;
    pnlLegenda: TPanel;
    Label3: TLabel;
    pnlDados: TPanel;
    pnlCentro: TPanel;
    dbgDados: TDBGridCitel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtRecIni: TEditFocus;
    edtRecFin: TEditFocus;
    edtPerCom: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    pnlTopo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label24: TLabel;
    dbeCodRec: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    cbbTipOpe: TComboBoxFocus;
    pnlEmpresa: TPanel;
    Label11: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TDBEditFocus;
    btnHeranca: TBitBtnLocked;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lblCodDep: TLabel;
    dbeCodDep: TDBEditFocus;
    edtDesDep: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodRecExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure dtsComRecStateChange(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnHerancaClick(Sender: TObject);
    procedure dbeCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objComRec: TComRec;
    strAutIncAlt: String;
    blnRecEmp: Boolean;
    arrEmp: TConsultasArray;

    procedure pLimpaCampos;
    procedure pCarregaTipoOperador;
    procedure pCarregaEmpresa;
    procedure pMontaListaTipOpe;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; Override;
  end;

Const
  arrTipOpe: Array[0..7] Of String = ('A','C','I','E','D','S','G','M');

implementation

uses SysUtils, untFuncoesSimples, untConstantes, untConsultas,
  untHerancaFaixaComissao;

{$R *.dfm}

procedure TfrmCadComRec.FormCreate(Sender: TObject);
begin
  objComRec := TComRec.Create(Self);
  inherited;

  blnRecEmp          := fCfgSis('RECEMP', VarBoolean);
  pnlEmpresa.Visible := blnRecEmp;
  pnlDados.Height    := IIF(blnRecEmp, pnlDados.Height, pnlDados.Height - pnlEmpresa.Height);
  btnHeranca.Visible := blnRecEmp;
  Bevel1.Visible     := blnRecEmp;
  Bevel2.Visible     := blnRecEmp;

  If blnRecEmp Then
    strNomeTabela := 'RECCOM'
  Else
    strNomeTabela := 'COMREC';

  strNomeCampo  := 'COM_CODTAB';
  qryTabela     := objComRec.qryTabela;
  dtsComRec.DataSet := qryTabela;
  dtsDados.DataSet  := objComRec.cdsDados;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodRec;
  pMontaListaTipOpe;
  pHabilitaCodigo(dbeCodRec, dbeDescricao, False);
  strAutIncAlt := '';
end;

procedure TfrmCadComRec.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objComRec);
end;

procedure TfrmCadComRec.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadComRec.pCarregaEmpresa;
begin
  If blnRecEmp Then
    edtNomEmp.Text := fRetNomeEmpresaSelec(qryTabela.FieldByName('COM_CODEMP').AsString)
  Else
    edtNomEmp.Text := '';
end;

procedure TfrmCadComRec.pCarregaTipoOperador;
  Var
    intCont : Integer;
begin
  cbbTipOpe.ItemIndex := -1;

  For intCont := Low(arrTipOpe) To High(arrTipOpe) Do
  Begin
    If (arrTipOpe[intCont] = objComRec.cdsDados.FieldByName('COM_TIPOPE').AsString) Then
      cbbTipOpe.ItemIndex := intCont;
  End;
end;

procedure TfrmCadComRec.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COM_CODTAB');
  stlCampos.Add('COM_DESCRI');

  If blnRecEmp Then
    stlCampos.Add('COM_CODEMP');

  stlCampos.Add('COM_RECINI');
  stlCampos.Add('COM_RECFIN');
  stlCampos.Add('COM_PERCOM');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COM_CODTAB+COM_RECINI+COM_RECFIN');
  stlCamInd.Add('COM_DESCRI');

  If blnRecEmp Then
    stlCamInd.Add('COM_CODEMP');

  stlCamInd.Add('COM_CODTAB');

  stlDesInd.Add('Código/Recebimento Inicial/Recebimento Final');
  stlDesInd.Add('Descrição');

  If blnRecEmp Then
    stlDesInd.Add('Empresa');

  stlDesInd.Add('Código');
end;

procedure TfrmCadComRec.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnRecEmp Then
    pHabilitaCodigo(edtCodEmp, dbeCodRec, True);

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodRec, dbeDescricao, False)
  Else
    pHabilitaCodigo(dbeCodRec, dbeCodRec, True);

  objComRec.cdsDados.EmptyDataSet;

  qryTabela.FieldByName('COM_CODEMP').AsString := VS_strCodEmp;
  pCarregaEmpresa;

  cbbTipOpe.ItemIndex := -1;
  edtDesDep.Text := '';
  dbgDados.Enabled := True;
  dbgDados.Repaint;
  btnHeranca.Enabled := True;
  edtCodEmp.Color := clWindow;
end;

procedure TfrmCadComRec.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If blnRecEmp Then
    pHabilitaCodigo(edtCodEmp, dbeDescricao, False);

  pHabilitaCodigo(dbeCodRec, dbeDescricao, False);
  dbgDados.Enabled := True;
  dbgDados.Repaint;
end;

procedure TfrmCadComRec.pLimpaCampos;
begin
  edtRecIni.Text := '0,00';
  edtRecFin.Text := '0,00';
  edtPerCom.Text := '0,00';
  dbgDados.Enabled := False;

  If Not fEmptyStr(dbeCodDep.Text) Then
    edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [dbeCodDep.Text])
  Else
    edtDesDep.Text := '';
end;

procedure TfrmCadComRec.pMontaListaTipOpe;
begin
  cbbTipOpe.Items.Clear;
  cbbTipOpe.Items.Add('Administrativo');
  cbbTipOpe.Items.Add('Compras');
  cbbTipOpe.Items.Add('Vendedor Interno');
  cbbTipOpe.Items.Add('Representante Externo Loja');
  cbbTipOpe.Items.Add('Representante Externo Distribuidor');
  cbbTipOpe.Items.Add('Sub-Gerente');
  cbbTipOpe.Items.Add('Gerente');

  If fCfgSis('AUTCEN', VarBoolean) Then
    cbbTipOpe.Items.Add('Mecânico');
end;

function TfrmCadComRec.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  function fCheckRange(fltFat: Double): Boolean;
    Var
      cdsAux: TUniClientDataSet;
  begin
    Result := True;

    cdsAux := TUniClientDataSet.Create(Nil);

    Try
      pCloneDataSet(cdsAux, objComRec.cdsDados);

      cdsAux.First;
      While Not cdsAux.Eof Do
      Begin
        If (cdsAux.FieldByName('AUTOINCREM').AsString = strAutIncAlt) Then
        Begin
          cdsAux.Next;
          Continue;
        End;

        If (fltFat >= cdsAux.FieldByName('COM_RECINI').AsFloat) And (fltFat <= cdsAux.FieldByName('COM_RECFIN').AsFloat) Then
        Begin
          Result := False;
          Exit;
        End;

        cdsAux.Next;
      End;
    Finally
      FreeAndNil(cdsAux);
    End;
  end;
begin
  Result := True;

  Try

    If (Sender = dbeCodRec) Then
    Begin
      objComRec.strCodTab := dbeCodRec.Text;

      if (dbeCodRec.Enabled) And fEmptyStr(dbeCodRec.Text) then
      Begin
        fMensagem('ATENÇÃO','O código deve ser preenchido!',['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = dbeDescricao Then
    Begin
      objComRec.strDescri := dbeDescricao.Text;

      if fEmptyStr(dbeDescricao.Text) then
      begin
        fMensagem('ATENÇÃO','A descrição deve ser preenchida!',['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = cbbTipOpe Then
    Begin
      If fEmptyStr(arrTipOpe[cbbTipOpe.ItemIndex]) Then
      Begin
        fMensagem('ATENÇÃO','O Tipo de Operador deve ser selecionado!',['&Ok']);
        Result := False;
      End
      Else
      Begin
        If objComRec.fTipOpeCadastrado(arrTipOpe[cbbTipOpe.ItemIndex], dbeCodDep.Text) Then
        Begin
          fMensagem('ATENÇÃO','Já existe uma faixa cadastrada para este Tipo de Operador!',['&Ok']);
          Result := False;
        End
        Else
          objComRec.strTipOpe := arrTipOpe[cbbTipOpe.ItemIndex]
      End;
    End

    Else If (Sender = dbeCodDep) Then
    Begin
      objComRec.strCodDep := '';

      If (fEmptyStr(dbeCodDep.Text)) Then
        edtDesDep.Clear
      Else
      Begin
        edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [dbeCodDep.Text]);
        If fEmptyStr(edtDesDep.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse departamento não está cadastrado!',['&OK']);
          Result := False;
        End
        Else
          objComRec.strCodDep := dbeCodDep.Text;
      End;

      If objComRec.fTipOpeCadastrado(arrTipOpe[cbbTipOpe.ItemIndex], dbeCodDep.Text) Then
      Begin
        fMensagem('ATENÇÃO','Já existe uma faixa cadastrada para este Tipo de Operador e Departamento!',['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) And pnlEmpresa.Visible Then
    Begin
      objComRec.strCodEmp := edtCodEmp.Text;

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO','Defina uma empresa!',['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO','Empresa não cadastrada!',['&Ok']);
          Result := False;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtRecIni) And blnBuscaPorChave Then
    Begin
      objComRec.strRecIni := edtRecIni.Text;

      if fStrToFloat(edtRecIni.Text) < 0 then
      Begin
        fMensagem('ATENÇÃO','O Recebimento Inicial não pode ser negativo!',['&Ok']);
        Result := False;
      End
      Else If Not fCheckRange(fStrToFloat(edtRecIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO','Recebimento Inicial inválido! Já existe um intervalo contendo o valor especificado.',['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtRecFin) And blnBuscaPorChave Then
    Begin
      objComRec.strRecFin := edtRecFin.Text;

      if fStrToFloat(edtRecFin.Text) <= 0 then
      Begin
        fMensagem('ATENÇÃO','O Recebimento Final deve ser maior que zero!',['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtRecFin.Text) < fStrToFloat(edtRecIni.Text) Then
      Begin
        fMensagem('ATENÇÃO','Recebimento Final deve ser maior ou igual ao Recebimento Inicial.',['&Ok']);
        Result := False;
      End
      Else If Not fCheckRange(fStrToFloat(edtRecFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO','Recebimento Final inválido! Já existe um intervalo contendo o valor especificado.',['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtPerCom) And blnBuscaPorChave Then
    Begin
      objComRec.strPerCom := edtPerCom.Text;

      if fEmptyStr(edtPerCom.Text) then
      Begin
        fMensagem('ATENÇÃO','O % de comissão deve ser preenchido!',['&Ok']);
        Result := False;
      End
      Else
      Begin
        if fStrToFloat(edtPerCom.Text) <= 0 then
        Begin
          fMensagem('ATENÇÃO','O % de comissão deve ser maior que zero!',['&Ok']);
          Result := False;
        End
        Else if fStrToFloat(edtPerCom.Text) > 100 then
        Begin
          fMensagem('ATENÇÃO','O % de comissão não deve ser maior que 100%!',['&Ok']);
          Result := False;
        End;
      End;
    End;
  Except
    On E: ExceptionAutCom Do
    Begin
			pMensagensErro(E.Message,'[TfrmCadComRec.fValidaCampos]');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadComRec.dbgDadosDblClick(Sender: TObject);
begin
  inherited;

  With objComRec.cdsDados Do
  Begin
    if (Not IsEmpty) then
    Begin
      if State = dsBrowse then
        Edit;

      edtRecIni.Text := FormatFloat('#,#0.00', FieldByName('COM_RECINI').AsFloat);
      edtRecFin.Text := FormatFloat('#,#0.00', FieldByName('COM_RECFIN').AsFloat);
      edtPerCom.Text := FormatFloat('#,#0.00', FieldByName('COM_PERCOM').AsFloat);
      strAutIncAlt   := FieldByName('AUTOINCREM').AsString;

      If blnRecEmp Then
      Begin
        edtCodEmp.Text := FieldByName('COM_CODEMP').AsString;
        edtNomEmp.Text := fRetNomeEmpresaSelec(FieldByName('COM_CODEMP').AsString);
      End;

      dbgDados.Enabled := False;
    End;
  End;
end;

procedure TfrmCadComRec.dbgDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Delete: If btnGravar.Enabled Then objComRec.pDeletaRegistro;
    VK_Escape: pEscapePressed;
    VK_RETURN: dbgDadosDblClick(Sender);
  End;

end;

procedure TfrmCadComRec.dtsComRecStateChange(Sender: TObject);
begin
  inherited;

  cbbTipOpe.Enabled := qryTabela.State In [dsInsert, dsEdit];
  edtNomEmp.Enabled := qryTabela.State In [dsInsert, dsEdit];
  dbeCodDep.Enabled := qryTabela.State In [dsInsert, dsEdit];
end;

procedure TfrmCadComRec.btnGravarClick(Sender: TObject);
begin
   Try
    pnlInfo.Caption := 'Gravando registro! Aguarde....';
    If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
    Begin

      If (Not fVerificaCampos) Then
      Begin
        pnlInfo.Caption := '';
        Exit;
      End;

      if objComRec.cdsDados.RecordCount = 0 then
      Begin
        fMensagem('ATENÇÃO', 'Inclua pelo menos uma faixa de recebimento!', ['&Ok']);
        pnlInfo.Caption := '';
        pSetFocus(edtRecIni);
        Exit;
      End;

      fStartTransaction;

      If (blnUsaProCodigo) And (qryTabela.State = dsInsert) Then
      Begin
        qryTabela.FieldByName(strNomeCampo).AsString := fProximoCodigo;
        objComRec.cdsDados.Edit;
        objComRec.cdsDados.FieldByName(strNomeCampo).AsString := qryTabela.FieldByName(strNomeCampo).AsString;
        objComRec.cdsDados.Post;
        objComRec.strCodTab := qryTabela.FieldByName(strNomeCampo).AsString;
      End;

      objComRec.pAtualizaRegistros;
      objComRec.cdsDados.ApplyUpdates(0);
      objComRec.strAutInc := objComRec.cdsDados.FieldByName('AUTOINCREM').AsString;
      qryTabela.Cancel;
      objComRec.pAtualizaTabela;

      fCommit;

      pOnStateChange;
      pEnabled(Self, False);
      dbgDados.Enabled := False;
      strAutIncAlt := '';
      If btnIncluir.CanFocus Then
        pSetFocus(btnIncluir)

      Else If btnPesquisa.CanFocus Then
        pSetFocus(btnPesquisa);

      pnlInfo.Caption := '';
      blnGravou := True;
      btnHeranca.Enabled := False;
    End;
  Except
    On E: EUniError Do
    Begin
      If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadComRec.btnGravarClick]');
      End
      Else
      Begin
        fRollBack;
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '[ Gravar registro ]');
      End;
      blnGravou := False;
    End;

    On E: Exception Do
    Begin
      fRollBack;
      blnGravou := False;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[TfrmCadComRec.btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadComRec.btnHerancaClick(Sender: TObject);
  procedure pCarregaDadosHerdado(qryTmp: TUniQuery);
  Begin
    With qryTmp Do
    Begin
      If Not IsEmpty Then
      Begin
        First;

        While Not Eof Do
        Begin
          objComRec.cdsDados.Append;
          objComRec.cdsDados.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('RECCOM', FieldByName('COM_CODEMP').AsString);
          objComRec.cdsDados.FieldByName('COM_CODEMP').AsString := FieldByName('COM_CODEMP').AsString;
          objComRec.cdsDados.FieldByName('COM_CODTAB').AsString := '';
          objComRec.cdsDados.FieldByName('COM_DESCRI').AsString := FieldByName('COM_DESCRI').AsString;
          objComRec.cdsDados.FieldByName('COM_PERCOM').AsFloat  := FieldByName('COM_PERCOM').AsFloat;
          objComRec.cdsDados.FieldByName('COM_RECINI').AsFloat  := FieldByName('COM_RECINI').AsFloat;
          objComRec.cdsDados.FieldByName('COM_RECFIN').AsFloat  := FieldByName('COM_RECFIN').AsFloat;
          objComRec.cdsDados.FieldByName('COM_TIPOPE').AsString := FieldByName('COM_TIPOPE').AsString;
          objComRec.cdsDados.FieldByName('COM_CODDEP').AsString := FieldByName('COM_CODDEP').AsString;
          objComRec.cdsDados.Post;

          Next;
        End;
      End;
    End;
  End;
begin
  inherited;

  Try
    pCriarFormularios(TfrmHerancaFaixaComissao, frmHerancaFaixaComissao);
    frmHerancaFaixaComissao.ShowModal;

    If frmHerancaFaixaComissao.blnConfirma Then
    Begin
      If (qryTabela.Active) And (Not frmHerancaFaixaComissao.qryTabela.IsEmpty) Then
      Begin
        qryTabela.FieldByName('COM_CODTAB').AsString := '';
        qryTabela.FieldByName('COM_DESCRI').AsString := frmHerancaFaixaComissao.qryTabela.FieldByName('COM_DESCRI').AsString;
        qryTabela.FieldByName('COM_CODEMP').AsString := frmHerancaFaixaComissao.qryTabela.FieldByName('COM_CODEMP').AsString;
        qryTabela.FieldByName('COM_TIPOPE').AsString := frmHerancaFaixaComissao.qryTabela.FieldByName('COM_TIPOPE').AsString;
        qryTabela.FieldByName('COM_CODDEP').AsString := frmHerancaFaixaComissao.qryTabela.FieldByName('COM_CODDEP').AsString;

        objComRec.pAtualizaDados(False, '1');
        pCarregaDadosHerdado(frmHerancaFaixaComissao.qryTabela);
        pCarregaTipoOperador;
        pCarregaEmpresa;

        If (Not dbeCodRec.Enabled) Or blnUsaProCodigo Then
          pSetFocus(dbeDescricao)
        Else
          pSetFocus(dbeCodRec);
      End
      Else
      Begin
        objComRec.cdsDados.EmptyDataSet;
        cbbTipOpe.ItemIndex := -1;
        edtNomEmp.Text := '';
        edtDesDep.Text := '';
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadComRec.btnHerancaClick]');
    End;
  End;

  If Assigned(frmHerancaFaixaComissao.qryTabela) Then
    FreeAndNil(frmHerancaFaixaComissao.qryTabela);

  pFreeAndNil(frmHerancaFaixaComissao);
end;

procedure TfrmCadComRec.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If Not btnGravar.Enabled Then
    Exit;

  Try

    If fVerificaCampos And
       fValidaCampos(edtRecIni) And
       fValidaCampos(edtRecFin) And
       fValidaCampos(edtPerCom) Then
    Begin
      if fEmptyStr(strAutIncAlt) then
        objComRec.pInsereDados(IIF(blnRecEmp, qryTabela.FieldByName('COM_CODEMP').AsString, VS_strCodEmp))
      Else
        objComRec.pAtualizaRegistro;

      pLimpaCampos;
      strAutIncAlt := '';
      dbgDados.Enabled := True;
      dbgDados.Repaint;
      pSetFocus(edtRecIni);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadComRec.btnAdicionarClick]');
    End;
  End;

end;

procedure TfrmCadComRec.btnCancelaClick(Sender: TObject);
begin
  inherited;
  objComRec.pAtualizaDados(False, IIF(blnRecEmp, qryTabela.FieldByName('COM_CODEMP').AsString, ''));
  pCarregaTipoOperador;
  pCarregaEmpresa;
  pLimpaCampos;
  btnHeranca.Enabled := False;
end;

procedure TfrmCadComRec.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin

  chrKey := '/';

  if fPesqRecComissaoVen(conSimples,
                         Self,
                         nil,
                         nil,
                         qryTabela,
                         chrKey,
                         arrSel) then
  Begin
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);

    dbgDados.Enabled := False;
  End;

  If qryTabela.Active Then
  Begin
    objComRec.pAtualizaDados(False, IIF(blnRecEmp, qryTabela.FieldByName('COM_CODEMP').AsString, ''));
    pCarregaTipoOperador;
    pCarregaEmpresa;
  End
  Else
  Begin
    objComRec.cdsDados.EmptyDataSet;
    cbbTipOpe.ItemIndex := -1;
    edtNomEmp.Text := '';
  End;

  If (fEmptyStr(dbeCodDep.Text)) Then
    edtDesDep.Clear
  Else
    edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [dbeCodDep.Text]);
end;

procedure TfrmCadComRec.btnExcluirClick(Sender: TObject);
begin
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      fStartTransaction;
      objComRec.pDeletaFaixaCompleta(dbeCodRec.Text, Self.Name, qryTabela.FieldByName('COM_CODEMP').AsString);
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[btnExcluirClick]');
      End;
    End;

    objComRec.cdsDados.EmptyDataSet;
    cbbTipOpe.ItemIndex := -1;
    pLimparCampos;
    pLimpaCampos;
    dbeCodRec.Text := '';
  End;
end;

procedure TfrmCadComRec.dbeCodDepKeyPress(Sender: TObject; var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;
  If fPesqDepartamento(Self, dbeCodDep, edtDesDep, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(dbeCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComRec.dbeCodRecExit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(dbeCodRec.Text)) And (Not blnRecEmp) Then
  Begin
    objComRec.pAtualizaDados(False, IIF(blnRecEmp, qryTabela.FieldByName('COM_CODEMP').AsString, ''));
    pCarregaTipoOperador;
    pCarregaEmpresa;

    If (fEmptyStr(dbeCodDep.Text)) Then
      edtDesDep.Clear
    Else
      edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [dbeCodDep.Text]);
  End;
end;

procedure TfrmCadComRec.edtCodEmpExit(Sender: TObject);
  function fExisteComissaoCadastrada: Boolean;
    Var
      qryTmp: TUniQuery;
  Begin
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      SQL.Add('SELECT * FROM RECCOM ');
      SQL.Add('WHERE COM_CODTAB = :CODTAB');
      SQL.Add('  AND COALESCE(COM_CODDEP, "") = :CODDEP');
      SQL.Add('  AND COM_CODEMP = :CODEMP ');

      ParamByName('CODTAB').AsString := dbeCodRec.Text;
      ParamByName('CODTAB').AsString := dbeCodDep.Text;
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('COM_CODEMP').AsString;

      Open;

      Result := Not IsEmpty;
    End;

    FreeAndNil(qryTmp);
  End;
begin
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa', 3);

  If (Not fEmptyStr(dbeCodRec.Text)) And (blnRecEmp) And fExisteComissaoCadastrada Then
  Begin
    objComRec.pAtualizaDados(False, IIF(blnRecEmp, qryTabela.FieldByName('COM_CODEMP').AsString, ''));
    pCarregaTipoOperador;

    If (fEmptyStr(dbeCodDep.Text)) Then
      edtDesDep.Clear
    Else
      edtDesDep.Text := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [dbeCodDep.Text]);
  End;
end;

procedure TfrmCadComRec.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  If (pnlEmpresa.Visible) And
     (edtCodEmp.Enabled)  And
     fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.
