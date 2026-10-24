unit untMenuPedCom;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, StrUtils {Qt,}, Uni, untFuncoesPedido, AppEvnts,
  UniClientDataSet, DB, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untFuncoesPedidoSimples, untGravacaoPedido, Datasnap.DBClient,
  untRecuperaPedido, untImpressaoPedidoCompra, untTLock, untILiberacao, untMsgLiberacao, untLiberacaoFactory;
type
  TfrmMenuPedCom = class(TfrmPaiSimples)
    edtNumPed: TEditFocus;
    lblPedOrc: TLabel;
    pnlFundo: TPanel;
    rdgOpcoes: TRadioGroup;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    cdsEmpMlj: TUniClientDataSet;
    cdsEmpMljCODEMP: TStringField;
    cdsEmpMljDESCRI: TStringField;
    cdsEmpMljMARDES: TStringField;
    btnHeranca: TBitBtnLocked;
    btnCarrTxtFornecedor: TBitBtnLocked;
    BitBtn1: TBitBtnLocked;
    cdsEmpMljEMPVIS: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnHerancaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCarrTxtFornecedorClick(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    blnHRDPDL: Boolean;
    recOpcoesGiro: TRecOpcoesGiro;

    objCopiaSeg: TRecuperaPedido;

    objImpressaoPedido: TImprimePedidoCompa;

    strTrava    : String;
    blnAltPedGir: Boolean;

    blnNovoReg: Boolean;
    blnUsarGiro: Boolean;

    lstArquivos: TStringList;

    qryPcmGer: TUniQuery;

    strEmpUsadaGiro: String;

    intConf: Integer;
    blnBaixaParcial : Boolean;
    objLock: TLock;

    procedure pChamaTelaPedido;
    procedure pCarregaEmpresa;

    Procedure pSetaNumeroPedido;

    function fCarregaPedCom: Boolean;
    function fCalculoGiro(blnPededadosGiro: Boolean = True): Boolean;
    function fVerificaNotImpEmitida(strNumPed, strEspDoc, strCodEmp: String): Boolean;
    procedure pSetaValoresDefault(Var recOpcoesGiro: TRecOpcoesGiro);
    function fVerificaNotaFiscal: Boolean;

    procedure OnIdle(Sender: TObject; Var Done: Boolean);

    function fComparaEmpresa: Boolean;
    function fLiberouAlterarPedido: Boolean;
    function fNumeroNotaFiscal: String;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fPedidoMultilojaEJaFoiFeitoEntradaOuPreNota(strNumPed, strEspDoc, strCodEmp: String): Boolean;
  public
    { Public declarations }
    strEspDoc: String;
    strDocOri: String;
    strCodFor: String;
    blnConfirma : Boolean;



    strCodEmp: String;

    cdsItensPedido: TUniClientDataSet;
    cdsItensGiro  : TUniClientDataSet;
    cdsItensMultiLojas: TUniClientDataSet;
    qryGiro: TUniQuery;
    blnCodFab: Boolean;

  end;

var
  frmMenuPedCom: TfrmMenuPedCom;

implementation

uses untFuncoesSimples, untPedidoCompra, untConsultas, untPanelCxPedidoCompra, untPnlDadosPedCompra,
     untPai, untConstantes,
     untEntImportaPedFornc, untPedidoCompraImpr, untPedOpcoes,
     untEntEtiquetas,  untTypesSistema;

{$R *.dfm}

procedure TfrmMenuPedCom.FormCreate(Sender: TObject);
begin
  inherited;
  blnHRDPDL := False;
  objImpressaoPedido := TImprimePedidoCompa.Create;

  objCopiaSeg := TRecuperaPedido.Create(Self);

  recOpcoesGiro.objRecupera := objCopiaSeg;

  pSetaNumPedCom(edtNumPed);

  If Assigned(dicConfiguracoes) Then
    dicConfiguracoes.Remove('INCPED' + VS_strCodEmp);

  strTrava := '';
  blnAltPedGir := False;

  recOpcoesGiro.cdsEmpSel := Null;
  recOpcoesGiro.blnEmbala := False;

  strEspDoc   := 'PD';
  blnConfirma := False;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;
  strCodEmp := VS_strCodEmp;

  If Not fCfgSis('ALPDOL', varBoolean) Then
    edtCodEmpresa.Enabled := False
  Else
    edtCodEmpresa.Enabled := True;
  qryPcmGer := fCriaQuery(Self);

  cdsItensMultiLojas := Nil;
  Application.OnIdle := Self.OnIdle;

  recOpcoesGiro.strPedMlj := fCfgSis('PEDMLJ');

  strEmpUsadaGiro := '';

  intConf := -1;

  cdsItensGiro := Nil;

  If (fCfgSis('PEDMLJ') = 'S') Then
    pCarregaEmpresasMlj(cdsEmpMlj);

  recOpcoesGiro.blnCarregItensGrid := True;

  pSetaValoresDefault(recOpcoesGiro);
  objLock := TLock.Create;
end;

procedure TfrmMenuPedCom.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objImpressaoPedido);
end;

