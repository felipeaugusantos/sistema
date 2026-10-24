unit untEntConferPreNotaMotorola;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  frxClass, frxDBSet, StrUtils, untTypesSistema, TypesRel, untFuncoesRel2,
  Math, ShlObj, untFuncoesRel, BitBtnLockedIncrem, MemDS, DBAccess, Provider,
  frxExportCSVTestabilidade, untEntConfPreNotaFuncoes, Datasnap.DBClient;

type
  TFuncUpItem = Function (strAutInc: String; Var fltQtdIte: Double): Boolean Of Object;

  TfrmEntConferPreNotaMotorola = class(TfrmPaiOrdena)
    cdsCriticas: TUniClientDataSet;
    cdsCriticasCODITE: TStringField;
    cdsCriticasQTDITE: TFloatField;
    cdsCriticasQTDCON: TFloatField;
    cdsCriticasDESITE: TStringField;
    cdsCriticasSIGUNI: TStringField;
    cdsCriticasCODFAB: TStringField;
    cdsCriticasLOCFIS: TStringField;
    cdsCriticasSALDOS: TFloatField;
    cdsCriticasQTDXML: TFloatField;
    btnExcluir: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnExcluirItensIncons: TBitBtnLocked;
    btnQuantidade: TBitBtnLocked;
    btnCriticas: TBitBtnLocked;
    pnlDigitador: TPanel;
    pnlItens: TPanel;
    pnlNfe: TPanel;
    lblNotEle: TLabel;
    btnNotEle: TBitBtnLocked;
    edtNotEle: TEditFocus;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    Label3: TLabel;
    edtQtdIte: TEditFocus;
    lbl3: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cdsConsultaAfterClose(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCriticasClick(Sender: TObject);
    procedure btnNotEleClick(Sender: TObject);
    procedure btnNotEleEnter(Sender: TObject);
    procedure btnExcluirItensInconsClick(Sender: TObject);
  private
    { Private declarations }
    qryNotEle: TUniQuery;

    stlIncNfe: TStringList;

    strIdeDig: String;

    blnBarCen : Boolean;
    blnFcQtEt : Boolean;

    objConfPreNota: TConferePreNota;

    function fDocumentoLiberado: Boolean;

    procedure pCancela(blnPerguntar: Boolean = True);
    procedure pCdsConsultaBeforeDelete(Sender: TDataset);

  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;

    procedure pAcaoAbort; override;

  end;

Const
  MSG_ETIQUETA = 'Etiqueta não selecionada';


implementation

uses untPai, untFatSelecProduto, untRelacSemelhanca, untEntConfPedidosPreNotaMotorola,
     untCfgRel, untRelEntConferencia, untFuncFat,untConstantes,
     untFuncoesSimples, untFuncoesEtiqItens, untDllOpeProd,
     untPesqAux, untQckLiberacaoArmazenamento, untImpEtiquetas, untEntImportaColetor;

{$R *.dfm}

function TfrmEntConferPreNotaMotorola.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtSenDig) And (pnlDigitador.Enabled) Then
    Begin
      If fEmptyStr(edtSenDig.Text) Then
      Begin
        fMensagemAuto('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
      	strLoginUsuarioLogado 	 := fRetCodVendedor(edtSenDig.Text);
        objConfPreNota.strCodDig := fRetCodVendedor(edtSenDig.Text);
        edtNomDig.Text 					 := fRetNomeOperador(objConfPreNota.strCodDig);

        If fEmptyStr(objConfPreNota.strCodDig) Then
        Begin
          fMensagemAuto('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fOperadorAtivo(objConfPreNota.strCodDig) Then
        Begin
          fMensagemAuto('ATENÇÃO!', 'Esse digitador está inativo!', ['&O k']);
          Result := False;
        End
        Else
        Begin
        	pnlDigitador.Enabled := False;
	        pnlDigitador.Visible := False;
  	      Caption := 'Conferência - Operador: ' + objConfPreNota.strCodDig + '-' + edtNomDig.Text;

          pnlItens.Enabled      				:= True;
          pnlNFe.Enabled      					:= True;
	        btnExcluir.Enabled    				:= True;
  	      btnQuantidade.Enabled 				:= True;
    	    btnConfirma.Enabled   				:= True;
          btnCriticas.Enabled						:= True;
          btnExcluirItensIncons.Enabled := True;

          blnMudarFoco := False;

          pnlHeader.Height := pnlNfe.Height + pnlItens.Height + 5;

        	pSetFocus(btnNotEle);
        	Exit;
        End;
      End;
    End

    Else If (Sender = edtCodIte) Then
    Begin
      Result := True;
      blnMudarFoco := False;
    End

    Else If (Sender = edtQtdIte) Then
    Begin

      If (fEmptyStr(edtQtdIte.Text)) Then
      Begin
        pMensagemSonora('A quantidade deve ser preenchida!', True);
        Result := False;
      End
      Else If (fStrToFloat(edtQtdIte.Text) <= 0.0) Then
      Begin
        pMensagemSonora('A quantidade deve ser maior que zero!', True);
        Result := False;
      End

      Else
      Begin
        pSetFocus(edtCodIte);
        edtQtdIte.Enabled := False;
        blnMudarFoco := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmEntConferPreNotaMotorola.fGetSql(blnLike: Boolean): String;
Begin
  Result := objConfPreNota.fGetSqlPrincipal(blnLike);
End;

procedure TfrmEntConferPreNotaMotorola.pCancela(blnPerguntar: Boolean = True);
Begin
  If btnNotEle.Focused Or cdsConsulta.IsEmpty Then
    Close

  Else If (Not blnPerguntar) Or
          (fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1) Then
  Begin
    btnNotEle.Enabled := True;
    pSetFocus(btnNotEle);
  End;
End;

procedure TfrmEntConferPreNotaMotorola.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_RETURN: If edtCodIte.Focused Then
               begin
                 If fEmptyStr(edtCodIte.Text) Then
                   Exit;

                 If Not fValidaCampos(edtQtdIte, False) Then
                   Exit;

                 If Not cdsConsulta.Active Then
                   Exit;

                 objConfPreNota.fRegistraItem(True, False, False, nil, edtCodIte, edtQtdIte,
                                              blnBarCen, cdsConsulta, qryCfgRel, Self.Name,
                                              nil, stlIncNfe);
               end
               Else
                 inherited;

    VK_F3: Begin
           		Key := 0;
           End;

    VK_F5: Begin
           		Key := 0;
           End;

    VK_F6: btnQuantidade.Click;

    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;

    VK_ESCAPE:  If pnlPesquisa.Visible Then
                  inherited
                Else
                Begin
                  Key := 0;
                  pCancela;
                End;

    VK_DELETE: If dbgConsulta.Focused Then
                 btnExcluir.Click;

    Else inherited;
  End;

end;

procedure TfrmEntConferPreNotaMotorola.FormShow(Sender: TObject);
begin
  inherited;
  btnPesquisar.Visible := False;
  btnMudaOrdem.Visible := False;

  blnSempreRelerBanco := FALSE;
  blnTemSelecao       := FALSE;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pSetFocus(edtSenDig);

  btnCriticas.Enabled := fVerificaAcessoSistema('RELCPN');
end;

procedure TfrmEntConferPreNotaMotorola.btnQuantidadeClick(Sender: TObject);
begin
  inherited;
  If {(Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Or }(Not btnQuantidade.Enabled) Then
    Exit;

  edtQtdIte.Enabled := True;
  pSetFocus(edtQtdIte);
end;

procedure TfrmEntConferPreNotaMotorola.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Exit;

  With cdsConsulta Do
    If fMensagem('', 'Deseja excluir o item ' + FieldByName('ITE_CODITE').AsString + ' ?', ['&Sim', '&Não']) = 1 Then
      Delete;

  pSetFocus(edtCodIte);
end;

procedure TfrmEntConferPreNotaMotorola.btnExcluirItensInconsClick(Sender: TObject);
begin
  inherited;

  pLimpaPesquisa;

  If Not objConfPreNota.fPosssuiInconsistencias(cdsConsulta, cdsCriticas, qryNotEle) Then
    fMensagem('', 'Não há inconsistências no Documento!', ['&Ok'])

  Else If fMensagem('','Confirma exclusão dos itens com inconsistências?', ['','']) = 1 Then
  Begin
    objConfPreNota.pExcluirItensIncons(cdsConsulta, cdsCriticas);
  End;

end;

procedure TfrmEntConferPreNotaMotorola.btnNotEleClick(Sender: TObject);
begin
  inherited;

  pCriarFormularios(TfrmEntConfPedidosPreNotaMotorola, frmEntConfPedidosPreNotaMotorola);

  frmEntConfPedidosPreNotaMotorola.objConfPreNota := objConfPreNota;

  If frmEntConfPedidosPreNotaMotorola.ShowModal = mrOK Then
  Begin
    strIdeDig      := objConfPreNota.strIdeDig;
    stlIncNfe.Text := objConfPreNota.strIncrem;
    edtNotEle.Text := objConfPreNota.strDocume;
  End;

  pFreeAndNil(frmEntConfPedidosPreNotaMotorola);

  If stlIncNfe.Count = 0 Then
  Begin
    fMensagemAuto('ATENÇÃO!', 'Selecione a NFe para conferência!', ['&O k']);
  End

  Else If fDocumentoLiberado And fAbreConsulta(TRUE) Then
  Begin
    btnNotEle.Enabled := False;
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmEntConferPreNotaMotorola.btnNotEleEnter(Sender: TObject);
begin
  inherited;
  cdsConsulta.Close;
  strIdeDig := EmptyStr;
  stlIncNfe.Clear;
  edtNotEle.Clear;
end;

procedure TfrmEntConferPreNotaMotorola.btnSairClick(Sender: TObject);
begin
  pCancela;
end;

procedure TfrmEntConferPreNotaMotorola.cdsConsultaAfterClose(DataSet: TDataSet);
begin
  inherited;
  objConfPreNota.pLiberaDocumentos(stlIncNfe);
end;

procedure TfrmEntConferPreNotaMotorola.pAcaoAbort;
Begin
  pSetFocus(edtCodIte);
End;

function TfrmEntConferPreNotaMotorola.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  Result := inherited fAbreConsulta(blnLike);

  objConfPreNota.pCarregaItensNotaEletronica(stlIncNfe, qryNotEle, cdsConsulta);
  objConfPreNota.pSetaRequeridos(cdsConsulta);
End;

procedure TfrmEntConferPreNotaMotorola.FormCreate(Sender: TObject);
begin
  inherited;

  WindowState := wsMaximized;

  stlIncNfe := TStringList.Create;
  qryNotEle := fCriaQuery(Self);

  cdsCriticas.CreateDataSet;
  cdsCriticas.Open;

  edtQtdIte.EditFormat := fMskDigitos(fCfgSis('DEQTPC', varInteger));

  blnBarCen   := fCfgSis('BARCEN', varBoolean);
  blnFcQtEt   := fCfgSis('FCQTET', VarBoolean);

  cdsConsulta.BeforeDelete := pCdsConsultaBeforeDelete;

  objConfPreNota := TConferePreNota.Create;
end;

procedure TfrmEntConferPreNotaMotorola.btnConfirmaClick(Sender: TObject);
  Var
    frmQckLiberacaoArmazenamento: TfrmQckLiberacaoArmazenamento;
begin
  inherited;

  If (Not cdsConsulta.Active) Then
    Exit;  

  If fMensagem('', 'Confirma a finalização da conferência?', ['&Sim', '&Não']) = 1 Then
  Begin

    If objConfPreNota.fGravaConferencia(cdsConsulta, cdsCriticas, edtNotEle, nil, qryNotEle, stlIncNfe) Then
    Begin

      If fCfgSis('LIBPNT', varBoolean) then
      Begin
        pCriarFormularios(TfrmQckLiberacaoArmazenamento, frmQckLiberacaoArmazenamento);
        With frmQckLiberacaoArmazenamento Do
          pImprimir(strIdeDig, 'frmEntConferPreNota_LIBARM', '', oriLibPreNota);
        FreeAndNil(frmQckLiberacaoArmazenamento);
      End;

      pCancela(False);

    End;

  End;

end;

procedure TfrmEntConferPreNotaMotorola.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  cdsCriticas.EmptyDataSet;
  cdsCriticas.Close;

  {*************************************}
  {* LIBERA A LISTA DE LOCKS AO FECHAR *}
  {**********************************DP*}
  objConfPreNota.pLiberaDocumentos(stlIncNfe);

  If Assigned(stlIncNfe) Then
    FreeAndNil(stlIncNfe);

  If Assigned(qryNotEle) then
  	FreeAndNil(qryNotEle);

  If Assigned(objConfPreNota) then
  	FreeAndNil(objConfPreNota);
end;

procedure TfrmEntConferPreNotaMotorola.btnCriticasClick(Sender: TObject);
begin
  inherited;
  objConfPreNota.pCriticas(cdsConsulta, cdsCriticas, qryNotEle, edtNotEle, nil, nil, True);
end;

Function TfrmEntConferPreNotaMotorola.fDocumentoLiberado: Boolean;
  var
    intIndice: Integer;
Begin
  Result := True;

  For intIndice := 0 To stlIncNfe.Count -1 Do
  Begin
    Result := fLock_Unlock('NFE' + stlIncNfe[intIndice], True, False, True);

    If Not Result Then
    Begin
      fMensagemAuto('', 'Esse Documento está sendo utilizado em outra Estação por ' +
                        fGetHostLock('NFE' + stlIncNfe[intIndice])  + '!', ['&Ok']);
      Break;
    End;
  End;

End;

procedure TfrmEntConferPreNotaMotorola.pCdsConsultaBeforeDelete(Sender: TDataset);
Var
  qryDelete : TUniQuery;
begin
  try
    qryDelete := fCriaQuery(Self);
    With qryDelete, SQL Do
    Begin
      Clear;
      Add('DELETE FROM DIGELE WHERE AUTOINCREM = :AUTOINC');
      ParamByName('AUTOINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryDelete);
  End;
end;


end.
