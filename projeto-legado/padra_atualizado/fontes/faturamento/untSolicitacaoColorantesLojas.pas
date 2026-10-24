unit untSolicitacaoColorantesLojas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, DB, Grids,
  DBGridCitel, DBGrids, UniClientDataSet, Uni, untSolicitacaoColorantesTE,
  untCadLote, untTypesSistema, BitBtnLockedIncrem, StrUtils, frxClass,
  frxExportCSVTestabilidade, untLiberacao, untMsgLiberacao, Datasnap.DBClient;

type
  TfrmSolicitacaoColorantesLojas = class(TfrmPai)
    dbgItensLoja: TDBGridCitel;
    dtsItens: TDataSource;
    btnConfirma: TBitBtnLocked;
    dtsUsado: TDataSource;
    dbgEstoque: TDBGridCitel;
    dtsEstoque: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgItensLojaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    objCadLot: TCadLot;
    strNTrava: String;
    blnSenha: Boolean;
    strOpcTra: String;
    blnTravaSemPedirSenha: Boolean;
    cdsEstoque: TUniClientDataSet;
    objLiberacao: TLiberacao;

    Function fVerificaLojas: Boolean;

    Function fFaltaSaldoLoja(strCodIte, strCodEmp: String; fltQtdIte: Double;
      Var fltSaldos: Double): Boolean;

    Function fGetSaldoLoja(strCodIte, strCodEmp: String): Double;

    procedure pCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    function fSenhaLiberaProdutosAbastecimento: Boolean;
    function fRetCodItens(): String;
    procedure pCarregaSaldosEmpresas();
    procedure pFiltrarEstoqueProduto;
  public
    { Public declarations }
    objSolColorantesTE: TSolicitacaoColorantesTE;
    procedure pItensLojaBeforePost(DataSet: TDataSet);
    procedure pItensLojaAfterInsert(DataSet: TDataSet);
    procedure pItensLojaAfterScroll(DataSet: TDataSet);
  end;

implementation

uses untFuncFat, untFuncoesSimples, untConsultas, untConsultaLoteEmp;

{$R *.dfm}

procedure TfrmSolicitacaoColorantesLojas.pCarregaSaldosEmpresas;
Var
  qryEstoque: TUniQuery;
begin
  qryEstoque := fCriaQuery(nil);
  Try
    qryEstoque.SQL.Text := objSolColorantesTE.fRetSqlEstoque(fRetCodItens());
    qryEstoque.Open;
    cdsEstoque := fCriaClientDatset(qryEstoque, False, Self);
    (cdsEstoque.FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat :=
      '#,##0.000';
    (cdsEstoque.FieldByName('ITE_SALRES') As TFloatField).DisplayFormat :=
      '#,##0.000';
    (cdsEstoque.FieldByName('ITE_SALDIS') As TFloatField).DisplayFormat :=
      '#,##0.000';
    (cdsEstoque.FieldByName('ITE_ENTFUT') As TFloatField).DisplayFormat :=
      '#,##0.000';
    dtsEstoque.DataSet := cdsEstoque;
  Finally
    qryEstoque.Free;
  End;
end;

procedure TfrmSolicitacaoColorantesLojas.pCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  Try
    Key := #0;

    frmConsultaLoteEmp := TfrmConsultaLoteEmp.Create(Self);
    frmConsultaLoteEmp.strCodIte := dtsItens.DataSet.FieldByName
      ('CODITE').AsString;
    frmConsultaLoteEmp.cxgConsultaView.Bands[1].Visible := False;
    frmConsultaLoteEmp.ShowModal;

    If dbgItensLoja.SelectedIndex <> fFindColumnByName(dbgItensLoja, 'CODEMP')
      .Index Then
      dbgItensLoja.SelectedIndex := fFindColumnByName(dbgItensLoja,
        'CODEMP').Index;

    If Not(dtsItens.DataSet.State = dsEdit) Then
      dtsItens.DataSet.Edit;

    If Not fEmptyStr(frmConsultaLoteEmp.strCodEmp) Then
      dtsItens.DataSet.FieldByName('CODEMP').AsString :=
        frmConsultaLoteEmp.strCodEmp;

    dtsItens.DataSet.Post;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,
        '[TfrmSolicitacaoColorantesLojas.pCodEmpresaKeyPress]');
  End;

  pFreeAndNil(frmConsultaLoteEmp);
