unit untCadComFatVend;

interface

uses
  Windows, Classes, Controls, Forms, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, Uni,
  ExtCtrls, DB, Grids, DBGridCitel, DBGrids, DBCtrls, DBEditFocus, EditFocus, untComFatVend,
  untPaiCad, BitBtnLockedIncrem, Mask, frxClass, frxExportCSVTestabilidade,
  DBLookupComboBoxFocus, UniClientDataSet, Variants;

type
  TfrmCadComFatVend = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dtsComFat: TDataSource;
    pnlTopo: TPanel;
    dbeCodPes: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeDescricao: TDBEditFocus;
    pnlGrid: TPanel;
    pnlCentro: TPanel;
    dbgDados: TDBGridCitel;
    edtFatIni: TEditFocus;
    edtFatFin: TEditFocus;
    edtPerCom: TEditFocus;
    lblFatIni: TLabel;
    Label12: TLabel;
    lblFatFin: TLabel;
    lblPerCom: TLabel;
    dtsDados: TDataSource;
    btnAdicionar: TBitBtnLocked;
    lblMarIni: TLabel;
    lblMarFin: TLabel;
    bvlFatIni: TBevel;
    bvlPerCom: TBevel;
    dbeMarIni: TEditFocus;
    dbeMarFin: TEditFocus;
    dbeCodGat: TEditFocus;
    lblCodGat: TLabel;
    bvlCodGat: TBevel;
    bvlBonificacao: TBevel;
    edtPerBonificacao: TEditFocus;
    lblPercentualBonificacao: TLabel;
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
    procedure dbeCodPesExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure dbeCodGatKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objComFat: TComFatVend;
    blnUsaProCod: Boolean;

    procedure pLimpaCampos;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; Override;
  end;

implementation

uses SysUtils, untFuncoesSimples, untConstantes, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadComFatVend.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(objComFat);
  inherited;
end;

procedure TfrmCadComFatVend.FormCreate(Sender: TObject);
begin
  objComFat := TComFatVend.Create(Self);
  inherited;

  strNomeTabela := 'COMFAV';
  strNomeCampo  := 'COM_CODTAB';
  qryTabela     := objComFat.qryTabela;
  dtsComFat.DataSet := qryTabela;
  dtsDados.DataSet  := objComFat.cdsDados;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPes;
  blnUsaProCod := fUsaProCodigo('COMFAV');
  pHabilitaCodigo(dbeCodPes, dbeCodPes, Not blnUsaProCod);
  objComFat.blnUsaProCod := blnUsaProCod;

  if not fCfgSis('UTGRAT', varBoolean) then
  begin
    lblCodGat.Visible             := False;
    dbeCodGat.Visible             := False;
    bvlCodGat.Visible             := False;
    dbgDados.Columns[0].Visible   := False;
    lblMarIni.Left                := lblMarIni.Left - 74;
    dbeMarIni.Left                := dbeMarIni.Left - 74;
    lblMarFin.Left                := lblMarFin.Left - 74;
    dbeMarFin.Left                := dbeMarFin.Left - 74;
    bvlFatIni.Left                := bvlFatIni.Left - 74;
    lblFatIni.Left                := lblFatIni.Left - 74;
    edtFatIni.Left                := edtFatIni.Left - 74;
    lblFatFin.Left                := lblFatFin.Left - 74;
    edtFatFin.Left                := edtFatFin.Left - 74;
    bvlPerCom.Left                := bvlPerCom.Left - 74;
    lblPerCom.Left                := lblPerCom.Left - 74;
    bvlBonificacao.Left           := bvlBonificacao.Left - 74;
    lblPercentualBonificacao.Left := lblPercentualBonificacao.left - 74;
    edtPerCom.Left                := edtPerCom.Left - 74;
    edtPerBonificacao.Left        := edtPerBonificacao.Left - 74;
    btnAdicionar.Left             := btnAdicionar.Left - 74;
    Width                         := Width - 74;
  end;
end;

procedure TfrmCadComFatVend.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadComFatVend.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COM_CODTAB');
  stlCampos.Add('COM_DESCRI');
  stlCampos.Add('COM_CODGAT');
  stlCampos.Add('COM_FATINI');
  stlCampos.Add('COM_FATFIN');
  stlCampos.Add('COM_MARINI');
  stlCampos.Add('COM_MARFIN');
  stlCampos.Add('COM_PERCOM');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COM_CODTAB+COM_FATINI+COM_FATFIN');
  stlCamInd.Add('COM_DESCRI');
  stlCamInd.Add('COM_CODTAB');

  stlDesInd.Add('Código/Faturamento Inicial/Faturamento Final');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadComFatVend.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  objComFat.cdsDados.EmptyDataSet;
  objComFat.objTipoAcao := aoInserindo;
  If blnUsaProCod Then
    pSetFocus(dbeDescricao)
  Else
    pSetFocus(dbeCodPes);
end;