function TfrmMenuPedCom.fPedidoMultilojaEJaFoiFeitoEntradaOuPreNota(strNumPed, strEspDoc, strCodEmp: String): Boolean;
begin
  Result := False;
  If fEhPedidoCompraMultiLoja(strNumPed, strEspDoc, strCodEmp) Then
  Begin
    If fCfgSis('USACON', varBoolean) Then
    Begin
      If fCfgSis('CONFME') = '1' Then
      Begin
        If fPedidoEstaEmPreNota(strNumPed, strCodEmp,strEspDoc) Then
        Begin
          pMensagemOk('O Pedido é multi-loja e esta em pré nota não será possível a alterar!' + #$A#$D + 'Para manipular as quantidades do pedido utilizar o menu Principal->Movimentação de Itens->Manutenção de Pedido Multi-loja Após Entrada de Mercadoria/Pré-Nota');
          Exit(True);
        End
        Else If fPedidoBaixadoPelaEntrada(strNumPed,strCodEmp,strEspDoc) Then
        begin
          pMensagemOk('O Pedido é multi-loja e já foi feito a entrada, não será possível alterar!' + #$A#$D + 'Para manipular as quantidades do pedido utilizar o menu Principal->Movimentação de Itens->Manutenção de Pedido Multi-loja Após Entrada de Mercadoria/Pré-Nota');
          Exit(True);
        End;
      End;
    End;
    If fPedidoBaixadoPelaEntrada(strNumPed,strCodEmp,strEspDoc) Then
    begin
      pMensagemOk('O Pedido é multi-loja e já foi feito a entrada, não será possível alterar!' + #$A#$D + 'Para manipular as quantidades do pedido utilizar o menu Principal->Movimentação de Itens->Manutenção de Pedido Multi-loja Após Entrada de Mercadoria/Pré-Nota');
      Exit(True);
    End;
  End;
end;

function TfrmMenuPedCom.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strSenha,
    strPedOrc  : String;
    intFoco    : Integer;
    blnConfirma,
    blnConferido,
    blnAlterar,
    blnOrcamentoGeradoAutomaticamente : Boolean;
begin

  Result      := True;
  blnNovoReg  := True;
  blnUsarGiro := False;
  blnAltPedGir:= False;
  blnOrcamentoGeradoAutomaticamente := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtNumPed) Then
    Begin

      edtNumPed.Enabled := False;

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtCodEmpresa.Text := VS_strCodEmp;
        strCodEmp          := VS_strCodEmp;
        pCarregaEmpresa;
      End;

      If btnHeranca.Tag = 1 Then
      Begin
        strCodEmp          := edtCodEmpresa.Text;
        pCarregaEmpresa;
      End;

      If rdgOpcoes.ItemIndex = 0 Then
      Begin
        strPedOrc := 'pedido';
        strEspDoc := 'PD';
      End
      Else
      Begin
        strPedOrc := 'orçamento';
        strEspDoc := 'OR';
      End;

      If Not fEmptyStr(edtNumPed.Text) Then
      Begin
        If (strEspDoc <> 'OR') And fPedidoDeCompraOriundoDeGarantia(edtNumPed.Text, VS_strCodEmp) Then
        Begin
          fMensagem('', 'Não é permitido alterar um pedido de compra originado do envio de mercadorias em garantia para o fornecedor!', ['&Ok']);
          edtNumPed.Enabled := True;
          Exit(False);
        End;

        If fCarregaPedCom Then
        Begin

          objCopiaSeg.fSelecionaRecuperaPedido(edtNumPed.Text, strCodEmp, strEspDoc);

          If objCopiaSeg.blnCancelou Then
          Begin
            Result := False;
            edtNumPed.Enabled := True;
          End;

          blnNovoReg := False;

        End Else
        Begin
          fMensagem('ATENÇÃO!', 'Esse ' + strPedOrc + ' não está cadastrado!', ['&O k']);
          edtNumPed.Enabled := True;
          Result := False;
        End;
      End
      Else
      Begin

        Result := fComparaEmpresa;

        objCopiaSeg.fSelecionaRecuperaPedido('', '', strEspDoc);

      End;

      If objCopiaSeg.recPcmger.blnRecuperaPedido Then
      Begin
        blnUsarGiro := objCopiaSeg.recPcmger.strUsaGir = 'S';
        recOpcoesGiro.strPedMlj := objCopiaSeg.recPcmger.strPedMlj;
      End;

      {*****************************************}
      {* VERIFICA SE O PEDIDO ESTÁ JÁ ESTA     *}
      {* BAIXADA                               *}
      {**************************************MV*}
      If (Result) And (Not blnNovoReg) Then
      Begin
        If Not fVerificaPedidoBaixado(edtNumPed.Text, strEspDoc, strCodEmp, blnConferido, blnOrcamentoGeradoAutomaticamente) Then
        Begin
          If fCfgSis('USACON', varBoolean) And blnConferido Then
          Begin
            Result := False;
            edtNumPed.Enabled := True;
            fMensagem('ATENÇÃO!', 'Esse pedido já está conferido totalmente!', ['&O k']);
          End
          Else
          Begin
            Result := True;
            recOpcoesGiro.strNomFrm := '';
            If blnOrcamentoGeradoAutomaticamente Then
              recOpcoesGiro.strNomFrm := 'frmGerarOrcamentoCompraAuto';
          End;
        End Else
        Begin
          Result := False;
          edtNumPed.Enabled := True;
          fMensagem('ATENÇÃO!', 'Esse pedido já está baixado!', ['&O k']);
        End;
      End;

      If (Result) Then
      Begin
        If (fVerificaNotImpEmitida(edtNumPed.Text, strEspDoc, strCodEmp)) Then
        Begin
          Result := False;
          edtNumPed.Enabled := True;
          fMensagem('ATENÇÃO!', 'A nota de importação referente a esse pedido ' + #13#10 +
                                'já foi emitida, portanto não é possível altera-lo!', ['&O k']);
        End;

        If Not fEmptyStr(strTrava) Then
          objLock.fLock_Unlock(strTrava, False, False);

        If Not fEmptyStr(edtNumPed.Text) Then
        Begin
          strTrava := 'PEDCOM' + edtNumPed.Text +  strEspDoc + strCodEmp;

          If (Not objLock.fLock_Unlock(strTrava, True, False)) Then
          Begin
            edtNumPed.Enabled := True;
            fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strTrava), ['&Ok']);
            Result := False;
          End
        End;

      End;

      strDocOri := fCampoTabela('MID(PCG_DOCORI, ' + IntToStr(Succ(fTamDocCadRec)) + ', 2)', 'PCMGER', ['PCG_NUMPED', 'PCG_ESPDOC', 'PCG_CODEMP'], [edtNumPed.Text, strEspDoc, strCodEmp]);

      If Not Result Then
      Begin
        objCopiaSeg.recPcmger.blnRecuperaPedido := False;
        objCopiaSeg.recPcmger.strAutInc := '';
      End;

      If (Result) And (blnNovoReg) And (Not objCopiaSeg.recPcmger.blnRecuperaPedido) Then
      Begin

        If fCfgSis('PEDMLJ') = 'S' Then
          intFoco := 0
        Else
          intFoco := 1;

        Try
          pCriarFormularios(TfrmPedOpcoes, frmPedOpcoes);
          frmPedOpcoes.rdgMultiLoja.ItemIndex := intFoco;
          frmPedOpcoes.ShowModal;

          blnUsarGiro := frmPedOpcoes.blnGiro;
          blnConfirma := frmPedOpcoes.blnConfirma;


          recOpcoesGiro.blnUsaGiro :=  blnUsarGiro;

          If frmPedOpcoes.blnMultiLoja Then
            recOpcoesGiro.strPedMlj := 'S'
          Else
            recOpcoesGiro.strPedMlj := 'N';

          pSetaNumeroPedido;
        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '[frmMenuPedCom.fValidaCampos]');
          End;
        End;
        pFreeAndNil(frmPedOpcoes);

        If Not blnConfirma Then
        Begin
          edtNumPed.Enabled := True;
          Result := False;
          Exit;
        End;

        If blnUsarGiro Then
        Begin
          Result := fCalculoGiro;

          If (Result) Then
            Exit;
        End;

      End;

      If objCopiaSeg.recPcmger.blnRecuperaPedido Then
      Begin
        blnUsarGiro := objCopiaSeg.recPcmger.strUsaGir = 'S';
        recOpcoesGiro.blnUsaGiro := blnUsarGiro;
        recOpcoesGiro.strPedMlj := objCopiaSeg.recPcmger.strPedMlj;
      End;

      If Result Then
      Begin
        If (Not blnNovoReg) Or objCopiaSeg.recPcmger.blnRecuperaPedido Then
        Begin
          if not (fVerificaNotaFiscal) then
          begin
            if fCfgSis('PRENOT') = 'A' then
            begin
              fMensagem('', 'Pedido de compra já está associado a uma nota fiscal de entrada!', ['&O k']);
              blnAlterar := fMensagem('', 'Opção:', ['&Alterar', '&Imprimir']) = 1;
            end
            else if fCfgSis('PRENOT') = 'T' then
            begin
              if not fLiberouAlterarPedido then
              begin
                fMensagem('', 'Opção:', ['&Imprimir']);
                blnAlterar := False;
              end
              else
                blnAlterar := fMensagem('', 'Opção:', ['&Alterar', '&Imprimir']) = 1
            end
            else
              blnAlterar := fMensagem('', 'Opção:', ['&Alterar', '&Imprimir']) = 1
          end
          else
            blnAlterar := fMensagem('', 'Opção:', ['&Alterar', '&Imprimir']) = 1;

          If blnAlterar And fCfgSis('PDCGTR', varBoolean) then
          Begin
            If fPedidoMultilojaEJaFoiFeitoEntradaOuPreNota(edtNumPed.Text, strEspDoc, strCodEmp) then
            begin
              edtNumPed.Enabled := True;
              Exit;
            End;
          End;
          If objCopiaSeg.recPcmger.blnRecuperaPedido Or blnAlterar Then
          Begin

            (*
            If fTemPreNotaPedido(edtNumPed.Text, strCodEmp, strNotas) Then
            Begin
              pMensagemOk('Esse pedido já está associado à(s) pré-nota(s) '+ strNotas + ' e' + #13#10 +
                          'somente poderá ser alterado após a entrada de mercadorias (se parcial) ou' + #13#10 +
                          'cancelamento da(s) pré-nota(s).');

              edtNumPed.Enabled := True;
              fLock_Unlock(strTrava, False, False);
              exit;
            End;
            *)

            {*****************************************}
            {* CHAMA A TELA DE PEDIDO DE COMPRAS     *}
            {**************************************AF*}
            If (Not blnNovoReg) Or (Not blnUsarGiro) Or objCopiaSeg.recPcmger.blnRecuperaPedido Then
            Begin
              if rdgOpcoes.ItemIndex = 0 Then // Pedido
              Begin
                If Not fVerificaAcessoSistema('ALTPED', strLoginUsuarioLogado) Then
                Begin

                  If (Not (ffrmSenha(strSenha) And fVerificaAcessoSistema('ALTPED', fRetCodVendedor(strSenha)))) Then
                  Begin
                    fMensagem('', 'Usuario sem permissão de acesso!', ['&O k']);
                    edtNumPed.Enabled := True;
                    objLock.fLock_Unlock(strTrava, False, False);
                    exit;

                  End;

                End;
              End Else Begin // ORCAMENTO
                If Not fVerificaAcessoSistema('TALORC', strLoginUsuarioLogado) Then
                Begin

                  If (Not (ffrmSenha(strSenha) And fVerificaAcessoSistema('TALORC', fRetCodVendedor(strSenha)))) Then
                  Begin
                    fMensagem('', 'Usuario sem permissão de acesso!', ['&O k']);
                    edtNumPed.Enabled := True;
                    objLock.fLock_Unlock(strTrava, False, False);
                    exit;

                  End;

                End;
              End;


              If (strDocOri <> 'TE') And (Pos(strDocOri, 'NF_EL_') <= 0) Then  //ATENÇÃO NA HORA DE COLOCAR O EL AQUI TEM QUE SER <= E NÃO >
              Begin

                (**************************************************************)
                (* SE FOR MULTI LOJA JA VAI CALCULAR O GIRO                   *)
                (***********************************************************LA*)
                If objCopiaSeg.recPcmger.blnRecuperaPedido Or
                  (Not fEhPedidoCompraMultiLoja(edtNumPed.Text, strEspDoc, strCodEmp)) Then
                Begin

                  If Not objCopiaSeg.recPcmger.blnRecuperaPedido Then
                    recOpcoesGiro.strPedMlj := 'N';

                  If fEmptyStr(objCopiaSeg.recPcmger.strNumPed) And objCopiaSeg.recPcmger.blnRecuperaPedido Then
                    recOpcoesGiro.strValKey := objCopiaSeg.recPcmger.strAutInc
                  Else
                    recOpcoesGiro.strValKey := qryPcmGer.FieldByName('AUTOINCREM').AsString;

                  pSetaNumeroPedido;

                  fChamaCalculoGiro(recOpcoesGiro, True, False);

                  If Assigned(recOpcoesGiro.objSalInt) And recOpcoesGiro.objSalInt.blnEncontrouGiro And
                     fEmptyStr(objCopiaSeg.recPcmger.strNumPed) Then
                  Begin
                    blnAltPedGir := True;

                    If Not (fEmptyStr(objCopiaSeg.recPcmger.strNumPed) And objCopiaSeg.recPcmger.blnRecuperaPedido) Then
                    Begin
                      recOpcoesGiro.strNumPedUmaLoja := qryPcmGer.FieldByName('PCG_NUMPED').AsString;
                      recOpcoesGiro.strCodEmpUmaLoja := qryPcmGer.FieldByName('PCG_CODEMP').AsString;
                    End;

                    Result := fCalculoGiro(False);

                    If (Result) Then
                      Exit;
                  End

                  Else
                  Begin
                    If (Not (objCopiaSeg.recPcmger.blnRecuperaPedido And fEhPedidoCompraMultiLoja(edtNumPed.Text, strEspDoc, strCodEmp))) Then
                      recOpcoesGiro.strEmpGir := '';

                        pChamaTelaPedido;
                  End;

                End
                Else
                  pChamaTelaPedido;

              End
              Else
              Begin
                fMensagem('', 'Não é permitido alterar pedido de compra provenientes de transferências!', ['&O k']);
                edtNumPed.Enabled := True;
                objLock.fLock_Unlock(strTrava, False, False);
                exit;
              End;
            End;
          End    // Fim Alterar

          Else If Not objImpressaoPedido.fPodeImprimirPedido(edtNumPed.Text, strEspDoc, strCodEmp, True) Then
          Begin
            edtNumPed.Enabled := True;
            exit;
          End
          Else
          Begin
            objImpressaoPedido.pCarregaDadosPedido(edtNumPed.Text, strEspDoc, strCodEmp, '');

            If objImpressaoPedido.fPedeDadosImpressao Then

              objImpressaoPedido.pImprime;

            edtNumPed.Clear;
            edtNumPed.Enabled := True;

            objLock.fLock_Unlock(strTrava, False, False);
          End;
        End
        Else
        Begin

          {*****************************************}
          {* CHAMA A TELA DE PEDIDO DE COMPRAS     *}
          {**************************************MV*}
          If (Not blnNovoReg) Or (Not blnUsarGiro) Then
            pChamaTelaPedido;

        End;

      End;
      Result := False;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If (fEmptyStr(edtCodEmpresa.Text)) Then
        edtDesEmpresa.Text := 'TODAS'
      Else
      Begin
        pCarregaEmpresa;
        If (fEmptyStr(edtDesEmpresa.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
          Result := False;
        End

        Else If Not fEmpresaAtiva(edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa inativa no Cadastro de Empresas!', ['&Ok']);
          Result := False;
        End
      End;
    End;

  End;

  If Not Result Then
  Begin
    If (Sender.Enabled) And (Sender.Visible) Then
      pSetFocus(Sender);
  End;

end;

function TfrmMenuPedCom.fCarregaPedCom: Boolean;
begin

  Result := True;
  With qryPcmGer Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  * ');
    SQL.Add('FROM ');
    SQL.Add('  PCMDET ');
    SQL.Add('WHERE ');
    SQL.Add('  PCD_NUMPED = :NUMPED AND ');
    SQL.Add('  PCD_ESPDOC = :ESPDOC AND ');
    SQL.Add('  PCD_CODEMP = :CODEMP AND ');
    SQL.Add('  PCD_QTDBAI > 0           ');

    ParamByName('NUMPED').AsString := edtNumPed.Text;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    blnBaixaParcial := Not IsEmpty;
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  * ');
    SQL.Add('FROM ');
    SQL.Add('  PCMGER ');
    SQL.Add('WHERE ');
    SQL.Add('  PCG_NUMPED = :NUMPED AND ');
    SQL.Add('  PCG_ESPDOC = :ESPDOC AND ');
    SQL.Add('  PCG_CODEMP = :CODEMP ');

    ParamByName('NUMPED').AsString := edtNumPed.Text;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If IsEmpty Then
      Result := False;
  End;

end;

procedure TfrmMenuPedCom.pEscapePressed;
begin
  If (edtNumPed.Focused) Then
  Begin
    //pSetFocus(rdgOpcoes);
    SelectNext(edtNumPed, False, True);
  End
  Else
  Begin
    inherited;
  End;
end;

procedure TfrmMenuPedCom.edtNumPedKeyPress(Sender: TObject; var Key: Char);
  Var
    qryConGen : TUniQuery;
    arrSel : TConsultasArray;
    objfrmPnl: TPanelCxPedCompra;
begin
  inherited;

  qryConGen := fCriaQuery;

  Try
    strCodEmp := edtCodEmpresa.Text;

    objfrmPnl := TPanelCxPedCompra.Create(TfrmPnlDadosPedCompra);

    objfrmPnl.prcLista := objImpressaoPedido.pImprimePedido;
    objfrmPnl.FOnBeforeListaSelecaoAdd := objImpressaoPedido.pPodeAdicionarPedido;
    objfrmPnl.FSetFornecedorUnicoExportacao := objImpressaoPedido.pSetFornecedorUnicoExportacao;

    If fPesqPedidoCompra(Self, edtNumPed,
    qryConGen, Key, arrSel, strEspDoc, strCodEmp,
    rdgOpcoes.ItemIndex, False,
    objfrmPnl, STR_LITRO_GALAO) Then
    Begin
      If Length(arrSel) > 1 Then
      Begin
        fMensagem('','Selecione apenas um ' + IIF(rdgOpcoes.ItemIndex = 0, 'pedido', 'orçamento') + ' para alterar!', ['&OK']);
        edtNumPed.Clear;
        Exit;
      End;

      edtCodEmpresa.Text          := qryConGen.FieldByName('PCG_CODEMP').AsString;

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtCodEmpresa.Text := VS_strCodEmp;
      End;

      strCodEmp := edtCodEmpresa.Text;
      edtDesEmpresa.Text := fRetNomeEmpresa(strCodEmp);
    End;

    FreeAndNil(objfrmPnl);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmMenuPedCom.edtNumPedKeyPress]');
    End;
  End;
  FreeAndNil(qryConGen);
end;

Procedure TfrmMenuPedCom.pSetaNumeroPedido;
Begin
  recOpcoesGiro.strNumPedAlt := edtNumPed.Text;
  recOpcoesGiro.strEspPedAlt := strEspDoc;
  recOpcoesGiro.strEmpPedAlt := strCodEmp;
End;

function TfrmMenuPedCom.fCalculoGiro(blnPededadosGiro: Boolean = True): Boolean;
  Var
    objRecuperaAux: TRecuperaPedido;
begin
  pSetaNumeroPedido;

  Result := (Not blnPededadosGiro) Or fChamaCalculoGiro(recOpcoesGiro, False);

  If Result Then
  Begin
    pnlNomeForm.Width := 86;
    pnlInfo.Width     := 197;
    rdgOpcoes.Enabled := False;
    btnHeranca.Enabled := False;
    btnCarrTxtFornecedor.Enabled := False;
    pnlInfo.Caption   := 'Aguarde, calculando giro de estoque...';//

    cdsItensGiro       := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);
    cdsItensPedido     := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);
    cdsItensMultiLojas := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);

    If Result Then
    Begin
      If blnNovoReg Then
        objRecuperaAux := Nil
      Else
        objRecuperaAux := objCopiaSeg;

      {*****************************************}
      {* CALCULA O GIRO DE ESTOQUE             *}
      {**************************************MV*}
      With recOpcoesGiro Do
        Result := fCalculaGiroEstoque(recOpcoesGiro, opcChamada, dtaDataBaseGir, cdsItensGiro, cdsItensMultiLojas, strCodGru, strCodFor,
          strCodMar, strPrdGru, strGruCmp, strSitPro, strUnidade, strCodDep, intDiaVen, strAcoObj, strRefere, strDesIte, strLocIni, strLocFin,
          intOpcGir, strFilGir, intMesGir, intMesMos, blnAnalisaITEFOR,
          blnMedAju, blnAllIte, blnArredSug, blnConsMCom, blnEmbala, blnConsTLoj, blnConsEMin, blnConsEMax,
          blnConsRequisicao, blnConsPedPen, blnConsPedPenTransferencia, blnDesconsPedGar, blnConsPedVen, blnDescSalExt, blnConsMesAtu, blnConsOrdPro, blnConsGarPen, blnConsTransf,
          blnConsCot, blnVenPer, blnVenPerMed, blnConsEndere,  blnPonPed, blnAteMax, blnAgrSim,
          blnEntFutPrevisao,
          blnEntFutFalta,
          blnEntFutAguarda,
          intDiaPedVen, intOrdem, strPedMlj, '', '', '', strCodEmp, strEmpUsadaGiro, strEmpSubtraiPedTransf, arrCodFor, arrLinhaGrupo, arrMarca, arrPrdGru, arrGruCmp, arrSitPro, arrUnidade, arrCodDep,
          strEmpAgr, blnSugInd, cdsEmpSel, recNivEst, slfLocFis, strCodTab, slsSaldos, slsSaldosDestino, strCodCmp, strCodDig, strMeses, '',
          strNumPedUmaLoja, strCodEmpUmaLoja, objRecuperaAux,
          {blnGeraAuto} False,
          {strGirEmp} '',
          {blnEncontrouGiro} False,
          strNumPedAlt,
          strEmpPedAlt,
          strEspPedAlt);

      If blnNovoReg Then
        pCopiaClientDataSet(cdsItensGiro, cdsItensPedido);

      If Result Then
      Begin
        pChamaTelaPedido;
      End Else
      Begin
        blnUsarGiro := False;
        edtNumPed.Clear;
        edtNumPed.Enabled := True;
      End;
    End;

    recOpcoesGiro.cdsEmpSel := Null;
    rdgOpcoes.Enabled := True;
    btnHeranca.Enabled := True;
    btnCarrTxtFornecedor.Enabled := True;
    pSetFocus(rdgOpcoes);

  End
  Else
  Begin
    edtNumPed.Enabled := True;
    blnUsarGiro := False;
  End;

  SetLength(recOpcoesGiro.arrLinhaGrupo, 0);
  recOpcoesGiro.blnEmbala := False;

  pnlInfo.Caption   := '';
