unit untConsultarAdiantamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  untAdiantamentoCliente, Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, DB, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, EditFocus, MemDS, DBAccess, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxClasses, cxGridCustomView,
  cxGrid, cxGridDBTableView, untLiberacao;

type
  TfrmConsultarAdiantamentos = class(TfrmPai)
    dtsAdiantamentos: TDataSource;
    pnlHeader: TPanel;
    Label5: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    Label3: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnReimprimir: TBitBtnLocked;
    pnlDescricao: TPanel;
    lblDescricao: TLabel;
    lblTitDescricao: TLabel;
    dbgAdiantamentos: TDBGridCitel;
    btnGerarCredito: TBitBtnLocked;
    btnEstornarCredito: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtNumDocEnter(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure btnReimprimirClick(Sender: TObject);
    procedure dbgAdiantamentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgAdiantamentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGerarCreditoClick(Sender: TObject);
    procedure btnEstornarCreditoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    qryAdiantamentos: TUniQuery;
    cdsAdiantamentos: TUniClientDataSet;
    intSemaforoConsulta: Integer;

    objLiberacao : TLiberacao;

    function fCarregarAdiantamentos: Boolean;

    function fPermiteEstornoDeCreditoEmPedidoBaixado(const ANumDoc, AEspDoc, ACodEmp: String): Boolean;

    Const TOTALIZACAO: String = 'TOTAL LANÇAMENTOS:';

    procedure pAfterScroll(DataSet: TDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    { Private declarations }
  public
    { Public declarations }
    strCodOpe: String;
    blnApenasConsulta : Boolean;
    blnDesBotoes : Boolean;
    procedure pApenasConsulta(strNumPed,strEmpPed : String); overload;
    procedure pApenasConsulta(strNumPed,strEmpPed : String; blnDesBotoes: Boolean); overload;
  end;


implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncoesSimples, untFuncoes, untFuncFat,
  untPanelCxPedOrc, untPnlDadosPedOrc;

procedure TfrmConsultarAdiantamentos.btnEstornarCreditoClick(Sender: TObject);
begin
  inherited;
  If Not btnEstornarCredito.Enabled Then
    Exit;

  If Not fPermiteEstornoDeCreditoEmPedidoBaixado(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
    Exit;

  If Not fVerificaAcessoSistema('DIRRCXADCGCC', strCodOpe) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Estornar Crédito Gerado e Voltar o Saldo como Adiantamento');

    objLiberacao.strDirAce := 'DIRRCXADCGCC';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    If (Not objLiberacao.fLibera) Then
      Exit;
  End;

  If Not fLock_Unlock('CADREC' + edtNumDoc.Text +
                                 edtEspDoc.Text +
                                 edtCodEmp.Text +
                                 edtCodCli.Text + 'A0', True, False) Then
  Begin
    fMensagem('ATENÇÃO', 'Pedido ' + edtNumDoc.Text + edtEspDoc.Text + edtCodEmp.Text + ' está sendo utilizado em Outra Estação por ' +
                         fGetHostLock('CADREC' + edtNumDoc.Text +
                                                 edtEspDoc.Text +
                                                 edtCodEmp.Text +
                                                 edtCodCli.Text + 'A0')  + '!', ['&Ok']);
    Exit;
  End;

  Try
    If TAdiantamento.fEstornarCreditoGeradoAdiantamento(edtNumDoc.Text,
                                                        edtEspDoc.Text,
                                                        edtCodEmp.Text,
                                                        Self.Name,
                                                        strCodOpe) Then
      fMensagem('AVISO', 'Estorno do crédito realizado com sucesso!', ['&OK'], 1);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmConsultarAdiantamentos.btnEstornarCreditoClick]');
  End;

  fLock_Unlock('CADREC' + edtNumDoc.Text +
                          edtEspDoc.Text +
                          edtCodEmp.Text +
                          edtCodCli.Text + 'A0', False, False);

  If Not fCarregarAdiantamentos Then
    pSetFocus(edtNumDoc)
  Else
    pSetFocus(dbgAdiantamentos);
end;

function TfrmConsultarAdiantamentos.fPermiteEstornoDeCreditoEmPedidoBaixado(const ANumDoc, AEspDoc, ACodEmp : String): Boolean;
  Var
    LPedido,
    LAdiantamento : TUniQuery;

    LPedidoBaixado,
    LPedidoTemAdiantamentoEmCartao : Boolean;

    LLiberacao : TLiberacao;

  function PedidoTemAdiantamentoEmCartao : Boolean;
  begin

    Result := False;

    LAdiantamento := fCriaQuery;
    If TAdiantamento.fCarregarAdiantamentos(ANumDoc, AEspDoc, ACodEmp, EmptyStr, LAdiantamento) Then
    Begin

      LAdiantamento.Filtered := False;
      LAdiantamento.Filter   := 'TIPLAN = ' + QuotedStr('C') + ' AND (VALCAR > 0) ';
      LAdiantamento.Filtered := True;

      Result := LAdiantamento.RecordCount > 0;

    End;

  end;

  procedure pCarregarDadosPedido;
    var
      LSQL : String;
  begin

    LPedido := fCriaQuery(Self);

    LSQL := '';
    LSQL := LSQL + 'SELECT          ';
    LSQL := LSQL + '  F.*,          ';
    LSQL := LSQL + '  C.CLI_CODCLI, ';
    LSQL := LSQL + '  C.CLI_NOMCLI ';
    LSQL := LSQL + 'FROM            ';
    LSQL := LSQL + '  FATGOR F      ';
    LSQL := LSQL + '  INNER JOIN CADCLI C ON C.CLI_CODCLI = F.FGO_CODCLI ';
    LSQL := LSQL + 'WHERE ';
    LSQL := LSQL + '  F.FGO_NUMDOC = :NUMDOC AND ';
    LSQL := LSQL + '  F.FGO_ESPDOC = :ESPDOC AND ';
    LSQL := LSQL + '  F.FGO_CODEMP = :CODEMP ';

    LPedido.Close;
    LPedido.SQL.Clear;
    LPedido.SQL.Add(LSQL);
    LPedido.ParamByName('NUMDOC').AsString := ANumDoc;
    LPedido.ParamByName('ESPDOC').AsString := AEspDoc;
    LPedido.ParamByName('CODEMP').AsString := ACodEmp;
    LPedido.Open;

  end;

  function fMensagemEstorno : String;
  begin
    Result := 'O Pedido está baixado e esta operação estornará o crédito '+
              'gerado e voltará o valor como adiantamento, sendo necessário '+
              'realizar também o estorno do adiantamento posteriormente. '+
              'Como o adiantamento possui cartão, antes de continuar verifique '+
              'se é possivel estornar o cartão de crédito na administradora!'+ sLineBreak +
              'Deseja realmente continuar com a operação?';
  end;

  function fMensagemNaoPermitidoEstornar : String;
  begin
    Result := 'Não é permitido voltar saldo como adiantamento de pedido que está baixado.' + #13 +
              'Nesse caso, o crédito deve ser mantido no contas a receber!';
  end;

  function fLiberacao : Boolean;
  begin

    pCarregarDadosPedido;

    LLiberacao := TLiberacao.Create;

    Try

      LLiberacao.strDirAce := 'ECAPEDBAI';
      LLiberacao.strMsgSen := 'Estornar Crédito Gerado e Voltar o Saldo como Adiantamento de Pedido Baixado';
      LLiberacao.blnMosMen := True;
      LLiberacao.strCodOpe := strLoginUsuarioLogado;
      LLiberacao.strCodDig := strLoginUsuarioLogado;

      LLiberacao.objMsgLibera.pAddTexto('Senha para estornar Crédito Gerado e Voltar o Saldo como Adiantamento de Pedido Baixado');
      LLiberacao.objMsgLibera.pAddSeparador(60);
      LLiberacao.objMsgLibera.pAddTextoCaption('Documento', ANumDoc + '-' + ACodEmp, 24);
      LLiberacao.objMsgLibera.pAddTextoCaption('Cliente',               LPedido.FieldByName('CLI_CODCLI').AsString + '-' + LPedido.FieldByName('CLI_NOMCLI').AsString, 24);
      LLiberacao.objMsgLibera.pAddTextoCaption('Data',                  LPedido.FieldByName('FGO_DTAENT').AsString, 24);
      LLiberacao.objMsgLibera.pAddTextoCaption('Condição de Pagamento', LPedido.FieldByName('FGO_CODCND').AsString +'-' + fRetDesConPag(LPedido.FieldByName('FGO_CODCND').AsString), 24);
      LLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagamento',    LPedido.FieldByName('FGO_CODFPG').AsString +'-' + fRetDescFpg(LPedido.FieldByName('FGO_CODFPG').AsString), 24);
      LLiberacao.objMsgLibera.pAddTextoCaption('Valor do Pedido',       FloatToStrF(LPedido.FieldByName('FGO_VLRCON').AsFloat, ffFixed, 15, 2), 24);
      LLiberacao.objMsgLibera.pAddTextoCaption('Valor do Adiantamento', FloatToStrF(LAdiantamento.FieldByName('VALCAR').AsFloat, ffFixed, 15, 2), 24);
      LLiberacao.objMsgLibera.pAddSeparador(60);
      LLiberacao.objMsgLibera.pAddTexto('Ao realizar a liberação desta trava, o crédito (CC) será cancelado e irá voltar o valor do adiantamento.');
      LLiberacao.objMsgLibera.pAddTexto('Necessário realizar também o estorno do adiantamento posteriormente.');

      Result := LLiberacao.fLibera;

    Finally

      FreeAndNil(LLiberacao);

      If Assigned(LPedido) Then
        FreeAndNil(LPedido);

      If Assigned(LAdiantamento) Then
        FreeAndNil(LAdiantamento);

    End;

  end;

begin

  Result := True;

  LPedidoBaixado                 := fPedidoBaixado(ANumDoc, AEspDoc, ACodEmp);
  LPedidoTemAdiantamentoEmCartao := PedidoTemAdiantamentoEmCartao;

  If (LPedidoBaixado And LPedidoTemAdiantamentoEmCartao) Then
    If fMensagem('Atenção!', fMensagemEstorno, ['&Sim', '&Não']) = 2 Then
      Exit(False)
    Else
      Exit(fLiberacao);

  If (LPedidoBaixado) Then
  Begin
    fMensagem('Atenção!', fMensagemNaoPermitidoEstornar, ['&OK']);
    Exit(False);
  End;

end;

procedure TfrmConsultarAdiantamentos.btnGerarCreditoClick(Sender: TObject);
begin
  inherited;
  If Not btnGerarCredito.Enabled Then
    Exit;

  If Not fVerificaAcessoSistema('DIRRCXADCGCC', strCodOpe) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Transformar Adiantamento em Crédito no Conta Corrente do Cliente');

    objLiberacao.strDirAce := 'DIRRCXADCGCC';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;
  End;

  If Not fLock_Unlock('CADREC' + edtNumDoc.Text +
                                 edtEspDoc.Text +
                                 edtCodEmp.Text +
                                 edtCodCli.Text + 'A0', True, False) Then
  Begin
    fMensagem('ATENÇÃO', 'Pedido ' + edtNumDoc.Text + edtEspDoc.Text + edtCodEmp.Text + ' está sendo utilizado em Outra Estação por ' +
                         fGetHostLock('CADREC' + edtNumDoc.Text +
                                                 edtEspDoc.Text +
                                                 edtCodEmp.Text +
                                                 edtCodCli.Text + 'A0')  + '!', ['&Ok']);
    Exit;
  End;

  If TAdiantamento.fGerarCreditoSaldoAdiantamento(edtNumDoc.Text,
                                                  edtEspDoc.Text,
                                                  edtCodEmp.Text,
                                                  Self.Name,
                                                  strCodOpe,
                                                  True,
                                                  edtCodCli.Text) Then
    fMensagem('AVISO', 'Geração de crédito realizada com sucesso!', ['&Ok']);

  fLock_Unlock('CADREC' + edtNumDoc.Text +
                          edtEspDoc.Text +
                          edtCodEmp.Text +
                          edtCodCli.Text + 'A0', False, False);

  If Not fCarregarAdiantamentos Then
    pSetFocus(edtNumDoc)
  Else
    pSetFocus(dbgAdiantamentos);
end;

procedure TfrmConsultarAdiantamentos.btnReimprimirClick(Sender: TObject);
  Var
    objRecibo: TReciboAdiantamento;
begin
  If Not btnReimprimir.Enabled Then
    Exit;

  With cdsAdiantamentos Do
  Begin
    If fPergunta('Reimprimir Recibo?') Then
    Begin
      Try
        objRecibo := TReciboAdiantamento.Create(FieldByName('SEQCON').AsInteger,
                                                FieldByName('EMPLAN').AsString,
                                                FieldByName('ORIGEM').AsString);
        objRecibo.pImprimirRecibo;
      Finally
        FreeAndNil(objRecibo);
      End;
    End;
  End;
end;

procedure TfrmConsultarAdiantamentos.dbgAdiantamentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If Assigned(dtsAdiantamentos.DataSet) Then
  Begin
    With dtsAdiantamentos.DataSet, dbgAdiantamentos.Canvas Do
    Begin
      If Not Active Or IsEmpty Then
        Exit;

      If FieldByName('DESCRI').AsString = TOTALIZACAO Then
      Begin
        Brush.Color := clSilver;
        Font.Color  := clBlack;
        If Column.FieldName = 'TIPLAN' Then
        Begin
          Font.Style  := [fsBold];
          TextOut(Rect.Right - TextWidth(TOTALIZACAO) - 25,
                  Rect.Top + 2, TOTALIZACAO);
        End;
      End
      Else If Font.Color = clHighlightText Then
      Begin
        If FieldByName('TIPLAN').AsString <> 'C' Then
          Font.Color := clYellow
        Else
          Font.Color := clWhite;
      End
      Else
      Begin
        If (RecNo Mod 2 = 0) Then
          Brush.Color := fCfgSis('CORZEB')
        Else
          Brush.Color := ClWhite;

        If FieldByName('TIPLAN').AsString <> 'C' Then
          Font.Color := clRed
        Else
          Font.Color := clBlue;
      End;

      FillRect(Rect);
    End;

    dbgAdiantamentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmConsultarAdiantamentos.dbgAdiantamentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    pSetFocus(edtNumDoc)

  Else If (Key = VK_F2) Then
    btnReimprimir.Click

  Else If (Key = VK_F3) Then
    btnGerarCredito.Click

  Else If (Key = VK_F4) Then
    btnEstornarCredito.Click;
end;

procedure TfrmConsultarAdiantamentos.edtNumDocEnter(Sender: TObject);
begin
  inherited;
  If qryAdiantamentos.Active Then
    qryAdiantamentos.Close;

  If Assigned(cdsAdiantamentos) Then
    FreeAndNil(cdsAdiantamentos);

  btnGerarCredito.Enabled := False;
  btnReimprimir.Enabled := False;
  edtCodCli.Clear;
  edtNomCli.Clear;
  lblDescricao.Caption := '';
end;

procedure TfrmConsultarAdiantamentos.edtNumDocKeyPress(Sender: TObject; Var Key: Char);
  Var
    arrDoc   : TConsultasArray;
    objfrmPnl: TPanelCxPedOrc;
    qryTabela: TUniQuery;
begin
  If (InterlockedIncrement(intSemaforoConsulta) = 0) Then
  Begin
    Try
      inherited;
      If fEntraCons(Key) Then
      Begin
        edtNumDoc.Clear;
        objfrmPnl := TPanelCxPedOrc.Create(TfrmPnlDadosPedOrc, 'PD');
        qryTabela := fCriaQuery;

        If fPesqPedOrc(conPedCompleta,
                       Self,
                       edtEspDoc.Text,
                       edtEspDoc.Text,
                       edtCodEmp.Text,
                       edtNumDoc,
                       nil,
                       edtCodEmp,
                       qryTabela,
                       Key,
                       arrDoc,
                       True,
                       objfrmPnl,
                       '',
                       'S',
                       '',
                       fCfgSis('ADTALL', varBoolean)) Then
        Begin
          SelectNext(ActiveControl, True, True);
        End;

        FreeAndNil(qryTabela);
        FreeAndNil(objfrmPnl);
      End;
      InterlockedDecrement(intSemaforoConsulta);
    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intSemaforoConsulta);
        pMensagensErro(E.Message, '');
      End;
    End;
  End
  ELse
    InterlockedDecrement(intSemaforoConsulta);
end;

function TfrmConsultarAdiantamentos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtNumDoc) Then
  Begin
    If fEmptyStr(edtNumDoc.Text) Then
    Begin
      pMensagemOk('Favor informar o número do documento!');
      Result := False;
    End
  End

  Else If (Sender = edtEspDoc) Then
  Begin
    If fEmptyStr(edtEspDoc.Text) Then
    Begin
      pMensagemOk('Favor informar a espécie do documento!');
      Result := False;
    End
  End

  Else If (Sender = edtCodEmp) Then
  Begin
    edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      pMensagemOk('Favor informar a empresa de emissão do documento!');
      Result := False;
    End
    Else If fEmptyStr(edtDesEmp.Text) Then
    Begin
      pMensagemOk('Nenhuma empresa encontrada com este código!');
      Result := False;
    End
    Else If Pos(edtCodEmp.Text, fRetEmpAcessoUsuario(strCodOpe)) <= 0 Then
    Begin
      pMensagemOk('Usuário sem direito de acesso a esta empresa!');
      Result := False;
    End
    Else If Not fCarregarAdiantamentos Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há lançamentos para o documento informado. ' +
                            'Verifique se o número e a empresa foram informados corretamente!', ['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmConsultarAdiantamentos.pAfterScroll(DataSet: TDataSet);
begin
  btnReimprimir.Enabled := False;
  lblDescricao.Caption  := '';

  If Assigned(DataSet) And DataSet.Active Then
  Begin
    lblDescricao.Caption  := (DataSet.FieldByName('DESCRI').AsString);
    btnReimprimir.Enabled := (DataSet.FieldByName('TIPLAN').AsString = 'C') And
                             (DataSet.FieldByName('SEQCON').AsInteger > 0 ) And
                             (not Self.blnDesBotoes);
  End;
end;

procedure TfrmConsultarAdiantamentos.pApenasConsulta(strNumPed,
  strEmpPed: String; blnDesBotoes: Boolean);
begin
  pApenasConsulta(strNumPed, strEmpPed);
  Self.blnDesBotoes := blnDesBotoes;
end;

procedure TfrmConsultarAdiantamentos.pApenasConsulta(strNumPed,strEmpPed: String);
begin
  edtNumDoc.Text := strNumPed;
  edtCodEmp.Text := strEmpPed;
  blnApenasConsulta := True;
end;

procedure TfrmConsultarAdiantamentos.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  edtNumDoc.TamCampo  := fTamDocCadRec;
  edtNumDoc.MaxLength := fTamDocCadRec;

  qryAdiantamentos := fCriaQuery;
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
  strCodOpe := strloginUsuarioLogado;
  intSemaforoConsulta := -1;
  SelectFirst;
  Self.blnDesBotoes := False;
end;

procedure TfrmConsultarAdiantamentos.FormDestroy(Sender: TObject);
begin
  If Assigned(qryAdiantamentos) Then FreeAndNil(qryAdiantamentos);
  If Assigned(cdsAdiantamentos) Then FreeAndNil(cdsAdiantamentos);
  if Assigned(objLiberacao)     then FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmConsultarAdiantamentos.FormShow(Sender: TObject);
begin
  inherited;
  If blnApenasConsulta Then
    If Not fValidaCampos(edtCodEmp, False) Then
       btnSair.Click;
end;

function TfrmConsultarAdiantamentos.fCarregarAdiantamentos: Boolean;
  Var
    intField: Integer;
begin
  Result := TAdiantamento.fCarregarAdiantamentos(edtNumDoc.Text,
                                                 edtEspDoc.Text,
                                                 edtCodEmp.Text,
                                                 edtCodCli.Text,
                                                 qryAdiantamentos);

  If Assigned(cdsAdiantamentos) Then
    FreeAndNil(cdsAdiantamentos);

  cdsAdiantamentos := fCriaClientDatSet(qryAdiantamentos);
  dtsAdiantamentos.DataSet := cdsAdiantamentos;
  cdsAdiantamentos.AfterScroll := pAfterScroll;

  If Result And Not cdsAdiantamentos.IsEmpty Then
  Begin
    With cdsAdiantamentos,
         TAdiantamento.fGetTotaisAdiantamento(edtNumDoc.Text,
                                              edtEspDoc.Text,
                                              edtCodEmp.Text) Do
    Begin
      Append;
      FieldByName('DESCRI').AsString := TOTALIZACAO;
      FieldByName('VALDIN').AsFloat  := fltValDin;
      FieldByName('VALCHV').AsFloat  := fltValChV;
      FieldByName('VALCHP').AsFloat  := fltValChP;
      FieldByName('VALCAR').AsFloat  := fltValCar;
      FieldByName('VALORD').AsFloat  := fltValOrd;
      FieldByName('VALFIN').AsFloat  := fltValFin;
      FieldByName('VALCRE').AsFloat  := fltValCre;
      FieldByName('VALLAN').AsFloat  := fltValLan;
      Post;

      First;

      edtCodCli.Text := FieldByName('CODCLI').AsString;
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

      btnGerarCredito.Enabled := (fltValLan > 0) And (Not Self.blnDesBotoes);

      For intField := 0 To Fields.Count -1 Do
      Begin
        If Fields[intField].DataType = ftFloat Then
          TFloatField(Fields[intField]).DisplayFormat := '#,##0.00';
      End;

    End;

    If Self.blnDesBotoes Then
      btnEstornarCredito.Enabled := False
    Else
      btnEstornarCredito.Enabled := TAdiantamento.fPossuiCreditoGeradoEmAberto(edtNumDoc.Text,
                                                                               edtEspDoc.Text,
                                                                               edtCodEmp.Text);
  End;

  pAfterScroll(cdsAdiantamentos);

end;

end.
