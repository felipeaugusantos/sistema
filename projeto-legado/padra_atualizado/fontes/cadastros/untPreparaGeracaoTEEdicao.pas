unit untPreparaGeracaoTEEdicao;

interface

uses
  Windows, Messages, SysUtils, strUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, Mask, DBCtrls, DBEditFocus, DB, untTypesSistema,
  untFuncoesSimples, untPreparaGeracaoTE, frxClass, frxExportCSVTestabilidade,
  untTLock, MemDS, DBAccess, Uni, Math, UniClientDataSet;

type
  TfrmPreparaGeracaoTEEdicao = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    pnlEmprersa: TPanel;
    Label7: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label5: TLabel;
    edtEmpOri: TEditFocus;
    edtNomEmpOri: TEditFocus;
    edtSaldos: TEditFocus;
    Label6: TLabel;
    Label8: TLabel;
    edtEmpDes: TEditFocus;
    edtNomEmpDes: TEditFocus;
    Panel1: TPanel;
    Label9: TLabel;
    edtQtdCad: TEditFocus;
    lblQtdTra: TLabel;
    edtQtdTra: TEditFocus;
    dtsItem: TDataSource;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    edtSaldoDestino: TEditFocus;
    Label11: TLabel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeRefere: TDBEditFocus;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    btnPedCompGrid: TBitBtnLocked;
    pnlProduto: TPanel;
    lblCriticaTexoParte1: TLabel;
    lblCriticaTexoParte2: TLabel;
    btnCadLoteSubItem: TBitBtnLocked;
    btnVisualizarSubItens: TBitBtnLocked;
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpOriKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpDesKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpOriExit(Sender: TObject);
    procedure edtEmpDesExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure btnPedCompGridClick(Sender: TObject);
    procedure btnCadLoteSubItemClick(Sender: TObject);
    procedure btnVisualizarSubItensClick(Sender: TObject);
    procedure edtQtdTraExit(Sender: TObject);
  private
    { Private declarations }
    arrSelNada: TConsultasArray;

    strUltimaTrava, strTEPREV: String;
    objLock: TLock;
    blnGeracaoItensEstrutura: Boolean;
    qrySubIte: TUniQuery;
    cdsSubItens: TUniClientDataSet;
    procedure pLimpaCampos;
    procedure pHabilitaTextoCritica(blnMostraTextoCritica: Boolean);
    procedure pHabilitaLote(blnHabLot: Boolean);

    function fJaExisteQuantidadeCadastradaParaTransferencia(
             blnAcumulaDigitacao: Boolean; strQuantidadeJaCadastrada: String): Boolean;

    Function fTestaQuantidade: Boolean;
    function fPesquisaLote(Sender: TObject; Var Key: Char; arrNumLot: TStringArray = Nil): Boolean;
    function fLiberaMultiploVenda: Boolean;

    procedure pCarregaDadosGrid;

    function fValidaConfiguracaoPrecoTransfEstoque(strCodIte: String): Boolean;
    function fVerificaPrecoItensTransfEstoque: Boolean;
    function fRetornaConfiguracaoPrecoTranfEstoqueConemp: String;
    procedure pCarregaConfigCAREST;
    function fGeracaoPREPTE: Boolean;
    function fGeracaoPREPTEItensEstrutura: Boolean;
    function fValidaGeracaoSubItensComLote: Boolean;
    function fVerificaSaldo: Boolean;
    procedure pCarregaSubItens;
    procedure pAtualizarLoteObrigatorioSubItensCds;
    procedure pAtualizaQuantidadeSubItensCds;
  public
    { Public declarations }
    objPreparaGer: TPreparaGeracaoTE;

    blnCarregarDados: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fLiberaTransferencia(strCodIte, strDesIte, strQtdTra, strSaldos: String): Boolean;
  end;

implementation

{$R *.dfm}

Uses
  untPanelCxCadLote, untConsultas, untFuncoesConsulta, untPnlDadosCadLote, TypesRel,
  untFuncoesRel2, untILiberacao, untMsgLiberacao, untCadLotSubItensEstrutura,
  untLiberacaoFactory, untFuncoesRel, untRelEstPedCompraGrid, untConfirmaMultiploVenda,
  untSelecionaItens;

procedure TfrmPreparaGeracaoTEEdicao.edtEmpDesExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtEmpDes, edtNomEmpDes, arrSelNada, fRetNomeEmpresa, nil, 'da Empresa');

end;

procedure TfrmPreparaGeracaoTEEdicao.edtEmpDesKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtEmpDes, edtNomEmpDes, Nil, Key, arrSelNada) Then
  Begin
    If fValidaCampos(edtEmpDes, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmPreparaGeracaoTEEdicao.edtEmpOriExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtEmpOri, edtNomEmpOri, arrSelNada, fRetNomeEmpresa, nil, 'da Empresa');

  If blnGeracaoItensEstrutura Then
    pAtualizarLoteObrigatorioSubItensCds;
end;

