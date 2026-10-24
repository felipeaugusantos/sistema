unit untEntDigPedido;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, DB,
  EditFocus, Menus, Uni, untComissaoProfissional, AppEvnts,
  untfuncoesSimples, StrUtils, BitBtnLockedIncrem, frxClass, untLiberacao,
  frxExportCSVTestabilidade, untTypesSistema, ComboBoxFocus, untEntMercadorias,
  Faturamento.Consignacao.Classes, Messages;

type

  TfrmEntDigPedido = class(TfrmPaiSimples)
    lblTipoDoc: TLabel;
    edtNumPed: TEditFocus;
    pnlFundo: TPanel;
    edtCodEmp: TEditFocus;
    lblEmpresa: TLabel;
    edtDesEmpresa: TEditFocus;
    rdgOpcoes: TRadioGroup;
    lblNotEle: TLabel;
    edtNotEle: TEditFocus;
    btnNotEle: TBitBtnLocked;
    cbbEsp: TComboBoxFocus;
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure rdgOpcoesClick(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnNotEleClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    frmEntMercadorias : TfrmEntMercadorias;
    blnBonificacao,
    blnCarregarConferido: Boolean;

    fltCotDol,
    fltValFre: Double;
    fltDesAce: Double;
    strOrdIte : String;
    qryConAbf: TUniQuery;
    qryConIte: TUniQuery;
    qryAbfIcm: TUniQuery;
    blnOriund: Boolean;

    blnInformouCotacao,
    blnPresencial: Boolean;

    IDX_ENTRADA      : Integer;
    IDX_DEVOLUCAO    : Integer;
    IDX_DEVOLUCAO_AD : Integer;
    IDX_CONSERTO_EQU : Integer;
    IDX_CONSIGNACAO_DEVOLUCAO : Integer;
    IDX_LOCACAO_DEVOLUCAO : Integer;

    (**************************************************************)
    (* QUERY COM OS ITENS E VALORES UNITÁRIOS ORIGINAIS DO PEDIDO *)
    (* PARA CONFERENCIA DE TOLERANCIA DE VARIAÇÃO DE PREÇO        *)
    (***********************************************************LA*)
    qryItePed: TUniQuery;

    intSemaforoConfirma: Integer;

    recNotEle: TRecInfoNotaEletronica;
    blnLiberouADComSenha : Boolean;
    objLiberacao : TLiberacao;
    blnAutomatico: Boolean;

    FblnAcessadoViaRetornoConsignacao : Boolean;
    FTipoRetornoConsignacao           : tTipoRetornoConsignacao;
    FblnAcessadoViaRetornoLocacao     : Boolean;
    FstrCodCli: String;

    function fVeSeAtualizaPedidoCompraDigPed(strNumPed, strCodEmp, strForEle: String; Var strForPed: String): Boolean;


    Function fValidaClaFisNotaElet(strAutInc: String): Boolean;

    procedure pCarregaEmpresa;

    procedure pTrataCompra(strNumPed: String; Var blnConfirma: Boolean; Var strCodFor: String;
      Var blnCarregProd: Boolean; Var stlPedidos: TStringList);
    procedure pTrataDevolucao(Var blnConfirma: Boolean; strAutDev: String = '');
    procedure pTrataDevolucaoAD(Var blnConfirma: Boolean);
    procedure pMostraItensVenda(Var blnConfirma: Boolean; strDocSel, strCodVen,
      strCodRep, strCodCli, strCodFaz, strAutDev: String; blnTravaAD: Boolean);

    procedure pAbreEntMercadorias;
    function fEhNotaImportacao(strAutInc: String): Boolean;

    procedure pNumPedKeyPress(strNumPed: String);

    Function fPedeCotacaoDolar(stlPedidos: TStringList; Var blnAbortar: Boolean): Boolean; OverLoad;
    Function fPedeCotacaoDolar(arrPedidos, arrEmpresas: Array of String; Var blnAbortar: Boolean): Boolean; OverLoad;

    Function fTemPedidosEmDolar(stlPedidos: TStringList): Boolean;
    procedure pLiberacaoComAD;
    Function fPermiteDevolverTintaMaquina: Boolean;
    function fExistePedidoCompraParaNotaImportacao: Boolean;

    { Private declarations }
  public
    { Public declarations }
    blnEntradaEfetivada: Boolean;
    blnEntCpd: Boolean;
    blnEntCNF: Boolean;
    blnPedVicNFE : Boolean;
    strCodEmp: String;
    strNumDoc: String;
    strNumSer: String;
    blnFornJaAtualizado: Boolean;
    arrDocOri: TStringArrayArray;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pCarregaNotaImportacao(strAutIncGerEle: string);
    procedure pAjustarTelaEntradaRetornoLocacao;

    property blnAcessadoViaRetornoConsignacao : Boolean                 read FblnAcessadoViaRetornoConsignacao  write FblnAcessadoViaRetornoConsignacao;
    property TipoRetornoConsignacao           : tTipoRetornoConsignacao read FTipoRetornoConsignacao            write FTipoRetornoConsignacao;
    property blnAcessadoViaRetornoLocacao     : Boolean                 read FblnAcessadoViaRetornoLocacao      write FblnAcessadoViaRetornoLocacao;
    property strCodCli: String read FstrCodCli write FstrCodCli;
  end;

var
  frmEntDigPedido: TfrmEntDigPedido;
  objComPro: TComPro;

implementation

uses  untFuncoes, untEntSelItens, untEntSelPedidos, untPai,
      untFatMostraItemSalBal, untEntSelItensDevolucao, Math,  untFuncoesPedidoSimples,
      untEntSelDocumentos, untPcmGer, untConsultas, untPesqAux, untFuncoesCRM,
      untConstantes, untCadLote, untPedeCotacaoMoeda;

{$R *.dfm}

function TfrmEntDigPedido.fVeSeAtualizaPedidoCompraDigPed(strNumPed, strCodEmp, strForEle: String; Var strForPed: String): Boolean;
Begin
  Result := fVeSeAtualizaPedidoCompra(strNumPed, strCodEmp, strForEle, strForPed, False);
  If Result Then
    strForPed := strForEle;
End;

Function TfrmEntDigPedido.fTemPedidosEmDolar(stlPedidos: TStringList): Boolean;
  Var
    strSQL: String;
    qryPedidos: TUniQuery;
    sltAutInc: TStringList;
    intContador: Integer;
Begin
  Result := False;

  If Not Assigned(stlPedidos) Then
    Exit;

  If stlPedidos.Count = 0 Then
    Exit;

  sltAutInc := TStringList.Create;

  For intContador := 0 To stlPedidos.Count - 1 Do
    sltAutInc.Add(fCampoTabela('AUTOINCREM', 'PCMGER', ['PCG_NUMPED', 'PCG_CODEMP'], [LeftStr(stlPedidos[intContador], 12),
                                                                                      RightStr(stlPedidos[intContador], 3)]));

  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS QTD FROM PCMGER P ';
  strSQL := strSQL + ' WHERE P.AUTOINCREM IN (' + fCommaText(sltAutInc, True) + ') ';
  strSQL := strSQL + '       AND PCG_MOEDA_ = ' + IntToStr(INT_MOEDA_DOLAR);

  qryPedidos          := fCriaQuery;
  qryPedidos.SQL.Text := strSQL;
  qryPedidos.Open;

  Result := qryPedidos.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryPedidos);
  FreeAndNil(sltAutInc);
End;

Function TfrmEntDigPedido.fPedeCotacaoDolar(arrPedidos, arrEmpresas: Array of String; Var blnAbortar: Boolean): Boolean;
  Var
    intContador: Integer;
    stlPedidos: TStringList;
Begin
  stlPedidos := TStringList.Create;

  For intContador := Low(arrPedidos) To High(arrPedidos) Do
    stlPedidos.Add(arrPedidos[intContador] + arrEmpresas[intContador]);

  Result := fPedeCotacaoDolar(stlPedidos, blnAbortar);

  FreeAndNil(stlPedidos);
End;

function TfrmEntDigPedido.fPermiteDevolverTintaMaquina: Boolean;
var
  objLiberacao : TLiberacao;
begin

  If Not fCfgSis('USATMQ', varBoolean) Then
    Exit(False);

  If Not fCfgSis('DEVTIN', varBoolean) Then
    Exit(False);

  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Devolução de Tinta de Máquina.');
    objLiberacao.objMsgLibera.pAddTexto('Produto bloqueado por se tratar de Tinta de Máquina.');
    objLiberacao.strDirAce    := 'PDTINT';
    objLiberacao.strSenLib    := fCfgSis('SDVTIN');
    objLiberacao.strMsgSen    := 'Liberação para devolução de Tinta de Máquina(Devolução)';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.strCodDig    := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;

  Finally
    FreeAndNil(objLiberacao);
  End;
end;

Function TfrmEntDigPedido.fPedeCotacaoDolar(stlPedidos: TStringList; Var blnAbortar: Boolean): Boolean;
Begin
  Result := True;

  fltCotDol := 0;

  If fCfgSis('COTDOR', varBoolean) Then
  Begin

    If (Not fEmptyStr(recNotEle.strAutInc)) And (recNotEle.fltCotDol <> 0) Then
    Begin
      fltCotDol := recNotEle.fltCotDol;
      Self.blnInformouCotacao := True;
      Result    := True;
    End

    Else If Assigned(stlPedidos) And (stlPedidos.Count > 0) And fTemPedidosEmDolar(stlPedidos) Then
    Begin
      Result := TfrmPedeCotacaoMoeda.fPedeCotacaoMoeda(fltCotDol, infoPedidoEmDolar);
      Self.blnInformouCotacao := Result;
    End

  End;

  If Not Result Then
  Begin
    fltCotDol := 0;
    Self.blnInformouCotacao := False;
    blnAbortar := True;
  End;

End;