end;


procedure TfrmMenuPedCom.pSetaValoresDefault(Var recOpcoesGiro: TRecOpcoesGiro);
Begin
  With recOpcoesGiro, recNivEst Do
  Begin
    strNumPedUmaLoja := '';
    strCodEmpUmaLoja := '';

    opcChamada       := chaPedido;

    blnMedAju        := False;

    dtaDataBaseGir := VS_Date;
    intMesMos    := fCfgSis('MESMOS', VarInteger);
    intMesGir    := 03;
    strMeses     := fMontaStrMeses(intMesMos);

    blnImpReq    := False;
    blnLimReq    := False;
    blnInfMes    := False;

    blnCarregItensGrid := True;
    nivEstoque   := nivNenhum;
    strNiveis    := '';
    intDiaComGer := 30;
    intDiaComNvA := 30;
    intDiaComNvB := 30;
    intDiaComNvC := 30;
    strCodGru    := '';
    strCodFor    := '';
    blnAnalisaITEFOR := False;
    strCodMar    := '';
    strRefere    := '';
    blnAllIte    := True;

    blnEntFutPrevisao := True;
    blnEntFutAguarda  := True;
    blnEntFutFalta    := True;

    intOpcGir    := GIR_03MESES;

    strFilGir    := 'T';
    strCodCmp    := '';
    strEmpGir    := '';
    blnArredSug  := False;
    blnConsMCom  := False;
    blnEmbala    := False;
    blnConsTLoj  := False;
    intOrdem     := 1;
    blnConsEMin  := False;
    blnConsEMax  := False;
    blnConsPedPen:= False;
    blnConsRequisicao :=  False;
    blnConsOrdPro:= False;
    blnConsGarPen:= False;
    blnConsMesAtu:= False;
    intDiaPedVen := -1;

    strEmpAgr    := '';
    blnSugInd    := False;
    slfLocFis    := slfTodas;
    slsSaldos    := slsTodos;

    blnSpoTra    := False;

    SetLength(arrLinhaGrupo,0);
    SetLength(arrMarca,0);
    SetLength(arrCodFor ,0);

    strValKey := '';
    strNomFrm := '';
    objSalInt := Nil;
    strCodTab := '';
  End;