procedure TfrmPreparaGeracaoTEEdicao.edtEmpOriKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtEmpOri, edtNomEmpOri, Nil, Key, arrSelNada) Then
  Begin
    If fValidaCampos(edtEmpOri, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmPreparaGeracaoTEEdicao.fPesquisaLote(Sender: TObject; Var Key: Char; arrNumLot: TStringArray = Nil): Boolean;
  var
    objfrmPnl: TPanelCxCadLote;
begin
  inherited;

  Result := False;

  If Not fEntraCons(Key) Then
    Exit;

  Try
    objfrmPnl := TPanelCxCadLote.Create(TfrmPnlDadosCadLote);
    objfrmPnl.strCodIte := edtCodIte.Text;
    Result := objPreparaGer.objCadLot.fedtNumLotKeyPress(edtCodIte.Text, Sender, Key, edtNumLot, Self, False, False,
                           objfrmPnl, arrNumLot, edtEmpOri.Text);
  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

function TfrmPreparaGeracaoTEEdicao.fRetornaConfiguracaoPrecoTranfEstoqueConemp: String;
  Var
    qryDados: TUniQuery;
begin
  Result := '';

  qryDados := fCriaQuery;
  Try
    qryDados.Close;
    qryDados.Sql.Clear;
    qryDados.Sql.Add('SELECT CON_TEPDEF FROM CONEMP ');
    qryDados.Sql.Add('WHERE CON_EMPORI = :EMPORI AND CON_EMPDES = :EMPDES');

    qryDados.ParamByName('EMPORI').AsString := edtEmpOri.Text;
    qryDados.ParamByName('EMPDES').AsString := edtEmpDes.Text;

    qryDados.Open;

    If Not qryDados.IsEmpty Then
      Result := qryDados.FieldByName('CON_TEPDEF').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure TfrmPreparaGeracaoTEEdicao.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesquisaLote(Sender, Key) And fValidaCampos(edtNumLot, True) Then
     Self.SelectNext(ActiveControl, True, True);

end;

procedure TfrmPreparaGeracaoTEEdicao.edtQtdTraExit(Sender: TObject);
begin
  inherited;

  If (blnGeracaoItensEstrutura) And (StrToFloat(edtQtdTra.Text) > 0) Then
    pAtualizaQuantidadeSubItensCds;
end;

function TfrmPreparaGeracaoTEEdicao.fLiberaMultiploVenda: Boolean;
var
  fltValor,
  fltMltVen: Double;
  frmConfirmaMultiploVenda: TfrmConfirmaMultiploVenda;
begin
  Result := True;
  fltMltVen := fRetMltVenItem(edtCodIte.Text);

  if (fFormataFloat(fStrToFloat(edtQtdTra.Text), 2) < fFormataFloat(fltMltVen,2)) then
  begin
    if not SameValue(fStrToFloat(edtQtdTra.Text),fStrToFloat(edtSaldos.Text)) then
    begin
      fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(fltMltVen, ffNumber, 12, 3), ['&OK']);
      pCriarFormularios(TfrmConfirmaMultiploVenda, frmConfirmaMultiploVenda);
      try
        if frmConfirmaMultiploVenda.ShowModal = mrOk then
        begin
          if frmConfirmaMultiploVenda.rdgMultVenda.ItemIndex = 0 then
          begin
            edtQtdTra.Text := FloatToStrF(fltMltVen, ffNumber, 12, fCfgSis('DECQTD', varInteger));
            Result := True;
          end
          else
          begin
            Result := True;
          end;
        end
        else
        begin
          Result := False;
        end;
      finally
        pFreeAndNil(frmConfirmaMultiploVenda);
      end;
    end;
  end
  else
  begin
    fltValor := fFormataFloatInterna(fStrToFloat(edtQtdTra.Text) / fltMltVen, 4);
    if (fltValor - Int(fltValor)) > 0 then
    begin
      if not SameValue(fStrToFloat(edtQtdTra.Text),fStrToFloat(edtSaldos.Text)) then
      begin
        fMensagem('','A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(fltMltVen, ffNumber, 12, 3), ['&OK']);
        pCriarFormularios(TfrmConfirmaMultiploVenda, frmConfirmaMultiploVenda);
        try
          if frmConfirmaMultiploVenda.ShowModal = mrOk then
          begin
            if frmConfirmaMultiploVenda.rdgMultVenda.ItemIndex = 0 then
            begin
              fltValor  := fStrToFloat(edtQtdTra.Text);
              fltValor  := Int( ( ( fltValor + fltMltVen ) / fltMltVen ) ) * fltMltVen;
              edtQtdTra.Text := FloatToStrF(fltValor, ffNumber, 12, fCfgSis('DECQTD', varInteger));
              Result := True;
            end
            else
            begin
              Result := True;
            end;
          end
          else
          begin
            Result := False;
          end;
        finally
          pFreeAndNil(frmConfirmaMultiploVenda);
        end;
      end;
    end;
  end;

end;

function TfrmPreparaGeracaoTEEdicao.fLiberaTransferencia(strCodIte, strDesIte, strQtdTra, strSaldos: String): Boolean;
  Var
    objLiberacao: ILiberacao;
Begin
  objLiberacao := TLiberacaoFactory.fGetLiberacao;
  objLiberacao.objMsgLibera.pAddTexto('QUANTIDADE SOLICITADA PARA TRANSFERIR MAIOR QUE SALDO DISPONÍVEL');
  objLiberacao.objMsgLibera.pAddTextoCaption('ITEM', strCodIte + ' - ' + strDesIte);
  objLiberacao.objMsgLibera.pAddTextoCaption('SALDO A TRANSFERIR ', fPadL(FormatFloat('#0.00', fStrToFloat(strQtdTra)), 12)                               , 38, alCentro, teAmbos, '', 15);
  objLiberacao.objMsgLibera.pAddTextoCaption('SALDO DISPONÍVEL   ', fPadL(FormatFloat('#0.00', fStrToFloat(strSaldos)), 12)                               , 38, alCentro, teAmbos, '', 15);
  objLiberacao.objMsgLibera.pAddTextoCaption('SALDO FINAL        ', fPadL(FormatFloat('#0.00', fStrToFloat(strSaldos) - fStrToFloat(strQtdTra)), 12) , 38, alCentro, teAmbos, '', 15);

  objLiberacao.strDirAce := 'TRSALO';
  objLiberacao.strMsgSen := 'QUANTIDADE A TRANFERIR MAIOR QUE SALDO DISPONÍVEL';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.blnSempreVariavelUsuario := True;

  Result := objLiberacao.fLibera;
  objLiberacao.Clear;
end;

procedure TfrmPreparaGeracaoTEEdicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objLock);
  strUltimaTrava := '';

  If Assigned(qrySubIte) Then
    FreeAndNil(qrySubIte);

  If Assigned(cdsSubItens) Then
    FreeAndNil(cdsSubItens);