end;

Function TfrmSolicitacaoColorantesLojas.fGetSaldoLoja(strCodIte,
  strCodEmp: String): Double;
Begin
  Result := 0.00;
  If Assigned(cdsEstoque) Then
    If cdsEstoque.Locate('EMP_CODEMP', strCodEmp, []) Then
      Result := cdsEstoque.FieldByName('ITE_SALDIS').AsFloat;
End;

Function TfrmSolicitacaoColorantesLojas.fFaltaSaldoLoja(strCodIte,
  strCodEmp: String; fltQtdIte: Double; Var fltSaldos: Double): Boolean;
Begin
  pFiltrarEstoqueProduto;
  fltSaldos := fGetSaldoLoja(strCodIte, strCodEmp);
  Result := fltSaldos < fltQtdIte;
End;

procedure TfrmSolicitacaoColorantesLojas.pItensLojaAfterInsert
  (DataSet: TDataSet);
Begin
  DataSet.Cancel;
End;

procedure TfrmSolicitacaoColorantesLojas.pItensLojaAfterScroll
  (DataSet: TDataSet);
begin
  pFiltrarEstoqueProduto;
end;

procedure TfrmSolicitacaoColorantesLojas.pFiltrarEstoqueProduto;
begin
  If Not Assigned(cdsEstoque) Then
    Exit;
  cdsEstoque.Filtered := False;
  cdsEstoque.Filter := 'ITE_CODITE = ' +
    QuotedStr(dtsItens.DataSet.FieldByName('CODITE').AsString);
  cdsEstoque.Filtered := True;
end;

procedure TfrmSolicitacaoColorantesLojas.pItensLojaBeforePost
  (DataSet: TDataSet);
Var
  fltSaldos: Double;
  strMensag: String;
  intColEmp: Integer;
  blnRealizaValidacao: Boolean;