End;

procedure TfrmMenuPedCom.pChamaTelaPedido;
begin
  Try
    pnlInfo.Caption   := '';
    pnlNomeForm.Width := 138;
    pnlInfo.Width     := 149;

    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    If btnHeranca.Tag = 1 Then
      strCodEmp := edtCodEmpresa.Text ;

    fCarregaPedCom;

    If (Not blnNovoReg) And
       fEhPedidoCompraMultiLoja(edtNumPed.Text, strEspDoc, strCodEmp) Then
    Begin
      If Not objCopiaSeg.recPcmger.blnRecuperaPedido Then
        pSetaValoresDefault(recOpcoesGiro);

      recOpcoesGiro.strPedMlj := 'S';

      // CONFIGURAÇÕES ANTIGAS
      recOpcoesGiro.intMesGir      := qryPcmGer.FieldByName('PCG_MESGIR').AsInteger;
      If recOpcoesGiro.intMesGir = 0 Then
        recOpcoesGiro.intMesGir := 3;

      recOpcoesGiro.blnConsMesAtu  := qryPcmGer.FieldByName('PCG_MESATU').AsString = 'S';
      recOpcoesGiro.strValKey      := qryPcmGer.FieldByName('AUTOINCREM').AsString;

      pSetaNumeroPedido;

      // VAI CARREGAR ABAIXO
      If Not objCopiaSeg.recPcmger.blnRecuperaPedido Then
        fChamaCalculoGiro(recOpcoesGiro, True, False);
    End;

    If (Not Assigned(cdsItensPedido)) Then
      cdsItensPedido := fCriaDatasetPedido(IIF(recOpcoesGiro.intMesMos = 0, 12, recOpcoesGiro.intMesMos), arrCampos, arrCamposAgg);

    If (Not Assigned(cdsItensMultiLojas)) Then
      cdsItensMultiLojas := fCriaDatasetPedido(IIF(recOpcoesGiro.intMesMos = 0, 12, recOpcoesGiro.intMesMos), arrCampos, arrCamposAgg);

    {*****************************************}
    {* CASO ESTEJA ALTERANDO UM PEDIDO E SEJA*}
    {* CONFIGURADO PARA PED. MULTI LOJAS,    *}
    {* CARREGA OS PEDIDOS MULTILOJAS JÁ CAL- *}
    {* CULANDO O GIRO. SE NÃO FOR MULTI LOJAS*}
    {* CARREGA DE UM SELECT NORMAL.          *}
    {**************************************MV*}
    If (Not blnNovoReg) Or (objCopiaSeg.recPcmger.blnRecuperaPedido And (objCopiaSeg.recPcmger.strPedMlj = 'S')) Then
    Begin

      If (objCopiaSeg.recPcmger.blnRecuperaPedido And (objCopiaSeg.recPcmger.strPedMlj = 'S')) Or
         fEhPedidoCompraMultiLoja(edtNumPed.Text, strEspDoc, strCodEmp) Then
      Begin

        If (objCopiaSeg.recPcmger.blnRecuperaPedido And (objCopiaSeg.recPcmger.strPedMlj = 'S')) Then
          recOpcoesGiro.strCodCmp := ''
        Else
        Begin
          recOpcoesGiro.strCodCmp := qryPcmGer.FieldByName('PCG_CODCMP').AsString;
          recOpcoesGiro.strCodCmp := qryPcmGer.FieldByName('PCG_CODDIG').AsString;
        End;

        If (recOpcoesGiro.dtaDataBaseGir = 0) Or (Not Assigned(recOpcoesGiro.objSalInt)) Or (Not recOpcoesGiro.objSalInt.blnEncontrouGiro) Then
          recOpcoesGiro.dtaDataBaseGir := VS_Date;

        If Assigned(recOpcoesGiro.objSalInt) And recOpcoesGiro.objSalInt.blnEncontrouGiro And (recOpcoesGiro.cdsEmpSel <> Null) Then
          cdsEmpMlj.Data := recOpcoesGiro.cdsEmpSel;

        If Assigned(recOpcoesGiro.objSalInt) And (Not recOpcoesGiro.objSalInt.blnEncontrouGiro) Then
        Begin
          recOpcoesGiro.blnConsPedVen := True;
          recOpcoesGiro.blnDescSalExt := True;
          recOpcoesGiro.blnConsGarPen := True;
          recOpcoesGiro.blnConsOrdPro := True;
        End;

        pSetaNumeroPedido;

        If (Not Assigned(cdsItensGiro)) Then
          cdsItensGiro := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);

        If (objCopiaSeg.recPcmger.blnRecuperaPedido And (objCopiaSeg.recPcmger.strPedMlj = 'S')) Then
        Begin
          If Not fCarregaPedidoDeCompraMultiLojas(recOpcoesGiro,
                                                  cdsItensGiro,
                                                  cdsItensMultiLojas,
                                                  edtNumPed.Text,
                                                  strEspDoc,
                                                  strCodEmp,
                                                  strEmpUsadaGiro,
                                                  cdsEmpMlj.Data) Then
            Exit

         End Else
         Begin

          If Not fCarregaPedidoDeCompraMultiLojas(recOpcoesGiro,
                                                  cdsItensPedido,
                                                  cdsItensMultiLojas,
                                                  edtNumPed.Text,
                                                  strEspDoc,
                                                  strCodEmp,
                                                  strEmpUsadaGiro,
                                                  cdsEmpMlj.Data) Then
            Exit

         End;

      End
      Else
      Begin

      End;
    End;

    Try
      pCriarFormularios(TfrmPedidoDeCompra, frmPedidoDeCompra);

      frmPedidoDeCompra.objCopiaSeg        := objCopiaSeg;

      frmPedidoDeCompra.recOpcGir          := recOpcoesGiro;
      frmPedidoDeCompra.blnNovoReg         := blnNovoReg;
      frmPedidoDeCompra.blnModoHeranca     := (btnHeranca.Tag = 1);
      frmPedidoDeCompra.strNumPed          := edtNumPed.Text;
      frmPedidoDeCompra.strEspDoc          := strEspDoc;
      frmPedidoDeCompra.blnUsarGiro        := blnUsarGiro;
      frmPedidoDeCompra.chkCnvEmb.Checked  := recOpcoesGiro.blnEmbala;
      frmPedidoDeCompra.stlArquivos        := lstArquivos;
      if blnHRDPDL Then
        frmPedidoDeCompra.strCodEmp          := VS_strCodEmp
      Else
        frmPedidoDeCompra.strCodEmp          := strCodEmp;
      frmPedidoDeCompra.strEmpUsadaGiro    := strEmpUsadaGiro;
      frmPedidoDeCompra.blnAltPedGir       := blnAltPedGir;
      frmPedidoDeCompra.cdsItensPedido     := cdsItensPedido;
      frmPedidoDeCompra.cdsItensGiroExt    := cdsItensGiro;
      frmPedidoDeCompra.cdsItensMultiLojas := cdsItensMultiLojas;
      frmPedidoDeCompra.qryGiro            := qryGiro;
      frmPedidoDeCompra.qryPcmGer          := qryPcmGer;
      frmPedidoDeCompra.strCodCta          := qryPcmGer.FieldByName('PCG_CODCTA').AsString;
      frmPedidoDeCompra.blnAnalisaITEFOR   := recOpcoesGiro.blnAnalisaITEFOR;

      frmPedidoDeCompra.showModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmMenuPedCom.pChamaTelaPedido]');
      End;
    End;
    pFreeAndNil(frmPedidoDeCompra);

    objCopiaSeg.pLimpaDados;

  Finally

    objLock.fLock_Unlock(strTrava, False, False);

    pDestravarTodosLocksConexaoAtual;

    If Assigned(cdsItensGiro) Then
    Begin
      pLiberaAggs(cdsItensGiro);
      FreeAndNil(cdsItensGiro);
    End;

    If Assigned(cdsItensPedido) Then
    Begin
      pLiberaAggs(cdsItensPedido);
      FreeAndNil(cdsItensPedido);
    End;

    If Assigned(cdsItensMultiLojas) Then
    Begin
      pLiberaAggs(cdsItensMultiLojas);
      FreeAndNil(cdsItensMultiLojas);
    End;

    If Assigned(lstArquivos) Then
      lstArquivos.Clear;

    edtNumPed.Clear;

    edtNumPed.Enabled := True;
    blnUsarGiro := False;

    pSetaValoresDefault(recOpcoesGiro);

    recOpcoesGiro.strPedMlj := fCfgSis('PEDMLJ');
    strEmpUsadaGiro := '';

    If (btnHeranca.Tag = 1) Then
    Begin
      btnHeranca.Caption := AnsiReplaceStr(btnHeranca.Caption, 'ATIVO', 'INATIVO');
      btnHeranca.Tag := 0;
    End;
  End;

  SetForegroundWindow(Self.Handle);