end;

procedure TfrmPreparaGeracaoTEEdicao.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  blnCarregarDados   := False;
  blnFecharComEscape := False;
  blnGeracaoItensEstrutura := False;
  strUltimaTrava := '';

  edtQtdCad.EditFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  edtQtdTra.EditFormat := edtQtdCad.EditFormat;
  edtSaldos.EditFormat := edtQtdCad.EditFormat;
  objLock := TLock.Create;

  cdsSubItens := TUniClientDataSet.Create(nil);
  cdsSubItens.FieldDefs.Add('CODITE', ftString, 10);
  cdsSubItens.FieldDefs.Add('DESCRI', ftString, 80);
  cdsSubItens.FieldDefs.Add('NUMLOT', ftString, VS_Size_NumLot);
  cdsSubItens.FieldDefs.Add('LOTOBG', ftString, 01);
  cdsSubItens.FieldDefs.Add('QTDITE', ftFloat,  00);
  cdsSubItens.FieldDefs.Add('QTDTRA', ftFloat,  00);
  cdsSubItens.CreateDataSet;
end;

procedure TfrmPreparaGeracaoTEEdicao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of
    VK_F12: btnPedCompGrid.Click;
    VK_ESCAPE: If edtCodIte.Focused Then
               Begin

                 Close;
                 
               End Else
               Begin
                 Key := 0;
                 pLimpaCampos;
               End;

    Else       inherited;
  End;

end;

procedure TfrmPreparaGeracaoTEEdicao.pCarregaDadosGrid;
Begin
  With objPreparaGer.cdsIteLib Do
  Begin
    edtCodIte.Text := FieldByName('CODITE').AsString;
    edtEmpOri.Text := FieldByName('EMPORI').AsString;
    edtNumLot.Text := FieldByName('NUMLOT').AsString;
    edtEmpDes.Text := FieldByName('EMPDES').AsString;

    fValidaCampos(edtCodIte, True);
    fValidaCampos(edtEmpDes, True);
  End;

  pnlProduto.Enabled := False;
  pnlEmprersa.Enabled := False;
  pSetFocus(edtQtdTra);
End;

procedure TfrmPreparaGeracaoTEEdicao.pAtualizaQuantidadeSubItensCds;
begin
  cdsSubItens.First;
  While Not cdsSubItens.Eof Do
  Begin
    cdsSubItens.Edit;
    cdsSubItens.FieldByName('QTDTRA').AsFloat := cdsSubItens.FieldByName('QTDITE').AsFloat * strToFloatDef(edtQtdTra.Text, 1);
    cdsSubItens.Post;

    cdsSubItens.Next;
  End;
end;

procedure TfrmPreparaGeracaoTEEdicao.pAtualizarLoteObrigatorioSubItensCds;
  Var
    blnHabilitaCadastroLoteSubItem: Boolean;
begin
  blnHabilitaCadastroLoteSubItem := False;

  cdsSubItens.First;
  While Not cdsSubItens.Eof Do
  Begin
    If objPreparaGer.objCadLot.fExisteLote(cdsSubItens.FieldByName('CODITE').AsString, edtEmpOri.Text, '', False) Then
    Begin
      blnHabilitaCadastroLoteSubItem := True;

      cdsSubItens.Edit;
      cdsSubItens.FieldByName('LOTOBG').AsString := 'S';
      cdsSubItens.Post;
    End;

    cdsSubItens.Next;
  End;

  btnCadLoteSubItem.Enabled := blnHabilitaCadastroLoteSubItem;
end;