begin
  inherited;

  With DataSet Do
  Begin
    intColEmp := fFindColumnByName(dbgItensLoja, 'CODEMP').Index;

    If fEmptyStr(FieldByName('CODEMP').AsString) Then
      FieldByName('CODEMP').Clear;

    If (Not fEmptyStr(FieldByName('CODEMP').AsString)) Then
      FieldByName('CODEMP').AsString :=
        fStrZero(FieldByName('CODEMP').AsString, 3);

    If (Not fEmptyStr(FieldByName('CODEMP').AsString)) And
      fEmptyStr(fRetNomeEmpresa(FieldByName('CODEMP').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa não cadastrada.', ['&Ok']);
      pSetFocus(dbgItensLoja);
      dbgItensLoja.SelectedIndex := intColEmp;
      Cancel;
      Abort;
      Exit;
    End

    Else If (Not fEmptyStr(FieldByName('CODEMP').AsString)) And (Not strEmpAcessoUsuarioLogado.Contains(FieldByName('CODEMP').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Operador não possui acesso liberado à empresa informada.', ['&Ok']);
      pSetFocus(dbgItensLoja);
      dbgItensLoja.SelectedIndex := intColEmp;
      Cancel;
      Abort;
      Exit;
    End


    Else If fEmptyStr(FieldByName('CODEMP').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', Format('Informe a Loja que fornecerá o item [%s].',
        [FieldByName('CODITE').AsString]), ['&OK']);
      pSetFocus(dbgItensLoja);
      dbgItensLoja.SelectedIndex := intColEmp;
      Cancel;
      Abort;
      Exit;
    End

    Else If (Not fEmptyStr(FieldByName('CODEMP').AsString)) And
      (Not fPermiteTransfEntreEmps(FieldByName('CODEMP').AsString,
      VS_strCodEmp)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A empresa ' + FieldByName('CODEMP').AsString +
        ' não permite transferência de estoque.' + #13 +
        'Verificar nas configurações de "Transferência de Estoque" no "Cadastro de Empresa"',
        ['&Ok']);
      pSetFocus(dbgItensLoja);
      dbgItensLoja.SelectedIndex := intColEmp;
      Cancel;
      Abort;
      Exit;
    End

    // Else If FieldByName('CODEMP').AsString = VS_strCodEmp Then
    // Begin
    // fMensagem('ATENÇÃO!', 'A Loja que fornecerá o item não pode ser a loja corrente.', ['&Ok']);
    // pSetFocus(dbgItensLoja);
    // Cancel;
    // Abort;
    // Exit;
    // End

    Else
    Begin
      blnRealizaValidacao := Not fEmptyStr(FieldByName('CODEMP').AsString);

      If blnRealizaValidacao And fFaltaSaldoLoja(FieldByName('CODITE').AsString,
        FieldByName('CODEMP').AsString, FieldByName('QTDITE').AsFloat,
        fltSaldos) Then
      Begin
        If (Pos(strOpcTra, 'T_A_') > 0) And (blnTravaSemPedirSenha) Then
        Begin
          strMensag := 'Saldo de estoque do item ' + FieldByName('CODITE')
            .AsString + '-' + FieldByName('DESCRI').AsString + ', na Loja ' +
            FieldByName('CODEMP').AsString + ' = ' + FloatToStrF(fltSaldos,
            ffFixed, 12, 2);

          If blnTravaSemPedirSenha Then
            fMensagem('', strMensag, ['&Ok']);

          pSetFocus(dbgItensLoja);
          dbgItensLoja.SelectedIndex := intColEmp;

          Cancel;
          Abort;
          Exit;
        End
        Else If (Pos(strOpcTra, 'T_A_') > 0) And
          (Not blnTravaSemPedirSenha) Then
        Begin

        End;
      End;
    End;
  End;

end;

function TfrmSolicitacaoColorantesLojas.fRetCodItens: String;
var
  intRecNo: Integer;
begin
  With dtsItens.DataSet Do
  Begin
    Result := '';
    intRecNo := RecNo;
    First;
    Try
      While Not Eof Do
      Begin
        If Not fEmptyStr(Result) then
          Result := Result + ',';

        Result := Result + QuotedStr(FieldByName('CODITE').AsString);

        Next;
      End;
    Finally
      RecNo := intRecNo;
    End;
  End;

end;

function TfrmSolicitacaoColorantesLojas.
  fSenhaLiberaProdutosAbastecimento: Boolean;
Var
  objTabela: TRegistroMsgLiberaTabela;
  objLinha: TLinhaMsgLibera;
  intRecNo: Integer;
  intTamCodIte: Integer;
Begin
  If Not fCfgSis('LIBABS', varBoolean) Then
  Begin
    Result := True;
    Exit
  End;

  intTamCodIte := fTamCodIte+1;

  With dtsItens.DataSet Do
  Begin
    intRecNo := RecNo;
    First;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto
      ('Itens que foram solicitados as lojas para realizar o abastecimento');
    objLiberacao.objMsgLibera.pAddQuebra;

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('', 'Código'       , intTamCodIte , alEsquerda , teAutcom);
    objLinha.pAddColuna('', 'Descrição'    , 33 , alEsquerda , teAutcom);
    objLinha.pAddColuna('', 'Quantidade'   , 10 , alDireita  , teAutcom);
    objLinha.pAddColuna('', 'Loja Transf.' , 12 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    While Not Eof Do
    Begin
      objLinha := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('Código'       , FieldByName('CODITE').AsString                             , intTamCodIte , alEsquerda);
      objLinha.pAddColuna('Descrição'    , FieldByName('DESCRI').AsString                             , 33 , alEsquerda);
      objLinha.pAddColuna('Quantidade'   , FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 10, 2) , 10 , alDireita);
      objLinha.pAddColuna('Loja Transf.' , FieldByName('CODEMP').AsString                             , 12 , alDireita);
      objTabela.lstLinhas.Add(objLinha);

      Next;
    End;

    RecNo := intRecNo;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'SENABA';
    objLiberacao.strSenLib := fCfgSis('SENABA');
    objLiberacao.strMsgSen := 'Liberação de abastecimento';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  End;
end;

Function TfrmSolicitacaoColorantesLojas.fVerificaLojas: Boolean;
Var
  fltSaldos: Double;
  objTabela: TRegistroMsgLiberaTabela;
  objLinha: TLinhaMsgLibera;
  intAgrupador: Integer;
  intTamCodIte: Integer;
Begin
  Result := True;

  With dtsItens.DataSet Do
  Begin
    First;
    While Not Eof Do
    Begin
      If fEmptyStr(FieldByName('CODEMP').AsString) Then
      Begin
        fMensagem('ATENÇÃO!',
          Format('Informe a Loja que fornecerá o item [%s].',
          [FieldByName('CODITE').AsString]), ['&OK']);
        Result := False;
        Break;
      End;
      Next;
    End;
    First;
  End;

  If Not Result Then
    Exit;

  If blnTravaSemPedirSenha Then
    Exit;

  intTamCodIte := fTamCodIte+1;
  
  With dtsItens.DataSet Do
  Begin
    First;

    objLiberacao.Clear;
    objTabela := TRegistroMsgLiberaTabela.Create;
    intAgrupador := -1;
    While Not Eof Do
    Begin
      If fFaltaSaldoLoja(FieldByName('CODITE').AsString,
        FieldByName('CODEMP').AsString, FieldByName('QTDITE').AsFloat,
        fltSaldos) Then
      Begin
        If objTabela.IsEmpty Then
        Begin
          objLiberacao.objMsgLibera.pAddTexto
            ('ITENS SEM SALDO NA SOLICITAÇÃO ENTRE LOJAS');
          objLiberacao.objMsgLibera.pAddTextoCaption('EMP. SOLICITANTE',
            Copy(VS_strCodEmp + ' - ' + fRetNomeEmpresaSelec
            (VS_strCodEmp), 1, 50));
          objLiberacao.objMsgLibera.pAddQuebra;

          objLinha := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna('', 'CÓD.', intTamCodIte, alEsquerda, teAutcom);
          objLinha.pAddColuna('', 'DESCRIÇÃO', 35, alEsquerda, teAutcom);
          objLinha.pAddColuna('', 'QTDE. À LIBE.', 15, alDireita, teAutcom);
          objLinha.pAddColuna('', 'EMPRESA ABASTECEDORA', 25, alEsquerda,
            teAutcom);
          objLinha.pAddColuna('', 'SALDO EMP. ABAST.', 17, alDireita, teAutcom);
          objTabela.lstLinhas.Add(objLinha);

        End;

        inc(intAgrupador);

        objLinha := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.intAgrupador := intAgrupador;
        objLinha.pAddColuna('CÓD.', FieldByName('CODITE').AsString, intTamCodIte,
          alEsquerda);
        objLinha.pAddColuna('DESCRIÇÃO', FieldByName('DESCRI').AsString, 35,
          alEsquerda);
        objLinha.pAddColuna('QTDE. À LIBE.',
          FloatToStrF(FieldByName('QTDITE').AsFloat, ffFixed, 12, 2), 15,
          alDireita);
        objLinha.pAddColuna('EMPRESA ABASTECEDORA', FieldByName('CODEMP')
          .AsString + ' - ' + fRetNomeEmpresaSelec(FieldByName('CODEMP')
          .AsString), 25, alEsquerda);
        objLinha.pAddColuna('SALDO EMP. ABAST.', FloatToStrF(fltSaldos, ffFixed,
          12, 2), 17, alDireita);
        objTabela.lstLinhas.Add(objLinha);
      End;

      Next;
    End;

    If objTabela.IsEmpty Then
      FreeAndNil(objTabela)
    else
    Begin

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'LBSDVN';
      objLiberacao.blnTraTel := (strOpcTra = 'T');
      objLiberacao.strSenLib := fCfgSisL('SESDVN');
      objLiberacao.strMsgSen := 'Liberação de produto sem saldo - Venda Normal';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;

      If Not Result Then
      Begin
        pSetFocus(dbgItensLoja);
        dbgItensLoja.SelectedIndex := fFindColumnByName(dbgItensLoja,
          'CODEMP').Index;
      End;
    End;

    First;
  End;

End;

procedure TfrmSolicitacaoColorantesLojas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItensLoja);
end;

procedure TfrmSolicitacaoColorantesLojas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult = mrOk Then
  Begin
    If dtsItens.DataSet.State = dsEdit Then
      dtsItens.DataSet.Post;
    If Not fVerificaLojas Then
      Action := caNone
    Else If Not fSenhaLiberaProdutosAbastecimento Then
      Action := caNone;
  End;
end;

procedure TfrmSolicitacaoColorantesLojas.dbgItensLojaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
    pCodEmpresaKeyPress(Sender, Key)
end;

procedure TfrmSolicitacaoColorantesLojas.FormShow(Sender: TObject);
begin
  inherited;
  dbgItensLoja.SelectedIndex := fFindColumnByName(dbgItensLoja, 'CODEMP').Index;

  strNTrava := 'NNNNNNNNNNNNNNNNNNNN';
  blnSenha := fCfgSisL('SOLSTE', varBoolean);
  strOpcTra := fCfgSisL('TRASTE', VarString);

  blnTravaSemPedirSenha := (Not blnSenha) And (strOpcTra = 'T');
  pCarregaSaldosEmpresas();
  pItensLojaAfterScroll(dtsItens.DataSet);
end;

procedure TfrmSolicitacaoColorantesLojas.FormCreate(Sender: TObject);
begin
  inherited;
  objCadLot := TCadLot.Create(Self);
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmSolicitacaoColorantesLojas.FormDestroy(Sender: TObject);
begin
  If Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmSolicitacaoColorantesLojas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE:
      If dtsItens.DataSet.State = dsEdit Then
        dtsItens.DataSet.Cancel
      Else
        Close;
    VK_RETURN:
      Begin
        If Not(dtsItens.DataSet.State = dsEdit) Then
          dtsItens.DataSet.Edit
        Else
        Begin
          If dbgItensLoja.SelectedIndex = fFindColumnByName(dbgItensLoja,
            'CODEMP').Index Then
          Begin
            dtsItens.DataSet.Next;
          End
          Else
          Begin
            If (dtsItens.DataSet.State = dsEdit) Then
              dtsItens.DataSet.Post;

            dtsItens.DataSet.Next;
            dbgItensLoja.SelectedIndex := fFindColumnByName(dbgItensLoja,
              'CODEMP').Index;
          End;

          If dtsItens.DataSet.Eof And btnConfirma.CanFocus Then
            pSetFocus(btnConfirma);
        End;
      End;
    VK_F10:
      btnConfirma.Click;
  End;
  If ((Shift = [ssCtrl]) or (Shift = [ssAlt]) or (Shift = [ssAlt, ssShift]) or
    (Shift = [ssAlt, ssCtrl]) or (Shift = [ssShift, ssCtrl]) or
    (Shift = [ssAlt, ssShift, ssCtrl])) and (Key = VK_Delete) Then
    Key := 0;
end;

end.