end;

procedure TfrmMenuPedCom.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F3) Then
  Begin
    btnHeranca.Click;
  End
  Else If (Key = VK_F5) Then
  Begin
    btnCarrTxtFornecedor.Click;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      Close;
    End;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      If edtCodEmpresa.Enabled Then
        pSetFocus(edtCodEmpresa)
      Else
        pSetFocus(edtNumPed);
    End;
  End;

end;

procedure TfrmMenuPedCom.btnHerancaClick(Sender: TObject);
  Var
    strSenha: String;
begin
  inherited;

  If (Not rdgOpcoes.Enabled) Then
    Exit;

  If (btnHeranca.Tag = 0) Then
  Begin
    If
      (edtCodEmpresa.Text <> VS_strCodEmp)
      And fCfgSis('HRDPDL', varBoolean)
      And fVerificaAcessoSistema('HRDPDL', strLoginUsuarioLogado) Then
    Begin
      blnHRDPDL := fMensagem('',
            'O pedido de compra está sendo herdado da empresa ' + edtCodEmpresa.Text + '.'+ #13 +
            'Criá-lo na empresa logada ' + VS_strCodEmp + ' ou na empresa de origem ' + edtCodEmpresa.Text + '?',
            ['Criar na empresa &logada ' + VS_strCodEmp, 'Criar na empresa &origem ' + edtCodEmpresa.Text],
            1,
            False,
            1,
            230,
            False,
            0,
            False,
            False,
            True,
            0,
            500
            ) = 1;
    End;

    If ffrmSenha(strSenha) And
       fVerificaAcessoSistema('HERPDC', fRetCodVendedor(strSenha)) Then
    Begin
      btnHeranca.Caption := AnsiReplaceStr(btnHeranca.Caption, 'INATIVO', 'ATIVO');
      btnHeranca.Tag := 1;
    End;

  End
  Else
  Begin
    btnHeranca.Caption := AnsiReplaceStr(btnHeranca.Caption, 'ATIVO', 'INATIVO');
    btnHeranca.Tag := 0;
  End;

  If edtCodEmpresa.Enabled Then
    pSetFocus(edtCodEmpresa)
  Else
  Begin
    If (edtNumPed.Enabled) Then
      pSetFocus(edtNumPed);
  End;