procedure TfrmPreparaGeracaoTEEdicao.pCarregaConfigCAREST;
begin
  btnCadLoteSubItem.Visible     := False;
  btnVisualizarSubItens.Visible := False;
  blnGeracaoItensEstrutura      := False;

  If (fItemEstrutura(edtCodIte.Text)) And (Not objPreparaGer.blnAculumarDigitacao) Then
  Begin
    If fCfgSis('CAREST', varString) = 'S' Then
    Begin
      If fMensagem('', 'Carregar os itens da estrutura?', ['&S i m', '&N ã o']) = 1 Then
      Begin
        pCarregaSubItens;
        btnCadLoteSubItem.Visible     := True;
        btnVisualizarSubItens.Visible := True;
        blnGeracaoItensEstrutura      := True;
      End;
    End
    Else If fCfgSis('CAREST', varString) = 'P' Then
    Begin
      pCarregaSubItens;
      btnCadLoteSubItem.Visible     := True;
      btnVisualizarSubItens.Visible := True;
      blnGeracaoItensEstrutura      := True;
    End;
  End;
end;

procedure TfrmPreparaGeracaoTEEdicao.pCarregaSubItens;
begin
  qrySubIte := fCriaQuery;

  qrySubIte.Close;
  qrySubIte.Sql.Clear;

  qrySubIte.SQL.Add('SELECT ');
  qrySubIte.SQL.Add('  D.DMT_ITESUB AS CODITE, ');
  qrySubIte.SQL.Add('  D.DMT_QTDITE AS QTDITE, ');
  qrySubIte.SQL.Add('  (SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = D.DMT_ITESUB) AS DESCRI ');
  qrySubIte.SQL.Add('FROM ');
  qrySubIte.SQL.Add('  CADITE C ');
  qrySubIte.SQL.Add('  INNER JOIN GERMAT G ON C.ITE_CODITE = G.GMT_CODITE ');
  qrySubIte.SQL.Add('  INNER JOIN DETMAT D ON G.AUTOINCREM = D.DMT_SEQGER ');
  qrySubIte.SQL.Add('WHERE ');
  qrySubIte.SQL.Add('  C.ITE_CODITE = :CODITE ');
  qrySubIte.SQL.Add('ORDER BY ');
  qrySubIte.SQL.Add('  D.DMT_ITESUB ');

  qrySubIte.ParamByName('CODITE').AsString := edtCodIte.Text;

  qrySubIte.Open;

  If cdsSubItens.Active Then
    cdsSubItens.EmptyDataSet;

  qrySubIte.First;
  While Not qrySubIte.Eof Do
  Begin
    cdsSubItens.Append;

    cdsSubItens.FieldByName('CODITE').AsString := qrySubIte.FieldByName('CODITE').AsString;
    cdsSubItens.FieldByName('DESCRI').AsString := qrySubIte.FieldByName('DESCRI').AsString;
    cdsSubItens.FieldByName('QTDITE').AsFloat  := qrySubIte.FieldByName('QTDITE').AsFloat;
    cdsSubItens.FieldByName('QTDTRA').AsFloat  := qrySubIte.FieldByName('QTDITE').AsFloat;

    cdsSubItens.Post;

    qrySubIte.Next;
  End;
end;

procedure TfrmPreparaGeracaoTEEdicao.FormShow(Sender: TObject);
begin
  inherited;

  pHabilitaLote(False);

  dtsItem.DataSet := objPreparaGer.qryConsulta;
  pSetFocus(edtCodIte);

  If blnCarregarDados Then
  Begin
    pCarregaDadosGrid;
  End Else
  Begin
    If Not fEmptyStr(edtCodIte.Text) Then
      fValidaCampos(edtCodIte, True);
  End;

  If objPreparaGer.blnAculumarDigitacao Then
    lblQtdTra.Caption := 'Quantidade a transferir na finalização do pedido:';

  strTEPREV := fCfgSis('TEPREV', varString);
end;

procedure TfrmPreparaGeracaoTEEdicao.pHabilitaLote(blnHabLot: Boolean);
Begin
  lblNumLot.Enabled := blnHabLot;
  edtNumLot.Enabled := blnHabLot;

  If Not edtNumLot.Enabled Then
    edtNumLot.Clear;
End;

procedure TfrmPreparaGeracaoTEEdicao.pLimpaCampos;
Begin
  objPreparaGer.qryConsulta.Close;

  edtEmpOri.Clear;
  edtNomEmpOri.Clear;
  edtSaldos.Clear;
  edtEmpDes.Clear;
  edtNomEmpDes.Clear;
  edtQtdCad.Clear;
  edtQtdTra.Clear;
  edtNumLot.Clear;
  edtSaldoDestino.Clear;

  If cdsSubItens.Active Then
    cdsSubItens.EmptyDataSet;

  blnGeracaoItensEstrutura := False;
  pHabilitaLote(False);
  pHabilitaTextoCritica(False);
  pSetFocus(edtCodIte);
End;

Function TfrmPreparaGeracaoTEEdicao.fTestaQuantidade: Boolean;
Begin

  Result := True;

  If (Not fVerificaSaldo) Then
    Result := False

  Else If fRetMltVenItem(edtCodIte.Text) > 0 Then
    Result := fLiberaMultiploVenda

  Else If (fStrToFloat(edtQtdTra.Text) = 0) Then
    Result := fPergunta('A Quantidade a transferir será zerada. Confirma?');

  If (Result) And (fCfgSis('VAQTTR', varBoolean)) And (fStrToFloat(edtQtdTra.Text) > 0) Then
    Result := fValidaQuantTransfEmpresaDestino(edtCodIte.Text, edtEmpOri.Text, edtEmpDes.Text, fStrToFloat(edtQtdTra.Text)) ;

  If (Result) Then
    Result := fPergunta('Confirma a preparação da Transferência?');