{ TfrmEntDigPedido }
function TfrmEntDigPedido.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Const
    CONFERENCIA_PEDIDO = '2';
  Var
    blnAbortar,
    blnConfirma: Boolean;
    strNotas,
    strCodFor: String;
    strCodCli: String;
    strCodFaz: String;
    strOriDoc: String;
    strCodVen: String;
    strCodRep: String;
    strCodOpe: String;
    qryGenIte: TUniQuery;
    qryGenAux: TUniQuery;
    dtsGenIte: TDataSource;
    blnCarregaProd,
    blnImportacao,
    blnConferido: Boolean;
    blnLiberado: Boolean;
    blnBaixado: Boolean;
    blnMaisDeUm,
    blnOriundoImportacaoNotaEletronica: Boolean;
    strNumPed: String;
    strSQL   : String;
    strEmpDes: String;
    strEmpres: String;
    strPreNot: String;
    blnDocOri: Boolean;
    dtaDtaEmi: TDateTime;
    strDocDev,
    strAutInc: String;
    frmEntSelItens : TfrmEntSelItens;
    function fLiberado: Boolean;
      Var
        blnPedeSenha: Boolean;
    begin
      Result := True;
      blnPedeSenha := False;

      If (fCfgSis('USACON', varBoolean) And (Not blnConferido)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse pedido não está conferido!', ['&Ok']);
        blnPedeSenha := True;
      End;

      If (fCfgSis('LIBPCM', varBoolean) And (Not blnLiberado)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse pedido não está liberado (liberação de pedidos de compra)!', ['&Ok']);
        blnPedeSenha := True;
      End;

      If blnPedeSenha Then
      Begin
        ffrmSenha(strSenha, 'Senha por direito de acesso!');
        strCodOpe := fRetCodVendedor(strSenha);

        If (Not fVerificaAcessoSistema('ENTPNL', strCodOpe)) Or fEmptyStr(strCodOpe) Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso!', ['&O k']);
          Result := False;
        End
        Else
          if blnCarregarConferido Then
            blnCarregarConferido := False;

      End;

    end;

begin
  qryGenIte := fCriaQuery(Self);
  dtsGenIte := fCriaDataSource(qryGenIte);

  blnConfirma := False;
  Result      := True;
  strCodFor   := '';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumPed) Then
    Begin
      blnCarregarConferido := (fCfgSis('USACON', varBoolean) And fCfgSis('PERCPA', varBoolean));

      If fCfgSis('ENTXML', varBoolean) And fEmptyStr(edtNotEle.Text) And (rdgOpcoes.ItemIndex = IDX_ENTRADA) Then
      Begin
        ffrmSenha(strSenha, 'Entr. sem XML, Senha direito acesso!');
        strCodOpe := fRetCodVendedor(strSenha);

        If (Not fVerificaAcessoSistema('ENTXML', strCodOpe)) Or fEmptyStr(strCodOpe) Then
        Begin
          fMensagem('', 'Usuario sem permissão de acesso!', ['&O k']);
          pSetFocus(btnNotEle);
          exit;
        End;
      End;

      If fEmptyStr(edtNumPed.Text) Then
      Begin

        If InterlockedIncrement(intSemaforoConfirma) = 0 Then
        Begin

          If ( ((Not blnEntCpd) or blnPedVicNFE ) And (rdgOpcoes.ItemIndex = IDX_ENTRADA) ) Or
             ( (Not blnEntCNF) And (rdgOpcoes.ItemIndex = IDX_DEVOLUCAO) ) Or
             (rdgOpcoes.ItemIndex = IDX_CONSERTO_EQU) or
             (rdgOpcoes.ItemIndex = IDX_CONSIGNACAO_DEVOLUCAO) or
             (rdgOpcoes.ItemIndex = IDX_LOCACAO_DEVOLUCAO) Then
          Begin
            If (rdgOpcoes.ItemIndex = IDX_ENTRADA) And
               (Not fEmptyStr(recNotEle.strAutInc)) And  //Nota Selecionada
               (recNotEle.blnEhNotaImportacao) And (Not recNotEle.blnEhNotaImportacaoAcompanhamento) And //Nota de importação
               (Not fCfgSis('USACON', varBoolean)) And   //Não usa conferência
               (fEmptyStr(edtNumPed.Text)) And  //Pedido de compra não está informado
               fExistePedidoCompraParaNotaImportacao Then //Valida se existe pedido de compra de importação em aberto para essa nota
            Begin
              Result := False;
              pSetFocus(edtNumPed);
              InterlockedDecrement(intSemaforoConfirma);
              Exit;
            End;

            Try
              pCriarFormularios(TfrmEntMercadorias, frmEntMercadorias);
              frmEntMercadorias.qryItePed := qryItePed;
              frmEntMercadorias.recNotEle := recNotEle;
              frmEntMercadorias.strOrdIte := strOrdIte;
              frmEntMercadorias.blnAutomatico := blnAutomatico;

              frmEntMercadorias.blnDevolu := (rdgOpcoes.ItemIndex = IDX_DEVOLUCAO);
              frmEntMercadorias.blnPresencial := (rdgOpcoes.ItemIndex = IDX_DEVOLUCAO) And blnPresencial;
              frmEntMercadorias.blnConEqu := (rdgOpcoes.ItemIndex = IDX_CONSERTO_EQU);
              frmEntMercadorias.blnLocEqu := (rdgOpcoes.ItemIndex = IDX_LOCACAO_DEVOLUCAO);


              If Not fEmptyStr(recNotEle.strAutInc) Then
              Begin
                fltValFre := recNotEle.fltValFre;
                fltDesAce := 0;
              End;

              frmEntMercadorias.blnSemInc      := False;
              frmEntMercadorias.fltValFre      := fltValFre;
              frmEntMercadorias.fltDesAce      := fltDesAce;

              pAbreEntMercadorias;
            Except
              On E: Exception Do
                pMensagensErro(E.Message, '[frmEntDigPedido.fValidaCampos('+Sender.Name+')]');
            End;
            FillChar(recNotEle, SizeOf(recNotEle), #0);
            edtNotEle.Clear;
            fltValFre := 0;
            fltDesAce := 0;
            blnPresencial := False;

            If FblnAcessadoViaRetornoLocacao Then
            Begin
              strNumDoc := frmEntMercadorias.edtNumDoc.Text;
              strNumSer := frmEntMercadorias.edtSerie.Text;
            End;

            pFreeAndNil(frmEntMercadorias);
            pSetFocus(rdgOpcoes);
          End Else
          Begin
            If blnEntCpd And (rdgOpcoes.ItemIndex = IDX_ENTRADA) Then
              pMensagemOk('É obrigatório informar o número do Pedido de Compra para entrada de mercadorias!');

            If blnEntCNF And (rdgOpcoes.ItemIndex = IDX_DEVOLUCAO) Then
              pMensagemOk('É obrigatório informar o número da Nota de Venda para a devolução!');
          End;

          InterlockedDecrement(intSemaforoConfirma);

        End
        Else {If InterlockedIncrement(intSemaforoConfirma) = 0 Then}
          InterlockedDecrement(intSemaforoConfirma);

      End
      Else {do If fEmptyStr(edtNumPed.Text) Then}
      Begin

         If rdgOpcoes.ItemIndex = IDX_DEVOLUCAO Then
         Begin
           If (Not fVerificaVendaExiste(edtNumPed.Text, cbbEsp.Text, strCodEmp,strCodCli,strCodFaz,strCodVen,strCodRep,strOriDoc, dtaDtaEmi, blnPresencial)) Then
           Begin
             fMensagem('ATENÇÃO!', 'Esse documento não está cadastrado!', ['&Ok']);
             blnMudarFoco := False;
             pSetFocus(edtNumPed);
           End
           Else
           Begin
             pMostraItensVenda(blnConfirma,QuotedStr(edtNumPed.Text + cbbEsp.Text + strCodEmp+strCodCli+strOriDoc),strCodVen,strCodRep, strCodCli, strCodFaz, '', True);
             edtNumPed.Clear;
           End;
         End

         Else If rdgOpcoes.ItemIndex = IDX_DEVOLUCAO_AD Then
         Begin
           If Not fNumADCadastrado(edtNumPed.Text, '', edtCodEmp.Text) Then
           Begin
             fMensagem('ATENÇÃO!', 'AD não econtrado!', ['&O k']);
             Result := False;
           End
           Else If fTemDevolucaoRealizadaParaAD(edtNumPed.Text, edtCodEmp.Text, strDocDev) Then
           Begin
             fMensagem('ATENÇÃO!', 'Já foi realizada uma devolução com o documento ' + strDocDev + ' ' +
                                   'para esta AD!', ['&O k']);
             Result := False;
           End
           Else
           Begin
             pTrataDevolucao(blnConfirma, edtNumPed.Text);
           End;
         End

         Else If rdgOpcoes.ItemIndex = IDX_ENTRADA Then
         Begin
           If (not fCfgSis('REFENT', varBoolean)) And fPedidoDeCompraOriundoDeGarantia(edtNumPed.Text, edtCodEmp.Text) Then
           Begin
             fMensagem('', 'Não é permitido efetuar a entrada de um pedido de compra originado do envio de mercadorias em garantia para o fornecedor!', ['&Ok']);
             edtNumPed.Clear;
             Exit;
           End;

           If (Not fPedidoCompraCadastrado(edtNumPed.Text, edtCodEmp.Text, 'PD', blnBonificacao,
              blnLiberado, blnConferido, blnBaixado, blnDocOri, blnImportacao, blnMaisDeUm,
              strEmpDes, strEmpres, strCodFor, strPreNot, strAutInc, blnOriundoImportacaoNotaEletronica, True)) Or blnMaisDeUm Then
           Begin

             If blnMaisDeUm Then
             Begin
               pNumPedKeyPress(edtNumPed.Text);
               edtNumPed.Clear;
               Exit;
             End;

             fMensagem('ATENÇÃO!', 'Esse pedido não está cadastrado!', ['&Ok']);
             blnMudarFoco := False;
             pSetFocus(edtNumPed);
           End
           Else If blnBaixado Then
           Begin
             fMensagem('ATENÇÃO!', 'Esse pedido já está baixado!', ['&Ok']);
             blnMudarFoco := False;
             pSetFocus(edtNumPed);
           End

           Else If fTemPreNotaPedido(edtNumPed.Text, strEmpres, strNotas) Then
           Begin
             pMensagemOk('Esse pedido já está associado à(s) pré-nota(s) '+ strNotas + ' e' + #13#10 +
                        'somente poderá ser alterado após a entrada de mercadorias (se parcial) ou' + #13#10 +
                        'cancelamento da(s) pré-nota(s).');
           End

           Else If (Not fEmptyStr(recNotEle.strAutInc) and (recNotEle.strCodFor <> strCodFor)) And
                   (Not fVeSeAtualizaPedidoCompraDigPed(edtNumPed.Text, strEmpres, recNotEle.strCodFor, strCodFor)) Then
           Begin
             fMensagem('ATENÇÃO!', 'Não é permitido baixar pedido com fornecedor diferente do XML!', ['&Ok']);
             blnMudarFoco := False;
             pSetFocus(edtNumPed);
           End
           Else If blnImportacao And fEmptyStr(recNotEle.strAutInc) Then
           Begin
             fMensagem('ATENÇÃO!', 'Não é permitido fazer entrada de Pedido de Importação sem importar a Nota Eletrônica (XML)!', ['&Ok']);
             blnMudarFoco := False;
             pSetFocus(edtNumPed);
           End

           Else If (Not fLiberado) Then
           Begin
             blnMudarFoco := False;
             pSetFocus(edtNumPed);
           End
           Else If blnMudarFoco And (Not fTestaDataBalanco(edtNumPed.Text, strEmpres, qryGenIte)) Then
           Begin
             fMensagem('', 'Esse pedido contem itens com data de balanço ' + DateToStr(VS_Date) + '. Verifique!', ['&O k']);

             {**********************************************************}
             {*  MOSTRA OS ITENS  COM DATA DE BALANÇO >= DATA CORRENTE *}
             {*******************************************************PB*}
             Try
               pCriarFormularios(TfrmFatMostraItemSalBal, frmFatMostraItemSalBal);
               frmFatMostraItemSalBal.strPedOrc := 'PD';
               frmFatMostraItemSalBal.strNumPed := edtNumPed.Text;
               frmFatMostraItemSalBal.dbgItens.DataSource := dtsGenIte;
               frmFatMostraItemSalBal.ShowModal;
             Except
               On E: Exception Do
               Begin
                 pMensagensErro(E.Message, '[frmEntDigPedido.fValidaCampos('+Sender.Name+')]');
               End;
             End;

             pFreeAndNil(frmFatMostraItemSalBal);
             blnMudarFoco := False;
             pSetFocus(edtNumPed);
           End

           Else If blnMudarFoco  Then
           Begin
             blnConfirma := Not fEmptyStr(recNotEle.strAutInc);

             Try
               qryGenAux := fCriaQuery(Self);

               strSQL := '';
               strSQL := strSQL + 'SELECT   ';
               strSQL := strSQL + '  PCG_VALFRE, ';
               strSQL := strSQL + '  PCG_DESACE  ';
               strSQL := strSQL + 'FROM     ';
               strSQL := strSQL + '  PCMGER ';
               strSQL := strSQL + 'WHERE    ';
               strSQL := strSQL + '  PCG_NUMPED = :NUMPED ';
               strSQL := strSQL + '  AND PCG_CODEMP = :CODEMP ';

               With qryGenAux Do
               Begin
                 Close;
                 SQL.Clear;
                 SQL.Add(strSQL);
                 ParamByName('NUMPED').AsString := edtNumPed.Text;
                 ParamByName('CODEMP').AsString := strEmpres;
                 Open;

                 If Not IsEmpty Then
                 Begin
                   fltValFre := FieldByName('PCG_VALFRE').AsFloat;
                   fltDesAce := FieldByName('PCG_DESACE').AsFloat;

                   Close;
                   blnConfirma := True;
                 End
                 Else
                 Begin
                   fMensagem('', 'O Pedido informado não está cadastrado!', ['&O k']);
                   edtNumPed.Clear;
                   pSetFocus(edtNumPed);
                 End;

               End;

             Finally
               FreeAndNil(qryGenAux);
             End;

             If Not fEmptyStr(recNotEle.strAutInc) Then
               strNumPed := edtNumPed.Text;

             blnCarregaProd := True;

             Self.blnInformouCotacao := False;

             blnAbortar := False;

             {*****************************************}
             {* CASO PEDIDO EXISTE, CARREGA OS ITENS  *}
             {* DO MESMO                              *}
             {**************************************MV*}
             If fEmptyStr(recNotEle.strAutInc) And
                fPedeCotacaoDolar([edtNumPed.Text], [strEmpres], blnAbortar) And
                fCarregaItensPedidos(fltCotDol, [edtNumPed.Text], [strEmpres], strEmpres, blnCarregarConferido, qryItePed) Then
             Begin
               strNumPed := edtNumPed.Text;
               edtNumPed.Clear;


               {***************************************************}
               {* VERIFICA SE EXISTEM ITENS ESPECIAIS NOS PEDIDOS *}
               {* CASO EXISTA NÃO DEIXA CARREGAR OS PEDIDOS       *}
               {************************************************LU*}
               If Not fVerificaItemEspecial Then
               Begin

                 If (Not blnDocOri) Then
                   blnCarregaProd := (fMensagem('', 'Carregar produtos?', ['&Sim', '&Não']) = 1)
                 Else
                   blnCarregaProd := True;

                 If (blnCarregaProd) Then
                 Begin

                   {*****************************************}
                   {* CHAMA A TELA DE SELEÇÃO DOS ITENS     *}
                   {**************************************MV*}
                   Try
                     pCriarFormularios(TfrmEntSelItens, frmEntSelItens);
                     frmEntSelItens.blnDocOri := blnDocOri;
                     frmEntSelItens.qryItePed := qryItePed;

                     If Not fCfgSis('USACON', varBoolean) Then
                     Begin
                       frmEntSelItens.showModal;
                       strOrdIte   := frmEntSelItens.strOrdIte;
                       blnConfirma := frmEntSelItens.blnConfirma;
                       strCodFor   := frmEntSelItens.strCodFor;
                     End
                     Else
                     Begin
                       frmEntSelItens.pCarregaTabela;
                       strOrdIte   := 'ENT_DESITE';
                       blnConfirma := True;
                       strCodFor   := frmEntSelItens.cdsItens.FieldByName('ENT_CODFOR').AsString;
                     End;

                   Except
                     On E: Exception Do
                     Begin
                       blnConfirma := False;
                       pMensagensErro(E.Message, '[frmEntDigPedido.fValidaCampos('+Sender.Name+')]');
                     End;

                   End;

                   pFreeAndNil(frmEntSelItens);

                 End
                 Else
                 Begin
                   blnConfirma := True;
                   pDeletaTabelaEntradaMercadorias;
                   pCriaTabelaEntradaMercadorias;
                 End;

               End
               Else
               Begin
                 pDeletaTabelaEntradaMercadorias;
                 pCriaTabelaEntradaMercadorias;
               End;

             End; {If fEmptyStr(recNotEle.strAutInc) And}

             If blnAbortar Then
               blnConfirma := False;

             If blnConfirma Then
             Begin

               Try
                 pCriarFormularios(TfrmEntMercadorias, frmEntMercadorias);
                 frmEntMercadorias.qryItePed := qryItePed;
                 frmEntMercadorias.blnDocOri := blnDocOri;
                 frmEntMercadorias.recNotEle := recNotEle;
                 frmEntMercadorias.strOrdIte := strOrdIte;
                 frmEntMercadorias.strCodFor := strCodFor;
                 If fEmptyStr(edtNotEle.Text) Then
                   frmEntMercadorias.blnBonificacao := blnBonificacao;

                 If Not fEmptyStr(recNotEle.strAutInc) Then
                 Begin
                   fltValFre := recNotEle.fltValFre;
                   fltDesAce := 0;
                 End;

                 frmEntMercadorias.fltValFre := fltValFre;
                 frmEntMercadorias.fltDesAce := fltDesAce;

                 frmEntMercadorias.blnDevolu := (rdgOpcoes.ItemIndex = IDX_DEVOLUCAO);
                 frmEntMercadorias.blnPresencial := (rdgOpcoes.ItemIndex = IDX_DEVOLUCAO) And blnPresencial;
                 frmEntMercadorias.blnConEqu := (rdgOpcoes.ItemIndex = IDX_CONSERTO_EQU);
                 frmEntMercadorias.stlPedidos.Add(strNumPed + strEmpres);
                 frmEntMercadorias.blnCarregProd := blnCarregaProd;

                 pAbreEntMercadorias;

               Except
                 On E: Exception Do
                 Begin
                   pMensagensErro(E.Message, '[frmEntDigPedido.fValidaCampos('+Sender.Name+')]');
                 End;
               End;

               FillChar(recNotEle, SizeOf(recNotEle), #0);
               edtNumPed.Clear;
               strNumPed := '';
               edtNotEle.Clear;
               fltValFre := 0;
               fltDesAce := 0;
               blnPresencial := False;
               pFreeAndNil(frmEntMercadorias);
               pSetFocus(rdgOpcoes);

             End {If blnConfirma Then}

             Else pSetFocus(rdgOpcoes);

           End;

         End;

      End; {end do Else do If fEmptyStr(edtNumPed.Text) Then}

    End {If (Sender = edtNumPed) Then}

    Else If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a empresa!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If (fEmptyStr(edtDesEmpresa.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'É necessário digitar a empresa!', ['&Ok']);
          Result := False;
        End;

      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEntDigPedido.pTrataCompra(strNumPed: String; Var blnConfirma: Boolean;
  Var strCodFor: String; Var blnCarregProd: Boolean; Var stlPedidos: TStringList);
  Var
    arrPedidos: Array Of String;
    arrEmpresas: Array Of String;
    intContador: Integer;
    intTamMat: Integer;
    blnAbortar,
    blnDocOri: Boolean;
    frmEntSelItens : TfrmEntSelItens;
begin
    blnDocOri := False;
    {*****************************************}
    {* CHAMA A TELA DE SELEÇÃO DOS PEDIDOS   *}
    {**************************************MV*}
    Try
      qryItePed.Close;

      fltCotDol := 0;
      pCriarFormularios(TfrmEntSelPedidos, frmEntSelPedidos);
      If recNotEle.strAutInc <> '' Then
        frmEntSelPedidos.blnNotaImportacao := fEhNotaImportacao(recNotEle.strAutInc);

      frmEntSelPedidos.blnSomenteConferido := blnCarregarConferido;
      frmEntSelPedidos.strNumPed := strNumPed;
      frmEntSelPedidos.strCodEmp := strCodEmp;
      frmEntSelPedidos.strCodFor := strCodFor;
      frmEntSelPedidos.blnNotEle := Not fEmptyStr(recNotEle.strAutInc);
      frmEntSelPedidos.showModal;

      intTamMat := Length(frmEntSelPedidos.arrPedidos);
      SetLength(arrPedidos, intTamMat);
      SetLength(arrEmpresas, intTamMat);
      strCodFor     := frmEntSelPedidos.strCodFor;
      blnConfirma   := frmEntSelPedidos.blnConfirma;
      blnCarregarConferido := frmEntSelPedidos.blnSomenteConferido;
      fltValFre     := frmEntSelPedidos.fltValFre;
      fltDesAce     := frmEntSelPedidos.fltDesAce;
      blnDocOri     := frmEntSelPedidos.blnDocOri;
      strNumSer     := frmEntSelPedidos.strNumSer;
      strNumDoc     := frmEntSelPedidos.strNumDoc;
      blnFornJaAtualizado:= frmEntSelPedidos.blnFornJaAtualizado;

      arrDocOri     := frmEntSelPedidos.arrDocOri;

      {*****************************************}
      {* PROCESSA A MATRIZ COM OS PEDIDOS QUE  *}
      {* FORAM SELECIONADOS                    *}
      {**************************************MV*}
      For intContador := 0 To intTamMat -1 Do
      Begin
        arrPedidos[intContador] := frmEntSelPedidos.arrPedidos[intContador];
        arrEmpresas[intContador] := frmEntSelPedidos.arrEmpresas[intContador];
        stlPedidos.Add(arrPedidos[intContador] + arrEmpresas[intContador]);
      End;

      blnBonificacao := frmEntSelPedidos.strPedBon = 'S'

    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[pTrataCompra - frmEntSelPedidos]');
      End;
    End;

    pFreeAndNil(frmEntSelPedidos);

    blnAbortar := False;

    If blnConfirma Then
    Begin
      If fEmptyStr(recNotEle.strAutInc) Then
        Self.blnInformouCotacao := False;

      {*****************************************}
      {* CASO CONFIRME OS PEDIDOS, GERA A TEM- *}
      {* PORÁRIA COM OS ITENS                  *}
      {**************************************MV*}
      If fEmptyStr(recNotEle.strAutInc) And
         fPedeCotacaoDolar(arrPedidos, arrEmpresas, blnAbortar) And
         fCarregaItensPedidos(fltCotDol, arrPedidos, arrEmpresas, edtCodEmp.Text, blnCarregarConferido, qryItePed) Then
      Begin

        edtNumPed.Clear;

        {***************************************************}
        {* VERIFICA SE EXISTEM ITENS ESPECIAIS NOS PEDIDOS *}
        {* CASO EXISTA NÃO DEIXA CARREGAR OS PEDIDOS       *}
        {************************************************LU*}
        If Not fVerificaItemEspecial Then
        Begin

          If (Not blnDocOri) Then
            blnCarregProd := (fMensagem('', 'Carregar produtos?', ['&Sim', '&Não']) = 1)
          Else
            blnCarregProd := True;

          If (blnCarregProd) Then
          Begin
            {*****************************************}
            {* CHAMA A TELA DE SELEÇÃO DOS ITENS     *}
            {**************************************MV*}
            Try
              pCriarFormularios(TfrmEntSelItens, frmEntSelItens);
              frmEntSelItens.blnDocOri := blnDocOri;
              frmEntSelItens.qryItePed := qryItePed;

              If Not fCfgSis('USACON', varBoolean) Then
              Begin
                frmEntSelItens.showModal;

                strOrdIte   := frmEntSelItens.strOrdIte;
                blnConfirma := frmEntSelItens.blnConfirma;
                strCodFor   := frmEntSelItens.strCodFor;
              End
              Else
              Begin
                frmEntSelItens.pCarregaTabela;
                strOrdIte   := 'ENT_DESITE';
                blnConfirma := True;
                strCodFor   := frmEntSelItens.cdsItens.FieldByName('ENT_CODFOR').AsString;
              End;

              blnOriund := blnDocOri;
            Except
              On E: Exception Do
              Begin
                blnConfirma := False;
                pMensagensErro(E.Message, '[pTrataCompra - frmEntSelItens]');
              End;
            End;

            pFreeAndNil(frmEntSelItens);
          End
          Else
          Begin
            pDeletaTabelaEntradaMercadorias;
            pCriaTabelaEntradaMercadorias;
          End;

        End
        Else
        Begin
          blnConfirma := False;
          pDeletaTabelaEntradaMercadorias;
          pCriaTabelaEntradaMercadorias;
        End;

      End;

      If blnAbortar Then
        blnConfirma := False;
    End;

end;

procedure TfrmEntDigPedido.pMostraItensVenda(Var blnConfirma: Boolean; strDocSel,
  strCodVen, strCodRep, strCodCli, strCodFaz, strAutDev: String; blnTravaAD: Boolean);

  Var
    blnPrecoPraticado: Boolean;
    blnRedCargaMedia: Boolean;

  procedure pCarregaAbrevFiscalDev(strCodIte: String; fltTotIte: Double;
                                   Var fltBasIcm, fltAlqIcm, fltAlqIcmRed, fltValIcm, fltPerBas, fltPeBaST: Double;
                                       strCodAbf: String;
                                   Var strDesAbf, strClaFis, strCodFis: String);
    Var
      fltAliSte: Double;
      fltAliFCP: Double;
      strEmpEst: String;
      blnContribuinteIPI: Boolean;
  begin

    strEmpEst          := fCadEmp('ESTADO');
    blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));


    pPesquisaAbfIcm(qryAbfIcm, qryConAbf, strCodAbf);
    With qryConAbf Do
    Begin

      strDesAbf := FieldByName('ABF_DESABF').AsString;

      fRetornaDadosFiscais(strEmpEst,
                           blnContribuinteIPI,
                           False,
                           FieldByName('ABF_CODABF').AsString,
                           fltTotIte,
                           frmEntMercadorias.fltAlqFor,
                           frmEntMercadorias.strEstFor,
                           frmEntMercadorias.strCodFor,
                           fItemRevInd(strCodIte, VS_StrCodEmp) = 'R',
                           strClaFis,
                           strCodFis,
                           fltBasIcm,
                           fltAlqIcm,
                           fltAlqIcmRed,
                           fltValIcm,
                           fltPerBas,
                           fltPeBaST,
                           fltAliSte,
                           fltAliFCP,
                           blnRedCargaMedia,
                           IIF(rdgOpcoes.ItemIndex = IDX_ENTRADA, False, True),
                           True,
                           False,
                           False,
                           False,
                           '',
                           False,
                           blnPresencial);
    End;

  end;

  Var
    strSQL   : String;
    qryGenIte: TUniQuery;

    fltValCof, fltBasPis, fltValPis, fltBasCof, fltDesAceDet, fltAlqCof, fltAlqPis,
    fltValIpi, fltTotIte, fltValRet, fltBasRet, fltVal_Rt, fltPerRed, fltAlqRet,
    fltBasIcm, fltAlqIcm, fltAlqIcmRed, fltValIcm, fltPerBas, fltPeBaST, fltBasIPI, fltUnitar,
    fltDesEsp, fltFreIte: Double;

    fltBASFCP,
    fltPERFCP,
    fltVALFCP,
    fltBFCPST,
    fltPFCPST,
    fltVFCPST: Double;

    strIncPis, strCtsCof, strCtsPis, strNR_Pis, strNR_Cof,
    strCodAbf, strDesAbf, strClaFis, strCodFis, strCodUni,
    strNumLot, strDesIte: String;
Begin
  pnlInfo.Caption := 'Aguarde... Carregando Itens';
  Self.Enabled    := False;
  Application.ProcessMessages;

  Try
    pCriarFormularios(TfrmEntSelItensDevolucao, frmEntSelItensDevolucao);
    frmEntSelItensDevolucao.blnTravaAD := blnTravaAD;

    frmEntSelItensDevolucao.blnAcessadoViaRetornoConsignacao := FblnAcessadoViaRetornoConsignacao;

    frmEntSelItensDevolucao.cxgItenQTDDEV.Visible := True;

    qryGenIte := fCriaQuery(Self);

    Try

      frmEntSelItensDevolucao.strCodCli := strCodCli;
      frmEntSelItensDevolucao.pCarregaCDSItens(strDocSel, strAutDev);
      If Not frmEntSelItensDevolucao.blnTemItensDisponiveis Then
      Begin
        fMensagem('Atenção', 'Todos os itens deste documento já foram devolvidos.', ['&OK']);
        Exit;
      End
      Else
        frmEntSelItensDevolucao.ShowModal;

      blnConfirma := frmEntSelItensDevolucao.ModalResult = mrOk;

      If (frmEntSelItensDevolucao.fTemTintadeMaquina) And (Not fPermiteDevolverTintaMaquina) Then
      Begin
        blnConfirma := False;
        fMensagem('ATENÇÃO!', 'Não é permitida a devolução de Tinta de Máquina!', ['&O k']);
      End;

      if (blnConfirma) and (FblnAcessadoViaRetornoConsignacao) and (fEmptyStr(strDocSel)) then
      Begin
        fMensagem('Atenção', 'É obrigatório informar o documento de envio para prosseguir com o retorno.', ['&OK']);
        blnConfirma := False;
      End;

      If blnConfirma Then
      Begin
        Try
          Try
            pnlInfo.Caption := 'Aguarde... Inserindo Itens';
            Application.ProcessMessages;

            pCriarFormularios(TfrmEntMercadorias, frmEntMercadorias);

            frmEntMercadorias.strDocSel := strDocSel;
            frmEntMercadorias.qryItePed := qryItePed;
            frmEntMercadorias.blnDocOri := blnOriund;
            frmEntMercadorias.strOrdIte := strOrdIte;
            frmEntMercadorias.recNotEle := recNotEle;
            frmEntMercadorias.blnDevolu := True And (rdgOpcoes.ItemIndex <> IDX_CONSIGNACAO_DEVOLUCAO) and (rdgOpcoes.ItemIndex <> IDX_LOCACAO_DEVOLUCAO);
            frmEntMercadorias.blnPresencial := blnPresencial;
            frmEntMercadorias.blnSemInc := fEmptyStr(strAutDev);
            frmEntMercadorias.strAutDev := strAutDev;

            If Not fEmptyStr(recNotEle.strAutInc) Then
            Begin
              fltValFre := recNotEle.fltValFre;
              fltDesAce := 0;
            End;

            frmEntMercadorias.fltValFre := fltValFre;
            frmEntMercadorias.fltDesAce := fltDesAce;

            frmEntMercadorias.strCodFaz := strCodFaz;
            frmEntMercadorias.pCarregaCliente(strCodCli);
            frmEntMercadorias.fltAlqFor := fRetornaAlqFor(frmEntMercadorias.strEstFor, frmEntMercadorias.qryConCli.FieldByName('CLI_I_E_S_').AsString);
            frmEntMercadorias.strCodFor := strCodCli;
            frmEntMercadorias.strCodRep := strCodRep;
            frmEntMercadorias.strCodVen := strCodVen;

            blnPrecoPraticado := fCfgSis('SUGPDV') = '1'; //Configurado para trazer como sugestao o preco praticado na venda

            frmEntMercadorias.blnPrecoPraticado := blnPrecoPraticado;

            pCriaTabelaEntradaMercadorias;

            With frmEntSelItensDevolucao Do
            Begin
              cdsItensDev.First;

              While Not cdsItensDev.Eof Do
              Begin

                If fInLista Then
                Begin

                  pPesquisaCadIte(qryConIte, qryConIte, cdsItensDev.FieldbyName('DET_CODITE').AsString, '', False, False);

                  If Not (qryConIte.IsEmpty) Then
                  Begin

                    With qryGenIte Do
                    Begin
                      strSQL := '';
                      strSQL := strSQL + 'SELECT ';
                      strSQL := strSQL + '  I.*, ';
                      strSQL := strSQL + '  CONCAT(IFNULL(C.ITE_CODMAR,""),"-",IFNULL(MAR_DESMAR,"")) AS MAR_DESMAR ';

                      strSQL := strSQL + 'FROM ';
                      strSQL := strSQL + '  ITEGER I ';
                      strSQL := strSQL + '  INNER JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE ';
                      strSQL := strSQL + '  LEFT JOIN CADMAR ON MAR_CODMAR = C.ITE_CODMAR ';
                      strSQL := strSQL + 'WHERE ';
                      strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
                      strSQL := strSQL + '  I.ITE_CODEMP = :CODEMP ';

                      Close;
                      SQL.Clear;
                      SQL.Add(strSQL);
                      ParamByName('CODITE').AsString := qryConIte.FieldByName('ITE_CODITE').AsString;
                      ParamByName('CODEMP').AsString := strCodEmp;
                      Open;


                      If fEmptyStr(cdsItensDev.FieldByName('DET_CODACA').AsString) Then
                        strDesIte := qryConIte.FieldByName('ITE_DESITE').AsString
                      Else
                        strDesIte := cdsItensDev.FieldByName('DET_DESCRI').AsString;

                      If fCfgSIs('TIPABF') = '1' Then
                        strCodAbf := qryConIte.FieldByName('ITE_CODABF').AsString
                      Else
                        strCodAbf := FieldByName('ITE_CODABF').AsString;

                      fltUnitar := cdsItensDev.FieldByName('DET_UNITAR').AsFloat;

                      pCarregaAbrevFiscalDev(qryConIte.FieldByName('ITE_CODITE').AsString,
                                             fltUnitar*cdsItensDev.FieldByName('QTDDEV').AsFloat,
                                             fltBasIcm, fltAlqIcm, fltAlqIcmRed, fltValIcm, fltPerBas, fltPeBaST,
                                             strCodAbf, strDesAbf, strClaFis, strCodFis);

                      If blnPrecoPraticado Then
                      Begin

                        If cdsItensDev.FieldByName('DET_ALQIPI').AsFloat > 0 Then
                          fltBasIPI := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_BASIPI').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2)
                        Else
                          fltBasIPI := 0;

                        fltBasIcm := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_BASICM').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltValIcm := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_VALICM').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltAlqIcm := cdsItensDev.FieldByName('DET_ALQICM').AsFloat;

                        fltValIpi := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_VALIPI').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);

                  //      fltTotIte := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_TOTITE').AsFloat / cdsItensDev.FieldByName('DET_QTDITE').AsFloat), -2);

                        fltTotIte := fFormataFloat((cdsItensDev.FieldByName('QTDDEV').AsFloat * fltUnitar), 02);  {utilizando o mesmo arredondamento do faturamento TFatVenda.fCalculaTotalItem }

                        fltValRet := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_VALRET').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltBasRet := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_BASRET').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltVal_Rt := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_VAL_RT').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);

                        fltValCof := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_VALCOF').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltBasPis := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_BASPIS').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltValPis := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_VALPIS').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltBasCof := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_BASCOF').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltDesAceDet := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_DESACE').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);

                        fltDesEsp := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_DESESP').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltFreIte := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_TOTFRE').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);

                        fltBFCPST := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_BFCPST').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltPFCPST := cdsItensDev.FieldByName('DET_PFCPST').AsFloat;
                        fltVFCPST := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_VFCPST').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);


                        fltBASFCP := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('ICD_BASFCP').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);
                        fltPERFCP := cdsItensDev.FieldByName('ICD_PERFCP').AsFloat;
                        fltVALFCP := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('ICD_VALFCP').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);

                        fltPerBas := cdsItensDev.FieldByName('DET_PERBAS').AsFloat;
                        fltPeBaST := cdsItensDev.FieldByName('DET_PEBAST').AsFloat;
                        fltPerRed := cdsItensDev.FieldByName('DET_PERRED').AsFloat;
                        fltAlqRet := cdsItensDev.FieldByName('DET_ALQRET').AsFloat;
                        strCodFis := cdsItensDev.FieldByName('DET_CODFIS').AsString;
                        strIncPis := cdsItensDev.FieldByName('DET_INCPIS').AsString;
                        strCtsCof := cdsItensDev.FieldByName('DET_CSTCOF').AsString;
                        strCtsPis := cdsItensDev.FieldByName('DET_CSTPIS').AsString;
                        strNR_Pis := cdsItensDev.FieldByName('DET_NR_PIS').AsString;
                        strNR_Cof := cdsItensDev.FieldByName('DET_NR_COF').AsString;
                        fltAlqCof := cdsItensDev.FieldByName('DET_ALQCOF').AsFloat;
                        fltAlqPis := cdsItensDev.FieldByName('DET_ALQPIS').AsFloat;
                        strCodUni := cdsItensDev.FieldByName('DET_CODUNI').AsString;

                      End Else
                      Begin
                        If cdsItensDev.FieldByName('DET_ALQIPI').AsFloat > 0 Then
                          fltBasIPI := fltUnitar*cdsItensDev.FieldByName('QTDDEV').AsFloat
                        Else
                          fltBasIPI := 0;

                        fltTotIte := fltUnitar*cdsItensDev.FieldByName('QTDDEV').AsFloat;

                        fltValIpi := fltBasIPI*cdsItensDev.FieldByName('DET_ALQIPI').AsFloat/100;

                        strCodUni := qryConIte.FieldByName('ITE_CODUNI').AsString;

                        fltFreIte := RoundTo(cdsItensDev.FieldByName('QTDDEV').AsFloat * (cdsItensDev.FieldByName('DET_TOTFRE').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat), -2);

                        fltDesEsp := 0;
                        //fltFreIte := 0;
                        fltValRet := 0;
                        fltBasRet := 0;
                        fltVal_Rt := 0;
                        fltPerBas := 0;
                        fltPeBaST := 0;
                        fltPerRed := 0;
                        fltAlqRet := 0;

                        fltValCof := 0;
                        fltBasPis := 0;
                        fltValPis := 0;
                        fltBasCof := 0;
                        fltDesAceDet := 0;
                        fltAlqCof := 0;
                        fltAlqPis := 0;

                        fltBFCPST := 0;
                        fltPFCPST := 0;
                        fltVFCPST := 0;

                        fltBASFCP := 0;
                        fltPERFCP := 0;
                        fltVALFCP := 0;

                        strCodFis := '';
                        strIncPis := '';
                        strCtsCof := '';
                        strCtsPis := '';
                        strNR_Pis := '';
                        strNR_Cof := '';
                      End;

                      If cdsItensDev.FieldByName('QTDDEV').AsFloat > 0 Then
                      Begin
                        frmEntMercadorias.pCarregaItemDevolucao(cdsItensDev.FieldbyName('DET_CODITE').AsString);

                        strNumLot := '';


                        If ((rdgOpcoes.ItemIndex = IDX_DEVOLUCAO) and (fCfgSis('MANEND', VarBoolean))) Then
                          strNumLot := cdsItensDev.FieldbyName('DET_NUMLOT').AsString;

                        if (FblnAcessadoViaRetornoConsignacao) And (FTipoRetornoConsignacao = ttrEntradaManual) then
                        Begin
                          strNumLot := cdsItensDev.FieldbyName('DET_NUMLOT').AsString;

                          if (fUsaRotinaWMS) and
                             (fCampoTabela( 'ITE_RASTRE', 'CADITE', ['ITE_CODITE'], [cdsItensDev.FieldbyName('DET_CODITE').AsString]) = 'N') then
                            strNumLot := 'A DEFINIR';
                        End;

                        frmEntMercadorias.pAdicionaItem(fltUnitar,
                                                        cdsItensDev.FieldByName('QTDDEV').AsFloat,
                                                        fltTotIte,
                                                        cdsItensDev.FieldByName('DET_ALQIPI').AsFloat,
                                                        fltBasIPI,
                                                        fltValIpi,
                                                        fltAlqIcm,
                                                        fltBasIcm,
                                                        fltValIcm,
                                                        cdsItensDev.FieldbyName('DET_CODITE').AsString,
                                                        cdsItensDev.FieldbyName('ITE_CODGRU').AsString,
                                                        strDesIte,
                                                        qryConIte.FieldByName('ITE_REFERE').AsString,
                                                        strCodUni,
                                                        strCodAbf, strDesAbf,
                                                        IIF(frmEntMercadorias.blnDevolu, cdsItensDev.FieldByName('AUTOINCREM').AsString, ''),   {strAutVen}
                                                        IIF(frmEntMercadorias.blnDevolu, cdsItensDev.FieldByName('TABELA').AsString, ''),       {strTabVen}
                                                        qryConIte.FieldByName('ITE_CODFAB').AsString,
                                                        cdsItensDev.FieldByName('DET_NUMDOC').AsString,
                                                        cdsItensDev.FieldByName('DET_ESPDOC').AsString,
                                                        cdsItensDev.FieldByName('DET_CODEMP').AsString,
                                                        cdsItensDev.FieldByName('DET_CODCLI').AsString,
                                                        strNumLot,
                                                        qryConIte.FieldByName('ITE_RPRENT').AsString,
                                                        cdsItensDev.FieldByName('DET_CODACA').AsString,
                                                        cdsItensDev.FieldByName('DET_EMPACA').AsString,
                                                        cdsItensDev.FieldByName('DET_PROACA').AsString,
                                                        cdsItensDev.FieldByName('DET_DESCRI').AsString,
                                                        cdsItensDev.FieldByName('DET_UNITAR').AsFloat,
                                                        cdsItensDev.FieldByName('ACA_SALDOS').AsFloat,
                                                        qryConIte.FieldByName('ITE_CLAIPI').AsString,
                                                        1,
                                                        qryConIte.FieldByName('ITE_UNICOM').AsString,
                                                        cdsItensDev.FieldByName('DET_CODMOT').AsString,
                                                        cdsItensDev.FieldByName('DET_CODDIV').AsString,
                                                        cdsItensDev.FieldByName('DET_DESESP').AsFloat / cdsItensDev.FieldByName('QTDORI').AsFloat,
                                                        cdsItensDev.FieldByName('DET_EMP_PD').AsString,

                                                        '', // strCDCEST

                                                        strIncPis,
                                                        strCtsCof,
                                                        strCtsPis,
                                                        strNR_Pis,
                                                        strNR_Cof,
                                                        strCodFis,

                                                        fltValRet,
                                                        fltBasRet,
                                                        fltVal_Rt,
                                                        fltPerBas,
                                                        fltPeBaST,
                                                        fltPerRed,
                                                        fltAlqRet,
                                                        fltValCof,
                                                        fltBasPis,
                                                        fltValPis,
                                                        fltBasCof,
                                                        fltDesAceDet,
                                                        fltAlqCof,
                                                        fltAlqPis,
                                                        fltDesEsp,
                                                        fltFreIte,
                                                        cdsItensDev.FieldByName('QTDORI').AsFloat,
                                                        cdsItensDev.FieldByName('DET_PROEMB').AsString,
                                                        qryConIte.FieldByName('ITE_IMPDIR').AsString,
                                                        fltBFCPST,
                                                        fltPFCPST,
                                                        fltVFCPST,
                                                        fltBASFCP,
                                                        fltPERFCP,
                                                        fltVALFCP,
                                                        cdsItensDev.FieldByName('DET_IDEPRO').AsString,
                                                        cdsItensDev.FieldByName('DET_ITETIN').AsString,
                                                        cdsItensDev.Recno,
                                                        qryGenIte.FieldByName('MAR_DESMAR').AsString,
                                                        cdsItensDev.FieldByName('INCFUT').AsString);

                      End;

                    End;

                  End
                  Else
                  Begin

                    qryGenIte.Close;

                  End;


                End;

                cdsItensDev.Next;

              End;

            End;

            pAbreEntMercadorias;

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '[pMostraItensVenda]');
            End;
          End;
        Finally
          FillChar(recNotEle, SizeOf(recNotEle), #0);
          edtNotEle.Clear;
          fltValFre := 0;
          fltDesAce := 0;
          strNumDoc := '';
          strNumSer := '';
          pFreeAndNil(frmEntMercadorias);
          Application.ProcessMessages;
          pSetFocus(rdgOpcoes);
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pMostraItensVenda_1]');
      End;
    End;

  Finally
    pFreeAndNil(frmEntSelItensDevolucao);

    pnlInfo.Caption := '';
    Self.Enabled    := True;
    FreeAndNil(qryGenIte);
  End;
  Application.ProcessMessages;