end;

procedure TfrmMenuPedCom.OnIdle(Sender: TObject; var Done: Boolean);
begin

  If (rdgOpcoes.ItemIndex = 0) Then
  Begin
    lblPedOrc.Caption := 'Pedido para alterar:';
  End
  Else
  Begin
    lblPedOrc.Caption := 'Orçamento para alterar:';
  End;

end;

procedure TfrmMenuPedCom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(objLock);
  Application.OnIdle := Nil;
  FreeAndNil(qryPcmGer);
  inherited;
end;

function TfrmMenuPedCom.fVerificaNotaFiscal: Boolean;
var
  vQryPedEle: TUniQuery;
begin
  try
    vQryPedEle := fCriaQuery(Self);

    vQryPedEle.Sql.Text :=  ' SELECT *                                            ' +
                            '   FROM PEDELE P                                     ' +
                            '  INNER JOIN GERELE G ON G.AUTOINCREM = P.PEL_SEQELE ' +
                            '  WHERE IFNULL(G.GER_DOCENT, "") = ""                ' +
                            '   AND P.PEL_NUMDOC = :NUMDOC                        ' +
                            '   AND P.PEL_CODEMP = :CODEMP                        ' +
                            '   AND P.PEL_ESPDOC = :ESPDOC                        ';
    vQryPedEle.ParamByName('NUMDOC').AsString := edtNumPed.Text;
    vQryPedEle.ParamByName('CODEMP').AsString := strCodEmp;
    vQryPedEle.ParamByName('ESPDOC').AsString := strEspDoc;
    vQryPedEle.Open;

    Result := vQryPedEle.IsEmpty;
  finally
    FreeAndNil(vQryPedEle);
  end;