End;

procedure TfrmPreparaGeracaoTEEdicao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not fVerificaCampos) Then
    Exit;

  If (Not fTestaQuantidade) Then
    Exit;

  If (Not fVerificaPrecoItensTransfEstoque) Then
    Exit;

  If objPreparaGer.blnAculumarDigitacao Then
  Begin
    If objPreparaGer.fSalvaDigitacao(edtCodIte.Text, edtDesIte.Text, edtNumLot.Text, edtEmpOri.Text, edtEmpDes.Text, fStrToFloat(edtQtdTra.Text)) Then
    Begin
      pLimpaCampos;

      If blnCarregarDados Then
        Self.Close;
    End;
  End
  Else If fGeracaoPREPTE Then
  Begin
    objLock.pDestravarTodos;
    pMensagemOk('Operação realizada com sucesso!');
    pLimpaCampos;
  End;
end;

procedure TfrmPreparaGeracaoTEEdicao.btnCadLoteSubItemClick(Sender: TObject);
  Var
    frmCadLotSubItensEstrutura: TfrmCadLotSubItensEstrutura;
begin
  inherited;

  If Not fValidaCampos(edtEmpOri, True) Then
    Exit;

  Try
    pCriarFormularios(TfrmCadLotSubItensEstrutura, frmCadLotSubItensEstrutura);
    frmCadLotSubItensEstrutura.Caption := frmCadLotSubItensEstrutura.Caption + ' - ' + EdtCodIte.Text + ' - ' + fRetNomProduto(EdtCodIte.Text);

    cdsSubItens.First;
    While Not cdsSubItens.Eof Do
    Begin
      If (cdsSubItens.FieldByName('LOTOBG').AsString = 'S') Then
        frmCadLotSubItensEstrutura.fInserirItem(cdsSubItens.FieldByName('CODITE').AsString,
                                                EdtEmpOri.Text, False, '', cdsSubItens.FieldByName('QTDITE').AsFloat,
                                                cdsSubItens.FieldByName('QTDTRA').AsFloat);

      cdsSubItens.Next;
    End;
    frmCadLotSubItensEstrutura.ShowModal;

    cdsSubItens.First;
    While Not cdsSubItens.Eof Do
    Begin
      If (cdsSubItens.FieldByName('LOTOBG').AsString = 'S') Then
      Begin
        cdsSubItens.Edit;
        cdsSubItens.FieldByName('NUMLOT').AsString := frmCadLotSubItensEstrutura.fRetLotInformado(cdsSubItens.FieldByName('CODITE').AsString);
        cdsSubItens.Post;
      End;

      cdsSubItens.Next;
    End;
  Finally
    pFreeAndNil(frmCadLotSubItensEstrutura);
  End;
end;

procedure TfrmPreparaGeracaoTEEdicao.btnPedCompGridClick(Sender: TObject);
begin
  If fEmptyStr(edtCodIte.Text) Then
  Begin
    fMensagem('Atenção!', 'Para visualizar os pedidos é preciso selecionar um produto.', ['&OK']);
    pSetFocus(edtCodIte);
    Exit;
  End;

  try
    pCriarFormularios(TfrmRelEstPedCompraGrid, frmRelEstPedCompraGrid);
    frmRelEstPedCompraGrid.strCodIte := edtCodIte.Text;
    frmRelEstPedCompraGrid.strDesIte := edtDesIte.Text;
    frmRelEstPedCompraGrid.ShowModal;
  finally
    FreeAndNil(frmRelEstPedCompraGrid);
  end;
end;


procedure TfrmPreparaGeracaoTEEdicao.btnSairClick(Sender: TObject);
begin
  inherited;

  Close;
end;

procedure TfrmPreparaGeracaoTEEdicao.btnVisualizarSubItensClick(Sender: TObject);
  Var
    frmSelecionaItens: TfrmSelecionaItens;
begin
  inherited;

  Try
    pCriarFormularios(TfrmSelecionaItens, frmSelecionaItens);

    frmSelecionaItens.Caption := 'Visualização Sub-Itens Estrutura - '+EdtCodIte.Text + ' - ' + fRetNomProduto(EdtCodIte.Text);
    frmSelecionaItens.btnConfirma.Visible := False;
    frmSelecionaItens.btnSair.Caption := 'Sair';
    frmSelecionaItens.qryAux := qrySubIte;

    frmSelecionaItens.ShowModal;
  Finally
    pFreeAndNil(frmSelecionaItens);
  End;
end;

procedure TfrmPreparaGeracaoTEEdicao.edtCodIteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodIte, edtDesIte, arrSelNada, nil, fRetNomProduto, 'do Produto');

  pCarregaConfigCAREST;
end;