End;

procedure TfrmEntDigPedido.pTrataDevolucaoAD(Var blnConfirma: Boolean);
  Var
    strKey: Char;
Begin
  strKey := '/';

  If fPesqAD(Self, edtNumPed, Nil, strKey, '', True, 'N', True) Then
  Begin

    blnConfirma := fValidaCampos(edtNumPed);

  End

  Else blnConfirma := False;

End;

procedure TfrmEntDigPedido.pTrataDevolucao(Var blnConfirma: Boolean; strAutDev: String = '');
  Var
    strDocsSel: String;
    strCodVen: String;
    strCodRep: String;
    strCodCli: String;
    strCodFaz: String;
Begin
  blnConfirma := False;

  Try

    If fEmptyStr(strAutDev) Then
    Begin

      pCriarFormularios(TfrmEntSelDocumentos, frmEntSelDocumentos);

      if FblnAcessadoViaRetornoConsignacao then
        frmEntSelDocumentos.blnAcessadoViaRetornoConsignacao := FblnAcessadoViaRetornoConsignacao;

      If frmEntSelDocumentos.ShowModal = mrOk Then
      Begin

        strDocsSel := frmEntSelDocumentos.strDocsSel;
        strCodVen  := frmEntSelDocumentos.strCodVen;
        strCodRep  := frmEntSelDocumentos.strCodRep;
        strCodCli  := frmEntSelDocumentos.strCodCli;
        strCodFaz  := frmEntSelDocumentos.strCodFaz;

        pMostraItensVenda(blnConfirma,strDocsSel,strCodVen,strCodRep,strCodCli,strCodFaz,'', True);
      End;

      pFreeAndNil(frmEntSelDocumentos);

    End Else
    Begin

      pRetornaDadosAD(edtNumPed.Text, edtCodEmp.Text, strDocsSel,strCodVen,strCodRep,strCodCli);

      If fEmptyStr(strDocsSel) Then
        pMensagemOk('Nenhum item econtrado para devolução!')
      Else
        pMostraItensVenda(blnConfirma,strDocsSel,strCodVen,strCodRep,strCodCli,strCodFaz,edtNumPed.Text, False);

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmEntDigPedido.pTrataDevolucao]');
    End;
  End;

  edtNumPed.Clear;