end;

function TfrmMenuPedCom.fVerificaNotImpEmitida(strNumPed, strEspDoc,
  strCodEmp: String): Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;

begin
  Try

    qryGenGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCG_JAEMIT = 1 ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := Fields[0].AsInteger > 0;
      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure TfrmMenuPedCom.btnCarrTxtFornecedorClick(Sender: TObject);
begin
  inherited;

  If (Not btnCarrTxtFornecedor.Enabled) Then
    Exit;

  rdgOpcoes.ItemIndex := 0;
  edtNumPed.Clear;

  Try
    pCriarFormularios(TfrmEntImportaPedFornc, frmEntImportaPedFornc);
    If (frmEntImportaPedFornc.ShowModal = mrOk) Then
    Begin
      lstArquivos := frmEntImportaPedFornc.stlArquivos;
    End
    Else
      If (Assigned(lstArquivos)) Then
        FreeAndNil(lstArquivos);
  Except
    On E: Exception Do
    Begin
      lstArquivos := Nil;
      pMensagensErro(E.Message, '[frmMenuPedCom.btnCarrTxtFornecedorClick]');
    End;
  End;
  pFreeAndNil(frmEntImportaPedFornc);

  If (Assigned(lstArquivos)) Then
  Begin
    blnNovoReg := True;
    pChamaTelaPedido;
  End;

  If edtCodEmpresa.Enabled Then
    pSetFocus(edtCodEmpresa)
  Else
  Begin
    If (edtNumPed.Enabled) Then
      pSetFocus(edtNumPed);
  End;