procedure TfrmCadComFatVend.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  objComFat.objTipoAcao := aoEditando;
  pHabilitaCodigo(dbeCodPes, dbeCodPes, Not blnUsaProCod);
  If blnUsaProCod Then
    pSetFocus(dbeDescricao)
  Else
    pSetFocus(dbeCodPes);
end;

procedure TfrmCadComFatVend.pLimpaCampos;
begin
  dbeMarIni.Text := '0,000';
  dbeMarFin.Text := '0,000';
  edtFatIni.Text := '0,000';
  edtFatFin.Text := '0,000';
  edtPerCom.Text := '0,00';
  edtPerBonificacao.Text := '0,00';
  dbeCodGat.Text := '';
end;

function TfrmCadComFatVend.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try
    If (Sender = dbeCodPes) Then
    Begin
      objComFat.strCodTab := dbeCodPes.Text;
      If fEmptyStr(dbeCodPes.Text) And (Not blnUsaProCod) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeDescricao) Then
    Begin
      objComFat.strDescri := dbeDescricao.Text;
      If fEmptyStr(dbeDescricao.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeCodGat) Then
    Begin
      if not fEmptyStr(dbeCodGat.Text) then
      begin
        if fEmptyStr(fRetDescGrupoAtividade(dbeCodGat.Text)) then
        begin
          fMensagem('ATENÇÃO!', 'Grupo de Atividade não cadastrado', ['&Ok']);
          Result := False;
        end
        else
          objComFat.strCodGat := dbeCodGat.Text;
      end
      else
        objComFat.strCodGat := '';
    End
    Else If (Sender = dbeMarIni) Then
    Begin
      objComFat.strMarIni := fStrToFloat(dbeMarIni.Text);
      If (fStrToFloat(dbeMarIni.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Margem Inicial deve ser maior que zero!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not blnBuscaPorChave) Then
          Result := objComFat.fValidaMargemOuFatInvidual(fStrToFloat(dbeMarIni.Text),
                                                        'COM_MARINI',
                                                        'COM_MARFIN',
                                                        fStrToFloat(edtFatIni.Text),
                                                        fStrToFloat(edtFatFin.Text),
                                                        dbeCodGat.Text);
      End;
    End
    Else If (Sender = dbeMarFin) Then
    Begin
      objComFat.strMarFin := fStrToFloat(dbeMarFin.Text);
      If (fStrToFloat(dbeMarFin.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Margem Final deve ser maior que zero!', ['&Ok']);
        Result := False;
      end
      Else If fStrToFloat(dbeMarIni.Text) > fStrToFloat(dbeMarFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Margem Final deve ser maior que a Margem Inicial!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not blnBuscaPorChave) Then
          Result := objComFat.fValidaMargemOuFatInvidual(fStrToFloat(dbeMarFin.Text),
                                                         'COM_MARINI',
                                                         'COM_MARFIN',
                                                         fStrToFloat(edtFatIni.Text),
                                                         fStrToFloat(edtFatFin.Text),
                                                         dbeCodGat.Text);
      End;
    End
    Else If (Sender = edtFatIni) And blnBuscaPorChave Then
    Begin
      objComFat.strFatIni := fStrToFloat(edtFatIni.Text);
      If (fStrToFloat(edtFatIni.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Faturamento Inicial deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtFatFin) And blnBuscaPorChave Then
    Begin
      objComFat.strFatFin := fStrToFloat(edtFatFin.Text);
      If (fStrToFloat(edtFatFin.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Faturamento Final deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatIni.Text) > fStrToFloat(edtFatFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Faturamento Final deve ser maior que o Faturamento Inicial!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtPerCom) And blnBuscaPorChave Then
    Begin
      objComFat.strPerCom := fStrToFloat(edtPerCom.Text);
      If (fStrToFloat(edtPerCom.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % de Comissão deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtPerBonificacao) And blnBuscaPorChave Then
    Begin
      If (fStrToFloat(edtPerBonificacao.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % de Comissão deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
      Else
        objComFat.PercentualBonificacao := fStrToFloat(edtPerBonificacao.Text);
    End;
  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagensErro(E.Message,'');
      Result := False;
    End;
  End;
  
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadComFatVend.dbgDadosDblClick(Sender: TObject);
begin
  inherited;
  If btnGravar.Enabled Then
  Begin
    dbeMarIni.Text      := FormatFloat('#,##0.000', objComFat.cdsDados.FieldByName('COM_MARINI').AsFloat);
    dbeMarFin.Text      := FormatFloat('#,##0.000', objComFat.cdsDados.FieldByName('COM_MARFIN').AsFloat);
    edtFatIni.Text      := FormatFloat('#,##0.000', objComFat.cdsDados.FieldByName('COM_FATINI').AsFloat);
    edtFatFin.Text      := FormatFloat('#,##0.000', objComFat.cdsDados.FieldByName('COM_FATFIN').AsFloat);
    edtPerCom.Text      := FormatFloat('#,##0.00' , objComFat.cdsDados.FieldByName('COM_PERCOM').AsFloat);
    edtPerBonificacao.Text  := FormatFloat('#,##0.00' , objComFat.cdsDados.FieldByName('COM_PERBON').AsFloat);
    dbeCodGat.Text      := objComFat.cdsDados.FieldByName('COM_CODGAT').AsString;
    objComFat.strAutInc := objComFat.cdsDados.FieldByName('AUTOINCREM').AsString;
    pSetFocus(dbeMarIni);
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadComFatVend.dbgDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE: If btnGravar.Enabled Then objComFat.pDeletaItem;
    VK_ESCAPE: pEscapePressed;
    VK_RETURN: dbgDadosDblClick(Sender);
  End;

end;

procedure TfrmCadComFatVend.btnGravarClick(Sender: TObject);
begin
  //inherited;
  Try
    pnlInfo.Caption := 'Gravando registro! Aguarde....';
    If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
    Begin
      If blnUsaProCod And (qryTabela.State = dsInsert) And fEmptyStr(dbeCodPes.Text) Then
      Begin
        dbeCodPes.Text := fPadL(fAtualizaProCod('COMFAV', '', ''), fRetTamCampo('COMFAV'), '0');

        While objComFat.fExisteProCodCadastrado(dbeCodPes.Text) Do
          dbeCodPes.Text := fPadL(fAtualizaProCod('COMFAV', '', ''), fRetTamCampo('COMFAV'), '0');

        objComFat.strCodTab := dbeCodPes.Text;
      End;

      If (fValidaCampos(dbeCodPes)) And
         (fValidaCampos(dbeDescricao)) Then
      Begin
        fStartTransaction;
        objComFat.pAtualizaRegistros;
        objComFat.cdsDados.ApplyUpdates(0);
        qryTabela.Cancel;
        objComFat.pAtualizaTabela;
        fCommit;

        pOnStateChange;
        pEnabled(Self, False);
        If btnIncluir.CanFocus Then
          pSetFocus(btnIncluir)
        Else If btnPesquisa.CanFocus Then
          pSetFocus(btnPesquisa);

        blnGravou := True;
      End;

      pLimpaCampos;
      pnlInfo.Caption := '';
    End;
  Except
    On E: EUniError Do
    Begin
      If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
      Begin
        fRollBack;
        pMensagensErro(E.Message, '');
      End
      Else
      Begin
        fRollBack;
        pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, '');
      End;
      blnGravou := False;
    End;
    On E: Exception Do
    Begin
      fRollBack;
      blnGravou := False;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmCadComFatVend.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not btnGravar.Enabled Then
    Exit;
    
  Try
    If fVerificaCampos And
       fValidaCampos(edtPerCom) And
       fValidaCampos(dbeCodGat) Then
    Begin
      objComFat.strFatIni             := fStrToFloat(edtFatIni.Text);
      objComFat.strFatFin             := fStrToFloat(edtFatFin.Text);
      objComFat.PercentualBonificacao := fStrToFloat(edtPerBonificacao.Text);

      If (Not fEmptyStr(objComFat.strAutInc)) Then
        objComFat.pAlteraDados
      Else
        objComFat.pInsereDados;

      pLimpaCampos;
      pSetFocus(dbeMarIni);
      objComFat.strAutInc := '';
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'');
    End;
  End;
end;

procedure TfrmCadComFatVend.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
  objComFat.pAtualizaDados;
end;

procedure TfrmCadComFatVend.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    qryPesq: TUniQuery;
begin
  chrKey := '/';
  qryPesq := fCriaQuery(Self);

  If fPesqComissaoFatVend(conSimples,
                          Self,
                          nil,
                          nil,
                          qryPesq,
                          chrKey,
                          arrsel) Then
  Begin
    pLimpaCampos;
    
    If (qryPesq.Active) And (Not qryPesq.IsEmpty) Then
    Begin
      With qryTabela Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM COMFAV WHERE COM_CODTAB = :CODTAB');
        ParamByName('CODTAB').AsString := qryPesq.FieldByName('COM_CODTAB').AsString;
        Open;
      End;

      If (Not qryTabela.IsEmpty) Then
        objComFat.pAtualizaDados;
    End
    Else
      objComFat.cdsDados.EmptyDataSet;

    pSetFocus(btnAlterar);
  End;
  
  FreeAndNil(qryPesq);
end;

procedure TfrmCadComFatVend.btnExcluirClick(Sender: TObject);
begin
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
  Begin
    objComFat.objTipoAcao := aoDeletando;
    objComFat.strCodTab   := dbeCodPes.Text;

    Try
      fStartTransaction;

      If objComFat.fExcluiRegistro Then
      Begin
        fCommit;
        pLimpaCampos;
        objComFat.cdsDados.EmptyDataSet;
        qryTabela.Close;
        qryTabela.Open;
      End
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[btnGravarClick]');
      End;
    End;
  End;
end;

procedure TfrmCadComFatVend.dbeCodGatKeyPress(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  If fPesqGrupoAtividade(Self, dbeCodGat, Nil, Nil, Key, arrSel, True) Then
  Begin
    If fValidaCampos(dbeCodGat, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadComFatVend.dbeCodPesExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(dbeCodPes.Text) Then
    objComFat.pAtualizaDados;
end;

end.
