unit untFatDadosNotaComp;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, untFuncFat,
  ExtCtrls, EditFocus, Mask, MaskEditFocus, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, StrUtils;

type
  TfrmFatDadosNotaComp = class(TfrmPaiSimples)
    Label1: TLabel;
    edtObse01: TEditFocus;
    edtObse02: TEditFocus;
    edtObse03: TEditFocus;
    edtObse04: TEditFocus;
    edtObse05: TEditFocus;
    edtObse06: TEditFocus;
    edtObse07: TEditFocus;
    edtObse08: TEditFocus;
    edtObse09: TEditFocus;
    edtObse10: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    mskDtaEnt: TMaskEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundo: TPanel;
    pnlNfe: TPanel;
    rdbComplemento: TRadioButton;
    rdbCredito: TRadioButton;
    rdbComIpi: TRadioButton;
    rdbTransfCredICMS: TRadioButton;
    rdbTransfDevICMS: TRadioButton;
    Label14: TLabel;
    Label15: TLabel;
    lbl1: TLabel;
    lblIteCom: TLabel;
    edtChaveAcesso: TEditFocus;
    edtEspDoc: TEditFocus;
    edtNumDoc: TEditFocus;
    edtSerie: TEditFocus;
    chkExibirDocOutros: TCheckBox;
    Shape1: TShape;
    rdbCompValor: TRadioButton;
    rdbRestIcmsStEstoque: TRadioButton;
    rdbEstornoDeCredito: TRadioButton;
    rdbComplementoDifalFcp: TRadioButton;
    rdbComplementoStPerfilCnc: TRadioButton;
    rdbNFAjusteICMSaMaior: TRadioButton;
    rdbComplementoFrete: TRadioButton;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumDocEnter(Sender: TObject);
    procedure lblIteComClick(Sender: TObject);
    procedure edtNumDocExit(Sender: TObject);
    procedure rdbComplementoClick(Sender: TObject);
    procedure rdbComplementoDifalFcpClick(Sender: TObject);
    function fEhPerfilCncUTIE48: Boolean;
    procedure pCarregarItens;
    procedure pCarregaDadosItem(qryItens: TUniQuery; strCodIte: String);
    function fRetornaTipoDeFrete(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
    function fCalcularComplementoStPerfilCNC: Boolean;
  private
    { Private declarations }
    strNotaCarregada: String;
    blnNotaDeImportacao: Boolean;
    procedure pCarregaDoc;
    procedure pZeraCamposFatVenda(blnModoForce: Boolean=False);
    procedure pHabilitaRadios;
    function fInformouDataRetroativaNaNotaFiscalDeComplemento(strChaveAcesso: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnSatComplementar: Boolean;
    blnNFCeComplementar: Boolean;
    fatVenda   : TFatVenda;
  end;


implementation

uses untfuncoesSimples, untConsultas, untTypesSistema, untFatDadosNotaCompItens,
  untDigDescComplemento, untNotCom, untFatDadosNotaCompItensValor, Shared.Functions.Types,
  untFatInfDataHora, untFuncFatTypes, untFuncoes;

{$R *.dfm}

procedure TfrmFatDadosNotaComp.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pZeraCamposFatVenda;
  Close;
end;

procedure TfrmFatDadosNotaComp.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    If Self.rdbCompValor.Checked Then
    Begin
      If fatVenda.objNfeComplemento.TotalItens.fltValorCom <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário complementar pelo menos um item', ['&O k']);
        lblIteComClick(Sender);
        Exit;
      End;
    End;

    If (rdbNFAjusteICMSaMaior.Checked) Then
    Begin
      If fEmptyStr(edtChaveAcesso.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um documento com chave de acesso.', ['&Ok']);
        Exit;
      End;
    End;

    If (rdbComplementoFrete.Checked) Then
    Begin
      If fEmptyStr(edtChaveAcesso.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um documento com chave de acesso.', ['&Ok']);
        Exit;
      End;
    End;

    If (rdbComplementoStPerfilCnc.Checked) Then
    Begin
      If fEmptyStr(edtChaveAcesso.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um documento com chave de acesso.', ['&Ok']);
        Exit;
      End;

      If not fCalcularComplementoStPerfilCNC Then
      Begin
        fMensagem('ATENÇÃO!', 'Os valores de complemento ficaram zerados.'+#13+
                              'Verifique as regras de cálculo e tente novamente.', ['&Ok']);
        Exit;
      End;
    End;

    If blnNotaDeImportacao And (Not fatVenda.objNfeComplemento.blnTemItens) Then
    Begin
      fMensagem('ATENÇÃO!', 'Nota Fiscal com CFOP de Importação.'+#13+
                            'É necessário complementar pelo menos um item', ['&Ok']);
      lblIteComClick(Sender);
      Exit;
    End;

    If (fEmptyStr(Self.edtChaveAcesso.Text)) Or
       (fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso <> Self.edtChaveAcesso.Text) Then
    Begin
      fatVenda.objNfeComplemento.pRemoverItens;

      If (fEmptyStr(Self.edtChaveAcesso.Text)) Then
        fatVenda.objNfeComplemento.pRemoverNotaReferenciada;
    End;

    pZeraCamposFatVenda;

    fatVenda.blnVendaPresencial := fatVenda.objNfeComplemento.fGetVenPreNFRef(fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso);
    fatVenda.strMenNc01 := Self.edtObse01.Text;
    fatVenda.strMenNc02 := Self.edtObse02.Text;
    fatVenda.strMenNc03 := Self.edtObse03.Text;
    fatVenda.strMenNc04 := Self.edtObse04.Text;
    fatVenda.strMenNc05 := Self.edtObse05.Text;
    fatVenda.strMenNc06 := Self.edtObse06.Text;
    fatVenda.strMenNc07 := Self.edtObse07.Text;
    fatVenda.strMenNc08 := Self.edtObse08.Text;
    fatVenda.strMenNc09 := Self.edtObse09.Text;
    fatVenda.strMenNc10 := Self.edtObse10.Text;
    fatVenda.dtaDtaEnt  := StrToDate(Self.mskDtaEnt.Text);

    If (not fEmptyStr(fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso)) And
       (Self.rdbComIpi.Checked Or Self.rdbComplemento.Checked Or Self.rdbComplementoDifalFcp.Checked) Then
    Begin
      fatVenda.objNfeComplemento.notaReferenciada.strClaFis := fatVenda.objNfeComplemento.fGetClaFisNFRef(fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso);
    End;

    Try
      blnConfirma := True;

      Try
        pCriarFormularios(TfrmDigDescComplemento, frmDigDescComplemento);

        If Self.rdbComplemento.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'COMPLEMENTO DE ICMS';
          fatVenda.objNfeComplemento.tncTipoNota := tncComplementoICMS;
        End
        Else If Self.rdbCredito.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'CRÉDITO DE ICMS';
          fatVenda.objNfeComplemento.tncTipoNota := tncCreditoICMS;
        End
        Else If Self.rdbComIpi.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'COMPLEMENTO DE IPI';
          fatVenda.objNfeComplemento.tncTipoNota := tncComplementoIPI;
        End
        Else If Self.rdbTransfCredICMS.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'TRANSFERÊNCIA DE SALDO CREDOR DE ICMS';
          fatVenda.objNfeComplemento.tncTipoNota := tncTransferenciaCredorICMS;
        End
        Else If Self.rdbTransfDevICMS.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'TRANSFERÊNCIA DE SALDO DEVEDOR DE ICMS';
          fatVenda.objNfeComplemento.tncTipoNota := tncTransferenciaDevedorICMS;
        End
        Else If Self.rdbCompValor.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'COMPLEMENTO DE VALOR';
          fatVenda.objNfeComplemento.tncTipoNota := tncComplementoValor;
        End
        Else If Self.rdbRestIcmsStEstoque.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'RESTITUIÇÃO DE ICMS ST/ESTOQUE';
          fatVenda.objNfeComplemento.tncTipoNota := tncRestIcmsStEstoque;
        End
        Else If Self.rdbEstornoDeCredito.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'ESTORNO DE CRÉDITO';
          fatVenda.objNfeComplemento.tncTipoNota := tncEstornoDeCredito;
        End
        Else If Self.rdbComplementoDifalFcp.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'COMPLEMENTO DE DIFAL';
          fatVenda.objNfeComplemento.tncTipoNota := tncComplementoDifalFcp ;
        End
        Else If Self.rdbComplementoStPerfilCnc.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'COMPLEMENTO ST - PERFIL CNC';
          fatVenda.objNfeComplemento.tncTipoNota := tncComplementoStPerfilCnc ;
        End
        Else If Self.rdbNFAjusteICMSaMaior.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'CORREÇÃO DE DESTAQUE DE ICMS';
          fatVenda.objNfeComplemento.tncTipoNota := tncNFAjusteICMSaMaior ;
        End
        Else If Self.rdbComplementoFrete.Checked Then
        Begin
          frmDigDescComplemento.edtDesIte.Text   := 'COMPLEMENTO DE FRETE';
          fatVenda.objNfeComplemento.tncTipoNota := tncComplementoFrete ;
        End;

        frmDigDescComplemento.showModal;

        blnConfirma := frmDigDescComplemento.blnConfirma;

        If (blnConfirma) Then
        Begin
          blnConfirma := fInformouDataRetroativaNaNotaFiscalDeComplemento(fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso);
        End;

        fatVenda.objNfeComplemento.strDescricao := frmDigDescComplemento.strDesIte;
      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message, '[pConfirma]');
        End;
      End;
    Finally
      pFreeAndNil(frmDigDescComplemento);

      If blnConfirma Then
        Close;
    End;
  End;
end;

procedure TfrmFatDadosNotaComp.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma         := False;
  blnSatComplementar  := False;
  blnNFCeComplementar := False;
  blnNotaDeImportacao := False;
  mskDtaEnt.Text      := DateToStr(VS_Date);
  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
  strNotaCarregada    := '';
end;

function TfrmFatDadosNotaComp.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaEnt) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de entrada deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

{    Else If (Sender = edtVlrCon) Then
    Begin

      If fEmptyStr(edtVlrCon.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor total deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtVlrCon.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor total deve ser maior que Zero!', ['&O k']);
        Result := False;
      End;

    End}

{    Else If (Sender = edtAlqIcm) Then
    Begin

      If fEmptyStr(edtAlqIcm.Text) Then
        edtAlqIcm.Text := '0,00';

      If (fStrToFloat(edtAlqIcm.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A alíquota de ICMS deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End}

    Else If (pnlNfe.Visible) Then
    Begin
      If ((rdbComplemento.Checked) Or (rdbComIpi.Checked) Or (rdbComplementoDifalFcp.Checked)) Then
      Begin
        If (Sender = edtNumDoc) Or (Sender = edtSerie) Or (Sender = edtEspDoc) Then
        Begin

          If fEmptyStr(edtNumDoc.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'A nota de referência deve ser preenchida!', ['OK']);
            Result := False;
          End
          Else If fEmptyStr(edtEspDoc.Text) Then
          Begin
          fMensagem('ATENÇÃO', 'A espécie de referência deve ser preenchida!', ['OK']);
          Result := False;
        End
        Else If Pos(edtEspDoc.Text, 'NF_NV_EL_IF_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'A espécie de referência deve ser IF, NF ou EL!', ['OK']);
          Result := False;
        End
        Else If fEmptyStr(edtSerie.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'A série de referência deve ser preenchida!', ['OK']);
            Result := False;
          End
          Else If (edtNumDoc.Text <> '') And (edtSerie.Text <> '') And (edtEspDoc.Text <> '') Then
          Begin
            pCarregaDoc;
            If (fEmptyStr(edtNumDoc.Text)) Or (fEmptyStr(edtSerie.Text)) Or (fEmptyStr(edtEspDoc.Text)) Then
            Begin
              Result := fMensagem('ATENÇÃO', 'NF não encontrada!', ['OK']) = -1;
            End;
          End;
        End;
      End
      Else If ((rdbTransfCredICMS.Checked) Or (rdbTransfDevICMS.Checked)) Then
      Begin
        If fatVenda.strCliEst <> fCadEmp('ESTADO') Then
        Begin
          fMensagem('ATENÇÃO', 'Este tipo de operação não é permitido para clientes fora do estado.', ['&OK']);
          Result := False;
        End;
      End;

      If (Result) And ((Sender = edtNumDoc) Or (Sender = edtSerie) Or (Sender = edtEspDoc)) And
         (Pos(edtEspDoc.Text, 'NF_NV_EL_') > 0) And (Not fEmptyStr(edtNumDoc.Text)) And (fEmptyStr(edtChaveAcesso.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'Ao referenciar uma nota fiscal para fins de complemento, sua chave de acesso também deve ser referenciada!'+#10#13+
                             'Provavelmente essa nota ainda não foi autorizada no painel!'+#10#13+
                             'Verique seu status e certifique-se de sua autorização, antes de emitir seu complemento!', ['OK']);
        Result := False;
      End;

    End;

  End;
end;

procedure TfrmFatDadosNotaComp.lblIteComClick(Sender: TObject);
  Var
    frmFatDadosNotaCompItens : TfrmFatDadosNotaCompItens;
begin
  inherited;
  If (Not lblIteCom.Enabled) Then
  Begin
    fatVenda.objNfeComplemento.pRemoverItens;
    Exit;
  End;

  If (Length(fatVenda.objNfeComplemento.arrItensNFe) = 0) Or
     (fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso <> Self.edtChaveAcesso.Text) Or
     (strNotaCarregada <> Self.edtChaveAcesso.Text) Then
  Begin
    fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso := Self.edtChaveAcesso.Text;
    fatVenda.objNfeComplemento.notaReferenciada.strNumDoc      := Self.edtNumDoc.Text;
    fatVenda.objNfeComplemento.notaReferenciada.strSerie       := Self.edtSerie.Text;
    fatVenda.objNfeComplemento.notaReferenciada.strEspDoc      := Self.edtEspDoc.Text;

    If (fatVenda.blnNCForCli) And (rdbCompValor.Checked) Then
      fatVenda.objNfeComplemento.tncTipoNota := tncComplementoValor;

    fatVenda.objNfeComplemento.pCarregarItens;
    strNotaCarregada := fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso;

    fatVenda.objNfeComplemento.notaReferenciada.strClaFis := fatVenda.objNfeComplemento.fGetClaFisNFRef(strNotaCarregada);
  End;

  {*********************************************}
  {* NOTA DE COMPLEMENTO CLIENTE OU FORNECEDOR *}
  {**REQ.76061******************************TS**}
  If (fatVenda.blnNCForCli) And (rdbCompValor.Checked) Then
  Begin
    Try
      Try
        pCriarFormularios(TfrmFatDadosNotaCompItensValor, frmFatDadosNotaCompItensValor);
        frmFatDadosNotaCompItensValor.fatVenda := Self.fatVenda;
        frmFatDadosNotaCompItensValor.ShowModal;
        If (Not fatVenda.objNfeComplemento.blnEhNCPorProdutoAndValCarregada) Then
        Begin
          pZeraCamposFatVenda(True);
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
    Finally
      pFreeAndNil(frmFatDadosNotaCompItensValor);
    End;
  End
  Else
  Begin
    Try
      Try
        pCriarFormularios(TfrmFatDadosNotaCompItens, frmFatDadosNotaCompItens);
        frmFatDadosNotaCompItens.fatVenda := Self.fatVenda;
        frmFatDadosNotaCompItens.blnComplementoDifalFcp := rdbComplementoDifalFcp.Checked;
        frmFatDadosNotaCompItens.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
    Finally
      pFreeAndNil(frmFatDadosNotaCompItens);
    End;
  End;

  pHabilitaRadios;
end;

procedure TfrmFatDadosNotaComp.FormShow(Sender: TObject);
begin
  inherited;

  blnConfirma    := False;
  pnlNfe.Visible := fCfgSis('NFEUSA', varBoolean);

  chkExibirDocOutros.Checked := fatVenda.objNfeComplemento.blnDocumentoOutros;

  Self.edtObse01.Text := fatVenda.strMenNc01;
  Self.edtObse02.Text := fatVenda.strMenNc02;
  Self.edtObse03.Text := fatVenda.strMenNc03;
  Self.edtObse04.Text := fatVenda.strMenNc04;
  Self.edtObse05.Text := fatVenda.strMenNc05;
  Self.edtObse06.Text := fatVenda.strMenNc06;
  Self.edtObse07.Text := fatVenda.strMenNc07;
  Self.edtObse08.Text := fatVenda.strMenNc08;
  Self.edtObse09.Text := fatVenda.strMenNc09;
  Self.edtObse10.Text := fatVenda.strMenNc10;

  If fatVenda.dtaDtaEnt = 0 Then
    Self.mskDtaEnt.Text := DateToStr(VS_Date)
  Else
    Self.mskDtaEnt.Text := DateToStr(fatVenda.dtaDtaEnt);

  Self.edtChaveAcesso.Text := fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso;
  Self.edtNumDoc.Text      := fatVenda.objNfeComplemento.notaReferenciada.strNumDoc;
  Self.edtEspDoc.Text      := fatVenda.objNfeComplemento.notaReferenciada.strEspDoc;
  Self.edtSerie.Text       := fatVenda.objNfeComplemento.notaReferenciada.strSerie;

  Case fatVenda.objNfeComplemento.tncTipoNota Of
    tncCreditoICMS             : Self.rdbCredito.Checked                := True;
    tncComplementoIPI          : Self.rdbComIpi.Checked                 := True;
    tncComplementoICMS         : Self.rdbComplemento.Checked            := True;
    tncTransferenciaCredorICMS : Self.rdbTransfCredICMS.Checked         := True;
    tncTransferenciaDevedorICMS: Self.rdbTransfDevICMS.Checked          := True;
    tncComplementoValor        : Self.rdbCompValor.Checked              := True;
    tncRestIcmsStEstoque       : Self.rdbRestIcmsStEstoque.Checked      := True;
    tncEstornoDeCredito        : Self.rdbEstornoDeCredito.Checked       := True;
    tncComplementoDifalFcp     : Self.rdbComplementoDifalFcp.Checked    := True;
    tncComplementoStPerfilCnc  : Self.rdbComplementoStPerfilCnc.Checked := True;
    tncNFAjusteICMSaMaior      : Self.rdbNFAjusteICMSaMaior.Checked     := True;
    tncComplementoFrete        : Self.rdbComplementoFrete.Checked       := True;
  End;

  If (Not fatVenda.blnNCForCli) Then
    Self.rdbCompValor.Enabled := False;

  If fEmptyStr(fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso) Then
    Self.rdbComplemento.Checked := True;

  fatVenda.objNfeComplemento.strCodFaz := fatVenda.objFazenda.strCodFaz;

  If Not fatVenda.blnNCCliente Then
    Self.rdbRestIcmsStEstoque.Visible := False;

  rdbComplementoStPerfilCnc.Visible := fEhPerfilCncUTIE48;

  rdbNFAjusteICMSaMaior.Visible := (not fatVenda.fDocumentoParaFornecedor);

  pHabilitaRadios;

  pCarregaDoc;
end;

procedure TfrmFatDadosNotaComp.edtNumDocEnter(Sender: TObject);
var
  key : Char;
begin
  inherited;

  key := '?';
  If (rdbComplemento.Checked Or rdbComIpi.Checked Or rdbCompValor.Checked Or rdbTransfCredICMS.Checked Or rdbNFAjusteICMSaMaior.Checked Or rdbComplementoFrete.Checked) And
     (pnlNfe.Visible) Then
  Begin
    edtNumDocKeyPress(edtNumDoc,key);
  End;
end;

procedure TfrmFatDadosNotaComp.edtNumDocExit(Sender: TObject);
begin
  inherited;
  pCarregaDoc;
end;

function TfrmFatDadosNotaComp.fRetornaTipoDeFrete(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): String;
var
  qryAux: TUniQuery;
  strSQL: String;
begin
  qryAux := fCriaQuery;
  Try
    strSQL := 'SELECT GER_TIPFRE FROM MOVGER '+
              'WHERE GER_NUMDOC = :NUMDOC '+
              '  AND GER_ESPDOC = :ESPDOC '+
              '  AND GER_CODEMP = :CODEMP '+
              '  AND GER_CODCLI = :CODCLI ';

    qryAux.SQL.Text := strSQL;
    qryAux.SQL.Add('UNION ALL');
    qryAux.SQL.Add(AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER'));
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    Result := qryAux.FieldByName('GER_TIPFRE').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmFatDadosNotaComp.edtNumDocKeyPress(Sender: TObject; var Key: Char);
var
  strForCliPesq : String;
  strTip_FCPesq : String;
  qryGen        : TUniQuery;
  arrSel        : TConsultasArray;
begin
  strForCliPesq := '';
  strTip_FCPesq := '';

  If Not chkExibirDocOutros.Checked Then
  Begin
    strForCliPesq := fatVenda.strCodCli;
    strTip_FCPesq := IIF(fatVenda.fDocumentoParaFornecedor, 'F', 'C');
  End;

  Try
    qryGen :=  fCriaQuery(Self);

    If fPesqLivroFiscal(Self, qryGen, Key, arrSel, True, IIF(blnNFCeComplementar, conNFCeComplementar, conNotaComplemento),
                        strTip_FCPesq, strForCliPesq,
                        fatVenda.objFazenda.strCodFaz, '', False, 0, 0, True, '', False, True) Then
    Begin
      fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso := qryGen.FieldByName('FIS_ACESSO').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strNumDoc      := qryGen.FieldByName('FIS_NUMDOC').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strEspDoc      := qryGen.FieldByName('FIS_ESPDOC').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strCodEmp      := qryGen.FieldByName('FIS_CODEMP').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strSerie       := qryGen.FieldByName('FIS_SERIE_').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strTip_FC      := qryGen.FieldByName('FIS_TIP_FC').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strForCli      := qryGen.FieldByName('FIS_FORCLI').AsString;
      fatVenda.objNfeComplemento.strTipFre                       := fRetornaTipoDeFrete(qryGen.FieldByName('FIS_NUMDOC').AsString,
                                                                                        qryGen.FieldByName('FIS_ESPDOC').AsString,
                                                                                        qryGen.FieldByName('FIS_CODEMP').AsString,
                                                                                        qryGen.FieldByName('FIS_FORCLI').AsString);

      edtNumDoc.Text      := qryGen.FieldByName('FIS_NUMDOC').AsString;
      edtChaveAcesso.Text := qryGen.FieldByName('FIS_ACESSO').AsString;
      edtSerie.Text       := qryGen.FieldByName('FIS_SERIE_').AsString;
      edtEspDoc.Text      := qryGen.FieldByName('FIS_ESPDOC').AsString;

      SelectNext(ActiveControl, True, True);
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;


function TfrmFatDadosNotaComp.fInformouDataRetroativaNaNotaFiscalDeComplemento(
  strChaveAcesso: String): Boolean;
var
  frmFatInfDataHora: TfrmFatInfDataHora;
begin
  Result := True;

  if (fatVenda.strOpcDoc <> 'NC') then
    Exit;

  if (fCfgSis('DRNFCC', varInteger) < 1) Then
    Exit;

  pCriarFormularios(TfrmFatInfDataHora, frmFatInfDataHora);

  try
    frmFatInfDataHora.Label1.Visible := False;
    frmFatInfDataHora.mskHorSai.Visible := False;
    frmFatInfDataHora.blnEhComplementoNF := True;
    frmFatInfDataHora.dtaDtaDocReferenciado := fCampoTabela('FIS_DTADOC', 'CADFIS', ['FIS_ACESSO'], [strChaveAcesso], False);

    if (frmFatInfDataHora.ShowModal = mrOk) then
    begin
      fatVenda.dtaDtaEnt := frmFatInfDataHora.dtaDataSaida;
      fatVenda.blnEhDataRetroativaComplementoNF := True;
    end
    else
    begin
      Result := False;
    end;
  finally
    pFreeAndNil(frmFatInfDataHora);
  end;
end;

procedure TfrmFatDadosNotaComp.pCarregaDoc;
  Var
    qryGen: TUniQuery;
begin

  edtNumdoc.Enabled := True;
  edtSerie.Enabled  := True;
  edtEspDoc.Enabled := True;

  If rdbRestIcmsStEstoque.Checked Or rdbEstornoDeCredito.Checked Then
  Begin
    edtNumDoc.Clear;
    edtSerie.Clear;
    edtEspDoc.Clear;
    edtChaveAcesso.Clear;

    edtNumdoc.Enabled := False;
    edtSerie.Enabled  := False;
    edtEspDoc.Enabled := False;
  End;

  chkExibirDocOutros.Enabled := rdbCredito.Checked;

  If Not chkExibirDocOutros.Enabled Then
    chkExibirDocOutros.Checked := False;

  If rdbTransfCredICMS.Checked Then
    chkExibirDocOutros.Checked := True;

  lblIteCom.Enabled := False;

  If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtSerie.Text)) Then
  Begin
    Try
      qryGen := fCriaQuery(Self);
      qryGen.SQL.Clear;
      qryGen.SQL.Add(' SELECT DISTINCT ');
      qryGen.SQL.Add('   FIS_FORCLI, ');
      qryGen.SQL.Add('   FIS_TIP_FC, ');
      qryGen.SQL.Add('   FIS_CODEMP, ');
      qryGen.SQL.Add('   FIS_NUMDOC, ');
      qryGen.SQL.Add('   FIS_ESPDOC, ');
      qryGen.SQL.Add('   FIS_SERIE_, ');
      qryGen.SQL.Add('   FIS_DTADOC, ');
      qryGen.SQL.Add('   FIS_ACESSO, ');
      qryGen.SQL.Add('   FIS_ENTSAI, ');
      qryGen.SQL.Add('   FIS_CLFSC1, ');
      qryGen.SQL.Add('   AUTOINCREM ');
      qryGen.SQL.Add(' FROM CADFIS ');
      qryGen.SQL.Add(' WHERE TRUE ');
      qryGen.SQL.Add('     AND FIS_ESPDOC = :ESPDOC ');
      qryGen.SQL.Add('     AND ((FIS_ORIDOC = "V") OR ((IFNULL(FIS_ORIDOC,"") = "") AND (LEFT(FIS_CLFSC1,1) = 3))) ');

      If Not chkExibirDocOutros.Checked Then
      Begin
        If fatVenda.fDocumentoParaFornecedor Then
          qryGen.SQL.Add('     AND FIS_TIP_FC = "F" ')
        Else
          qryGen.SQL.Add('     AND FIS_TIP_FC = "C" ');

        qryGen.SQL.Add('     AND FIS_FORCLI = ' + QuotedStr(fatVenda.strCodCli));
      End;

      qryGen.SQL.Add('     AND FIS_CODEMP = ' + AnsiQuotedStr(VS_strCodEmp, '"'));
      qryGen.SQL.Add('     AND FIS_NUMDOC = :NUMDOC ');
      qryGen.SQL.Add('     AND IFNULL(FIS_SERIE_, "") = :SERIE ');

      qryGen.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      qryGen.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      qryGen.ParamByName('SERIE').AsString  := edtSerie.Text;
      qryGen.Open;

      fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso := qryGen.FieldByName('FIS_ACESSO').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strNumDoc      := qryGen.FieldByName('FIS_NUMDOC').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strEspDoc      := qryGen.FieldByName('FIS_ESPDOC').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strCodEmp      := qryGen.FieldByName('FIS_CODEMP').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strSerie       := qryGen.FieldByName('FIS_SERIE_').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strTip_FC      := qryGen.FieldByName('FIS_TIP_FC').AsString;
      fatVenda.objNfeComplemento.notaReferenciada.strForCli      := qryGen.FieldByName('FIS_FORCLI').AsString;

      edtChaveAcesso.Text := qryGen.FieldByName('FIS_ACESSO').AsString;

      blnNotaDeImportacao := (LeftStr(qryGen.FieldByName('FIS_CLFSC1').AsString, 1) = '3');

      If Not fEmptyStr(edtChaveAcesso.Text) Then
        lblIteCom.Enabled := rdbComplemento.Checked Or rdbComIpi.Checked Or rdbCompValor.Checked Or rdbComplementoDifalFcp.Checked;

      If Not lblIteCom.Enabled Then
      Begin
        fatVenda.objNfeComplemento.pRemoverItens;
      End;

    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure TfrmFatDadosNotaComp.pHabilitaRadios;
begin
  If (blnSatComplementar Or blnNFCeComplementar) Then
  Begin
    lblIteCom.Visible              := False;
    rdbCredito.Visible             := False;
    rdbComIpi.Visible              := False;
    rdbTransfCredICMS.Visible      := False;
    rdbTransfDevICMS.Visible       := False;
    rdbCompValor.Visible           := False;
    rdbRestIcmsStEstoque.Visible   := False;
    rdbEstornoDeCredito.Visible    := False;
    rdbNFAjusteICMSaMaior.Visible  := False;
    rdbComplementoDifalFcp.Visible := False;
    rdbComplemento.Visible         := True;
    rdbComplemento.Checked         := True;
  End
  Else If (fatVenda.objNfeComplemento.blnEhNCPorProdutoAndValCarregada Or fatVenda.objNfeComplemento.blnEhNCPorProdutoAndICMCarregada) Then
  Begin
    If rdbCredito.Visible           Then rdbCredito.Enabled           := False;
    If rdbComIpi.Visible            Then rdbComIpi.Enabled            := False;
    If rdbComplemento.Visible       Then rdbComplemento.Enabled       := False;
    If rdbTransfCredICMS.Visible    Then rdbTransfCredICMS.Enabled    := False;
    If rdbTransfDevICMS.Visible     Then rdbTransfDevICMS.Enabled     := False;
    If rdbCompValor.Visible         Then rdbCompValor.Enabled         := False;
    If rdbRestIcmsStEstoque.Visible Then rdbRestIcmsStEstoque.Enabled := False;
    If rdbEstornoDeCredito.Visible  Then rdbEstornoDeCredito.Enabled := False;

    If fatVenda.objNfeComplemento.blnEhNCPorProdutoAndValCarregada Then
      rdbCompValor.Enabled := True
    Else If fatVenda.objNfeComplemento.blnEhNCPorProdutoAndICMCarregada Then
      rdbComplemento.Enabled := True
  End;
end;

procedure TfrmFatDadosNotaComp.pZeraCamposFatVenda(blnModoForce: Boolean=False);
begin
  If (rdbCompValor.Checked) Or (blnModoForce) Then
  Begin
    SetLength(fatVenda.arrMatItens, 0);
    cdsVenda.EmptyDataSet;
    fatVenda.pCalculaTotGer;
    fatVenda.fltTotGer := 0;
    fatVenda.fltTotIpi := 0;
    fatVenda.fltTotRet := 0;
  End;
end;

procedure TfrmFatDadosNotaComp.rdbComplementoClick(Sender: TObject);
begin
  inherited;
  {*************************************}
  {* Necessário para exibir ou não o   *}
  {* Label para complementar por itens *}
  {**********************************JC*}
  pCarregaDoc;
end;

procedure TfrmFatDadosNotaComp.rdbComplementoDifalFcpClick(Sender: TObject);
begin
  inherited;
  edtObse01.Text := fatVenda.strMenNc01 + ' REF.DIF.CALCULO DIFAL/FCP';
  rdbComplementoClick(Sender);
end;

function TfrmFatDadosNotaComp.fEhPerfilCncUTIE48: Boolean;
Begin
  Result := False;

  If Not fatVenda.blnNCCliente Then
    Exit;

  If not fatVenda.fFaturamentoDentroDoEstado Then
    Exit;

  If not (fRegimeSubstituicaoTributaria('', fatVenda.fOpcDocClaSub) = '1') Then
    Exit;

  If not fCfgSis('UTIE48', varBoolean) Then
    Exit;

  If not (Pos('CNC', fGetTipoAbfCliente(fatVenda.strCodCli)) > 0) Then
    Exit;

  Result := True;
End;

procedure TfrmFatDadosNotaComp.pCarregarItens;
Var
  itemNFe: TNfeComplementoItem;
  qryDadosItens: TUniQuery;
  forTin: TForTin;
  dadosMadeira: TDadosMadeira;
begin
  qryDadosItens := fCriaQuery(Nil);

  try
    FillChar(forTin, SizeOf(TForTin), #0);
    FillChar(dadosMadeira, SizeOf(TDadosMadeira), #0);

    SetLength(fatVenda.arrMatItens, 0);
    cdsVenda.EmptyDataSet;

    For itemNFe In fatVenda.objNfeComplemento.arrItensNFe Do
    Begin
      pCarregaDadosItem(qryDadosItens, itemNFe.strCodIte);

      fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
              Nil, 'NOR',
              qryDadosItens.FieldByName('ITE_CODGRU').AsString,
              itemNFe.strCodIte,
              qryDadosItens.FieldByName('ITE_DESITE').AsString,
              qryDadosItens.FieldByName('ITE_DESITE').AsString,
              '',
              qryDadosItens.FieldByName('ITE_CODUNI').AsString,
              qryDadosItens.FieldByName('ITE_CODUNI').AsString,
              qryDadosItens.FieldByName('ITE_CODMAR').AsString,
              qryDadosItens.FieldByName('ITE_CODFOR').AsString,
              itemNFe.strAutInc,
              itemNFe.fltValUni,
              itemNFe.fltValUni,
              itemNFe.fltValUni,
              itemNFe.fltValUni,
              0,
              itemNFe.fltQtdIte,
              itemNFe.fltTotIte,
              IIF(StrToIntDef(LeftStr(itemNFe.strClaFis, 1), 5) < 5, 'E', 'S'),
              itemNFe.fltTotIte,
              itemNFe.fltTotIte,
              'N',
              qryDadosItens.FieldByName('ITE_IPISAI').AsFloat,
              0,
              itemNFe.fltValUni,
              itemNFe.fltValUni,
              itemNFe.fltValUni,
              itemNFe.fltValUni,
              itemNFe.fltValUni,
              itemNFe.fltValUni,
              itemNFe.fltValUni,
              0,
              0,
              qryDadosItens.FieldByName('ITE_INCPIS').AsString,
              0,
              0,
              0,
              '',
              '',
              '',
              0,
              0,
              '',
              0,
              0,
              0,
              0,
              fRetornaNCM(qryDadosItens.FieldByName('ITE_CLAIPI').AsString,
                          fatVenda.strCliEst,
                          fatVenda.strCodCid,
                          itemNFe.strCodIte,
                          ''),
              '',
              '',
              '',
              '',
              0,
              '',
              0,
              0,
              0,
              0,
              0,
              '',
              '',
              0,
              0,
              qryDadosItens.FieldByName('ITE_CODABF').AsString,
              0,
              0,
              'N',
              0,
              0,
              0,
              0,
              '',
              0,
              '',
              0,
              0,
              '',
              '',
              '',
              0,
              0,
              0,
              '',
              '',
              0,
              0,
              '',
              '',
              '',
              0,
              '',
              '',
              '',
              0,
              0,
              0,
              '',
              '',
              'N',
              '',
              '',
              itemNFe.strSigUni,
              0,
              0,
              '',
              '',
              '',
              False,
              '',
              '',
              '',
              0,
              0,
              0,
              0,
              0,
              0,
              '',
              '',
              '',
              '1',
              0,
              0,
              '',
              0,
              '',
              0,
              '',
              '',
              'N',
              '',
              0,
              0,
              itemNFe.fltDesEsp,
              0,
              'N',
              '',
              itemNFe.fltValUni,
              itemNFe.fltValUni,
              0,
              0,
              0,
              0,
              0,
              0,
              forTin,
              '',
              '',
              '',
              '',
              '',
              False,
              '',
              '',
              0,
              '',
              '',
              '',
              0,
              0,
              0,
              '',
              0,
              False,
              '',
              '',
              '',
              0,
              0,
              '',
              '',
              dadosMadeira,
              0,
              0,
              0,
              '',
              0,
              '',
              '',
              0,
              0,
              '',
              '',
              0,
              '',
              'N',
              0,
              0,
              0,
              False,
              False,
              'N',
              '',
              0,
              0,
              '',
              'N',
              0,
              '',
              '',
              '',
              '',
              qryDadosItens.FieldByName('ITE_EXCIPI').AsString,
              0,
              '',
              itemNFe.strClaFis);

    End;

    fatvenda.blnNotaCompValor := True;
    fatVenda.pPreencheMatrizFechamento;
    fatvenda.blnNotaCompValor := False;

    fatvenda.pCalculaTotGer;

  Finally
    FreeAndNil(qryDadosItens);
  End;
end;

procedure TfrmFatDadosNotaComp.pCarregaDadosItem(qryItens: TUniQuery; strCodIte: String);
begin
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT ');
  qryItens.SQL.Add('  I.ITE_CODITE, ');
  qryItens.SQL.Add('  I.ITE_CODGRU, ');
  qryItens.SQL.Add('  I.ITE_DESITE, ');
  qryItens.SQL.Add('  I.ITE_CODUNI, ');
  qryItens.SQL.Add('  I.ITE_CODMAR, ');
  qryItens.SQL.Add('  I.ITE_CODFOR, ');
  qryItens.SQL.Add('  I.ITE_INCPIS, ');
  qryItens.SQL.Add('  I.ITE_CLAIPI, ');
  qryItens.SQL.Add('  I.ITE_EXCIPI, ');

  If fCfgSis('TIPABF', varString) = '1' Then
    qryItens.SQL.Add('  I.ITE_CODABF AS ITE_CODABF, ')
  Else
    qryItens.SQL.Add('  G.ITE_CODABF AS ITE_CODABF, ');

  qryItens.SQL.Add('  G.ITE_IPISAI ');
  qryItens.SQL.Add('FROM ');
  qryItens.SQL.Add('  CADITE I ');
  qryItens.SQL.Add('INNER JOIN ITEGER G ');
  qryItens.SQL.Add('  ON G.ITE_CODITE = I.ITE_CODITE ');
  qryItens.SQL.Add('WHERE ');
  qryItens.SQL.Add('  I.ITE_CODITE = :CODITE AND ');
  qryItens.SQL.Add('  G.ITE_CODEMP = :CODEMP ');

  qryItens.ParamByName('CODITE').AsString := strCodIte;
  qryItens.ParamByName('CODEMP').AsString := fatVenda.objNfeComplemento.notaReferenciada.strCodEmp;
  qryItens.Open;
end;

function TfrmFatDadosNotaComp.fCalcularComplementoStPerfilCNC: Boolean;
var
  item: TDadosFechamento;
  intContador: Integer;
  blnExisteValor: Boolean;
  tncTipoNotaOriginal: TTipoNotaComplemento;
begin
  blnExisteValor := False;

  tncTipoNotaOriginal := fatVenda.objNfeComplemento.tncTipoNota;

  Try
    fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso := Self.edtChaveAcesso.Text;
    fatVenda.objNfeComplemento.notaReferenciada.strNumDoc      := Self.edtNumDoc.Text;
    fatVenda.objNfeComplemento.notaReferenciada.strSerie       := Self.edtSerie.Text;
    fatVenda.objNfeComplemento.notaReferenciada.strEspDoc      := Self.edtEspDoc.Text;

    fatVenda.objNfeComplemento.tncTipoNota := tncComplementoStPerfilCnc;

    fatVenda.objNfeComplemento.pCarregarItens;
    strNotaCarregada := fatVenda.objNfeComplemento.notaReferenciada.strChaveAcesso;

    fatVenda.objNfeComplemento.notaReferenciada.strClaFis := fatVenda.objNfeComplemento.fGetClaFisNFRef(strNotaCarregada);

    pCarregarItens;

    For item In fatVenda.arrMatItens Do
    Begin
      If ((item.fltSICMEF + item.fltVSTANT) > 0) Then
      Begin
        blnExisteValor := True;

        For intContador := 0 To Length(fatVenda.objNfeComplemento.arrItensNFe) -1 Do
        Begin
          If item.strRefere = fatVenda.objNfeComplemento.arrItensNFe[intContador].strAutInc Then
          Begin
            fatVenda.objNfeComplemento.arrItensNFe[intContador].fltSICMEF := item.fltSICMEF;
            fatVenda.objNfeComplemento.arrItensNFe[intContador].fltBSTANT := item.fltBSTANT;
            fatVenda.objNfeComplemento.arrItensNFe[intContador].fltVSTANT := item.fltVSTANT;
          End;
        End;
      End;
    End;

  Finally
    Result := blnExisteValor;
    fatVenda.objNfeComplemento.tncTipoNota := tncTipoNotaOriginal;
  End;
End;

end.