end;

procedure TfrmMenuPedCom.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresasAtivas(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmMenuPedCom.pCarregaEmpresa;
Begin
  If Not (fEmptyStr(edtCodEmpresa.Text)) Then
    edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text)
  Else
    edtDesEmpresa.Text := '';
End;

procedure TfrmMenuPedCom.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  strCodEmp := edtCodEmpresa.Text;
end;

function TfrmMenuPedCom.fComparaEmpresa: Boolean;
begin

  Result := True;

  If (VS_strCodEmp <> edtCodEmpresa.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Empresa do Pedido deverá ser a mesma do Sistema!', ['&O k']);
    edtNumPed.Enabled := True;
    Result := False;
  End;

end;

function TfrmMenuPedCom.fLiberouAlterarPedido: Boolean;
var
  objLiberacao : ILiberacao;
begin
  objLiberacao := TLiberacaoFactory.fGetLiberacao;
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(113);
  objLiberacao.objMsgLibera.pAddTexto('Pedido de Compra com Pré-nota já vinculada.');

  objLiberacao.objMsgLibera.pAddTextoCaption('Operador Logado' , strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado)            , 23);
  objLiberacao.objMsgLibera.pAddSeparador(113);
  objLiberacao.objMsgLibera.pAddTexto('Empresa: ' +  strCodEmp);
  objLiberacao.objMsgLibera.pAddSeparador(113);
  objLiberacao.objMsgLibera.pAddTexto('Pedido de compra: ' +  edtNumPed.Text);
  objLiberacao.objMsgLibera.pAddSeparador(113);
  objLiberacao.objMsgLibera.pAddTexto('Nota Fiscal de Entrada: ' +  fNumeroNotaFiscal);
  objLiberacao.objMsgLibera.pAddSeparador(113);

  objLiberacao.strDirAce := 'PRENOT';
  objLiberacao.strMsgSen := 'Pedido de Compra com Pré-nota já vinculada.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
end;

function TfrmMenuPedCom.fNumeroNotaFiscal: String;
var
  vQryPedEle: TUniQuery;
begin
  try
    vQryPedEle := fCriaQuery(Self);

    vQryPedEle.Sql.Text :=  ' SELECT G.B08_NNF                                    ' +
                            '   FROM PEDELE P                                     ' +
                            '  INNER JOIN GERELE G ON G.AUTOINCREM = P.PEL_SEQELE ' +
                            '  WHERE IFNULL(G.GER_DOCENT, "") = ""                ' +
                            '   AND P.PEL_NUMDOC = :NUMDOC                        ' +
                            '   AND P.PEL_CODEMP = :CODEMP                        ' +
                            '   AND P.PEL_ESPDOC = :ESPDOC                        ';
    vQryPedEle.ParamByName('NUMDOC').AsString := edtNumPed.Text;
    vQryPedEle.ParamByName('CODEMP').AsString := strCodEmp;
    vQryPedEle.ParamByName('ESPDOC').AsString := strEspDoc;
    vQryPedEle.Open;

    Result := vQryPedEle.FieldByName('B08_NNF').AsString;
  finally
    FreeAndNil(vQryPedEle);
  end;
end;

end.