End;

procedure TfrmEntDigPedido.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (Key <> #13) And (rdgOpcoes.ItemIndex = IDX_CONSERTO_EQU) Then
    Key := #0;

  If fEntraCons(Key) Then
    pNumPedKeyPress('');
End;

function TfrmEntDigPedido.fEhNotaImportacao(strAutInc: String): Boolean;
  var
    qryConsulta: TUniQuery;
begin
  Result := False;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT LEFT(I08_CFOP, 1) AS CFOP FROM DETELE');
    qryConsulta.SQL.Add('WHERE DET_SEQGER = "' + strAutInc+ '"');
    qryConsulta.SQL.Add('LIMIT 1');

    qryConsulta.Open;


    If qryConsulta.IsEmpty Then
      Exit(False);

    If (qryConsulta.FieldByName('CFOP').AsString= '3') Or
       (qryConsulta.FieldByName('CFOP').AsString = '7') Then
     Result := True;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TfrmEntDigPedido.fExistePedidoCompraParaNotaImportacao: Boolean;
var
  qryPedImp: TUniQuery;
  strMensagem: String;
begin
  qryPedImp   := fCriaQuery;
  try
    qryPedImp.Close;
    qryPedImp.SQL.Clear;
    qryPedImp.SQL.Add('SELECT PCG_CODEMP, PCG_NUMPED, PCG_ESPDOC, PCG_DOCEMI ');
    qryPedImp.SQL.Add('  FROM PCMGER ');
    qryPedImp.SQL.Add(' WHERE PCG_DOCEMI = :DOCEMI ');
    qryPedImp.SQL.Add('   AND PCG_ESPEMI = "NF" ');
    qryPedImp.SQL.Add('   AND PCG_SEREMI = :SEREMI ');
    qryPedImp.SQL.Add('   AND PCG_CODFOR = :CODFOR ');
    qryPedImp.SQL.Add('   AND PCG_BAIXAD = 0 ');
    qryPedImp.SQL.Add('   AND PCG_PEDIMP = "S" ');
    qryPedImp.SQL.Add('   AND PCG_DOCEMI IS NOT NULL ');  {Pega os pedidos de importação com NF já emitida}

    qryPedImp.ParamByName('DOCEMI').AsString := recNotEle.strNumDoc;
    qryPedImp.ParamByName('SEREMI').AsString := recNotEle.strSerDoc;
    qryPedImp.ParamByName('CODFOR').AsString := recNotEle.strCodFor;

    qryPedImp.Open;

    Result := Not qryPedImp.IsEmpty;
    if Result Then
    Begin
      // Se vier da entrada automatica de nota de serviço continua o processo informando o pedido automaticamente
      If blnAutomatico then
      begin
         edtNumPed.Text := qryPedImp.FieldByName('PCG_NUMPED').AsString;
         Result := False;
      end
      else
      begin
        strMensagem := Format('Existe pedido de compra %s - %s - %s para essa nota de importação. Por favor, informar.',
                        [qryPedImp.FieldByName('PCG_NUMPED').AsString,
                         qryPedImp.FieldByName('PCG_CODEMP').AsString,
                         qryPedImp.FieldByName('PCG_ESPDOC').AsString]);

        fMensagem('', strMensagem, ['&O k']);
      end;
    End;

  finally
   FreeAndNil(qryPedImp);
  end;
end;

procedure TfrmEntDigPedido.pNumPedKeyPress(strNumPed: String);
  Var
    blnConfirma: Boolean;
    blnCarregProd: Boolean;
    strCodFor,
    strCodOpe: String;
    stlPedidos: TStringList;
begin

  If fEmptyStr(edtCodEmp.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar a empresa!', ['&Ok']);
    edtNumPed.Text := '';
    pSetFocus(edtCodEmp);
    exit;
  End;

  strCodFor := '';

  If fCfgSis('ENTXML', varBoolean) And fEmptyStr(edtNotEle.Text) And (rdgOpcoes.ItemIndex = IDX_ENTRADA) Then
  Begin
    ffrmSenha(strSenha, 'Entr. sem XML, Senha direito acesso!');
    strCodOpe := fRetCodVendedor(strSenha);

    If (Not fVerificaAcessoSistema('ENTXML', strCodOpe)) Or fEmptyStr(strCodOpe) Then
    Begin
      fMensagem('', 'Usuario sem permissão de acesso!', ['&O k']);
      pSetFocus(btnNotEle);
      exit;
    End;
  End;

  qryItePed.Close;

  edtNumPed.Enabled := False;

  If rdgOpcoes.ItemIndex = IDX_ENTRADA Then
  Begin
    stlPedidos := TStringList.Create;

    If Not fEmptyStr(recNotEle.strAutInc) Then
      strCodFor := recNotEle.strCodFor;

    pTrataCompra(strNumPed, blnConfirma, strCodFor, blnCarregProd, stlPedidos);

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmEntMercadorias, frmEntMercadorias);

        frmEntMercadorias.qryItePed := qryItePed;
        frmEntMercadorias.blnFornJaAtualizado:= blnFornJaAtualizado;
        If fEmptyStr(edtNotEle.Text) Then
          frmEntMercadorias.blnBonificacao := blnBonificacao;
        frmEntMercadorias.recNotEle := recNotEle;

        If Not fEmptyStr(recNotEle.strAutInc) Then
        Begin
          fltValFre := recNotEle.fltValFre;
          fltDesAce := 0;
        End;

        frmEntMercadorias.edtNumDoc.Text := strNumDoc;
        frmEntMercadorias.edtSerie.Text  := strNumSer;

        frmEntMercadorias.fltValFre := fltValFre;
        frmEntMercadorias.fltDesAce := fltDesAce;

        frmEntMercadorias.blnSemInc := False;
        frmEntMercadorias.strCodFor := strCodFor;
        frmEntMercadorias.strOrdIte := strOrdIte;
        frmEntMercadorias.stlPedidos.Assign(stlPedidos);
        frmEntMercadorias.blnCarregProd := blnCarregProd;

        frmEntMercadorias.arrDocOri := arrDocOri;

        pAbreEntMercadorias;
      Except
       On E: Exception Do
         pMensagensErro(E.Message, '[UntEntDigPedido -> edtNumPedKeyPress]');
      End;

      FillChar(recNotEle, SizeOf(recNotEle), #0);
      edtNotEle.Clear;
      fltValFre := 0;
      fltDesAce := 0;
      pFreeAndNil(frmEntMercadorias);

      pSetFocus(rdgOpcoes);

    End;

    FreeAndNil(stlPedidos);
  End

  Else If (rdgOpcoes.ItemIndex = IDX_DEVOLUCAO) or (rdgOpcoes.ItemIndex = IDX_CONSIGNACAO_DEVOLUCAO) or (rdgOpcoes.ItemIndex = IDX_LOCACAO_DEVOLUCAO) Then
  Begin
    pTrataDevolucao(blnConfirma);

    if (blnConfirma) and ((rdgOpcoes.ItemIndex = IDX_CONSIGNACAO_DEVOLUCAO) or (rdgOpcoes.ItemIndex = IDX_LOCACAO_DEVOLUCAO)) then
      Close;
  End

  Else If rdgOpcoes.ItemIndex = IDX_DEVOLUCAO_AD Then
    pTrataDevolucaoAD(blnConfirma);

  edtNumPed.Enabled := True;
  pSetFocus(Self);

  If (edtNumPed.Enabled) Then
    pSetFocus(edtNumPed);
end;

procedure TfrmEntDigPedido.FormCreate(Sender: TObject);
begin
  inherited;

  blnFornJaAtualizado:= False;

  FblnAcessadoViaRetornoConsignacao := False;
  FblnAcessadoViaRetornoLocacao  := False;

  fltCotDol := 0;
  blnAutomatico := False;

  blnPresencial := False;
  blnBonificacao := False;

  blnPedVicNFE := False;
  FillChar(recNotEle, SizeOf(recNotEle), #0);
  strOrdIte := '';
  blnEntCpd := (fCfgSis('ENTCPD', varBoolean));
  blnEntCNF := (fCfgSis('ENTCNF', varBoolean));
  edtCodEmp.Text := VS_strCodEmp;
  strCodEmp      := VS_strCodEmp;
  pCarregaEmpresa;

  qryConIte := fCriaQuery(Self);
  qryConAbf := fCriaQuery(Self);
  qryAbfIcm := fCriaQuery(Self);
  qryItePed := fCriaQuery(Self);

  fltValFre := 0;
  fltDesAce := 0;

  SetLength(arrDocOri, 0, 0);

  blnCarregarConferido := (fCfgSis('USACON', varBoolean) And fCfgSis('PERCPA', varBoolean));

  IDX_ENTRADA      := -1;
  IDX_DEVOLUCAO    := -1;
  IDX_DEVOLUCAO_AD := -1;
  IDX_CONSERTO_EQU := -1;
  IDX_CONSIGNACAO_DEVOLUCAO := -1;
  IDX_LOCACAO_DEVOLUCAO := -1;

  rdgOpcoes.Items.Clear;
  rdgOpcoes.Items.Add('&Entrada');
  IDX_ENTRADA := rdgOpcoes.Items.Count -1;

  blnLiberouADComSenha := False;

  objLiberacao := TLiberacao.Create;


  If (VS_strHabilitarCRM) And (fCfgSis('UTI_AD', varBoolean)) Then
  Begin
    rdgOpcoes.Items.Add('&Devolução por A.D.');
    IDX_DEVOLUCAO_AD := rdgOpcoes.Items.Count -1;
  End;

  rdgOpcoes.Items.Add('&Devolução');
  IDX_DEVOLUCAO := rdgOpcoes.Items.Count -1;

  If fCfgSis('CONEQU', varBoolean) Then
  Begin
    rdgOpcoes.Items.Add('&Conserto de Equipamento');
    IDX_CONSERTO_EQU := rdgOpcoes.Items.Count -1;
  End;

  rdgOpcoes.ItemIndex := IDX_ENTRADA;

end;

procedure TfrmEntDigPedido.FormActivate(Sender: TObject);
begin
  inherited;

  If Not fValidaForCusPersonalizada Then
  Begin
    fMensagem('Atenção','O sistema está configurado para usar fórmula de custo'#13#10
                       +'personalizada [CFG_FRMCUS] e a tabela da fórmula está'#13#10
                       +'vazia ( tabela FORCUS ). Peça para o responsável rever'#13#10
                       +'a configuração "CFG_FRMCUS" ou entre em contato'#13#10
                       +'com a citel.'
              ,['&O K']);

    PostMessage(Self.Handle,WM_CLOSE,0,0);
    ModalResult := mrCancel;
  End;
end;

procedure TfrmEntDigPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  FreeAndNil(qryAbfIcm);
  Application.OnIdle := Nil;
end;

procedure TfrmEntDigPedido.pAbreEntMercadorias;
  Var
    blnRecebimentoDeGarantiaDaFilial : Boolean;
    intCorre : Integer;
    blnAbortar,
    Result   : Boolean;
    stlPedEle,
    stlBlock : TStringList;

  Function fTravaDestrava(blnTrava : Boolean; strNumPed, strEspDoc, strCodEmp : String): Boolean;
  Begin
    Result :=  fTravaDestravaPedidoCompra(blnTrava, strNumPed, strEspDoc, strCodEmp);

    If Result Then
      edtNumPed.Enabled := True;
  End;

  Function fRetListaPedidosGerEle(strAutInc: String): String;
    Var
      qryPedEle: TUniQuery;
  Begin
    qryPedEle := fCriaQuery;
    qryPedEle.SQL.Text := 'SELECT GROUP_CONCAT(CONCAT(PEL_NUMDOC, PEL_CODEMP)) AS NUMPED FROM PEDELE WHERE PEL_SEQELE = ' + QuotedStr(strAutInc);
    qryPedEle.Open;

    Result := qryPedEle.FieldByName('NUMPED').AsString;

    FreeAndNil(qryPedEle);
  End;

  Procedure pPreencheListaPedidos(stlPedidos : TStringList);
    Var
      intCorre : Integer;
  Begin
    stlBlock := TStringList.Create;
    stlBlock.Sorted := true;
    stlBlock.Duplicates := dupIgnore;

    If Assigned(stlPedidos) And (stlPedidos.Count > 0) Then
    Begin
      For intCorre := 0 To stlPedidos.Count -1 Do
        stlBlock.Add(stlPedidos[intCorre])
    End

    Else If not fEmptyStr(edtNumPed.Text) Then
      stlBlock.Add(edtNumPed.Text + strCodEmp);
  End;

  function fVerificaSeTodosItensDaNotaTemLoteDeGarantia : Boolean;
    Var
      qryDetEle : TUniQuery;
      objCadLot : TCadLot;
      stlItens  : TStringList;
  Begin
    qryDetEle := fCriaQuery;
    objCadLot := TCadLot.Create(Nil);
    stlItens  := TStringList.Create;
    Try
      qryDetEle.SQL.Text := ' SELECT DET_CODITE FROM DETELE WHERE DET_SEQGER = :SEQGER ';
      qryDetEle.ParamByName('SEQGER').AsString := recNotEle.strAutInc;
      qryDetEle.Open;
      While not qryDetEle.Eof Do
      Begin
        if fUsaRotinaWMS or (objCadLot.fExisteLote(qryDetEle.FieldByName('DET_CODITE').AsString, VS_strCodEmp)) Then
        Begin
          if not objCadLot.fExisteLotePrincipalGarantia(qryDetEle.FieldByName('DET_CODITE').AsString, VS_strCodEmp) Then
          Begin
            if stlItens.IndexOf('"' + qryDetEle.FieldByName('DET_CODITE').AsString + '"') < 0 Then
              stlItens.Add('"' + qryDetEle.FieldByName('DET_CODITE').AsString + '"');
          End;
        End;

        qryDetEle.Next;
      End;

      Result := stlItens.Count = 0;

      if not Result Then
        fMensagem('', 'Os itens abaixo não possuem lote principal de garantia, '+
                      'cadastre o lote de garantia antes de realizar a entrada!' + #13 +
                      fCommaText(stlItens), ['&OK']);

    Finally
      FreeAndNil(qryDetEle);
      FreeAndNil(objCadLot);
      FreeAndNil(stlItens);
    End;
  End;

begin
  blnRecebimentoDeGarantiaDaFilial := False;
  Result := True;

  If FblnAcessadoViaRetornoLocacao Then
  Begin
    blnAutomatico := False;
  End;

  //Cria Travas do Pedido
  With frmEntMercadorias Do
  Begin

    if FblnAcessadoViaRetornoConsignacao then
    Begin
      if (FTipoRetornoConsignacao = ttrEntradaManual) and (fEmptyStr(strDocSel)) then
      Begin
        fMensagem('Atenção', 'É obrigatório informar o documento de envio para prosseguir com o retorno.', ['&OK']);
        Exit;
      End;

      frmEntMercadorias.blnAcessadoViaRetornoConsignacao := FblnAcessadoViaRetornoConsignacao;
      frmEntMercadorias.TipoRetornoConsignacao           := FTipoRetornoConsignacao;
    End;

    stlBlock := Nil;

    If (Assigned(stlPedidos) And (stlPedidos.Count > 0)) Or (Not fEmptyStr(edtNumPed.Text)) Then
    Begin
      pPreencheListaPedidos(stlPedidos);

    End Else If (Not fEmptyStr(recNotEle.strAutInc)) Then
    Begin
      stlPedEle := TStringList.Create;
      stlPedEle.CommaText := fRetListaPedidosGerEle(recNotEle.strAutInc);
      pPreencheListaPedidos(stlPedEle);
      pFreeAndNil(stlPedEle);
    End;

    If Assigned(stlBlock) Then
    For intCorre := 0 To stlBlock.Count -1 Do
    Begin
      Result := fTravaDestrava(True, LeftStr(stlBlock[intCorre], fTamDocCadRec()), 'PD', RightStr(stlBlock[intCorre], 3));

      //Se for entrada de garantia de outra loja filial, precisa verificar se todos os itens tem lote principal de garantia
      If (not blnRecebimentoDeGarantiaDaFilial) And fCfgSis('REFENT', varBoolean) Then
        blnRecebimentoDeGarantiaDaFilial := fPedidoDeCompraOriundoDeGarantiaFilial(LeftStr(stlBlock[intCorre], fTamDocCadRec()), RightStr(stlBlock[intCorre], 3));

      If Not Result Then
      Begin
        pDestravarTodosLocksConexaoAtual;
        Break;
      End;
    End;

    if blnRecebimentoDeGarantiaDaFilial Then
    Begin
      Result := fVerificaSeTodosItensDaNotaTemLoteDeGarantia;
      If Not Result Then
      Begin
        pDestravarTodosLocksConexaoAtual;
        Exit;
      End;
    End;

    If Result Then
    Begin

      If Not fEmptyStr(recNotEle.strAutInc) Then
        Self.blnInformouCotacao := False;

      blnAbortar := False;

      If Self.blnInformouCotacao Or fPedeCotacaoDolar(stlPedidos, blnAbortar) Then
      Begin
        frmEntMercadorias.blnInformouCotacao := Self.blnInformouCotacao;
        frmEntMercadorias.fltCotDol          := Self.fltCotDol;
        blnEntradaEfetivada := False;
        If blnAutomatico Then
        Begin
          pshow;
          frmEntMercadorias.btnConfirma.Click;
        End
        Else
          ShowModal;

        blnEntradaEfetivada := frmEntMercadorias.blnConfirma;
      End;

    End;

    If Assigned(stlBlock) Then
    Begin
      //Destrava pedidos
      If Result Then
        For intCorre := 0 To stlBlock.Count -1 Do
          fTravaDestrava(False, LeftStr(stlBlock[intCorre], fTamDocCadRec()), 'PD', RightStr(stlBlock[intCorre], 3));

      FreeAndNil(stlBlock);
    End;

    If FblnAcessadoViaRetornoLocacao and blnEntradaEfetivada Then
      Self.Close;

  End;
end;

procedure TfrmEntDigPedido.pAjustarTelaEntradaRetornoLocacao;
begin
  If Not FblnAcessadoViaRetornoLocacao Then
    Exit;

  If (fCfgSis('LOCEQU', varBoolean)) then
  Begin
    rdgOpcoes.Items.Add('&Locação - Devolução');
    IDX_LOCACAO_DEVOLUCAO := rdgOpcoes.Items.Count -1;
    rdgOpcoes.ItemIndex   := IDX_LOCACAO_DEVOLUCAO;
    rdgOpcoes.Enabled     := False;

    If (strListIdGerEle.Count = 1) Then
    Begin
      pCarregaNotaImportacao(strListIdGerEle.Strings[0]);
    End;
  End;
end;

procedure TfrmEntDigPedido.pCarregaEmpresa;
Begin
  If Not (fEmptyStr(edtCodEmp.Text)) Then
    edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmp.Text)
  Else
    edtDesEmpresa.Text := '';

End;

procedure TfrmEntDigPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
  Begin

    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      Close;
    End
    Else
    Begin
      SelectNext(ActiveControl, False, True);
    End;
  End
  Else If (Key = VK_RETURN) Then
  Begin

    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin

        SelectNext(ActiveControl, True, True);

    End;

  End;
end;

procedure TfrmEntDigPedido.FormShow(Sender: TObject);
begin
  inherited;

  If (FblnAcessadoViaRetornoConsignacao) and (fCfgSis('CONSIG', varBoolean)) Then
  Begin
    rdgOpcoes.Items.Add('&Consignação - Devolução');
    IDX_CONSIGNACAO_DEVOLUCAO := rdgOpcoes.Items.Count -1;
    rdgOpcoes.ItemIndex       := IDX_CONSIGNACAO_DEVOLUCAO;
    rdgOpcoes.Enabled         := False;

    if (strListIdGerEle.Count = 1) and  (FTipoRetornoConsignacao = ttrImportacaoXML) then
    Begin
      pCarregaNotaImportacao(strListIdGerEle.Strings[0]);
    End;
  End;

  pAjustarTelaEntradaRetornoLocacao;

  SelectNext(ActiveControl,False,True);
  pSetFocus(edtNumPed);

  intSemaforoConfirma := -1;

end;

procedure TfrmEntDigPedido.rdgOpcoesClick(Sender: TObject);
  function fValidaConfigConEqu: Boolean;
    Var
      strMsgTmp: String;
  Begin
    Result := True;
    strMsgTmp := '';

    If fEmptyStr(fCfgSis('ITECON', VarString)) Or fEmptyStr(fCfgSis('CLACON', VarString)) Then
    Begin
      If fEmptyStr(fCfgSis('ITECON', VarString)) Then
        strMsgTmp := 'CFG_ITECON';

      If fEmptyStr(fCfgSis('CLACON', VarString)) Then
      Begin
        If fEmptyStr(strMsgTmp) Then
          strMsgTmp := 'A configuração CFG_CLACON está'
        Else
          strMsgTmp := 'As configurações ' + strMsgTmp + ', CFG_CLACON estão';
      End
      Else
      Begin
        If Not fEmptyStr(strMsgTmp) Then
          strMsgTmp := 'A configuração ' + strMsgTmp + ' está';
      End;

      Result := False;
      fMensagem('', strMsgTmp + ' em branco. Configure-a(s) corretamente para prosseguir com este processo!' , ['&Ok']);
    End;
  End;
begin
  inherited;

  edtNumPed.ShowHint := False;
  edtNumPed.Hint     := '';

  If (rdgOpcoes.ItemIndex = IDX_DEVOLUCAO) And (VS_strHabilitarCRM) And (fCfgSis('UTI_AD', varBoolean)) And (Not blnLiberouADComSenha) Then
  Begin
    pLiberacaoComAD;
    If Not blnLiberouADComSenha Then
      rdgOpcoes.ItemIndex := IDX_DEVOLUCAO_AD;
  End;


  If rdgOpcoes.ItemIndex = IDX_ENTRADA Then
  Begin
    lblTipoDoc.Caption := 'Pedido de Compra:';
    pSetaNumPedCom(edtNumPed);
    cbbEsp.Visible := False;
    edtNumPed.Left := 138;
    edtNumPed.MaxLength := 12;
    edtNumPed.TamCampo  := 12;
    pSetFocus(edtNumPed);
  End

  Else If rdgOpcoes.ItemIndex = IDX_DEVOLUCAO Then
  Begin
    lblTipoDoc.Caption := 'Documento de Venda:';
    edtNumPed.MaxLength := fTamDocCadRec();
    edtNumPed.TamCampo  := edtNumPed.MaxLength;
    edtCodEmp.Text := VS_strCodEmp;
    pCarregaEmpresa;
    edtNumPed.Left := 180;
    cbbEsp.Visible := true;
    pSetFocus(cbbEsp);
  End

  Else If rdgOpcoes.ItemIndex = IDX_DEVOLUCAO_AD Then
  Begin
    lblTipoDoc.Caption := 'Número da A.D.:';
    edtNumPed.MaxLength := 8;
    edtNumPed.TamCampo  := 8;
    edtCodEmp.Text := VS_strCodEmp;
    pCarregaEmpresa;
    pSetFocus(edtNumPed);
  End

  Else If rdgOpcoes.ItemIndex = IDX_CONSERTO_EQU Then
  Begin
    If fValidaConfigConEqu Then
    Begin
      edtNumPed.ShowHint := True;
      edtNumPed.Hint     := 'Só é permitido criar uma nova nota de entrada de conserto de equipamento.';
      edtNumPed.Clear;
      lblTipoDoc.Caption := 'Conserto de Equipamento:';
      edtNumPed.MaxLength := fTamDocCadRec();
      edtNumPed.TamCampo  := fTamDocCadRec();
      edtCodEmp.Text := VS_strCodEmp;
      pCarregaEmpresa;
      cbbEsp.Visible := False;
      edtNumPed.Left := 138;
      edtNumPed.MaxLength := 12;
      edtNumPed.TamCampo  := 12;
      pSetFocus(edtNumPed);
    End
    Else
      rdgOpcoes.ItemIndex := IDX_ENTRADA;
  End

  Else If rdgOpcoes.ItemIndex = IDX_CONSIGNACAO_DEVOLUCAO Then
  Begin

    if FTipoRetornoConsignacao = ttrImportacaoXML then
    Begin
      edtNumPed.Visible  := False;
      lblTipoDoc.Visible := False;
    End
    Else
    Begin
      edtNumPed.Visible  := True;
      edtNumPed.Enabled  := True;
      lblTipoDoc.Visible := True;
      lblTipoDoc.Caption := 'Documento de Envio';
    End;

    edtCodEmp.Text := VS_strCodEmp;
    pCarregaEmpresa;
    cbbEsp.Visible := False;
  End
  Else If rdgOpcoes.ItemIndex = IDX_LOCACAO_DEVOLUCAO Then
  Begin
    edtNumPed.Visible  := False;
    lblTipoDoc.Visible := False;
    edtCodEmp.Text := VS_strCodEmp;
    pCarregaEmpresa;
    cbbEsp.Visible := False;
  End;

  lblNotEle.Enabled := (rdgOpcoes.ItemIndex = IDX_ENTRADA) Or
                       (rdgOpcoes.ItemIndex = IDX_CONSERTO_EQU) Or
                       (rdgOpcoes.ItemIndex = IDX_LOCACAO_DEVOLUCAO) Or
                       ((rdgOpcoes.ItemIndex = IDX_CONSIGNACAO_DEVOLUCAO) and (FTipoRetornoConsignacao = ttrImportacaoXML));
  btnNotEle.Enabled := (rdgOpcoes.ItemIndex = IDX_ENTRADA) Or
                       (rdgOpcoes.ItemIndex = IDX_CONSERTO_EQU) Or
                       (rdgOpcoes.ItemIndex = IDX_LOCACAO_DEVOLUCAO) Or
                       ((rdgOpcoes.ItemIndex = IDX_CONSIGNACAO_DEVOLUCAO) and (FTipoRetornoConsignacao = ttrImportacaoXML));

  If Not btnNotEle.Enabled Then
  Begin
    FillChar(recNotEle, SizeOf(recNotEle), #0);
    edtNotEle.Clear;
  End;
end;

procedure TfrmEntDigPedido.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  strCodEmp := edtCodEmp.Text;
end;

Function TfrmEntDigPedido.fValidaClaFisNotaElet(strAutInc: String): Boolean;
  Const
    STR_CONVCLA1 = ' IF(LOCATE(I08_CFOP, "5405_6404_5403_6403_") > 0, "1403", CONCAT("1", RIGHT(I08_CFOP, 3))) ';
    STR_CONVCLA2 = ' IF(LOCATE(I08_CFOP, "5405_6404_5403_6403_") > 0, "2403", CONCAT("2", RIGHT(I08_CFOP, 3))) ';

  Var
    qryDetEle: TUniQuery;
Begin
  qryDetEle := fCriaQuery;
  With qryDetEle, SQL Do
  Begin
    Clear;

    Add('SELECT GROUP_CONCAT(DISTINCT CODCFO) AS CODCFO FROM (');

    Add('SELECT ' + STR_CONVCLA1 + ' AS CODCFO ');
    Add('FROM DETELE');

    Add('LEFT JOIN CADCFO C ON C.CFO_CODCFO = ' + STR_CONVCLA1);

    Add('LEFT JOIN CADCFO E ON E.CFO_CODCFO = I08_CFOP AND E.CFO_CLAENT IS NOT NULL');

    Add('WHERE ');
    Add('  IFNULL(I08_CFOP, "") <> "" AND ');
    Add('  IFNULL(I08_CFOP, "") NOT IN ("5109", "6109") AND ');
    Add('  DET_SEQGER = :AUTINC   AND ');
    Add('  (E.CFO_CODCFO IS NULL) AND ');
    Add('  (C.CFO_CODCFO IS NULL)     ');

    Add(' UNION ALL ');

    Add('SELECT ' + STR_CONVCLA2 + ' AS CODCFO ');
    Add('FROM DETELE');

    Add('LEFT JOIN CADCFO C ON C.CFO_CODCFO = ' + STR_CONVCLA2);

    Add('LEFT JOIN CADCFO E ON E.CFO_CODCFO = I08_CFOP AND E.CFO_CLAENT IS NOT NULL');

    Add('WHERE ');
    Add('  IFNULL(I08_CFOP, "") <> "" AND ');
    Add('  IFNULL(I08_CFOP, "") NOT IN ("5109", "6109") AND ');
    Add('  DET_SEQGER = :AUTINC   AND ');
    Add('  (E.CFO_CODCFO IS NULL) AND ');
    Add('  (C.CFO_CODCFO IS NULL)     ');

    Add(') AS TAB');

    ParamByName('AUTINC').AsString := strAutInc;
    Open;

    Result := IsEmpty Or fEmptyStr(FieldByName('CODCFO').AsString);

    If Not Result Then
      pMensagemOk('Cadastre as Classificações Fiscais ' + FieldByName('CODCFO').AsString + ' para realizar a entrada!');

  End;
  FreeAndNil(qryDetEle);
End;

procedure TfrmEntDigPedido.pCarregaNotaImportacao(strAutIncGerEle: string);
  Var
    qryGerEle: TUniQuery;
Begin

  Try
    qryGerEle := fCriaQuery(Self);

    qryGerEle.SQL.Text := 'SELECT GERELE.*, ' + fSQLDescontoNotaXML + ' AS DESCONTO, '+
                           fSQLICMSDesoneradoEstaNoDescontoComercial + ' AS ICMSDesoneradoEstaNoDescontoComercial FROM GERELE WHERE GERELE.AUTOINCREM = "'+strAutIncGerEle+'" ';

    qryGerEle.Open;
    edtNotEle.Text := qryGerEle.FieldByName('B08_NNF').AsString + ' - ' + qryGerEle.FieldByName('GER_CODCLI').AsString + '-' + fRetNomCliente(qryGerEle.FieldByName('GER_CODCLI').AsString);
    pCarregaCabecalhoNota(qryGerEle, recNotEle);
    recNotEle.strClaBri := fretCFOPBonificacaoNotaElet(recNotEle.strAutInc);

    If Not fValidaClaFisNotaElet(recNotEle.strAutInc) Then
    Begin
      FillChar(recNotEle, SizeOf(recNotEle), #0);
      edtNotEle.Clear;
    End;


    edtNumPed.Clear;

    blnPedVicNFE := True;
    intSemaforoConfirma := -1;

    If FblnAcessadoViaRetornoLocacao Then
    Begin
      blnAutomatico := False;
    End
    Else
      blnAutomatico := True;

    fValidaCampos(edtNumPed, True);
    blnPedVicNFE := False;

  Finally
    FreeAndNil(qryGerEle);
    Self.Close;
  End;
End;

procedure TfrmEntDigPedido.btnNotEleClick(Sender: TObject);
  Var
    qryGerEle: TUniQuery;
    chrKey: Char;
    arrDigNota: TConsultasArray;
    LtpeFinalidadeXML : tpeFinalidadeXML;
begin
  inherited;

  {*******************************************}
  {* NOVA CONSULTA DE NOTA FISCAL ELETRONICA *}
  {****************************************AC*}

  Try
    qryGerEle := fCriaQuery(Self);

    chrKey := '/';

    LtpeFinalidadeXML := xmlEntradaMercadoria;
    if rdgOpcoes.ItemIndex = IDX_CONSIGNACAO_DEVOLUCAO then
      LtpeFinalidadeXML := xmlConsignacaoDevolucaoCliente;

    If rdgOpcoes.ItemIndex = IDX_LOCACAO_DEVOLUCAO Then
      LtpeFinalidadeXML := xmlRetornoLocacao;

    if fPesqGereleDigPedido(Self, edtNotEle, qryGerEle, recNotEle, chrKey, arrDigNota, True, LtpeFinalidadeXML) then
    begin
      recNotEle.strClaBri := fretCFOPBonificacaoNotaElet(recNotEle.strAutInc);

      If (LtpeFinalidadeXML = xmlConsignacaoDevolucaoCliente)  Then
      Begin
        blnAutomatico := True;
        strListIdGerEle.Clear;
        strListIdGerEle.Add(recNotEle.strAutInc);
        fValidaCampos(edtNumPed, True);
      End;

      If (LtpeFinalidadeXML = xmlRetornoLocacao) Then
      Begin
        blnAutomatico := False;
        strListIdGerEle.Clear;
        strListIdGerEle.Add(recNotEle.strAutInc);

        If FstrCodCli <> recNotEle.strCodCli Then
        Begin
          fMensagem('ATENÇÃO', 'O cliente do XML importado difere do cliente selecionado para o retorno de Locação.', ['&Ok']);
          FillChar(recNotEle, SizeOf(recNotEle), #0);
          edtNotEle.Clear;
          Exit;
        End;
      End;

      If fValidaClaFisNotaElet(recNotEle.strAutInc) Then
      Begin
        If (LtpeFinalidadeXML = xmlRetornoLocacao) Then
          fValidaCampos(edtNumPed, True);

        SelectNext(ActiveControl, True, True);
      End Else
      Begin
        FillChar(recNotEle, SizeOf(recNotEle), #0);
        edtNotEle.Clear;
      End;

    End Else
    Begin
      FillChar(recNotEle, SizeOf(recNotEle), #0);
      edtNotEle.Clear;
      SelectNext(ActiveControl, True, True);
    End;

    If (Not fEmptyStr(recNotEle.strAutInc)) And
       fCfgSis('USACON', varBoolean) And (Pos(fCfgSis('CONFME'), '1_3_') > 0) Then
    Begin
      edtNumPed.Clear;

      If (recNotEle.strConDir <> 'S') And (recNotEle.strEntDir <> 'S') And
         (rdgOpcoes.ItemIndex <> IDX_CONSIGNACAO_DEVOLUCAO) And
         (rdgOpcoes.ItemIndex <> IDX_LOCACAO_DEVOLUCAO) Then
        pMensagemOk('Existem Pedidos de Compra vinculados a esta NFe, ' +
                    'não será necessário selecioná-los, pois ' +
                    'o sistema irá baixá-los automaticamente!');

      blnPedVicNFE := True;
      fValidaCampos(edtNumPed, True);
      blnPedVicNFE := False;
    End;

  Finally
    FreeAndNil(qryGerEle);
  End;

  if (Not fEmptyStr(recNotEle.strAutInc)) and (rdgOpcoes.ItemIndex = IDX_CONSIGNACAO_DEVOLUCAO)  then
    Close;

end;

procedure TfrmEntDigPedido.pLiberacaoComAD;
Begin
  If (VS_strHabilitarCRM) And (fCfgSis('UTI_AD', varBoolean)) Then
  Begin
    If (fGetMenu('Escolha o Tipo de Liberação:', ['Liberação com AD', 'Digitar senha de liberação'], 1) = 2) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'EDSUAD';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.pAddTexto('Entrada de Devolução/Garantia sem vinculo de uma Autorização de Devolução (AD).');

      blnLiberouADComSenha := objLiberacao.fLibera;
    End;
  End;
End;


end.