procedure TfrmPreparaGeracaoTEEdicao.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSelNada, True, nil, 'Consulta de Itens', '1') Then
  Begin
    If fvalidaCampos(edtCodIte,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmPreparaGeracaoTEEdicao.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
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
          pMensagemOk('Produto não encontrado!');
          Result := False;
        End Else
        Begin

          If (strUltimaTrava <> edtCodIte.Text) And (Not objLock.fLock_Unlock('PREPARA_TE_' + edtCodIte.Text, True, False)) Then
          Begin
            pMensagemOk('Outra estação já está preparando a transferência desse produto!');
            Result := False;
          End Else
          Begin

            strUltimaTrava := edtCodIte.Text;

            If objPreparaGer.fConsulta(edtCodIte.Text) Then
            Begin

            End;

          End;

        End;

      End;

    End

    Else If (Sender = edtEmpOri) Then
    Begin

      If fEmptyStr(edtEmpOri.Text) Then
      Begin
        pMensagemOk('Informe o código da Empresa Origem!');
        Result := False;
      End Else
      Begin
        edtNomEmpOri.Text := fRetNomeEmpresaSelec(edtEmpOri.Text);

        If fEmptyStr(edtNomEmpOri.Text) Then
        Begin
          pMensagemOk('Empresa origem  não encontrada!');
          Result := False;
        End Else
        Begin
          pHabilitaLote(objPreparaGer.objCadLot.fExisteLote(edtCodIte.Text, edtEmpOri.Text, '', False));

          If Not edtNumLot.Enabled  Then
            edtSaldos.Text := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)),
                                objPreparaGer.fSaldoDisponivel(edtCodIte.Text, edtNumLot.Text, edtEmpOri.Text));

          If (Not fEmptyStr(edtCodIte.Text)) And (Not fEmptyStr(edtEmpOri.Text)) And (Not fEmptyStr(edtEmpDes.Text)) Then
          Begin
            edtQtdCad.Text := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)),
                                objPreparaGer.fSaldoATransferir(edtCodIte.Text, edtNumLot.Text, edtEmpOri.Text, edtEmpDes.Text));

            If blnValidaIndividual And objPreparaGer.blnAculumarDigitacao Then
              edtQtdTra.Text := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)),
                                            objPreparaGer.fSaldoAcumuladoDigitacao(edtCodIte.Text, edtNumLot.Text, edtEmpOri.Text, edtEmpDes.Text));

            pHabilitaTextoCritica(fJaExisteQuantidadeCadastradaParaTransferencia(objPreparaGer.blnAculumarDigitacao, edtQtdCad.Text));

          End;
        End;
      End;

    End

    Else If (Sender = edtNumLot) Then
    Begin

      If edtNumLot.Enabled Then
      Begin

        If fEmptyStr(edtNumLot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o número do Lote!', ['&Ok']);
          Result := False;
        End

        Else If Not objPreparaGer.objCadLot.fExisteLote(edtCodIte.Text, edtEmpOri.Text, edtNumLot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Lote não encontrado!', ['&Ok']);
          Result := False;
        End Else
        Begin
          edtSaldos.Text := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), objPreparaGer.fSaldoDisponivel(edtCodIte.Text, edtNumLot.Text, edtEmpOri.Text));

          If (Not fEmptyStr(edtCodIte.Text)) And (Not fEmptyStr(edtEmpOri.Text)) And (Not fEmptyStr(edtEmpDes.Text)) Then
          Begin
            edtQtdCad.Text := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)),
                                objPreparaGer.fSaldoATransferir(edtCodIte.Text, edtNumLot.Text, edtEmpOri.Text, edtEmpDes.Text));

            If blnValidaIndividual And objPreparaGer.blnAculumarDigitacao Then
              edtQtdTra.Text := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)),
                                            objPreparaGer.fSaldoAcumuladoDigitacao(edtCodIte.Text, edtNumLot.Text, edtEmpOri.Text, edtEmpDes.Text));

            pHabilitaTextoCritica(fJaExisteQuantidadeCadastradaParaTransferencia(objPreparaGer.blnAculumarDigitacao, edtQtdCad.Text));

          End;

        End;  

      End;

    End

    Else If (Sender = edtEmpDes) Then
    Begin

      If fEmptyStr(edtEmpDes.Text) Then
      Begin

        pMensagemOk('Informe o código da Empresa Destino!');
        Result := False;

      End Else
      Begin
        edtNomEmpDes.Text := fRetNomeEmpresaSelec(edtEmpDes.Text);

        If fEmptyStr(edtNomEmpDes.Text) Then
        Begin
          pMensagemOk('Empresa destino não encontrada!');
          Result := False;
        End

        Else If edtEmpOri.Text = edtEmpDes.Text Then
        Begin
          pMensagemOk('A Empresa Origem deve ser diferente da Empresa Destino!');
          Result := False;
        End Else
        Begin

          edtQtdCad.Text := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)),
                                        objPreparaGer.fSaldoATransferir(edtCodIte.Text, edtNumLot.Text, edtEmpOri.Text, edtEmpDes.Text));

          If blnValidaIndividual And objPreparaGer.blnAculumarDigitacao Then
            edtQtdTra.Text := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)),
                                          objPreparaGer.fSaldoAcumuladoDigitacao(edtCodIte.Text, edtNumLot.Text, edtEmpOri.Text, edtEmpDes.Text));

          pHabilitaTextoCritica(fJaExisteQuantidadeCadastradaParaTransferencia(objPreparaGer.blnAculumarDigitacao, edtQtdCad.Text));

        End;

        If Result Then
           edtSaldoDestino.Text := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)),
                                  objPreparaGer.fSaldoDisponivel(edtCodIte.Text, edtNumLot.Text, edtEmpDes.Text));

      End;

    End

    Else If (Sender = edtQtdTra) Then
    Begin

      If objPreparaGer.blnAculumarDigitacao Then
      Begin

        If (fStrToFloat(edtQtdTra.Text) < 0) Then
        Begin
          pMensagemOk('A quantidade a transferir deve ser maior ou igual a zero!');
          Result := False;
        End

      End

      Else If (fStrToFloat(edtQtdTra.Text) <= 0) Then
      Begin
        pMensagemOk('A quantidade a transferir deve ser maior que zero!');
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmPreparaGeracaoTEEdicao.fValidaConfiguracaoPrecoTransfEstoque(strCodIte: String): Boolean;
  Var
    strCampoItem  : String;
    strMensagem   : String;
    strTipoPreco  : String;
    qryDados      : TUniQuery;
    blnTEPREV     : Boolean;
begin
  Result := True;

  blnTEPREV := False;
  strTipoPreco := fRetornaConfiguracaoPrecoTranfEstoqueConemp;

  If fEmptyStr(strTipoPreco) Then
  Begin
    strTipoPreco := strTEPREV;
    blnTEPREV    := True;
  End;

  If fEmptyStr(strTEPREV) Then
  Begin
    fMensagem('Atenção!', 'Não foi possível localizar o preço que deve ser utilizado nesta operação, verifique: ' + #13#10 +
                          'A configuração(CFG_TEPREV) - Preço para Transferência de Estoque - Preço sugerido ' + #13#10 +
                          'Aba "CONFIGURAÇÃO DE TRANSF. DE ESTOQUE" no CADASTRO DE EMPRESAS.' , ['&OK']);
    Exit(False);
  End;


  Case AnsiIndexStr(strTipoPreco, ['CUS', 'VE1', 'VE2', 'VE3', 'VE4', 'VE5',
                                   'VE6', 'VE7', 'ULT', 'IMP', 'MED', 'CSD', 'SIC', 'CFI']) of
    0:Begin strCampoItem := 'ITE_PRECUS'; strMensagem := 'PREÇO DE CUSTO'   End;
    1:Begin strCampoItem := 'ITE_PREVE1'; strMensagem := 'PRECO DE VENDA 1' End;
    2:Begin strCampoItem := 'ITE_PREVE2'; strMensagem := 'PRECO DE VENDA 2' End;
    3:Begin strCampoItem := 'ITE_PREVE3'; strMensagem := 'PRECO DE VENDA 3' End;
    4:Begin strCampoItem := 'ITE_PREVE4'; strMensagem := 'PRECO DE VENDA 4' End;
    5:Begin strCampoItem := 'ITE_PREVE5'; strMensagem := 'PRECO DE VENDA 5' End;
    6:Begin strCampoItem := 'ITE_PREVE6'; strMensagem := 'PRECO DE VENDA 6' End;
    7:Begin strCampoItem := 'ITE_PREVE7'; strMensagem := 'PRECO DE VENDA 7' End;
    8:Begin strCampoItem := 'ITE_PREULT'; strMensagem := 'PREÇO DA ÚLTIMA COMPRA' End;
    9:Begin strCampoItem := 'ITE_IMPULT'; strMensagem := 'PREÇO DA ÚLTIMA COMPRA + IMPOSTOS' End;
    10:Begin strCampoItem := 'ITE_PREMED'; strMensagem := 'PREÇO MÉDIO' End;
    11:Begin strCampoItem := 'ITE_PRECUS'; strMensagem := 'PREÇO CUSTO REAL PROM. S/DESP. OP.' End;
    12:Begin strCampoItem := 'ITE_MEDSIC'; strMensagem := 'PREÇO MÉDIO SEM ICMS' End;
    13:Begin strCampoItem := 'ITE_PRECUS'; strMensagem := 'PREÇO DE CUSTO - VALOR DO FRETE / (1-(ICMS SAÍDA + IMPOSTOS FEDERAIS + DESPESAS OPERACIONAIS))'  End;
  End;

  Try
    qryDados := fCriaQuery;

    qryDados.Sql.Clear;
    qryDados.Sql.Add(' SELECT IFNULL(' + strCampoItem + ' ,0) AS CAMPO    ');
    qryDados.Sql.Add(' FROM ITEGER                  ');
    qryDados.Sql.Add(' WHERE ITE_CODITE = :CODITE   ');
    qryDados.Sql.Add('   AND ITE_CODEMP = :CODEMP   ');

    qryDados.ParamByName('CODITE').AsString := strCodIte;
    qryDados.ParamByName('CODEMP').AsString := EdtEmpOri.Text;

    qryDados.Close;
    qryDados.Open;

    If (qryDados.FieldByName('CAMPO').AsFloat <= 0.00) Then
    Begin
      fMensagem('Atenção!', 'O sistema está configurado para gerar a transferência ' +
                            IfThen(blnTEPREV, '(CFG_TEPREV) ', 'na aba "CONFIGURAÇÃO DE TRANSF. DE ESTOQUE" no CADASTRO DE EMPRESAS ') + #13#10 +
                            'utilizando o ' + strMensagem + ' ' + #13#10 +
                            'e o valor está zerado para o item: '+ strCodIte + ' ' + #13#10 +
                            'na Empresa de Origem: '+ EdtEmpOri.Text + ' ' + #13#10 +
                            'Por favor ajustar antes de continuar com a transferência.', ['&OK']);
      Result:= False;
    End;

  Finally
    FreeAndNil(qryDados)
  End;
end;

function TfrmPreparaGeracaoTEEdicao.fValidaGeracaoSubItensComLote: Boolean;
begin
  Result := True;

  cdsSubItens.First;
  While Not cdsSubItens.Eof Do
  Begin
    If (cdsSubItens.FieldByName('LOTOBG').AsString = 'S') And (fEmptyStr(cdsSubItens.FieldByName('NUMLOT').AsString)) Then
    Begin
      Result := False;
      Exit;
    End;

    cdsSubItens.Next;
  End;
end;

function TfrmPreparaGeracaoTEEdicao.fVerificaPrecoItensTransfEstoque: Boolean;
begin
  Result := False;

  If blnGeracaoItensEstrutura Then
  Begin
    cdsSubItens.First;
    While Not cdsSubItens.Eof Do
    Begin
      Result := fValidaConfiguracaoPrecoTransfEstoque(cdsSubItens.FieldByName('CODITE').AsString);
      If Not Result Then
        Exit;

      cdsSubItens.Next;
    End;
  End
  Else
    Result := fValidaConfiguracaoPrecoTransfEstoque(edtCodIte.Text);
end;

function TfrmPreparaGeracaoTEEdicao.fVerificaSaldo: Boolean;
  Var
    strSaldos: String;
begin
  Result := True;

  If blnGeracaoItensEstrutura Then
  Begin
    cdsSubItens.First;
    While Not cdsSubItens.Eof Do
    Begin
      strSaldos := FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)),
                               objPreparaGer.fSaldoDisponivel(cdsSubItens.FieldByName('CODITE').AsString,
                                                              cdsSubItens.FieldByName('NUMLOT').AsString,
                                                              edtEmpOri.Text));

      If (fStrToFloat(cdsSubItens.FieldByName('QTDTRA').AsString) > fStrToFloat(strSaldos)) Then
        Result := fLiberaTransferencia(cdsSubItens.FieldByName('CODITE').AsString,
                                       cdsSubItens.FieldByName('DESCRI').AsString,
                                       cdsSubItens.FieldByName('QTDTRA').AsString,
                                       strSaldos);

      If Not Result Then
        Exit;

      cdsSubItens.Next;
    End;
  End
  Else If (fStrToFloat(edtQtdTra.Text) > fStrToFloat(edtSaldos.Text)) Then
    Result := fLiberaTransferencia(edtCodIte.Text, edtDesIte.Text, edtQtdTra.Text, edtSaldos.Text);
end;

procedure TfrmPreparaGeracaoTEEdicao.pHabilitaTextoCritica(
  blnMostraTextoCritica: Boolean);
begin
  lblCriticaTexoParte1.Visible:= blnMostraTextoCritica;
  lblCriticaTexoParte2.Visible:= blnMostraTextoCritica;
end;

function TfrmPreparaGeracaoTEEdicao.fGeracaoPREPTE: Boolean;
begin
  If blnGeracaoItensEstrutura Then
    Result := fGeracaoPREPTEItensEstrutura
  Else
    Result := objPreparaGer.fSalvaPreparacao(edtCodIte.Text, edtNumLot.Text, edtEmpOri.Text, edtEmpDes.Text, fStrToFloat(edtQtdTra.Text));
end;

function TfrmPreparaGeracaoTEEdicao.fGeracaoPREPTEItensEstrutura: Boolean;
begin
  Result := False;

  If Not fValidaGeracaoSubItensComLote Then
  Begin
    fMensagem('Atenção!', 'Informe os lotes dos Sub-Itens!', ['&OK']);
    Exit;
  End;

  cdsSubItens.First;
  While Not cdsSubItens.Eof Do
  Begin
    Result := objPreparaGer.fSalvaPreparacao(cdsSubItens.FieldByName('CODITE').AsString, cdsSubItens.FieldByName('NUMLOT').AsString, edtEmpOri.Text, edtEmpDes.Text, cdsSubItens.FieldByName('QTDTRA').AsFloat);

    cdsSubItens.Next;
  End;
end;

function TfrmPreparaGeracaoTEEdicao.fJaExisteQuantidadeCadastradaParaTransferencia(
  blnAcumulaDigitacao: Boolean; strQuantidadeJaCadastrada: String): Boolean;
Begin
  Result:= False;

  If Not(fEmptyStr(strQuantidadeJaCadastrada)) Then
    Result:= (Not(blnAcumulaDigitacao)) And (fStrToFloat(strQuantidadeJaCadastrada) > 0);

End;

end.
